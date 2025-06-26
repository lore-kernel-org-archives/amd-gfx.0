Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979CCC7EE32
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 09:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3889210E277;
	Thu, 26 Jun 2025 09:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A33UHHXT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6391E89A5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 09:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clGQW5Qn8rzyKZfTMFAHFxQXGjjop2lcH2Rg+/kaWXH3GOiRaWbA+vJYs/wDIBRmIHseW/Ty20CY5DBqfTfooDQ8VJ78MTXIXOcjSSboks90tAzf2H0N/OXBCqt1+ksSl+dKu1iQ9JQpwsoxldyr8Un+88L41t9m2mUVvmDnFJz2zv6NJp6nFhMu8QtmEPB5N5IHWp9M6cT5XK3hvTTCDfA16AedsNoJrI6TRRooipchv8aDXxoDBqq87hoNDV5NSA4mOuG9lKqnM8EgouotXzgXr5auMZFfdRhn3oNP9sN3RAarwXMQ/2VMNpFnRL5tuxCD8g2UasG9CdLaxSCO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaFTR1tHEA4D/5mxdc439oWybERRvrOwxO0j6sdGYzE=;
 b=iErWLJJ1Ze/JiYWtUkqXM7U0oDEmppAOPQ+4RU7gH4uN9PSXX5SoHXFBK7mOCaklM8cuRtRUB6j8E9cPsrfznnrV1tvwiRuNnCaIDIvz2y3nsabNzyiJJIz0X1U+vbFsQ7eXRozbH562gucKS9NWwO2Vnc1lelSXs1Y8MAcNkROZRh5kqfjYslZq4vZqQC0E5wx0pSDKLjg/aVbvIJMH5QjRxqKsWvAanzjxQUBsJI4+Msq9omDunNq4z4UMvG6tR0vIqXx+603CvH81IM8jfJCp7J3iz8RA51m/BM8TUaIJQlbq3U1XpisBGmtGLwiS4vph1T+qIwgP1nmQS3gQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaFTR1tHEA4D/5mxdc439oWybERRvrOwxO0j6sdGYzE=;
 b=A33UHHXTH+u3Ua46CltO15Wbx/e+EgLDVENVMl2o5GS7gDKnX0na1SAt7v4jC8Deh2R3H2ZN/nakAHgGiYcRG2BxFrJi4MMBVd4dEvZA57eJtxYowLETI/8mIthvhJryV3M8lgNFYGle3klwqyiRonir4LfujiGItio1kjRGJ9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 26 Jun
 2025 09:10:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 09:10:26 +0000
