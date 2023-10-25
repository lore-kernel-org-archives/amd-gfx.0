Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5BEC0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 18:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9683310E6CD;
	Wed, 25 Oct 2023 18:45:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539A610E6CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 18:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe65IyYrP2NsFLft8cZSIXT9ugMFz98Kf0beWI1OC7NancvmR5s9SZF0WAX5tq7YwxsC2GP0zQJPjFPUwP3p0xEkkGGg/sNeiRuDbKTsqQBC88waZqXia58bX4b8LCo/faT65lEKZLd+y0K7z4rIOzcuWcNH1UP+YWQk2fq/e/aK6HZTAGZ4/fseWUz4isAt2/Sat9XakVoSaPdmMBC3ITsGThDk/mthMsVEjYuALYfx0LtkcLMKotUOK0xsFimrvwlQzaRzf583eA9d9vTB/7ShBqWYjAMz7hzu6BjXsYghdftnogx/g2Gx5NGpF++TzhsZkqXbtAFyP/r9mGtlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8K78/OR275U2eXer6M5PFbcXeNQc/5LTL6Rvbvj0y0=;
 b=lrD05fTU0AIQl7E5IIFzuPy6A/EhNzq3MPPLMnbEWyv8pVJ6e656QU73LmrzWu9uFm4KP1Sr74VaZ+meRVU+NPTbEOsJTUxFhpzXMgvUbd+V2VaArw6tVfAUWCeSpLt1vnuJw5a5/ElNq9WYPPv/qcSINfuBn6FEHdh6XmkCUmgxL3JG8SHu6l5JsWdF2M4Xh/q4rF0q1DQqSUMngVkPGm+CbRIleLCrUUNQIKiS9CjfVUHYtMdoBlIt3i4F0S0YmcwIkPVUHOjE5FtIuL5iGI5LJ6BUkMW+2KCvL16J+8B890tplA3X6OWzDZx2InJGjQHveAn1+XWt9Rj1XNwuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8K78/OR275U2eXer6M5PFbcXeNQc/5LTL6Rvbvj0y0=;
 b=S/BMoA8oXP5CI6P9+5USdW9ZTCz80pRUqir4v15kEI2qcoOlRTqbDLLBW2GZtbvE8+SLTh/Bej7vcAg9UTkilxNrDLaxPaxZE8bAYrDFgx6wYW4p7Fk6YYYs38anTsCIWLYua76Qr42xgB8SQMkmGXPFmIcEdAl9zv8L0T6BPoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 18:45:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:45:11 +0000
