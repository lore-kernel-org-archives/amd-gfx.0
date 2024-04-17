Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A92C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A1210EF9C;
	Wed, 17 Apr 2024 08:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/kgdwxX";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D0310EF9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 08:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiYtJtfHjWIKbpZLEitUxkAfspP4OrV8UW/kuggqp6itH0Nuhb3h3/GXxVlKkn/+4rsNP4e8OeYvAxFQPJ43YRQN3EeN3mU9kHdekYhnTYdRye5PbkyFfaUhLjrslKEmBctZ8r5gEcRO7EhexJIvTahzq3p6SUSRuV9VnpFMLodUycMbJGV3EHxj+bGMoFCfeJlA5Sj6zESiBRzdhMwhRJYbKi/i92B5Sd/u/vxB9C7xKWTYyZTxi3B9YPKRpWMEelsn0OhkG+SoRLdprMdgPB4C/iPKJuYYzJNbVX3kOOuT5P9OWj+qD4aX3+t0azSEJqsigDFU4OKuE7zWG8+6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1UhVC4Ww0JS8s2970FdLefobrQMlsq4NLOZScS6B+I=;
 b=ArJxs3gE3M9CQhTDDIkm3LmILMggXEkZBZX6+yEU/giWhtaFIAFDhRIN6zeMpoRc0sRtHdd4DWoOGk/KPew6GP1UF/ZHGnP/DlJWz6U44YchJjd4r4fBtazhBYs1hNEw7LHUvk9sUPBodOwQ0+DeIp7w1dB9XxM57vg7r+Ygy/uBPQLfGjQKRiI+cfVdNajG6vLTk+LGgNE3qBO1m0u5DFa+wwH0r2DxcVqDqOmBP9uL0zyc431VXlqzybst2F9ZpCEM+QyDRTrzDbhyhEH/Wb8vSasfZu3AWPTiblxdMSb+BPbGGH36C7XhBXPdKljogNK5O3tiNAA1ROPu81QxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1UhVC4Ww0JS8s2970FdLefobrQMlsq4NLOZScS6B+I=;
 b=3/kgdwxXlH+KiAemYOE7JAoK8nW6d61RXfiSUjxzYmp3yDrR3TKBxiM7gMSMgwiZopiiU+Pcitk+apxL5c36Ciyow6/xUGNoPxIMbCLeUncsEvvs4eXeIaw5UbE69fxz8XnVDaBGZk9iFl124vRwGFzVAlgQEC1hzJybq8/gLIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:24:51 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 08:24:51 +0000
