Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D909FD637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582E510E98E;
	Tue, 16 Dec 2025 21:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dL3SyZFk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E54B10E98E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guV/E2ZmvYK3R+LVLp+8mVoPAbScKA0YzGQNl50vRSuTXnUn+8mnywaDh4OhMwvAm/wxq2ReJ3tm8jKNhyGlAVMTjZUKGZBN+QElabXawGpRNa+WwEmPFczdR7xTuXjq1U3tzrWw1DbIcoAU+JwbqDqv7BI0cVxWtKlhlk4dXk6riH3Alq1VUatEQiO/nSa34dbQF1mHgJIl4y5Hyr5RaICtlxgphmNTTjuj7sNISn52iHt+sj6649fIDQ7pA/AH05ndWGj1TMq0a8r07q09sAEG7s3e5lJVwAWXCEXwlo7mF2K0+kKHCteEaYC6XOQI18MOSUzJPrQHEz50K89V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky31zHWTNIGGnUZyypJ4TLmwXx2Qt+1WAiE8MHmmBrs=;
 b=Xf9BnSrSoLyjD1oEJpSOmIuzGrUh8DYaBrckEfJdsF/1KkLoKEZo/l7Nc0zIa1tyAT78egeMYz7iJXTUtw5CqC394YvAVoVsAqooNbs72ZDcpCNAiBlEod4NxfrNxRF+pz7TKdODvskTv87TRA+3z/8xb9ZDK0lXKJvWbxoOxrR2YyXyNHvIX2zH7ScAr4Gf21JahF4PSXluQPRZ4EyFEwA9KrtphnLJVD4XpBFoL91MX9Z/ZNB/ji63PsrYHW2s002RxyA4RVgLYp34EukS3cRJLxjTgFT3+HnIlkC7Y3wMwWHuDeU/1lH+Qmyxk5DQio+OpeCv4Q45X9DMaOoPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky31zHWTNIGGnUZyypJ4TLmwXx2Qt+1WAiE8MHmmBrs=;
 b=dL3SyZFkIA1++rqtUt7xN4ce7IzPO5VoKMIG4VNc2X+pvy3w2J3ZUgXkmGsf2qYSeBezlK6Mbgm6LIeC2gN16XEHyepVyxN6Tso1DpBg7YI/tziBEAjnO4IFaWjgsxwj4mCehNqpco2NT1u4GI0arEfrrT23Wc/8oX5d3UKb7Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Tue, 16 Dec
 2025 21:25:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 21:25:40 +0000
