Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C20C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D19610A8
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D19610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BD76E878;
	Mon,  7 Jun 2021 08:55:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081C96E878
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALPkPtlsEnKnWQUHcPtWAgaM+JMwJQBuoufjUsxXmfKY9jI3barSm6lER3H01qFUJ42vX/le+dN9TrP/hs/RGV1TkkgZfWZRlIEJuN0TIGi7D1DvcOby5/cubc2V7n4L94tL0hAcHfzb6X4FgC6OdexFFioolC7zrm5EuV9LtaDKiNMGu+syUE26c8pftH6tg8Yh3PBnNgHsvRuz+RRr+5Vs/8rSGIIEpPlUGvukBY0rZpIARzCDX/F+f0EHnv7OukLcXGG/ISsIF18Fa2qKK1XOtUj8YACermcHclwCUQ8uXz5lGU0/LQkUQ001JAtEomIpPQYGs7PBmQRUXBH7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oedXaY4NpVxTPPPy9k95yPVVbPuoGLLZZFMD2W4LkjE=;
 b=njZmE77YdpDMMQFwFvV/i5nghc/CVVwG2g8Dhy3j4T3a8GDnlMIUVURcT8jIb5JyfVsFlvsBCiswOR/gW3IUAHrdsFIR1MezqU5u+Pmljlyu4PiOLrec/G5my1qayt80mCtn3TTVwJ1qgaCWw57LHWrWzEPocWp22gWjy4s8W+7aGZY4WMkJ6XgTJlTjHlvBx8piEPVhgGJaBjzUykNO39pPX7gqp79Fnde80BbGVQep+oy4n0ENBj1yTbQGf6uX3hi0BvlSezGpUeaGaitFRGz2Z0tzprEEOvdxEelNpGd1tdM36vunXqQDlQCwLra/rDmgUfASFvKheHXUAVc/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oedXaY4NpVxTPPPy9k95yPVVbPuoGLLZZFMD2W4LkjE=;
 b=IzHwP40uvp6kGBG9J7Kymk7IMsKt3b6TqKrx48+9v3xgDuc1i/dOfUDXSY20szK4Ds8RR11kV8nDX5nKMxINnDACe5tiOkif5GTUtPX6dyd5qUhjyu4KebkBmKyQR4NUTbj8sz1tr5+ZZ3j+znZYlXucA7lcYsXAYxuRPYLLySE=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 08:55:21 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::b822:fe51:a6e3:817d%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:55:21 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fixing "Indirect register access for Navi12
 sriov" for vega10
Thread-Topic: [PATCH] drm/amdgpu: Fixing "Indirect register access for Navi12
 sriov" for vega10
