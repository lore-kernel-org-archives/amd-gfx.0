Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF07C02188
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 19:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A695910EB6F;
	Fri, 17 Jan 2025 19:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWj7gaMC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BA510EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 19:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6ZqM75Fsx5H9VYTTc9zan9E0f7cuhyoI2gxadnZome0N5JZM2n6w2Dk4rh9OqoKTfZZcFZGooBxNVenpK54Idv/O/Sxcf7rof7e4qd29NWKQe8rIU3NjwfB0EO9GH1Xo3d4Zm3a5cx4SXxDJVUSuM03NWYm3e5D3kHcSnF8lIPdwC1Zm0wc38WOO0/4SjCH9mC0Gb2/3SVMVw+5qcVrr09mnc1Jk59xm49TYW2zh38nwk8NjW75W4a/ymUnfvo4c0iBBPAzb2u0ilX/6G3oB5wjilzZbN1S1OZCyFdR/6MIDNJK2wrTe6pEWs4p5h6CNI9gBisPtZwukJFOW0aVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS8e2sgqM+PVgqYADjEPjtcnpOMeFT5QfRSrL2S644k=;
 b=PE6Lzwl66XGtgDYO1MOCHGcze5ATvzfKQuj479b/vKBvs0eEacVxIuhCCRjXxgdfkrbyQmdUly3TToMICNxwdMdmB21wjEJ+xgpAs3YgE8t6g5cEI/OQf5Pf6u7YAJERSP1HiQdRSrLePfEBVS6Cri0y1CMmy5xmClQxn9C6iPxRNxzZLfcn1tluZRVcun1bgpbY/v0ufN8guJsmm+vQsfMU7kafaHyeK8P5apdBE9QthWM6EnT6y9GxDURg71zeXiqA0+Xp2QpYgBauxgmHUnBNwhN8g8Ml8sbjdEV4NZbPB4+TiQHB7RowQlmnH4WN+24BBSiNjqH/nFQwz3YWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS8e2sgqM+PVgqYADjEPjtcnpOMeFT5QfRSrL2S644k=;
 b=iWj7gaMCOHrouXE3paMbGLyuLwJGy1pO72RPB1H2AL9UydKvuBCi2waUEnD6dA3FmhytrVsCk2zqy0WV+hc13623Y7bPMjGusKfKeb3a5K0/7GMve8Jpt7OkIxNPiJZJDc+glX5cXlPxpm45pOoV1T+a1sqq568g725lqBy/e00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 19:28:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 19:28:02 +0000
