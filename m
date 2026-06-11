Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C38CD8CB9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 06:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963D110ECF1;
	Thu, 11 Jun 2026 06:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZgRs2Zq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7856610ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 06:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcq4lQ07kDt3neR8FvESpOiysk16rrvqzhQVpgTGpezvRYUkCNquOaMEyUwCku5xCzcR9SkF6UeT12p3ydw0tZIc+f1KvmCtJXgEuMtfGs5woGgKr9Y8CAK/a2ttUcY8BhCb2lr1VsjEpoQvf8CFJJjpeSUtY0yaihOu6JyP4CWsBRKEq6EqXWnDphrqkoSyMJtF37oxQ+hRKdXP7CM8NDUpJ6D5pxn3vmDnUl9WFyjIlLylV0yhHQZiWUYVHlRy+Q/uPy4Sl15yHUjGp+vEmZSxTlwvIT9gmRVLrplRIYkZLQW9dCPg3zltxr7h5PNv5zYK/yP9xV0PaRyBswK7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H45MInQH4bZF4jELaFy/DMBcuEqYx/U4Np/pJmCK+Vs=;
 b=cLu7ISAFcTzo/YfioQa8aaXqvGUp1ODaA6eXA7pRRJ6ackrDlrCafbMmbwJdu4diLz1Kidh1ol+gFnjvcaQVvB0HggC5/w8vqNZoubA/YgXRMDKGMPbzONn1RG2KvgYPoDgexo7myEz0bnZrHhT3g5mUX+XA76BH0TUuvxa2PJmnmFl/iaLZ95c7L7yJlOu2vH6GZpRGwUyZam66wARPM9lrXXL/U4C7UV/VmNNZWFBojD6y/t5l/dvbrpZFEyLdAGcywkILFfS5Y9+I3l+BgcpBORK5z0jJyOswJL5SrHATgIdjmm3qqIPXs4/Y3+Cv5dfkjq1wDbw7FdQA14brZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H45MInQH4bZF4jELaFy/DMBcuEqYx/U4Np/pJmCK+Vs=;
 b=DZgRs2ZqELFR8YUw4rmlTE4/v+X3z4hndChB2lM4zTX71o8dQglu83BIAW2y7QGsqPA7aA14JVslL40hQk0F7SWs/GmwPY3goBFoP+w2glfeb/jY46/J9x09T1DdHtyC7J2qh+4bdh5jlXrSNVA+BGSo4PVyyruLGE9Uyz2foXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 06:27:11 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 06:27:11 +0000
