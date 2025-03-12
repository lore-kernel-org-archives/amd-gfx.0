Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89113C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303A210E6EB;
	Wed, 12 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGpzmCge";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7456C10E6EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kva2ml5SDKmlfOjm95luPffRpuQsxmyIHPbfSlreOMPxXeB2/Kjeya5XzRTnBmuDbBWVrAjDG12bnFZr1VFctiFaBg19leotKX5Q1vSNszwygqV7sjNIBMnyQ60eV2IEv263SyLcMhdhFnnVYib7wQdxrkWa7f8Y5h9ojPTDIoGHGHrXbWqp0h3zo7y20rAxhAyI2NbqiaaPPcOA6alyJfH25BZfvXZtAiHQdz2SAlXWvKOjJxLJC9JLUunzQgU9ta3N7glN7+xrWIMr1TdAOCOVeIWys5kto+RxpJj2tLtFwfu9x6PA8QY+iHuEVNBtFE0g9cC6RXtICPIInC6kMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsYywiVQHR5CkTQvWRUI/8a5hLmrNLtahZgaYjVzqsA=;
 b=nCSgncstMylYTKZxphYxsc6VcJVBhwVL9Uynr+CdUuY8ZD7KkG8HUhZqRY6w+yArWGWvWraTJ/V61QGXZVyIQtbpxSWzCwFZ26VP28rmCwGjZaaNUboHJyM6MVW9LfHbBDe3rwOaZdpmR5I1WBp7xojzRUZWIi7H6wCoFYeQ1nMC1Btz6HBBLqLEAnn224wv3ScYjT1uCzkNtiMSnd/RAuo9O3qulw9A6udYGm9ZrmT6kVhQwoNGJS6NNIW7LkBuj6rh3mO/VqqSc8x1GVfF38wgFfFeWwIx8VJ0H2Kr6QOJBEtrOOUCvopg9Qxh9YlhNJytZVhCAvexpL1i+DHWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsYywiVQHR5CkTQvWRUI/8a5hLmrNLtahZgaYjVzqsA=;
 b=AGpzmCgekC6Cz9QFzv+VLA3tLsEJAlpbukC5Eb8zZItgz7mUbqIvO/5Sb0Wrmgzra4A8GgFsvJP9IxXhU+TijkXcKIdsP1XfDCcks4kTuOtCqT7SFOB99Z4hYYozUgHe48eppzWk4Dfxcb92Q0dEtUuLttCTUX75I53dxDrvO+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 08:19:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:19:50 +0000
