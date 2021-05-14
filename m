Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D476D61407
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D476D61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99E6EE3D;
	Fri, 14 May 2021 07:56:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01FC6EE3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekC1OJJoxA6OnBbFtntaizVK0+T0mWFdBtN8oAnR/aoNsAShk4xeDCtkn/aTeG3s38yTaO6AB96WZL/uLr5oO4CK2J4H6PtDgL/FmBMUzxVgWb+8yBAO2X47y3eNElib5O6qhaeztt80HcBmEtCCzoF4oPvfUcUKGa/3AVzgOcFOrApA4sfW27cM9HFKDlwlLaWrVlmzbfFN/cc6ABvuib4xLi2ifpDwPH+X6JDH2YuT5rXjtFonW6f1kes+j2e+0Vb0JG7EfIrzQ4VlogqR0IeIMNyFIPGfnr4W2W6miqhqwntW7FTukbnzyF2YlIHmNXR2gCKs4efl2rLfkIFCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3yfJqH3ZgFvuncTINy3ZdR4DZkWX8KmkCjsWz7YTZ4=;
 b=MzFb0V/r3mEkgS2/1G9QIPx5QnxcpnuSDuG5L50YWYAnVuEUmBDCZnwR2tQ4zTHlYmyDg1ICaYKuKVFV/aSud1Xagn6LpQ6wNOPXyGjQ1afL8jZ2bRkiepTHWTWtSe2uTc1sV6Bk3a6qwU4jD9Ldh+SNzRL0vOmygkMHj5RLhUdXG8wGLRzeEzD5ChS/G9ZHWeItF3e5g/EN04qesojV4zTplMxQ7tOz+LF0dqVdTu+braVzTfscabVeU1rfhy0r/XwPFe1VKOhCC730MIPhhXIHo3WCDKDuDQU/Z2DS/5pFTVIciiHLPu3jKIVdOE0NNnb4lsrHA1rx+Peu554m5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3yfJqH3ZgFvuncTINy3ZdR4DZkWX8KmkCjsWz7YTZ4=;
 b=rC0iRlLWp2486ljLfK7kBmmkOvI4tP7scqSfRm/YhsGEqbyQUurfiN1YnYY5rgU2ioYs738sZMH+ByMBSVWK7gvfgJluySgEJqBuNJKvrhdpCF60dCcJMoMuLtsHgHDLaLxj3H5ikq8gm9ZiWWhQxDyH0Wl0DBtGbIZDiJEMhW0=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Fri, 14 May 2021 07:56:39 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 07:56:39 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface
Thread-Topic: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface
Thread-Index: AQHXSJKd4xbXjSv5PEOL5DSUaoT5Faril+yw
Date: Fri, 14 May 2021 07:56:39 +0000
Message-ID: <DM8PR12MB54789C30F58F1BB9216A2ADFF8509@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
 <20210514072706.4264-16-PengJu.Zhou@amd.com>
