Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECC1CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632D510E1C0;
	Wed, 29 Oct 2025 10:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYafto5K";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BA110E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcluCCKis6Fhm3giEEyu/zxfR08oUZGl2Z6KiZO82uzDqf67+s3XqK/eHRijChfw6szmU5c+iPPJWOKJqK8fAGTE3W5zFgKg2r2VgvQMDFmF2tsA1qF8XQ1rhKbq1VzKQSXZYtj3uDwQ89FuWGBIdqlAPGmyg4j44HPIiGp5GERfZiJuNg4P+QR0z7GMLPYt/EiTVJbqWVr1YibwDvxrLPCXRgFLoSxSr6SBZR9lbun4AACrzwoRh1KTGbH7VN/aEmwvYuxeh2bu7oTH7H8uwBiqDBI12b8oOY+CGn2nW4EA1pfjZfC/fzyRRqjfUiB0ItzbJOFYbSBEwQZYAh7N9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LilJSMAA2soC1X/ZOPu5/ePi6388UIHgXcnLgC/6xZg=;
 b=BCppseK+5KizXHIkKm2Po4xBo8bRb/bnLqd7RrWdYfVWAnlSB/fFWDuQrG1/cW87kpezEvm/fLBhdtrFAI3CzBFUAeRQLIhDwfvtqIwC2S6si9CW/2U/wt5reG3EDkF3lP3LvgiI0shvo7ZT1R4GgiNXm50mpTbENULs5kKVwQct3Cxpp2wvu63KDhdkGwjh3cfuJijPcxLb5juFSDGclh2efjNPtymNrRHxFxWRNUmpB9gKSF3HtH4r++ADw13DAjCTbUB9Ju5E1mTJBxcnYBfDSeDIKd0SjlB0/TCQ1BsSM5dLBNi2TH7hXTQ5HcUOjX9LEUXPq1h1rZyEzeSjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LilJSMAA2soC1X/ZOPu5/ePi6388UIHgXcnLgC/6xZg=;
 b=EYafto5KrI8qdp2NZKry/hfZgAeMBXF0wz5AEPjvCeGtwg3uTV9V6VbkexIb2Cr+GmyP7bmjcIhNlq+pL7uzFIbL8N61tVC7VvQTjFF9/NTNzkLSrkPeY66rcpRKk603Bd0NNpfuvdY+TCG+BH1SSnbdMLtPV7S8NkEv+NOFt18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:16:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:16:11 +0000
