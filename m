Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4219C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 03:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BC510E17E;
	Tue, 18 Feb 2025 03:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QIr2Gnsy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1855510E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 03:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNIsILy3Xr0IN3I0xZBpv3IHm58gN3UokS6Rc4+icIWSjQgicI564W9hQH659yw+vT+eHPrSLznFe0N/y0snr8lEzpBS6x4nWKbGf4HqEMy9wxTj0LXto8Epxg4B+8flf3YHayXn2BcQAcr2LufR96MzQq8hH8hInvNISclnyuA8Aoy+r4looRGnzWzPdli7F6NUSpfls26m+UwaW1V3WZwsMjhDNJuuPyukc/Y5x8ICaA4GyeGoRU7HRpRQCXAI6N4fJpnJ8mRJC1HmSq7OWkkmCpp79VoDale5nTl9etWTme/c4DLFp50y1yofP0Cg0v/wDYM8pHxjEaCYVZnRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhJ5b8H3SEHTwm8PuSsBwVnqD2TiI3oECU6CarjBBJw=;
 b=W6qMSoVEGVUY0CD2FvAH+35+aJXEh7ukmWeySdhfIs1lE49e92Cx6ReifhhtBkF4QqBZBmPVXwarewmBAzBWsffqCSZMMS3+PnFjPj3q8f3d69+3yv7jQrnpoomX42PeavUZWtNPmBkXXkDKmgFYuzjmcQtUcQgPs7cARAbH0fvg/sLqv1Uc4PkQyP2hdCK4V4zntJwmk/TUGnwzktL3zqMPrhYYAnWeNvw6zREpt8PhBwy0yrtFfve81Vbhf1v8Ype8mX9Zr9nXhyp+GrSuwmBzooT7meluvcfrncSNJe3UFwHgvyEqXRlwkRPxrtuFWxHJzhJEiyEJwpN60FJ+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhJ5b8H3SEHTwm8PuSsBwVnqD2TiI3oECU6CarjBBJw=;
 b=QIr2Gnsy+d8+J74UcX+2/AYur+xK1Uly4p1G4n6T6Jor+EJtpnEuDlhF73Q6dnMzd1sffdwqbWCQTz2AmvNk0BqBtXIMB2TK4De3l5DaqcZxM+pzLdXkwGZOgXsPwCV4J97MvOj5n9fBCGKzxKYzQWnGKnFB9GlUZ8Ff7HhnVqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 03:32:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:32:38 +0000
