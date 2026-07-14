Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2AEC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FB410E395;
	Tue, 14 Jul 2026 09:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lV/n29a";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507EA10E044
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj+QAa5/YsQcho994L8RUPzqbH6Kw7zJH4AjBAWUDCNIOwjhAeKGzLpYtvTiuwJPekUyBlMr+wxRJxzon9gw13sHF2/gHzbJKaR9Z4NQDKLT4JMABu0KRj0phGp23zIMYRGsbYhX06q7nE5J5LSOqwfcDe/wypp0MfWjgstxPbwzpqsxF4oJA1P8cZwN6QsOmhPeafGX9femRfR6qHf7EH175/pfGyQhuGGOS2oTIl1Jn2G/M73YvlnX0IZJdmsIUObPKbKGEgajYulIR2Wuh5y8GE2v5mieKqo8tOlhr5lKM32nCgXtvomBKV5L718OhR+VbIYjZpZvAqFSzZU/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzpv6wdXWEtqTCVGtAq5ewq0dBu8FBVTYmMu7+Xr7Is=;
 b=IU0Hpgt8Tnc65rGDxsuaZRnIdLSpj9Ji7YtND5WCFcu4GD0915PfDl5EBgaIMEvGwpDMIE2MKCkRTJ9mI0q0CUqdEvfm2EF0Jw5V3y73l/JxkU4Owuwwn0MANRR2517a69QlKuO+wUzhWjpxqX15PxLy+8xVauzCSEgL/cPCWhzxJ+U0zEHJwUse/1vlvHk6Y4kvNBAHCZMafOqfWINbFcv0S1sr2EFMBp3mqZpMvHH20V7NswMuU5lQQ/sniIGhXJSH31HM/XfgrqsLEjEylXuLWV4PbsJ3+AQSWeqNU2E2s6MBDRNRFIPyYxxRJuKfZmCvSw4Jkbz656g7l5kYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzpv6wdXWEtqTCVGtAq5ewq0dBu8FBVTYmMu7+Xr7Is=;
 b=0lV/n29alyB8zvJ/qjpJVKG5BCyRExbXHmd/dX/4tXcnEZCn5+jY6AupVG/wFu2qmT7Vuq+ryfcYA34t/0Dpwh3lvM7jCEMQGTz0W9r8b0DJGysqZ8zMq4rbCJndfG3pyZMgPktgOfHIkSQgEgIX3P4x6zguK3SXtaRpPRRrXQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 09:44:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:44:32 +0000
