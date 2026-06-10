Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1FECD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 07:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D8110E77E;
	Wed, 10 Jun 2026 07:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQyGl3/i";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EFB610E77E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 07:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J53Y0hOUZcFz4KuX3J9mrUUn7cHi3RB9aGfY0njWUIlFIAsfc4EyibpZZK+N1cgiXX1yyNLCwE2LpKhA5zMf6RICKbTJC5nRlptRqvcPPwOjSucNZLugBBaGSAOeeuVjWDZrfcQu5WtHus+mMlUIHBV+jpvpe7RuxqHnyRByIcNQ99+/iKSMSgt/BppjaPVlEEFldXNuULXiX0AoBS8AOmBd1Gy7oxTYvqQbTjRhgzN/kf4bVlAgTmEfhY4CWYIKWTetmxb1SoXGwyo78dOC0rs4rLlX6ZlVrKQRGceTJnJwiE4vcDcGgNldhLDNlc5HcP+910gBfU4JGtxUYGICbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWKqRn/NJPf3W+yG6UpE+SXf6Apd4sta+ryKM482XA8=;
 b=N8MSNubsBmaY3ZUVxu9BoC4Q3MKuU96Cc0AFUPuPEw4KmI2UkbQzXLGekqy9oUxjmpwAHFM/oqepIg37vYVUB9iVEgJz/aW4242e2vtRuhL8iQmEyfKbUZPJd1eoSnKXDkcEJfaNcbalJYClvdDaY0M/3q8jZGRjr6FS0VMpNN5NERbK5uj8oSW09nIn/OovxzslipV0PfU6VI49NpZ2nvsp660XMGK9GvryvQXzbzINi4imk0j338eMZ7vTs01em8qDW7Qg/e8zLe5+SqtYEHG8/Ut2zj5ZAmZRE0+0tMKMoYfzxjTpCxTeNlWIMEBg9fni5yQ2M/1RECxqtr/NaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWKqRn/NJPf3W+yG6UpE+SXf6Apd4sta+ryKM482XA8=;
 b=wQyGl3/i9Nsk2luqvgGMUyseMtpzv6mNmTOck9pvizoMqzHv9zm+hsFRW+P3uFb3bPNtnhloP5/BXmS1w+KRgzUmM2uZ7k10Klb+kPiKW/f/vEKb8jD3V7HvMncm5f2IWq8rQN9TxQAV7bNi7/4wMzsZ6pXGcI86QMlm8Z3gbUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 07:50:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 07:50:25 +0000
