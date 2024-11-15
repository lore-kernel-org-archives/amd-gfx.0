Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE9D6DDED
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 11:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E158910E002;
	Fri, 15 Nov 2024 11:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRbXZ+j4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9173010E002
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 11:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0QMWnBuo/JBH0A1z8j/RDoIELSKUT0PiHJ2VtZyqPbBGasQEiLh0BzgbmyuL0vFnRJoXqbCgpCwuB/afDE0eYMzqATbOqWLFT+grmL47D7kAD4PPnq5rdXn2jZAAPAl+FVKeb1Qiz9DZ8qQ4HuQ7M7w0GbsA7c/YPrZkjAdor0Sv/LHeEZ+Ia/+rnYuIuURNhk/sZekHE3RzTezM9sSGziJfdOxtzzKfFCAaHLCtckojJ4IIcPOVWAGUf4tLkuQvHI53fltHCSVEoS44+PGzosOEpUBJmXO1tTJFa9IwGeC3KTsXH/T9o7uo8b3BUWlIOJn68wWu7RrSSRJFcnBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL+wFcFssXCVqxTJYGTm9LCZbR+C8WhlfG541FQ7EM0=;
 b=Qz5S3yYLYHCPEP1DY9Fc3BbTGbkzSDcUUMggSFbmb8YgPhTml2h3VaySXwvJXEza0sfFv3SMTSyhO7dBmmnjgGJmiQjar3uNiudNkac3GrCmZFVdf7pfCYdPfB7LIw4SSYaeM3+bx2jUyzF7GWGsH6AO2VSMkgf2AwAZm9Azgqfu/RUsj745lQG4BGIxthwV6lDssCEV8sEy2v/0DqTLvEwpC1rL9Rsw2OqYCDJ2GbYrufUjE6coXJ5N3xAyx5t+UCsApYXcBwyFMNujGeZVy1XVIb1I2TaEqCw6jKpOJ79kqouha03xCSiKKCV0Ouf66dxj1HCHis06vdGLWptMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL+wFcFssXCVqxTJYGTm9LCZbR+C8WhlfG541FQ7EM0=;
 b=CRbXZ+j4WOvq6hNVahs0PTlZqciNBsoA2CqB6LtFHZ7FIvNEipGCLipb2zymO19gbXf8K0+KDJ1JRBrKmVXMhYj7tDbytEm87Q54jacNNwManfO0xAUpvtIM0R6O7yKIfIpvBvCqyqkWaoBzRHB+ihvoXPCY0Xg14o9+QATfzuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 11:17:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 11:17:10 +0000