Message-ID: <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
Date: Tue, 14 Jul 2026 15:14:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0183.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0f4f84-91da-4505-3357-08dee18c81bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FTCcuit68ZWmtOZGlEKUca/M+QlJVFEzktAOoXMsDAcGvSzkFIRY6v6VG8O4pZ1vr+bSYz1csQxSB568EF5MchrtTbEY+Xz4KNFZhL1lBfnPvplnBHV7FxCVqPC7kYM/4H4P7ki/K7BdwBsP5wS1rvy+xrxz5kxkkbtYXy7TuvGbL1VnAhe6twmU56I4H8yp6zSa+TcuOsWvTYTT8ZqGCUzGEkdj+wpgAtl2sptJM9CymLW8/+Dmtb7Ctz0w2uILptM4rmWVqi6ew3kXh/bhy/JJs/KU2nQa7x1AgYTiRRawYj+FzTK6oK7vE7MFL8Qo6ZJMKRqjyjERWhtojxa8iqVAjKPhApVNjUFt8LrZ4OlvwdhoNHkrAcv/Q/KR2DcuTW0PwX0g/mBdLy4BKN//sBPzSTL8OnsJ2ellQhkOWysrP/TpE6XetkrYvMr5QPpMpTmPjCo+7V2ggWw0WJLHhxVnv31OxbH6A78GA7kuwrjzJ3GZXFiAICAcH5dH6jAU1NatUfw3wCAqY6akvhltPSSrVPIODNE3rpXrKD5YhSKKzoYicUgrDjJRMDyU1e5TUCGj2E8OZZ4uJD0MMKcHtLpDBzMiGm5V8R4jgWZ0AO9fPPWd2zyX9omK/ZQqjj/zj58sAAk0tJgwX9NyOszpQ1umH9fpPUP+spNPrTj4/FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxVUHRHaEpGUFlJdEQ2T0NISFMrVUdOR1k1eG10VVZUbU9CZklRVXpJVkdo?=
 =?utf-8?B?UXBQeXcxZlBqTkhEc0JvT2hZR0ZmV3JvSWhUUTVrVCtQZzJpUUxDSXNrVFZ0?=
 =?utf-8?B?aHJvU1VpM1RwbUp4Y0dRUDhBNWF2Zko2V1NmcXZPdktpSVIwemhzaFNKd0lN?=
 =?utf-8?B?bzRTMFFKZFEyakJRdGhSdkcwa1czb2JjU1hmK3N0dW1CZm1WaU9UblBaRDMy?=
 =?utf-8?B?dWE0ZUZJa2VzbVNIbkhLV2EyRTUvU0ZZTk1ta0Y3Y3p3SXJzNzVWeUd2VEhx?=
 =?utf-8?B?YnRxb2VTblBZZ0Q0SlpTTFc3ZXBMNExEUzVhVW84cnBmbDRuZithdUVSakxl?=
 =?utf-8?B?djB3L1Q0MmRYUE9CSHhqajFCT1FjTCthU0ltS0o1dVI2c0RNbHVyTGc3MW1x?=
 =?utf-8?B?bkRxS3RBSXp5TGptOVJ2SUh0WnVmQ29MN2xudnNsZjhuZUJnN1NqN2VhWXdy?=
 =?utf-8?B?dk0yRWZBZzJGOUl2TWNjRHcrcnBtRzg0akZYQ1JqYlg3MEx5b2Jtb1BlbFlZ?=
 =?utf-8?B?WmFzT0N0VUdpMzNGLzdjSXlYbVo5bEdabUJISFR5bnhjWEhHMzB0YVMwZjZk?=
 =?utf-8?B?M1ExcUNFLzUzVE9INDU4QXRsVkpnaStBSk5xRjA4M1dNVlFWdG43VnN3K0JW?=
 =?utf-8?B?MDRkN2FnNDFUejI0MytDaDNUQnRPZ1plWlhnOUlyQjRQcTNQRlRiTnZ0WnRP?=
 =?utf-8?B?ejU1MlhGUjNOTGg3YmdFRmlaV0xYVkRZRWFmQVlvQVp5T1hYQ3ZTVHRMbEcv?=
 =?utf-8?B?NEl2aVdGUXN0b3cyZEVuMlNzL1hCRTZzWldubU5ESDVVbEZTdzRWRHJZUDRp?=
 =?utf-8?B?YkFpVmtnS2s4NnpaMGVqZWo0QmZxRWY0eld3UkdZWndOaHlGVlRDNmgzZFpq?=
 =?utf-8?B?MkdNWVNCWHJhRmJueVZ4UStLbjh0MWd1dVN3LzQ2RStOV2UvOU9TcmRrRFhn?=
 =?utf-8?B?QlJmVWxZK2w0ZGdKMTJHTFdMa0ZlNkRGRkdoQXBoTVdiWnBhYng1S2hnV3F2?=
 =?utf-8?B?YllDaWZwREtQM3FmRk41MHdKYUc0eGpyVHV4ZFJKeVpxeUFsR3l0U3NYSEJ0?=
 =?utf-8?B?YVJGYjJwQk9ENjUvRU1uWTJ0WWR0RVk3eTJpRnN2QzRYTXpjZ093R3grTWpj?=
 =?utf-8?B?T1hkQS9HYzEzS004RVNyMmh5a0t5NTRzOFo2NWRvMkhQbVlBOGJIN1Y0aHFl?=
 =?utf-8?B?UGN3MWd1SS9pUnQ1UlN4UGd3ckxtL1A3SnU1VGowMDFCVU45MTNuVW9QTElx?=
 =?utf-8?B?a3dDVXNxWlJlQkFHNUdtMFhyZkJVK0M3RUVERFh6bXY0UFArWkZYNVlUNnpz?=
 =?utf-8?B?N1gwSGR2aFBJK2tyMExvZnVTOCtTenJtbEIvV1ZlMjkxUGEwNGtCTjRmUld1?=
 =?utf-8?B?ekpGRk1NKzJRTzdVOEZON2QvUHA2V2hvQ2FCY3NqUjVWWFVpUVJZcUx0RjRk?=
 =?utf-8?B?VE5sLzBxeTIzWTNxZStUQ0xQa0RPQU94Y0hxdWxneW85dHdpNDFVbU5xbWIy?=
 =?utf-8?B?Z1hqbjFHOGJVQ0NZeXFKVTN3clordUU3OXFlNFM0ZTRPYWdESkg4WFJxWVhv?=
 =?utf-8?B?UTFNOEgrTExFOHh1MDM2YktPc2V4VE9vVkFmc2ErNDNVbFc4Y1JGdytZNEQw?=
 =?utf-8?B?U2c5ZjdsMEsrbFowMXJVMDlZRVVya0JSek9MR21yL0NKMVYrdktWYW56WWNt?=
 =?utf-8?B?SHZqNVozQUtuM0ljOEdjbE94UzN5N2pVdnBjbHYwNU05SlFWUGg0am1qNGJU?=
 =?utf-8?B?bzA1VlBYY3hiSUc3WUh2dTlESGV6MXhOcUZxcTdyS09PNnp4dVBvTE1nNGs5?=
 =?utf-8?B?R09mWUQ0RE5jL0JMdms0eUlNSzJic1N0QWlXblI3MVYvaGF2QTJwb3FxRTh3?=
 =?utf-8?B?TzFlbGh6VGVxais4RkFPUU9HMVc4NEV2dWVnNHdBVnhlbkNRMTk3aXFTVGNv?=
 =?utf-8?B?MHU1d1YwV1JKdHNEcmlWdEx6ZGlob2tRK3lONVdpb0sraVdTSnlJcUNUa3FG?=
 =?utf-8?B?ZFNoZzhZS3JXMmc0RkFIcjBlTGdIVXpsQmYxNXl4K3laOWJ0MjRNZThtRm1J?=
 =?utf-8?B?M2tMTittSGxlQ2JEbHRWYUJET09RVlZOY1pMMDlxT29WOHZXeTBHeVRLUThl?=
 =?utf-8?B?TE5PSGhPQU5uSkx6aEJEWGQwRVJVT0M2YmwwdnFGR3hjVXVUTi8rcmlEK1dO?=
 =?utf-8?B?UENncGNYT3diVTNzMTUyOGZmaFlwVFQ5VzlIOE43RjVwUERzcEV2SXNvWFVP?=
 =?utf-8?B?TWNOeWF5UWg4YnF0czNPZ1ZqYnh4RURML1JoaituVmZSNmxDMWI3SzBEYlM2?=
 =?utf-8?B?anJOMUl4V21ZYUw1VzNzY0s5SDlvYzJFOUsxMXB3Y05nWWlEU3hXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0f4f84-91da-4505-3357-08dee18c81bf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:44:32.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER7+ChOuC1Mu4EY9KGJpruBW73KWeodxv9BZ6tUrIvEjAvfF95Nd7P05JUsRb7w7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227
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



