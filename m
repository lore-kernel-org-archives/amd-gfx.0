Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F8CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 23:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D6210E88F;
	Wed,  8 Nov 2023 23:26:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CAC10E88F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 23:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz5MKpaPhjy0WVT/t1225iKXzToU+diZD9rU00CJk1mvhyWNISEohpM5pIN1D9I2P/d9+0cU6U2cLL2FH1FIUxS08eDLKJDYlXFR5xo7tchzvHadOJbUk75ThMU7IoW95VpFX8IZPch7GmDBENBgjErZVJyhn4hB4ihgFK8FSMYIx2MUMJw3KXLyi9D1FhH24HMgTZ/kKY1CvMS1913KlN0E2l9k+9TOUTaHZ1R7TERZ7EeWpWZRxwFl9UNFC2r9qKBPVMBrlglgNYH7OxEHeMz/E/1310dZPwnvvcdsaZGb0GZymyZeFRQsfyRqEKSsMCv+UhJXnK1G3pANDnwuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgSft32p7J8HIBCj7B3IErWgSKab/0H2tiA0BFCBU/o=;
 b=S+J52Ou5gtezaNDl7YWrzdEgvcZCUE16ykLWr8mkTX5Osoo2oBTzAh3uDA9RBh8yNGyAZX9/jog3zfC/z+BdshyuySiLs1aKP+4jNlkJDKAeBRlFKmZ3jpYTIgc6RHjMhVQqAazpsyEvVnZawA7/owCe6EwaU4G5nBjT2Bnwduo/H0GWuxL40LzjNUxwQDaZfmuLTfzaN15Al1hjfG6SQxgkr/SqKwrtQZ/kfT4Tqq2tHu1TqwYdhr5h9zOVcF2NkcqdNBg4o2nXTAXqWJyVHV90a1rkilM617iFFq7745eJNiZiLHbotsT1dSh0aaE94mgdGns0UmmSGfSwES76Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgSft32p7J8HIBCj7B3IErWgSKab/0H2tiA0BFCBU/o=;
 b=n4OAT0350bRg2lKUs21ntJfAFHRkKtubFXhe33qm+XXOhWT/iGguoJBb+yyRj8MPAQnxnextq+WC3164Nhft11Lr0VwrN7g80L0aiL1hzNXMNPom8pP6fMJiaLugZ4aE/sGokmEjDnKFFH8e82626OPytTZC+5c9XyRck7qNZhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 23:26:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 23:26:07 +0000