Message-ID: <45129aa7-31e1-4d87-9f28-84a9c2b8485a@amd.com>
Date: Fri, 15 Nov 2024 16:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20241114210603.10448-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241114210603.10448-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000018A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::55) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d70982-1911-402a-1eb7-08dd05670bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rms5OUVWVEMvajQwa3NhV1k4YUpwK1JtSUJyalM3QVd6Q01PV1BnUTJyZlIv?=
 =?utf-8?B?bFBwTVArSXViU0xzUCtVUW5kcnk3V0hQaWhabFZvVXNxN2pmbCtlaGxEa1Z6?=
 =?utf-8?B?aU5XRXVOalNFRk5Hdy9ZbnZtajl4QzNybFU4eFZla3BzMnVhUStpOW9pMDRl?=
 =?utf-8?B?dENCdDF6Z0xLOTNLUHhuTGFOYS9mZk9kZ01oY3hNS2tsMHRYTC9pV014NjJ5?=
 =?utf-8?B?NklsTExNOVJDdXBCbTJZblJjQzFxNlBVS2FmcWVUeFJmeWk0cTlkM0FORGkr?=
 =?utf-8?B?dW0rQlhGdnA0L3BEZEI2SXc5NVg0dUVyOTAxMkdWSHJiNm1VTnhWZDJrUzJM?=
 =?utf-8?B?MG5wd3pzcUNuM2R6NUtiQ1Y5WWNTZFdJendzKzNwNzBHK0RQNkZxb0tUWEVa?=
 =?utf-8?B?V0ZYRXFTTllyNjJHN0NhSUtkT1V6UXVmQTJVa0xLcVlqQlJYRXRLNk9XbDNW?=
 =?utf-8?B?SXFGd3U0SjZ3VERlNVNqSDgvYlNqSHlCWmtWS3V2UGJIV3Z6YkpFaVZsU1FW?=
 =?utf-8?B?enN0MSs5YjBkWFlTQmQ2NGFmN1h4UmNSMkIwVWFaVFVhWEtteWxJemVYZ2l6?=
 =?utf-8?B?d3RYR28xK1ViZXcyZGhyWVBza3hMUUcwZWFuMHFHN1RzWVM5M3hlS3o0ZFdp?=
 =?utf-8?B?aDlTbHFXUmJyZFFtNXdhQlhGRi9vQ05KYUt4alhIbGNncUhEZnFzZjFuWWpQ?=
 =?utf-8?B?cG5lMzdYWGVvOUxvVWRiclVqV04rQ09lOUtCQ1d6L0t0UUxESitkRmVPOVd2?=
 =?utf-8?B?NEtWYVR4aHBvT1U3T0MxZXdZQVZ4SWYrYVd2RlV2Tk40WGNNeE93QkpLQjUy?=
 =?utf-8?B?b2hNQ0E5aWx4QTE5OTE0SUhiR1Z4eUdKaHI5eEZza29aWUZnTG5oQ2tiM1la?=
 =?utf-8?B?T0hMNEpJOUlGdVAwWVhPR0NvdFg0bDB3N0twanZCT3ZCVmVWeDNEckJpbjly?=
 =?utf-8?B?QXBFNVZwWFAvWWt6R24vSDQzRTduWEkrZzhJRGN1Q0wwMWgydXNvOHJmdlp0?=
 =?utf-8?B?dWRtODl4RUdleTVxd0tYMEpZTjloQUJRMEZjUllpWngydlZNNm5hL2tmM21P?=
 =?utf-8?B?aEpBOU95dExRcG5SQkd2dVJLOFRXSTZidzZCeGJlandZSnBBOC9mUE5sWmtZ?=
 =?utf-8?B?Qm1iZ2gwWlJUSjkzbG5BQnRGdFhFOC9IQkFSNFZudGpEczZYamR5ZEZrdFFU?=
 =?utf-8?B?Z2NPczdmU0RnTDZOZ21hdUhKcmxOTS9kSlJuN3cyN25HaUZTdUc5OUtFaUhB?=
 =?utf-8?B?ai9MWTVDZWVWS0E1dnRRVisrZ2RLS2txVG1aaFVreTk5Z1hHSm92d2YxckpE?=
 =?utf-8?B?WTB2bU1WWFpEdE5Fa1NrR203WXhzUHJ1TStJVDRCUmwrU2ljMmhqemRZYWl3?=
 =?utf-8?B?eUEzUzBiRm50MHRKaWxMRWdubW40TXBKS2xIVGJaaG5ISjM4cFl1TkpQV005?=
 =?utf-8?B?M3VzUUpaZnFBNDFpdUVZcS9wUnZidjFpVlhiYmhtL3NxeUNlQUNSTWtEOWE4?=
 =?utf-8?B?c0dTWGhmYUllTXBlRVFIYzNBQSt2dEIyeWFWa09UZjJSMjhWbTdMd2xPZnpl?=
 =?utf-8?B?RFZWeVI4YVF6eUVDbTl6U3JOU0FOTWdJQzF3bWVJYW5yUm02T0VrZVV4b0lD?=
 =?utf-8?B?WE1VQ0xrcjFJc1NXZndNQlYxaG9CcWp3cHEyUld6dzVkMHY5cHJYQjZRR014?=
 =?utf-8?B?OGR3Y2h1TnB4MTh1ZUFRU256Wjc1aWw0UWJVZG5FR0huN3VWRWZ0MFFncjdC?=
 =?utf-8?Q?A1D9mbEUwc9dgFe2ct2leWrJD3OthHRMyinw7Ga?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1N3ZUF3Q1p4SFY1dFdyVzVwcmxub0wzL0FSSHVEc2ZGaDFjUFEyU3FEeTJF?=
 =?utf-8?B?UnYwU3FzUFNBVXZLdi8wV3kyL3dSS2R1VVlmR3VIcFhUWG1CS3RjQlBkdUJN?=
 =?utf-8?B?SmJLeXE5c3ZMTHdvR3lQdEQ3YXRkaHBpZzEzQWVlOTYydlJETnRONVIvN1dX?=
 =?utf-8?B?OUNQb1ZzeUtqTzlySW9IODdidEJRNWVQZ20zYUxnaEV6QWZ5STlTYzRRL1J6?=
 =?utf-8?B?clFqeVpZcTFPQUJnZi9ScmZ3cFlwaXpIVC8yV3dOWVNuZGMvYzhGNlJIdjMw?=
 =?utf-8?B?T1FJZno5a3Byd3krZUVMckJ4R2hOa095cjdUZHRpRElyQ2JWemJVTXd5MXg1?=
 =?utf-8?B?aXhNTVJBaWFZZzNnUlVnQ1ZXYnlOeVVPNTJsdC9GYmR2RGV1Z1k1bWNPbjdj?=
 =?utf-8?B?TXcwY2k1NnMwYjhZbzBMT0luT01GNTJTb0E5YzRvcDBxZ0lFOFhZYUI2RnVX?=
 =?utf-8?B?N2lmcE51emlNZVVyYXkxSHpYcjVmRE9hZ2VmK0FGNVpVbkNPTVZpOHFndExs?=
 =?utf-8?B?TFpXZXJpT0dWRGErZlVwVUhkaUx3NCt6WjBzSXRaRjNQbEV4djMxNllaNERC?=
 =?utf-8?B?RnNVVnpmNU9ZTDhhc1hDaWxCVEQzR0lueUhyQ21KUC9OcVkyM2FyM2ZMd0ZZ?=
 =?utf-8?B?dkZFc2RjcUNERitPcGpaU2VGVHBFK04rTUhQSVl2S0MzV2FUakNxWUVjdlBk?=
 =?utf-8?B?MCt3RlVhSUNNYkRpUDRkek9US2YwS3A5QW5aUUZ3VmNJczlydTV0YnowaUhS?=
 =?utf-8?B?bm9VZ2V2ZzFoVENlUGN6Q3lLNEs0SEVzTU16N3QrYTlDaWdWRFlDMjRVUDFy?=
 =?utf-8?B?NDlsS0hWQTdjcmc2bVo1V1lZYXZsaW9ZVHhmL0tMalRQZFFGZDRXQ29PWlhY?=
 =?utf-8?B?QTRNZms2Um1lNmZhR3VuVVVHQ2xnYU0zL0tHMldyQU9rQVAyVEVPNTFSZDgx?=
 =?utf-8?B?VGVCN1NoZHhBdG5pSmZCbDlhUGVQci9KbjRuTmZwNFhRR3hzbjlYc21EUUdP?=
 =?utf-8?B?UC9oRk9tQ1hqc3d3VEtua3hpdXphV1dCdEd5aHpqOXY1TXpDYWkyTXhyTW9q?=
 =?utf-8?B?WEJjWlNNYWRoR3lKSE5xdTBIS3VMSDl1dURyak1lcXpOMXVscSt2aUJBdDBp?=
 =?utf-8?B?SmNmYXJWYWV2VGNVWFFWQVdkZng3aGpQbjdZTnhvYkdMMS84L1F0TjlKT1BP?=
 =?utf-8?B?Rm1KQlZVZVVlalFoMDROeWNuMDRDMmMwcGJSUkJmUGsyZm9VK1BJOTQvUGwx?=
 =?utf-8?B?Uk9lWk5ZWGw4K3E2d29mckRTbWh0eVRqa0hld2xMRll1L3M4MXh3cG9jTEpz?=
 =?utf-8?B?SW9MUUxqZ2VscjBSa0hOU290eEpYdWRWVHA2ZFh0ejM4QlNhMXpCcGNyRUNR?=
 =?utf-8?B?NEJPMi9CMTMyYzJIaWJVb2xUZ0hGdXE1Z0hxT2xkaXA1b1YxSGczdEdSdTRW?=
 =?utf-8?B?Z1QrdGh4cEJSRnNoT3RpWXRiVDhBcFUxTlF1MkEwWFVGemRtTTFaZ2Z4Rnh0?=
 =?utf-8?B?WktGaVpjU1lnTEF5L3h4d2NoWDh0T1hpeFJxQ3oybkJ2VWxSdXdycXZKL3V6?=
 =?utf-8?B?a0VMeUdYSXJ1eEoxR1dJVnBuWVFZTXlsUk0vSS9CZUJDR0VFbGNXNFRjdEJQ?=
 =?utf-8?B?WkZYRTlCSlQ0amZSOVI1dDlZSVk1bHYxSEpqUGMvMm5EN1hRcGd6WFhQUzlO?=
 =?utf-8?B?aFdJL3pobWY5RjZEV3YwZnpOUGhrWmdnSHIyc1Z2OW9EN0xva1NITWMwcnp6?=
 =?utf-8?B?THE0enAzVmRZbnRVc2dGQUYyMFl3UlNxK1hjZVZUVTlUMnB6SjdHU2VvZ0RB?=
 =?utf-8?B?SnlkMWFmT0cxcGdWOWhSQ3RNSHQ5SVRFZXNpUjRnY2U3cHl1cEs3ZlROUEZh?=
 =?utf-8?B?ZjhBV1FTcVFVZFNidXU3VWtwK1VDbWpFdE1QcCs1WVFYUzJoSHBZOFlEcWxC?=
 =?utf-8?B?a3ROMHpCc3hFWnI3SWQwdWRVd2NrOUgrMlRXdkFuakdrZW96ZU51cTVldStY?=
 =?utf-8?B?OU1CTVBmSVo5dVpZSVVCQ09tdGJZV1JsUjZNb0dvVHZKa2tJSlNkL1pvcFVn?=
 =?utf-8?B?cVNNbTExQWJRL2RLVlRneGkyV2lUZ0xaMTh5WVZ3N1VlRldyL2FxUWN2Vmkw?=
 =?utf-8?Q?kAbSvcaQpICi8zCe4E1+SRMdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d70982-1911-402a-1eb7-08dd05670bc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 11:17:09.9552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA65NrGCmgvW7voYUXgLGZI7iJfkJ2jEa0rmw+ztoyL++0AD6/iWciFRto+5/tKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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