Message-ID: <5daeb642-903a-451c-9245-b540afcabb72@amd.com>
Date: Wed, 12 Mar 2025 13:49:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250311141711.1911564-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a5aa8f-0752-4842-1e00-08dd613ea8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWp5Z241MlNkTFhYWElwUjBMTThDdEc1eDdETEE4MGo5aTZDTnB6MzlyZGtL?=
 =?utf-8?B?V1JTcWU3VE11RE9EVGNReGZsSjZkL3dROUdhVi9yM3JmUGlLWDdLU3pneVYr?=
 =?utf-8?B?am9UTFRsRU9XZEhTbXh2SUtKa3R5N05NQVZMSENVd1JENkR1Szg5WERCelQv?=
 =?utf-8?B?OWllWVFrVTkwQUdyaXRiaG05TEZGaEdBemNRWWFCU1Q2YzhxVWljbm50UmNE?=
 =?utf-8?B?ZWQvQmxYRy9tN20raDJPZWtSdU5wMW1lR3pDcWxaZnB1ZjI1YmoyVCtFVUtl?=
 =?utf-8?B?eVBUM0tzOE5hYlN2T2dOYWMwdWNHVEFWdytuTVczRThQdHcvQ29TMkR3cStp?=
 =?utf-8?B?b2IwNWZHeWttRjhvYnppY2ZCNkY1amI5cEJzbDFDejFOQWxGZUlIM3UyRGtw?=
 =?utf-8?B?b2pId1R4OTFrT1ZZalZnTlpKOWpVWkU0alphY3N2TTNFMkFpRlY5bEhwaEw1?=
 =?utf-8?B?cUF3ZnpGWWRCY2dhcmtxNEtNQ0NUczVRTU9KODlpRkpZWFV1Q1RrSVVlcmw3?=
 =?utf-8?B?NjMxMVBDNmhzRVVyWVcrdVdnWUw1ZEQ2bTJRdDZqTXF1QXh4Z0V1SzRHdndo?=
 =?utf-8?B?Rm9tcGV1Q25YUHo1N2xOclJ6OTlFUy80NFBGdm1pN1M3WHhJNFJKcnFMc1o4?=
 =?utf-8?B?WGtEUm5iOTg2c1g0UzIxUHdtaU5GNDFhOXJocUY0OEVrUmR5WjJTK2JmMEpH?=
 =?utf-8?B?MWlGUi9YTElJN1Q5QlVOUjZKQmV6MDNPazk2eUFXbjBmMkV0RVhTcDk5cHVZ?=
 =?utf-8?B?ajdpcDE4VmxjTnErRmpOZ1lMdmQ0cFFkeXdkVXFjYUZPSm1ydjMxQlNCZnRs?=
 =?utf-8?B?RFJGaDN6NG5FK0hNc2NWNm1mVzArQWxXdUR3Y0RSVzNBWVk0aSs1cjVId3NM?=
 =?utf-8?B?Si9lQUZMVTRoWDJTSStma2lXdGJWaUVydFE4SldjT2ladTJxakJrQ0VycHNC?=
 =?utf-8?B?MVM4dkhrMDdrTkZyTmg5QnJrenFUK3FYWWZYVFUwdGhzQUhXVWVFZW9kKytR?=
 =?utf-8?B?Tk1aNW5SR1B6NjNKeDd5OGpmNzltMnYrSlFOUzFpcmFKeWxBa3F0Q1dzTm1M?=
 =?utf-8?B?T0RzSmpodGM4dEM2aHhGWGFjQmtlNDVkU0xwYm1yUmZ2encvSWRSTlc1dDhm?=
 =?utf-8?B?aFNiQzY2NVBXakVTcnlkTE0zYXFoZGFzODA0aStlV0xGejdvU3lxV3MvREc0?=
 =?utf-8?B?ZkVSTE13bUxyVlFzQ0lxYUNTdU9TMHBHU2lkajlZYkw5QmxSNmFEQzd3MVNM?=
 =?utf-8?B?VEc5a1dhZGdZaTROL0dVOEdyMmppSUpxTk42MmE2V1hNQ3pSekx3M0h0a096?=
 =?utf-8?B?S1FkM0FlZFRsVnkzTmovQXFNbG4vNUVna3hvWnM3cVkyN1NuV1hNM3JyS3Fs?=
 =?utf-8?B?T2tMd0VERm5DZHNvRis4QXFaeSt1QXdGRWNVMXA4dEtIanVOOEpaZlZmb2Jz?=
 =?utf-8?B?UzRWQjFKd3RXeEgwclNwZ2Y2U2VVUGpCRERrU0t0ODF6SDRpTVB4N1FXa1Ja?=
 =?utf-8?B?MlRVQzVUMUJVaWFWUDNVZVdKNzdMdmE4UWVTNk1OUG1OOGZiQXRJMmpYaVdk?=
 =?utf-8?B?UGkwK2pqczk3WFVIMFJDU2w1UEFJc0lwWjQxblYzSldqZHpQVGdyU05hVmpz?=
 =?utf-8?B?M3lkaytOMStsS0xJRWpHSE9PeE95M1NmQU1LOFEvLzB0UlRjbStSK3QweFVW?=
 =?utf-8?B?aXM3MUhCeGxrQjBlQmkxVEFtSWNyMUtISERDLzVzbkdIcitrcHpoTkFpZzZ6?=
 =?utf-8?B?OFFBNmI2L0l3aHBLVDZyYU9jUjFYZFp3b21xd2FnRUhrT1RXRDJ5aTJQZmlM?=
 =?utf-8?B?c0h4UzFyejlSWFNEejNYVVh5c09kOW5CUHJDSUtFM2wvUkVoNThxdm01Y2hB?=
 =?utf-8?Q?AJBOGyzSPRijn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZaL0s4OGtwWjdVdi81eHYrL04rVmZaMERJUmJwU3NVbkdneFhNWk9MZTFI?=
 =?utf-8?B?TkJhVW1vVkpvUk1ocUZMcUJNbE5BMEpaOUk1ZTVTYWJMNlVCK05ucWs0ZWVH?=
 =?utf-8?B?YmRBaW9kbk9Ra1dsZ2JSSzAvNVhLTmVQZ2RGeXc2Nk92dHRNNENWYlpoMnZ5?=
 =?utf-8?B?eFlBSmM3ODJXWFRuOGI2ZkFDTkcyWGJNUWlUbWF1dDFWVmVva3JnWmpoZFQr?=
 =?utf-8?B?L21XdEpnZGtBMCtMN0FpdzUxaWFFdkdzSHJTMEZPUXBpVVVScThOV2crdzh2?=
 =?utf-8?B?T1RVNTRscVhYbXptRklaNUVYcmZ6UHZ2OGZ4TnVrMlZOdVFzeVpwNGFiMktq?=
 =?utf-8?B?SkpjUjJCbTB6ZEJNcjluMDdtdUVQZFZVVjNFSVl6OUlXRmdNTC9iZ2diV05B?=
 =?utf-8?B?eWhCTGdCRWlvbTJBellROCtNbys5cDFhV3lLaVdNbVRtLzFCYkdUeVpxVEJi?=
 =?utf-8?B?bVpyWVZhNkY3NGRqS1Y1cmFVeTlhZm5DNy9hcDBaQlJZaXJLcXhtUWxGK3Jo?=
 =?utf-8?B?aGc0VUJLT1pIVzQxQmRMSDluR1dRdDNUeFJYWHJBeERDS1FrZXZnaGxIajBp?=
 =?utf-8?B?Q2hjOWdVZDNpcjlaM2RnbWJXSWJSYVJsdWlESFkwMlNpRS9XY2tUekhKTzJ5?=
 =?utf-8?B?RzRVK2crNC90NjFSMzZUL0dOWVZpdjd0VUF4bjZYVHZrZzMvS0xmYkxQV3V6?=
 =?utf-8?B?WURtUlg2aUJCaFZCUGZSOGk2c01TZ1VGSVBhbGhSUS9QR3pOVzJ3RitMQlpy?=
 =?utf-8?B?aW04RWoyb0kxM2Q5WEk4dk1ZRVRla3pyMEhxcGFrU2ExUk11ZGF6UjVPOURX?=
 =?utf-8?B?dVN3MDl1NjBLemJtaUZCNU1sd05KTUxIckRVYm9XNUYzZU5GVU4vTjBnQ3Vt?=
 =?utf-8?B?cmRyUTl2SGZlRElqZzFENlFDM2I2OXZwYS9oN3BZYlV0eHM2c2hvQTF2eDV4?=
 =?utf-8?B?clhkK3lzVHora0lVK1hJVVl5aWxkOUVkNjd4WWlpYjZsL2pNd1UxcWVmRmJk?=
 =?utf-8?B?dWV2VytkWWlpL0lKM0NhSHJtank2cEdYK1RjR3hubGlyMU1mc0ZNeXFXV2o5?=
 =?utf-8?B?TUlwc0RSY0FLaDNaLzlqZUtaN3lsVUNhWHZJZkRxM3l4aEJibElmcVF3RlIz?=
 =?utf-8?B?eTRVV3hta2l4SlExVEprR2hXbkd0SC9uMnh2TU9LbUFCR01oWEVnMGMvWk9n?=
 =?utf-8?B?WFZVUFhLRytGd0RBWEJDOHFBNFlxYTk0U0ZJZlBUVHQ3MG1XQld6NUUxNTYr?=
 =?utf-8?B?bVEvZi9sZEhmek9pRjk4aE93UVBlK1pLWGhXZXA3Rm5lV0NNUitVT0ozWnJp?=
 =?utf-8?B?eWFyZE9XTmVScFdWVlFKazNJczdaSVVyem1EZTY5M1dTTmRYMWlvNG5vVWVL?=
 =?utf-8?B?Yjc0TU9oVm9ZRmVhNzRNOUVLSm42c0h2Sk9LTEdvWTFOeThiUjZzclFtUU8y?=
 =?utf-8?B?TXY5UEN2OHZaajBGSURpTEp0MEhOZUs0QUdoZUpyNWV4UmRlNDdTcXB3Rmlo?=
 =?utf-8?B?dzZrZFhQcFRFeDIvWURxZTNHREpQRW9KVnR5d2xGZnRURzA1cjJvMGJDRnBp?=
 =?utf-8?B?N2pFbzdtMWZkTEpVbTZsT0l6bG1oaEhNb3FXTzQvM0p4TFlrQXU4TGhpZHNR?=
 =?utf-8?B?MklVUGpHZ2hwLzFJdHpGbmhhT2V6bzMyZFVZOGw5UWFhbjdYckc5WkRrSTFP?=
 =?utf-8?B?bm1kMU02Q3lPQWlQYTVzWWtrbWRRWTVETUtaS1hrUVRsL1NRdFJWdCtFYXFu?=
 =?utf-8?B?WURPV3ZZSGhzV0VrNDNWOHF6OC9FeGl6TFRVUkdBd3Q2OUErVDZaRTQzUXNn?=
 =?utf-8?B?SUNpY0ZoS0YxbEJ4WFR4c0czZjRSV0pWZVY5TzFFclFud3hMTFpEbEJ0NWgx?=
 =?utf-8?B?QVB2VTJaWmJLbC9PVlRPQlVOSUdsL2FkTEx3eTdLUytaMDVIam5zaEF1dTFk?=
 =?utf-8?B?a1RFc0lyVmFjN0xaaXJLejR1NWNIUGxiYllUU0ZRSC9WVzF5TkVQdjZvdm1j?=
 =?utf-8?B?Q3haazViMFFEcU1tazhacjhmYzdpQmtqUi9VRzNOd1M4MG1IeGhRS21qZHUv?=
 =?utf-8?B?SE5VZUFFWFUrZ1dEdVk4dnI5cnRCcmFST1BzSHFVazF4VFZ0VW1Xbyt3ZGZh?=
 =?utf-8?Q?3yrPH5A5dxQGEJhgfLGMcHV3e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a5aa8f-0752-4842-1e00-08dd613ea8b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:19:50.6342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15tr9ol3mZ/+USi/2i9NAbLEaSf5lTT1tmr8uV8rnWD9K2ZzAIzZEqlq1kYY0BWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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



