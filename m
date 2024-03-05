Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3FC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9060711253D;
	Tue,  5 Mar 2024 09:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUmjqQV7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9094110E363
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8pGXXyYzqzA5M7IrJol9Ak/iuKXIYdofPKp7pnchQd8QPHi3oI7LtNsJEVx+plXLN3Drtwnxk69zsUliO3iG+7vpauQPiYdSuIoL0IGPC2w0lzDzCAExdNZlgWq6a1cPYkbraBSBcjKxLxmROPYEImEl9ZjrIhZCJZPZtGCU6jIbay3wv2+tVTK/tO8TelB6b4rfYbYc7dUgzo3H8PwuSDyooPhWEru53go5kKJFTbk/gy0ymrl5ArcNL6NIvWI4J5+Yh7WrKFmKoFxVlkWWXVikZpOGrKG2DePCQ28eJfIJQIJpwSTWDgqrm76r77gM0CQAb+t+Fif6e1r04j5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0a/EyULII8J28c2CYCpnoSkGZjX15jHYM33P1rJNiU=;
 b=EilbL28F9op2O5P8AcHqgjvI0RAEXPpbm70ETqpxEc2qjZYT2Qg1G15u0sI0gM1uWDuEI/KTZzQ4fUPPvYqz+8ZomVfABZrdwqmZPuISqXTITmZjHEWD26XsUghl6bl0ktB3Q1dfqtM/p3BPcODeQmeGgN7eCGa9sd3Kkwo88ftb/12GaTop77RKGjYysCLgCBcEVi2/7vz+QojBjx7mLX3EsHoo7+MQmmCLCQ2Bo5T7BwkMOjLpLuuwK39piUWBmIr+umF59Q0eXzY5UYMahKVbNFKMvEB9LHT3bftf+BAxxblzXChEcfxNu91znESNp16kBNw5RpNxa08N1QHD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0a/EyULII8J28c2CYCpnoSkGZjX15jHYM33P1rJNiU=;
 b=dUmjqQV70uyjbZ4RCw/OiVSP7ARdzzNKK2QX9I/CTmLc+B/znTDwW9/4dEQF8dk0/t3jMTYCGvn6ZykxHWXtl1PFzsriZXNRJcpCO3HAf/YhtEAlPsFRG9Q85SQqtTk9YdnwpXK/4oj6Az0ZOmUtg/sOg+HJWrOQi9n2wEaGAlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 09:01:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:01:20 +0000