On 11/15/2024 2:36 AM, Alex Deucher wrote:
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
> 
> Move all handling of smu->workload_mask in to the backends and
> simplify the code.  Store the user's preference in smu->power_profile_mode
> which will be reflected in sysfs.  For internal driver profile
> switches for KFD or VCN, just update the workload mask so that the
> user's preference is retained.  Remove all of the extra now unused
> workload related elements in the smu structure.
> 
> v2: use refcounts for workload profiles
> v3: rework based on feedback from Lijo
> 
> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 165 +++++++++---------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  21 ++-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 147 ++++++++--------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 151 ++++++++--------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 150 ++++++++--------
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 153 ++++++++--------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 120 +++++++------
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 141 ++++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  38 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   7 +-
>  12 files changed, 614 insertions(+), 563 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c3a6b6f20455..ab6b30a9df1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
>  
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
> @@ -1268,9 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>  	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
> -	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->user_dpm_profile.user_workload_mask = 0;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>  		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> @@ -1278,33 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> -
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	} else {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> -		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	}
> -
> -	smu->workload_mask = smu->driver_workload_mask |
> -							smu->user_dpm_profile.user_workload_mask;
> -	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> -	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
> -	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
> -	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
> -	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	else
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	smu_power_profile_mode_get(smu, smu->power_profile_mode);
> +
>  	smu->display_config = &adev->pm.pm_display_cfg;
>  
>  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> @@ -2140,6 +2121,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>  	if (!ret)
>  		adev->gfx.gfx_off_entrycount = count;
>  
> +	/* clear this on suspend so it will get reprogrammed on resume */
> +	smu->frontend_workload_mask = 0;
> +
>  	return 0;
>  }
>  
> @@ -2251,26 +2235,46 @@ static int smu_enable_umd_pstate(void *handle,
>  	return 0;
>  }
>  
> -static int smu_bump_power_profile_mode(struct smu_context *smu,
> -					   long *param,
> -					   uint32_t param_size)
> +static int smu_bump_power_profile_mode(struct smu_context *smu)
>  {
> -	int ret = 0;
> +	u32 workload_mask = 0;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
> +		if (smu->workload_refcount[i])
> +			workload_mask |= 1 << i;
> +	}
> +
> +	if (smu->frontend_workload_mask == workload_mask)
> +		return 0;