Message-ID: <4685c497-7e29-4245-9960-db572bdb83f9@amd.com>
Date: Wed, 29 Oct 2025 11:16:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] drm/amdgpu/gart: Add helper to bind VRAM BO
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: fba3ac9e-6e01-4cc8-1505-08de16d42f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlJsZXU1Ry9WREZGTzF5aWFvd0phYVhTcUltVlc2TnBZcFhQSU1oUlBNbWJi?=
 =?utf-8?B?dmtHbUtTaWhjSDc0YlQ5NmdSeUNmOXg4NE1VVk94dDJJcDllcmlQdVUzcmhV?=
 =?utf-8?B?UkpGc2YzdnVEZnVtcmw1QXhvMm1CL05yRm1kSGNJOHZhbFJCVlk4NjVOSUxL?=
 =?utf-8?B?VHN3ZTloRnEwNlIxZ1NBdXNINURSZ1d5WXFlZEp2QmtNL0k4RzNyVUpQTjRh?=
 =?utf-8?B?WVlrYXZFbmoxemNId3lLZERPQ3Q4Lyt3ZWRqT2lKd0JlNnBEaVZ4SS85RlZl?=
 =?utf-8?B?UHpmRVRmeHAxSDQ2YVlEM0RBVWJRK05IOTVoTy9iZkNIUmQ1bHVKUGk4YllK?=
 =?utf-8?B?WlE3TGdGL3JNZlkySW5DYWUrejgwTzgxNXZIdWhCUExIT0FwalNrTldROEp6?=
 =?utf-8?B?YTdxZjBJa0tPSC9Lai80OWY3eTlUUGt4TXRFMGdoR0NlMWFuYjlYMGxsVlNj?=
 =?utf-8?B?a2FmTWJ2VzZuV284VDBia1ZaalRHWmh2RUNOeG12czhPMXZzc296VmROTm5s?=
 =?utf-8?B?YTRrTVN5RFpNT0QvdUZxYUF5UTZnQkZ5VTB6ZkhRd3BWa2tQV3FrMTltMTVU?=
 =?utf-8?B?UUNleGpiMkppUGpXTjk2U0Q0dGdLVjR5eWErSUZUNXd0TUF2SkNzYk9vMHU0?=
 =?utf-8?B?Y0p6TldaN2VnVmkxRXdOSElzUzJSSGNRMjBlN1EzMDN4RU1FNy94Z3YzUDM2?=
 =?utf-8?B?Z2JTbUIyY25jbzFYYzJPbGZzNUFHMVRBV05PcnpLRmltZ0hnQjhON0hnKzNm?=
 =?utf-8?B?cWFEc092SFBrYU45RWJLSmlkSktxT3hUQVp5VFFIaTlWbkYrT0NDUEMwSTdt?=
 =?utf-8?B?TU5pOGcrRnJyY0N0T01POWtwd1lrbW1rVk1sYmFOWGFzVFZmOStHOFdIeTlB?=
 =?utf-8?B?ZUdtTnFpblVwVkVkMkxPQldwZ2t5aGtxYkNDcUxMcGxsK1dXMzRJQ0diNTl3?=
 =?utf-8?B?cEwyS0kxNEc2VGN0aXZHOUE2MTRYV01Bc3g1UDhUWnpZU3pRa2Z1ZlU3WVJO?=
 =?utf-8?B?YnloTkZyU0E5ZEh2UVFNcjVWc1VuZkZEL0xVVWNWbVRHaGZNNGNkSFd3bkR2?=
 =?utf-8?B?MkVmNXhPSWdiTVQzVVh6OW5ISEZCRll1dldLNm8yY2xoa2VDcGU1elR2MDZW?=
 =?utf-8?B?dGdHWENEVlVoUTMvSUVTREpzVlpWMklWc0hDbHY5MHJVRXFMdEZ5MHFuckRX?=
 =?utf-8?B?T3h2QjFXRHhkeWc4QlRidGhBNVMxWTdIZVh2V1lqRlB0NlhSYTVBUTZRMDJR?=
 =?utf-8?B?dExsb0JSazk2TVVNVG53TThmMXhBVFk5QjFnYUxPekEwOHlSejNkYVhvbFlP?=
 =?utf-8?B?Tm01T3BwUGdYQ0NBcDJnQnJKVndsKzQ0NHdpalBZVWlxcndJbWJVUkJCZ3Fa?=
 =?utf-8?B?MUdEOTJRdE5iMm0xc2Fac0RzbHJ5MWpJRGpzT210aklZb3dVSXo4Ky9kMzBM?=
 =?utf-8?B?bXJzNEZpTE81ck11eHhFTHVjdFFrb2QxbFVEeW55OTMrMFprMUJ6Wi9TQkt0?=
 =?utf-8?B?Skc3SzFqd2dWYjlJckJlRjdJRDZ3cWxERi8wUXVjSnFCTGNQNWVlTzYvV3d2?=
 =?utf-8?B?amxSSzdLMUxxdjdTOHhuKzJ6VmxuaEUwbnpqSTE5aXBhKzRQRFhHQUUzOGo2?=
 =?utf-8?B?YnMwa0JxN2lRRWYvdkNQWkxqU3ZZVEFGT3hNOE0vUU9tNld3dWFIWUo1TjJ2?=
 =?utf-8?B?Uk1hamttUUw2MW1KR0VHOWdZZGh1Y2dsSDEvNUtJaXlPbHdtd2dXOEJpcHFy?=
 =?utf-8?B?MjJNV3lld0Y3Z3YvQnJuWFprREVwc0NBaEFJUnJCK3ZVVXN6T3FidXg0bEs2?=
 =?utf-8?B?VlF1d1FuY1ZFSzVyenp1OE9NL1VJNkxTbFR0YmU2Q0pSb2tyOUkrSloyUzVi?=
 =?utf-8?B?VDYvallKUUdpektZbW51TFVUL1dGTFliZndPM1BtbForTGU4d2JTbGdhVkts?=
 =?utf-8?Q?BJU8pd8rUTKKXoqVT+pHSFKtWZIsc+/M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0g4cngwSW1WZ3RhanJkQ01iM0p2eWVpb0JuQm5pSkNVSHduU0lVSUtraVBz?=
 =?utf-8?B?KzV6alJPU0pXUVlkK1VMSWF6RnJINWxKRUJ6WWNZMW1HM2llVzRad3lHcHNo?=
 =?utf-8?B?eDM0Ykk5Zkt6UmtCUlJJcXRZc1FYbmswSmpHSEphNkZYK0VtSG5GU20vMndI?=
 =?utf-8?B?aldlWHVuR2dLR2U3eGJKb25NL2xFRHNpeVYwVU51UU9VeDgvY05JVW85M2Z5?=
 =?utf-8?B?dktKZjRwMlU2ekQ4SUJvamJlNWR3SWY4NGhpYUZDcTc2RCtqYnhMK1htVTJw?=
 =?utf-8?B?aWZ6NjIvSWpCSXVrVU0wek53ODB4akQwdzhuUGNVOTB0YTRGcHV2U1RSeW9E?=
 =?utf-8?B?K3ppWUIyckJoa3FWeVNzYThIU2RPWWw4Q1VkcTI3VVIvYnZmc2JsRkpxNnJO?=
 =?utf-8?B?ekJKWGtoRmZRWFpETVF3VXVEYUMxMkxWM0t3SER6UlMyTGc2a0FxLzVVa3ly?=
 =?utf-8?B?cU1ZTjIzKzdXZXJNdDcyL09CV0V5aHl3Z3VpM0QwVTVRSTlLT21SaWdkRkV0?=
 =?utf-8?B?L3lzZ0hRYklDTFBlbHhOdmtmaWlVY2NMTndnK203cjNubVMvSDIrczgvYjBn?=
 =?utf-8?B?ZzdXNzdzeUVOSHhid0NxUDFhYW54OFVUeGxoN0NveDRKM2Z6ZXZjbnN1Ri9i?=
 =?utf-8?B?N0RFRzBZMmdGV3hWT3BCWm9jLzBwVHlTTFRHSVFnMldsVHZqLzlTSHFVMWR6?=
 =?utf-8?B?a0l6ZlRFUnlQVis0cm1SNXpITzF3bGg3eXZFQlFXRDdpRVZnbXUzMDBsd1Jx?=
 =?utf-8?B?eXdrSWlkY2V2Mlo5SkliNjk3Q1l3cnFkUlpic0Y4MmdwcWlsMUFmQTk2bFB4?=
 =?utf-8?B?SFo3QkpvN3J5amxacW8zWjM3S1Qzem9LYk83d3IyN0VaTTgvOTVxc2dsYjAz?=
 =?utf-8?B?aVNWV1FFSnJkS3hRRUp4QmNoZndvdjJkaXJDcU5HMlFwQ0dlM1BYRlk2U1RN?=
 =?utf-8?B?Slc0RVc1S2dkYVpGYVNjd2dnZXQ3VlVoY1Vta1ZoUGg0QU1aMXRmWnZydE04?=
 =?utf-8?B?aWd3UnlQK2o1Rkl4YTdvYmNsODZaUHlLVGlOS3lwMitJWkRtVTBBaCtjVHZX?=
 =?utf-8?B?S1VGL2NEdXNmWVNPdVlUcUNHZ21PQ2t5UkUxU3lhVm5YS2s4YWJaY0RvbWpZ?=
 =?utf-8?B?amFxN29RYURIZ3dRUm5xN3NIWGVWTTNmL2gwZEZpV1RoMXl0V0lHMHVlT2pX?=
 =?utf-8?B?R3o4MTNpM2JtV2hqR2N5VmZEdnNLUDRMb1djQU44d2M5eVBWNmx4Z0ZGSUto?=
 =?utf-8?B?VHhreFdqVVVRMWQ5RTRidnpndHdFMmYrdlBrZ0ozbC9OUFRUQy8rWDJvTGNQ?=
 =?utf-8?B?TnhTdlJaNFNKalpObTJOZjJaYnI4MEp3TjlEY29pMmJQMFhIQU56UWl0YnlF?=
 =?utf-8?B?TzRrMGZ3dS9hUlJkL1JaSy90bjUzLzZyQmNCUVd2cnMxZVBSc0pGdEZZUytC?=
 =?utf-8?B?RGFrY2hJVmxoVkZUaUJkcWY2RHNKSmN1TTlFMnN5VjlGNENwNVNaR1hpa256?=
 =?utf-8?B?a0xtUjBUZzVVT3FRb3dIVVpBdEExSnVIemVXckFaeGtSSk9ENElMMHJqVlhK?=
 =?utf-8?B?b3RWU1h3aWc2akZ6eTJhbDkrT2wwZmt4aTFRcnFOMjRiQnFpdEFucTJQc2hT?=
 =?utf-8?B?UjdXSXRsbnNiOG5NQnRtK3lBRjk2R28zQzNTMXpUaU9WdHhRZGF1TVVzcVBp?=
 =?utf-8?B?cnFiOWg1a2piSkdiNm4xUmQwSEJGVHdFNmlNT3VLb2ExOXBzWTViNnlRdDd2?=
 =?utf-8?B?RE9uN3N0V09rZmtSakhLSDZxRjUrc2xqOHM3SGVKaGVJT3NjWTRFWXZHaEZr?=
 =?utf-8?B?bVJRdmNGU0hkRjhDM2RVcXVIUlNyb3kxcENHSzNWOFQ2RTFGRDdhZkt4cHRZ?=
 =?utf-8?B?OXRtc1JaZHpXanVjUFlFVmcwSHFnNk5kanZ6aU5iN0VHMHFCWUZ0MWVDcmw2?=
 =?utf-8?B?QUM2MjViYXdoOGJoYVpNdHhzY3dMUkR4R2dXK2dmUUxmL2dtem9FMVhPSXZE?=
 =?utf-8?B?Rk80RDBISWc3c0ZMUTZLemdEdi9mdHhlbFZWa3JML0dnS0wrQjZUS3NUZmJV?=
 =?utf-8?B?SG56UDZoMC9NR1BuUUxvNGFlbFhHRUJhNldoa0RuZ2ttMzAxekZjUGU0Vk1t?=
 =?utf-8?Q?JsE7ZRaXsKp6sBAyeelBGEkh0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba3ac9e-6e01-4cc8-1505-08de16d42f41
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:16:11.6163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dXxE97wkKy/Mxoc/i/8uxfNoPZlYaztdzWXxEI6FEDgdywLGbcDC4X+EyDbg33Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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