Message-ID: <ebbf567e-cdb8-44bf-b8ec-1c0096ca740f@amd.com>
Date: Wed, 10 Jun 2026 09:50:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
To: Jiqian Chen <Jiqian.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260610055736.951241-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610055736.951241-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: f2303ac4-98f5-4629-b2e7-08dec6c4ee61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: jbKnXqmAwOyciO9oZJ/nIt6XP0cKWjWMldD2EyuNWYmg4H2RkAC7ay/4TDQTPPiBKXHC37e12qRrUXBA2igoaUOxQzj12XhREasiV4iMolk9L2CpiI3mpFX7hQwk2lA8ClHA+5V1kHOiQqwNQ86ZnwHt28qH9hncHNrZxUCbNyA/ehuqBZIOLRpNrLVyJZ1cu3N8slYoKiW38QzIE3tEU4velNqjM1m0elWZoeQiuxNtFKIKN/Sxqu3GOTNIKbYDlhdjtdXMQ92ajtQATNy9DPBs1Bvs9LzmWINmC2JaZSQdSxA+CjhXStOzKHktn+RbwdjQyXN4VLAcHhGHePFkeaGD8t7YU2wn58nOOMHeVLWP82qCr1ahd2wE9tlrNLCILO4U3kwFheh38PLL+Zx38kULORbHYP1UdTcSTJcSw56Hl26QhJSA/BxHCF/jzTwkoGihd/mI+u0ZI5RF+mptqWz5WPkXcqRAaJKwYtLW/Q5t1/43jnlsDwCCzsn7NM7ruWjCMFU+LBf1Rw8IAONgOlqNvBjjTfbeeHDQqFDxmPwWasCOHf5QHe68cPoGsDzYdbW+GVyvkJpOyDh7vNlSScCwf4QLHC73dg8e5nO2LZw0tslDEnvw3Vlm9o29md72pZzn3Dad8G1nYCcpV+0R78WBpSAIMPslGUFB8ZkO+vb0qQbwZLpFQxO3tYvto6EO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmIxRWt1SC92dEpORVJEazl1dW9Tc2lBTjRBNTFpVkdxeG0xRzVUckROSWJC?=
 =?utf-8?B?eklUS3JCUVJqL1JCbWJxTm5vTHNIb3ExWVphTlUvR2xsdnBTa0pzTmFGOFNM?=
 =?utf-8?B?dzIxaytac3BLK0ZuNlZTVlk0dW5YdlFYRkZGTEdTcnZJaU81S3JCN00zOGV1?=
 =?utf-8?B?RWxtVzRPd1VMbjBjUDJ5cDI5eEUzeFB3SUVVNUp6MmQyM0kzS0QyWGpjM29R?=
 =?utf-8?B?VVJ4MWljS1Z6cVJWQkxQRzNRdWkrRThlYytUZ2VrU1FGQTVidmJBR2ZZblFO?=
 =?utf-8?B?MUU3K3NONjZjM1ltTkxuSGQvTVd5YUZzRkdJMkt0cm95dk9Oc3Q2SGZYbXlO?=
 =?utf-8?B?WmdOTUlkTFNBQWlUSlkvWThWcitxVFpqQW4rYUJqelV1ZGhzNTZrNjc1NndY?=
 =?utf-8?B?a1d3SUNKS0l2UXp5bUR3WEd6eUxWc0RmaHNURkYyQWJuOG16Rm50cVdmTEpY?=
 =?utf-8?B?dWdqS21ybVczYzJPV2lxVmd3OEFtclhPb3lOTmRIUWhRT3RHWkpRaE51U1A3?=
 =?utf-8?B?aWliQzdkZE44cmg4bmZqQjVzcFhrSXEzZFpWb2REVENnaTZyS0tzcGlPeTdv?=
 =?utf-8?B?Y2pabk9IYS9lVEpzZUE0TmFHNHV2dThUUkVTMHVrVnlZZ0IxM2E0bzhveWs4?=
 =?utf-8?B?K3RwTnNCZjhSZnlBL3hWWUdvWU5jYVNjWlUyUXV6cDY5bWRQb1BHVytUaGUz?=
 =?utf-8?B?V0RTYXk2TjU0MmppT1I1bTlUT3NsZWtzYVhZSW1KZHFua0d3cDhuWXNOdnpE?=
 =?utf-8?B?SGJvM0FlNHlMdndRT3lTTlI5eTZpRHZ5NW5vSFBpRG96c3lLT3dTUVY0eTBv?=
 =?utf-8?B?bWJtditHaGtXblVJZzNKalp6UzdQb3RlcUNtY3orSk5NVDdnSGtzQXRYcHgv?=
 =?utf-8?B?d3U3S0xSNFNsNEVGMlFDUTc0Sm9WMjR5ZzlCUVZJenBGS1JEV3FoaEJJWXpp?=
 =?utf-8?B?YUdHMHRYNElidjJwRVlEeTZFR09lay9vNG5Lejh4cXBUejd2bTZvUWRPM1lE?=
 =?utf-8?B?K1RNZHZzbWh4Y21wZzhnM1R3NkxRN25US2hYcW9CZHZNMEV4Y2ZjNDJ4UDUy?=
 =?utf-8?B?NUNYdW1id0ltOGRKenM3THA5U2M2cUZja1RhR0dXSHNGL1kwdmZsT0ZTMWYy?=
 =?utf-8?B?NVNmdHpHa2VaaHIwY3lPRWlqb3FGMEo1Mm56enNucjBrUDNBL2t5Q1kvUnZG?=
 =?utf-8?B?NHNYLzFlU3ZrbS9ObkRDZUh3anJPZGFJZGk4UW9GWFFPNkNzckcyckhJcWJG?=
 =?utf-8?B?dndQem9PVWhQSjZzUEtqdDU1Rzc4bDRJV2JTUHpWdzJuV282b1JLVmNNanNw?=
 =?utf-8?B?NFVyWEV1V3hCSk5vWHR0dFZmNUlMVGN6TittUkJySjNsOGllaXJjMGZDYnQ4?=
 =?utf-8?B?clFNY2UzYmJ1ZXJMS0xZOUhmK0RaaGdPZ2ZIVCtHSFpzbXcxRGY3YTRtaWtK?=
 =?utf-8?B?NWdUMEwwU3F3R1k4ZENFNE85VWE0emlKbW9VSlNtZUtySEMvMyttbnZpTmF4?=
 =?utf-8?B?YjlvbEdtcGx0K1hSZDd4ZFoySE1jSXJCUUY5SzFTRjl4N2hGS0lQa0pXN2hj?=
 =?utf-8?B?VmhDbDNJUjhzTFVOZlZtWGhMNTJ3ZFo2M1RjbzFoTVlPc3huSlhvakw5dlAz?=
 =?utf-8?B?LzJUbEE1ODgwaWlhMTlGUzdSeXdwQ1R1dnpuV0sxdmd4ZlBZVU1yZGsyODNh?=
 =?utf-8?B?SjlRZ3B2OGZuS3NHVUhpS25EVW9PUm93MWtnZnBnVXgySUlKYkNtcWNSOGdW?=
 =?utf-8?B?SkVlbnVzcE5PV0NPcVpFQlBVOWhrZXluQUMwN1BnWHAySW5tczdLa21wMkJu?=
 =?utf-8?B?eVMrSnFNS09pRWd0NW9pb2IvT3lOdVZIM0NRenFyT2pSZVJyTkZPem1ZTUUr?=
 =?utf-8?B?bWdBdk1jTDVoQnVZUDY5Y0ZDNFlJYUVEUEtsdUtva0dPQ3JVc05PbDVKL0th?=
 =?utf-8?B?LytuakxwcnhBM0tPTGZNd0xNajlYQ1dnMHlRQzRIUVlXNnhQQURRM1RzbzBs?=
 =?utf-8?B?ejhmMjNERldSYmloNWNYZ2Q2d3V1Rk5qUzU2MTNNbUN2Q3h6WXdSU0NFb1A2?=
 =?utf-8?B?M3l2TVpnSkdOMkxJTE5YM1RUNXZqclhmVEd6ckhDQmlQMkw4cmVIMkhkVWRX?=
 =?utf-8?B?cXRNMTQvWGpWMExUNEg1UjJSaVVNb0FQb28rOEdsd1J2dXdsS2FpckZsNmp1?=
 =?utf-8?B?cEFNNjBOVGpHcVd1ZU12dXkwL2x2cWFLZ1gxN3d2T0NLZWxQK3JNdTVGY2Vs?=
 =?utf-8?B?cTlIVnYzMEVtUzlneFJKcjVTeWxYaDB6NUlnZ0RmRUZTeGlkZWJNbi9ZWFVW?=
 =?utf-8?Q?A+4bSpZiKO0Qwky8jK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2303ac4-98f5-4629-b2e7-08dec6c4ee61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:50:24.9557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtgDqomlzLoyPqi+Z0yPfZR6lAr9IynqgDlC+A9fs6J4TGpS9ALuI1HgBTWm8AzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

