Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C72E77188
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 08:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE2A10E235;
	Wed, 18 Dec 2024 08:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IhrErl20";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2862110E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 08:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2TZXcJE8cIhSSLgaNIsBFnlT2kSJPTC1IUHo7Rw6UZB1KsFOcC6yESuzB74xlxMOXmXktQ/e7vQtUzqnR5hAh70t3uLRl9t4csygIG5OJZJVwsxcy/gYh49B0Vn1Bm+29O9Lp8CMNdYdY4Kt3CU/+Tp+hfra3k4OvlHapbWGmfOQyNJnAf7oIcvQ0bWzt2jrPUBQc0WyCDE6SsJCErXoTmq6Yr48+BdxGETrN0uN/BUEJTNZwX5ZQqGQez60/ryio3o/YToJrGBXxMbXH+UDWDJpcCvJ7ufkzlrHRNdVaNJYVRvVvAd6hZ3NyAutUjb2zqa0B/aQAQwCyKUUZDCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zrqPRRKzYC+yi7NohlDcO4PClu6fqRVLzyn7izDEpI=;
 b=JDblgIkBMx8jq8GrIwFPijVw0dFrjrf3UWMGccnyGxjm78mlHG7AC5UTXAdUbRfqi7Jiv7gtQVX3EwoxnjPtqVhfiC79shvTh+t4U55kXRTevcH5NLVFtfgdxR6TyVz1h3wm7aW/XR/mY5G9Pstp0f6CFWKqaTwqrW6DLEuW5aowUaATnNIh3mi2oXWk8UrZ4boK0jBaiPJDsZ/JidB1szOgRer+xSHauJLNz7wlBDluiIAAg3ReoGM99nVRFPmt6oLPDbPvlOzTbos3o1j4ACpgPjPQzdZIpDuYnVfHZpIgpK08RssytRwCyFh1LpEh9ZTi/+bmfYB0kPbaGblJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zrqPRRKzYC+yi7NohlDcO4PClu6fqRVLzyn7izDEpI=;
 b=IhrErl20ricnciPDg9CqEAxHRsK7qTUqd4PCUJjKx/lYxvg265PLW0UW7A0UFhOxvkq5ztW9U9ReeV1y++89YGr+gApb9NXzIHonR50Y5QMsh6vUyBr2EX4n47GcWxaxxexUUuDnvvA1GueQ77LI+oYzttu/phaLIBWYPYf7L10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Wed, 18 Dec 2024 08:36:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 08:36:02 +0000
