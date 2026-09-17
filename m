Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C989C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 22:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB24910E055;
	Thu, 17 Sep 2026 22:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3JghO0Y";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D65610E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 22:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZdTIe2d1V32PWLcmohA1/pta2q6167+h0EE87O3P0O1VvJlnZb9+wQJySN+A5jZVl9sJE2yVuHTAkVrLizZsERmBKdjr3cDqLuQI1HDoXsn5R5fLPT5uvRFyBRMq1+X5VYY0SKbUd7C3lQoKHEJ/BMwJSOaetB9VavBOEr387snFcgxeOCRwT7E4CJSsjMHyoKjUE+K4QZyoFYPvYQsYIcv0bn0NA3MTTxbNSUiHhenVy5JoXfIA6GCTId4uRPYwMTgALwlBScYEpd+m/kRC3g2xpTik+94Yf7E1zUntXCMLrci7VxIlzyJXBO1Z9ByHqpRCn/Xn6gqfcBbr8QVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/wBPb15EfUSM+PB4DKXMqMPEE2ftV51Mlp51OwLDBM=;
 b=Ksy31G/GPnkV+wMp1hhbqx4jPo3gg2LBprHUTKtVVGYJU54AsZQkt3RDmTDlv49btLEprtc+2Gsz8pGxygswgDvj2BN1tkVPA+n2mFANqw91tLbymH6Fv6amLELqap7DXwN+IR4Twb5OOiWBXKwlB5FGBtmjT7J9Gx9PIBVd05qlyLyO/PX2yLghL+DQqZiXGo5JlTRcfbtSUn+asrgf2EHSJxo6c0cb2i1nPVJ8upqWkyeLGZz0feqT5kmrvnVJ6BBBhVmD+xPEUt1XUzqTP4zkCt92YgwN0t6pi4QLGoAe9nz084iPr0dfawah3jcDu96OkQMwM78sbRGgd/5jrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/wBPb15EfUSM+PB4DKXMqMPEE2ftV51Mlp51OwLDBM=;
 b=E3JghO0Ysc2Bu0GlsKOBQyhiMgdTO1UOsXKJfbHL7e5IxnEVr1FAA6oH3AW/RtUzylhwHMb+AmLxl4bfietO6PedIZ09HD/gnVApifzjqoDkdyk3VPoXlaqCKlYeSllbr9OPOCn90h0cdL/9QGNBTc+GsjfX5Ut4NJavEwLctps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 22:06:48 +0000
