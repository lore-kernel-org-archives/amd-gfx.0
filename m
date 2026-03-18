Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60474FCD0CC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 08:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D0210E738;
	Wed, 18 Mar 2026 08:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WUdhYHd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F98710E738
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 08:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsa/4qx0VnLfzVafpbib1wWrlp+uMe/vM46jDQ49Z9/FjxOJDtwDzFGzMNYjXzzf8uHe6E6s0TmVKVmE3Ab2e9WJH15D359tkyEVF3EvoPnGO2KlNcK7hGiIJ0kpJBq2UEuUFhVxCjMaEc7MapQHwtCAHYc5ecKYqZnqpxjqvOvbwCFhzg1G9GqAFR/gRoKRpQlv+9gvSh9r1NgIk4II1IkMoC6sr6ZsYzX0dTtFQ1ol4/wA9ZU+08urseNdsEeJOYZXZ99o0PQzBsTRYwF1y9zFxrhxY4xg7LG+wzgpcRct1mq5AdXwQS4BlkE0LRgTkaJ+9hXOIGPaRxqb9OqKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYdSIm7BERam4Vyfk/ZGVcDXczBRlypC7oOyTaKwgC0=;
 b=WUb1HcNlHtz3OznpjmYx6/dRBOf7TvNuDWcvfNIizrq4yN449Ob4+1gxYyh6vCOAbadZkZHTX3Wh8I4rgMC3r8AUZCx73pcSPHJp7HhaXvEdEwPP+u4V6+l1pmC60n2MnVzeJnU+zvkuatSC/sB9YGXakghByqiwFMAvlibToTJSUVwppJXn/eAxhnT5SanOnnwXypSNbMEEiLuwDdF2DhD7GLYeV/LVoAClzUK+pzJxFH8JtMIwTS/2egRxgSdB7hRwpXlIV1MzY6MgUS3JjiWJbTVlXaVJsutnH0RpbPGboP4uF8UkPSqIug6EdDl9ufaLYtnV6IfVGs8FDO0mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYdSIm7BERam4Vyfk/ZGVcDXczBRlypC7oOyTaKwgC0=;
 b=5WUdhYHdEPFQkgG4R/qf/add1I5KSW1iRikmn4a2f3ubB67e0F9ahhF1ZuhYzJpEuCQf0lMHWYuWtpeuxc3MJNZRmB5xRKXxeaoY2kUCzk6UowGQCqcZqpsJcsLRfsIwbqmWWgUfV90G1u81yYSp8g9CLaHjwRgNb39r6LgWM+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:22:20 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 08:22:20 +0000
