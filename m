Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF160A2606
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wS2Ige8x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F8C10E43D;
	Tue, 27 Oct 2026 16:38:49 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDE710E43D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 16:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRoa45J7dOIcqUA6in1cGI+i93Tnj2fyjHtCXCQQjQpsFtPsmXWJnJITgWH0T89pUwZXRaUdo6dOYFQNyC6c3QoLSzY/I+dCRkAIb2saMU62rDE55DCpnUWWaGPASoemrQSW2Mr/nyMHKgGM0WoPpfFXZ1wpPjJ1kYLqHi8sa8jJWR5V4sSO6XqxgX1rXUvgRrohzTW45T9S02NAwDI1YO2imDqtRiANIOHUwj9OxgHA0CGPQh/USs9aZxM9ZPpmrLlUcjSePBrOGvqg8QR19qjs2CDmkwN/LOnGmbUF2CbPi7yk/IA6W4nJjBWEAKPFEoFgDEnF9WRBvcaebYIa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRQGTbahyXFiYqHq2hNVEjm0PAhTFXbevYGQh2Pun7s=;
 b=BdlSGzMkKugFtWsM/oad0U4eBC0wamE9z6/or3z9in0XneVyi7o8gVUYFJ8y6MS1StsRo73TpOPQeOpiZREln0jotpZ0B+zgfjNSqwtw2mmQ50RgLMQ6I1oEaxi9kdZHAhQPu+3F/3HHpV7+wf33pQP5I9GTXy7Odka8Tipz5qpoxhf8H4QWDPWRqfjGKr34BmrvC9mkY8WJilSroUT8Nji5egimLEip4JooqDi8DogxYn/TNQmBxuDMHUFWndQjNAbXBb7W7MB/4VSTj2KbCFat9iDxpUOjadd0m+9SZ3xleiVgXwAOKjDmfklv2myNSy6NZsGsg8CPbxh+K6+YLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRQGTbahyXFiYqHq2hNVEjm0PAhTFXbevYGQh2Pun7s=;
 b=wS2Ige8xsSIyHvt/KKqPZ+3jWUx8OFf7318H0GjkGFnbwPNs3w3uU36IUcZ+KaZEPmSBbyVcf0tZQI9aICbCNNQmZ2uezT+BxQI7HjJ6zMUekS0rpaespPs4tqt9ECo5TXSVtc1lxikO8v22k44C2TWr0zQD1uKxleTcB5aNPH0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:38:39 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:38:39 +0000
Content-Type: multipart/alternative;
 boundary="------------BdoGepANJW6RUROJ60Yn8igU"