Received: from PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41]) by PH0PR12MB5607.namprd12.prod.outlook.com
 ([fe80::26e0:df91:f91:c41%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 22:06:48 +0000
Message-ID: <278e2182-a840-4cb1-8e17-ad4495441f1f@amd.com>
Date: Thu, 17 Sep 2026 23:06:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to the gfx12
 trap handler
To: Siwei He <siwei.he@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jay.Cornwall@amd.com, Jonathan.Kim@amd.com, Vladimir.Indic@amd.com
References: <20260814135720.3575351-1-siwei.he@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260814135720.3575351-1-siwei.he@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To PH0PR12MB5607.namprd12.prod.outlook.com
 (2603:10b6:510:142::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5607:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbe4d39-0684-4118-7479-08df1507f80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|6133799003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: oavNfXd9nhGlw9CwzuzzlZaDZTHSMIwmpyqo8kCwu20hSynGxNKhpOZUsHzImh1c4Jp/gtEJG7q5ABEOzO7dYKQGcfoVcGi1wKbE41SvTYIsGw1K3rURklOnx1op2m1I6fmc8ABJSj7S3kFUtkVS7XFilFyUk2qglgmoW/06x5qRu0Q5+eWmRmGXemxZ5IWFr8hWNEgzaYpNdpVjl07UPWtah73lRa6j2yJ2anQF/g13ao8GwKYSe7BXptxQONKalSBEvzAEkfkQR7AbEpH7mXkVZXOQz5tCBsMvey1k+3hm38NJ0wPw57iFuPMOC6dK5zkjFCnXwuvpnNYXUv8s30zt1NoehXhGUiTY+g/H9IFByp/j3+Q760Q9r+1pe1PgRj6UTSRJX+dloJNj3y+qGpUChvl7LORsOOF2/nnewPWrdtkS0WjH0g74o9xLNLMT3xziCqSgwfjc4Nwt7dITbSY2uVne+SUKZRAENNqM2m7Iuxg0utUH3UmWxcjeS61PiBXd+3Ctx56QP/zrrTDtBZY9If1hMS1M10o6+G1gt5YIyNcunLsyZplCOLKC7pI2ev358tUpZsR6+TrxGdGVKlrm9pkgFW82i7NpdhgQozL98tQEJOZTucdyHQq2xdQGpctO1xmFRvaWawXAq4FCg0rah3mdd2CrungRG43GNE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5607.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRGSGlCemt4NW9HcVpuVUlVSmtvaDNJYzBhbDk3d2F5YTNJL210Vkh3VlBw?=
 =?utf-8?B?blFWY1lUOEV4Y0x5Z3EvaDVFWWtJWGVEV01OejFWdHkzZUNZbVBQcnJaYk81?=
 =?utf-8?B?SzAxSWxyZEV6UzFPbXRpS3RmOXlBQVZuamgwbUVBRFA2dXNsOERCbnZSWURu?=
 =?utf-8?B?c2krcjhNZUNkTjJlVnVEWkRycGpMdGF5Tk1vck1PQXl1TE96dUdoUllxNVN4?=
 =?utf-8?B?MVc5Y3ZCcXFLMWNndEtvZkNaclF6YUxhS3dVREZuS2N6dHZmMTQ2bHBDUmxH?=
 =?utf-8?B?LzVqQi8vL2RtL2N0VEpDckxBT0JCT24vNWhyNFRRTHl4SmpHQVBGT3lCUjV2?=
 =?utf-8?B?MGxIbVNlMGFUY1dkVy9CWm1uUzIxSHMyd2JSc1JRWFFaOVh6SjNNazA5VDlJ?=
 =?utf-8?B?eGFWZkR3b2Iya1M3QU1XK3V4aXM4NGhscEdaV2hhS2x5dnc5NXUraEZjeVEx?=
 =?utf-8?B?dFFoNlRwM1hZUHEyL2NleDV6VEtscW81QythQVNTY0VXUnZWbDhycVFMR0V4?=
 =?utf-8?B?cHNFNkVFR3J6YzBhMHRJMzhDOUlXNDhDSmJPaml1SC9Za21zL1lCM1lpeWw5?=
 =?utf-8?B?RFRSQzhkRzZFdjMxbGNBenNOSnZNNWJza1NQbFhlK0VIeVpJVjVxM2twTEo4?=
 =?utf-8?B?RmtXVkljeit0WDR3L1EyRkp5bG0rNHRFUnUwT1dqejRhUnNjTEQ5YzZwYkRD?=
 =?utf-8?B?VHJFejlqcFdBQ1dxbkJodTNReTM5dG12S09xOVI3SXcraXNTNFlJZkFic1VL?=
 =?utf-8?B?ME90THFZY3NwbzhGaVJ2MDAvZnlhem5yVXBLTmdSajNndzhud09ZWEdURHZJ?=
 =?utf-8?B?TUZMM1gwRFJNQVhNT2w0L2x6VG84UHNxSTNlZDJsSHdCZnlucjVyRE16Z1h5?=
 =?utf-8?B?dWZBNittY2VlWTQwaXJrVVFxUHB2b0plOXNPanpwOHl1T0R2dHhKejcyOWdO?=
 =?utf-8?B?VmtKb0ROaHVwOUlYS2F2cHNWZDFXMi9aaDB3R1lQdEZZSXROelFUcjJIT0pu?=
 =?utf-8?B?M2Z0RDBBb29Ncm8vekpRQmpsTlpJaHJFR1hudnFhUGh3L1RiQi93d0g3YTlq?=
 =?utf-8?B?bHYvOG84b21BWjZiOHFEYngybVBRdWdsYlJxY0hNbzJQbldBSE8wK0pkWVRR?=
 =?utf-8?B?UHNkamIyVGpKZXRJM0JzZ1FROE9xZ3NLNU52UWJFVGVsTENGRW5VQmE4elZW?=
 =?utf-8?B?djlnbHh0K2dyb3czWTNhYWRDbUNWaW1UY0VsQ2t0SUVmaC91QzVpQmpSNnZF?=
 =?utf-8?B?NUdQSWE1eDFjV2Z5b2o5aW5ZYmZRVGZyd0Q4WnFZaUNvejc4aU5WTE5rNENL?=
 =?utf-8?B?RlpYb2NKQjdzSUR3Y3p5QlBLRnJBemVjOEgvSU9pNWc3THNseWl6ZVRHZm9C?=
 =?utf-8?B?cUVFU3pDRkdHbC9zdHhINmsreUxGek13MERMV0RjbFhwVE00Y3RXSG00OHZE?=
 =?utf-8?B?OEZKR0xWK2ZsRGtTWk1SbnJ5dkxLVUlsWnM1SGQyYm9NRW9DYUJjTVR0akRH?=
 =?utf-8?B?TUpvdUdheEdWSTVEV3BVdDMwZ0F1cDFRUWNWdDEwcnkrRTZEeHNBRTFjdkN5?=
 =?utf-8?B?MVlmYTFPRjQwaUdtVHZlUDRWQTNsOUdaKy9CWkcvQ2dwQXNmS202RzZXeXhw?=
 =?utf-8?B?cXBsU2tueVFwSGNFNkZkT1psbDNFeENiSitaQ3I5Vk5uOFplMCt2ZGhtZTI5?=
 =?utf-8?B?bUduT0ZZZzhCYXh6UFpJeElROHJnM0NJN1hKTzQ5Z01Jc3NXN1NrdVhKK0Ju?=
 =?utf-8?B?Y3FPU1BLK3JXRExKclc2Z1RBditSaTk5OWVvdmlVN3ZENm8wdGNlek5rT1h5?=
 =?utf-8?B?THpTKzdBMkRrSHcxaVhxSUlESFk2RURMc3pPc3VIYlpaT1dBK1hhVzZ0enIr?=
 =?utf-8?B?MHhXUy9Jc2piRUliT0VzWm91dWdNOGY3a3ZEMVVGaTdiVXhKWGZ3aTNEeDBj?=
 =?utf-8?B?YkMvd2hrRDJKbG9RUzIzai9xWjVWS2ZQRi9nNERKbWFRMWxUbFZVSEhvd2s5?=
 =?utf-8?B?eWFNR0ZCNGFYVXJlZ2FGc0I5aUpjZXA5SmZWUkhDdE9Bb3d4Z0cydVdtUzJp?=
 =?utf-8?B?UElSRWVDNDBFaXZOa1doMjFVUDZpcXZTYWxkSCtvbHBZYlBUUHJueWhXMVcr?=
 =?utf-8?B?Vlpya2U1U01OQmJwSk1FdGQwbEVDV1VpYllRcktHVFJmdi9LZEU4cSt5eGVB?=
 =?utf-8?B?ZDlvSzd6SmVQQm1EUGkvUHdLNjNKVkd3SmZjSERlOGJ2NDJBQnEwc2NUSHhx?=
 =?utf-8?B?S1ZoM09td2VUQWlBQS9CL0hQV1VTNlJ6YVp4dWw2TzRxNTFhekNPV21uNmVN?=
 =?utf-8?Q?RnwxzSsTL9RnudXAb4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbe4d39-0684-4118-7479-08df1507f80f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 22:06:48.5506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KLuB8slsNkmIzqw5On4fjTQjpLKaIclogW16JUqoh7YSR2rXNBbivrE7p45wj8lGCrU0dayGFcmPqEhY3TMaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
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

Hi Siwei,

Thanks for working on this.

Comments included inline.

On 14/08/2026 14:57, Siwei He wrote:
> A gfx12 wave using dynamic VGPRs is launched with a fixed 16-VGPR block
> and allocates the rest from a shared pool with s_alloc_vgpr.
>   - the fixed block (WAVE_MIN_NUM_DVGPRS, 16 VGPRs) continues to go to
>     the CWSR buffer;
>   - the dynamic VGPRs go to the wave's scratch, which is durable per wave
>     and therefore survives a restore that cannot reallocate them.
> 
> Persist wave's total VGPR count in a 4-byte per-lane
> slot reserved at the front of the dynamic-VGPR scratch region, read back
> through a VGPR lane since scratch is per lane.
> 
> Restore reallocates with s_alloc_vgpr once SCRATCH_BASE is available and
> retries while the pool is full. If a context save becomes pending while
> the allocation still cannot be satisfied, waiting would block the very
> preemption that frees pool space, so the wave leaves its dynamic VGPRs
> in scratch, completes the restore without resuming the shader, and
> re-enters the save path at L_SAVE_BYPASS to be retried on a later
> restore. Such a re-save must not overwrite the persisted count.
> The live allocation has collapsed to the fixed block, and recording that would
> lose the real count and strand the dynamic VGPRs in scratch. Signal the
> condition in PC_HI bit 1.

Should this be PC_HI bit 16?

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 356 +++++++++++-------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 217 ++++++++++-
>   2 files changed, 432 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 54fa76f374c9..259b2a4a1940 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
>   };
>   
>   static const uint32_t cwsr_trap_gfx12_hex[] = {
> -	0xbfa00001, 0xbfa00239,
> +	0xbfa00001, 0xbfa00273,
>   	0xb0804009, 0xb8eef81a,
>   	0xbf880000, 0xb980081a,
>   	0x00000000, 0xb8f8f804,
> @@ -3707,7 +3707,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x000c0000, 0x00000000,
>   	0x7e000280, 0xbefe007a,
>   	0xbeff007b, 0xb8fb0742,
> -	0x847b997b, 0xb8fa3b05,
> +	0x847b997b, 0xb8faf802,
> +	0xbf0d9e7a, 0xbfa10003,
> +	0xbefa00ff, 0x00000800,
> +	0xbfa00007, 0xb8fa3b05,
>   	0x807a817a, 0xbf0d997b,
>   	0xbfa20002, 0x847a897a,
>   	0xbfa00001, 0x847a8a7a,
> @@ -3748,6 +3751,9 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xee0a4074, 0x010c0000,
>   	0x00020000, 0xee0a4074,
>   	0x018c0000, 0x00030000,
> +	0xb8f0f802, 0xbf0d9e70,
> +	0xbfa10003, 0xbef000ff,
> +	0x00000800, 0xbfa00007,
>   	0xb8f03b05, 0x80708170,
>   	0xbf0d9973, 0xbfa20002,
>   	0x84708970, 0xbfa00001,
> @@ -3790,7 +3796,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xbeff0080, 0x80767074,
>   	0x82778075, 0xee0a4076,
>   	0x010c0000, 0x00000000,
> -	0xbefe00c1, 0xb8f03b05,
> +	0xbefe00c1, 0xb8f0f802,
> +	0xbf0d9e70, 0xbfa10003,
> +	0xbef000ff, 0x00000800,
> +	0xbfa00007, 0xb8f03b05,
>   	0x80708170, 0xbf0d9973,
>   	0xbfa20002, 0x84708970,
>   	0xbfa00001, 0x84708a70,
> @@ -3859,9 +3868,12 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xbf06817d, 0xbfa20002,
>   	0xbeff0080, 0xbfa00001,
>   	0xbeff00c1, 0xb8fb4306,
> -	0x8b7bc17b, 0xbfa10042,
> +	0x8b7bc17b, 0xbfa10048,
>   	0x8b7aff6d, 0x80000000,
> -	0xbfa1003f, 0x847b897b,
> +	0xbfa10045, 0x847b897b,
> +	0xb8f0f802, 0xbf0d9e70,
> +	0xbfa10003, 0xbef000ff,
> +	0x00000800, 0xbfa00007,
>   	0xb8f03b05, 0x80708170,
>   	0xbf0d9973, 0xbfa20002,
>   	0x84708970, 0xbfa00001,
> @@ -3902,20 +3914,37 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xb8fb3b05, 0x807b817b,
>   	0x847b827b, 0x857d9973,
>   	0x8b7d817d, 0xbf06817d,
> -	0xbfa2001b, 0xbefd0084,
> -	0xbf0a7b7d, 0xbfa10032,
> -	0x7e008700, 0x7e028701,
> -	0x7e048702, 0x7e068703,
> -	0x80767074, 0x82778075,
> -	0xee0a4076, 0x000c0000,
> -	0x00000000, 0xee0a4076,
> -	0x008c0000, 0x00008000,
> -	0xee0a4076, 0x010c0000,
> -	0x00010000, 0xee0a4076,
> -	0x018c0000, 0x00018000,
> -	0x807d847d, 0x8070ff70,
> -	0x00000200, 0xbf0a7b7d,
> -	0xbfa2ffe9, 0xbfa0001a,
> +	0xbfa2003d, 0xbefd0084,
> +	0xb8faf802, 0xbf0a7b7d,
> +	0xbfa10053, 0x7e008700,
> +	0x7e028701, 0x7e048702,
> +	0x7e068703, 0x80767074,
> +	0x82778075, 0xee0a4076,
> +	0x000c0000, 0x00000000,
> +	0xee0a4076, 0x008c0000,
> +	0x00008000, 0xee0a4076,
> +	0x010c0000, 0x00010000,
> +	0xee0a4076, 0x018c0000,
> +	0x00018000, 0x807d847d,
> +	0xbf0d9e7a, 0xbfa10002,
> +	0xbf0a907d, 0xbfa10005,
> +	0x8070ff70, 0x00000200,
> +	0xbf0a7b7d, 0xbfa2ffe5,
> +	0xbfa00037, 0xbf0d906d,
> +	0xbfa20035, 0xbef00080,
> +	0x7e00027b, 0xed068070,
> +	0x00000000, 0x00000000,
> +	0xbef00084, 0xbf097b7d,
> +	0xbfa2002d, 0x7e008700,
> +	0x7e028701, 0x7e048702,
> +	0x7e068703, 0xed068070,
> +	0x00000000, 0x00000000,
> +	0xed068070, 0x00800000,
> +	0x00000400, 0xed068070,
> +	0x01000000, 0x00000800,
> +	0xed068070, 0x01800000,
> +	0x00000c00, 0x807d847d,
> +	0x80709070, 0xbfa0ffeb,
>   	0xbefd0084, 0xbf0a7b7d,
>   	0xbfa10017, 0x7e008700,
>   	0x7e028701, 0x7e048702,
> @@ -3929,17 +3958,20 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00030000, 0x807d847d,
>   	0x8070ff70, 0x00000400,
>   	0xbf0a7b7d, 0xbfa2ffe9,
> -	0xbfa0014c, 0xbef4007e,
> +	0xbfa001ab, 0xbef4007e,
>   	0x8b75ff7f, 0x0000ffff,
>   	0xbef1007f, 0xb8f20742,
>   	0x84729972, 0x8b6eff7f,
> -	0x04000000, 0xbfa10044,
> +	0x04000000, 0xbfa1004a,
>   	0xbefe00c1, 0x857d9972,
>   	0x8b7d817d, 0xbf06817d,
>   	0xbfa20002, 0xbeff0080,
>   	0xbfa00001, 0xbeff00c1,
>   	0xb8ef4306, 0x8b6fc16f,
> -	0xbfa10039, 0x846f896f,
> +	0xbfa1003f, 0x846f896f,
> +	0xb8f8f802, 0xbf0d9e78,
> +	0xbfa10003, 0xbef800ff,
> +	0x00000800, 0xbfa00007,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
> @@ -3972,134 +4004,178 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x857d9972, 0x8b7d817d,
>   	0xbf06817d, 0xbfa20002,
>   	0xbeff0080, 0xbfa00001,
> -	0xbeff00c1, 0xb8ef3b05,
> -	0x806f816f, 0x846f826f,
> -	0x857d9972, 0x8b7d817d,
> -	0xbf06817d, 0xbfa2002c,
> -	0xbeee0078, 0x8078ff78,
> -	0x00000200, 0xbefd0084,
> -	0x80767874, 0x82778075,
> -	0xee0a0076, 0x000c0000,
> -	0x00000000, 0xee0a0076,
> -	0x000c0001, 0x00008000,
> -	0xee0a0076, 0x000c0002,
> -	0x00010000, 0xee0a0076,
> -	0x000c0003, 0x00018000,
> -	0xbf8a0000, 0x7e008500,
> -	0x7e028501, 0x7e048502,
> -	0x7e068503, 0x807d847d,
> +	0xbeff00c1, 0xb8ecf802,
> +	0xbf0d9e6c, 0xbfa10002,
> +	0xbeef0090, 0xbfa00003,
> +	0xb8ef3b05, 0x806f816f,
> +	0x846f826f, 0x857d9972,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa2002c, 0xbeee0078,
>   	0x8078ff78, 0x00000200,
> -	0xbf0a6f7d, 0xbfa2ffe8,
> -	0x80766e74, 0x82778075,
> -	0xee0a0076, 0x000c0000,
> -	0x00000000, 0xee0a0076,
> -	0x000c0001, 0x00008000,
> -	0xee0a0076, 0x000c0002,
> -	0x00010000, 0xee0a0076,
> -	0x000c0003, 0x00018000,
> -	0xbf8a0000, 0xbfa0002d,
> -	0xbeee0078, 0x8078ff78,
> -	0x00000400, 0xbefd0084,
> -	0xbf0a6f7d, 0xbfa10018,
> -	0x80767874, 0x82778075,
> -	0xee0a0076, 0x000c0000,
> -	0x00000000, 0xee0a0076,
> -	0x000c0001, 0x00010000,
> -	0xee0a0076, 0x000c0002,
> -	0x00020000, 0xee0a0076,
> -	0x000c0003, 0x00030000,
> -	0xbf8a0000, 0x7e008500,
> -	0x7e028501, 0x7e048502,
> -	0x7e068503, 0x807d847d,
> +	0xbefd0084, 0x80767874,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00008000, 0xee0a0076,
> +	0x000c0002, 0x00010000,
> +	0xee0a0076, 0x000c0003,
> +	0x00018000, 0xbf8a0000,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000200, 0xbf0a6f7d,
> +	0xbfa2ffe8, 0x80766e74,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00008000, 0xee0a0076,
> +	0x000c0002, 0x00010000,
> +	0xee0a0076, 0x000c0003,
> +	0x00018000, 0xbf8a0000,
> +	0xbfa0002d, 0xbeee0078,
>   	0x8078ff78, 0x00000400,
> -	0xbf0a6f7d, 0xbfa2ffe8,
> -	0x80766e74, 0x82778075,
> -	0xee0a0076, 0x000c0000,
> -	0x00000000, 0xee0a0076,
> -	0x000c0001, 0x00010000,
> -	0xee0a0076, 0x000c0002,
> -	0x00020000, 0xee0a0076,
> -	0x000c0003, 0x00030000,
> -	0xbf8a0000, 0xb8f83b05,
> -	0x80788178, 0xbf0d9972,
> -	0xbfa20002, 0x84788978,
> -	0xbfa00001, 0x84788a78,
> -	0x8078ff78, 0x00000200,
> -	0x80f8ff78, 0x00000060,
> -	0x80767874, 0x82778075,
> -	0xbefd00ff, 0x0000006c,
> -	0xf460403b, 0xf8000000,
> -	0xbf8a0000, 0x80fd847d,
> -	0xbf800000, 0xbe804300,
> -	0xbe824302, 0x80f6a076,
> -	0x82f78077, 0xf460603b,
> +	0xbefd0084, 0xbf0a6f7d,
> +	0xbfa10018, 0x80767874,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00010000, 0xee0a0076,
> +	0x000c0002, 0x00020000,
> +	0xee0a0076, 0x000c0003,
> +	0x00030000, 0xbf8a0000,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000400, 0xbf0a6f7d,
> +	0xbfa2ffe8, 0x80766e74,
> +	0x82778075, 0xee0a0076,
> +	0x000c0000, 0x00000000,
> +	0xee0a0076, 0x000c0001,
> +	0x00010000, 0xee0a0076,
> +	0x000c0002, 0x00020000,
> +	0xee0a0076, 0x000c0003,
> +	0x00030000, 0xbf8a0000,
> +	0xb8f8f802, 0xbf0d9e78,
> +	0xbfa10003, 0xbef800ff,
> +	0x00000800, 0xbfa00007,
> +	0xb8f83b05, 0x80788178,
> +	0xbf0d9972, 0xbfa20002,
> +	0x84788978, 0xbfa00001,
> +	0x84788a78, 0x8078ff78,
> +	0x00000200, 0x80f8ff78,
> +	0x00000060, 0x80767874,
> +	0x82778075, 0xbefd00ff,
> +	0x0000006c, 0xf460403b,
>   	0xf8000000, 0xbf8a0000,
> -	0x80fd887d, 0xbf800000,
> +	0x80fd847d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0x80f6c076, 0x82f78077,
> -	0xf460803b, 0xf8000000,
> -	0xbf8a0000, 0x80fd907d,
> +	0x80f6a076, 0x82f78077,
> +	0xf460603b, 0xf8000000,
> +	0xbf8a0000, 0x80fd887d,
>   	0xbf800000, 0xbe804300,
>   	0xbe824302, 0xbe844304,
> -	0xbe864306, 0xbe884308,
> -	0xbe8a430a, 0xbe8c430c,
> -	0xbe8e430e, 0xbf06807d,
> -	0xbfa1ffef, 0xb980f801,
> -	0x00000000, 0xb8f83b05,
> -	0x80788178, 0xbf0d9972,
> -	0xbfa20002, 0x84788978,
> -	0xbfa00001, 0x84788a78,
> -	0x8078ff78, 0x00000200,
> -	0x80767874, 0x82778075,
> -	0xbeff0071, 0xf4601bfb,
> -	0xf8000000, 0xf4601b3b,
> -	0xf8000004, 0xf4601b7b,
> -	0xf8000008, 0xf4601c3b,
> -	0xf800000c, 0xf4601c7b,
> -	0xf8000010, 0xf4601ebb,
> -	0xf8000014, 0xf4601efb,
> -	0xf8000018, 0xf4601e7b,
> -	0xf800001c, 0xf4601cfb,
> -	0xf8000020, 0xf4601bbb,
> -	0xf8000024, 0xbf8a0000,
> -	0xb96ef814, 0xf4601bbb,
> -	0xf8000028, 0xbf8a0000,
> -	0xb96ef815, 0xf4601bbb,
> -	0xf800002c, 0xbf8a0000,
> -	0xb96ef812, 0xf4601bbb,
> -	0xf8000030, 0xbf8a0000,
> -	0xb96ef813, 0x8b6eff7f,
> -	0x04000000, 0xbfa1000b,
> -	0xf4601bbb, 0xf8000038,
> -	0xbf8a0000, 0xbf0d806e,
> -	0xbfa10006, 0x856e906e,
> -	0x8b6e6e6e, 0xbfa10003,
> -	0xbe804ec1, 0x816ec16e,
> -	0xbfa0fffb, 0xbefd006f,
> -	0xbefe0070, 0xbeff0071,
> -	0xb97b2011, 0x857b867b,
> -	0xb97b0191, 0x857b827b,
> -	0xb97bba11, 0xb973f801,
> -	0xb8ee3b05, 0x806e816e,
> +	0xbe864306, 0x80f6c076,
> +	0x82f78077, 0xf460803b,
> +	0xf8000000, 0xbf8a0000,
> +	0x80fd907d, 0xbf800000,
> +	0xbe804300, 0xbe824302,
> +	0xbe844304, 0xbe864306,
> +	0xbe884308, 0xbe8a430a,
> +	0xbe8c430c, 0xbe8e430e,
> +	0xbf06807d, 0xbfa1ffef,
> +	0xb980f801, 0x00000000,
> +	0xb8f8f802, 0xbf0d9e78,
> +	0xbfa10003, 0xbef800ff,
> +	0x00000800, 0xbfa00007,
> +	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
> -	0x846e896e, 0xbfa00001,
> -	0x846e8a6e, 0x806eff6e,
> -	0x00000240, 0x806e746e,
> -	0x826f8075, 0xf4605c37,
> -	0xf8000010, 0xf4605d37,
> -	0xf8000020, 0xf4601e77,
> -	0xf8000034, 0xbf8a0000,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> -	0x936eff77, 0x0002001a,
> -	0xb96ef81a, 0xb97af804,
> +	0x84788978, 0xbfa00001,
> +	0x84788a78, 0x8078ff78,
> +	0x00000200, 0x80767874,
> +	0x82778075, 0xbeff0071,
> +	0xf4601bfb, 0xf8000000,
> +	0xf4601b3b, 0xf8000004,
> +	0xf4601b7b, 0xf8000008,
> +	0xf4601c3b, 0xf800000c,
> +	0xf4601c7b, 0xf8000010,
> +	0xf4601ebb, 0xf8000014,
> +	0xf4601efb, 0xf8000018,
> +	0xf4601e7b, 0xf800001c,
> +	0xf4601cfb, 0xf8000020,
> +	0xf4601bbb, 0xf8000024,
> +	0xbf8a0000, 0xb96ef814,
> +	0xf4601bbb, 0xf8000028,
> +	0xbf8a0000, 0xb96ef815,
> +	0xf4601bbb, 0xf800002c,
> +	0xbf8a0000, 0xb96ef812,
> +	0xf4601bbb, 0xf8000030,
> +	0xbf8a0000, 0xb96ef813,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa1000b, 0xf4601bbb,
> +	0xf8000038, 0xbf8a0000,
> +	0xbf0d806e, 0xbfa10006,
> +	0x856e906e, 0x8b6e6e6e,
> +	0xbfa10003, 0xbe804ec1,
> +	0x816ec16e, 0xbfa0fffb,
> +	0xbef80080, 0xb8f6f802,
> +	0xbf0d9e76, 0xbfa10038,
> +	0xbefe00c1, 0xbef80080,
> +	0xed050078, 0x00000000,
> +	0x00000000, 0xbfc00000,
> +	0xd7600077, 0x00010100,
> +	0xbef60077, 0xbe805376,
> +	0xbfa20006, 0xb8f6f811,
> +	0x8b76a076, 0xbf830010,
> +	0xbfa1fff9, 0xbef80081,
> +	0xbfa0001a, 0xbefe00c1,
> +	0xbefd0090, 0xbef80084,
> +	0xbf0a777d, 0xbfa10015,
> +	0xed050078, 0x00000000,
> +	0x00000000, 0xed050078,
> +	0x00000001, 0x00000400,
> +	0xed050078, 0x00000002,
> +	0x00000800, 0xed050078,
> +	0x00000003, 0x00000c00,
> +	0xbfc00000, 0x7e008500,
> +	0x7e028501, 0x7e048502,
> +	0x7e068503, 0x807d847d,
> +	0x80789078, 0xbf0a777d,
> +	0xbfa2ffeb, 0xee0a0074,
> +	0x000c0000, 0x00000000,
> +	0xee0a0074, 0x000c0001,
> +	0x00008000, 0xee0a0074,
> +	0x000c0002, 0x00010000,
> +	0xee0a0074, 0x000c0003,
> +	0x00018000, 0xbf8a0000,
> +	0xbefd006f, 0xbefe0070,
> +	0xbeff0071, 0xb97b2011,
> +	0x857b867b, 0xb97b0191,
> +	0x857b827b, 0xb97bba11,
> +	0xb973f801, 0xb8eef802,
> +	0xbf0d9e6e, 0xbfa10003,
> +	0xbeee00ff, 0x00000800,
> +	0xbfa00007, 0xb8ee3b05,
> +	0x806e816e, 0xbf0d9972,
> +	0xbfa20002, 0x846e896e,
> +	0xbfa00001, 0x846e8a6e,
> +	0x806eff6e, 0x00000240,
> +	0x806e746e, 0x826f8075,
> +	0xf4605c37, 0xf8000010,
> +	0xf4605d37, 0xf8000020,
> +	0xf4601e77, 0xf8000034,
> +	0xbf8a0000, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0xbf068178,
> +	0xbfa20007, 0x936eff77,
> +	0x0002001a, 0xb96ef81a,
> +	0xb97af804, 0xbe804ec2,
> +	0xbf94fffe, 0xbe804a6c,
> +	0xbef8007a, 0x8c6dff6d,
> +	0x00010000, 0xbfa0fc47,
>   	0xbe804ec2, 0xbf94fffe,
> -	0xbe804a6c, 0xbe804ec2,
> -	0xbf94fffe, 0xbfb10000,
> +	0xbfb10000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
> -	0xbf9f0000, 0x00000000,
>   };
>   
>   static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index d38ff404277b..355b5175f141 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -38,6 +38,7 @@
>   #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
>   #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
>   #define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
> +#define HAVE_DYNAMIC_VGPRS (ASIC_FAMILY == CHIP_GFX12)
>   
>   #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
>   #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
> @@ -60,16 +61,20 @@ var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
>   var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
>   var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
>   var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
> +var SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT		= 30
>   var SQ_WAVE_STATUS_IN_WG_SHIFT			= 11
>   var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
>   var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
>   
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_MASK		= 0xFF000
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
>   
>   #if ASIC_FAMILY < CHIP_GC_12_0_3
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT	= 24
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE	= 4
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
>   #else
>   var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
> @@ -185,6 +190,34 @@ var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
>   var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
>   var S_WAVE_SIZE					= 25
>   
> +#if HAVE_DYNAMIC_VGPRS
> +var WAVE_MIN_NUM_DVGPRS				= 16	// Defined by SQ_DYN_VGPR.block_size.  Assume default value for now.
> +
> +// The total VGPR count of a DVGPR wave is persisted in the wave's own scratch, in a small
> +// region reserved at the front of the dynamic-VGPR backing store (ahead of the dynamic
> +// VGPRs themselves).
> +//
> +// NOTE: the driver-side dynamic-VGPR scratch allocation must include these reserved bytes
> +// per lane in addition to the space for the dynamic VGPRs.
> +var S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET		= 0	// count location within the reserved region
> +var S_SAVE_DVGPR_SCRATCH_RESERVE		= 4	// bytes reserved per lane at scratch offset 0
> +
> +// DVGPR restore-allocation bypass.  If the restore-time s_alloc_vgpr fails while a
> +// context-save is pending, the wave cannot restore its dynamic VGPRs.  Rather than
> +// dropping them (corruption) or spinning forever, the wave re-enters the save path
> +// (L_SAVE_BYPASS) so it is re-saved and retried on a later restore when pool space frees.
> +//
> +// On such a re-save the live allocation has collapsed to the minimum block, so the save
> +// must NOT overwrite the durable scratch count (that would lose the real count and strand
> +// the dynamic VGPRs still sitting in scratch).  A freshly dispatched wave never passes
> +// through restore, so a "this is a bypass re-save" marker cannot live in scratch (its first
> +// save would read it uninitialized); it is instead carried for the single trap execution in
> +// a free PC_HI bit.  On GFX12 the PC occupies PC_HI[15:0] (48-bit address) and there are no
> +// banked-VGPR bits, so PC_HI[30:16] are free; the bit is masked off before PC_HI is written
> +// to memory, so it is never persisted.
> +var S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT		= 16
> +var S_SAVE_PC_HI_DVGPR_BYPASS_MASK		= 0x00010000
> +#endif
>   var s_restore_spi_init_lo			= exec_lo
>   var s_restore_spi_init_hi			= exec_hi
>   var s_restore_mem_offset			= ttmp12
> @@ -196,6 +229,8 @@ var s_restore_mode				= ttmp7
>   var s_restore_flat_scratch			= s_restore_tmp
>   var s_restore_pc_lo				= ttmp0
>   var s_restore_pc_hi				= ttmp1
> +// Scratch register, valid only before L_RESTORE_HWREG loads the saved PC.
> +var s_restore_tmp2				= s_restore_pc_lo
>   var s_restore_exec_lo				= ttmp4
>   var s_restore_exec_hi				= ttmp5
>   var s_restore_state_priv			= ttmp14
> @@ -210,6 +245,20 @@ var s_restore_ttmps_lo				= s_restore_tmp
>   var s_restore_ttmps_hi				= s_restore_alloc_size
>   var s_restore_spi_init_hi_save			= s_restore_exec_hi
>   
> +#if HAVE_DYNAMIC_VGPRS
> +// Temporaries for the dynamic-VGPR restore, which runs after L_RESTORE_HWREG (scratch is not
> +// addressable before SCRATCH_BASE is restored).
> +var s_restore_dvgpr_tmp				= s_restore_addr_lo
> +var s_restore_dvgpr_count			= s_restore_addr_hi
> +
> +// s_restore_mem_offset (ttmp12) is dead as a scratch offset once the dynamic-VGPR restore
> +// finishes, so it is reused to carry the rfe-vs-resave decision to the end of restore:
> +// 0 == resume the shader normally, 1 == bypass to the save path (re-save).  The dynamic-VGPR
> +// restore loop only ever leaves the register 0 or >= S_SAVE_DVGPR_SCRATCH_RESERVE (its
> +// starting offset, which it only increments), so 1 is an unambiguous marker.
> +var s_restore_dvgpr_bypass			= s_restore_mem_offset
> +#endif
> +
>   #if SAVE_TTMPS_IN_SGPR_BLOCK
>   var TTMP_SR_OFFSET_FROM_HWREG			= -0x40
>   #else
> @@ -409,6 +458,15 @@ L_SAVE:
>   	s_endpgm
>   L_HAVE_VGPRS:
>   	s_and_b32	s_save_pc_hi, s_save_pc_hi, ADDRESS_HI32_MASK
> +#if HAVE_DYNAMIC_VGPRS
> +// Re-entry point for the DVGPR restore-allocation bypass (see L_DYN_VGPR_ALLOC_LOOP).
> +// On entry from restore s_save_state_priv has been populated from s_restore_state_priv and
> +// the bypass marker bit (S_SAVE_PC_HI_DVGPR_BYPASS_MASK) has been set in PC_HI -- this entry
> +// skips the PC_HI mask at L_HAVE_VGPRS, so the marker survives to the dynamic-VGPR save,
> +// where it suppresses the durable scratch count write (the count and the dynamic VGPRs are
> +// already intact in scratch from the previous save).
> +L_SAVE_BYPASS:
> +#endif
>   	s_mov_b32	s_save_tmp, 0
>   	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
>   
> @@ -798,6 +856,9 @@ L_SAVE_VGPR_NORMAL:
>   
>   	// VGPR store using dw burst
>   	s_mov_b32	m0, 0x4							//VGPR initial index value =4
> +#if HAVE_DYNAMIC_VGPRS
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)			//save to check DYN_VGPR_EN later
> +#endif
>   	s_cmp_lt_u32	m0, s_save_alloc_size
>   	s_cbranch_scc0	L_SAVE_VGPR_END
>   
> @@ -815,12 +876,51 @@ L_SAVE_VGPR_W32_LOOP:
>   	global_store_addtid_b32	v3, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128*3
>   
>   	s_add_u32	m0, m0, 4						//next vgpr index
> +#if HAVE_DYNAMIC_VGPRS
> +	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +	s_cbranch_scc0	L_SAVE_FIXED_VGPR_END_LOOP_CHECK
> +	s_cmp_lt_u32	m0, WAVE_MIN_NUM_DVGPRS
> +	s_cbranch_scc0	L_SAVE_DYN_VGPR_SAVE
> +
> +L_SAVE_FIXED_VGPR_END_LOOP_CHECK:
> +#endif
>   	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128*4		//every buffer_store_dword does 128 bytes
>   	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
>   	s_cbranch_scc1	L_SAVE_VGPR_W32_LOOP					//VGPR save is complete?
> -
>   	s_branch	L_SAVE_VGPR_END
>   
> +#if HAVE_DYNAMIC_VGPRS
> +L_SAVE_DYN_VGPR_SAVE:
> +	s_bitcmp1_b32	s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT
> +	s_cbranch_scc1	L_SAVE_VGPR_END
> +
> +	// Persist the total VGPR count in the reserved scratch slot (durable per wave).
> +	// s_save_alloc_size holds the live total VGPR count (HW_REG_WAVE_GPR_ALLOC).
> +	s_mov_b32	s_save_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET
> +	v_mov_b32	v0, s_save_alloc_size
> +	scratch_store_b32 off, v0, s_save_mem_offset offset: 0
> +
> +	// m0 already holds WAVE_MIN_NUM_DVGPRS: the fixed-VGPR loop steps by 4 and branches here
> +	// on the first index at or past the block boundary (must match RESTORE).
> +	s_mov_b32	s_save_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
> +
> +L_SAVE_DYN_VGPR_SAVE_LOOP:
> +	s_cmp_ge_u32	m0, s_save_alloc_size
> +	s_cbranch_scc1	L_SAVE_VGPR_END
> +
> +	v_movrels_b32	v0, v0							//v0 = v[0+m0]
> +	v_movrels_b32	v1, v1							//v1 = v[1+m0]
> +	v_movrels_b32	v2, v2							//v2 = v[2+m0]
> +	v_movrels_b32	v3, v3							//v3 = v[3+m0]
> +	scratch_store_b32 off, v0, s_save_mem_offset offset: 0
> +	scratch_store_b32 off, v1, s_save_mem_offset offset: 4
> +	scratch_store_b32 off, v2, s_save_mem_offset offset: 8
> +	scratch_store_b32 off, v3, s_save_mem_offset offset: 12
> +	s_add_u32	m0, m0, 4
> +	s_add_u32	s_save_mem_offset, s_save_mem_offset, 16
> +	s_branch	L_SAVE_DYN_VGPR_SAVE_LOOP
> +#endif
> +
>   L_SAVE_VGPR_WAVE64:
>   	// VGPR store using dw burst
>   	s_mov_b32	m0, 0x4							//VGPR initial index value =4
> @@ -934,9 +1034,23 @@ L_RESTORE_VGPR:
>   L_ENABLE_RESTORE_VGPR_EXEC_HI:
>   	s_mov_b32	exec_hi, 0xFFFFFFFF
>   L_RESTORE_VGPR_NORMAL:
> +#if HAVE_DYNAMIC_VGPRS
> +	// For DVGPR waves this loop restores only the fixed VGPR block, so cap the loop bound at
> +	// WAVE_MIN_NUM_DVGPRS rather than taking the live GPR_ALLOC size.  The dynamic VGPRs are
> +	// restored later, from scratch, once SCRATCH_BASE has been restored (it is not yet
> +	// restored at this point) and their count is known.
> +	s_getreg_b32	s_restore_tmp2, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp1_b32	s_restore_tmp2, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +	s_cbranch_scc0	L_RESTORE_ALLOC_SIZE_FROM_HW  // Not DVGPR, use HW register
> +	s_mov_b32	s_restore_alloc_size, WAVE_MIN_NUM_DVGPRS
> +	s_branch	L_RESTORE_ALLOC_SIZE_DONE

I am not sure we need to distinguish here, do we?  According to the 
manual[1] states "Waves in dynamic VGPR mode are initialized with one 
VGPR-block allocated" (section 3.3.3).  Therefore, I expect that if the 
wave is using DVGPRs, on restore it is created with 1 block, so reading 
GPR_ALLOC would give us the same result.

Unless I missed someting, it seems we could just remove this hunk (and 
the definition of s_restore_tmp2), and have the same behaviour.  Am I 
missing something?

[1] https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture

> +
> +L_RESTORE_ALLOC_SIZE_FROM_HW:
> +#endif
>   	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
>   	s_add_u32	s_restore_alloc_size, s_restore_alloc_size, 1
>   	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 2		//Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)
> +L_RESTORE_ALLOC_SIZE_DONE:

If this remains (see previous comment), this label might be guarded by 
HAVE_DYNAMIC_VGPRS (not strictly necessary, but would remain consistent 
with the rest of the patch).

>   	//determine it is wave32 or wave64
>   	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
>   	s_and_b32	m0, m0, 1
> @@ -1181,6 +1295,74 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>   	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
>   #endif
>   
> +#if HAVE_DYNAMIC_VGPRS
> +	// Default: resume normally after restore (see s_restore_dvgpr_bypass).
> +	s_mov_b32	s_restore_dvgpr_bypass, 0
> +
> +	// Check if dynamic VGPR is enabled
> +	s_getreg_b32	s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp1_b32	s_restore_dvgpr_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +	s_cbranch_scc0	L_SKIP_DYN_VGPR_RESTORE
> +
> +	// Total VGPR count persisted in the reserved scratch slot at preempt (see
> +	// L_SAVE_DYN_VGPR_SAVE).
> +	s_mov_b32	exec_lo, 0xFFFFFFFF
> +	s_mov_b32	s_restore_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET
> +	scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
> +	s_wait_loadcnt	0
> +	v_readlane_b32	s_restore_dvgpr_count, v0, 0
> +
> +L_DYN_VGPR_ALLOC_LOOP:
> +	// s_alloc_vgpr modifies its operand, so give it a fresh copy of the count each attempt.

Does it?  It modifies SCC, but I do not think it modifies its operand.

> +	s_mov_b32	s_restore_dvgpr_tmp, s_restore_dvgpr_count
> +	s_alloc_vgpr	s_restore_dvgpr_tmp
> +	s_cbranch_scc1	L_DYN_VGPR_RESTORE			// allocation succeeded
> +	// Allocation failed.  Keep retrying unless a context-save is pending.
> +	s_getreg_b32	s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +	s_and_b32	s_restore_dvgpr_tmp, s_restore_dvgpr_tmp, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +	s_sleep		0x10
> +	s_cbranch_scc0	L_DYN_VGPR_ALLOC_LOOP			// no save pending -> retry
> +	// A context-save is pending and there is still no room: bypass to the save path so
> +	// this wave is re-saved and retried on a later restore. The re-save does write
> +	// the fixed VGPRs back from registers, so v[0:3] must be put back first.
> +	s_mov_b32	s_restore_dvgpr_bypass, 1		// re-save instead of rfe
> +	s_branch	L_DYN_VGPR_RELOAD_FIXED
> +
> +L_DYN_VGPR_RESTORE:
> +	// Enable all lanes for the v_movreld instructions below.  This path is wave32 only, so
> +	// exec_lo is the entire mask.
> +	s_mov_b32	exec_lo, 0xFFFFFFFF

Can exec_lo be anything else at this point?  It was set to this value 
before reading the vgpr alloc size, which was needed to re-allocate.

> +	// Start at the first dynamic VGPR (must match SAVE).
> +	s_mov_b32	m0, WAVE_MIN_NUM_DVGPRS
> +	s_mov_b32	s_restore_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
> +	s_cmp_lt_u32	m0, s_restore_dvgpr_count
> +	s_cbranch_scc0	L_DYN_VGPR_RELOAD_FIXED
> +
> +L_DYN_VGPR_RESTORE_LOOP:
> +	scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
> +	scratch_load_b32 v1, off, s_restore_mem_offset offset: 4
> +	scratch_load_b32 v2, off, s_restore_mem_offset offset: 8
> +	scratch_load_b32 v3, off, s_restore_mem_offset offset: 12
> +	s_wait_loadcnt	0
> +	v_movreld_b32	v0, v0
> +	v_movreld_b32	v1, v1
> +	v_movreld_b32	v2, v2
> +	v_movreld_b32	v3, v3
> +	s_add_u32	m0, m0, 4
> +	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 16
> +	s_cmp_lt_u32	m0, s_restore_dvgpr_count
> +	s_cbranch_scc1	L_DYN_VGPR_RESTORE_LOOP
> +
> +	// Put back the v[0:3] borrowed above as scratch-load staging.  The fixed VGPR block starts
> +	// at CWSR offset 0, DVGPR implies wave32, hence the 128-byte stride.
> +L_DYN_VGPR_RELOAD_FIXED:
> +	global_load_addtid_b32	v0, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS
> +	global_load_addtid_b32	v1, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128
> +	global_load_addtid_b32	v2, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*2
> +	global_load_addtid_b32	v3, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*3
> +	s_wait_idle

Could as well be `s_wait_loadcnt 0`, couldn't it?

> +L_SKIP_DYN_VGPR_RESTORE:
> +#endif
>   	s_mov_b32	m0, s_restore_m0
>   	s_mov_b32	exec_lo, s_restore_exec_lo
>   	s_mov_b32	exec_hi, s_restore_exec_hi
> @@ -1220,6 +1402,14 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
>   
> +#if HAVE_DYNAMIC_VGPRS
> +	// DVGPR restore-allocation bypass: if dynamic VGPRs could not be allocated while a
> +	// context-save was pending (flagged in s_restore_dvgpr_bypass == 1 by
> +	// L_DYN_VGPR_ALLOC_LOOP), re-enter the save path instead of resuming the shader.
> +	s_cmp_eq_u32	s_restore_dvgpr_bypass, 1
> +	s_cbranch_scc1	L_DYN_VGPR_BYPASS_RESAVE
> +#endif
> +
>   #if RELAXED_SCHEDULING_IN_TRAP
>   	// Assume relaxed scheduling mode after this point.
>   	restore_sched_mode(s_restore_tmp)
> @@ -1239,6 +1429,16 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
>   
>   	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
>   
> +#if HAVE_DYNAMIC_VGPRS
> +L_DYN_VGPR_BYPASS_RESAVE:
> +	// Out of line so the resume path above ends at s_rfe_b64 with SCC untouched.  Hand the
> +	// save path the state_priv it would otherwise have read at trap entry, and set the
> +	// transient PC_HI bypass marker so the save skips the durable scratch count write.
> +	s_mov_b32	s_save_state_priv, s_restore_state_priv
> +	s_or_b32	s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_MASK
> +	s_branch	L_SAVE_BYPASS
> +#endif

I am not sure I follow why this needs to be ou of line.  SCC was touched 
before deciding if we want to jump here or not.  Feels the previous hunk 
could be

   s_cmp_eq_u32   s_restore_dvgpr_bypass, 1
   s_cbranch_scc0 L_NO_DVGPR_RESAVE

   // set state as expected for save
   s_mov_b32	s_save_state_priv, s_restore_state_priv
   s_or_b32	s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_MASK
   s_branch	L_SAVE_BYPASS

L_NO_DVGPR_RESAVE:
   ...
   // Here we do restore SCC
   s_setreg_b32    hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv


Best,
Lancelot.

> +
>   L_END_PGM:
>   	// Make sure that no wave of the group/cluster can exit the trap handler
>   	// before the group/cluster barrier state is saved.
> @@ -1271,6 +1471,18 @@ function write_12sgpr_to_v2(s)
>   end
>   
>   function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
> +#if HAVE_DYNAMIC_VGPRS
> +	// DVGPR waves (wave32 only) keep only the fixed VGPR block (WAVE_MIN_NUM_DVGPRS) in
> +	// the CWSR buffer; the dynamic VGPRs live in scratch.  Every CWSR region placed after
> +	// the VGPR block (SGPR/HWREG/LDS/TTMP) is sized off the VGPR block, so centralize the
> +	// fixed-block adjustment here to keep every offset consistent.
> +	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp1_b32	s_vgpr_size_byte, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
> +	s_cbranch_scc0	L_GET_VGPR_SIZE_NORMAL
> +	s_mov_b32	s_vgpr_size_byte, (WAVE_MIN_NUM_DVGPRS * 128)		//16 fixed VGPRs, wave32
> +	s_branch	L_GET_VGPR_SIZE_DONE
> +L_GET_VGPR_SIZE_NORMAL:
> +#endif
>   	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
>   	s_add_u32	s_vgpr_size_byte, s_vgpr_size_byte, 1
>   	s_bitcmp1_b32	s_size, S_WAVE_SIZE
> @@ -1280,6 +1492,9 @@ function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
>   L_ENABLE_SHIFT_W64:
>   	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, (2+8)		//Number of VGPRs = (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)
>   L_SHIFT_DONE:
> +#if HAVE_DYNAMIC_VGPRS
> +L_GET_VGPR_SIZE_DONE:
> +#endif
>   end
>   
>   function get_sgpr_size_bytes