Message-ID: <f01dea79-b5fd-4026-8b87-8c333bb01c15@amd.com>
Date: Tue, 5 Mar 2024 14:31:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add HDP flush to VCN v4.0.3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <ea7e75ed-0060-4c40-b43a-1baecadd4ef9@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ea7e75ed-0060-4c40-b43a-1baecadd4ef9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b46aef8-7986-48d9-5367-08dc3cf2d338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ygJXG6ZgVlTHWNqi1i1oOMvIqByV6s9lzpYJIq6BeVjPmpj/es5+sp7Z6Fr8WZjW0mmahbB7RBYeGSmasQag/HfyeT+Ya6QBkX5RyJfrT50MFbg/V8mrGinCJnpN1QHe8ymkaBvYw+fs0vHumqo2roUr97nFGhL9m3EpGrAAK+CE8X3V0YWe+TgSxkzYisBVPDSeTY73RcXT6CO5GE/ji8gNjKPZ2UxhDRKncSRYSd6Qocgd8Gc8S1Wb3jdTd3l7J5CNALZrXc5cdurpgtgjtggZL/qdHOmYReDh0Uv+6Gu5Z2XeRjaA/JmpC1MH+bOvH0zNZoNgJ0xBlwhCEhg8DsJk3N+uiC7t2OAjjafokQfAqWbavNNNc2F2JW7wHl6XIx+bv6aPCMYM0fbfW4iZshmyM6+PKuCGG5CF/hpiH37jf/G/3mLPheuFhFjU+aLyh/gCcp9oMNiH6XU6fc4wogeBcGxl3VySxgkVj8ZichjN0rw7Y51Scb3FG3+Kf2aEDAupMamGhN0UzWPnu9MtWiXqrkrB5pWVwY4kQogzpSft4ZoTMOmuX0Vo+aHXG4agYtbH2L6zVAqmXydUzT4MonELQjyI0RqU++7tXxWOtmsfz6pkYcG43AyFVvvW6I39kKxufkffNAi3UBEJ4tSZTQVTpfbBhp/CsuoaC4pi2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFwaFJlT0ZJWlU0V2s5QVpqUmpmOEtBM002azcyQUNTVGxDSUpQSnlVR3Bh?=
 =?utf-8?B?SDhELzl3elh1cmVEZkw1WXFYMWUrcFNnYzc4VjhVajA4bHFrWWRnNmNtNXZy?=
 =?utf-8?B?MkM1K2YzVVYvamRDVUhrUDdTVGNERWdUSTM4QTJJemY4aVhmdWF1NHVVTlVt?=
 =?utf-8?B?VlBJb2doUjVZOHZ5NEFtbE5QdTdiSWtBYjArQ2tsbk4ybmVYaDJZZkJudG1h?=
 =?utf-8?B?UHpXcnVicFgzV3RqTGpDQTczV2d3YnpBSW5GVWJCZjgzbVZMY2JjTU4ybzd6?=
 =?utf-8?B?VjJKZ3daYlk2WEVKU2NEemhwa2ZHeUZFVjBKQlBsbXN6QVFNMklGZnlnSm1M?=
 =?utf-8?B?RURPKzA2MTZzUUhYZzFhb1pMcExtKy9zZUc5ZkVYeGVGMDNYTnNTYzhmVHNH?=
 =?utf-8?B?U3paSW5lRThMZ1FsT2JsSlZLUU5hWm9ud1ZxQ016R0NJN1k5L1NBYnh5UnQv?=
 =?utf-8?B?VnN3Mm9BNDJCd20zRy9zTFo4MFpMeVNldUtTZEhlMkVNYVdsN3hwVWpoZVdE?=
 =?utf-8?B?dTFzYlQ5MXR5eERXMkt5ZHY3N0QvYVpwMlNKU0k3MkFxZUswTnpQd0d0TTZF?=
 =?utf-8?B?MzRhVUlQNGowQzVVemZlRWJSQ3VaY0tEOGVDYjh2NjRDS0hDWDJiOUFUeGtj?=
 =?utf-8?B?OWtxM1NITFFkT2VzRVRqWEV1Y3I3YjhQWVlTWjRWQmVLUERyRG9vVFdzZU04?=
 =?utf-8?B?SDBKbE1naEZPdGtTRitVUXMvclNUY3dtdkw3NEhySjdUVWw1T2RUN1YwVDhn?=
 =?utf-8?B?TmViR0pJTUovUWJiZ201RWh4N1FVM3ZpYkhvM0ZGbU1UdkN3ZEtvSjF6MGRP?=
 =?utf-8?B?RkI2bzZLODExcjF5UFZBU0RldCtRbXN4LzdPRnEvb2RKOGJ0SC9abzRadkd5?=
 =?utf-8?B?VGtnWXMvb0NkT1QvYXk5SW4wRXlpeWxnZVJ3bFBJY3JrckY2TklKQ0VUOXMz?=
 =?utf-8?B?K3RQMFp3aGhiaDcvMGNKdFBETjVTdXBkRzZzL0JMU3dWa01GREVQZ2czSkd3?=
 =?utf-8?B?SzV0ZURwcDA3eXFaT1pYUUg5TzRMTnBQSzViMm1majc2REpZbXJHMmNLd29k?=
 =?utf-8?B?cmVsNjN3WW01Z3dyN2xYRGczVUwxbnpESERUWWJLNFRZQ0NmajRIeUEwZ0Fp?=
 =?utf-8?B?ZTNtaE8wL05nYlg0bEpDa1ZNNEQ3WkpBN25YSHJwcHVkbW9mVXcybjJSYTEy?=
 =?utf-8?B?ZEVyKzFQS2hsQTBoeElHTEs2SVZvOUdvVG1wMzBEL1dKUFFhWVhqWGlHYlhl?=
 =?utf-8?B?NVhXS3VYQnk3NnNpSDJHalZHaW9OL3pqRlQzclY1TWJYblA4K2JQN3o1dzNB?=
 =?utf-8?B?aEREeWVldmpGNlo5MTFuSUo1bm9WN0FMRzhmTkhmQkluVG1IYVlDVDhadGJz?=
 =?utf-8?B?VEdnVHpDUG9jcEY3YTJGRlJqR2pNWGh2TVVGU1ZHelp4WGN5eWZOQW9xaGgw?=
 =?utf-8?B?K2NZekRpMlF5UFhCaEVtdGdQUGFmT085T1VUZm5DR1M1aGxqZEdkYTJjeFE0?=
 =?utf-8?B?bTllcVJVdU9iVGl0RDNLb1hBUXoyVjF5ZGR0bDViaStZNC9zVk5xUld0RG1I?=
 =?utf-8?B?cFA0QUZpUzFtRnpremNYcWN1TXFiRWcwV01NaXU5RjBvUjdaOWJtZkdOTTUv?=
 =?utf-8?B?VlRVS3diVWlDSEtLV3lCUTNvcVZjNUp4L2dMSVpma01yTjRqMU5xWDBzUGt6?=
 =?utf-8?B?ajZIL04vK0ZCMktyMndmREZxOWRITE81VHl6VFpnVndHdUJJdHlDRVROakZu?=
 =?utf-8?B?WTN3UGgrZEwzcXdnVUc5elRpNDdnSTJ3aEZjNU1oZm9HMXo4RnBlV2NoNGZ5?=
 =?utf-8?B?QkFjSWMvRjZtcWZiOGdORjZ2YUZOckpORUdpYXVQMzRHQithZzFtOFVwdEhk?=
 =?utf-8?B?eEpOVmZsaU9Fb21aNHJVN2ttVjRkV3ZGMDR1eHAvVUVHVWVGYjRxVFRtaUdM?=
 =?utf-8?B?d2lsQkVtRnR2L1RGbmt5c01OZG91ckFmSXhWRStPemJRR1pkUWdTQ21FMFNS?=
 =?utf-8?B?UUFQSzFNWkxUVnN2WXVZRDBrY3JDbzJqSFY4NXN5UXp0eDZNbkVoelA0R3VN?=
 =?utf-8?B?REpMckVHNUVEZEJiaXBkNlZleWdmQWdDVlgrZDI5bmhmMXVwWDBTMi9qdUU3?=
 =?utf-8?Q?Xa+pAZmGBkSa+1Kkig1Oprj2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b46aef8-7986-48d9-5367-08dc3cf2d338
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:01:20.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl58tOQv0dShrWrEFlVtL7nNudMMjnueBIRUP4doQvJE9axUgz4FA0IeGJ8tIR4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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