Message-ID: <5b602827-6633-4ee2-a19e-30455243ab7b@amd.com>
Date: Tue, 27 Oct 2026 11:38:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Get foreign dma-buf info
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20261023144813.1220394-1-xiaogang.chen@amd.com>
 <b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com>
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ffb530-7d51-4b1e-0e3a-08df3448c0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261021123027099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|8096899003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: fsEO6ragXooWFhCWOaHc+RWnW+WNbN8TMmSe8DaV9FEPc1vsYWvRK9bxSJji3Wr/9HZ8l/MYs3H8PmYNm9ZAY2pS2PxllWlA2c445qaFaThvKqephMH0PxTniQWR97fNdI7KXsucY5sH6d0aC2bgQ8HWLfBPg12IlTs29PqhUD4GtWPvbmVFbVA2EX6qFfseSLFGkYwu1r4KNnp9L4Ngil17dYPOAtTCZLE+RwQyfDqr/1fqNmB/VyJZPSMXZjmgWy3oeeZIDCwIpJHnHx+jCiPgmacbay9TX64pbdtvRFnCIyz2axspdHci4OwPVRksbrRpq9pLQvTmWEz0pDxzFhQSxEqRv0kxySBnlKypJos7A5HHPLNbPkLxr5nfxeWHd/AosOEvzZyzMC5zVSn+hiLCQpogwiZCouqKfY2wlji1N5g1fCdn3/5RxU3AfPCdTDJBTXUkqCJQqNmnVDpRGGjCle5cjAZuhglWxHw9wep74A71g38ujkFiO09xjCiPy/KByvSp/wFKfcelebaoaadBOU51JSmn1U+80fNfEiF0z8a2rScEUaTB9nyauL04XyzFUsvKVHLHsFRFFYxd55kGoWpuyCnBZB6SvUJkUvMxqAVo4nVI57WD67syyEMHDSg0PpdNTlXn/QbxAwMI9gRyTrrgKrBgBPRNVqWMk18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(8096899003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdqMUlydW15aW9QT2U5OEI2c2ZJMjVSVjFIRlI3SDhXaUxnakJjL2FYdnly?=
 =?utf-8?B?VUkvRlJ6cklBRkRZWUtwMlBCVWxrSzBLOUIwaWRqc3VYV2ZlVHQ3K25RbTEx?=
 =?utf-8?B?Umh3ZStyeWJqeW9YazFmclMwb1JZcVoyOXhQQll6ZWw1MkFXaS8vdlBjMjJV?=
 =?utf-8?B?d0FKTG13eGpYV2t1c2dyY1NvYmhkVmxNcDFrV0diU0w0UTloWmtBaTBQMUsw?=
 =?utf-8?B?dmZMVlN1bVdBRjZTcTMwSmNMTGNxQUc0MDZiVXF0RFFGL2FCWDFoMjlsRjhX?=
 =?utf-8?B?TlZidWpLemUxdEM4WUY0T3F3UnFFbnBZTm9ub0wyTXB5dFAzaVFJUnZCTU5U?=
 =?utf-8?B?SDkzOTFVTGZrZWZtZWkxMzNiTStpam5jUUU3SkRiS2R4Z3FhU2V5N0YzWjRz?=
 =?utf-8?B?bENIR3laelVMVDh5cXdXc044ejJlMlpLVjZ1elhjUlBpQ3ZjRVIvWmU0eXls?=
 =?utf-8?B?MXlXMjFLQ0Jrc2ovUUx6cE9nRW1sc1NlRlN5ck81UFo1QjZNT3Y4Ull5VnZB?=
 =?utf-8?B?OGRCSVJUSExXSU9PT0VpaFlNK3Fib3IxSGl4cjNQTWIwZ3oxTDU1N29TRWxT?=
 =?utf-8?B?UHZpYThzaStJVzVnWENGMFpzS2U3Rmd6N2k1RUUxUmJMaC9QZ3R6TlpLM2NY?=
 =?utf-8?B?TXhmYVpHR2luYkVzQzloK1hsZ3lLTUsvN2lBOWlIY2NVWnBxUlEyeVhpeklK?=
 =?utf-8?B?RW1zZmdPRk9uL3MzSC9FN2VkeEpPUHB1Q3R6ellPbndkR3ExNEpDTXpJWk5o?=
 =?utf-8?B?MjRiLzRmTGVoaDlXV3BHZWI2MzBENHJtd0hURUI2UmEzTVg3VG9HeFkyWG5Q?=
 =?utf-8?B?SStVcWxsVTRha3FxUXpZVnVHOUEzakVzMUhST1kvL2xKb2VmS0UyMHZoUDRI?=
 =?utf-8?B?QVZOczZjTTB0WFVKWGJQeDNKM0pvclRhczV2MkwycEc1WThjcGI5dmxVTjV4?=
 =?utf-8?B?MGxzTWlyMmF3WWRMbURYNGtaK01rVHFvRjM4VGVyNzlQTTcvNW9EM2g2U1N4?=
 =?utf-8?B?ckZreHljMGdSMHdSWWxLenVabHZreFljdWhWTHRFM0NpU1AzOEJ4Sk5FcXVl?=
 =?utf-8?B?ZkJvN0dST05oVWtRWGM3dzQ0b1YveVB6NisvMGZJREFLVGJITktsUkhKOWRy?=
 =?utf-8?B?T1llUmd1QWM3aTBrNzRZRGo4RVpMS1FEeHNYM0hSZ2dHV25MVDYyZHhNenhR?=
 =?utf-8?B?ZGF0MVRmR2FDcHNxbWJCa1RHd21oVFVvQzdwSS9pVHJBbDh4MXpHRENDc1d2?=
 =?utf-8?B?WnRnbXJrRGtJRW9BcFF4RWhXQVk5T1Bic1BRTGwzeTNSdkd1ZFF5N2dKQy8w?=
 =?utf-8?B?Z0xmV20yY2drdmgxeHpGNFZrK3dSNWpUQXRJd0pkN0xFUTU5c2ZiM3lETmxL?=
 =?utf-8?B?OXY0d1FMNGpnd2NTRVl4ZGJidE9oSERrVHhLN3VUVnljOG4wejc0WUQ5ZG5D?=
 =?utf-8?B?R3FUTmVhVW9CQm5IOW9vT0ZzdW9NU3lSakQyTGZZMGp3Q0t4eFhsd2J2aCt0?=
 =?utf-8?B?cExXOVIzc2FJV0U2MmRkZjJESllQdVF3TmI5Z1ozb1FlaUlDZ080ZFFCcDBp?=
 =?utf-8?B?V05lOVB3bmhNWTJWdTAveG45Q2l2cnR0ZUI3M3JlNEZ1K1hwWjF1cktQMm9h?=
 =?utf-8?B?SWdzZHRpSFBJNjRnUkZOR2NEVzZXOTQxVTZUSWNYOUdaSzlYc2R0dFlQUS9U?=
 =?utf-8?B?THl1c0VGVmtrdWlCTVRRWnhzY1k2MXdWc2FrbXhHWXFaSzdEN3VMb1JOd09H?=
 =?utf-8?B?WTd2cGRLcFlIVHR5amZkWE85SUdyNmgzb0FUalBjdjV5Rk1MYlRRMlFMSDAy?=
 =?utf-8?B?TzYxMGxjQStBcFpYRXBpUWtJYjZpbmxCT0xSUnRQb0JpSXpvVUlyekZ4bitV?=
 =?utf-8?B?ODNFa0x1Qks0Q3V2bFU3TVZHbnpoODB3bVlkUUdxd0VwWnUzdEZzTnErdS9Z?=
 =?utf-8?B?Skc2N1drYzYrUkJKTThORnBRdnZPcXVNT29FMmdCTW9VYzBHTzJ5NmEzaU1a?=
 =?utf-8?B?MENKVEZJU0xhVFNTbHVxdTBmMmppRG1LYnlBQkxvMmxWRG5vRW9KSDlic3lN?=
 =?utf-8?B?UEk4d0hTYWxxQjF5dXhrMit2NUcxM1Q5czF5VHpINmI0S2tEeExzR2QrMEhm?=
 =?utf-8?B?SXBJVWpzY0ZERDh3Z3BhM25GZVZCMTBlZlh3cTQ3bnJhY1FQTHR6Q1E2RG8w?=
 =?utf-8?B?a3d3czNqejAzT2RlTjh2U0V6dHZ2MkcyaHppVHpRYm9WWitQWmlEMlNrd2x0?=
 =?utf-8?B?M0Jha3c1dy82ZUowYUUrTUtGM0Vrejk1QWhjWFo3eGVjUmJvUVdmOFVKcTR1?=
 =?utf-8?Q?4bhotiNPIpOOe13I4z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ffb530-7d51-4b1e-0e3a-08df3448c0f2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:38:39.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgIVF3LXsg8tIBwDaSCSvh4uK5DFZYr0pTZp0WHRjGKRQBF31LJVAdmPHbo7kNWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------BdoGepANJW6RUROJ60Yn8igU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/27/2026 4:02 AM, Christian König wrote:
>
> On 10/23/26 16:48, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> When import a dma-buf into kfd driver the dma-buf can be exported from amdgpu
>> driver or another driver/component(foreign).
>>
>> Current kfd driver can't handle foreign dma-buf at AMDKFD_IOC_GET_DMABUF_INFO.
>> When a foreign dma-buf is imported into kfd driver(ex udmabuf) it becomes a
>> normal kfd buf that can be exported, then imported in same or another amdgpu
>> device. That requires kfd drive to get new exported dma-buf info before it is
>> imported.
> Yeah again absolutely clear NAK to that!
>
> Re-exporting the imported DMA-buf this way is *clearly* not allowed!
This "Re-exporting" is from driver point view. App exports only once. 
The original buf was generated by Thunk using foreign driver/component 
exported buf when app allocates buf. Driver sees "exporting the imported 
DMA-buf", app does not. App uses same routine to handle it as for normal 
kfd buf.
>
> What you can do is to re-export the original DMA-buf so that you get the same fd you would get from the original exporter.
>
> In other words you can then also ask the original exporter for that information.

During the procedure there is only one dma-buf instance which was 
generated by foreign driver/component. kfd does not generate new dma-buf 
instance. It saves this dma-buf instance. kfd generates a "struct 
kgd_mem" to wrap this dma-buf instance and record its metadata. Then 
dma-buf info is obtained from this "struct kgd_mem".

Regards

Xiaogang

>
> Regards,
> Christian.
>
>> Extend kfd_ioctl_get_dmabuf_info to handle args->dmabuf_fd that was originally
>> exported by foreign component.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 47 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++++-
>>   3 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index e3da382ceb3c..170f0ea0b78a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -347,6 +347,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>>   					 uint64_t va, void *drm_priv,
>>   					 struct kgd_mem **mem, uint64_t *size,
>>   					 uint64_t *mmap_offset);
>> +int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
>> +					     uint64_t *size, uint32_t *flags,
>> +					     uint32_t *gpu_id);
>>   int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>>   				      struct dma_buf **dmabuf);
>>   void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index a5d1d83ee5d3..b7fea3a2f5ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2452,6 +2452,53 @@ static int import_obj_create(struct amdgpu_device *adev,
>>   	return ret;
>>   }
>>   
>> +int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
>> +					     uint64_t *size, uint32_t *flags,
>> +					     uint32_t *gpu_id)
>> +{
>> +	struct amdkfd_process_info *info = kgd_info;
>> +	struct dma_buf *dma_buf;
>> +	struct kgd_mem *mem;
>> +	int ret = -EINVAL;
>> +
>> +	if (!info)
>> +		return -EINVAL;
>> +
>> +	dma_buf = dma_buf_get(fd);
>> +	if (IS_ERR(dma_buf))
>> +		return PTR_ERR(dma_buf);
>> +
>> +	mutex_lock(&info->lock);
>> +	list_for_each_entry(mem, &info->kfd_bo_list, validate_list) {
>> +		struct amdgpu_device *bo_adev;
>> +		struct kfd_dev *kfd;
>> +		int8_t xcp_id;
>> +
>> +		if (!mem->is_imported || mem->dmabuf != dma_buf)
>> +			continue;
>> +
>> +		if (size)
>> +			*size = amdgpu_bo_size(mem->bo);
>> +		if (flags)
>> +			*flags = mem->alloc_flags;
>> +		if (gpu_id) {
>> +			bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
>> +			kfd = bo_adev->kfd.dev;
>> +			xcp_id = mem->bo->xcp_id;
>> +			if (kfd && xcp_id >= 0 && xcp_id < kfd->num_nodes &&
>> +			    kfd->nodes[xcp_id])
>> +				*gpu_id = kfd->nodes[xcp_id]->id;
>> +			else if (kfd && kfd->num_nodes && kfd->nodes[0])
>> +				*gpu_id = kfd->nodes[0]->id;
>> +		}
>> +		ret = 0;
>> +		break;
>> +	}
>> +	mutex_unlock(&info->lock);
>> +	dma_buf_put(dma_buf);
>> +	return ret;
>> +}
>> +
>>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>>   					 uint64_t va, void *drm_priv,
>>   					 struct kgd_mem **mem, uint64_t *size,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 1d86ddfd6bde..9ca20331e815 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1595,8 +1595,17 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>>   					  &dmabuf_adev, &args->size,
>>   					  &metadata_buffer, args->metadata_size,
>>   					  &args->metadata_size, &flags, &xcp_id);
>> -	if (r)
>> +	if (r) {
>> +		/* Foreign dma-buf: report it when this process imported it. */
>> +		r = amdgpu_amdkfd_gpuvm_imported_dmabuf_info(p->kgd_process_info,
>> +							     args->dmabuf_fd,
>> +							     &args->size,
>> +							     &args->flags,
>> +							     &args->gpu_id);
>> +		if (!r)
>> +			args->metadata_size = 0;
>>   		goto exit;
>> +	}
>>   
>>   	if (xcp_id >= 0)
>>   		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
--------------BdoGepANJW6RUROJ60Yn8igU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/27/2026 4:02 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com">
      <pre wrap="" class="moz-quote-pre">