Message-ID: <297844d3-835c-4785-b2f9-122a1432e474@amd.com>
Date: Wed, 8 Nov 2023 18:26:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-5-Felix.Kuehling@amd.com>
 <feedeec2-e6ca-f1c1-77db-db0cd6305428@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <feedeec2-e6ca-f1c1-77db-db0cd6305428@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 60183e54-d83e-499d-beeb-08dbe0b215b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE/MielP8nKNv3iNO5N2kA1WT/I6FgI+TDI7UL+AYqz8Aq1z3FhukpA4m1vurLCnmaQAGyP6f7G/Ip8FR3ezF6iSkQsQqK/vEjtVdmGxNf5Fogwnnay0cJRuahd5RN+3XITK+P1xZptmBHCUozcCB4b3W/T4PpExwJsKgslm5+8ebGPP1L5QkwAanFH5+2TLCLdlwAyoTKvQfSMHRxSmKu0ofNB9kdA2M/Xm34GMrzAq7BUr+74CGfYDPvwZMGEINhu2BWFVAebTt7XiDDKX16PMb/ecoGqJEKJODSaIdZB+VXXHqoUTbrxeYj0WzS5+KrXhY2mNmg01twlQhd3PfdCoHza2zQHfIYu3P8xmNC+d6QEVpsuMVYLBl6D7XeLAgYwlAGB21VQRfKbgYV1aCMfuo/xOwMXrSVmrstXEAuSw8mjyka9OaiUf4LkVR5CFokQ3J3h9RAOu18nSGpIsXW0HdGPhIO2tt8yqe/5JqcKRKX4WVaPQt66s141F2U7Kp4jWbCR5b7je0uYe4pjucNzs5SpyHHKPFajgymVUEiY7pOBABdAuUNyIEeHMWfdLIA4MUyaIgg3Gmg4Tncw22yRGRogWPsT9WG+kVea/tb1wuIu+m63CEmbnJLKCNF6bYnMhhfq8hgSc8lPQqVb20A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(2906002)(83380400001)(41300700001)(8936002)(8676002)(478600001)(4326008)(6486002)(44832011)(86362001)(36916002)(6506007)(53546011)(66556008)(31686004)(316002)(66946007)(66476007)(2616005)(5660300002)(38100700002)(6512007)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ozakkwS3lSeDJKa0p1SjBDMlFsVUdSOXFWR2xOS1BDaUFhcXNzcjdLcWFL?=
 =?utf-8?B?RUkxZ3p6SE93MFdVYXBlbFc4bFpVbVltbkI1U2MxbmxNV21IbEVGTWhPQ0xQ?=
 =?utf-8?B?WmYwclVUeTB6NzRYb1BmWVBvdmNnUEZwUG8yY2F2U0JVaWJvcGk0aHpxUXZ0?=
 =?utf-8?B?Z2xseWtoMTVmS0RQdUxzcUxEZ2ViWVdGT3F3M2RTZ0JyYjQ1R2lFalpZS1Vt?=
 =?utf-8?B?NlJZb0ZVZUFUSVdXcXdvNXdKQnExUHRYS1NIMGQ5NVM3bVZlSmJLSzdGMEJF?=
 =?utf-8?B?YnM2R3NzZEw3Vy9TcWVYc05NdWhBTDR1QXRZaCtYS2dxajk4ZlliZ1pqSkEv?=
 =?utf-8?B?U2tWZE1aZ2FCWmRDNWpiVHNkZ1l6UzlSQ1ZxVDB3SnV2cytoQ1RaM0dCNHVE?=
 =?utf-8?B?SEZhZE92VTNrWXZSbTlTeWR6bkJqNmtsSXJwcms1SVVja3QxRC8vRmp2bHU5?=
 =?utf-8?B?TzVJaW1HaHpERDF4VjV2VlNEaTRzTjQ3MFlnOCs0K0NHOW15VGNBSUI1UC9D?=
 =?utf-8?B?N1VMZHluT2Y0Ti9tUytBdXdUMlZNZWJsYlk0MVptazBuckEwalR2Vm5kMm5z?=
 =?utf-8?B?YzhKeDdoQzVBbTczUXlzYy9RSHNibnNYeWd0TVBzaUt3L1JKaVJQRng1VXpW?=
 =?utf-8?B?RkQ5bEQydzByem0zdUlXUzM1eTBSK082M1JOU0ppeTlaN2hDakZDbTVxK3lP?=
 =?utf-8?B?L0ZlK0tKQUlDYXBNU29obXRRdiswaVA4RWs4ZmhUb0lnYnM1YXozZVFjdHdN?=
 =?utf-8?B?WU4zZWM5T3FZcDRsTURLcVBJcjE1MFZ5WkIraUtEcFdvYjV4eTJGSndKbDgy?=
 =?utf-8?B?WkluRVRVemI5N054eGdGaGE2YWZ1ZzNpT3A1WFFzU1hld0dBNXhiL3lBNjhG?=
 =?utf-8?B?THc5bjladGhBazgrdEliSnBUSElORXpVM3FRZHlDb1F3QWVvanE4OHNmWldM?=
 =?utf-8?B?Q3RxTS9zMzVtbGFaUVpjOFdmMVFKZTF3OE5TSjhkNzR6NGhDTk4wV0V3UW42?=
 =?utf-8?B?TGd5ZEYzdnhoUEZreUlSWWtkblJ0d1AyMHZNUlgyR0w4THdJYkpkRnQwZmp5?=
 =?utf-8?B?eTdBVkNaSmhuV2tQWWs3NUc5OU5JR2pBZ2Z6Qm1YZkhRVWtYS2lTbFZiZHN5?=
 =?utf-8?B?ZnQ2UktXRFhBbXI4Y2JzRUpKendNZEdkaFVoSVpvQzRCazQ4dklhT2JFQlFn?=
 =?utf-8?B?ZTNpVVZPUFVtbFU0eXRBWldlVkUrS1FTb0VkYWRDM2dIVEloVGVyWnYweEtV?=
 =?utf-8?B?Q2JXQlVvVEp1QWhOb2RDZjNQRVBYMjU3em96b2hVMmxhdEZaK25OTXUzT2Z3?=
 =?utf-8?B?QkxiejJucmdBVjRnMi9HMkVLYU1WWXA4RkRQcDRpaHhtWmhlSVl6SFNFbFdv?=
 =?utf-8?B?by80dVpzQVJ5cElNekZXOVlXcHM1Tk5aditPTXdUMnhUclhVYmFhWU1zYUl2?=
 =?utf-8?B?VjgwTmhiNDdCY0pIZmt3QU9YV0F4K1NoNTRUMkpDdVVXRkJLQVlvcWdCMGdm?=
 =?utf-8?B?aksvMkw4SUx1OEFjbTV0ckpzU21Hb3hQWUhvNGNSK3c5N3U4TElDZVBFSjV1?=
 =?utf-8?B?ZnBnaUg2Zy9lSkN2blMzeUNWbzk0dENmZEw0V002c2o5TWJIVEcrSTZqT1hW?=
 =?utf-8?B?MXNpZUIxOWg2bzdiY2ZkSXNFNHo3d1hrYktwS21UTkNOeUdTcWNRdzRLeWJE?=
 =?utf-8?B?NFg1Y3YxOUUyY1ByeVhJTm03U3FsNUIzbmZqMml6RHN4NFVEdkk1cWVraU1s?=
 =?utf-8?B?ZWZiaHZDZTEvQ2ZrVFJzYmo0VDk2MUplNmpRZjRoMTBWZkE1MmFZTGgxb1Rw?=
 =?utf-8?B?SzBiUUwxdlNidmdERjhHQTVLOElaYUI2c1JIdjFuZ3pkM0QwNlhoeHdtNXNN?=
 =?utf-8?B?VTV3OUJVRmpXT3BoTmE2d0hGVmkvTVNrbzJiNGZaUXpiZkhjZktYeXg5Qnh4?=
 =?utf-8?B?cnhSZy9IK1dxdUdIalZackUwM04xRDdOb2RQWWFpM1V0MVFlTmhpdlBKcFRH?=
 =?utf-8?B?Wk0zMWQza1RlMGl0cmlsS0h1V2pOM1cwYTVXaHlYRng2eFZHcTNUdWpyb2Ey?=
 =?utf-8?B?OE9vNWZmUXJrMjI0Nm9GR0ZYNFNaNS9MZ1poWHJlY085a05RVjhuSEFhdDZo?=
 =?utf-8?Q?899gxwtKYTsygLmxqE7NXTyFD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60183e54-d83e-499d-beeb-08dbe0b215b4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 23:26:07.7154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7Y1dWk+GQLC8i6G5P8rNR5CIR6WP87BZ1caqaVAvCj9uUaNu6EIe+hsMUaCtHmVmy9xsSHwi1SUqCln3svdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-08 18:20, Chen, Xiaogang wrote:
