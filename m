Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB0FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 22:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B6410E3AD;
	Thu,  9 Dec 2021 22:14:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7B010E3AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 22:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AggZ8MxuOZxf7mbKwOtslqjbVeT68tpcEB7A9kb9L5EfVPlfSXGfo3/t3DYzBveK7I2/2E0u4wf8oHWfNYCozv1lXj7vxh15D/NYOmx9rSTc9e2R5nybmm3Qw2G7ZoqgEf/A4+niuhQTndJdSD4Yw+1A3lJjchsdmSZD4lN5NZjv4NG0uyUrUtOBKVBCHNbUgy87SWqgVBbbt+quUi1i0Kpwdc6UGHG1imEMfggrK2F0G6HXK6LMKef1cOTUGb0tleuQSa33wPTsBoi+JzyS6Efd+ivBtkURVZxCqy/09e/awHCtYykXATsprhxLDI3bQqfDlU+Vs8BskGlqDMKDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWLqVuD7MP09pab43F9kDllFdbJ71S1s/Yspi3dKRqg=;
 b=LwSvAZBO66DSrfRbAhWIzv3QRxd7jCRKPC3GK3WIwn1ZvL3ic7kyPvh4arKZpX4Gr9GG8xmhE2DuSPWT0s1sQb2mKZwuXtzsoNbSNId7mYDHNgR/PUFtEhnGusXCyhkHzREdZIDy4XjCIfdWaCvlVkI7ELvqqYdQ/MhV/gV9DGG8TN9bw1iDa6t9+NVMy9tySisPCpGAaw6c7GcyswjIybj+8bZHPXFUg3fmhdgD8NF0SyrKfqQ6mENgi3nklBJhut2xhuwb0GIspDJN40VIyG4P9wuFvb0BoxLO+XY7pwYA9LnDxGsc/a4u3ZS9boSOqTIVsMW5SFpsa7NI6lAF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWLqVuD7MP09pab43F9kDllFdbJ71S1s/Yspi3dKRqg=;
 b=xnAh5yXqS9DizJt8ziZTCzUXh5bqUsDnsgsAAvH6wQyb6h0vxP3QI6TEcMnlQKGu/dBMlgUSkqlnPlg2A54YnSL0aMZ/CR+3FG3DrLJQXGvU6r5NJDsL07KSG0bR0Wq8vY5ZlYdaSjMU06mlG98AA+hzhSoLqSaVNtEV53rD2GE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Thu, 9 Dec 2021 22:14:24 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::c11e:f325:b7c4:de4b]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::c11e:f325:b7c4:de4b%7]) with mapi id 15.20.4755.021; Thu, 9 Dec 2021
 22:14:24 +0000
Message-ID: <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
Date: Thu, 9 Dec 2021 16:14:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
 <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