Message-ID: <de4452e5-5e67-42ea-9712-db48c9bc87c2@amd.com>
Date: Wed, 17 Apr 2024 13:54:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset
 during driver reload
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
 <26c0e7b8-e0a6-495f-877d-2fe522b2249b@amd.com>
 <be82827f-93e8-4053-a301-7e6bc8fed5c5@amd.com>
 <399498b0-6674-4a81-9382-f6f3946298be@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <399498b0-6674-4a81-9382-f6f3946298be@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: faa66c09-9cc3-4db2-d76f-08dc5eb7d9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfy8nX/9pi3qFXrT2BIBoYAkUVJDrr71D32d9WetJnwA//wYoRPVMir4Ur1JER1QLLQmM4JKPZMpWrlO9c6mhaDG+hhjC7yR0/KayQzRQ/JQ7oztOHIYV0NN/+cWPNqDe3cvqSYSFVOPC4hitAiFED17X2Bcyl7x5mAr7XzAFDNZLBXSfGV6h/w+i5D1svkcCnaJIM7bVA1MWkHd1zp8dRHY7hVqFh06bHEFPcRF5twBfp4M/vWjJ5o2ht/1nGtdDx1rl9vbCupDRfRsNsSMV0Jc5dbh86tqfzZwW8lQKfNeWHUm2tU4qOshCfNtvzSwbBoZ6oeem0V3cfXIlLjXXUI1bUlYLSwBdjubCQlmwx7P5Vtxg13pI+o2wRuU0nWUAiT6R7hqJez81B6bn2BaHUkQjPVf6pzWiS6twMenCERMz/VrYIAIcyZoC+yeQL8LlPupUIlYBz6RDaw1Eh8dXBYpDmOpEHL2htJLl/jeN0LgzPv8rdWWyUcUM7wsae+3Ip8JpFPaQdn/ldOXq2ZbQr23noC8+fD0vAD6TthgCeTZfiZv/aM4og7xRwiRO/7NmuNAGNQh5g3DgvVoJIQeEGyvBBH58xnt5CkBBeYFWFgF7iOXuXO1R3mMn/LG5a2Zs0UQ0bgWPyTRqAWE14/V6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti9URHpWbWpFbWt6SERxa3o3NWpWNjI2ZXIzVTZEdzIrV1JIV3gzYno5VXBF?=
 =?utf-8?B?N016TXN1cmlNUmpsMmZIODd6OGJTMkF0amhWVTFoaUlwdGsxaVZrS2w2dkdC?=
 =?utf-8?B?MnFKOHJKcE9NZU10OWt2R0N0bVFzb2Q0ZnFsZmR6eVRVVUZnTDcrQkZaeVBU?=
 =?utf-8?B?Q2V4T1hnSFg3NCsyckxMSXNRUzNLdSszcTVlRTF4UXhBNGJtY3YwWEFFNFk0?=
 =?utf-8?B?MXl2QUNVeEFyNXFZUFFiamhuYkQ2WExyQ3hIdkJFUzBFU1BHZzNJb2VDLy9D?=
 =?utf-8?B?YVpHaFdJWEt0eTJGOUc5eGxHc3pJY0Z6WlJGRWtxYktIVFRoSmlCWktBbmlQ?=
 =?utf-8?B?YzYxQWtSbDRPRkhYRGYwdm05MDEzcGVleFplb1lpWVM2OUpZK2NLR2xNY1FJ?=
 =?utf-8?B?OUlCUlRYWno4eXArRXRQY0VIZjBEQXR5VjFvVTFLa3I4M1pPUmdnTDFaR2hx?=
 =?utf-8?B?eEZOTUtZdy9lbGNDSkJLWTRJYjBQNmVFK05BemxMMUVYRisvb2NUempqa1Iw?=
 =?utf-8?B?dnV0eXRwZFk3cG5mRU9FakIxSzZtbDMwRGNPSGplSnlOZEc0Q05yOGZlRU9p?=
 =?utf-8?B?L2ZObmNHU3NYRDVheitpZHFhMjA2eE92OERNMmtNclFWMXN0UFh5ejA2S01U?=
 =?utf-8?B?RFZCVW0ydHd1Z1pXUmZoY1psWEdQRlY2cW43Q3FGdk8xME0yaDNENlJGU3hw?=
 =?utf-8?B?Q3A5OHE5OHBUanBDUmhBc3hhZlZiYjJQb0tNcXo4blF1aDRxVS8yQnBjTWxF?=
 =?utf-8?B?dDNOeHFPUjlVY0kxa1JnRXdWZlN0Rmp0c3pKZG4rdnFEQUNROEJFbDE4NTdW?=
 =?utf-8?B?UEx1KzM5b2hrY09OM2tzNFZqSmdDeXkwUlJMdUJtcko4RTJHZjc5dWdzMndM?=
 =?utf-8?B?dEcxakpXR0l0c0xqZUJGUEp3SzN5RWxTZnUrUGIvMzVXdEgxaXF3MDgzN0cv?=
 =?utf-8?B?eGlhNUFGRTZLZFVPZWpZMlhRT25xckxsKzlNUjNjWUx5ODVFR1NIZkprQXJB?=
 =?utf-8?B?MWhMakZOcGllRGVlME1DV1ZVNm1MMC90SXc5dUtYYmNPT0VHZmRtMksxV3pw?=
 =?utf-8?B?RHQ4cUFZWDZsQmdyVENYbEUwa3dmR1lUWTNKdCtoZGlQdW9VR3hXRFVrRTVR?=
 =?utf-8?B?S2loWjA2a1NsRjFwVE44Qno5dEFkWmF3c2ZDeHJFa2hlWHgxdlZlaW50ejRO?=
 =?utf-8?B?bjgrbHFkZ3lXMkhFVCtwQlRMYnVNKzluOXVEZVBvOEh6RTlGZnJveDhrbFB1?=
 =?utf-8?B?dkpNSkp0NlJUWGhuUWJHRTBaWTNkQTh5bko3Z2VoZVBNUHlKdWNoOUVoNnNS?=
 =?utf-8?B?VDkvVURiQVdDQm1mSUMrUEdlblVwdkJPKzdXanJWZnpXRlpZdjNEelpDU1o3?=
 =?utf-8?B?MDZSWUdjakY5REV5L0FtR1NtOWxONnRRbGFRdC92K1Z6bFZNM3FiQkRoTDlT?=
 =?utf-8?B?WHVOdmFHWnVFN2NWQ0tpRVc4elQwdkI3b0VoVTN2MW5YdWlaZW5PdWNJdTB5?=
 =?utf-8?B?bzh4SldvTzhrWVYxOWoyWjBLd0dhY2ZJSzhHUW1ldXdReVgydnYxUGR5S1lz?=
 =?utf-8?B?RGQrQnRyZ0ZINDJiOEljUG56Y09LSnFVOXd4dksxVW8zUUNxdTJRLzJyRmhD?=
 =?utf-8?B?MkN0NUg1aG5iWitVZThyckY0SjZwKzlBbjdZZ0xwRlZDc1R3QzhaaEIzZXh0?=
 =?utf-8?B?bW9xVnVSUVA5WlZTVXYvVnRDMVpuWG1QaXl6RnNKVWtrTTRjVmVNQzluV2V2?=
 =?utf-8?B?UTQwb1NxZXpKUmdpWEFZaDdGSmRWeUV1eUNaQnkxR1FKOU9Wa3RJa1M0dzho?=
 =?utf-8?B?RWVzY01KQjR2dXZhZXRyakQ5bG4vc0Z2WmNnMEZpVTFYQWVRd3ZFOVp1cHF5?=
 =?utf-8?B?U3RMVHBqSzJZQzAwWlhkM2JpZnhxYnZwUkVCZElIbENGZlovcVFNL2dzVzV6?=
 =?utf-8?B?OUlFYUJnS0FlekVqNFhZSER0SllPTnQ0WnVwUnpneS9mYnpiaXhUNGY0bURm?=
 =?utf-8?B?TGkwbnNEZWV6WDNsVFRyNVM1MW9sQWgwYmk1ZVc0M1hyZCs2ZCtxWEtSNkZN?=
 =?utf-8?B?bG5hMnB6SC9LV2VVYmpTcHBuKzVMOTdLV0grdytXaERhZGpab0w0QXRIWHlR?=
 =?utf-8?Q?vRMaHAM9lFDsnVPHJF16SU99O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa66c09-9cc3-4db2-d76f-08dc5eb7d9d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:24:50.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/jphXw6lbekJQzG6SGNtFa2NI8OEmOPIf2nLXRnV7yuRFjQS9wbYny7XrAxOafOk0OtQ20iOkp3gbajPvs6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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


