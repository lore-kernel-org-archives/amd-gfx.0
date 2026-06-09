Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A37CD8CAD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 20:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860FE10E209;
	Tue,  9 Jun 2026 20:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGSzDuBb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387B310E209
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 20:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/J/KM5BfAH51/T1bgVsNrrndUtaqYVShQp8kW856CvZYjIa6e5l76Zj3UontcEzvI1lDKpEGum9RX5+H8KyehBZ9gzs3wCTv5Rxf1yR/6iwksseQmUFppX9e2NBzb+TVvaobCmPnN1VjEPWx7O3gs1X6WVVOvJZ3kr0+Tg5EMGawa9O8tkKbEbBQUltzw/rboScfOpnPwuH/0LQhppHDrGSP0a+lBA15aCosnMht6+ohaMYnS7aNBWWWGWtD87luABRGUWdBJ94pr9Mw/2gNsakG98YKwaoy/jbijmmu2XpIR2J72rGhP0pFwW1P6mxAbO1/+w0Dd4Kx0G3SYI57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGnZcEgex48v3JXpbP0XgLMfcevPcM9QxCx0ZzYw3HU=;
 b=vNkvHWqfznN1Dnc2R3bO8qVZvCvTk+snKQhRMFik1w1B3G10exSBStqhXFVd3aLlvMbvA7fCIZALvNrmPKaAWkNCxTZnm7rk1fI741veRHfcoHuyhsFH2xjBXndNg1M1E3MTR0KtlwYFlcxjZdsPxH8wl+EPr3Vm5uan3DSo7TtdWlIaGeJy5vbcBs78yHBDm8Q2haFMpAvipY7vcPaeRv5fibXY6CCa8+VlWep5P1XPr97Jb6L73dv1Yt3TFfb0fsbQNkzifPNsttYQPzc1CVOCabAbKfnNSA+CiqkoFxqGmiSzu/NzvyeAyyTW0P2DA2Vnz/iVtyBh20nSk3HkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGnZcEgex48v3JXpbP0XgLMfcevPcM9QxCx0ZzYw3HU=;
 b=xGSzDuBb3yFZ0Rbv5Z+Qlffk9xD1ZuWMF6YzsDByx3wiqMbvJW1ky5sP7IC3XwWTT+xxOHZHLJj3xpZBkz6N4kc1QtXJA6EsFZmiBRMhvEeB8MuFXgTFAoqEXgSBPkMPlh/R4nd9NEUGVjY+aHBMdtjxiyWjtX5wsjrl3r7zyu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 20:51:56 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%7]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 20:51:55 +0000