Message-ID: <ee7bbedd-9bed-4e38-be92-94c1e2dba3f5@amd.com>
Date: Tue, 16 Dec 2025 15:25:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support for SDMA IP version 6.1.4
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tim Huang <tim.huang@amd.com>
References: <20251216211009.1963990-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251216211009.1963990-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 378dc167-fa48-47c6-9d5a-08de3ce9a935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHRsVy8wTzUvZ3d1Q1ZNMUQ2d3NGVGVaRWlyTVJyNTBHa2k0N2tDbXY1ZVM3?=
 =?utf-8?B?dEtLUlRwWEVIR3NxS0tpcmozWlE1eHdQdnNEU1NqUGYyVTE1OHo1MWwya2F6?=
 =?utf-8?B?NERxMUJNU2x4TzZPQ3JRRWxRRVY5YXE4S2JDV2JsQ0lLZC9MSElHUWluWjYx?=
 =?utf-8?B?Z3JuM3hRaDgwK29qRkxaZ3Fpa2JwU0k1enpSUGV1S0hDM3BjRlBWdHJHZ3pl?=
 =?utf-8?B?OFlMY1RpYmRrb2xtTHlKalROMmR1WUllSzdFUnhDTmcwS0dHVGl5Mlk5RitP?=
 =?utf-8?B?QzNLaVFOZksySDg4L2xjQTU5NVgwTzdheVpRNkVRdVdYZGhrU3ZibmJKU2tH?=
 =?utf-8?B?aDVRRGt0anpOaWpEMFdndFRaK2JheWx0cEdNY0RUcG5jckVlZDZEZkFvTmFa?=
 =?utf-8?B?Y3VuOEl5alZ0djNEcXU4MExxY09KRExrM3dTcGM4Q0VvWDNhZjBuSnNIK2NQ?=
 =?utf-8?B?ZnM3bG1NdnlHQWJ4cllmbWdQdjQrQmUyRklYYkF4RzBZT2ZuMVV3WkJEUmVv?=
 =?utf-8?B?VXN4UDYvUitIaGtCelhBYkp4cnNRYWJkRXVhOGNzMUpsbDd2dVlLdkdXTUhF?=
 =?utf-8?B?VElGdHdXNFJFYlNKc0VKV1czMFpBb1psNDF5c2pReVRaR2wzbnRkSUk2RVVB?=
 =?utf-8?B?TDFrTUlmZ29mMXBDdU1RTjVUV0hldFIyZ28rcHlNQjB4QlYxSmFRR3M1OWZy?=
 =?utf-8?B?RzNORjhReTVkZUVqOHRrYVUyd3Z3OXdZNTlrZC9IbHJSRTZxMDRjOFJPVkNw?=
 =?utf-8?B?NkVYZ2pEWk5TenhpNS9ZeWRSRHdnVkMxNW5GMWpIcGdUdXFMcng1aC90Rk5n?=
 =?utf-8?B?cWZobUZXQnZ1dllaS24zeXFOd1MzWXlwSXlsVUtmb1hQbTlnUE1sNnUyTWpO?=
 =?utf-8?B?WHNFZXN2bHRDSUFuSXpJZitpMlJoSkExWFY0ZTlXOW54OFZrZlV4a3VCVkdK?=
 =?utf-8?B?QlYxWDl4dmdUeHlWWmtRMnI3cEhBcFY1QmRITlZnMHZyWm9iVzRPSnVvbExk?=
 =?utf-8?B?NkNYbzRURTEyMUtVUGFxRmVsajE0QlIyZlozQTRWR3hMV0VtcDNrakQ2ZTFt?=
 =?utf-8?B?c3QyTlNQcXowQTlVVXJYSVpsWmtJT01TdlRTV0FZKzE5dkEvNHNURmNaUlpF?=
 =?utf-8?B?SFV6L2xGK3llQ1E5ZFlpWkpVdVd5RFFjVnlzdlh0K1JrdGhKYkV2Zk5IcGF4?=
 =?utf-8?B?Q2JZRjRQazdpWjA4V284WmdnWGpLcmtqejg0dWJPQ3JiTXRJdFc2cktDK1lo?=
 =?utf-8?B?RERoZFJPaVkrS2NwRTJpUGxqaTA3OTBraGtiamdkamdra2VXYWJheXRPa2Va?=
 =?utf-8?B?a0U4bzFRbjZranFrcElCZTdoSWsxVWczenorM0tLenJlK1JTd3RnZ08xR1Zz?=
 =?utf-8?B?dWYwZlV4UlR3WXA4S0dwbFVQL0NJR2IzdWlTc3FPVHFvMzd6eWx0UTEwc1JY?=
 =?utf-8?B?dXhnZk41SUdLRHdSU1RUVnYvWlpjQ3NtYk9mdU40WCtyeER2d0l4eTRlelJv?=
 =?utf-8?B?N2RSVTlKN2xTVmhPMDhvNkRTQW5Gejd6czlUMXNmSTB1ZzM3LzBnaFY0RERn?=
 =?utf-8?B?d1llVFVoN1UxdXA3cENPS2NjcXZDUHE5OCttQUpvL01pNnMyZld6VVVrakVL?=
 =?utf-8?B?TlE1NE1sWFV1SCtEdXBVWXJUTlRBSmRLUXFSUHNWOFBKV2NhTGVkaDdmMHZF?=
 =?utf-8?B?cUhueXdvMDU2b1RhNUNSZHRxM3pMNEQ2aCswT0FIdlF3L2xydGNnZkg3TlRx?=
 =?utf-8?B?Y3l2eTl3UmpIN2kxVzUzWXVBTThmcUp1d2U5MXhvRHhHQ1B4ekpRbnRKc3Fn?=
 =?utf-8?B?RTBZc2R2WGNDNUFoQldLbTFKUHdyT3B1eXpxOTY3MzI5ZldYTVB6ZUNzQkM5?=
 =?utf-8?B?MWh5SmFzdUtJcEVzaTh0NDhaRm80aXFCeHU5b25YOTVFTEs5MzNOTGNQMmls?=
 =?utf-8?Q?VqcYJBNhQxWEJFcpB413jgwcENiC9Sh3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FMWmZyYmpGdzFuaFdmNytRZDJYSXZpVDVMU3ZoaGFJNGo4YUhyTVRjbXk4?=
 =?utf-8?B?N0dHQlNWZGF0LzFlbDNNZzhXU1ljbU4zeHowanZKQjhUSkdpaE5FRUFtN3Vr?=
 =?utf-8?B?SVFlV1MxNUlkZmVhaTNnamRwbWNTdjNVenh5aE8rallLQVl1SnZUVmZ3MEds?=
 =?utf-8?B?dEVGelFsNHhBaUFvTVRzWlFGU1N4SXJjelMxOEhTRVc2d3dPOGhFb0t2b0lX?=
 =?utf-8?B?ODRVQ2JDQTA4a1VUVTl6R0dDN1Q5MVZSRnpnRSs3d0s5ekN1Y2VaaStuNGZi?=
 =?utf-8?B?QVIrc3ZLSEtRdEl1MG1xUlZxanJjNW9RTVJuMS9DNG04cjJhOGVObEo5OXQv?=
 =?utf-8?B?bzRidXpJWkc5L3NMNzFrVnpvMlc3ZmU5WWh3cksycWd5cG9jeVhOMVhDYnJo?=
 =?utf-8?B?UmpMOElEWjJjZ3VlMmYydUdua2s2ZEhvZUh5L0RPRG91bzZicVlkSGhGQWhM?=
 =?utf-8?B?WWlSdk5Ea2hXZy9lcjlmMXNmZmlaV2ZWekg4NjBXRUZwQ1FRUktTTVhZK2ll?=
 =?utf-8?B?b2JTeVJESG1EV3RwSzFhdzFpTktVMkxMZ2JUa0ttUmg4OFNJT1hjaWF6NUFZ?=
 =?utf-8?B?ay94QWw0OFl3VGJnYmYvZVRpY3pOak5JZGZIV2xJdkNraGFRdXlNczdvUFhE?=
 =?utf-8?B?SDc4MC9MYmYrSWd3bWpzY2lkUTNLZnkrRHRzSndjdEVDbEliemFqN2FWdlZk?=
 =?utf-8?B?UXhoZk1NaGI3YlpWRHBEM001TFZqbWl3UUwvNEEwM0p2enFEY01scnZsZFhK?=
 =?utf-8?B?bEg1bkJIM3FxSjJGS3JNYWtGMmx2UWs3VSs3VXlCQ1ZNMXpkaFlzLzhmOWNM?=
 =?utf-8?B?N3RDVU42YUVMSXgwTThQYmpDTVV0ZjJQSXVDdVBON1YrZHRkZFVoc1JZdzd4?=
 =?utf-8?B?VmRzb2tGSHFEK3RBb2k0QVB5Z09RbmdFOHpBZkFDd3owRWoybHJZd1JnOXJD?=
 =?utf-8?B?ZkZTaG41VjZjeWZEWlN5aytHUTRHMW9FeG9tUGNZcnBDYUF1QmliMktDMEFT?=
 =?utf-8?B?eHZzN0YxV05FblRtWFRyZUZKckFtaTNnRUVPVno2NXNHeEJhZ3Q5dFFnanhB?=
 =?utf-8?B?cUpXcHcwR0VWVlRsRGhKTzNPQmZJQzRKOTIwd3RhSWZuV01LOU1vR3FhaUxJ?=
 =?utf-8?B?Y0FQMFh5TEx1Yndsb0hzMFlHVFFzRjN5QWhLQnJMaEFEVlU2U1hJdjNhYTZX?=
 =?utf-8?B?eWtQNTZVRlhaeHN1MTlBMEV4MlozUDFQOVozdnlkemt2ODIzbEE2RTFlS25F?=
 =?utf-8?B?b2pyR096NlhYWjdrWVpWaWttK2NhT3drYXlDL1laR292TE1Ob01uQlNZOU10?=
 =?utf-8?B?UWJiMTdJWHVJdTdxZVc4Y2pxUnMrS21qWEpxUVZWZFZTOUpWa1NsVXZUWm1k?=
 =?utf-8?B?OHFPSHhVL1dON2xRNTl5Zyt3cTBEdDRsS2JvK0I5UCtWU3RoT3hvcEpHeWFm?=
 =?utf-8?B?VDVuUTc1ODhYYnQ0dzZGbFB6UXZHRGxnaUdOQ3pGZTZzN20vdkdyMVkwOUZ3?=
 =?utf-8?B?R0ZseFM0dTMxQ2JBYUhsT3FxVFpLZHI2azRiNjBFOGswOG11MU8vMU8xa3o5?=
 =?utf-8?B?ZXRZU1pnL1E4K3VWSEVEZjRrMVdTNzZ4Q2hITEJTWGloWlJzb3k1aXFEQlR5?=
 =?utf-8?B?bHlkSzF6M2Y3ekxVMTJ4ZVp3bVN6YVIrcFZxYVdmdU9jd3pkSDc5U3VLNHh3?=
 =?utf-8?B?c0ljVjFTNnF4bTlUeUdkTzg3UVZsMFJJWUp2SXZQZE5SQjdPclNQMzBCNHpZ?=
 =?utf-8?B?NkFHRE9vck1sSks5SFRkM25XcFF1Ry9icmY4Z1ZUbWdVdVdwalBFcmdvTlBG?=
 =?utf-8?B?c3ppaDNyZ0xlcFlySEQyUDd3cVZVdE5IVHpRcmFaNkREZXV3VEF3ZW1idnhr?=
 =?utf-8?B?WGtyRlhnYSs0TjJKZzZiM2xaSWdzVVBqNTdKNHBGdVVoTG54QmhzcnFHVjhF?=
 =?utf-8?B?UHJnWXUzQUVjWXlLS1ErUGFaam5LdnNVOVdBMGlrbHUyNC9IQWc1S2Y4QXdO?=
 =?utf-8?B?QVNhS0ROaHRFc1A5NG5nUFVJN1JWT2ViRUhtNHlLVkt6TGtLdVpWbnRlOHpn?=
 =?utf-8?B?VlZaNFRsVDByTFc0RStJSjlNZzI5dHRuaVhXU0E4b2dSUGFGbnRxVHFybWFi?=
 =?utf-8?Q?ncWCSTA3ZQOJrF2fbKW0vqnpb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378dc167-fa48-47c6-9d5a-08de3ce9a935
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:25:39.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxiLqanqE3TfR5/wjNjgvJE5uOj7WrKW9yTTtf8/TEnAe1J++nXdkqp5lwOJGNr/SlBTYsdSIbz/fFs82lOrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
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

For series:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

On 12/16/2025 3:10 PM, Alex Deucher wrote:
> From: Tim Huang <tim.huang@amd.com>
> 
> This initializes SDMA IP version 6.1.4.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 116cb437c81bb..ba3a1eb116dfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2420,6 +2420,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(6, 1, 1):
>   	case IP_VERSION(6, 1, 2):
>   	case IP_VERSION(6, 1, 3):
> +	case IP_VERSION(6, 1, 4):
>   		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
>   		break;
>   	case IP_VERSION(7, 0, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index f38c2bdd01e3c..651fdfc94a0a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -54,6 +54,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
>   
>   #define SDMA1_REG_OFFSET 0x600
>   #define SDMA0_HYP_DEC_REG_START 0x5880
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 01e5b3416716f..b7647324ea821 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -104,6 +104,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
>   	case IP_VERSION(6, 1, 1):
>   	case IP_VERSION(6, 1, 2):
>   	case IP_VERSION(6, 1, 3):
> +	case IP_VERSION(6, 1, 4):
>   	case IP_VERSION(7, 0, 0):
>   	case IP_VERSION(7, 0, 1):
>   	case IP_VERSION(7, 1, 0):

