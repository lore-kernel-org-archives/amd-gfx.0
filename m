Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16436C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 22:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBA110ECD6;
	Fri, 23 Feb 2024 22:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hEXFjmZN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5921710ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 22:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg5V9psP6EUgc00VW5a5VG3Hydr5qEO1x337d3dgnJpvpKvLNVA63F4mWVNrv/bEZwub5wLnE2YieXxVvYOMpL/Z8OHfA0Cn9XfMqNNb1CedEDxFlyzi4DchgKWjHS7xBVruAdLb4+iV80YjocR5Z1pxbomgaiN/39+5AwDBrdseyB14HqaB8Mkvoz0b2oIfoizyCE8OpqYgTFIlNqQR8+PaEyJVBvuiG+kKtxueg5VWlwcBsaiYES6LhSwXNl72mZVu0d5N3bcUiq/TRu8lp6sDMcfhSNJG7UB7FzoGZIjnfw7AbVLQTZv7NHBp76GTuowRIezy+OFwfHXAxyPqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVx1uTTIkGEpN9JqWTbce6W5HD1yXXnY4V9TSgva2Ns=;
 b=TVR2KBxPs0twLopwBbb1YvdXsHkdYSO6vajXbimVMb+Ud/aNcvjoVyXjpNU0EOIWtvoCmfnfo5goVhoW3mjdLWulIfgb4sH7aEA38fJJYCvaK45kj4k2j37wHwOQDAUQSyzC5J+/Dyu9rSWv5y1SmFre2qU1m+M/nZvaEM+JunkCbw40c+DkGltQd0muOeOMfbMBGZM9+qnTJfXjOa86PYnrDiZmLxJ3iQ+f1m7CCzzwvY7K8IS/0Yhh+VKZVoexAg75aaNF6LM2Ak83JmtR0qkhw/yFBS6fCd8uJ4/ygNBRADksqYkP3dgt1cOF23+xXYUaZJ/D6FRRkfEAgy2dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVx1uTTIkGEpN9JqWTbce6W5HD1yXXnY4V9TSgva2Ns=;
 b=hEXFjmZN+05sNCs3TyOr8XgLRoQ4eB/Zx2KQT2vqRPsNV15Ht6fVJkskGbSBSgxyplZPBsp96X3tJ/3SRCKIE+opkO9cRNPLzN18LnKPrWyUjzlXk5to7gkEWte2YM9Kz6tmw1lvXSoxG/JUu2ukGXFz7rePXX1vRkLgpGqJXDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 22:55:51 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::cb5d:bda9:5824:d140]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::cb5d:bda9:5824:d140%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 22:55:50 +0000
Message-ID: <5466aa0d-9890-46e9-9461-0deca707909d@amd.com>
Date: Fri, 23 Feb 2024 17:55:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Increase the size of the memory reserved for
 the TBA