Message-ID: <b9cc2730-4736-4440-8429-633785b5ad31@amd.com>
Date: Thu, 26 Jun 2025 11:10:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/30] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250625210638.422479-1-alexander.deucher@amd.com>
 <20250625210638.422479-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250625210638.422479-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a30d8b0-9b18-47a1-bb52-08ddb4914a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXBpWGoyckx3N0FNdEFFeEN6aWxsdTJQTS92QkJVRWRiWVAzWFJHNHBodGI2?=
 =?utf-8?B?bWJ0OFVUcGRJREdwZHVhVERoakoveUN6WnIzNkppQm1Qbk9vM2hTMGhqeTBw?=
 =?utf-8?B?VW9lWURsVFlwK0RiUEZ2dzdOUGtKMEsydHVoTkFUQXhXS0phUHEyd1FvdmN1?=
 =?utf-8?B?bUNEcU5wbU5jZGdIUTdtMndIL280Vkw0MVZ0cnhNZWk4Y1luMDJaVzBpeFZP?=
 =?utf-8?B?ODV0TEFCcDlYVDh4dktBYWxFRnJpbncwZUhBMEpKc21VRUk3OGQzR1Zadmk5?=
 =?utf-8?B?RWRpSHJyWGNtWFdUR3Q3SWJLQXhSWmU4OWhjUEFNd1oxc0Z2NGVPaFlCTEVh?=
 =?utf-8?B?R2pZdloyUGRRSFY4cEJId2NvUjdTakw3S2NzT3BkdlkycU1EbFFYOXhNaWc3?=
 =?utf-8?B?QXZPdlR0MTNSYzBWQlk4dGNXRzBvbDhHcFhwUzhMNHg0blVKMU9EZjA1VUY5?=
 =?utf-8?B?RnFNdHpNUzdqOUtXYlgrU01peDVydE0yTUt1Vjc0Wi81TFM4UXVmNVh2L05q?=
 =?utf-8?B?UWJyc1Q1bTB2bFhSSWpaVzB3ZzBzR3dKZFZzdGRnWjNUUndISWZJb0lIV2VC?=
 =?utf-8?B?anZPTkU3SUVmQjZ0Tkhnc2Nub1FCaVZGeTFpdWJFRUJoWkpFcExIMS9nWWhu?=
 =?utf-8?B?ZldIMWJPUXpTS0NLeGY4dGxSMDRxdVhLVzA5WHdGMHNtcHhLSFVacm1WNFpU?=
 =?utf-8?B?V1RDeWx0NW9lM3FrZ0hvbFhNM084bVlObVhuZFYwakkxSEQzRWVTUGdWVnNh?=
 =?utf-8?B?ZEtOZGJvVnB6c1U1WG5yYlNnbHE0dk5Pb3dWT0RsZk1vbGh0anoremxGZFJI?=
 =?utf-8?B?SytWV0xXeEh3Z1l0OXZLdGxJWGYveEJYU051TTRhUlhNYTZPWW1MZVAyYzFu?=
 =?utf-8?B?UVRjRndtaU5yVFpONFhVNmZ0QU9BeXArVzc0WFpRVEpLUW5Fbk9GaW5tbEMw?=
 =?utf-8?B?Tm5OMjlwSmd5ZVFnK2xtSlFqYXExRWliK3dvTi8zOUpGMjVFck9WMFJPdHUw?=
 =?utf-8?B?SFI2ejV4TURBYk5jTm9ITmJFdjExS2JVT0JOSW9mRUNQbVhFSDh3dDQ1elpB?=
 =?utf-8?B?SHNCd2UzRlhURVJuYVkyNVlPSzJVMkliT3p6Umo1RjZHdGZiZFo3Q0dhSHIy?=
 =?utf-8?B?YkludG5SOEZQME5hMmY0YWt3YkhpYzRabnhnMVFPVWRZWlJkS1R6S2tjcTlS?=
 =?utf-8?B?ZUZiMEFIU2dQY3VZZitITVFoYXRndEJqSHJ5UWltaXRBSkdpUmRGMHNTU3Nw?=
 =?utf-8?B?VnJRVHNmQ3JOOFhTZmtYK0t6OThpTFIvcVhLRjR4bytjaWNRV0c0ZkYxZ1lM?=
 =?utf-8?B?WHN5aW5tMmM0L3JiaFBpMkI0R0dyNXVWWFMvOUhDMTBOOU95SUxheEhjREIr?=
 =?utf-8?B?bXlqR3J5Ymc1cnBkUmNtcXhud3JWaTZtM2loeDY5S3g2UjViNnZoYXhkaHJ2?=
 =?utf-8?B?ai94MkloTFNhU09UUTlESFc5bGFQRlhJN2dFQ1RkUFBlVTk1SUkwT2dMbDlR?=
 =?utf-8?B?SXNEK0tTWkZuZngvK3RadnR5VTAzVnloSkFkZ3pHR1NEd3FYd1RRRHNXTHNz?=
 =?utf-8?B?VmQxVlRWamd5ZW5CRTVFK1pLbm9lbnhUMCt3MkgyeDlIMVVZdEcvYVFydU9s?=
 =?utf-8?B?ZFQrSnJ6dGYvZzBnbFlRMFR2L2JsRGF2U3pycmErSXlyNlBoN0trRjJIb0Ji?=
 =?utf-8?B?ZTBTR2NxTUYxamdCZDc4NENBS3JvNW5GdzM5U2lUeDRLdSs3dUFmcjdybm1F?=
 =?utf-8?B?QkVRVWpGMDM4U1ZlVGhBc1pwUkI4NVNHcHUwZXlVOVhxK0N0ZTllQUwyTXNM?=
 =?utf-8?B?QlVmb2dOUytXa0V6SnFLTkREeEE4N2IzYk1aZVFKVFN6dEZMeDF1R29pSUJ1?=
 =?utf-8?B?NmhHbjc5R2EveVBrNEN4WmlhWTAwOXlqRjBxbzNkSW96YWxaekdTdFRGOGhU?=
 =?utf-8?Q?EFCjhzgT/5Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVremFHeVVyRWlOeC9nL21mMDBTaXorY0E4NFo2Z3J6L2hjdGRMOUFZL045?=
 =?utf-8?B?dVU4MGpsNVJkdXU3aDVXamk0ZUJQeDVNa0kxbU9uWUVwWEIvbFlEakYyNmtl?=
 =?utf-8?B?L0NaeHBlQmRQRW1xRUNsSzBUeG03Smd1TXhxdTY4bVNpQktucXR6NWFoVTUv?=
 =?utf-8?B?bnpuTDZIV3NOY3Ira1BKN2wwQ3FndXQ4MlpoNmZPTkZPQU5JdFp1MWNYYzFL?=
 =?utf-8?B?RGxQUlA3TTB4MHBTVFZBQThBV2RqN1ROWVFNbWtrUVFzdGJwWElSOGNvZm42?=
 =?utf-8?B?V05qYWZDTnJmOEkxZkdBZ1QrTWUxaGpOOFNwNTlnK2d6NE4xMDI4VWlwVlln?=
 =?utf-8?B?M3dCOThsVXVINkM5cXRJUGRUYjJiWU82Y2YzeWZUVytDOWJqdldRQkJKNjBM?=
 =?utf-8?B?elNUZDUva2Zib1h3LzlwbGZEWlJ3MGlDaHN4bWJvMDBjOXBWNGJHUllzMWo1?=
 =?utf-8?B?UUc4RkJNcTlzbkNEcUJSOWEySWlkRzRmNFBneGJGczJkNEs5b0FyVGhBMzJ1?=
 =?utf-8?B?b2JOdFBwYStpNFA3d2x6bUxzb2RFdktXQ2FTenJ1bVpJWW50MFNxNzJka04w?=
 =?utf-8?B?VytQd3l0dU1NTGVDZ05BWDUzRkdiZ3g2bWxrenZHMU0zZWNqY3JSalZTNTRP?=
 =?utf-8?B?M2UxWkhzTmpjeGJ1cEthWkg5OWh3Sk04cDhDNW1RV1NIL3p0V0VaV2FSN202?=
 =?utf-8?B?T3lKNVp6Y3dOT01uclpXQW9HcFVZTlg3d0lYS000R2VBSnI1VlZjTElwS1Zk?=
 =?utf-8?B?NFZCRVpjRDlQZjlZa05rUmMwMnlEaFFRZUlycnd3ejluMWRjTkZQMmJwK2Jp?=
 =?utf-8?B?T1p1a2ZXNXRVYmNvVThObFRMSlBpUnZ1aENyUHhVM2NTQzJ1cXVRN09WZmpX?=
 =?utf-8?B?VTNtMW1wZk9aSC9yOFVpZCtpbkhiUzAvSk9KeXl3bWgvRGtJczJrdHA1enRq?=
 =?utf-8?B?RlA1aUk2L3NQZWFqWFNhUitPNTlVRW5WeHBjZys2WWNvSyt2ZlhnQ2ZEeWh4?=
 =?utf-8?B?OFQxWXo5RTBWY0VZM25sV2xsbDhaeEY1OHRKN0FZaDRCd0ZYTzJDbFdLR3NH?=
 =?utf-8?B?VExMYkxSS2xLcERqTmtjaGZXU08wZE5CTTBxd29mR0ZUQW5FZ1Fsa21sVytD?=
 =?utf-8?B?UFNiSXBMZDhDTTBCbk50QjlvMEQva1lBV3A5WWdkQU1zd2wxK2svemtmWlhO?=
 =?utf-8?B?aFdTOGNpVHRucWUxanA3QU9ONXM2ZDNzNldoOE1ZRTZybGxuVFJkMm9yY3kz?=
 =?utf-8?B?TE9aQk8zL3YzT2dhcWpxeHRPZ2tyNENKdHphY3orcEw0YnVGbU9lOG1YMzlO?=
 =?utf-8?B?TmpqWnNVcWVRZUdRM3diZ3p0SFFUVnMwNFBNK0ZPcUEzYWNqTmVwOUh2aEpm?=
 =?utf-8?B?MTBCL29QVUlUTVJxNlNlSVlJN3lteThiN1lhdm0xNnk1NjA3V0ZYcGFMdlBQ?=
 =?utf-8?B?Q3BteUJFOWFCQTNnTURKNkd0L1BCY0tuMnRvSkhMbkV1aHdkRnF6cGhTR2JU?=
 =?utf-8?B?ZXFQb09ueUIxOTc5S2UzbS96SmpCdzFudzRJSjkyczBaRllyY2hNWTh1STY5?=
 =?utf-8?B?QVpqUm5oNThMblJJTGNGdlpFNFJqUEx0YW5JSzlsanFkdWx0T21tcjU3UmZE?=
 =?utf-8?B?QXZzVkMzalhwbGNqSzJZMGFWejFxYk1aQUFFaXVBdGZMOXEza09iRFpjTUtn?=
 =?utf-8?B?eXBFdHA5MjM3NkxZdnBaYXc5dUoxT0E0UFB0Zzlud2w2UGpWN3RVd21MSWlk?=
 =?utf-8?B?SlprRUxOekZzMHBOVUR5MnNkOStRNUhFa2pwaEEwRGt1cWhQWXRNdFFNSUlG?=
 =?utf-8?B?NXcxTTlXS3V0eFR5OVNRNTBlZERjZHlTNmpUSnhIWWh5QVdTSDk4SHhmMG9t?=
 =?utf-8?B?aHBsOGNMNWpuVEprdjZ6RlFJV2luUW0zVVUrQk9XYnMyT0xCQXVWNTJUdUNx?=
 =?utf-8?B?ZUN5OGQ1RzhQaGFGRE5CRlZLRGsyRGNhOHBIQjQ2MDRnRTViRkRvUDFBWFpq?=
 =?utf-8?B?S2NKM3FERDZSYi93eHZxeG1TZkVwbE1rMUJONzZxZStsbkIva1h3eWZubTV6?=
 =?utf-8?B?UTlPaEZ5TG1yTUZjYm5iazhQbzgrM2UxNVpMZ2FmUXV5Tk9uOWdyTHhJcFlI?=
 =?utf-8?Q?iaI45Vdk2t1bAJ6y9UsrLlfNT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a30d8b0-9b18-47a1-bb52-08ddb4914a20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 09:10:26.5031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zzl3gxfniUf+X2DBsMwKwVpYd64Y0hxJT6smhn47mWQyAfsmttwJ2Xzbhiq7XTBg
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