On 10/23/26 16:48, Xiaogang.Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When import a dma-buf into kfd driver the dma-buf can be exported from amdgpu
driver or another driver/component(foreign).

Current kfd driver can't handle foreign dma-buf at AMDKFD_IOC_GET_DMABUF_INFO.
When a foreign dma-buf is imported into kfd driver(ex udmabuf) it becomes a
normal kfd buf that can be exported, then imported in same or another amdgpu
device. That requires kfd drive to get new exported dma-buf info before it is
imported.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yeah again absolutely clear NAK to that!

Re-exporting the imported DMA-buf this way is *clearly* not allowed!</pre>
    </blockquote>
    This &quot;Re-exporting&quot; is from driver point view. App exports only
    once. The original buf was generated by Thunk using foreign
    driver/component exported buf when app allocates buf. Driver sees
    &quot;exporting the imported DMA-buf&quot;, app does not. App uses same
    routine to handle it as for normal kfd buf.
    <blockquote type="cite" cite="mid:b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com">
      <pre wrap="" class="moz-quote-pre">

What you can do is to re-export the original DMA-buf so that you get the same fd you would get from the original exporter.

In other words you can then also ask the original exporter for that information.</pre>
    </blockquote>
    <p>During the procedure there is only one dma-buf instance which was
      generated by foreign driver/component. kfd does not generate new
      dma-buf instance. It saves this dma-buf instance. kfd generates a
      &quot;<span style="white-space: pre-wrap">struct kgd_mem&quot; to wrap this dma-buf instance and record its metadata. Then dma-buf info is obtained from this &quot;</span><span style="white-space: pre-wrap">struct kgd_mem&quot;.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Extend kfd_ioctl_get_dmabuf_info to handle args-&gt;dmabuf_fd that was originally