Date: Thu, 11 Jun 2026 14:26:52 +0800
From: Huang Rui <ray.huang@amd.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Huang Trigger <Trigger.Huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Message-ID: <aipVLOVnOxst+zTS@amd.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
X-ClientProxiedBy: KL1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:820::30) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f89761a-3ceb-4a66-6572-08dec782784a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5//rDhWkWPotZ53d192/qLhrGIeMpkaUEt+7ODfvaTFgvcR9mCh3vZRy1o74rpVLgeSTbr2byyl16RatWvUEpF1l0+2IZGo6Vjnami0yfpUHUmcUcllIYN9NdujaLo6mop2N71Str+YVvhYrmRbZEca4laRw7k1XwpswNmamSbV+NWyq+XqZIHDgAC+3fNsc9DizHqXhi3BgeVbImE4BEG8nBtYK0tDENLnus60Iz68AvKIVu3iLTBz2GilVtiGVUCmoE1y+oMJJ6uWgPOWYctdbppeh2sdoPvFfqgArAIItsD6aU0c4bsgw2gUMhn6wtEbneN7668kaLGIhAsAt8feLKHZ1p2xTaOtTgiz3J25fr+FYNm1Gbfy0+KGsZbMPHTENPx1luSO+CgSNuvkcUngkz+d9AlBbkCA/FRrhbThlZf4Zz7Q7Aac78tEjDqf1q/cOXFmuDoRrDK0IACu04Fo8wXc66bclehyc6b47kLUTeogU2a9oLrMM5qkh5/DlM5C6EqZ+jCEyKGHed9isPT99Pl18RVya5nb2v/0LpnhoawFB6ic31gRdpiST6pCZ9C5FQflYQnYsFyUESAO9KIwwEW1eXsZ1DQFqRuPH7TmqjBlt+hY74KyniOAe2zLDDxfSb7OIoaNRZGMNIDgwhm4uUuMkMDcnxwowc++6iEJ9zR1g102TUX0x68yXcNq1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcN5UViHNclVu2HQnRPzNWIAgU8/YvlOWKW1n5zFlrcVy79Hp7sC1WjSpCOA?=
 =?us-ascii?Q?+yVHQVyyEqG1zcBjW9Zr9nqtGWOpFZrx6qLH3uUdakF/qvd66/+k2+UI7l0w?=
 =?us-ascii?Q?rIShYImPWfJaNukU3FC/gKFSqU006UCc3SXcz1YzQeqNbit8qQ//AEAe9eO2?=
 =?us-ascii?Q?wgB/piZxUgMBSempOU9sxnLBo/FYrmph9y42WfNIjSWC1wCqhXgtM42BTtFY?=
 =?us-ascii?Q?1g0+wj4lSIwfZNpXWWjaiSdpZRzIc8UqJOT5Qhw4wGN09yaANFbu+oREBHvG?=
 =?us-ascii?Q?2A5+BPY1xUA7rppdbwEZLnPpUTFIRzxV05dYRyQN2cQtqktOIYGQTyM1xciR?=
 =?us-ascii?Q?C+2XaHhtxa2Fy43L6IXHUBjsgrDBI4PwGb6ATjbXESnAbS0HHAaNcsJZZgHM?=
 =?us-ascii?Q?l3dBelzJYbmTYZF7datIVCJfwh6M7kA7wrtdZXkXUFu+oDJONkU/BV2v/1pB?=
 =?us-ascii?Q?xMiZfoO1DL2s5/3nxvUuiYpqa0LdL4QVpgVyx1RZvfT7+m1LBZPt3cXlFMMr?=
 =?us-ascii?Q?dSoM8trIjGUPxljF+HaTFrpI0Q94ZEGzg2nvSgCT5ICd7j8qzoluXzp28f2T?=
 =?us-ascii?Q?0xUCmxwab4wmGZbl7kNwcM8G0nXByPT+e6PD1Di9H/5enfFJwH8uos/UGsUA?=
 =?us-ascii?Q?e7CJp9/q1OQvuGOIpMKPYp8bio7I5z5DfzIXDoZSOaUiUSPWE8bew4SVEOUl?=
 =?us-ascii?Q?/XTMWFRbX2zfklVGiRT0tGIhkcvTQwdaGQEHNJUY93mvbAtn1qPjl6iSht0C?=
 =?us-ascii?Q?1QqegvW8vJq818HJLDLCV23KYqkYdliEVJBghcyOrIhKxIKkWuOVk84f3Jdj?=
 =?us-ascii?Q?0qjVfUzM+R572oJeTr5WB0/RvCFbwCwNUmIW+XufF68RJ6DiXCC7iwDi0sPT?=
 =?us-ascii?Q?KGx92tBfNF7vK3LiPPk1yfg3Cp/oLp6OEVLvFxezCU8H8Lqjz2nveblUJKzS?=
 =?us-ascii?Q?sGxwA4vK57+FZVZeiWlkgBMes5E8tLnblbZ5/t5gr/lvybqqFBZWeLBS25fo?=
 =?us-ascii?Q?Jad/czqzbxpHDTQyzPNBNkv6xpI+CNLqAXQXZPETNGo4IZ6XVtqo7NWB4rym?=
 =?us-ascii?Q?6mD5ozDi98HTDHQ9gOlXotgfZCUkOCRMNM7+SIcHmVEVdyqopYKc1wMF0rfF?=
 =?us-ascii?Q?cGnVUhlGvqcvwro7xUXzz3voI5UixpB4VxLPN+CAsZIvrAmIU1nEDfhx3Nyb?=
 =?us-ascii?Q?AKcUWwP9k/j15cvqq7u3cmaLeFnV8FZYxAaRr0SPf4N6L7w4nVMuKQCT3R4o?=
 =?us-ascii?Q?4HgAFcvG85Zvsj6zwYHFbkQ9JyhMutqYtAKzPeC822XTdqmawFjija5DA6gG?=
 =?us-ascii?Q?r6aAWHVPQAOWBTz4HLqKQfZO1+tBy+F+ZGgMuKcHQSwQqa7d7rv9n5PrOgRN?=
 =?us-ascii?Q?WIcsam4C5dJWkiBHXYIw3gKwTBTZ/Mn0cD7YxpJ/HkHpRg6qze4I1vfdQIkf?=
 =?us-ascii?Q?GgyU9qSaH/VJyurTlauDAS8e3wbqxg66kMYRNYmMT3kbYFmzgHG9hQstJR8c?=
 =?us-ascii?Q?OXJL05DrHP/GKILbrmWq+fFUCm4d8oWAITES7DhmeMfiMxbb4asxNGDg5uGU?=
 =?us-ascii?Q?IdoAJ6NLOqIXHVxYzinzjceQ5JYd7TJ6R+RQPeRUFypptj63NclO4Nv5rb7s?=
 =?us-ascii?Q?aSbRho+wbHlkXR6MCDr17dUc1RNf1gUadxIUGx/3jjGfOt/aw5B8TslZlKJ6?=
 =?us-ascii?Q?tC0M+cdQD7u/YrZ4mWwUmgl9XpRX4lA5A5V4bLxJk5YxwNxPmNCu75RJXsgz?=
 =?us-ascii?Q?6Wxs1TUrCA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f89761a-3ceb-4a66-6572-08dec782784a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:27:11.3218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0D4P8mLbBQGsgRiKbdvlhu0kI3ImmK3QdaEkT4uQ2gPQtgvsuPWAJMjuukwiPfo+3S2Yjl4FctrGkzt/mcMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

