Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA26C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 04:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC5A611F0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 04:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC5A611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7236E9AB;
	Tue, 11 May 2021 04:22:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CE46E9AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 04:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcIHPcPTCuKszhr9h0YXDBd7ZvR2VduNBnZtdTF553zzZG3/1A8OFpIiBeeDDvk9QtxVIS48rrOukcDsE0EQWagzoDshHvmKTavVCvHbP7hC1Vj78l1rSSgAxz9KK+JiDF22QJzAKnVgOR7E3l26yIoP4fOpP8RrPDd4bzi41kqFs31npccaEsrfVR60oEolq6kjWdGcN2zxS1HBj+8eQMqJ1w7LHg+ofccHBqH9guo7aLsSBRq9tN5ei1puAXEvoHksq2GueFOubHxHeTqJK702GGD2+UPeYpOe6iAqfzU5nw/pKsLpJdXoiPu2cyA/7A2L0Oz62GJ+6CN+h1U54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLj0giL85Ov6R8VSLZmB3JyEsXRZEYYn3VX3WX8J3+c=;
 b=bjX+mJ3hIKXWG6SzMZ3rJx3f0NwBck01VEjwWr7JaOGAgN6p6zrYvBiZIw5dNYNbSIHcVk75an4uaJiMr8Aw6Z1Mbnd7ZdQluWNa5wU5k7HghT7CR3NRmRC8XrNTXfZgRtkIv9K5x9O0glWQlLb6+bagqqYuEB6O0/2m0qFdVIyi1fd3N45fLkFl79SUmvZZCRS3Acwe0W4GzDxv/iVBtCbh03vDL6QfgCEbp8bLyvapym6BrIuCqIWZgBUD6NsD/u54DU1hWy6jZrS1aauEARFO9w9SlPyjPTpiV30wbl4BeeDCtZO7iHa6wT8luaZRwJn0YH4EvVeF0IT6+Ijb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLj0giL85Ov6R8VSLZmB3JyEsXRZEYYn3VX3WX8J3+c=;
 b=f1L4TCgzO4lKJdO3hAmM1F+yQP6tO9A5X94ZJ+X3G6UHIewDmmPU3VSxhBH9GecG8NMgyZ+FxdBixQje21ZAwvGvMXtSdmUrY1VasB9yC0IeVQ5BOwBkcozpOtEHGMESBVgn9dC998yfv8kbJW1saE6svkLGDquVZqRbXIidhe0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 04:22:11 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 04:22:11 +0000
Date: Tue, 11 May 2021 12:22:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: seperate the dependency between CGCG and
 CGLS when diable CGCG/CGLS