Message-ID: <78374cc7-a4ea-4d54-b7e0-f5761dc4298d@amd.com>
Date: Tue, 9 Jun 2026 16:51:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: add sdma queue counter for gfxv9.4.3
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260604174526.131849-1-jinhuieric.huang@amd.com>
 <b0ec2b8a-478d-4f15-afed-39a288a40cea@amd.com>
 <0228d789-95e3-4a60-85fb-4f7eefb2be24@amd.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <0228d789-95e3-4a60-85fb-4f7eefb2be24@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To SJ2PR12MB8650.namprd12.prod.outlook.com
 (2603:10b6:a03:544::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8650:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2e5e7b-5ef6-4655-995b-08dec668f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099006|11063799006|22082099003|3023799007|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: ZFuuuA91Me0ORMnEX7zoe9F56sAz4TqJNG8QHhs7r0BQQ2tFckmsRu/bdaFB0ZyRQ4o3ouXTMqCCVguh3x3Wljh63fRpzX2f8ueVnpik54MT+tOyZD5YVoD3egF9JgUyErEr/wt825rKU5TRpTj4BAv2yo37oug6B7nRYEKACBPmOnVHx+m9/Nvs7heDcHJrxHtUsMOP1Zpdd2JITFJ4hWsz3DN+EB9fHAIiwPuno144PrdV0qHFnjhS+uJQGdEZLezdGV1xv7//hiBdKOC62023lJE8syiBcXqd5VCFH55magg81GAcnRsorn+NX7gnRzSSP1ES/uUZkS6xypR38xG7f4Z+/ktPuOiDpCjWNMjtPEQzcHzrN1fR4w27zseMDC4yEZrP1sF6sfuV692S3+Lg+x+MKtpUO0LZdBi4YtkgC5BEHIjUEfAqOArLZ3FBq/kC9eFnEg6mhmQvn8smUxeEFoQH5j8Fqx/gF+NMZGYJjDVyy2SNGIKJ3i+/c7qYgDIw4rvA2xLm1Sa0DVEhdqBQ1czXUTpVzsv5WvX9JP22bp3efjD9TaT1BPXH/zlleysTCsMeoj7BGD71UIva0P6vDB7J0nnevbPBZCH32fzmwGORvOo35mHZIDo1GYfhxAHc6IqBtyzrmmh89mmRi6QEyb2IBoofQ5ksJPpSdBzHzfr7YCk9uRyq4utSA4NQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(3023799007)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3cwcWd4bU52aVMrdGoyaUVhR2xNOEJBcjRvRmd3T2E0R0Y2U1hGV2FaUW0y?=
 =?utf-8?B?ZlBCc2loYWhlYkx4Q25pNVdZWVU2c2JwRjgvdVBCU0d4RzlIT2VvR3NsYjZC?=
 =?utf-8?B?amQrM0xoamkxWnpsbjQwSXVmV2tSM3IvSWdFcm83aFZjSXVVOEdNaEZYeCtz?=
 =?utf-8?B?NlFYcHZidmtXZkoxM1pSTFMzRHYrQk1LbzFnR29uM29uVGpVcVhJZXZIL2d3?=
 =?utf-8?B?aWx5bmVUWDhZbVgwNkd6dEUrOGU4djlIUGljeGJHc044R3V6VVhKZENHaWtI?=
 =?utf-8?B?NGs2aXFLTGMzbk9Fc2Q4MDI1YktoaWU3bXBsTWtDMXB6WCtxY0ZHTlhNNzlF?=
 =?utf-8?B?WHgwTDJWcEdOVFJVaTlDSXRkN3pzUDVtK0ZOZDFFWEN2YnNBUi9BL3M1YnNL?=
 =?utf-8?B?Yk1KYTNRVytZQjQyRmtNNTBKaitYNVFUd0JyY2tWQTBIK1Y0T29JRXlXYjFp?=
 =?utf-8?B?ZjQ2c2gxQ25hTE1pWDY0NnBUaEVCQUpqeFUyNjhOWEpwZWg1Z1dTblNDY0pE?=
 =?utf-8?B?aml3OUxJUG5weXVtVzVpa3pJZzlFVkNtV3pNWUptU2h1TUE5VHFLWFFscDVC?=
 =?utf-8?B?cDdyTnQxYUFTMUhmSWpCbmwyWU5KQnVic3VkcDZ1QlVWaWg1anAwRXE2eGc2?=
 =?utf-8?B?WHFrY053RUhXU0lHV3dsazZCZzNZNWJGNm1vRjdZdklLenJkaC9leXVsdyto?=
 =?utf-8?B?TklIQ1lKQ01NalZXdWtzQVI1Sm9IQzlZVGxaSEV1VG5zVVhvRlhvajF3dWhH?=
 =?utf-8?B?UHFFbXpxYUxFYUE0UFNBYnhPWlQ5aWRxS21waE13NEJZczhhanprZWszMlNG?=
 =?utf-8?B?UTY0aWtCeGQrQ0tDdS9za2Y3aWZJZkJYdjFuZTAxOGF3bHpwU3pMRmw1cmRF?=
 =?utf-8?B?cjJxWDgzQjNMbkU5ZEw0VjVkU1JXNm85djhnYVM1K3hMS1ZoRHdlTmVkcXJj?=
 =?utf-8?B?R3EyZUZkRmZHd2x2bzFmTHhmZkJ2Mnl3Yk8wSUhQV1NNaCt2VnkrL2JpaGhN?=
 =?utf-8?B?T2V1Q01ncmdTUmszR1BMMEtGZEZqTk9kQnZLcFo5RWJIM1hKekw2VExBV1pK?=
 =?utf-8?B?dldKbU80R0ZBWVJrRjkvR2VNeW03YXFsTFUyR0hlZTM5MXdFdkNCdlpWRlZT?=
 =?utf-8?B?eHNJQ2dzK1FRZ3c4UmVQZTZoaDdzS2hMa0Z4cHpkN25HNHMyTzBaTDZCUUo1?=
 =?utf-8?B?VVptNitCaisvaUdqWTRPYXZ4T05zZGthamJKdjN0cWxXK2Rua0M5ZGdDeWxm?=
 =?utf-8?B?U3Vud1pmanJtTlhVc09NTWI3ZEtBUUVOSWVkMm1WVWhuTjhWdFkxYW53TlUr?=
 =?utf-8?B?elZBV3B2WXdITlFnU3VPa0pvY3I4VnlsYmNLMmQ4VmlCcWgwZmZsYzdDQ3hL?=
 =?utf-8?B?TDBZeVN4MnRFWk5MR0NoVEsyTitNN2hWcmRiM3BVdGZ0UWFnY2ExM3VMN2lZ?=
 =?utf-8?B?elQyaFEvYjE3UDlrbFJFNWFFQkp5TW5oc0pGMzFEOEhkbmZ1VTFma0MzK252?=
 =?utf-8?B?cGdvc21aR0VhdDZkeWFlcEJsdHp2dWJKYytsZk5kWjdXbXNDVGVvTTRZUGJQ?=
 =?utf-8?B?b1pOTGd2RDkwajdxOGovcmc0MWFKRHVLWnFkbEdKWXRKZ09pZGdYMWtiZDAy?=
 =?utf-8?B?ZG53STd5anZ1bldxbzE5WWhUaG9YVnV0cVhlbGdRMUtvQ2hlYXhaRDhKSlVh?=
 =?utf-8?B?S1VycnZlWWczSmlVQXkwU0FBQXYyVWRZYWtabkZJVkhmemRzZ01WYXZhM3N5?=
 =?utf-8?B?eFdwdDIrYmwvVEx4aXdrNWpOTnVpSFBKRlJCZzJpRmlFY0pxRmsxMW9CSXdL?=
 =?utf-8?B?NnNiNm5FbzZRNGVrcU5wTzVOdnlRaHkrMFk3N282TkxzR1dJOTNBVHNsT1l1?=
 =?utf-8?B?Z2ZXd3cxTU8zZEgxR0ZURHZVUlc0bFVINkgzNURkbmlKcmpOM3ZzMlRVWWc5?=
 =?utf-8?B?UFg4dEswT3VwSWIrcVU2emtKOE1VUTlWbWdPYU0zZTVTamRpV1d6Zit0V1RN?=
 =?utf-8?B?Z0JrZ0c3RFdYdGR6VGM5T01kOVNwaHFjYy9ZZjdCM1dzM0x5NEJaYVk5eENs?=
 =?utf-8?B?YnhEdFlsZjBlMlBSeSs5SDhJRm1Cand0SXJiRFhuZnlHdXZGY296L0ZYd2Jq?=
 =?utf-8?B?YWZoMXlkTUF0VWtFekU3YnVDMFFQZUhKckM0Uk4rTFNJU3ZOL1d3b3VXZXJh?=
 =?utf-8?B?ejhaa0JmZ3hGYTlMUURnbFlObFhrSUVLcTNjUVI0S29DUVRSVjUxTXFUT29I?=
 =?utf-8?B?NHd3Z3JIWlhpd3hxVlhjR0srZnVVM0gzcEdObnBZc3E4NzhWY1NNaFYrMU4x?=
 =?utf-8?B?Z25rcUwzS3lhMWhIelMyVmVHZHFkL0o4ck43WHRjMUhXL1pZNVhkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2e5e7b-5ef6-4655-995b-08dec668f108
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 20:51:55.7629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtdGLyTbduJZ5H+i3uei6zTlzl/obDYZKJOcyb7xFUcPHHZ0QMS8mL6ZR398Rd1MBvmo202JBJoS/LYTjIEFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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



On 2026-06-09 14:14, Eric Huang wrote:
> 
> On 2026-06-09 12:43, Harish Kasiviswanathan wrote:
>> There should be a CP FW version check that supports these registers.
> The only difference for CPFW supporting save/restore the registers is no accumulated value per-queue after unmap/remap queue, the utilization register  always updates current value+activity counter by HW, so it is not fully necessary in my point of view. If the check is needed, it won't return anything wrong, and just leaves a warning like "No accumulated counter supported!", what do you think?

[HK]: I think printing values that look correct but is wrong is very misleading. If CP FW doesn't support it, sdma_utilization should report either 0 or -1 along with a message in the kernel log. This should be case for 9.4.4 and 9.5 until CP FW fixes for these ASICs. Apart from that everything else looks fine.

>> Some comments inline.
>>
>>
>> On 2026-06-04 13:45, Eric Huang wrote:
>>> since gfx 9.4.3 HW is calculating accumulated activity counter
>>> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
>>> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
>>> will still keep the way to read from memory at rptr+8.
>>>
>>> v2: read dynamic counter directly from utilization register
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 51 ++++++++++++++++++-
>>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++-
>>>   .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
>>>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +
>>>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
>>>   6 files changed, 89 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>>> index f46c59118304..16bad244c091 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>>> @@ -35,6 +35,8 @@
>>>   #include "sdma/sdma_4_4_2_sh_mask.h"
>>>   #include <uapi/linux/kfd_ioctl.h>
>>>   +#define SDMA_QUEUES_NUM_PER_ENG    8
>>> +
>>>   static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>>>   {
>>>       return (struct v9_sdma_mqd *)mqd;
>>> @@ -584,6 +586,52 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
>>>               ptl_state, fmt1, fmt2);
>>>   }
>>>   +static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
>>> +                    void *mqd, uint64_t *val)
>>> +{
>>> +    struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
>>> +    uint32_t sdma_rlc_reg_offset;
>>> +    uint32_t sdma_rlc_rb_cntl;
>>> +    uint32_t engine_id, queue_id;
>>> +    uint32_t engines = adev->sdma.num_instances;
>>> +    uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
>>> +    bool found = false;
>>> +
>>> +    if (!m)
>>> +        return -EINVAL;
>>> +
>>> +    for (engine_id = 0; engine_id < engines && !found; engine_id++) {
>>> +        for (queue_id = 0; queue_id < SDMA_QUEUES_NUM_PER_ENG; queue_id++) {
>>> +            sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
>>> +                        engine_id, queue_id);
>> [HK]: sdma_rlc_reg_offset read could be move inside the if condition. Saves unncessary register read here.
> It won't work, sdma_rlc_reg_offset is needed in the next line for reading sdm_rlcx_rb_base from register.
>>
>>> +            sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
>>> +                        regSDMA_RLC0_RB_BASE);
>>> +            sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
>>> +                        regSDMA_RLC0_RB_BASE_HI);
>>> +
>>> +            if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
>>> +                m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
>>> +                found = true;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>> [HK]: Needs a if(!found) error handling.
> Because SDMA doesn't support oversubscription, there must be a HQD associated with a MQD, found must be true here. I probably need to add the comment in finding loop for that.
>>
>>
>>> +    sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
>>> +
>>> +    /* Read sdma activity counter from utilization register
>>> +     * if hw queue is enabled, otherwise read from MQD.
>>> +     */
>>> +    if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
>>> +        *val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
>>> +            RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
>>> +    else
>>> +        *val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
>>> +            m->sdmax_rlcx_utilization_lo;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>>>       .program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>>>       .set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
>>> @@ -623,5 +671,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>>>       .trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
>>>       .override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
>>>       .setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
>>> -    .ptl_ctrl = kgd_v9_4_3_ptl_ctrl
>>> +    .ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
>>> +    .hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index b934863312d0..a65161659f74 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -1067,8 +1067,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>>>       /* Get the SDMA queue stats */
>>>       if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>> -        retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>>> -                            &sdma_val);
>>> +        if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
>>> +            retval = read_sdma_queue_counter(
>>> +                    (uint64_t __user *)q->properties.read_ptr,
>>> +                    &sdma_val);
>>> +        else
>>> +            retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>>> +                 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>>> +                    dqm->dev->adev, q->mqd, &sdma_val) :
>>> +                 0;
>> [HK]: What ahout 9.4.4 and 9.5? Do we we support those now? Otherwise, it will silently report 0 and not error.
> gc_9_4_3_kfd2kgd funcs are shared with gfx 9.4.4 and 9.5. The only thing I think is return -ENOTSUP instead of 0, if no function is found here. what do you think?
>>
>>>           if (retval)
>>>               dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>>>                   q->properties.queue_id);
>>> @@ -2728,8 +2735,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>>>       /* Get the SDMA queue stats */
>>>       if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>> -        retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>>> -                            &sdma_val);
>>> +        if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
>>> +            retval = read_sdma_queue_counter(
>>> +                    (uint64_t __user *)q->properties.read_ptr,
>>> +                    &sdma_val);
>>> +        else
>>> +            retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>>> +                 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>>> +                    dqm->dev->adev, q->mqd, &sdma_val) :
>>> +                 0;
>>> +
>>>           if (retval)
>>>               dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>>>                   q->properties.queue_id);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 0be2fd04e6d0..911f974e6bf5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
>>>     struct temp_sdma_queue_list {
>>>       uint64_t __user *rptr;
>>> +    void *mqd;
>>>       uint64_t sdma_val;
>>>       unsigned int queue_id;
>>>       struct list_head list;
>>> @@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>>>             INIT_LIST_HEAD(&sdma_q->list);
>>>           sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
>>> +        sdma_q->mqd = q->mqd;
>>>           sdma_q->queue_id = q->properties.queue_id;
>>>           list_add_tail(&sdma_q->list, &sdma_q_list.list);
>>>       }
>>> @@ -193,7 +195,16 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>>>         list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>>>           val = 0;
>>> -        ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>>> +
>>> +        if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
>>> +            ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>>> +        else
>>> +            ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>>> +                  dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>>> +                    dqm->dev->adev,
>>> +                    sdma_q->mqd, &val) :
>>> +                  0;
>>> +
>>>           if (ret) {
>>>               pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>>>                    sdma_q->queue_id);
>>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>>> index ead81aeffd67..8700f8190c7c 100644
>>> --- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>>> @@ -493,6 +493,10 @@
>>>   #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
>>>   #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
>>>   #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
>>> +#define regSDMA_RLC0_UTILIZATION_LO                                    0x017c
>>> +#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX                                0
>>> +#define regSDMA_RLC0_UTILIZATION_HI                                    0x017d
>>> +#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX                                0
>>>   #define regSDMA_RLC1_RB_CNTL                                                                            0x018
>> [HK]: Formatting error. You need to use space instead of tabs, I guess.
> Sure.
>>
>>
>> 8
>>>   #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
>>>   #define regSDMA_RLC1_RB_BASE                                                                            0x0189
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> index d34c869b182f..f3220794c108 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> @@ -361,6 +361,8 @@ struct kfd2kgd_calls {
>>>                    uint32_t *ptl_state,
>>>                    enum amdgpu_ptl_fmt *fmt1,
>>>                    enum amdgpu_ptl_fmt *fmt2);
>>> +    int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
>>> +                    void *mqd, uint64_t *val);
>> [HK]: #define SDMA_QUEUES_NUM_PER_ENG    8 <-- We already hard code this value in KFD. I think #define could be avoided if you pass in number_of_sdma_queues_per_engine as a parameter.
> OK.
> 
> Regards,
> Eric
>>
>>
>>>   };
>>>     #endif    /* KGD_KFD_INTERFACE_H_INCLUDED */
>>> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
>>> index a2f81b9c38af..e0d387f08576 100644
>>> --- a/drivers/gpu/drm/amd/include/v9_structs.h
>>> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
>>> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>>>       uint32_t sdmax_rlcx_midcmd_cntl;
>>>       uint32_t reserved_42;
>>>       uint32_t reserved_43;
>>> -    uint32_t reserved_44;
>>> -    uint32_t reserved_45;
>>> +    uint32_t sdmax_rlcx_utilization_lo;
>>> +    uint32_t sdmax_rlcx_utilization_hi;
>>>       uint32_t reserved_46;
>>>       uint32_t reserved_47;
>>>       uint32_t reserved_48;
> 