On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Alex Deucher <alexander.deucher@amd.com>
>> Sent: Tuesday, July 14, 2026 2:09 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
>> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>>
>> We need to increment the reset counter, force fence completion, and set the
>> wedged event when a user queue is reset.
>>
>> mes_userq_reset_queue() handles this for collateral damage, but the caller needs
>> to handle this directly for the original guilty queue.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Cc: Prike Liang <Prike.Liang@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 6aa75da27f912..5e1262636e1e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
>> work_struct *work)
>>                                                         queue, NULL, NULL);
>>                else
>>                        r = userq_funcs->reset(queue);
>> -             if (r)
>> +             if (r) {
>>                        gpu_reset = true;
>> +             } else {
>> +                     atomic_inc(&adev->gpu_reset_counter);
>> +                     amdgpu_userq_fence_driver_force_completion(queue);
>> +                     drm_dev_wedged_event(adev_to_drm(adev),
>> DRM_WEDGE_RECOVERY_NONE, NULL);
>> +             }
>>        } else {
>>                gpu_reset = true;
>>        }
> 
> After the original queue was reset successfully, it did not update gpu_reset_counter, complete its pending fences, or send the wedged event.
> mes_userq_reset_queue() already updates gpu_reset_counter, completes the pending fences, and sends the wedged event for the other affected queues,
> but skips the original queue because it has already been reset.

What is the rationale of sending multiple device wedged events on a per 
queue basis?

Thanks,
Lijo

> This patch adds the same steps for the original queue, making the reset handling consistent for both the original queue and the other affected queues.
> 
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
>> --
>> 2.55.0
> 