On Thu, Jun 11, 2026 at 01:57:15PM +0800, Jiqian Chen wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2 compute Ring test and IB test fail
> randomly. It because the CPC and CPF are still stuck after Mode2,
> that causes compute Ring test fail. What's more, the HQDs of
> MECs are still active, that causes MECs use stale HQDs when MECs
> are unhalted before driver restore MQDs, then causes compute IB
> tests fail.
> 
> So, add sequences to reset CPC and CPF after Mode2, and de-active
> HQDs of MECs before unhalting MECs.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> * Add reset Mode2 method check to the if condition that call my sequences
> 
> v1:
> Hi all,
> 
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
> 
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that caused Compute Ring tests fail.
> 
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restoring
> MQDs to HQDs).
> 
> So, I send this patch to fix above problems.
> There are two main changes of my patch:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47721d0c3781..d3ef45aa299a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3942,6 +3942,46 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>  	return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>  
> +static void gfx_v9_0_cp_mode2_clear_state(struct amdgpu_device *adev)
> +{
> +	u32 tmp;
> +	int i, j, k;
> +
> +	/*
> +	 * CPC and CPF are still stuck after Mode2 reset, that causes later
> +	 * compute ring test fail and then loop Mode2 reset infinitely
> +	 */
> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	udelay(50);
> +
> +	tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> +			GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	udelay(50);
> +
> +	/*
> +	 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> +	 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
> +	 * Otherwise, later compute IB test may fail
> +	 */
> +	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> +				mutex_lock(&adev->srbm_mutex);
> +				soc15_grbm_select(adev, i + 1, j, k, 0, 0);
> +				WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);

I think we don't need to use WREG32_SOC15_RLC here, because SRIOV GPU won't
access this code path.

> +				soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +				mutex_unlock(&adev->srbm_mutex);
> +			}
> +		}
> +	}
> +}
> +
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  {
>  	int r, i;
> @@ -3967,6 +4007,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  		gfx_v9_0_cp_gfx_enable(adev, false);
>  	gfx_v9_0_cp_compute_enable(adev, false);
>  
> +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> +		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)

If we constrain the condition to a mode2 reset, does that mean we no longer
need to restrict it to APU?

Thanks,
Ray

> +		gfx_v9_0_cp_mode2_clear_state(adev);
> +
>  	r = gfx_v9_0_kiq_resume(adev);
>  	if (r)
>  		return r;
> -- 
> 2.39.5
> 