Message-ID: <20210511042204.GB1272913@hr-amd>
References: <20210429060853.4144-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210429060853.4144-1-changfeng.zhu@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK0PR01CA0072.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 11 May 2021 04:22:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0c5d45-930b-4e16-e494-08d91434590a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1855F54E639EC30054210F37EC539@MWHPR12MB1855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXNGD8sT4PpGPNK1vQGYvDTsVPOoXzvmKdzxOEBNDCurzpvIRfB9wt8i+vFXZMEaGMIhRRo1AZwCAO2af3v4FC6p4AGvWIeIwY+Baep3fIW7JNIWcpj/+Ldod2ZoFlfmPsnciIxUzLENkv/iw7fESN95lFnTAYyG0oWLRMvWLhr+/dG4hWCRv/z9qnVZNiAyWFGmFhhl1WKaMSvX1Z6MvJGK2SNDf2boSA2FqltWCSOt+EIyv4I91xgI0tjnFNfzgCRUhtdidQTOpdMJ/MuhdGtOkBAq9+zyw8TFxHIkQrquEfpXmYsfGHPkkb7dO2eYNVDli0Aqn1VECNKkGimUWipnjb1GW1H53lKmSeSeO65aHFXOuGEy7RnP4ZVLQzLLTp1gk1tUp77Hw3wv/ewTj3c2fs/qydxJn+UaJBpezhlmwWrkHkRjZbqLq33neYhUZ195RSjm7zu1jiurtWeby6GihMQlWmqspzMobro3Y+uSvlNWk3Hg9i1lYZCMJmgwulL2Seme1xfs4w/aR/E+qSPQ0KZgMcjs8GMo5NrU590/vDG+3Lw3Wfy09jnIYF4mT1tmikI22dexn5VhRigAIc/M3m0P/lsMyOlVjs3z3qiOq8PYceYRSP8SSaraA4my9LMC/n3JeZDL8zbtk921ifY849RzDmK7ClAnljLCfPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39840400004)(136003)(52116002)(6496006)(26005)(6666004)(66946007)(6862004)(6636002)(54906003)(66476007)(66556008)(478600001)(4326008)(83380400001)(316002)(16526019)(186003)(38100700002)(38350700002)(33656002)(55016002)(9686003)(8676002)(5660300002)(956004)(86362001)(33716001)(2906002)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0P4oMFNRC3hc9RXrXPpko2x8nVCRKYSx869c9tQI4o7GBFHpDSKmpLRSGcuq?=
 =?us-ascii?Q?ZCWCcQDy3xeEFAMey3t7UPoek5w78bF/vqEWi8A1N703f0yS0owwhy8trZHl?=
 =?us-ascii?Q?fwV2aqjkuQ5GVtx/RBHiROZsqZLtuf5N2Dw7THB32Fb6YExjhGvQ8tbT7IQ5?=
 =?us-ascii?Q?Osy2GOGdPZZZM4uW8DUN7OVWIx5lYOfa8vQJUoGwcsHBcwNt2O2unN1tyqMV?=
 =?us-ascii?Q?bGN3skM5Zzb7cV+Mv2L4ROhqNeWoLlmwrEqcsci0DQDWj0KasOBIQbHEtyFx?=
 =?us-ascii?Q?yStGNv4yb70pc/3/OScfEgdAlDJMHLUwU/zJO3qArZspw8wHENxg1wJEeyKO?=
 =?us-ascii?Q?J1ZZzjJu5gdB6b5nfq9hldHl5/5Jc8S7PdTE5kr6qpb3COGNIpFQEqjp5wfz?=
 =?us-ascii?Q?kLtIVXdtAQQaOO01hrGUN/p0aCaLgRlDdMnWbEmoaSf09mHootzIb0Hojdmj?=
 =?us-ascii?Q?GInVp3zPMHXkPEeYiSRNbvQ3uRrWjSnlp0sGFRBwJhazaRa3tHdXoxB/FM1o?=
 =?us-ascii?Q?Dd4nGBmS7duzsL6don6F/+1tSTP/F4HGdyuHWRXIz9d4AukKWl7lXLVLqUaY?=
 =?us-ascii?Q?5BgPSH3p4wwkse5rFnxanvfC1mnEvkCc0DNasHBOSJZR9adN1NnjMzythyyE?=
 =?us-ascii?Q?9fRiG1rkpsgvymsaxKf6t8vzwM6aOUn9gnHXByjirWiSjm7mdMUJXu6UmdWZ?=
 =?us-ascii?Q?910C9O87qxuMqdixOABZ0vZztBwRCIHHpwfLKMkr9IYyogJ/eyc6jt7EnJ02?=
 =?us-ascii?Q?qFiULF9db/eWcEuoit6Ezd/mUu9oYalDwxS7cYfEI8Sz8SeN1e7C/FeSZycr?=
 =?us-ascii?Q?Dy9olYKx6slCMH0RyRcgXLyEsfFM+Pp2qtkv7HvfdnlYP3cTBmJjCjlbcer0?=
 =?us-ascii?Q?jGNizyvoU+rWA944l1N+WDNRucLwVmAfuKh96LmVZjzbAlfBvLeAjfBKSxVw?=
 =?us-ascii?Q?WCQAjN+op6xGrGKf4GU6+7oiFhkf8ikGwiNrx4MlTQUzx73X69kT1OJCj28L?=
 =?us-ascii?Q?0lNJRt3vNHeDZrl7kGqGbO4DFml0tOHoD9tdv3CeFIrbxHj/CihcCpLr86eS?=
 =?us-ascii?Q?BmVOFWE2VIvRVMSeMyxHDTPU+OPNqBFfO0Wl7K8+BVYlShXnkgyToqWfK+aB?=
 =?us-ascii?Q?iz6fBy0Sh3lsSrRD7PzBr9e7AH2U8cuMTLGlOTo/gdfSubzktoVzeI6WSa+G?=
 =?us-ascii?Q?jTh6AuGnSQiHSWNYFCMUv42Vch8euqLbnf24p/hWvMEu0j/sImVl4VhdsCU1?=
 =?us-ascii?Q?VJaMZY2NmFBfK9ytxRy1/zqklaxQ1mXlWYRS6pBQVhloOZ/MMwzgJ24tvKfN?=
 =?us-ascii?Q?eG797v5xQAEZ1Zr6I7TmMqRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0c5d45-930b-4e16-e494-08d91434590a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 04:22:11.6206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlkZwvkgYEcB0yxHIU/8vLtocGaizyNtnXcFPrDX24bqwE5jNcsHXQEm5MEz2utTQUs/X6PIs+x3+ejkRvJAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1855
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 29, 2021 at 02:08:53PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> The disable process of CGLS is dependent on CGCG now. Align with windows
> code, seperate the dependency between CGCG and CGLS and it will reduce
> confusion when debug CGCG/CGLS related issue.
> 
> Change-Id: Ia91b8b16236bebd9224160672e500f6850dbc268
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 33 ++++++++++++++++----------
>  2 files changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 49fd10a15707..3f8aa2fb974d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7717,18 +7717,22 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
>  	uint32_t data, def;
>  
>  	/* Enable 3D CGCG/CGLS */
> -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> +	if (enable) {
>  		/* write cmd to clear cgcg/cgls ov */
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		/* unset CGCG override */
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> +			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
>  		/* update CGCG and CGLS override bits */
>  		if (def != data)
>  			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
>  		/* enable 3Dcgcg FSM(0x0000363f) */
>  		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> -		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> +		data = 0;

The data should be inited with register default value like this:

def = data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);