On 10/28/25 23:06, Timur Kristóf wrote:
> Binds a BO that is allocated in VRAM to the GART page table.
> 
> Useful when a kernel BO is located in VRAM but
> needs to be accessed from the GART address space,
> for example to give a kernel BO a 32-bit address
> when GART is placed in LOW address space.
> 
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 41 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 83f3b94ed975..19b5e72a6a26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -390,6 +390,47 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>  	amdgpu_gart_map(adev, offset, pages, dma_addr, flags, adev->gart.ptr);
>  }
>  
> +/**
> + * amdgpu_gart_bind - bind VRAM BO into the GART page table

That should be the function name or otherwise you get automated warnings.

> + *
> + * @adev: amdgpu_device pointer
> + * @offset: offset into the GPU's gart aperture
> + * @bo: the BO whose pages should be mapped
> + * @flags: page table entry flags
> + *
> + * Binds a BO that is allocated in VRAM to the GART page table
> + * (all ASICs).
> + * Useful when a kernel BO is located in VRAM but
> + * needs to be accessed from the GART address space,
> + * for example to give a kernel BO a 32-bit address
> + * when GART is placed in LOW address space.
> + */
> +void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t offset,
> +		     struct amdgpu_bo *bo, uint64_t flags)

Please not the BO but just the VRAM pa.

> +{
> +	u64 pa, bo_size;
> +	u32 num_pages, start_page, i, idx;
> +
> +	if (!adev->gart.ptr)
> +		return;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return;
> +
> +	pa = amdgpu_gmc_vram_pa(adev, bo);
> +	bo_size = amdgpu_bo_size(bo);
> +	num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
> +	start_page = offset / AMDGPU_GPU_PAGE_SIZE;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> +			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
> +	}
> +

Ideally amdgpu_gart_map() should be able to take both dma_addr array or VRAM pa (or have two map functions).

This way we could cleanup the code in amdgpu_ttm_map_buffer as well.


> +	amdgpu_gart_invalidate_tlb(adev);

IIRC we moved that out of amdgpu_gart_bind(), probably best to do so here as well.

Regards,
Christian.

> +	drm_dev_exit(idx);
> +}
> +
>  /**
>   * amdgpu_gart_invalidate_tlb - invalidate gart TLB
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index 7cc980bf4725..756548d0b520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -64,5 +64,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>  		     void *dst);
>  void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>  		      int pages, dma_addr_t *dma_addr, uint64_t flags);
> +void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t offset,
> +		     struct amdgpu_bo *bo, uint64_t flags);
>  void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>  #endif