On 3/11/2025 7:47 PM, Alex Deucher wrote:
> Only increment the power profile on the first submission.
> Since the decrement may end up being pushed out as new
> submissions come in, we only need to increment it once.
> 
> Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling”)
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 28 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 984e6ff6e4632..90396aa8ec9f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2142,12 +2142,25 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>  		amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
>  }
>  
> +static unsigned int
> +amdgpu_gfx_get_kernel_ring_fence_counts(struct amdgpu_device *adev)
> +{
> +	unsigned int i, fences = 0;
> +
> +	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
> +	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
> +
> +	return fences;
> +}
> +
>  void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
>  		container_of(work, struct amdgpu_device, gfx.idle_work.work);
>  	enum PP_SMC_POWER_PROFILE profile;
> -	u32 i, fences = 0;
> +	unsigned int fences = 0;
>  	int r;
>  
>  	if (adev->gfx.num_gfx_rings)
> @@ -2155,10 +2168,8 @@ void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
>  	else
>  		profile = PP_SMC_POWER_PROFILE_COMPUTE;
>  
> -	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> -		fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
> -	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
> -		fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
> +	fences = amdgpu_gfx_get_kernel_ring_fence_counts(adev);
> +
>  	if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
>  		r = amdgpu_dpm_switch_power_profile(adev, profile, false);
>  		if (r)
> @@ -2174,6 +2185,7 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	enum PP_SMC_POWER_PROFILE profile;
> +	unsigned int fences = 0;
>  	int r;
>  
>  	if (adev->gfx.num_gfx_rings)
> @@ -2181,15 +2193,17 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>  	else
>  		profile = PP_SMC_POWER_PROFILE_COMPUTE;
>  
> -	atomic_inc(&adev->gfx.total_submission_cnt);
> +	fences = amdgpu_gfx_get_kernel_ring_fence_counts(adev);
>  
> -	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> +	if (!cancel_delayed_work_sync(&adev->gfx.idle_work) && !fences &&
> +	    !atomic_read(&adev->gfx.total_submission_cnt)) {

Should this check be restricted to !fences &&
!atomic_read(&adev->gfx.total_submission_cnt). If the work has already
started execution, cancel_delayed_work_sync will wait for completion and
will return true. In that case, it could happen that idle work would
have already called amdgpu_dpm_switch_power_profile(adev, profile,
false) since submission count increment is moved down.

Wondering if this needs to be split like below -

1) cancel_delayed_work_sync(&adev->gfx.idle_work);

2) Take fence/submission count

3) if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)

Thanks,
Lijo

>  		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
>  		if (r)
>  			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>  				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>  				 "fullscreen 3D" : "compute");
>  	}
> +	atomic_inc(&adev->gfx.total_submission_cnt);
>  }
>  
>  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)