On 3/5/2024 2:22 PM, Christian König wrote:
> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>> VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, trigger
>> HDP flush from host side before ringing doorbell.
> 
> Well that won't work like that.
> 
> The HDP flush is supposed to be emitted into the ring buffer of the
> engine. If you just "emulate" it by a register write than that write
> comes at the wrong time.
> 
> This code here is seriously broken.
> 

This approach was in fact suggested by VCN IP and FW team since RRMT is
not working from VCN side to do a remote flush of HDP (HDP is active
only in one of the AIDs). They mentioned that VCN doesn't need to flush
HDP at the time of processing.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 810bbfccd6f2..7b5ad13b618e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -36,6 +36,7 @@
>>   #include "vcn/vcn_4_0_3_offset.h"
>>   #include "vcn/vcn_4_0_3_sh_mask.h"
>>   #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
>> +#include <uapi/linux/kfd_ioctl.h>
>>     #define mmUVD_DPG_LMA_CTL        regUVD_DPG_LMA_CTL
>>   #define mmUVD_DPG_LMA_CTL_BASE_IDX    regUVD_DPG_LMA_CTL_BASE_IDX
>> @@ -1380,6 +1381,26 @@ static uint64_t
>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>                       regUVD_RB_WPTR);
>>   }
>>   +static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>> +{
>> +    /* VCN engine access for HDP flush doesn't work when RRMT is
>> enabled.
>> +     * This is a workaround to avoid any HDP flush through VCN ring.
>> Instead
>> +     * HDP flush will be done by driver while submitting doorbell.
>> +     */
>> +}
>> +
>> +static void vcn_v4_0_3_flush_hdp(struct amdgpu_ring *ring)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +
>> +#ifdef CONFIG_X86_64
>> +    if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>> +        return;
>> +#endif
>> +    if (ring->wptr)
>> +        WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>> KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +}
>> +
>>   /**
>>    * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
>>    *
>> @@ -1394,6 +1415,9 @@ static void
>> vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>       if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
>>           DRM_ERROR("wrong ring id is identified in %s", __func__);
>>   +    /* Flush HDP before ringing doorbell */
>> +    vcn_v4_0_3_flush_hdp(ring);
>> +
>>       if (ring->use_doorbell) {
>>           *ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
>>           WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
>> @@ -1420,6 +1444,7 @@ static const struct amdgpu_ring_funcs
>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>       .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>       .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>       .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>> +    .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>       .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>       .test_ib = amdgpu_vcn_unified_ring_test_ib,
>>       .insert_nop = amdgpu_ring_insert_nop,
> 