Message-ID: <ad4250ea-a517-41d3-a456-67b5e6251e79@amd.com>
Date: Tue, 18 Feb 2025 09:02:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
References: <20250218030652.2472681-1-sathishkumar.sundararaju@amd.com>
 <20250218030652.2472681-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250218030652.2472681-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ce3129-851f-4514-2d7b-08dd4fcce48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djRqalhUUTVjWUtHc1ZkRmFHYTlWTWk0SHNkR3l5M0FVdzRaNWxZazNzaDV5?=
 =?utf-8?B?S1EyTzZjMGNXTTNMbE0vQlpadlJ0WVJyMmxPYkhUT3dMZk5ONnRSeThTVlp3?=
 =?utf-8?B?S3o4cjB0bld0T2FydUZpQkdFdWVIOXlnRWpQMFdVSTdiakM5QU0raXlJaExC?=
 =?utf-8?B?TU5YeEk0dUVWZHRQRzY2b09nYUNyY3NaWmUwOUU4OVprWDQ1UzA3ZHJ0R3I0?=
 =?utf-8?B?RTAvd1RHVXdzSGwzYkplYi8xYXZ0RnpmUklSNEY3cEhwckNLODdHRWkzUUlL?=
 =?utf-8?B?c3hVeVRzTkh2eTgvOVpuVUVMRW9iak5wa3U1QWp1dFlXSW5saEVtR3Jhek8z?=
 =?utf-8?B?b09IVnJaNExtbk01azFqbW1lT21BdUNmdHFDRVJZNXhQR2R1MmJocVFqck5v?=
 =?utf-8?B?eWNnQXJpNzVCTDJlWndsekZ1UXZTMU92aFZBM3hZVHBHVldGQW53U3VHb0FI?=
 =?utf-8?B?NElJZmhqRCtoeTJFYjJvNUhDRmlRZ1c0NGdjbXNValhSQUNPZUpZQlRlVjNG?=
 =?utf-8?B?SktvWjEwcUFpL3hxcjRkR2U5a1FmWHI0ZkdwYm5ya3AyU083Z2FsNDhqdVEx?=
 =?utf-8?B?S050UGp2WXdTNjlleXlwbGN1ZC9QM2hlM2R2ZG9yWUhISGg2dHNHbm93NUxQ?=
 =?utf-8?B?TWxyT3JQdGpqQWxZMHhUU3RjSzZwSDIzblE2UVRMOCsvZHhtcm1NQjM3TjJX?=
 =?utf-8?B?akt0VFZzSFVqY0tXSnZkblZDUDZnYTZOVnQrdkZ5YmQ4OUk5cGdPRVNFdnlK?=
 =?utf-8?B?cG5ZSUdlNVhYeXZOZnRCSXJ1dEU2RXlaNmVVM1puMStrTGN5VklnRnpZbzVp?=
 =?utf-8?B?N0VDejR6ZnJiSy9qL25QUnQxNWducjBRTGNxNVFvNHRaazdsdFFzNzhzM3h1?=
 =?utf-8?B?T1hTa04rS1JkbVpjOW84U1l0TnMyV0l3ZFRObDlramhLcTRsZkZ0NzRTUUVP?=
 =?utf-8?B?TEVZZ0xUSStzbmRZbExQRE81cWZIS3FHTmdVL3FjK3p1c2Yrem1nNklmM0pD?=
 =?utf-8?B?MFgxdWJnNmFJM2JiMkRiMi9SU2V5dlBzVTVmdDkyaFlXYmJoeWp5b0R5Smgv?=
 =?utf-8?B?c2dGL1RGb2RlRmRNZVR5RlMvU3lqUE9IUTNFVHNyOTZxdmxlbVZoRy9sMHd6?=
 =?utf-8?B?RjBzbzd3d0pvMTJ0UEdMNFFqV1p2RjZrNlJDZlA3U3RycTM4Vkt5YU1kUEZl?=
 =?utf-8?B?TGh6Vy9qbVpLR1AvNTJBWTNJQS9iTzVXSGp4MFBjazlMdVVDaUdZN2Z4V0hj?=
 =?utf-8?B?TUp4U0tWY2svY0pRWnAwYUEvOUhET3BpUTNybjk4bDhjY0crZ1dlQ1hNQmRn?=
 =?utf-8?B?S0RJVUQwQWdDUVZ4WkFoYTNRVzBOWkNwMjJMQUZxK0RDSVhheVZ3aWpGVjZJ?=
 =?utf-8?B?MEJBY1ZTQXJIeUtvQlZMMUdZdm5mRElmQy8xSllDd25LcHcvckl3ZXF0QXBU?=
 =?utf-8?B?cXpBVEw0SlUzRitqRXU2YmtrTkttaXlsOVp5b0wwS3czNTh6YXIwV2kzRXZq?=
 =?utf-8?B?TGZwRE9ub3ZsemVFM3JyOWxuZWxZcE1vNk5ka3pzT1FZOUt2NzRGdWhpNldW?=
 =?utf-8?B?WkVRY09XMGNRQWE2b0NVRHU2b21wcFIvVjlUdmlXN1RMMzI3YkNuQXF2MG1B?=
 =?utf-8?B?Y0JVcEVyenFNZFRzdjdJWkpoK2VNbjM3MjBGWVFXZTZ3WDZEdFB0OGYyZzBz?=
 =?utf-8?B?VFpnd255TzN3OWZ4cEZxN2RTbmxuNEFRSmFCdTA0SmI4MzJKSXNXYkZKODdx?=
 =?utf-8?B?cEJnVUpUeVk0YVFTTklkbTR4R0lVYTAyR0IzMUtvS0hFcEp6dkxOY2VKbUNJ?=
 =?utf-8?B?MmhiQzdZRnBoVklVRVBiSlFPOHhFVWQ1UGFyRHIwbTA4RzVYaUNaa0dYOG9n?=
 =?utf-8?Q?+GFNEuYv8jto6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9zTDBocjhQS0t2TEdONzNNV01Hd3NHTk80UXF5WE5XTXQ2RnBMdDMxS0dQ?=
 =?utf-8?B?dWF6eTVhMHV6c1luY0lEVlVlbHA1ZHVFSThQMUxHV21iOFVJSE1LQ0pDYTB3?=
 =?utf-8?B?VmJTTmQrOWNnZ2xkREIrb1NuMEZSSEdCb3ZQa3JwaUY1cGFoSHh5OVVUUzZ0?=
 =?utf-8?B?NkwrbnVYdjZJb21kdVV0SVA3SlBHMlV2M2h2TllkZ3BaTVlmVFZiS1Z2cE05?=
 =?utf-8?B?QzNGUmg5TVdGRTdGdG5MY2d6VlpnMmw0ek0xamg3R1NBeENzQnZYOUEzN2x1?=
 =?utf-8?B?SzZOVXZ0dVlTOE5iai8rN0VZREVwWXF1U3BEZjNiQVUwT3lRK3RnUHA3RTdq?=
 =?utf-8?B?OC8wMFlFTityRDdjaEpnbkltTVozSGFYTm1sU3lqU0xBMmsxWmFmSDJUS3Bo?=
 =?utf-8?B?TTJNdHRpL3hPY0NKSTZLdHlTOW5aQWlweVBadWlDODFmaUJ2Rk81QlUycDgw?=
 =?utf-8?B?QVF3UmtuRGhWS3Zyd1dzMEV5a05DRHNXb3RjZXptMHJrSnY0QWQyTGkwUnNC?=
 =?utf-8?B?TVhtdkxFU29OQ0dtUmNnMWxYN3V1Z0dKSjM3Mi9HMEZpWkJFcVFZU01NRE8w?=
 =?utf-8?B?Rldad1NuL1owMzYvRkpERGRjRm1QaHk4bEtwZC9DQjVvZ0JjK1ZBSGlxb1BN?=
 =?utf-8?B?b0NMYk5ScW8vaUt4dUtxWVBDRUp0cWdSKzA3YWo1QXZMSllSQWpIUTl1Z2NU?=
 =?utf-8?B?cHJUZElvbkdaLytwNzMrMTdqNldIck9mMEh3RHRKNHZRRjNET1l3OGlEVmxY?=
 =?utf-8?B?MUtpdEQ0VXY3elRVOFR0bnkvelhQWkhMZmsvU1RxekwzM2tFbEV6UzFYNDBl?=
 =?utf-8?B?bG5PeFpTU05yMmpUWTRsQUpuVFR4bkE1dzdLWWh1NUthWS85c2lsMm9VV0dk?=
 =?utf-8?B?RlJYUklBbmt4UitVSzcvbi8wL1ZqeDIwWUF6ZkhiaEVyNVZxUTB6eXlZcTFG?=
 =?utf-8?B?WmRMc2RjOUdrNlJHc2dsazFyQXZ1V24wV2gza09UWnZBZHgxQWF2VDFaQlpE?=
 =?utf-8?B?NGJkSlZQaDJMcTd0WjJBckVWd2JjK1V1R1pCRmN1MG9OZ0tKNXhoeGJRaEli?=
 =?utf-8?B?NG1VQzdqUk1CMEJQaFFOTncvWVF5V3R4NWUwUlgwS2xwdmhQZXhCRXpPRXFE?=
 =?utf-8?B?YlNkUmNkVUJjRXNZUG95R1BiSEtFb0JMSDVtczUxdFMwMEVPUEM4WEFLUU1G?=
 =?utf-8?B?WmJCcXJjdzlEZ0FqQUg4a1lBSzZ1THNWT2d5eVptQm03ZXlMUk1XdWFJUEhy?=
 =?utf-8?B?VmRBVWQ3emRsTG54UFEyN2R3bWxQaEV1c2JTSGlGbWhGQzJtRkZFQ3JMakp4?=
 =?utf-8?B?MzBCdmVQczlLTmFXNU0vVi90Zld6bG12WVpxcGoxZlVZRTZOM2hxaVZSOWJ0?=
 =?utf-8?B?QnZyMnlKRWlVdC9mWTNxQUE4NHV6RUpFc2VsODEyeDlaWnJQTzFBa1lVcEhF?=
 =?utf-8?B?TE9xRi9HTmNOWFdOTlRzenNhK1pOektEaXF5RHczNEVJNTZVUXpQRzZHc3BQ?=
 =?utf-8?B?TENkVDcvcWlJRlFrSkZTQmpLaysrQ1cyUnh1RUp1N0c4cm5aaExWci9HbE1m?=
 =?utf-8?B?TnFNYkFEYkIvZ3o5cDc4NlVTaTZOSzljOHNNUGdUcDl4RzJYRW50SDJUeUFJ?=
 =?utf-8?B?OXJDMmVwQXU0ZU11OUkzc0hWM0Vka056akwyU1paN0xUWnFoRlhNOVIzREwx?=
 =?utf-8?B?aTlqaDdtd0NkM1VUUTBzb1o4b1o3cDlNZ0N0ZGI4b2dtNkJUZDdxZEFPeHp6?=
 =?utf-8?B?ekdWNU96N2dGcDJBUkUyMWRQMHI4NGdZSFdySVorcDMwMXBQNkFRTm9SSFJO?=
 =?utf-8?B?NFhtZjdRdzJMR2NJTVFHVGdudjlqT1FsS2xRa0VlN1huYUtZYmxTMjZzSDZ3?=
 =?utf-8?B?cVVzSlVMY2R1SVRPZm1xNXVzV3ZTVG5oekFzYW1kOXFsVlBxbTE4aStTM2Z4?=
 =?utf-8?B?T0pSMURUUDZWZVJNRnV5QkRxV29kTFdnYnJlRGUxRGJWNStGRDRMckVkeU9T?=
 =?utf-8?B?d2FpeHlBNU1rU1pKaFJZUnNMMVJlV1htMDFjajJkaGFDUG95YlY5WHVjMEFx?=
 =?utf-8?B?Vm5mVFJoT29ZVGd5VW1nUVVzMFF5UHJ3ZXdGS0FTL01yTHNvYkI4TXljMVJM?=
 =?utf-8?Q?k/Tol1UeNQY6mX/Svp1tMPSka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce3129-851f-4514-2d7b-08dd4fcce48d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:32:38.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvQuOZVBr0HR3PUz2dypLeRXzOclW6vny7J7M/NeqpUblMP90ww7KEWTIiO3XnLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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