Message-ID: <cd449c1c-7885-451e-8b15-7f8fd9f84217@amd.com>
Date: Wed, 18 Dec 2024 14:05:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Driver needn't request RLC safe mode for gfx
 MGCG
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241218073154.843863-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241218073154.843863-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 761dea4e-2b8c-4a86-d72f-08dd1f3f00f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5PdHBnbCtKR1dHVzc5d2R4OTVoWFRTQ2Y4Njl6YlhvcGd0Ylk3b1FVNnFo?=
 =?utf-8?B?Q294N3lkaE4rMlJMZmRaSDZHWWVpZ1BHZFdnN0JCUGJWVnA1bmpVd3RGOHox?=
 =?utf-8?B?aUpwRGVOaXpXYTFVdGFpMzB5M3RiRnpyZWhyWmRMN09MVVdXNTVKNklhUVQx?=
 =?utf-8?B?U09FV3FDUDM1V1laS3FpNHRwd213N0F1WkkzOC9NY3pWNXFNYU12anhMYytW?=
 =?utf-8?B?K2NFRXhTTGpOUndxRElwNTJSMmJFQlpEZmF5V2docHpJR3JvajBoZmxkRENV?=
 =?utf-8?B?UE5XMnU2MW53cGQ4Z1UybmovbG9aSEJXYVA5NjVuT1dkSVZMTTBHN0NWYzQr?=
 =?utf-8?B?eW1ZT1F3UEViMTFXRHRCOHE5TEJlZDM5ZDNIM3hIRXNlVUJqbUJaVkczTDdX?=
 =?utf-8?B?MmdKWThMMGo3RzE2bG5nRGp6Y29hNGdDT2h5aDRkM2JSL2QzeVpxenM3TFhx?=
 =?utf-8?B?QWg3SUszdG9jZ2xrMmtKSjBjQmUzdFk2elBzVVNZZ3NrU29ZR3dEeS9IODZl?=
 =?utf-8?B?bVNDNDI3Vm0zbU0rMHpxa1IwQnZudWdtWkZRL3htTVBYZDFHdzNTdlZtYmd3?=
 =?utf-8?B?VmU0OG9sYlo3U2VqcVlUZVFLY1ZMMklsOUFoRzNacXhIOUhoZlBKQ0hCYjZP?=
 =?utf-8?B?TXc0NkMxc1hDaU1DdkhOT1ljVUI4QnY3RWptMEI1Y0dYQnlJdUM4MURhTWhK?=
 =?utf-8?B?anMvL1d0aUZsOE9lbERGNjB3ZzlDcVJjQ25FWUppcHl5dzFlV0ZNajBSYWl6?=
 =?utf-8?B?YUxZNDAxY055QVJib2tnWHppeWRCZEphbG1tQ0NsRTNndUpuS3dmbFdDQU1H?=
 =?utf-8?B?VjdEblBURHFudzNiU1N1U0p6RmhmSkNqSEo0K2V2N3Z3N1Y4djhhMFpXR3FO?=
 =?utf-8?B?eDN4MHkvblpxcVZVUjcyVUtaNkhZaVg0cVNJd3lPeWNLWVMyVkNrNGxSMmZa?=
 =?utf-8?B?K1VYbkkwUHR0UVVDR2U3bUoyYWFqbksrR3VrMTl1YkZ3d1FVdE5KS1dVWVhD?=
 =?utf-8?B?bUxyWDZVQ2pmNW0rVnBBaGljV3ozVC94cFAvY1FNWHhCVGlwWnhXZWJnNnpH?=
 =?utf-8?B?QjdsN0FGckJJR1lxdHduUmpYNTE3Q2V2WUowS0dHbjJDZ2xoZlphdnZGM3da?=
 =?utf-8?B?QWRMWENuVklqNjlvZUJnQlpWV1V2SnFUVVR1ZWJkdG42c1ZLL2U1OW5qZFo3?=
 =?utf-8?B?eW9qNE9FWmVhdUdydTJZZC9WeE5UZm8xRXpzeUh5Tk82WmVZWm83SVhmWFZm?=
 =?utf-8?B?NTBvL0w0VDNCVkZmTXJDSjZiZFpuQUNTdUFMY3E1RFZaOGRUYjJESHF6VjVy?=
 =?utf-8?B?WHpyMkJ2WkFpclo3OWNmQkg1RSs1eUlGcnVNN3hYc28xTjZaU20xcGkxcjJY?=
 =?utf-8?B?VG5LRytIRU9HVzBoak5GRTFvVzNFL3VEL0JlaE5zKzA2TEdpRXo5N1ZCUFZ0?=
 =?utf-8?B?ZUNOdW9QeDViMSt4WXVFOWNzWnMyMVAxRUd0cFJ0cFBobXZEVWp5RGY2NTFR?=
 =?utf-8?B?cEZObEZWRkFCUG1EYVZQSDBBeng4ODBWOUtiMlBZNzJwR1lnUjNsK2cyMkdN?=
 =?utf-8?B?eXUwK1J5SDh0L1FnbUowVlFNZFpzeXlpYjQzdDRHdStScWVQcnlCSEtOb0xq?=
 =?utf-8?B?bnJkbTdSUUMrUzhKNDFXYWhuZjNvR1dKU0hyL2F6aTV1ck1QN3VYT0x6aCto?=
 =?utf-8?B?ZGdwcEh4cCtVVlNhNHlLQlBhaGZOQlJ2UTBoWXlHY3JkOUNxUUZHM2pKaS9H?=
 =?utf-8?B?WGhPdUlkTkpnczRkUGN1dFoxR0EyVU5VNGYxM1hWdFoxb2Jvcjkyak9QK0NR?=
 =?utf-8?B?UFdSZ3ZoenU4cWtGV25RUXNJTjNqckJoYUl3b29PSkZtbHFUZ2x3UTZKOStJ?=
 =?utf-8?Q?mp72/pMCXHF51?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlLWkRXcXFQUElQM3gxaXQzVEQ2ZTBwdTNvZVZjdVREdTdaV2Z4aWNZcWpO?=
 =?utf-8?B?enZKRjBWMk9FQ2RkMzVCUGs3VWtkNVRQeUQyUUNzakdNZGdNNmRlSElqZHNL?=
 =?utf-8?B?a2J6ZDhqYzIrSWM4REgwOEFIMnpQTVl6cndzT2RHd3RHN2srS05nUnBnNjVm?=
 =?utf-8?B?VFU3cnNLTHRMeHpwZDUxN0Nkd0xQWW1wcTNxNnpwd1JlbGNib01ZM1BZV2RM?=
 =?utf-8?B?NzJQYTdOSDNnZWlVaDBwNmNveEhJWG5mM25yR3UrdXdZWFYvZDd3TTNvTEFy?=
 =?utf-8?B?ZW1WZm10VFFCVDlHc0lsektxcnZGNUtPem9BZ2kva1VSL2NhSWhmR092dnJC?=
 =?utf-8?B?amNhSWZlbXl6K3I5QXpQM0UwWVg1aEUvbDJGTW4rOEtzL0F5UkI2NC9YWWta?=
 =?utf-8?B?T0ZWcXF0S1N3dmFKeGFQcXVQM3owMWFwMlRkelJKMnhnU2VYMXlteFBiWUNj?=
 =?utf-8?B?U0U1SGxOOE9uQnhrZ3JBL3JOM1VRekZQd0R2OExBOGFkQVZQeDc1b3kwRVU3?=
 =?utf-8?B?Wnprc0dvbGZnWGVJYUhwRkp3S3hPdUVXMTNTV3kvVXJWWnFIKzJqYVIzYWlr?=
 =?utf-8?B?VmFoQmFPa1FUdFBtNTRGZUM3b2YvZ2ZFNXZ4M0RKMFhLc2FRdnQvUEkyNU14?=
 =?utf-8?B?RjEzZlptNjhTYjBqNkFOY3cxWkRtd1lZYXdTai9tbUVEQm9NdkNtSkdBalht?=
 =?utf-8?B?TWowa3kvZkFicDQ1Z3NaR1hlMUFBS293dzBKYjFNc2hiTzRURXQ3WHIwaFJi?=
 =?utf-8?B?MTQ0V0IzRUVkV3lDd0lSSlRVUHhiYWF2UCsvaDcwL2FTeC9hbHJDUmRsSDNT?=
 =?utf-8?B?ZXdXVTl1WG1KQ3dGZjVhRi9qbkp3SnVxTkxDMEE4bWFiZWRZZ3N6bk1MOG9n?=
 =?utf-8?B?QlFpU3JxWjZFMjhzb2N2YUlsRTl2cmRvdldDYzF0bmJjbzduREFQVGdnOVpv?=
 =?utf-8?B?Ty84WVArWnNyQnRBQ3ZUS3ExRGtHMklBbVVwbEtsOVdKWjY5UkZ5Z21jcFZ2?=
 =?utf-8?B?LzE1MUdwRWV6YXpPYU9VZm1QMXdKNkZqeWxiSGxUKzJ6aXhGMWZZUXBmQkFO?=
 =?utf-8?B?VktRck16ejQreWV6cmFkVnNQeGtQd1hBeUJVejBQN0JBU2NyTnF6M01pY2Zm?=
 =?utf-8?B?TU5ERzREbTUzSXZwT1NQNWJadUtkZlBtMEkxRG4vWDV6bUFzcmlJSExGcStx?=
 =?utf-8?B?VmQwd3pjdUFTYmRPYU1IcnZkS05jQ1c3YzBIOGF5YmtTRWdWcU93akR6cDFM?=
 =?utf-8?B?MTkxUVo5UmxiNlhwR3FiZk5ITEoydFoyaEVyMjc5Zkh1NnhtSHR6Zng2WVRH?=
 =?utf-8?B?TVJWNEZSbzNob0NCeHJVWGtRb1YzWlQvS1RIelhkbkpRdU0wbDVqL05LOElK?=
 =?utf-8?B?U0VsTjJnMWo0Yjl5d1h5VDczdloxNytrVUNEY3pQWmQvYXcrTDRsa2tibUYy?=
 =?utf-8?B?L3JYRklZK1dRSlFwOXc0MnFaaFFpWlhQWHBxRHJVSUVZWk9yelN1TFdpYjB4?=
 =?utf-8?B?V2h5Ri9aT0RVaWlsK25IS1lRYmN6eGI1elBtVDNoUkdIZDhrYmZucFRZcTRW?=
 =?utf-8?B?bTh3TlkxeW5uelJTRW9scDhWTS9TL3FFYi9aajNxeHNIWXJpTi9zOEVjWDZz?=
 =?utf-8?B?elBlWkZBODFyNFJpaUlFejl1Uzk3Sjc5QmdEdjRtYm5kYjFtK0xydHRFME1K?=
 =?utf-8?B?eGJGSXRHSlVwcUN2THBkczdtUnRpVkpBTWxvcFMzYS9VY29YNnA4TFBwdW5k?=
 =?utf-8?B?NnlaZkFIVk53b1l2bHNrZVF0dlU3UUhMeU5kL0t2OFFmNlJlSWJrYy9xd0l4?=
 =?utf-8?B?WW1JUDU1amFiUk43OVJBUlJuU3A3RWpDN1BjSk1QQzBVaU82MkQ2RC9Gbjdi?=
 =?utf-8?B?UFJXUEhBVEMwOWpROHRLenVqREpJOG83NTBZSi9jRGVNYXFBc1IwK2JtWjF6?=
 =?utf-8?B?dUFsTmljK1c5bG9WQkdZaVNhUloxWk1USTFqSzRKakpOSFZIS1BzSzhsTWNM?=
 =?utf-8?B?V1JpaktteGpveCtjcm9JbjV5QmIwNFVVYlZJR3ZSbmticnpHWm5HZlNtT3Q0?=
 =?utf-8?B?M29uazhpM2xjR2pVYmpBSGRGeWM3M01uMEV0L2FvVW5OMW1RZ1VKblVSUnRq?=
 =?utf-8?Q?Mq3hdaivNtwN3dGLxl81oQja1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761dea4e-2b8c-4a86-d72f-08dd1f3f00f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:36:02.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDh7Relqf5gJvntihHbZ4BX2wHQ09gmh1hUDmbID27xX3i5o9PqUOIWsGpL44NFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
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