Content-Language: en-US
To: Laurent Morichetti <laurent.morichetti@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: jay.cornwall@amd.com
References: <20240223190523.1823860-1-laurent.morichetti@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240223190523.1823860-1-laurent.morichetti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f49c2a-a508-4f89-c345-08dc34c294f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNnAqa27J19j0FU1mlsNKxdayHZHQDmPyP5GhztqgArYnFXaiqoWP0GlryIeALDcAFIwj/G5B5oy3efZmB9uKZJX1zoKkDALBg7o+2R9uGxnNmXiKVfL89qBc0HLkB4ZwZe83pSt5VdTyO9FJepEF9NqdBLHnYICR8p2/XJ9Rg3wMPoam4Gcxt/PFPFU0TnmkUmVrJZUweDWs0Ja3BfpChSVxweCoB0L0GdO4VSmf4kOGuRzk0EwynfL002u7AGTvYjMihkz2JyRZ3IXMqFixVJWu4uSY+/AmkvKQxd2ux7v1mzf6ZTyN2FJAHri8nQYmOnzOvFW08MwGT3UFFRo1Sbkoa6xCxwgJ1r4SU+ToTPBvlBfxAlSvUdH62GIqmw/cgaTMZOXAMK1/GZ8krxNINLxJaXFl1axogIuG7DN4WBPv8zj58Q+g6CxN/yaaHTzzkaGIz4qkzXmCOtHx+JkfSXePtjR4n7Gd1kz1Ef7NPTh3GBe3q4PifqO1O6d8aSc+x4TpW5ZgoNRw1kRxY8DEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWQvSjNoU3JtY2tWdDJMUWNoc3dVNmpWTkVyWTlyQzAzM0t1eGZQZk1TL2l2?=
 =?utf-8?B?UzExSFlrQnVOVE1MUUJoNkZqdGxLZjhrTDByWXUzdk5OclpadGFKbHhkNWJu?=
 =?utf-8?B?WU5GbkExMEYyVzRQY1lDZGs5dkZNR1hoSko5S05FVkZTekhwZkRidUpPdFY4?=
 =?utf-8?B?ZWN4QnE1cGRBN3A3MXFrNUY3dS9mNTBqOUg0T1Y0R1NPTDc5djVjZjc3Rzcw?=
 =?utf-8?B?VWNPWVY5T2NBZzhicjZwT3c2bzZhNVFGNTVOUUdIUHZBcU5ha2trRUQwaThx?=
 =?utf-8?B?bEI2bHRoOVFqU0ZqQlNkMHZmRVRGNXNXR0x3Y2xIb0hMMkRneVEwNDN3K0tG?=
 =?utf-8?B?aW94T1pJR2dJbUZEUDJjNTdFVnNGUW5zaXJndkNFR2ZVWWNoUVN3ZjU2dWRS?=
 =?utf-8?B?bnV6eFRhNTI2d24rck9rbXdUZEVzSjdKR3RiUCtSczRxWEE1a1I4TmVDNXhO?=
 =?utf-8?B?QzB1VE1Kdm9hWW9kQURlUlJ1MTBUWnVQNTRvMU8yMjVzUHhUSWVsS3pqM2hs?=
 =?utf-8?B?L2ZWby90aHc0Y1NUYnY1RzRZL0Jaam9BZnJmZzRRMEJ4VWRKSmQwN2RXRzNa?=
 =?utf-8?B?bmtiUWlMNWhqdkRRQmtpV1R2bE85em5uejY0QW90S1RaY2cwS2Jic2VLZ3Mw?=
 =?utf-8?B?UkFvaFd1MGRscmtkRFo5a2RKbGpHMnc4aFFHZVREMkR2aVVCb0E2OU5NZ3hj?=
 =?utf-8?B?UVlobXVSc2U1NlQveEFBbmxjaUs1V21WbGEySXFNSCtxOVVFVHpCaTJSQ3Js?=
 =?utf-8?B?aDE4Y2k4L0JrWEQvOHZ3Z2tVUVM0T1MxMUEzTFc3QTNCd1NkQWoxZklPT1hU?=
 =?utf-8?B?QytuYkM3Y0F1U2hqZjBibFpjNTdnMWFCVTBqMGczdzJSSWU5WkNpQ1hkSzlw?=
 =?utf-8?B?UWVraGlZbUd2eWtTSUk3Q21JSGRtVnJPdmtSTnBYQkdIbnlxYm1zQnZkclc0?=
 =?utf-8?B?NVVwVTNJWXFaQzFyeGx4WjFSQ3hWNExnZGNkZWFSWE52VEJUMGxQVUNXS09a?=
 =?utf-8?B?cU42czhCUml2SzJzTVRzL3BzWFJmaEsvdmJxNHVsb3ZmNEtwZFZJRy96a1J1?=
 =?utf-8?B?WGhCdTVEcWM5UitsUWZHNnJqdGxaZjZ1RWhPTGdTV0pKbklTSDZtY216WUVP?=
 =?utf-8?B?U1VLMVYranFjdDRJaklZeThMRElVVmtQM0hPa25yL29Rdk9DM2VNaEFoQzM3?=
 =?utf-8?B?UmdUMU05ZTRtNGdqUEM1aGh1UGJuNHFJNUc3TmRldm9EUXNKTFBSMWZDaHNo?=
 =?utf-8?B?aFNWT2p2QTlvMExHR2tXWEVVeENrVENuTS9EZHl4eU5nQThOeEQ5R09ta1pD?=
 =?utf-8?B?K3BaSkxGYThuc0JtUWYzdyt5RDJzOXpuNWFGemZKbWdldTR3MEh6T0lSOGhQ?=
 =?utf-8?B?ZjNpNzN3eEZvbFFvdDJ6dlRJelcxdGtmc2wxNUxvcDEzemxSenA0VHhqWGkw?=
 =?utf-8?B?RUg0LzF1UWluYVN6RHJsT3p0TUhOT0w3andobzhVNkpPVTNCSE9SWFBkZzFV?=
 =?utf-8?B?ck90YTJ2RXVzVGVvMWgrNHZoOEN3QnhzeVJ2VFNjMXBYRjFCaTdya3c5MnRr?=
 =?utf-8?B?SkZyWWVIUGVSUUZYTlh1Y1YrMUNsTVlIYUdLZFdoalVtUzJ0YTR4NWs0WFVX?=
 =?utf-8?B?Mlp4OHg2cVRsWERGRmlZV2VGRDhTSndaSHlCbC8rZU8zUW9qOGlzcTlyWmVn?=
 =?utf-8?B?MlplZjRqR1Z5SGZwQkV6WjZEM3FDaS84aS9CTTdOaEFXTWY4a3F6alJYSGl2?=
 =?utf-8?B?R1lhdUdOUFV3RVF6WGMyNnB5b3owS1hjTzhtampKZUI5TG85bnRRME84WllO?=
 =?utf-8?B?Y2YzN1RlWlRvOHJNYkp0MWhuNUxSaVJ1dnEwNU5LZ2VaY2hGdHJNZ0dJemJw?=
 =?utf-8?B?VGhoTTVrVlI5RTJnTVZMOENRbHR3RDdONkoraFFIcjBCdjJVOW12d0w3Rndw?=
 =?utf-8?B?Zi9oMkZpa1NWUTBqYURxUEFPVnhpTHlkam1XM0ZLdG1pdjdQb0JXeFYrNVJN?=
 =?utf-8?B?NCtZQVNsVSt5RmRqUGFKR2p2aFU2enJDbm9PWHg4SFpVUHFqRDk4SmpwSlJl?=
 =?utf-8?B?UVdrR2FWYktudWpRN1F4aVdmY0xia0x0TURTQWpFVDBxRDFvU1VvRWtEM1ZB?=
 =?utf-8?Q?x6x44teZBD/SK7wFyiyIzowUH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f49c2a-a508-4f89-c345-08dc34c294f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:55:50.8369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJwMwBQNW8WM0KAVZ7enGjNr7VzSuZEByI4qZTrFdyVxSTNAm8r0YP1rmcKEqgT2Z92tVK+LiE4BrfpvuBM6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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