On 4/17/2024 1:19 PM, Lazar, Lijo wrote:
>
> On 4/17/2024 1:14 PM, Khatri, Sunil wrote:
>> On 4/17/2024 1:06 PM, Khatri, Sunil wrote:
>>> devcoredump is used to debug gpu hangs/resets. So in normal process
>>> when there is a hang due to ring timeout or page fault we are doing a
>>> hard reset as soft reset fail in those cases. How are we making sure
>>> that the devcoredump is triggered in those cases and captured?
>>>
>>> Regards
>>> Sunil Khatri
>>>
>>> On 4/17/2024 9:43 AM, Ahmad Rehman wrote:
>>>> In passthrough environment, the driver triggers the mode-1 reset on
>>>> reload. The reset causes the core dump collection which is delayed task
>>>> and prevents driver from unloading until it is completed. Since we do
>>>> not need to collect data on "reset on reload" case, we can skip core
>>>> dump collection.
>>>>
>>>> v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.
>>>>
>>>> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>>>>    3 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 1b2e177bc2d6..c718982cffa8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head
>>>> *device_list_handle,
>>>>        /* Try reset handler method first */
>>>>        tmp_adev = list_first_entry(device_list_handle, struct
>>>> amdgpu_device,
>>>>                        reset_list);
>>>> -    amdgpu_reset_reg_dumps(tmp_adev);
>>>> +
>>>> +    if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
>>>> +        amdgpu_reset_reg_dumps(tmp_adev);
>>>>          reset_context->reset_device_list = device_list_handle;
>>>>        r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>> @@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head
>>>> *device_list_handle,
>>>>                      vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>>>    -                amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>>>> +                if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>> &reset_context->flags))
>>>> +                    amdgpu_coredump(tmp_adev, vram_lost,
>>>> reset_context);
>>>>                      if (vram_lost) {
>>>>                        DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 6ea893ad9a36..c512f70b8272 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2481,6 +2481,7 @@ static void
>>>> amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>>>>          /* Use a common context, just need to make sure full reset is
>>>> done */
>>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>> +    set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>> If this is used for guests only can we better have a flag like
>> amdgpu_sriov_vf  for setting the skip coredump flag ??
>>
> A reset is not always triggered just because of hang. There are other
> cases like we want to do a reset after a suspend/resume cycle so that
> the device starts from a clean state. Those are intentionally triggered
> by driver. Also, there are case like RAS errors where we reset and that
> also really doesn't need a core dump. In all such cases, this flag is
> required, and this is one such case (this patch only addresses passthrough).


Thanks Lijo
Able to verify that in normal hangs dump is working.

Regards
Sunil

>
> Thanks,
> Lijo
>
>> Regards
>> Sunil khatri
>>
>>>>        r = amdgpu_do_asic_reset(&device_list, &reset_context);
>>>>          if (r) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> index 66125d43cf21..b11d190ece53 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>>>>          AMDGPU_NEED_FULL_RESET = 0,
>>>>        AMDGPU_SKIP_HW_RESET = 1,
>>>> +    AMDGPU_SKIP_COREDUMP = 2,
>>>>    };
>>>>      struct amdgpu_reset_context {