Message-ID: <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
Date: Wed, 18 Mar 2026 13:52:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 069755b0-2424-4a64-9392-08de84c77950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XLKwpFPIdKdsbCx4q1Ue1lrl1WUlfWoNXaXCFDjwxrqq1rCKaAA5YRGuaMrFE0FEcS1xlLw+W4Q2/0WB1hNkJwGZC6EAkpiWiC4dNUxLcgCkHo65HjAyQ4+u4H9l04yFF+/NLIAdxACXhJ3RrhawQ6MXXok0nZooWkzrUisZ04J3BE2RFBzxNVTkCsb691gJCVhnWrZ5LLt3mnXUrgg3S15V1PVqzhWvL6rPC3gu76ONLQN5lRpKy7mJ1weNQwX7J9V68r+0K6uNt25/9eUo8spokGlv3+6ce8Y6RL4TYp9Hbgol9syXeDtDvdRAtEAzyG/vBwOVvYsDWrhtEEay4C2qRp9Pt/IsZAwzvFndOM2H5qgxVWhhQ1trrUp68wMp/aG2JQlblDEju+pIXAE65rKizgEjtal2gnF2mQt1e6NcMd1gRFPSfLH7P8/0UqFmhsJDStV/VOwuQCTdoSBLOVvJAoXIBQnyJ+2FUpcd7o6qKRsaT39oUD+728WxeCLGfGieT9TfvbGX24JM4zXgaqKBl1PabJDR1L803xJpzcrcn1ZUehHr+WUOJQ4nYAx6wYJ2LOB3AchrvARpYg23l171VelzR7HAxFLJMg1v5Ge/n1O6awD4tXArod0YZv7MHJuxYyQbWhC9lbUA6n3pn398RdGLkYRGGiIhBDFcXLFnbfGgvPE9+vkRTDqFbfNrDTPDZbtogs/sMG1/f+HAOxh4eYYpd50EQjoxJs29yfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09nWTJjQXNNSUUrSWNWRlJ4eUZ4RTFzako2UHVsYkNiZUQ0bWxKNHhCQXhh?=
 =?utf-8?B?ZUJIb24wQTVTRkI3b3BpMkpoYnhOUUwyYzZQTHNMM3ZpOVhJaEZCdWNBT2gr?=
 =?utf-8?B?cGowaUhORVdCYVhPYW0vQnEzNkJaeG9ROXhwZGlNZklKMTVXMVJMOGMxd0dX?=
 =?utf-8?B?TnBIcTJKNmR1Wk1EaXJOeW9mL254ZVQrT2lHMGlPc2NHcjFnbXo4b2M2dUFB?=
 =?utf-8?B?ZlRyOXc3dXQ3dU1PckJVOE01VklGS0xJQ3RxcWlOcy9idXVGWXFPRUlBSjdu?=
 =?utf-8?B?Yzd3SzZNdzdkeWtwWUg3d1oxeFdMcXh6dk1zL2g5VzIxMnl0MVRTeEpnT1Ba?=
 =?utf-8?B?M20wVDdFcXg2S0h6ZndvajdRUmpuODNoejJNelFXRFBMOEFxQ1B1Nmx3ek1Z?=
 =?utf-8?B?MSt5UDR5Q2hoTzhTcWRRNE9icGxpOFdRNjhqenA0Z1pXU2xLM0NWeHhodHIx?=
 =?utf-8?B?RlVKVVBHK2RMQms1bytYRDRXS0xHWmFDNXFvdVVjUFFFVENiT2gyL0wwUWYy?=
 =?utf-8?B?MjIzSS8xZWhBRkdraGxmM2JIWFQ5RTZ5WExYeXJudkpWbUZObVZCeUdkVE9x?=
 =?utf-8?B?SHBiZFNKUUR4cEp2WGNaTzFjdnBac0xUaFk2RitJc0ltM3VRcEYxUGlKajE4?=
 =?utf-8?B?eFlaOE03S2h0QW5zRGZCQXYyQVZmYlBLOFJ2WTFZTHpsM0VZbTBQa29vbGpP?=
 =?utf-8?B?YzZYeUh3ZE0zcVBzWWYyNEZqc3ZnS1poMmpWeVptd0RBUDF5NktnT2dXYXNu?=
 =?utf-8?B?VVRvRS9kR0hHRVVEdFpWUWhaME5qaDJqYUdTNjRBbkNXdFdFd08yTm50Sllq?=
 =?utf-8?B?WUdJTzJOdnpocmxaSUEwS0xvRk5pK2VXVHZzV1lRa0I3S3R5VS9nOCtrQ1Ra?=
 =?utf-8?B?ZnZtOHJ0NHplVHhEU3JQakZ6QjJReGVFMi9sSGdtQThiK1NnWC9yYkttbTNr?=
 =?utf-8?B?aFljNWF1S0J6dkNRQ2U2eHBadk5vaGxaZGFhbkFyTnJqNGg1eXUvU1NFd05a?=
 =?utf-8?B?ditZclR6TFdFSExjVHNwaTllaTN6VU1KSWE0SGdmT3JqekFQSlpmdGFBOXRY?=
 =?utf-8?B?WGZETnRPRjl0V3dHSVVtcWlVU3Y1U1gwZ3I0MmwzZHlUUGFrUFFtK1dYUkxy?=
 =?utf-8?B?Vm03cStxNWVnNWJ0SWhEUWNCeTdNMEpucnFhaXNsYW1BekxIMUxyRkkyTjhJ?=
 =?utf-8?B?bVFEZnYyVkZjbHZrVlVpTGdoQ3orQms3OXF4bjhZV1hrVzdTUE0rM0tGOERm?=
 =?utf-8?B?ZE1GUlFvM283TVNGKzN2TXhCYWJUeXQ5NnBiQXB5T0R5THM0OWV6RDZOcFZz?=
 =?utf-8?B?OWo0by9scVBiRVBSMHZmeERwUXByeHlCQzJiTER4bUo4OFhoZ1ltaDl2VnZK?=
 =?utf-8?B?T1RWT0Z5L2tXeC9sdnY3ZWl0NVRzWUlLcTdIaFJKdm5lRXBBMjhONGN3SzQ2?=
 =?utf-8?B?MzI4NGlyQTBad2dha3M4M0IyTjViazllanBrRE9Ocmw3SmJCbytVNldhRTJk?=
 =?utf-8?B?ckljQlNCNkMzbU01RXhOOFJud1IrbEFjOXpmZ1djaFNtNjM2SDJVb0paeDhL?=
 =?utf-8?B?WWFLUndJMGtSdlVmR1c3eHlqSXd3OTBFKzJhVDN1aVF4Ym10LzJHT0p1VFla?=
 =?utf-8?B?TmtobnhZWU9pR2pHcnJPT3lzL3F1cXEyb1dxV3BEYUZXUVBPNVhtYjgrME5N?=
 =?utf-8?B?d1AvNm4zZkQ2VTh4OWJVUmpyZ1Naa0VLZVJ3VVNIblJrUmlWN2FNWTY1QnVi?=
 =?utf-8?B?ZzZoQTI3UHBKTjBiVFNiSGhVeEg5K2g5WWI4WUFvS2ozdHVSU1RiVnd6TEpY?=
 =?utf-8?B?dHErWDV1bHlJdC9PTTMvYmJSTC9tVkkxM1Jyd1BnVjdlbEhnTm9TNnpXdWQz?=
 =?utf-8?B?QXNJbm5qZUtkNFpJUmZqUXo2eEJEeWhoUEROTGs3bld3aW9sNHU0NndlaVVh?=
 =?utf-8?B?YUx3OElOSEFqOHBzRjFjdDFvVHdRNlc5b3R6U2QxMWpHRGVDNDg1bUhzaGM5?=
 =?utf-8?B?eUhhVElkVStnV2w5azhFTHRkRmpzaWxEdlI4U1VGbExFQ3FOREVsRkk5WDNT?=
 =?utf-8?B?NkEwUFVnZHQ3cnNkNEhyUUZ6WVhLbDlOMjRBZGprY25GWi9WZ0NQZUxQUG9B?=
 =?utf-8?B?TVpXbHFaRHJqSFN4QXVJajNZWmQwdnR0MzA4eHFnT1Btc2hzQmh6ZUtpdlJi?=
 =?utf-8?B?UnFuK0liU0dHTkllWUpBZlB4YUlmK01DOEtweW9vNVdJRzRCRTNtY3cyVTlX?=
 =?utf-8?B?cVFwOGlZTGZIRHBuRWZDYjd4aElPNHJFQVJObStBOU9QbVc1V0RNbW5ONzgw?=
 =?utf-8?B?RHprNzJsVXVwL0poUlBBUjNaODd3ODJiZHgxSjVkUStraFdweE5IQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069755b0-2424-4a64-9392-08de84c77950
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:22:20.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AhwNILx0wdiMUbYraKWWI2kQ6n2X3UqFuPmVPnyP4pQbGHpaokDR009rN/6pFv1amCHTCc/QtZajXcZVd37ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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