On 6/10/26 07:57, Jiqian Chen wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2, the CPC and CPF are still stuck,
> that causes compute Ring tests fail. What's more, the HQDs of
> MECs are still active, that causes MECs use stale HQDs when MECs
> are unhalted before driver restore MQDs, then causes compute IB
> tests fail.
> 
> So, add sequences to reset CPC and CPF after Mode2, and de-active
> HQDs of MECs before unhalting MECs and mapping compute queues.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> Hi all,
> 
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.

Oh! It's really nice to see that.

We had quite a number of bug reports on this issue, but were never able to reproduce it reliable.

IIRC some Valve engineers ran into that as well, adding a few people on CC.

I can't judge if the proposed fix is technically correct, but it's good to see that there is some progress on this issue.

Thanks,
Christian.

> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that may cause Compute Ring tests fail.
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restore
> MQDs to HQDs).
> So, I send this patch to fix above problems.
> There are two main changes of my patches:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 40 ++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47721d0c3781..dc0978bc312c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3944,7 +3944,8 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>  
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  {
> -	int r, i;
> +	u32 tmp;
> +	int r, i, j, k;
>  	struct amdgpu_ring *ring;
>  
>  	if (!(adev->flags & AMD_IS_APU))
> @@ -3967,6 +3968,43 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  		gfx_v9_0_cp_gfx_enable(adev, false);
>  	gfx_v9_0_cp_compute_enable(adev, false);
>  
> +	if ((adev->flags & AMD_IS_APU) &&
> +		(adev->apu_flags & AMD_APU_IS_RENOIR) && amdgpu_in_reset(adev)) {
> +		/*
> +		 * CPC and CPF are still stuck after Mode2 reset, that causes later
> +		 * compute ring test fail and then loop Mode2 reset infinitely
> +		 */
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		udelay(50);
> +
> +		tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> +				GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		udelay(50);
> +
> +		/*
> +		 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> +		 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
> +		 * Otherwise, later compute IB test may fail
> +		 */
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> +					mutex_lock(&adev->srbm_mutex);
> +					soc15_grbm_select(adev, i + 1, j, k, 0, 0);
> +					WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
> +					soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +					mutex_unlock(&adev->srbm_mutex);
> +				}
> +			}
> +		}
> +	}
> +
>  	r = gfx_v9_0_kiq_resume(adev);
>  	if (r)
>  		return r;