exported by foreign component.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 47 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e3da382ceb3c..170f0ea0b78a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -347,6 +347,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 					 uint64_t va, void *drm_priv,
 					 struct kgd_mem **mem, uint64_t *size,
 					 uint64_t *mmap_offset);
+int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
+					     uint64_t *size, uint32_t *flags,
+					     uint32_t *gpu_id);
 int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
 				      struct dma_buf **dmabuf);
 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d3..b7fea3a2f5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2452,6 +2452,53 @@ static int import_obj_create(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
+					     uint64_t *size, uint32_t *flags,
+					     uint32_t *gpu_id)
+{
+	struct amdkfd_process_info *info = kgd_info;
+	struct dma_buf *dma_buf;
+	struct kgd_mem *mem;
+	int ret = -EINVAL;
+
+	if (!info)
+		return -EINVAL;
+
+	dma_buf = dma_buf_get(fd);
+	if (IS_ERR(dma_buf))
+		return PTR_ERR(dma_buf);
+
+	mutex_lock(&amp;info-&gt;lock);
+	list_for_each_entry(mem, &amp;info-&gt;kfd_bo_list, validate_list) {
+		struct amdgpu_device *bo_adev;
+		struct kfd_dev *kfd;
+		int8_t xcp_id;
+
+		if (!mem-&gt;is_imported || mem-&gt;dmabuf != dma_buf)
+			continue;
+
+		if (size)
+			*size = amdgpu_bo_size(mem-&gt;bo);
+		if (flags)
+			*flags = mem-&gt;alloc_flags;
+		if (gpu_id) {
+			bo_adev = amdgpu_ttm_adev(mem-&gt;bo-&gt;tbo.bdev);
+			kfd = bo_adev-&gt;kfd.dev;
+			xcp_id = mem-&gt;bo-&gt;xcp_id;
+			if (kfd &amp;&amp; xcp_id &gt;= 0 &amp;&amp; xcp_id &lt; kfd-&gt;num_nodes &amp;&amp;
+			    kfd-&gt;nodes[xcp_id])
+				*gpu_id = kfd-&gt;nodes[xcp_id]-&gt;id;
+			else if (kfd &amp;&amp; kfd-&gt;num_nodes &amp;&amp; kfd-&gt;nodes[0])
+				*gpu_id = kfd-&gt;nodes[0]-&gt;id;
+		}
+		ret = 0;
+		break;
+	}
+	mutex_unlock(&amp;info-&gt;lock);
+	dma_buf_put(dma_buf);
+	return ret;
+}
+
 int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 					 uint64_t va, void *drm_priv,
 					 struct kgd_mem **mem, uint64_t *size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d86ddfd6bde..9ca20331e815 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1595,8 +1595,17 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 					  &amp;dmabuf_adev, &amp;args-&gt;size,
 					  &amp;metadata_buffer, args-&gt;metadata_size,
 					  &amp;args-&gt;metadata_size, &amp;flags, &amp;xcp_id);
-	if (r)
+	if (r) {
+		/* Foreign dma-buf: report it when this process imported it. */
+		r = amdgpu_amdkfd_gpuvm_imported_dmabuf_info(p-&gt;kgd_process_info,
+							     args-&gt;dmabuf_fd,
+							     &amp;args-&gt;size,
+							     &amp;args-&gt;flags,
+							     &amp;args-&gt;gpu_id);
+		if (!r)
+			args-&gt;metadata_size = 0;
 		goto exit;
+	}
 
 	if (xcp_id &gt;= 0)
 		args-&gt;gpu_id = dmabuf_adev-&gt;kfd.dev-&gt;nodes[xcp_id]-&gt;id;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------BdoGepANJW6RUROJ60Yn8igU--