On 18-03-2026 01:29 pm, Christian König wrote:
>
> On 3/18/26 08:47, Sunil Khatri wrote:
>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
>>
>> The patch has caused regression for userqueues where user is stuck
>> and is waiting for fences and a gpu reset is triggered in kernel.
>> Also for any of the parameters when count is zero, the driver does
>> not read from the pointer and having that check is overkill.
>>
>> Application:
>> MESA: error: amdgpu: getting wait num_fences failed
>> MESA: error: amdgpu: getting wait fences failed
>> MESA: error: amdgpu: getting wait num_fences failed
>> MESA: error: amdgpu: getting wait fences failed
>>
>> Dmesg:
>> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
>> [  122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
>> [  124.687518] amdgpu 0000:0a:00.0: Dumping IP State
>> [  124.688351] amdgpu 0000:0a:00.0: Dumping IP State Completed
>> [  124.688355] amdgpu 0000:0a:00.0: [drm] AMDGPU device coredump file has been created
>> [  124.688357] amdgpu 0000:0a:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
>> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout, signaled seq=569, emitted seq=571
>> [  124.688366] amdgpu 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid 3479
>> [  124.688369] amdgpu 0000:0a:00.0: Starting gfx_0.0.0 ring reset
>> [  126.560451] amdgpu 0000:0a:00.0: MES(0) failed to respond to msg=RESET
>> [  126.560456] amdgpu 0000:0a:00.0: failed to detect and reset
>> [  126.560460] amdgpu 0000:0a:00.0: Failed to detect and reset queues, err (-110)
>> [  128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed
>> [  128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1
>> [  128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled, skipping HW reset
>> [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
>> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but recovered through reset
>> [  128.804574] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  6
>> [  128.816663] amdgpu 0000:0a:00.0: Dumping IP State
>> [  128.817458] amdgpu 0000:0a:00.0: Dumping IP State Completed
>> [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed to respond to msg=REMOVE_QUEUE
>> [  130.963949] amdgpu 0000:0a:00.0: failed to unmap legacy queue
>>
>> Cc: Jesse Zhang <jesse.zhang@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 -------------------
>>   1 file changed, 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 3fcd70a38374..0d9a13081f2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>   		return -EINVAL;
>>   
>> -	/* Reject non-NULL pointers paired with a zero count. */
>> -	if (!args->num_syncobj_handles && args->syncobj_handles)
>> -		return -EINVAL;
>> -
>> -	if (!args->num_bo_read_handles && args->bo_read_handles)
>> -		return -EINVAL;
>> -
>> -	if (!args->num_bo_write_handles && args->bo_write_handles)
>> -		return -EINVAL;
>> -
>>   	num_syncobj_handles = args->num_syncobj_handles;
>>   	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>   					    num_syncobj_handles, sizeof(u32));
>> @@ -950,25 +940,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>   		return -EINVAL;
>>   
>> -	/* Reject non-NULL pointers paired with a zero count: the pointer
>> -	 * is meaningless and indicates inconsistent input from userspace.
>> -	 */
>> -	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
>> -		return -EINVAL;
>> -
>> -	if (!wait_info->num_syncobj_timeline_handles &&
>> -	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
>> -		return -EINVAL;
>> -
>> -	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
>> -		return -EINVAL;
>> -
>> -	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
>> -		return -EINVAL;
>> -
>> -	if (!wait_info->num_fences && wait_info->out_fences)
>> -		return -EINVAL;
>> -
> Mhm, in general such checks look valid to me.
>
> My educated guess is that userspace sets num_fences = 0 to query if it needs to resize the pointer out_fences or not.
>
> If you have time please double check which check fails here.

Sure, i will check on that but for now i have pushed this revert.

regards

sunil khatri

>
> Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
>>   	num_syncobj = wait_info->num_syncobj_handles;
>>   	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>>   	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