On 2024-02-23 14:05, Laurent Morichetti wrote:
> In a future commit, the cwsr trap handler code size for gfx10.1 will
> increase to slightly above the one page mark. Since the TMA does not
> need to be page aligned, and only 2 pointers are stored in it, push
> the TMA offset by 2 KiB and keep the TBA+TMA reserved memory size
> to two pages.
>
> Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 23 ++++++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 +++---
>   2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4d399c0c8a57..041ec3de55e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -466,34 +466,43 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
>   {
>   	if (cwsr_enable && kfd->device_info.supports_cwsr) {
>   		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
>   		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
>   		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
>   		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
>   		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
>   		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
>   		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(11, 0, 0)) {
> -			BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) > PAGE_SIZE);
> +			BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex)
> +					     > KFD_CWSR_TMA_OFFSET);
>   			kfd->cwsr_isa = cwsr_trap_gfx10_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx10_hex);
>   		} else {
> +			/* The gfx11 cwsr trap handler must fit inside a single
> +			   page. */
>   			BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
>   			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
>   			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 80320b8603fc..42d40560cd30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -99,11 +99,11 @@
>   /*
>    * Size of the per-process TBA+TMA buffer: 2 pages
>    *
> - * The first page is the TBA used for the CWSR ISA code. The second
> - * page is used as TMA for user-mode trap handler setup in daisy-chain mode.
> + * The first chunk is the TBA used for the CWSR ISA code. The second
> + * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>    */
>   #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> -#define KFD_CWSR_TMA_OFFSET PAGE_SIZE
> +#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
>   
>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE		\
>   	(KFD_MAX_NUM_OF_PROCESSES *			\
>
> base-commit: 420b2460a743b320868f30e407d4c4685958ea2c