>
> On 11/7/2023 10:58 AM, Felix Kuehling wrote:
>> Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This
>> ensures that a GEM handle is created on import and that obj->dma_buf
>> will be set and remain set as long as the object is imported into KFD.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 +++++++++++++------
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
>>   3 files changed, 52 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 4caf8cece028..88a0e0734270 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -318,11 +318,10 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>                           struct dma_fence **ef);
>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>                             struct kfd_vm_fault_info *info);
>> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>> -                      struct dma_buf *dmabuf,
>> -                      uint64_t va, void *drm_priv,
>> -                      struct kgd_mem **mem, uint64_t *size,
>> -                      uint64_t *mmap_offset);
>> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, 
>> int fd,
>> +                     uint64_t va, void *drm_priv,
>> +                     struct kgd_mem **mem, uint64_t *size,
>> +                     uint64_t *mmap_offset);
>>   int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>>                         struct dma_buf **dmabuf);
>>   void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 4bb8b5fd7598..1077de8bced2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>         /* Free the BO*/
>>       drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>> -    if (!mem->is_imported)
>> -        drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
>> +    drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
>
> A minor thing for this patch: I think this is a correction for last 
> patch " Export DMABufs from KFD using GEM handles". mem->gem_handle is 
> created unconditionally at amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu.  
> drm_gem_handle_delete should be put at the lat patch.

