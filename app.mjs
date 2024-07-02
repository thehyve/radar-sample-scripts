import * as Minio from 'minio'

const minioClient = new Minio.Client({
    endPoint: '<api.s3.RADARBASE_INSTANCE_URL>',
    port: 443,
    useSSL: true,
    accessKey: '<AccessKey>',
    secretKey: '<SecretKey>',
})

// List of Buckets
try {
    const buckets = await minioClient.listBuckets()
    console.log('List of buckets', buckets)
} catch (err) {
    console.log(err.message)
}

// List of Objects
const data = []
const stream = minioClient.listObjects('radar-output-storage', '', false)
stream.on('data', function (obj) {
    data.push(obj)
})
stream.on('end', function (obj) {
    console.log(data)
})
stream.on('error', function (err) {
    console.log(err)
})

// List of Objects
const stream1 = minioClient.listObjectsV2('radar-output-storage', 'output/STAGING_PROJECT/0c15448d-f90e-4113-b567-8e6249df5cd0/', true, '')
stream1.on('data', function (obj) {
    console.log(obj)
})
stream1.on('error', function (err) {
    console.log(err)
})

// List of objects with metadata
const stream2 = minioClient.extensions.listObjectsV2WithMetadata('radar-output-storage', 'output/STAGING_PROJECT/0c15448d-f90e-4113-b567-8e6249df5cd0/', true, '')
stream2.on('data', function (obj) {
    console.log(obj)
})
stream2.on('error', function (err) {
    console.log(err)
})


minioClient.fGetObject('radar-output-storage', 'output/STAGING_PROJECT/0c15448d-f90e-4113-b567-8e6249df5cd0/questionnaire_timezone/20230404.csv.gz', './tmp/20230404.csv.gz', function (err) {
    if (err) {
        return console.log(err)
    }
    console.log('File has been written successfully')
}).then()