If you notice, smu->backend_workload_mask is really not used. I think
only a single mask is required. At any point, smu->workload_refcount[i]
can be used to derive the mask. I think we just need to move the above
logic to smu_cmn_get_backend_workload_mask/smu_cmn_get_workload_mask.

While going for suspend, only clear smu->workload_mask. During resume
bump_profile_mode() will be called and at that time, we will have

smu_cmn_get_backend_workload_mask() != smu->workload_mask

To check if custom profile is requested,this will do -

if (smu->workload_refcount[PP_SMC_POWER_PROFILE_CUSTOM]).

The decision for smu_cmn_get_backend_workload_mask() !=
smu->workload_mask may be left to the backend.

It's possible that the parameters for custom changed, but the mask
remains same. The current check in bump_profile_mode() doesn't appear to
cover that case.

// custom_param_changed = existing check in this patch.

In backend we can check
	if (smu->workload_refcount[PP_SMC_POWER_PROFILE_CUSTOM] &&
custom_param_changed)

Also, anytime a smu_bump_power_profile_mode() fails we need to do

	smu_power_profile_mode_put(smu, type)

Not able to see that in the patch, not sure if it's handled in a
different way.

Thanks,
Lijo
>  
>  	if (smu->ppt_funcs->set_power_profile_mode)
> -		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
> +		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask);
> +
> +	if (!ret)
> +		smu->frontend_workload_mask = workload_mask;
>  
>  	return ret;
>  }
>  
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	smu->workload_refcount[profile_mode]++;
> +}
> +
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	if (smu->workload_refcount[profile_mode])
> +		smu->workload_refcount[profile_mode]--;
> +}
> +
>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  					  enum amd_dpm_forced_level level,
> -					  bool skip_display_settings,
> -					  bool init)
> +					  bool skip_display_settings)
>  {
>  	int ret = 0;
> -	int index = 0;
> -	long workload[1];
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  
>  	if (!skip_display_settings) {
> @@ -2307,14 +2311,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  	}
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -
> -		if (init || smu->power_profile_mode != workload[0])
> -			smu_bump_power_profile_mode(smu, workload, 0);
> -	}
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> +		smu_bump_power_profile_mode(smu);
>  
>  	return ret;
>  }
> @@ -2333,13 +2331,13 @@ static int smu_handle_task(struct smu_context *smu,
>  		ret = smu_pre_display_config_changed(smu);
>  		if (ret)
>  			return ret;
> -		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, false);
>  		break;
>  	case AMD_PP_TASK_COMPLETE_INIT:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	case AMD_PP_TASK_READJUST_POWER_STATE:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	default:
>  		break;
> @@ -2361,12 +2359,10 @@ static int smu_handle_dpm_task(void *handle,
>  
>  static int smu_switch_power_profile(void *handle,
>  				    enum PP_SMC_POWER_PROFILE type,
> -				    bool en)
> +				    bool enable)
>  {
>  	struct smu_context *smu = handle;
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
> -	long workload[1];
> -	uint32_t index;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> @@ -2374,24 +2370,14 @@ static int smu_switch_power_profile(void *handle,
>  	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>  		return -EINVAL;
>  
> -	if (!en) {
> -		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	} else {
> -		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	}
> -
> -	smu->workload_mask = smu->driver_workload_mask |
> -						 smu->user_dpm_profile.user_workload_mask;
> -
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -		smu_bump_power_profile_mode(smu, workload, 0);
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +		if (enable)
> +			smu_power_profile_mode_get(smu, type);
> +		else
> +			smu_power_profile_mode_put(smu, type);
> +		smu_bump_power_profile_mode(smu);
> +	}
>  
>  	return 0;
>  }
> @@ -3090,21 +3076,44 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> -	int ret;
> +	bool custom_changed = false;
> +	int ret = 0, i;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	if (smu->user_dpm_profile.user_workload_mask &
> -	   (1 << smu->workload_priority[param[param_size]]))
> -	   return 0;
> +	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
> +		if (param_size > SMU_BACKEND_MAX_CUSTOM_PARAMETERS)
> +			return -EINVAL;
> +		/* param_size is actually a max index, not an array size */
> +		for (i = 0; i <= param_size; i++) {
> +			if (smu->custom_profile_input[i] != param[i]) {
> +				custom_changed = true;
> +				break;
> +			}
> +		}
> +	}
>  
> -	smu->user_dpm_profile.user_workload_mask =
> -		(1 << smu->workload_priority[param[param_size]]);
> -	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
> -		smu->driver_workload_mask;
> -	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +	if ((param[param_size] != smu->power_profile_mode) || custom_changed) {
> +		/* save the parameters for custom */
> +		if (custom_changed) {
> +			/* param_size is actually a max index, not an array size */
> +			for (i = 0; i <= param_size; i++)
> +				smu->custom_profile_input[i] = param[i];
> +			smu->custom_profile_size = param_size;
> +			/* clear frontend mask so custom changes propogate */
> +			smu->frontend_workload_mask = 0;
> +		}
> +		/* clear the old user preference */
> +		smu_power_profile_mode_put(smu, smu->power_profile_mode);
> +		/* set the new user preference */
> +		smu_power_profile_mode_get(smu, param[param_size]);
> +		ret = smu_bump_power_profile_mode(smu);
> +		if (!ret)
> +			/* store the user's preference */
> +			smu->power_profile_mode = param[param_size];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fa93a8879113..a9b88072bd05 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>  	/* user clock state information */
>  	uint32_t clk_mask[SMU_CLK_COUNT];
>  	uint32_t clk_dependency;
> -	uint32_t user_workload_mask;
>  };
>  
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
> @@ -510,6 +509,8 @@ enum smu_fw_status {
>   */
>  #define SMU_WBRF_EVENT_HANDLING_PACE	10
>  
> +#define SMU_BACKEND_MAX_CUSTOM_PARAMETERS	11
> +
>  struct smu_context {
>  	struct amdgpu_device            *adev;
>  	struct amdgpu_irq_src		irq_source;
> @@ -557,12 +558,16 @@ struct smu_context {
>  	uint32_t hard_min_uclk_req_from_dal;
>  	bool disable_uclk_switch;
>  
> -	uint32_t workload_mask;
> -	uint32_t driver_workload_mask;
> -	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> -	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> +	/* asic agnostic workload mask */
> +	uint32_t frontend_workload_mask;
> +	/* asic specific workload mask */
> +	uint32_t backend_workload_mask;
> +	/* default/user workload preference */
>  	uint32_t power_profile_mode;
> -	uint32_t default_power_profile_mode;
> +	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> +	/* backend specific custom workload settings */
> +	long custom_profile_input[SMU_BACKEND_MAX_CUSTOM_PARAMETERS];
> +	bool custom_profile_size;
>  	bool pm_enabled;
>  	bool is_apu;
>  
> @@ -733,9 +738,9 @@ struct pptable_funcs {
>  	 * @set_power_profile_mode: Set a power profile mode. Also used to
>  	 *                          create/set custom power profile modes.
>  	 * &input: Power profile mode parameters.
> -	 * &size: Size of &input.
> +	 * &workload_mask: mask of workloads to enable
>  	 */
> -	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
> +	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask);
>  
>  	/**
>  	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4b36c230e43a..64605cd932ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1441,97 +1441,98 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int arcturus_set_power_profile_mode(struct smu_context *smu,
> -					   long *input,
> -					   uint32_t size)
> +static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
> +						 long *input,
> +						 uint32_t size)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
> -	int workload_type = 0;
> -	uint32_t profile_mode = input[size];
> -	int ret = 0;
> +	int ret;
>  
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> +	if (size != 10)
>  		return -EINVAL;
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> -	     (smu->smc_fw_version >= 0x360d00)) {
> -		if (size != 10)
> -			return -EINVAL;
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor.Gfx_FPS = input[1];
> +		activity_monitor.Gfx_UseRlcBusy = input[2];
> +		activity_monitor.Gfx_MinActiveFreqType = input[3];
> +		activity_monitor.Gfx_MinActiveFreq = input[4];
> +		activity_monitor.Gfx_BoosterFreqType = input[5];
> +		activity_monitor.Gfx_BoosterFreq = input[6];
> +		activity_monitor.Gfx_PD_Data_limit_c = input[7];
> +		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> +		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	case 1: /* Uclk */
> +		activity_monitor.Mem_FPS = input[1];
> +		activity_monitor.Mem_UseRlcBusy = input[2];
> +		activity_monitor.Mem_MinActiveFreqType = input[3];
> +		activity_monitor.Mem_MinActiveFreq = input[4];
> +		activity_monitor.Mem_BoosterFreqType = input[5];
> +		activity_monitor.Mem_BoosterFreq = input[6];
> +		activity_monitor.Mem_PD_Data_limit_c = input[7];
> +		activity_monitor.Mem_PD_Data_error_coeff = input[8];
> +		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -				       WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor),
> -				       false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor.Gfx_FPS = input[1];
> -			activity_monitor.Gfx_UseRlcBusy = input[2];
> -			activity_monitor.Gfx_MinActiveFreqType = input[3];
> -			activity_monitor.Gfx_MinActiveFreq = input[4];
> -			activity_monitor.Gfx_BoosterFreqType = input[5];
> -			activity_monitor.Gfx_BoosterFreq = input[6];
> -			activity_monitor.Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Uclk */
> -			activity_monitor.Mem_FPS = input[1];
> -			activity_monitor.Mem_UseRlcBusy = input[2];
> -			activity_monitor.Mem_MinActiveFreqType = input[3];
> -			activity_monitor.Mem_MinActiveFreq = input[4];
> -			activity_monitor.Mem_BoosterFreqType = input[5];
> -			activity_monitor.Mem_BoosterFreq = input[6];
> -			activity_monitor.Mem_PD_Data_limit_c = input[7];
> -			activity_monitor.Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	return ret;
> +}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -				       WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor),
> -				       true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> -			return ret;
> -		}
> -	}
> +static int arcturus_set_power_profile_mode(struct smu_context *smu,
> +					   u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
>  
> -	/*
> -	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> -	 * Not all profile modes are supported on arcturus.
> -	 */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
> -		return -EINVAL;
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
> +
> +	if (custom_enabled) {
> +		ret = arcturus_set_power_profile_mode_coeff(smu,
> +							    smu->custom_profile_input,
> +							    smu->custom_profile_size);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					  SMU_MSG_SetWorkloadMask,
> -					  smu->workload_mask,
> -					  NULL);
> +					      SMU_MSG_SetWorkloadMask,
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
>  		return ret;
>  	}
>  
> -	smu_cmn_assign_power_profile(smu);
> +	smu->backend_workload_mask = backend_workload_mask;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int arcturus_set_performance_level(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 211635dabed8..8ed446b3458c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,90 +2006,101 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>  	return size;
>  }
>  
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
> +					       long *input,
> +					       uint32_t size)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
> -	int workload_type, ret = 0;
> +	int ret;
> +
> +	if (size != 10)
> +		return -EINVAL;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor.Gfx_FPS = input[1];
> +		activity_monitor.Gfx_MinFreqStep = input[2];
> +		activity_monitor.Gfx_MinActiveFreqType = input[3];
> +		activity_monitor.Gfx_MinActiveFreq = input[4];
> +		activity_monitor.Gfx_BoosterFreqType = input[5];
> +		activity_monitor.Gfx_BoosterFreq = input[6];
> +		activity_monitor.Gfx_PD_Data_limit_c = input[7];
> +		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> +		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	case 1: /* Socclk */
> +		activity_monitor.Soc_FPS = input[1];
> +		activity_monitor.Soc_MinFreqStep = input[2];
> +		activity_monitor.Soc_MinActiveFreqType = input[3];
> +		activity_monitor.Soc_MinActiveFreq = input[4];
> +		activity_monitor.Soc_BoosterFreqType = input[5];
> +		activity_monitor.Soc_BoosterFreq = input[6];
> +		activity_monitor.Soc_PD_Data_limit_c = input[7];
> +		activity_monitor.Soc_PD_Data_error_coeff = input[8];
> +		activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	case 2: /* Memclk */
> +		activity_monitor.Mem_FPS = input[1];
> +		activity_monitor.Mem_MinFreqStep = input[2];
> +		activity_monitor.Mem_MinActiveFreqType = input[3];
> +		activity_monitor.Mem_MinActiveFreq = input[4];
> +		activity_monitor.Mem_BoosterFreqType = input[5];
> +		activity_monitor.Mem_BoosterFreq = input[6];
> +		activity_monitor.Mem_PD_Data_limit_c = input[7];
> +		activity_monitor.Mem_PD_Data_error_coeff = input[8];
> +		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	default:
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 10)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor.Gfx_FPS = input[1];
> -			activity_monitor.Gfx_MinFreqStep = input[2];
> -			activity_monitor.Gfx_MinActiveFreqType = input[3];
> -			activity_monitor.Gfx_MinActiveFreq = input[4];
> -			activity_monitor.Gfx_BoosterFreqType = input[5];
> -			activity_monitor.Gfx_BoosterFreq = input[6];
> -			activity_monitor.Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Socclk */
> -			activity_monitor.Soc_FPS = input[1];
> -			activity_monitor.Soc_MinFreqStep = input[2];
> -			activity_monitor.Soc_MinActiveFreqType = input[3];
> -			activity_monitor.Soc_MinActiveFreq = input[4];
> -			activity_monitor.Soc_BoosterFreqType = input[5];
> -			activity_monitor.Soc_BoosterFreq = input[6];
> -			activity_monitor.Soc_PD_Data_limit_c = input[7];
> -			activity_monitor.Soc_PD_Data_error_coeff = input[8];
> -			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 2: /* Memclk */
> -			activity_monitor.Mem_FPS = input[1];
> -			activity_monitor.Mem_MinFreqStep = input[2];
> -			activity_monitor.Mem_MinActiveFreqType = input[3];
> -			activity_monitor.Mem_MinActiveFreq = input[4];
> -			activity_monitor.Mem_BoosterFreqType = input[5];
> -			activity_monitor.Mem_BoosterFreq = input[6];
> -			activity_monitor.Mem_PD_Data_limit_c = input[7];
> -			activity_monitor.Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +static int navi10_set_power_profile_mode(struct smu_context *smu,
> +					 u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor), true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
> +
> +	if (custom_enabled) {
> +		ret = navi10_set_power_profile_mode_coeff(smu,
> +							  smu->custom_profile_input,
> +							  smu->custom_profile_size);
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
> -
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    smu->workload_mask, NULL);
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		return ret;
> +	}
> +
> +	smu->backend_workload_mask = backend_workload_mask;
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 844532a9b641..bea11bbe859c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,93 +1704,103 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>  	return size;
>  }
>  
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
> +						       long *input, uint32_t size)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> +	int ret;
> +
> +	if (size != 10)
> +		return -EINVAL;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[1];
> +		activity_monitor->Gfx_MinFreqStep = input[2];
> +		activity_monitor->Gfx_MinActiveFreqType = input[3];
> +		activity_monitor->Gfx_MinActiveFreq = input[4];
> +		activity_monitor->Gfx_BoosterFreqType = input[5];
> +		activity_monitor->Gfx_BoosterFreq = input[6];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[7];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[8];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	case 1: /* Socclk */
> +		activity_monitor->Fclk_FPS = input[1];
> +		activity_monitor->Fclk_MinFreqStep = input[2];
> +		activity_monitor->Fclk_MinActiveFreqType = input[3];
> +		activity_monitor->Fclk_MinActiveFreq = input[4];
> +		activity_monitor->Fclk_BoosterFreqType = input[5];
> +		activity_monitor->Fclk_BoosterFreq = input[6];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[7];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[8];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	case 2: /* Memclk */
> +		activity_monitor->Mem_FPS = input[1];
> +		activity_monitor->Mem_MinFreqStep = input[2];
> +		activity_monitor->Mem_MinActiveFreqType = input[3];
> +		activity_monitor->Mem_MinActiveFreq = input[4];
> +		activity_monitor->Mem_BoosterFreqType = input[5];
> +		activity_monitor->Mem_BoosterFreq = input[6];
> +		activity_monitor->Mem_PD_Data_limit_c = input[7];
> +		activity_monitor->Mem_PD_Data_error_coeff = input[8];
> +		activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
> +		break;
> +	default:
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 10)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinFreqStep = input[2];
> -			activity_monitor->Gfx_MinActiveFreqType = input[3];
> -			activity_monitor->Gfx_MinActiveFreq = input[4];
> -			activity_monitor->Gfx_BoosterFreqType = input[5];
> -			activity_monitor->Gfx_BoosterFreq = input[6];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Socclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinFreqStep = input[2];
> -			activity_monitor->Fclk_MinActiveFreqType = input[3];
> -			activity_monitor->Fclk_MinActiveFreq = input[4];
> -			activity_monitor->Fclk_BoosterFreqType = input[5];
> -			activity_monitor->Fclk_BoosterFreq = input[6];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[7];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 2: /* Memclk */
> -			activity_monitor->Mem_FPS = input[1];
> -			activity_monitor->Mem_MinFreqStep = input[2];
> -			activity_monitor->Mem_MinActiveFreqType = input[3];
> -			activity_monitor->Mem_MinActiveFreq = input[4];
> -			activity_monitor->Mem_BoosterFreqType = input[5];
> -			activity_monitor->Mem_BoosterFreq = input[6];
> -			activity_monitor->Mem_PD_Data_limit_c = input[7];
> -			activity_monitor->Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
> +						 u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
> +
> +	if (custom_enabled) {
> +		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
> +								  smu->custom_profile_input,
> +								  smu->custom_profile_size);
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
> -
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    smu->workload_mask, NULL);
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		return ret;
> +	}
> +
> +	smu->backend_workload_mask = backend_workload_mask;
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f89c487dce72..279d01f58785 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,42 +1056,29 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu,
> +					  u32 workload_mask)
>  {
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
>  
> -	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    smu->workload_mask,
> -				    NULL);
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> -					workload_type);
> +		dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
> +			     workload_mask);
>  		return ret;
>  	}
>  
> -	smu_cmn_assign_power_profile(smu);
> +	smu->backend_workload_mask = backend_workload_mask;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 75a9ea87f419..f6d0973506d6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,44 +864,29 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu,
> +					 u32 workload_mask)
>  {
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> +	int ret;
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
>  
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		/*
> -		 * TODO: If some case need switch to powersave/default power mode
> -		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> -		 */
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
> -		return -EINVAL;
> -	}
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    smu->workload_mask,
> -				    NULL);
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> +		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
> +			     workload_mask);
>  		return ret;
>  	}
>  
> -	smu_cmn_assign_power_profile(smu);
> +	smu->backend_workload_mask = backend_workload_mask;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 80c6b1e523aa..4bc984cca6cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> -					      long *input,
> -					      uint32_t size)
> +static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input,
> +						    uint32_t size)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> -	u32 workload_mask;
> -
> -	smu->power_profile_mode = input[size];
> +	int ret;
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (size != 9)
>  		return -EINVAL;
> -	}
> -
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 9)
> -			return -EINVAL;
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinActiveFreqType = input[2];
> -			activity_monitor->Gfx_MinActiveFreq = input[3];
> -			activity_monitor->Gfx_BoosterFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreq = input[5];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[6];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinActiveFreqType = input[2];
> -			activity_monitor->Fclk_MinActiveFreq = input[3];
> -			activity_monitor->Fclk_BoosterFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreq = input[5];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[6];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[1];
> +		activity_monitor->Gfx_MinActiveFreqType = input[2];
> +		activity_monitor->Gfx_MinActiveFreq = input[3];
> +		activity_monitor->Gfx_BoosterFreqType = input[4];
> +		activity_monitor->Gfx_BoosterFreq = input[5];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[6];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> +		break;
> +	case 1: /* Fclk */
> +		activity_monitor->Fclk_FPS = input[1];
> +		activity_monitor->Fclk_MinActiveFreqType = input[2];
> +		activity_monitor->Fclk_MinActiveFreq = input[3];
> +		activity_monitor->Fclk_BoosterFreqType = input[4];
> +		activity_monitor->Fclk_BoosterFreq = input[5];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[6];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +	return ret;
> +}
>  
> -	if (workload_type < 0)
> -		return -EINVAL;
> +static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int workload_type, ret;
>  
> -	workload_mask = 1 << workload_type;
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
>  
>  	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>  	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
> @@ -2658,26 +2652,29 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  							       CMN2ASIC_MAPPING_WORKLOAD,
>  							       PP_SMC_POWER_PROFILE_POWERSAVING);
>  		if (workload_type >= 0)
> -			workload_mask |= 1 << workload_type;
> +			backend_workload_mask |= 1 << workload_type;
> +	}
> +
> +	if (custom_enabled) {
> +		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_input,
> +							       smu->custom_profile_size);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	smu->workload_mask |= workload_mask;
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_SetWorkloadMask,
> -					       smu->workload_mask,
> -					       NULL);
> -	if (!ret) {
> -		smu_cmn_assign_power_profile(smu);
> -		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> -			workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> -			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> -										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> -										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -		}
> +					      SMU_MSG_SetWorkloadMask,
> +					      backend_workload_mask,
> +					      NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		return ret;
>  	}
>  
> +	smu->backend_workload_mask = backend_workload_mask;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c5d3e25cc967..225629eb9422 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2528,79 +2528,89 @@ do {													\
>  	return result;
>  }
>  
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input, uint32_t size)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> +	int ret;
> +
> +	if (size != 8)
> +		return -EINVAL;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor->Gfx_ActiveHystLimit = input[1];
> +		activity_monitor->Gfx_IdleHystLimit = input[2];
> +		activity_monitor->Gfx_FPS = input[3];
> +		activity_monitor->Gfx_MinActiveFreqType = input[4];
> +		activity_monitor->Gfx_BoosterFreqType = input[5];
> +		activity_monitor->Gfx_MinActiveFreq = input[6];
> +		activity_monitor->Gfx_BoosterFreq = input[7];
> +		break;
> +	case 1: /* Fclk */
> +		activity_monitor->Fclk_ActiveHystLimit = input[1];
> +		activity_monitor->Fclk_IdleHystLimit = input[2];
> +		activity_monitor->Fclk_FPS = input[3];
> +		activity_monitor->Fclk_MinActiveFreqType = input[4];
> +		activity_monitor->Fclk_BoosterFreqType = input[5];
> +		activity_monitor->Fclk_MinActiveFreq = input[6];
> +		activity_monitor->Fclk_BoosterFreq = input[7];
> +		break;
> +	default:
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 8)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_ActiveHystLimit = input[1];
> -			activity_monitor->Gfx_IdleHystLimit = input[2];
> -			activity_monitor->Gfx_FPS = input[3];
> -			activity_monitor->Gfx_MinActiveFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreqType = input[5];
> -			activity_monitor->Gfx_MinActiveFreq = input[6];
> -			activity_monitor->Gfx_BoosterFreq = input[7];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_ActiveHystLimit = input[1];
> -			activity_monitor->Fclk_IdleHystLimit = input[2];
> -			activity_monitor->Fclk_FPS = input[3];
> -			activity_monitor->Fclk_MinActiveFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreqType = input[5];
> -			activity_monitor->Fclk_MinActiveFreq = input[6];
> -			activity_monitor->Fclk_BoosterFreq = input[7];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
> +
> +	if (custom_enabled) {
> +		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_input,
> +							       smu->custom_profile_size);
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
> -
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    smu->workload_mask, NULL);
> +					      backend_workload_mask, NULL);
>  
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		return ret;
> +	}
> +
> +	smu->backend_workload_mask = backend_workload_mask;
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..272a44b6faf7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1717,89 +1717,100 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> -					      long *input,
> -					      uint32_t size)
> +static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input,
> +						    uint32_t size)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> -	uint32_t current_profile_mode = smu->power_profile_mode;
> -	smu->power_profile_mode = input[size];
> +	int ret;
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (size != 9)
>  		return -EINVAL;
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 9)
> -			return -EINVAL;
> +	switch (input[0]) {
> +	case 0: /* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[1];
> +		activity_monitor->Gfx_MinActiveFreqType = input[2];
> +		activity_monitor->Gfx_MinActiveFreq = input[3];
> +		activity_monitor->Gfx_BoosterFreqType = input[4];
> +		activity_monitor->Gfx_BoosterFreq = input[5];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[6];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> +		break;
> +	case 1: /* Fclk */
> +		activity_monitor->Fclk_FPS = input[1];
> +		activity_monitor->Fclk_MinActiveFreqType = input[2];
> +		activity_monitor->Fclk_MinActiveFreq = input[3];
> +		activity_monitor->Fclk_BoosterFreqType = input[4];
> +		activity_monitor->Fclk_BoosterFreq = input[5];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[6];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinActiveFreqType = input[2];
> -			activity_monitor->Gfx_MinActiveFreq = input[3];
> -			activity_monitor->Gfx_BoosterFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreq = input[5];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[6];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinActiveFreqType = input[2];
> -			activity_monitor->Fclk_MinActiveFreq = input[3];
> -			activity_monitor->Fclk_BoosterFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreq = input[5];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[6];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	return ret;
> +}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> -			return ret;
> -		}
> -	}
> +static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask)
> +{
> +	u32 backend_workload_mask = 0;
> +	bool custom_enabled = false;
> +	int ret;
> +
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask,
> +					  &custom_enabled);
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	/* disable deep sleep if compute is enabled */
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
>  		smu_v14_0_deep_sleep_control(smu, false);
> -	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	else
>  		smu_v14_0_deep_sleep_control(smu, true);
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
> +	if (custom_enabled) {
> +		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_input,
> +							       smu->custom_profile_size);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -										  smu->workload_mask, NULL);
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		return ret;
> +	}
>  
> -	if (!ret)
> -		smu_cmn_assign_power_profile(smu);
> +	smu->backend_workload_mask = backend_workload_mask;
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index fd2aa949538e..91a3bf074f78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>  	return ret;
>  }
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu)
> -{
> -	uint32_t index;
> -	index = fls(smu->workload_mask);
> -	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -	smu->power_profile_mode = smu->workload_setting[index];
> -}
> -
>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>  {
>  	struct pci_dev *p = NULL;
> @@ -1226,3 +1218,33 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
>  {
>  	policy->desc = &xgmi_plpd_policy_desc;
>  }
> +
> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> +				       u32 workload_mask,
> +				       u32 *backend_workload_mask,
> +				       bool *custom_enabled)
> +{
> +	int workload_type;
> +	u32 profile_mode;
> +
> +	*custom_enabled = false;
> +	*backend_workload_mask = 0;
> +
> +	for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
> +		if (!(workload_mask & (1 << profile_mode)))
> +			continue;
> +
> +		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +							       CMN2ASIC_MAPPING_WORKLOAD,
> +							       profile_mode);
> +
> +		if (workload_type < 0)
> +			continue;
> +
> +		*backend_workload_mask |= 1 << workload_type;
> +
> +		if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM)
> +			*custom_enabled = true;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 8a801e389659..8d40c02efa00 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>  int smu_cmn_set_mp1_state(struct smu_context *smu,
>  			  enum pp_mp1_state mp1_state);
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu);
> -
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
> @@ -149,5 +147,10 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
>  void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
>  void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
>  
> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> +				       u32 workload_mask,
> +				       u32 *backend_workload_mask,
> +				       bool *custom_enabled);
> +
>  #endif
>  #endif