Message-ID: <90128cb6-0828-41eb-aa27-6b8396fb674f@amd.com>
Date: Fri, 17 Jan 2025 14:28:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix SUBVP DC_DEBUG_MASK documentation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20250117191856.2781254-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250117191856.2781254-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9503c9-f47a-4db4-1103-08dd372d0efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkxYMUx6dTNST0xzeHl1bWNsK1RlbkdwR2JNS21KLzlyQzNNOEY5UlRiZHJM?=
 =?utf-8?B?VXVQMHc2V1VwL2pxdGJqdkZpbUpkL3JOMm9BMWkva2ZrQkowYUUvRVF5eHBu?=
 =?utf-8?B?aGxZNjZEa3hSbmhYRTkxbFZPb3VaMHdnQkZIRjI2aDRFNzRIS0x2YjZPMmdI?=
 =?utf-8?B?c0hYYkw5YjBON05oMy9vTWI1TDlhbFpKYXhrdGtYelcxUGtPTk1xRHhVa3Y2?=
 =?utf-8?B?SERHaFk4cHVIcG04eDcvbDdQaGkyM3E4U0QrN1FSYnVmMC9ZNXg3elRMbUFj?=
 =?utf-8?B?Y21abHUyanVpVllNR1hzNnh3OUNSajExZzZHZWtmOGVWc1dQWFErQ3FHTFZ0?=
 =?utf-8?B?dTBNbFRLbkE3L1ZUUlpoejhHTFplenlhR0FpbFFNTFRKVlUrdWJrSUJVTDBh?=
 =?utf-8?B?T2FITXJ3SW9YK2Z4bEs5Y1lVV3J6VkQzVFhYeEFXSDBxTllrc1dBempvZnFz?=
 =?utf-8?B?VUZ2R0k1L2lGUThldFJQY0xFSEczYTk0dWpLZC9rUjBJc2ZTMjZMa2IxYVdL?=
 =?utf-8?B?MlhzMXBUK1lGNnlNRitQckRmRVFPNFdDd0YyYy9MSnA4ZUZXWkFiMm50ZGVp?=
 =?utf-8?B?VlhHSFlGVWFFUmV6VStvRk91ZlVST1h6RUdGSTJQeGZkTXR5aHhSUjYyWlkw?=
 =?utf-8?B?bFZHRUdVNjBBcG9PTFQxSTFtMU1tWFo1aDZyVGpSY3R6bnZ5UE5NYWthRUxN?=
 =?utf-8?B?T3BTQmFlYk9kSGE5akFjbm5EK29QTlJMZ3ZMYmw5bjRlMmpkeDVHV2EzSkFq?=
 =?utf-8?B?SjRtSGdIdmlCYUluSFpvTXZucU5WWi9YK1JPQ0tDVk9YNWl0bXl4TG84S1Ex?=
 =?utf-8?B?dC8wa2JwSTBpTjBmWUhBMFByWFVSdG0zM08xRHhPVXVqc0hRSmN4RG5mVDdx?=
 =?utf-8?B?UC9xaW51QnNIbnlaYjNBWWtqNHFHUUhTZy9Ga2IyaDlxRkJuWlppOGtBR01s?=
 =?utf-8?B?ZTEwOWJFMC9SY2lTWjZYeUZPMnU5MDZjeUlVbU13OUdSRkR6dGtRM3VqNnRo?=
 =?utf-8?B?YUNmU2JDTkxRbXFWZ1RFS0tJMWZaUnBoNE9Rc3hvdGdUL3B4aG9nWFhYeGhV?=
 =?utf-8?B?YVI0bWZwZjRQbWEzcGxmR1V3aTl0NVFIbHc2TEFWUkVQWjZ6bjh6RTlkRlRw?=
 =?utf-8?B?dlFVbjhHZEpLN1pmOTlsTGFxNmVvWXZKMzBzYzJXd2RpbnhTOUJtQmNzTWI3?=
 =?utf-8?B?RWwwNzV0R2xlSWRTQytJeS96SFRoMHJ5SU1KRXlPMVRPa2pWc3E4S1BOWVhV?=
 =?utf-8?B?MkhoanNibUJzUEZzV2xkZFF2ZGhhQTRGWTJaSzlmZTRVcHpyTjloZWVtZC8v?=
 =?utf-8?B?TjZjeS8vMEp4aC9nNkMzZXBmd1FGU2hscjE1aDhod0htV1BTMzl4TGZtbDIw?=
 =?utf-8?B?NEF1QlliQllZQk1raUhzU2ZOQkdwVFFjdVpsZFBpQTZodEJQbVp4c1RpNC95?=
 =?utf-8?B?SUVWRnhyL00vNmhXZm4rdEpPMzQ1SkdBeElQSCtzakEreUlvOHZDTUM1c1pV?=
 =?utf-8?B?bDd1c2IwMlpJUi9NVmVqMGRuanMrM28zUUdCc3I2Q2I2NWYzdE1FM2JKUW1r?=
 =?utf-8?B?bkVmcU92dmd6NmovMmdRMGFzZnkrN0kwTmtrUldvK29XWDQyK0Z3TW9JZHoy?=
 =?utf-8?B?SFRLRFE0cTE1U1lXQnM2L2F6bFhqaEgxZWVFSm84ZjlUMU1mMTcyWmxTc1R2?=
 =?utf-8?B?ZkNra1NuN0FlY1RCYWF6TlU0Wk01U1VvckZ6T3dWdUsxenFZZW90TXF5dUp0?=
 =?utf-8?B?a1ZVd0tPS3p6WFFJUXhDSUZwOU1jZFFkcWM1Wnl3K3VYVE5UNUFPL3JMR3VE?=
 =?utf-8?B?ZVhpMkg3WGMwbEV3cS9DbHk4WmluL2ExdCtaajROaVlKbkUvT3FQaXdZSFVk?=
 =?utf-8?Q?GocoBB2hXzZrp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCt1c0k1aDJwaTBXSnBaenk3WXp6Y3NwZ2ZvRU4rdVE0amN5RUJnMGY1RGRC?=
 =?utf-8?B?NmJJZm1DNEFjazAySURmNVJ4RElPdVlFQUhWaUxvSHowTWdNOEFUL0pNSU04?=
 =?utf-8?B?bjY4ZzRUamJOMVBWWERtL2swNDVkU3N5dmYzYXF1T21uQ3J3RjdCd2d3U2xp?=
 =?utf-8?B?YWJVVTZxMHE1ZUl5Q0hRSmtJTWliclRuRUsxQ0ExV3htbDdqYXU2ZFJNWldh?=
 =?utf-8?B?cEkrL0J3U082Rkh0TEZnN2hPV1BkenppNTRKcW9tV0tYR1RpdlFYdFh4TGQ1?=
 =?utf-8?B?SEZBQ0NENThnUDhWTm1MOGNMSy9ESkdQTll1QzMyNXZZUkxEQXZLb0FoZEtM?=
 =?utf-8?B?dVhaSTF5MWF1L1p2S3pUc0gvaHhIb0Z3anhPakU4RUtlYnpBME1IeVlaN2lx?=
 =?utf-8?B?TWNtREk5QklObSsvUnViRnlFZTlaRnlTZU5SK1pPODFDNFhydUREcmgwRitN?=
 =?utf-8?B?Um5UWWEzd2JENlJnWG9LSjdMZSt4SzRaaTdjc3NIYm5oUGJ2MXh0bVJDbE9U?=
 =?utf-8?B?dlZLQkVJaSswVUxlNkRYVVVLT05nOTd1bkRzNnlUeU4xWit0eUlPbHVPMDhp?=
 =?utf-8?B?MmtwMS9XNEZ6RmZUY1l4WG5iZXd0Q2xJRnUwejRCUnlYZGJnTnVpRWpmVUdB?=
 =?utf-8?B?WGNjQUFMOGFONVZpVjdockd2cmsxVVc4QVRkM3Y0RWlvdUdtMVF0bk1NQVI0?=
 =?utf-8?B?MGZ3bnhyVVRwUjk1N1dOd3o1SzFEMER3aDY5NzVvaktMZnh2NE1nQy9ha2tP?=
 =?utf-8?B?NGVZMy9zM3NYQVArcmt4TC94b3A0UDk1ZldSQzQvNkNZQWhZMHJ3dkN0OU9y?=
 =?utf-8?B?VS96R1R2bXpFOHNBNzRCcFRLUW1GL3dZckN0Nm1MejJpeXhWNFZzL3pzRCtw?=
 =?utf-8?B?RTZzTUkyeDUxbnl3WUFFZFZFYm52TnU3M0xzbjAzZHVTTWFmbVo5TGh0dkNz?=
 =?utf-8?B?N0R5SC9JdUlPYmRXK1hzd20zRVRVN2dOM0dSYjBuWjJ4Z0pjdUVUWTdpdlU4?=
 =?utf-8?B?WkNmdkxrMTZIQkpkN2hGMGJicERmVHZLbWpDZ1paWXNEcncvdkY5QXc5UHU3?=
 =?utf-8?B?UXhlUnJrVXFGWWVYSitVbUgra1VkdDVnYkZ4OWV4QzljSzlWaHBINjE5WkJW?=
 =?utf-8?B?VWNsRVdtaVJ4ZXNRMTdWb24zTkVDYXpNQ01zZC9TZndjbkxheFhyRzVtaWI4?=
 =?utf-8?B?cUlYdnFPM0IvdTVUdlpHQlNVN1FBOFJVN1VHaHJyanZETW4weXFZeDhWRWQr?=
 =?utf-8?B?Q3dKRnBPSmZob3NXYTJzdXh4aWZGZllrRjNRUlcxNDlzVTVuSXlvVFk0a0dW?=
 =?utf-8?B?UUZhbUFLdlNqbFlUU2IvVGF5cTduOCtwUEFSWkhMa3RxMG5QanhrNlBGaGhv?=
 =?utf-8?B?NTJHME5vUmJzREVHbStiL2ZXUUxmU1B0YUdUSml6dGF2Sk5xMytzM2pDSCtQ?=
 =?utf-8?B?Mzh4THZ1TjRDUG93RXdpMnVINEJiV29tUnR6MVFEN05wOEhjSnp0cUdrYi9V?=
 =?utf-8?B?YU9XWnkrNDJiZGRmMkJUTWFIaHdGRnhKWElEdCtaTTkzRDZHTTZCZllNR0JK?=
 =?utf-8?B?YXJ6cWo1aVZNR29oZy95MW9BYkUzeUFOeWxIb3Z5TU40V3dabWdpMjdsTWox?=
 =?utf-8?B?V2owR1ExKzZ1NVFMakVGQnUraTVkclljUHcreGN3R0lrNHBJWGVoYkhFNUpW?=
 =?utf-8?B?QVRTVktGbWxJcnVJZmhJNGFIZ3hpMUpWalZqbWREYnhjbVY4UnIySUE0dHdQ?=
 =?utf-8?B?L3Q0YjVOdlZ1TXRHajhEcEJnYWdvWHpEZUhHMnpESGM0V0ZFd3FqUmVoa2Fy?=
 =?utf-8?B?bVYzalpRQ0ZHaERFTnNNcWR0MDN0Z1dSNjVmZ3ZJbXFQdDkzZTFkRUg1L2VU?=
 =?utf-8?B?QUE2TnA2SzdXMnpOeFpualRySUZpd1RYd3g2NHh1MGtaUUExQlE2TkR2eWNy?=
 =?utf-8?B?Z0NLbUh1NUlvTC9lVFlFMWtGTGtTQXVPMVg2UlJwNGFMcGx1NUVHN2RZVFdt?=
 =?utf-8?B?OGtPRWpkc0dmZmpnSkhVWGJSdExocm0zZmczTS92aTZTYnhyNG5ubnJHVHJQ?=
 =?utf-8?B?TFlvalpsY2tNOUJacWY5aENDTXdyV05yS0YxNFhyR3NLRXBwb0dtM2RTZ0pv?=
 =?utf-8?Q?TKkhrU1sl0Hn5R+vGRCqigvya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9503c9-f47a-4db4-1103-08dd372d0efd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:28:02.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T/fUSBriOu00uZoA144d7zdb8rGhAO/E6S+rH4GsYJgwGBb0N9n6GKf5nsTNuujozixxc22MJrq7lnp/gnU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

On 2025-01-17 14:18, Alex Deucher wrote:
> This needs to be kerneldoc formatted.
> 
> Fixes: 5349658fa4a1 ("drm/amd: Add debug option to disable subvp")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 5cb97414e4a33..6dccee403a3d1 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -350,7 +350,7 @@ enum DC_DEBUG_MASK {
>  	 */
>  	DC_DISABLE_HDMI_CEC = 0x10000,
>  
> -	/*
> +	/**
>  	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
>  	 */
>  	DC_DISABLE_SUBVP = 0x20000,

