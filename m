Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A546109F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90A546109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F0E6E96A;
	Wed, 20 Oct 2021 08:48:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94F96E8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 08:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffj3RNzWhRs3+yEi5ggkh8YQ+22f6Ra0QeYBcBHMCddkHR4owKC3EaRt2QWQWoK/ulkAOH4qe4gK4M39m7PHYSu019XsoYlKgLpNxC/RurYGq+C+y4p1TgDrD7DQ9XFZfvmKnmCaxy2T5+Ff44lAIVqrZp0JZHI4lMmSEA+Q6qlGNfUDs+Dm3glviPt5NJn1rMS+bCwEE/lXmuf+G7frobkL1cr9DXUU8/3QiNb0qLNvjXY3QLNDi1Y4JK+oRohWRN+c29HNj6dtZRBjN6AZweMcmyEw1dX/chmKSOqLEOCrRdSf/Q3xPvfQ6jT4RCWtx4JD7wOhC+0mIQr4t/szzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ7jY6kNo6qR7yvGB5+78c1nRZ6ZUAvK9ZGuWd68Zdg=;
 b=YzVPq6jqzhBiz0RSEEAKEUOFbXvbiTLIfRMsdqf7hYH26mH9OvTVtQh7wyW/IWF7ESWZwqwDy2/AoigLK4KhQep7/te7HSdPZ4gAFKWqU1EOslHrpxK4qxeuF1RDMosuD+nukyUlszqYObIqDR2ptSO/DHge7EcFXXkr9XEc3g8597/YaVLLjHN9bWcXLigP7O7QJWyNNiTZ8e2y/UsN7YH2IuUomsFJotoTWVNy50N0C3hung/ikJbv7+wQRIrhDvJPgbOOtmMkHUQXXa/hk6PEvzdujZK4iVa2fLwdoPOgVlPXkgvN3Ws9ULq8IzVJIavY0J9Ti2mAEKrZjjisaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ7jY6kNo6qR7yvGB5+78c1nRZ6ZUAvK9ZGuWd68Zdg=;
 b=OkSzHCTuVQT2jpfnwfZkNj3qR8Cm2k6cRf6FLyq9lei5adfmuOrA9Cu4/y0qeXkyfSTacKyuiXJjQi/X6Ed7sBKRmjj9EbKdtmqE4tk9c6hXejQZmwHXIj6+A/HVm++REZ9YPbMeYUqd7YSIPzXfB4kyJdhel4BID/vCxl2CVM0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 08:48:07 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 08:48:07 +0000