This change was intentional. Without this patch, imported DMABufs didn't 
get a GEM handle, so I didn't need to delete one. With this patch, I now 
have a GEM handle for imported BOs, so I delete the GEM handle 
unconditionally.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>>       if (mem->dmabuf) {
>>           dma_buf_put(mem->dmabuf);
>>           mem->dmabuf = NULL;
>> @@ -2363,34 +2362,26 @@ int 
>> amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>> -                      struct dma_buf *dma_buf,
>> -                      uint64_t va, void *drm_priv,
>> -                      struct kgd_mem **mem, uint64_t *size,
>> -                      uint64_t *mmap_offset)
>> +static int import_obj_create(struct amdgpu_device *adev,
>> +                 struct dma_buf *dma_buf,
>> +                 struct drm_gem_object *obj,
>> +                 uint64_t va, void *drm_priv,
>> +                 struct kgd_mem **mem, uint64_t *size,
>> +                 uint64_t *mmap_offset)
>>   {
>>       struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>> -    struct drm_gem_object *obj;
>>       struct amdgpu_bo *bo;
>>       int ret;
>>   -    obj = amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
>> -    if (IS_ERR(obj))
>> -        return PTR_ERR(obj);
>> -
>>       bo = gem_to_amdgpu_bo(obj);
>>       if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
>> -                    AMDGPU_GEM_DOMAIN_GTT))) {
>> +                    AMDGPU_GEM_DOMAIN_GTT)))
>>           /* Only VRAM and GTT BOs are supported */
>> -        ret = -EINVAL;
>> -        goto err_put_obj;
>> -    }
>> +        return -EINVAL;
>>         *mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>> -    if (!*mem) {
>> -        ret = -ENOMEM;
>> -        goto err_put_obj;
>> -    }
>> +    if (!*mem)
>> +        return -ENOMEM;
>>         ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>>       if (ret)
>> @@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct 
>> amdgpu_device *adev,
>>       drm_vma_node_revoke(&obj->vma_node, drm_priv);
>>   err_free_mem:
>>       kfree(*mem);
>> +    return ret;
>> +}
>> +
>> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, 
>> int fd,
>> +                     uint64_t va, void *drm_priv,
>> +                     struct kgd_mem **mem, uint64_t *size,
>> +                     uint64_t *mmap_offset)
>> +{
>> +    struct drm_gem_object *obj;
>> +    uint32_t handle;
>> +    int ret;
>> +
>> +    ret = drm_gem_prime_fd_to_handle(&adev->ddev, 
>> adev->kfd.client.file, fd,
>> +                     &handle);
>> +    if (ret)
>> +        return ret;
>> +    obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
>> +    if (!obj) {
>> +        ret = -EINVAL;
>> +        goto err_release_handle;
>> +    }
>> +
>> +    ret = import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, 
>> mem, size,
>> +                mmap_offset);
>> +    if (ret)
>> +        goto err_put_obj;
>> +
>> +    (*mem)->gem_handle = handle;
>> +
>> +    return 0;
>> +
>>   err_put_obj:
>>       drm_gem_object_put(obj);
>> +err_release_handle:
>> +    drm_gem_handle_delete(adev->kfd.client.file, handle);
>>       return ret;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 4417a9863cd0..1a2e9f564b7f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct 
>> file *filep,
>>   {
>>       struct kfd_ioctl_import_dmabuf_args *args = data;
>>       struct kfd_process_device *pdd;
>> -    struct dma_buf *dmabuf;
>>       int idr_handle;
>>       uint64_t size;
>>       void *mem;
>>       int r;
>>   -    dmabuf = dma_buf_get(args->dmabuf_fd);
>> -    if (IS_ERR(dmabuf))
>> -        return PTR_ERR(dmabuf);
>> -
>>       mutex_lock(&p->mutex);
>>       pdd = kfd_process_device_data_by_id(p, args->gpu_id);
>>       if (!pdd) {
>> @@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct 
>> file *filep,
>>           goto err_unlock;
>>       }
>>   -    r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
>> -                          args->va_addr, pdd->drm_priv,
>> -                          (struct kgd_mem **)&mem, &size,
>> -                          NULL);
>> +    r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>> args->dmabuf_fd,
>> +                         args->va_addr, pdd->drm_priv,
>> +                         (struct kgd_mem **)&mem, &size,
>> +                         NULL);
>>       if (r)
>>           goto err_unlock;
>>   @@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct 
>> file *filep,
>>       }
>>         mutex_unlock(&p->mutex);
>> -    dma_buf_put(dmabuf);
>>         args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
>>   @@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct 
>> file *filep,
>>                              pdd->drm_priv, NULL);
>>   err_unlock:
>>       mutex_unlock(&p->mutex);
>> -    dma_buf_put(dmabuf);
>>       return r;
>>   }