Message-ID: <d2d2b06a-6b88-4340-be70-3473d25b833e@amd.com>
Date: Wed, 25 Oct 2023 14:45:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20231024192043.400319-1-David.Francis@amd.com>
 <ebed6ec6-df71-479a-9604-aaf507b340a5@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <ebed6ec6-df71-479a-9604-aaf507b340a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 75851974-bdda-4d33-2ce2-08dbd58a8493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYv7aneq/PqE93/sxilTKl5dRFBkRJzB6UPe80neLvZa9/GH/C+zIF7akLDfggEcABf3WCzgtLLxevkBzc/YQBFB1JHCPyRQiuEO8/84nkwF5U/dEQtAw9HdelNsm9cRD+zjCOjNdj0z2iYRc0wBtY4uPrbNPVaCvJLdKW5hMFZ4S7FaKz9OembDm2B19wZ3IpzSX0i7cQIh66Zs8zg15BtsWGbDIiR47r+WaONk0WErrQAjV3NmweyFgQ97Ttlq3TfXVicxmk8YbOlTiMqKXFoixs4REZ6uIRVPbXhJVC8EwJ6N5XN8kWXOE9rb1ViMv51/TiA6ndOjIwIzfeIxH7UFjsJ8E/VX/0QnAZYv6+XF7nZKm5LaM0hHds9mMTQmaHXMHX39Ikoz8jBMitjF75EWML3XDvfEiAps8eXQyHWvrYQjGvXmdJx0obLedutU4w94uxhqVsg5Zz0LTudgcwpu/VNQC9x7f5+SyTgw7VLNn2ofmwgvvuRDXHscJ0mmog8TlAf1BjcGu8xXC+QFtQlOnFnLBa0Du9IGmh/5vphSxVzER8EZW1tWBbV2VAQI3LPYvoEWnaI2q1xZWWmc3Y+xy4SArHw+n2hcTvjvVcDZ0k+sbWMS5bzwFXo+b09OCfOW3N+DJYRYnmofSoryQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66946007)(36916002)(6512007)(8936002)(83380400001)(66476007)(6506007)(2616005)(5660300002)(41300700001)(53546011)(44832011)(2906002)(478600001)(4001150100001)(8676002)(6486002)(86362001)(6916009)(66556008)(316002)(31696002)(38100700002)(66574015)(26005)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUN3Q1AwSHVlaDJHR2Q1TEdpV0dpVHNmclR3TmY1MXJSVmVOL0xLazl2WFdo?=
 =?utf-8?B?QUduY0Y5aUVzZVdXYUg3MzhxZFV1TERuTEdXcTd3RjNnZ21UVXFQT0hwS3ZB?=
 =?utf-8?B?MXhDdlNPbS8rWVJxU01BNEJuTGpBVlhsUjkrclczamkwMFl0Yy9NL3NwczRk?=
 =?utf-8?B?NmJlQ1VpWHRPTENRQzUyTC90OHA3bERzQW4rSUhVWGpMZWo2RFdjQTRZTE5Y?=
 =?utf-8?B?LytiQlRtUG5oUTVaR1kvWWI5a2dTQkZrTGZRQm9KRHJ0cEtJbVYrZzZNNmZT?=
 =?utf-8?B?L0hpa2UzQTd1OXNtU3dVRTJieEN5ZENIMmhNYm1XTjVHT0lqTk5yVGZ2Zm9Z?=
 =?utf-8?B?SHFHTHBDOExjSFNPdG02d29BWFYyS0VoZWJqeFNOZk5KMTYzTFVXRlBZZXBi?=
 =?utf-8?B?ZGZNbW05VUdqekx3VXE0eitaSWVPNUNDL1d1bGNEYktGTERYeUc5Tjk2RFlV?=
 =?utf-8?B?VXh4WThRNWdXRTV4Yjh5ZTJPQzBhZWJ4a3FXNDM0VytvZ1J3SkkrT2RWSDZP?=
 =?utf-8?B?TStrMlFTbkM2N2FVOFF3cWFWZDZQSERuZXhsUm5Nb1ZDZ0xPMU43R0MrbTJV?=
 =?utf-8?B?aWVRSk9OYktGWi9mdjAxelR3RW95cG9waTRuRWtOVk5UNVhnajYyWFhyazhm?=
 =?utf-8?B?cmZ4NS92VjZleFp0eVdvMFdoZ3RUWFYwYUYyRWNSSGNBM3ZzSjlWMG4xY2V0?=
 =?utf-8?B?RStUMG9YTkt4R3NNeUhtVjcvVVdyV1hSeTlZVE1ld3N6ZDRhVG5oeFErZ2tC?=
 =?utf-8?B?VWpZVFd0KzFJRGx5dUw5Skwva3BzU1UydU44aHZQNEdVTzNsODF4K3R2QU1V?=
 =?utf-8?B?N1pHZ0hTbnVBdEdYTVZLa0VPMmhad2h4b0I2UFhoZUtuWlh3WFd0ZVh4L2tR?=
 =?utf-8?B?L0lsUjJZV3FsU2JVSWZUQlN3Y09YdkRRVnRlQ0JaNC90bThFRS9WcC92M2dp?=
 =?utf-8?B?YkpXMzVCbTZ3K0F0T2JxNnpCN3ZlejcvNys3Q0tvQTBzZjZyYXJhRGprMldU?=
 =?utf-8?B?WGd0S3EraElFeFBiQzA4elB6YmJ6bmNVWDhhSGhSc3lESS9JMzcybkpCaFdm?=
 =?utf-8?B?VEt0NHA4amxTNjNqVHV1MnA2OERDKzFHMmNvRlpNTXFHVmpSdzZ0N0MrRFRa?=
 =?utf-8?B?STB5a0x5bVczZmFmdEFRaWJ1TElXd3piWXozOHBhTjM3bVlmN2I4bWtCZ3pw?=
 =?utf-8?B?dklUOGlvdHR2Y0lQdHErZ0UzMS9MTTYzS3RoU3BCb3RpSm50cVQ4Q28zbENN?=
 =?utf-8?B?Rm9yOEZyMTQ1RVhJWk8wSC94Y09zQTZXNXd5c0k1bDBWc1hPZUpvb2sxV1R2?=
 =?utf-8?B?YXlVdGd4eGFSdjUvdVFvd1lmVzdvVTRnbTEyMTlQQ1VPM2hFYjdkdG96VzN0?=
 =?utf-8?B?Q0tkZWNqNEFrWlAzRVJTOWJ6STc3Zk85N09QWEM0NTN6RnRNU2ZocU9yejFl?=
 =?utf-8?B?c2dRd1JHU1JIcThxaU5KSW1PajAwYU45YVZKa0xISFFVaHcrK0FjYzFOalM2?=
 =?utf-8?B?ejN5NkQ4Tmg5TWp0WHBXUkdRNUtkNytQd2VUbmIxTmRYVW5sNitQc0wyeFNP?=
 =?utf-8?B?Ylg2SjN2NmIyVUpKZE1wVXltLzZ4OEF2SFpMYjVPVVB3Nit6aVZOR05FVHAz?=
 =?utf-8?B?eHN0U01hdFo1UTZjcC9INmxvNGJLM2UwcGVEYThZUTBnbTJnSUR6ZVpPNGdC?=
 =?utf-8?B?Nnc3QWpwNE1ET0VmbDhqUTR1Mjk4QmVITVpHSFdmTGRLdXJia3ZrcE5DMXJ3?=
 =?utf-8?B?bU15NmtTTGxIS1hieFQxTzkyNHZZK2FwOFJtTmt6b1F3TE5mWDZ0Q2NQT3hP?=
 =?utf-8?B?QUNWUTlrLzlabGd0NlBWYUJndEpHYzhhbHVqRUQ2QzI2Y3hjUnFVRnJLKzhH?=
 =?utf-8?B?T3hYZlg1VllPNnJNYjBqTjR4RjJJcW9xR2dxMzVoai95QXkxR2R0cks0eFQy?=
 =?utf-8?B?OUJKcDFOalllZ3VCQjlOM0xmSVZUSi9yK2Mxa2VqNGprL3I0ak9GS1lGUlpz?=
 =?utf-8?B?b2puTW9nRUFNTy8xQUVZMmxIeS9TUmFjRGt6bll4S01aTjdjckZ4dEVrQjl4?=
 =?utf-8?B?Zm5MVjZNVG1GR2VlMStmdmJUUHlNeWRjTXZON0E5azMrYTRPNEV5REU2UDI4?=
 =?utf-8?Q?OzHruERnt384yp+LtaSQD5jiR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75851974-bdda-4d33-2ce2-08dbd58a8493
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:45:11.1342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klfAcZTCWxDTe5+AwRQ2K1SWXuP9+A2t6r/9PH8e4QJHuzp/hqkSCp6s6o5L0RtmHLx2QpReytPx/PSe7TFe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-25 02:12, Christian König wrote:
> Am 24.10.23 um 21:20 schrieb David Francis:
>> dmaunmap can call ttm_bo_validate, which expects the
>> ttm dma_resv to be held.
>
> Well first of all the dma_resv object isn't related to TTM.
>
>>
>> Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.
>>
>> Because the dmaunmap step can now fail, two new numbers
>> need to be tracked. n_dmaunmap_success tracks the number
>> of devices that have completed dmaunmap. If a device fails
>> to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
>> the number of bos on that device that were successfully
>> dmaunmapped.
>>
>> Track those values in struct kgd_mem.
>>
>> This failure can also cause the sync_memory step of the ioctl
>> to be repeated; it is idempotent, so this should not cause any issues.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 +++++++++++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++++-----
>>   3 files changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 3ad8dc523b42..c60564ec4312 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -86,6 +86,10 @@ struct kgd_mem {
>>         bool aql_queue;
>>       bool is_imported;
>> +
>> +    /* Used to track successful dmaunmap across retries in unmap 
>> ioctl */
>> +    uint32_t n_dmaunmap_success;
>> +    uint32_t n_dmaunmap_bos;
>>   };
>>     /* KFD Memory Eviction */
>> @@ -302,7 +306,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct 
>> amdgpu_device *adev,
>>                         struct kgd_mem *mem, void *drm_priv);
>>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>           struct amdgpu_device *adev, struct kgd_mem *mem, void 
>> *drm_priv);
>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>> *drm_priv);
>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>> *drm_priv);
>>   int amdgpu_amdkfd_gpuvm_sync_memory(
>>           struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 54f31a420229..c431132d7cc1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2102,21 +2102,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>       return ret;
>>   }
>>   -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>> *drm_priv)
>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>> *drm_priv)
>>   {
>>       struct kfd_mem_attachment *entry;
>>       struct amdgpu_vm *vm;
>> +    int ret;
>> +    int i = 0;
>>         vm = drm_priv_to_vm(drm_priv);
>>         mutex_lock(&mem->lock);
>>         list_for_each_entry(entry, &mem->attachments, list) {
>> -        if (entry->bo_va->base.vm == vm)
>> -            kfd_mem_dmaunmap_attachment(mem, entry);
>> -    }
>> +        if (i >= mem->n_dmaunmap_bos) {
>> +            ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
>> +            if (ret) {
>> +                mem->n_dmaunmap_bos = i;
>> +                goto out;
>> +            }
>> +
>> +            if (entry->bo_va->base.vm == vm)
>> +                kfd_mem_dmaunmap_attachment(mem, entry);
>>   +            amdgpu_bo_unreserve(entry->bo_va->base.bo);
>> +        }
>> +        i++;
>> +    }
>
> WOW, big NAK to that!
>
> You are essentially re-inventing the locking multiple BOs at the same 
> time, please don't do that. Instead use dma_exec or ttm_exec_buf for 
> that.