Message-ID: <0cff2a61-0637-cf31-2a60-5326c6bd40f7@amd.com>
Date: Wed, 20 Oct 2021 10:48:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AS8PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:20b:310::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Wed, 20 Oct 2021 08:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1179177d-29e1-4379-5afb-08d993a65695
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53270F273A1A5ED937F21EB98BBE9@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNWLCFdMgcjo47xh55ZWB++Z31kW8oiD3J5rmPbVmOJo7O02oacObOK6k6VlPhIAZe3MM4cCT0JfpnIPMlMOXmxHBlmHJcOSvSAYReLHmRukUEGNCEYRAi6iu8OXboPTBBAf9F/b1A+1Sposz9Og4jET4hdPpatByOkz+uua2n0AyjyKG8DmvU17kStRagClyC+y2iAUgoqPDFkbljmQj95NirySukgQdEh6rFatNU5OfXGyzDN2XAqsNkwhgE093Ar5Exud1GKKqbHjYh/vS+jq+rs8xM4p3l8F+WAO04aqzTa5IJm6BCVKUj2KswDR4/sG/LmC4G81OgJBHlcj9rBy95v414gJfQNzInQkbyTSDg9WZeubzf9BRZBZpqKke4zGWG1bE6n26Q3DkxT1DVBgwHlRAMfJ6sD7TPURbdGW1c559yNOw5lBf1Q8F148XaA5cQPn/Vjp05FeVkEforyH4cV/K+3QOwaPgSWo5N2Mt9Jofg4Vhk9fjtSAtFH4uFLcyjIKn813FWC7ldAodxeSWbQ1Mq6zjma+DcF+bXcolgG4e2BNgRHSQkHWI1TiAqLgRLfqzZ9T3FHqs7lOGr0n9/N4q5VeKunPqGbaAozEmdKeV32GqTCt2hQSkGjLhByfWuQYvH1CybpFo0lT/CeWBnJiP/BcGFynkf/Zft4ESvu0H4FXFQ5E2e/OntkxjigA2TeMTKovUNBCXEr/Y0DOBHZlunEZbVtiz+wGFa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8936002)(26005)(5660300002)(316002)(4326008)(66556008)(66476007)(2616005)(956004)(66574015)(53546011)(83380400001)(66946007)(508600001)(16576012)(38100700002)(8676002)(36756003)(31696002)(86362001)(31686004)(2906002)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxrZm1sOWdtY2VLYjM0cFd3UDJIVmFMVEsyZmtTaSs5RHJBdmFsTHo3QVRY?=
 =?utf-8?B?UWVrQytDWlBmbnU3dkxEc2VxcllYZUhkRi8rWktKN0NBUnE0U1N3SklZc28w?=
 =?utf-8?B?OUFseHFlakhxWElkQ0NmWmdBZWVabmxzMXFwNkthbEQvSHZ2Q3pUbCtCSmxu?=
 =?utf-8?B?MmlzZzI3YUZaUHFud25yTTQ4K0N5SlJYLytJUmViMFlMbS9YWXNybUc2alRv?=
 =?utf-8?B?T2h4alNya09YaFd1cU5NOFNVL2h0Q2pmNmlkNWxmbGs0SUNPTjhzektTczVX?=
 =?utf-8?B?eG85alVPamRsT3phUCtvUE5JOWtmMHVTZk51Sk11WnQyd0plYWRKM2tPZXpB?=
 =?utf-8?B?ek84SmN5bEJqMHJ4ci9oVHVxUEZOd3hpT01hc05nM1BNWkNPSGFvMWpLVFhx?=
 =?utf-8?B?bHRlTzFheUNGc3V2S09xNVhLWklWSU1sS21VMkFLbm4xVndzbzNGMzBmLzh1?=
 =?utf-8?B?U1VxaGtDQi9OazRJWmRrSytHd0dxUUMzNU12TVNIVWxJK2krYmJQWElENG4x?=
 =?utf-8?B?QjZSUlhPS1NmS0Y2b3BabFppWlV2N1BKWVpPZEpoWUtkeVgzWnRPbDN5WFM4?=
 =?utf-8?B?UHVMK0VkUXgwbGYxSEJTY0N0U2xEeWUrdWR5aVUxSUE5WUhYVEVBZ0MvUTVz?=
 =?utf-8?B?a3Y2Sm1QU1o2d3FYc0xmVkpYU1FoR3Z5ZlRuVGJKWUdnWXF0VGdQcHF4bHZ3?=
 =?utf-8?B?WG0ySzdkT3dnVkNHbFJCRzNZSXVkYVNTbWxoc3lFZXNOcVRoeEkvQmJIQjNs?=
 =?utf-8?B?T3JkczhoQUZ0N1d4TVRqa0xTdUVLWG5TeFFLd1lJa3V4eXg2V2JXTFY0YUNE?=
 =?utf-8?B?WE1hNjNKVFIrb1VRelJkQ0lVQURIZW1SRVZQRkpIQ1F5TTB2NVpJeHBNb2hY?=
 =?utf-8?B?ZERIZmN1TnNWdi9yT2dJR1ZUSWg0SkRyaEpVNk5TOFFhVEhnMVhSeFpoakUr?=
 =?utf-8?B?NXNvRVY3ejB4d1BHNStGSEtNQXc2OEdIcktjaGZ5SjZhQ3gycGo5cEFyYlMy?=
 =?utf-8?B?WUtzclBDZEdDTkNKMi9RNjM4TGZ2UDlNbFdZSkpyK2dncEVnSnZXb3Z2Qkh6?=
 =?utf-8?B?VXBZTm9lM2w1RWlQbnRqWGN1dGg0SzhzUStpNkQ1NzNZVVZpUDVNUzdwbG9m?=
 =?utf-8?B?cXhMajRiRDVWSTRGWGc3V3h0SSsvVmVEeUMvZ2lGUVErM1BUR2pqa0xwTTJR?=
 =?utf-8?B?OWMySTFjNUd2dTF4OHFXeU8rUisxd1FGY0RGcDBLTjdmaUFZZFVCWWdyZEpR?=
 =?utf-8?B?WVl1cnBrVE5qR2hFa2hOajVSeElmYVlZUVV2a05VTkdmaGVWNTVoM1paT3VN?=
 =?utf-8?B?UDd0Sng3RkpsMU1mbm9IWW81VU0rNVlFKzB3NTg1aHlNeDgrcmNXY1NFOXpX?=
 =?utf-8?B?RmwreWZFTFBkQ3dVV3haUnVjZDY3cXB1MjJ2akhDUUpGT3NidzFGT3l4WHQr?=
 =?utf-8?B?QWd1cUZxNk5HNFpwSHphWFNMVXJ5WFFzcjAwVVJuTW4vdS9CKzJVcGhqZEJs?=
 =?utf-8?B?eXJ0QW9YdFZrUmVPdFBIZUFaSER4a1RxL1Y5T3JhcE9VNXlNdjhhdTBXY0Rh?=
 =?utf-8?B?U2lWTG42bmpMakpIeTJiYnZyTEMrcVAzQkNHL3pkcHlJZWZSdlhiSUhOV2E5?=
 =?utf-8?B?bzZGajBiRTlEbkV2ajF5d3l5ajlmWHpYSGFsZUJkbWxYRjB6TU9iVWd0RERt?=
 =?utf-8?B?UzQwekFiTjlsSWc3c0RiRi9XY29lQUJRRVcwMkZWRzZ1ZkVjc3V2OTRURGND?=
 =?utf-8?Q?uw42/X2Y2l1jfh6TIhv6+79EiAonA/brpDv4ust?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1179177d-29e1-4379-5afb-08d993a65695
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 08:48:07.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bC104SJbhA4PND2HtDyLMhRpst65si62vHy/aS++ypKokYMSx12U2FDn7b2Usiy3SPUiGXRoGkn5Lz1XOi0q7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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