On 2/18/2025 8:36 AM, Sathishkumar S wrote:
> Add ring reset function callback for JPEG4_0_3 to
> recover from job timeouts without a full gpu reset.
> 
> V2:
>  - sched->ready flag shouldn't be modified by HW backend (Christian)
> 
> V3:
>  - Dont modifying sched/job-submission state from HW backend (Christian)
>  - Implement per-core reset sequence
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 49 +++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index c67ba961de91..f10231c22c15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -204,14 +204,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->jpeg.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> +	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
>  
> -	return 0;
> +	return r;
>  }
>  
>  /**
> @@ -231,6 +227,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +
>  	r = amdgpu_jpeg_sw_fini(adev);
>  
>  	return r;
> @@ -1099,6 +1096,45 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int jpeg_inst = GET_INST(JPEG, ring->me);
> +	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
> +
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
> +			    reg_offset, 0x1F);
> +	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst,
> +			   regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
> +			   0x1F, 0x1f);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_JPEG_LMI_DROP,
> +			    reg_offset, 0x1F);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regJPEG_CORE_RST_CTRL,
> +			    reg_offset, 1 << ring->pipe);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
> +			    reg_offset, 0x00);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_JPEG_LMI_DROP,
> +			    reg_offset, 0x00);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regJPEG_CORE_RST_CTRL,
> +			    reg_offset, 0x00);
> +}
> +
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	if (amdgpu_sriov_vf(ring->adev))
> +		return -EINVAL;

-EOPNOTSUPP could be more appropriate. Since it's not supported on VF,
the same check may be applied while initializing
adev->jpeg.supported_reset mask also so that sysfs options are not
created for VFs.

Thanks,
Lijo

> +
> +	jpeg_v4_0_3_core_stall_reset(ring);
> +	jpeg_v4_0_3_start_jrbc(ring);
> +	return amdgpu_ring_test_helper(ring);
> +}
> +
>  static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>  	.name = "jpeg_v4_0_3",
>  	.early_init = jpeg_v4_0_3_early_init,
> @@ -1145,6 +1181,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>  	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>  	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = jpeg_v4_0_3_ring_reset,
>  };
>  
>  static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)