I don't think that's the intention here. We're not locking multiple BOs 
at the same time. The purpose of all this counting is to safely handle 
ioctl restart for signal handling without dmaunmapping the same thing twice.

That said, I'm not a fan of this counting approach either and suggested 
a simpler way of doing this by adding a flag in the kfd_mem_attachment 
structure.

Regards,
   Felix


>
> This also avoids all the fail handling.
>
> Regards,
> Christian.
>
>> +    mem->n_dmaunmap_bos = 0;
>> +out:
>>       mutex_unlock(&mem->lock);
>> +    return ret;
>>   }
>>     int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 06988cf1db51..66dee67ad859 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1366,7 +1366,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>   {
>>       struct kfd_ioctl_unmap_memory_from_gpu_args *args = data;
>>       struct kfd_process_device *pdd, *peer_pdd;
>> -    void *mem;
>> +    struct kgd_mem *mem;
>>       long err = 0;
>>       uint32_t *devices_arr = NULL, i;
>>       bool flush_tlb;
>> @@ -1400,7 +1400,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>           goto bind_process_to_device_failed;
>>       }
>>   -    mem = kfd_process_device_translate_handle(pdd,
>> +    mem = (struct kgd_mem *)kfd_process_device_translate_handle(pdd,
>>                           GET_IDR_HANDLE(args->handle));
>>       if (!mem) {
>>           err = -ENOMEM;
>> @@ -1414,7 +1414,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>               goto get_mem_obj_from_handle_failed;
>>           }
>>           err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>> -            peer_pdd->dev->adev, (struct kgd_mem *)mem, 
>> peer_pdd->drm_priv);
>> +            peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
>>           if (err) {
>>               pr_err("Failed to unmap from gpu %d/%d\n",
>>                      i, args->n_devices);
>> @@ -1426,7 +1426,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>       flush_tlb = kfd_flush_tlb_after_unmap(pdd->dev->kfd);
>>       if (flush_tlb) {
>>           err = amdgpu_amdkfd_gpuvm_sync_memory(pdd->dev->adev,
>> -                (struct kgd_mem *) mem, true);
>> +                mem, true);
>>           if (err) {
>>               pr_debug("Sync memory failed, wait interrupted by user 
>> signal\n");
>>               goto sync_memory_failed;
>> @@ -1434,7 +1434,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>       }
>>         /* Flush TLBs after waiting for the page table updates to 
>> complete */
>> -    for (i = 0; i < args->n_devices; i++) {
>> +    for (i = mem->n_dmaunmap_success; i < args->n_devices; i++) {
>>           peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>>           if (WARN_ON_ONCE(!peer_pdd))
>>               continue;
>> @@ -1442,8 +1442,14 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>               kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>>             /* Remove dma mapping after tlb flush to avoid 
>> IO_PAGE_FAULT */
>> -        amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>> +        err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, 
>> peer_pdd->drm_priv);
>> +        if (err) {
>> +            pr_debug("DMA unmapping failed, acquire interrupted by 
>> user signal\n");
>> +            goto dmaunmap_failed;
>> +        }
>> +        mem->n_dmaunmap_success = i+1;
>>       }
>> +    mem->n_dmaunmap_success = 0;
>>         mutex_unlock(&p->mutex);
>>   @@ -1455,6 +1461,7 @@ static int 
>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>   get_mem_obj_from_handle_failed:
>>   unmap_memory_from_gpu_failed:
>>   sync_memory_failed:
>> +dmaunmap_failed:
>>       mutex_unlock(&p->mutex);
>>   copy_from_user_failed:
>>       kfree(devices_arr);
>