On 10/20/2021 8:49 AM, Christian König wrote:
> Am 19.10.21 um 20:14 schrieb Nirmoy Das:
>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>> any ttm_resource_manager pointer. Also there is no need
>> to force other module to call a ttm function just to
>> eventually call gtt_mgr functions.
>
> That's a rather bad idea I think.
>
> The GTT and VRAM manager work on their respective objects and not on 
> the adev directly.


What is bothering me is : it is obvious that  the amdgpu_gtt_mgr_usage() 
for example should only calculate

usages for TTM_PL_TT type resource manager, why to pass that explicitly. 
I am trying to leverage the fact that

we only have one gtt/vram manager for a adev and the functions that I 
changed  work on whole gtt/vram manager

as a unit.


Regards,

Nirmoy


>
> Christian.
>
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 ++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
>>   4 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..5807df52031c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct 
>> amdgpu_device *adev,
>>         amdgpu_virt_init_data_exchange(adev);
>>       /* we need recover gart prior to run SMC/CP/SDMA resume */
>> - amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>> +    amdgpu_gtt_mgr_recover(adev);
>>         r = amdgpu_device_fw_loading(adev);
>>       if (r)
>> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                       amdgpu_inc_vram_lost(tmp_adev);
>>                   }
>>   -                r = 
>> amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, 
>> TTM_PL_TT));
>> +                r = amdgpu_gtt_mgr_recover(tmp_adev);
>>                   if (r)
>>                       goto out;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index c18f16b3be9c..5e41f8ef743a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -77,10 +77,8 @@ static ssize_t 
>> amdgpu_mem_info_gtt_used_show(struct device *dev,
>>   {
>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>> -    struct ttm_resource_manager *man;
>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
>> +    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
>>   }
>>     static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>> @@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct 
>> ttm_resource_manager *man,
>>   /**
>>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>>    *
>> - * @man: TTM memory type manager
>> + * @adev: amdgpu_device pointer
>>    *
>>    * Return how many bytes are used in the GTT domain
>>    */
>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
>>   {
>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> -    s64 result = man->size - atomic64_read(&mgr->available);
>> +    struct ttm_resource_manager *man;
>> +    struct amdgpu_gtt_mgr *mgr;
>> +    s64 result;
>> +
>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +    mgr = to_gtt_mgr(man);
>> +    result = man->size - atomic64_read(&mgr->available);
>>         return (result > 0 ? result : 0) * PAGE_SIZE;
>>   }
>> @@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct 
>> ttm_resource_manager *man)
>>   /**
>>    * amdgpu_gtt_mgr_recover - re-init gart
>>    *
>> - * @man: TTM memory type manager
>> + * @adev: amdgpu_device pointer
>>    *
>>    * Re-init the gart for each known BO in the GTT.
>>    */
>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
>>   {
>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> -    struct amdgpu_device *adev;
>> +    struct ttm_resource_manager *man;
>> +    struct amdgpu_gtt_mgr *mgr;
>>       struct amdgpu_gtt_node *node;
>>       struct drm_mm_node *mm_node;
>>       int r = 0;
>>   -    adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +    mgr = to_gtt_mgr(man);
>>       spin_lock(&mgr->lock);
>>       drm_mm_for_each_node(mm_node, &mgr->mm) {
>>           node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
>> @@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>> ttm_resource_manager *man,
>>                    struct drm_printer *printer)
>>   {
>>       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>> mman.gtt_mgr);
>>         spin_lock(&mgr->lock);
>>       drm_mm_print(&mgr->mm, printer);
>> @@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>> ttm_resource_manager *man,
>>         drm_printf(printer, "man size:%llu pages, gtt available:%lld 
>> pages, usage:%lluMB\n",
>>              man->size, (u64)atomic64_read(&mgr->available),
>> -           amdgpu_gtt_mgr_usage(man) >> 20);
>> +           amdgpu_gtt_mgr_usage(adev) >> 20);
>>   }
>>     static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func 
>> = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2955ea4a62b..b9b38f70e416 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>           ui64 = 
>> amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, 
>> TTM_PL_VRAM));
>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>       case AMDGPU_INFO_GTT_USAGE:
>> -        ui64 = 
>> amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>> +        ui64 = amdgpu_gtt_mgr_usage(adev);
>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>       case AMDGPU_INFO_GDS_CONFIG: {
>>           struct drm_amdgpu_info_gds gds_info;
>> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>           mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>>               atomic64_read(&adev->gart_pin_size);
>>           mem.gtt.heap_usage =
>> -            amdgpu_gtt_mgr_usage(gtt_man);
>> +            amdgpu_gtt_mgr_usage(adev);
>>           mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>>             return copy_to_user(out, &mem,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 91a087f9dc7c..6e337cacef51 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>> *adev);
>>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
>>     uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>