Then you can set the mask according to clock gating enabling flag.

We should handle it like this on the following codes as well. With those
fixed, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> +
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> +			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
>  			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
>  				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> @@ -7758,10 +7762,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>  {
>  	uint32_t def, data;
>  
> -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
> +	if (enable) {
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		/* unset CGCG override */
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
> +			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
>  			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
>  		else
> @@ -7772,8 +7777,11 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>  
>  		/* enable cgcg FSM(0x0000363F) */
>  		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
> -		data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -			RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
> +		data = 0;
> +
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
> +			data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
>  			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
>  				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 16a3b279a9ef..f69129097f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4946,20 +4946,23 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>  	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  
>  	/* Enable 3D CGCG/CGLS */
> -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> +	if (enable) {
>  		/* write cmd to clear cgcg/cgls ov */
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		/* unset CGCG override */
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> +			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
>  		/* update CGCG and CGLS override bits */
>  		if (def != data)
>  			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
>  
>  		/* enable 3Dcgcg FSM(0x0000363f) */
>  		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> +		data = 0;
>  
> -		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> +			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
>  			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
>  				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> @@ -4993,10 +4996,12 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  
>  	amdgpu_gfx_rlc_enter_safe_mode(adev);
>  
> -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
> +	if (enable) {
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		/* unset CGCG override */
> -		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
> +			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
> +
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
>  			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
>  		else
> @@ -5007,13 +5012,17 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  
>  		/* enable cgcg FSM(0x0000363F) */
>  		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
> +		data = 0;
> +
> +		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG) {
> +			if (adev->asic_type == CHIP_ARCTURUS)
> +				data |= (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
> +			else
> +				data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +					RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
> +		}
>  
> -		if (adev->asic_type == CHIP_ARCTURUS)
> -			data = (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
> -		else
> -			data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
>  			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
>  				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