Thread-Index: AQHXW2G1eFS4+wzMf02vxB0JJ/L3o6sIPoIQ
Date: Mon, 7 Jun 2021 08:55:21 +0000
Message-ID: <PH0PR12MB54171EDD7B7BDC408D058FFD8F389@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210607055510.24988-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210607055510.24988-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5bea7a35-1a00-4d15-b7a9-ad72a6e3b072;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T08:53:50Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6662f2a-604f-4ae3-4be2-08d92991fb91
x-ms-traffictypediagnostic: PH0PR12MB5465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5465408F043D2BF9A6E937FE8F389@PH0PR12MB5465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDm+GyfJfnIjzzWC0E/pVbC+Zv/SNAZx0MA/vJBJu8HKZfasWeB+djm2h64lC9/kU+VK0fMzYdZfJ8QheIxAzAYcIOgD1s3YsaloWh9ljabAi4N9qq+U6T4rlPSsy675yFYRZbCkPc4YS33pQyxBuMCpBlfeXOKF0xMQRBPRy4kvCD6uFFS2sYGckt/bAIQtsw1SpwhxR6C1NFwYfjy2UHeWXJgDxMT3H5C5lAM5xSFR7N1VHpb2VM1JRo2glSnrEJ6B1VodGVDgcy9CfVKiCkUcRG6Ly/IYRdFWSJ3wEywzG6ynNg+zQB1/eHoQd2wK+nS1B+xdX1KkyVfWP1U/rXcxlV78gQBL8O1t//YRNx8nMyxXvexl5jaY/Cvc18O0kyhyBYmhLDPwbD+nbYrXfd6y3MA9VOVgu76qXErrftkOTioEW4AJrj4YiuHk1Rs6pgh4a6IwOpjgBkMgxbRinZ6UFA0RL5sjh2e8KU9Z2kXgXWpL3SKRBLBWIQeZBiXGABhcFg5LeCQ3swmRju7FnIvfT7TTvpIi/fhTbiYOgxWzkfCrBEOc6ZL6cwuOx5HOhEuw4tSIM4/z4HctlH0VOIJec1uwwgJ08kXgZsB8B/gskFtNazbyVEroDg16EB5z6tzsgLYxYgBObsCJAveGNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(8676002)(8936002)(45080400002)(478600001)(5660300002)(83380400001)(55016002)(9686003)(38100700002)(2906002)(122000001)(66556008)(316002)(26005)(186003)(86362001)(66446008)(7696005)(64756008)(66476007)(33656002)(76116006)(110136005)(6506007)(66946007)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LywfkBXmCBej/XsIadXer6GVErwiMQH0TZJKeS/N4Anchcetd0tzV4rnCtH6?=
 =?us-ascii?Q?pVNwSWE00/7c8goL2Bo85PbxHO/fU+X/9NC7TdrLzO4nizzxsuAyuwZj6BvS?=
 =?us-ascii?Q?Gr+jfh2BaqZbql06CxrkMKSoS0o9XmrAlFhA3TIsftKaDTUGi6iDtqi+/fkw?=
 =?us-ascii?Q?B4qQVenCy7v61ZJ8Di/MA7NjCZfJ/5xjwKZMDylxL2zmumkRQ/ppVNhBJxLA?=
 =?us-ascii?Q?1ilEh3R2J64RSONMZG76wyNxfvtSqSoBssvjF5u1OTVTSLG+vCjpxn3Rsj+9?=
 =?us-ascii?Q?F3Xx5yy7TH8C3OI7lD1JfxYCLX6lZMUBi1dcWF5opPBfb6H/Bcb7uzU+jMVh?=
 =?us-ascii?Q?rlXlb9e1SAOatoZ0oL1EjSYLhFRZ1gK3niHR26bakyHNUVnND/7O3Ad3Li+r?=
 =?us-ascii?Q?krD3whUJy/b86pWJ1LoY6xTK9EUhDcilx9SGbJPXPse6TjoJezdZWUISdmQc?=
 =?us-ascii?Q?t+i+1GS09dQNxw9LQZPJWqQXjmQ4llFw4g4gdOoA5fM+Z7EiMip30Lrv2YQs?=
 =?us-ascii?Q?i11PgZwJD67jZbhjXG2rJhNY6tWbUgtwIwugrTiSYt+ImBYHhB0q4HXaF3p2?=
 =?us-ascii?Q?WVA1JFi/Q29JQIg6XPUrhGLgRt49MJ5OdeZrpLjiMOD74G9CYifdaxqtE92a?=
 =?us-ascii?Q?DaeE1yW1TSzAFrjepcFr3rRquEPaeF29/ZJFTGaeJDUvpfWUGY+LK9s/7Cu+?=
 =?us-ascii?Q?oFVhRBEbexZy2+UpLkTOu7KgohXKgCQdgOy51Yixvc/NunyoDkJrMn52h5tQ?=
 =?us-ascii?Q?Ruwkt+RyrjmbgrbrDnQnM71SYUq8WulLZFYHot9I3+j3c44Lgded7bDfhk8s?=
 =?us-ascii?Q?+0p2I8lXub3qdlzMPWjdJln6DaovVc3PsjlU45zJY6S56+4t6L73lTS6ARWx?=
 =?us-ascii?Q?SDhlEarKDETPBnSAESDp2jBdII372h9A7sNVj75BERkmAIlHZyfKO/jtJzjF?=
 =?us-ascii?Q?vXJFbstuGXW+z425vrA+8ykB2jZla/lDlp3mMQkw95cTj/RtarCn87VQJnC1?=
 =?us-ascii?Q?YUgWxm0OU3nKYHyulkK2ClDt9oaYjatI5u6ivaalmF9SZ2/7R5fdwK7xlmA5?=
 =?us-ascii?Q?n/X/54LNn08yxalnF9XFTCcBvWZqdYXxttPw2tIxO7eEKqftn3wfyfKr5DZs?=
 =?us-ascii?Q?T6RqKyLQypY+A4HShwBmzhXB9vbheLgU/1g8Uz+jfwM5Pzqij25UXeFqxKa4?=
 =?us-ascii?Q?9lkWiEop+CO2tAlEGWccgEMzRbIU8+RLNj8x66E9lDrMI9IyfDJmiHRgAb85?=
 =?us-ascii?Q?+qxHDctZfnAqLqDYPFUqXcWb5ad8vppSbaf/txvn0kO/sLdW9/09l8NRWE5g?=
 =?us-ascii?Q?wbINCOrwSRtkk6jJNh01Zbk8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6662f2a-604f-4ae3-4be2-08d92991fb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:55:21.5901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pNuh57I4XaXYzdEp91w+7GfQblwRuuqZVOmOZtzJ/gd3L5Nr9o/eeiJGJKkSVgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng Ju
>Zhou
>Sent: Monday, June 7, 2021 1:55 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/amdgpu: Fixing "Indirect register access for Navi12 sriov"
>for vega10
>
>The NV12 and VEGA10 share the same interface W/RREG32_SOC15*, the
>callback functions in these macros may not be defined, so NULL pointer must be
>checked but not in macro __WREG32_SOC15_RLC__, fixing the lock of NULL
>pointer check.
>
>Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 3 ++-
> drivers/gpu/drm/amd/amdgpu/soc15_common.h | 4 ++--
> 2 files changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>index fe5908f708cc..044076ec1d03 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>@@ -790,7 +790,8 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device
>*adev, u32 offset, u32 v, u32 f  static void gfx_v9_0_rlcg_wreg(struct
>amdgpu_device *adev, u32 offset,
>                              u32 v, u32 acc_flags, u32 hwip)  {
>-      if (amdgpu_sriov_fullaccess(adev)) {
>+      if ((acc_flags & AMDGPU_REGS_RLC) &&
>+          amdgpu_sriov_fullaccess(adev)) {
>               gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
>
>               return;
>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>index f6cf70e69cce..0eeb5e073be8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>@@ -28,12 +28,12 @@
> #define SOC15_REG_OFFSET(ip, inst, reg)       (adev-
>>reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
>
> #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
>-      ((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
>+      ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs &&
>+adev->gfx.rlc.funcs->rlcg_wreg) ? \
>        adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
>        WREG32(reg, value))
>
> #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
>-      ((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
>+      ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs &&
>+adev->gfx.rlc.funcs->rlcg_rreg) ? \
>        adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
>        RREG32(reg))
>
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C93e8d99e699940575
>6f708d92978d707%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37586421253857337%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=s
>vMhuOMA21NlQ%2B9T9lrio5AIcoAPR2uzRuJfDndhr9o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