On 25.06.25 23:06, Alex Deucher wrote:
> What we actually care about is the amdgpu_fence object
> so pass that in explicitly to avoid possible mistakes
> in the future.
> 
> The job_run_counter handling can be safely removed at this
> point as we no longer support job resubmission.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 34 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
>  3 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index dc92952bf1269..2d6b2b486baf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -99,14 +99,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>   *
>   * @ring: ring the fence is associated with
>   * @f: resulting fence object
> - * @job: job the fence is embedded in
> + * @af: amdgpu fence input
>   * @flags: flags to pass into the subordinate .emit_fence() call
>   *
>   * Emits a fence command on the requested ring (all asics).
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> -		      unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +		      struct amdgpu_fence *af, unsigned int flags)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence;
> @@ -115,36 +115,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  	uint32_t seq;
>  	int r;
>  
> -	if (job == NULL) {
> +	if (!af) {
>  		/* create a separate hw fence */
>  		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>  		if (!am_fence)
>  			return -ENOMEM;
>  	} else {
> -		/* take use of job-embedded fence */
> -		am_fence = &job->hw_fence;
> +		am_fence = af;
>  	}
>  	fence = &am_fence->base;
>  	am_fence->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
> -	if (job && job->job_run_counter) {
> -		/* reinit seq for resubmitted jobs */
> -		fence->seqno = seq;
> -		/* TO be inline with external fence creation and other drivers */
> +	if (af) {
> +		dma_fence_init(fence, &amdgpu_job_fence_ops,
> +			       &ring->fence_drv.lock,
> +			       adev->fence_context + ring->idx, seq);
> +		/* Against remove in amdgpu_job_{free, free_cb} */
>  		dma_fence_get(fence);
>  	} else {
> -		if (job) {
> -			dma_fence_init(fence, &amdgpu_job_fence_ops,
> -				       &ring->fence_drv.lock,
> -				       adev->fence_context + ring->idx, seq);
> -			/* Against remove in amdgpu_job_{free, free_cb} */
> -			dma_fence_get(fence);
> -		} else {
> -			dma_fence_init(fence, &amdgpu_fence_ops,
> -				       &ring->fence_drv.lock,
> -				       adev->fence_context + ring->idx, seq);
> -		}
> +		dma_fence_init(fence, &amdgpu_fence_ops,
> +			       &ring->fence_drv.lock,
> +			       adev->fence_context + ring->idx, seq);
>  	}
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b39..206b70acb29a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_ib *ib = &ibs[0];
>  	struct dma_fence *tmp = NULL;
> +	struct amdgpu_fence *af;
>  	bool need_ctx_switch;
>  	struct amdgpu_vm *vm;
>  	uint64_t fence_ctx;
> @@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = job->csa_va;
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
> +		af = &job->hw_fence;
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = 0;
>  		gds_va = 0;
>  		init_shadow = false;
> +		af = NULL;
>  	}
>  
>  	if (!ring->sched.ready) {
> @@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>  	}
>  
> -	r = amdgpu_fence_emit(ring, f, job, fence_flags);
> +	r = amdgpu_fence_emit(ring, f, af, fence_flags);
>  	if (r) {
>  		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>  		if (job && job->vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e1f25218943a4..9ae522baad8e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
> -		      unsigned flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +		      struct amdgpu_fence *af, unsigned int flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>  			      uint32_t timeout);
>  bool amdgpu_fence_process(struct amdgpu_ring *ring);