In-Reply-To: <20210514072706.4264-16-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T07:56:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=85e0186b-12b9-40e2-b2a5-39b1adbad225;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b8c003-47e9-4952-c58a-08d916adce6f
x-ms-traffictypediagnostic: DM6PR12MB5518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5518735F1D1E140813B3D8FAF8509@DM6PR12MB5518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JqM/cq2Wj4RhoY96H/R3G6WDlyAJ1KWJds5e3vWElYRaZZ75s9A63R5NGrImKTLDisCUD+rigIYbn+ZQncameHm4TGnbibkv7dKpwAD3JArWnqM+wCnTv7LWXr1WEm+V/Q1MnOm51vX6U+LO/OvKHADyaDzy6KX0rlzR/uo0aroOvLda1m3IyyZrWJ3FOQrGUCJBkoJOEbm6EoESoMjbLWfafk42VbVVo0i5Zc0C2zriANpt6zgDP1zOsRnJBrnOYt57KP7RaMX1U+8gNT5YcxbrqbI4AG0gSMtPkqBMjXpdKz25w1FwUdgQO1V/7OFciqXByrDQkCfHmefLmZlyyWdANbxNZSXuyK1RJngivJSBragf6+zjNxTCJseQqIuj0UIdutOxLNDrExq3sqUiEWyF50N6paImH3i3xPXU3EhgZEB7wVHql6B17dWHVrrALtknFwz+cqDIfsBNAQyD/66WA0XipytT/v2F5G0f2mXwh8ohiodFMEGl4ABGwjpij32zVaI7XB8bB0pM1BfyaEwq3ddDrJoknovvrUa8W+MMscGE51CBTRyu5ZGn2NDTUgpO3souWZDZtwVZdqfeRseQ9k/+/KlfJ/EAO6eDKyA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(54906003)(6506007)(38100700002)(122000001)(110136005)(33656002)(5660300002)(316002)(53546011)(7696005)(66446008)(64756008)(6636002)(66476007)(478600001)(66556008)(52536014)(66946007)(76116006)(9686003)(15650500001)(55016002)(8676002)(8936002)(83380400001)(71200400001)(4326008)(84040400003)(86362001)(2906002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Yx3UtOg4aXrKd7U8QKYeQBTHP9CzWQLyEFrSu7rXlXsC6jO7r/UEHH/MDEXu?=
 =?us-ascii?Q?X5JQT01GPTmxf+Q9YQBqA+wGo9mFoNMoK27UU+Hv0u8LW/2dIHOmXpMTwd5p?=
 =?us-ascii?Q?nAeulJX9Kr+XNwncmcDounfQPY8LIu/e79AP+2TAaJjCQcsaFc/rrTh3QCSG?=
 =?us-ascii?Q?hUrzbEZ5Khg58eBADptZk/fdSQClben2rHGN8uY8Dgql4K2Co9Wj2VBlXy+W?=
 =?us-ascii?Q?yl7pLcUWwMXucIQlzPyEhmf61UhXln/KTWSVLUDHFDHOJrZ+4MFg8p3oVN8m?=
 =?us-ascii?Q?skMJRcUTWJuB1EPmsRETyvQ8scyqghmVzzJ6ijXIWwFOaTTlwxuJ/7dRNRmz?=
 =?us-ascii?Q?R1ZDdcAW9jzaZC7MFejXcafcxged3hupmUSuguM/C4VZLt9LSf9lygDYI/Uu?=
 =?us-ascii?Q?P4VahI5bpVnjlw/SxJGtL7kgulMuOU8BlHQZDMdojYyf4Oipbucm2LIpwmCT?=
 =?us-ascii?Q?4smVeZo9GlLwdopsWesWX0t8iW7VLkfxmNUuSstw4VS7x3jOZXciVLMbR4JA?=
 =?us-ascii?Q?HmkZ0eFe9mmJZXyt+KPPtmNvhgA6t1D5avNzrj8YgI8ciq8OH6V65aV/lL96?=
 =?us-ascii?Q?8jny8kXczQCe6t+aCieuGUVvohss5dqthneLt6CfINTNR40CEC1TOuyZBccY?=
 =?us-ascii?Q?d/WP/GZJXYU+thPzH1RpmMypUNkQU8BnlKjndihlIpK5M4kwc6/dCz9J+aXC?=
 =?us-ascii?Q?nimFtnXxb/s4Wq1N5037Ha5la5GEmgehpf9YAcbXHRztT2WGaEoygOOQSqVq?=
 =?us-ascii?Q?cHThNUZm3wO7Qn5kqS4XG5NkynDzn16mJky1zpdpQQn0pKtn30NagEtiVNBX?=
 =?us-ascii?Q?k077l9JXWCA6eoAxdDl18oGHaLHVTVA/7+3RcYCc35kseOWdPYn5x8UkauxE?=
 =?us-ascii?Q?5T7meaum4sSNhHNBBra5ci3212mkaWP+lYvuOx0Bf+fVBqJ/w9WhvcUlKYM0?=
 =?us-ascii?Q?Yy9RWt3jrL3ciQu2yvmr4vevrNUoMGxNekJPWDMKqBAcZthg7lOlnWXCuE2H?=
 =?us-ascii?Q?0hSVKRiJOp11yGvVSjqX0Wtqzbr05jUpWYtLhtgOAKsq4D7G4icwRIDIgkVu?=
 =?us-ascii?Q?8rB0AKYBsZw2Qj5PrCcqfLP0fdZXjnDeTVU/84ULd066PINCq7x4Xs2fpcJS?=
 =?us-ascii?Q?JI+dd/N0U827rpLH35lzrqWtaSO8c8RySpetPzrUVlQ/Dh3PPZLwz40qv2vu?=
 =?us-ascii?Q?8JqbjUu0h2GphyY3sjJqPrz44p/HX9OY7YRxl4CJrKfyCYpGpLbBiyKO/eSj?=
 =?us-ascii?Q?solGvUqmN+trpJMItSaNNIZY6j3d9V+tKnBP8qvXBaYmWqYdXhJUf4iJapWO?=
 =?us-ascii?Q?C7HIm7yRExnPP2EPGei0coir?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b8c003-47e9-4952-c58a-08d916adce6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 07:56:39.6677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCH+pjNARJ1/8YZ9sNDHiHda/05gXfs65+V0EujuXeeRZ3DKmMoGQN6IrMRgA6wkN8Je3UdHMpga9TjpjkGAqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
Cc: "Wang, Yin" <Yin.Wang@amd.com>, "Ming, Davis" <Davis.Ming@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Felix/Christian
As we discussed before, we should access GC registers by RLCG by default in full access time.
Using RLCG interface if needed when access other IPs' registers.

The patches in the below(have been sent out) are the implementation of this proposal,
Can you help to review it?

The patches:
Subject: [PATCH v4 01/16] drm/amdgpu: Indirect register access for Navi12 sriov - new internal macro
Subject: [PATCH v4 02/16] drm/amdgpu: Indirect register access for Navi12 sriov - SOC15 macro
Subject: [PATCH v4 03/16] drm/amdgpu: Indirect register access for Navi12 sriov - RLC interface
Subject: [PATCH v4 04/16] drm/amdgpu: Indirect register access for Navi12 sriov - GFX v10
Subject: [PATCH v4 05/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file gfx_v10*
Subject: [PATCH v4 06/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file kfd_v10*
Subject: [PATCH v4 07/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file soc15.c
Subject: [PATCH v4 08/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file sdma_v5*
Subject: [PATCH v4 09/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file nv.c
Subject: [PATCH v4 10/16] drm/amdgpu: Modify GC register access from MMIO to RLCG in file amdgpu_gmc.c
Subject: [PATCH v4 11/16] drm/amdgpu: Modify MMHUB register access from MMIO to RLCG in file mmhub_v2*
Subject: [PATCH v4 12/16] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Subject: [PATCH v4 13/16] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in SRIOV
Subject: [PATCH v4 14/16] drm/amdgpu: Skip the program of GRBM_CAM* in SRIOV
Subject: [PATCH v4 15/16] drm/amdgpu: Refine the error report when flush tlb.
Subject: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface


---------------------------------------------------------------------- 
BW
Pengju Zhou




> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Friday, May 14, 2021 3:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Subject: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface
> 
> the interface on gfx v10 updated, the gfx v9 and v10 share the same interface,
> update v9's interface.
> 
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 357f9405f1aa..ce7f9d01083b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct
> amdgpu_device *adev,
>  	    adev->gfx.rlc.funcs &&
>  	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
>  		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
> -			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> +			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0,
> 0);
>  	} else {
>  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 16a3b279a9ef..59f3d8f922cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -734,7 +734,7 @@ static const u32
> GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
>  	mmRLC_SRM_INDEX_CNTL_DATA_7 -
> mmRLC_SRM_INDEX_CNTL_DATA_0,  };
> 
> -static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,
> u32 flag)
> +static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32
> +v, u32 flag)
>  {
>  	static void *scratch_reg0;
>  	static void *scratch_reg1;
> @@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device
> *adev, u32 offset, u32 v, u32
> 
>  }
> 
> -static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32
> v, u32 flag)
> +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> +			       u32 v, u32 acc_flags, u32 hwip)
>  {
>  	if (amdgpu_sriov_fullaccess(adev)) {
> -		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> +		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
> 
>  		return;
>  	}
> 
> -	if (flag & AMDGPU_REGS_NO_KIQ)
> +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		WREG32_NO_KIQ(offset, v);
>  	else
>  		WREG32(offset, v);
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