On 12/18/2024 1:01 PM, Prike Liang wrote:
> In accordance with the MGCG HW sequence, there is no need for
> the driver to request safe mode before enabling GFX MGCG. For
> GFX10 and later versions, maintaining safe mode is acceptable
> for GFX MGCG; otherwise, there will be an increased overhead
> during safe mode entry and exit when enabling other GFX clock
> gating. So now this change only apply gfx9 and gfx8, and without
> polling safe mode, the time required for GFX MGCG entry and exit
> will be reduced on GFX9 and GFX8 systems.
> 

The only place these get called is *update_gfx_clock_gating(). So it's
better to keep a single safe mode/entry exit for that rather than
keeping it separately for each function call within that.

For gfx_v8.0, somehow reference sequences use RLC safe mode entry/exit
for MGCG.

Thanks,
Lijo

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index af73f85527b7..690235dafec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5639,8 +5639,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  {
>  	uint32_t temp, data;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	/* It is disabled by HW by default */
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
> @@ -5734,8 +5732,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  		/* 7- wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
>  		gfx_v8_0_wait_for_rlc_serdes(adev);
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4b5006dc3d34..6dec5383ba17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4964,8 +4964,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  {
>  	uint32_t data, def;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	/* It is disabled by HW by default */
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>  		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
> @@ -5030,8 +5028,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
>  		}
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,