Received: from [172.31.132.189] (165.204.78.25) by
 MN2PR10CA0030.namprd10.prod.outlook.com (2603:10b6:208:120::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 22:14:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c11a5acd-6d43-4350-1174-08d9bb6141c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041D856A61E8A914A8EA267E3709@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7d/lvXCtQHcH3cfFRbHf+VUNtiGqDRclkNJGEdfl0SCzICc6joc+q3C8FfEzyuzncu5tampOb/nWkVic8iY6B8HKFZDnuS3xWMHC5AHXjvNTpX24gGJN8S+9XZlkQ9CsbRp9BoLPelMn2R9rXjEdAgVhMo64wHvGk6XSE30bhVPcy5mYghSFFOdrTHFXRcw21q2vT6FC1aQ8HaasQ/w8TYErNszEPDMOUKd/emQfvpuZnEnYfWEjKzGA/iai2QbL6FTHPhdxU4WxXVTEkW7TsjFJ7nQwJA0IpxgP6LvT6FvyZ+5zdcylXPmprMkZ9yTvP7lyVkAInYfoxPEbQXkkn5eHNJyRi0oDY67J7gvwWIn3R/wxjgKiHqh5LEkeRNyToZ0Ka7QJPcI+35nNqSEEOCJMGJBmTy83bFaiGocghPjzlFKtHbUU0QQdJHIz3BYZ4+oXxNe2dqK74U34EbmrRWkPh4l90SAKc0GJq4njQ+FcwuO3Ec5ha43pjQMsh8THBpFkz+CxMnyk4w7NZnT52DVmbDJ1NGzVufiT5/8poPUY5F1tbvsxPsBZu2kaFvt1Lf6gihdBybmnL7vfTuvzyfyYqyMW3jMAyGoIC2KosGOb9UegYyN7E1/px7dyk4PlG03jMjFV+vV/fYUgDYTVrixdxQxsevlXxss2RFzQAld9PzHz+DFEY3dMSqvONKgRRUPmQ+85SNJb2+psU8Qfb7mYWUaORtFV/WvnQTbZIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(16576012)(2616005)(4326008)(26005)(31686004)(66556008)(66476007)(8936002)(66946007)(38100700002)(8676002)(316002)(956004)(53546011)(508600001)(31696002)(6486002)(86362001)(36756003)(83380400001)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0EwdXVBVnNqajY2VGRYRVlqWG5MOHRDNnBRdG42Wlk5bE9Na29zY0l4alF5?=
 =?utf-8?B?L3hXR2NaQ3FqZHdYb0VRQ2dZdjJRMlJNQzhmeEJaYjZ6SU0yRWNVTlFlQ1FL?=
 =?utf-8?B?d2MyNUdQR0dwb3Z0aXczMk1QMTgzZXhPK1BtTHdhcDIzeGEvRUtOeG1YZTJ1?=
 =?utf-8?B?Nk1XamxuUitSbFhyL3IzdEZrYXdCSDJTbHFrWDdzZXp0aFQrWnNYUkxaWXZq?=
 =?utf-8?B?c0g5OHppdUdnNkxoRlM0VkF4ekd4eEFqMlJveFM5cEo5SlF2a2ZTTDBmUGYy?=
 =?utf-8?B?cmQxYlJsOVBhRGl2QWpVZTgzQVdjd2hnTTY2ZXJHcHpEUlBwclpKN1pQTnZN?=
 =?utf-8?B?eERTLzVXbFFQOEkxR3BVeDBWZUt6UDRTcXZyOWFpQkhRbk9wTGduY3BodHh6?=
 =?utf-8?B?c2ZBbXptaWU4V1poMFQ5R1MyMzBUY0x3bVJTMm1RdVVFYUhYb2NBd2RrWkpw?=
 =?utf-8?B?bWxJWFRkTEVldGF3SVR3UmVFajB5aXpUK1BWVDMyU0JZSkh3SmZPYy8welE1?=
 =?utf-8?B?eFhUVUlqUkQrVlZLK1ZNckRJMnNBR1pSRU1nc2NMR3RnWUlrNTNPQlZleUs3?=
 =?utf-8?B?bTVyQ3pSZThHTGZlT1RxNVJsRVRueURlRExHRHJCeUIvNmo0OU5rNHpFSXVJ?=
 =?utf-8?B?OXVaSjJyQUZmbk40RFEyR1ljTTQzaHpoeURkUUorWjBiSm8wTjFmak1xSnBx?=
 =?utf-8?B?Ty81YVJ3U1o3alVUeDZLVWpOdTZQZkJtWEVoMlBEcWtlTm5GSXhqRm9tM1hF?=
 =?utf-8?B?cDRWVzRTMUxTZ0tNbXQ1WHRYZ3BQR3ZXMGZYNEkrYnh1YlJpekpjMllscmtz?=
 =?utf-8?B?Y2xkeURtc0RSRUU3YWUzV1JnQUlhd3Y3dVgzWS92b215cUtDNFRrZmpFdTk1?=
 =?utf-8?B?cU1jZlFSaHZoeFhZa2JDdk5Ib25QeU5UNis0YVR1RXFlbVN4Y3A0aUVlU0h2?=
 =?utf-8?B?RWd0QXpjYUdjS1pXZW1iTDhhR21zM1piS0lMdWR1d05CNjFuMFlwZk0yN2dU?=
 =?utf-8?B?Z3liVGZqODNSNjlDeUcrYXFhNTJrS1MwOVR1eWk0VGZDaXBJajNlQitUZFNJ?=
 =?utf-8?B?RlI2SC9IekVrQ3VSUHBUWElMdzVxQjE1RjE3UEliNmtZY0twL09BVUE1ZjN4?=
 =?utf-8?B?THcveWlOVjROT2pNS25rS0FNbjFncEloaTBLN1h6Q1lzcnQ0WUJxTkRXZGhl?=
 =?utf-8?B?Vkh4bGgzMGdQZGtNelVoMm9CVlZlcEJTODBSa1dhaHRkb1RFUlhMNGhqMHND?=
 =?utf-8?B?NVZzM2xzQU0vb01sRVdReUViRjhaWVh1TkV4Uk5SQXdjTVZtUUxFR3h3dk1B?=
 =?utf-8?B?ZnFWcGJPdW5zYnd4SEh1LzFCSU45c0RJZ0szaU1GZkg4bDFlVm5jdCtwZnFp?=
 =?utf-8?B?Z3NkZnM4QWxQUUlaRTVXa0pZaVpzclhxTG9kODdic21PV05hRzhDa041a1Aw?=
 =?utf-8?B?ZXZyY1g0VHA1OUY1b2YwWnBrb20yZFpwYW1oQk5rM1FoNmc2SDlRQnVDYkZO?=
 =?utf-8?B?d2FIRGRZTUdGZEVLYlVqOUdaOERBRjQzZXQ4eTk0djJueW45UGpqWkZ4encx?=
 =?utf-8?B?UVFtUkxNNGlSbjN5eDNZS0RxKzNTdzdYTmE5VVhiS3JDQ0tzN0JmYVgweFlD?=
 =?utf-8?B?Y0ZvZFhoMG1wV0pML01Ub1ArS2UvdlE3ZGdFQ3NqMUF0T3NEY3J1bnRuN3pp?=
 =?utf-8?B?WkFLNDRQaFNsc0NTSzRaVlZJNmhsYlJnTXRRbjl0dUtDemJwWm80Qlk0ZnVJ?=
 =?utf-8?B?U3ZUMzRmU2xlWCtsTm5wSVdYQUtTZjNma2o5WklmajVIQ2sxMVc1eUN6Mlcv?=
 =?utf-8?B?WjgvYU0wa2hPUEtFbjd6OFpZTTlGZE4zaHhEREhkRXJwWURhSVFHRlhUTkI4?=
 =?utf-8?B?eG5hTENOc0poaXpjUUJGd0Z4aHVyeGQ0Y2ttSHdKVzd0Rzc4YWxwMHI1dmN4?=
 =?utf-8?B?TzRMS3NPY2NHaHB1QkpGOHFPK1J2SExoVCtIQjBuTTkzWUZnNG4xbWFSc01p?=
 =?utf-8?B?M3BSdjlOdGd2ekg0SXUvNXFHeTBDbWJ2T3poK29sVDdiZGo4UFpLSUhUdXBZ?=
 =?utf-8?B?em9GMHArTWh1MW1QQ29kUkxhS0ZvTG9iRVRjZk9GMWlJT2lKUElRK3R6cnJC?=
 =?utf-8?Q?+G8c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11a5acd-6d43-4350-1174-08d9bb6141c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:14:24.0438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8ukAwf2Y5ySdBF6Y/F01csPsDpiOqpe0l0X6yYedydNVgIUxpZemon6VmVBv9QV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 12/9/2021 12:40 PM, Felix Kuehling wrote:
> Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When application is about finish it destroys queues it has created by
>> an ioctl. Driver deletes queue entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
>> which is directory including this queue all attributes. Low level kernel
>> code deletes all attributes under this directory. The lock from kernel is
>> on queue entry, not its attributes. At meantime another user space application
>> can read the attributes. There is possibility that the application can
>> hold/read the attributes while kernel is deleting the queue entry, cause
>> the application have invalid memory access, then killed by kernel.
>>
>> Driver changes: explicitly create/destroy each attribute for each queue,
>> let kernel put lock on each attribute too.
> Is this working around a bug in kobject_del? Shouldn't that code take
> care of the necessary locking itself?
>
> Regards,
>    Felix

The patches do not change kobject/kernfs that are too low level and would involve deeper discussions.
Made changes at higher level(kfd) instead.

Have tested with MSF tool overnight.

Thanks
Xiaogang

>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33 +++++++-----------------
>>   2 files changed, 13 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 0c3f911e3bf4..045da300749e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -546,6 +546,9 @@ struct queue {
>>   
>>   	/* procfs */
>>   	struct kobject kobj;
>> +	struct attribute attr_guid;
>> +	struct attribute attr_size;
>> +	struct attribute attr_type;
>>   };
>>   
>>   enum KFD_MQD_TYPE {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 9158f9754a24..04a5638f9196 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -73,6 +73,8 @@ static void evict_process_worker(struct work_struct *work);
>>   static void restore_process_worker(struct work_struct *work);
>>   
>>   static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
>> +static void kfd_sysfs_create_file(struct kobject *kobj, struct attribute *attr,
>> +				char *name);
>>   
>>   struct kfd_procfs_tree {
>>   	struct kobject *kobj;
>> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
>>   	return 0;
>>   }
>>   
>> -static struct attribute attr_queue_size = {
>> -	.name = "size",
>> -	.mode = KFD_SYSFS_FILE_MODE
>> -};
>> -
>> -static struct attribute attr_queue_type = {
>> -	.name = "type",
>> -	.mode = KFD_SYSFS_FILE_MODE
>> -};
>> -
>> -static struct attribute attr_queue_gpuid = {
>> -	.name = "gpuid",
>> -	.mode = KFD_SYSFS_FILE_MODE
>> -};
>> -
>> -static struct attribute *procfs_queue_attrs[] = {
>> -	&attr_queue_size,
>> -	&attr_queue_type,
>> -	&attr_queue_gpuid,
>> -	NULL
>> -};
>> -
>>   static const struct sysfs_ops procfs_queue_ops = {
>>   	.show = kfd_procfs_queue_show,
>>   };
>>   
>>   static struct kobj_type procfs_queue_type = {
>>   	.sysfs_ops = &procfs_queue_ops,
>> -	.default_attrs = procfs_queue_attrs,
>>   };
>>   
>>   static const struct sysfs_ops procfs_stats_ops = {
>> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>>   		return ret;
>>   	}
>>   
>> +	kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
>> +	kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
>> +	kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
>> +
>>   	return 0;
>>   }
>>   
>> @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>>   	if (!q)
>>   		return;
>>   
>> +	sysfs_remove_file(&q->kobj, &q->attr_guid);
>> +	sysfs_remove_file(&q->kobj, &q->attr_size);
>> +	sysfs_remove_file(&q->kobj, &q->attr_type);
>> +
>>   	kobject_del(&q->kobj);
>>   	kobject_put(&q->kobj);
>>   }
