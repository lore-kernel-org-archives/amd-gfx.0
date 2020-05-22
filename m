Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2CC20757
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E6+vBjCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2CC20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFB46E046;
	Fri, 22 May 2020 05:51:43 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690056.outbound.protection.outlook.com [40.107.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609B66E046
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa+K5YubIAntQt4kttvYwxKHnFOoaiPv8rUs+O2xl+dfdu1QlC4qyWZdAc3D5DtQK/l0z1fhEMzVXliNLuVuBaWJBU3nc/CuIus4ZzflBdfPWO7I82EkLQcoUH+6lnQlvEfP2bfqb722JK5ivwIVaJfM5qp157TVPhIHvDZ3GUaOfcmde6A7nINOdYydDT7LQ/H053jUWCTvCddX/8WcUWnIxftQius9JiW1rEsttUx6IoUen7yohmA5UrXEejKyKDGERsqg2JvjwG/1Y8e1vWK4SGK6vmGiSMBdWxliQ2FYrZOo3Wpb57a1FqoMh5zCDe40TEMlDyMWDYsqisbMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFjoNzBIl6aQpUkOPSiCNsNqweRXdnEIG1xf1vpUef4=;
 b=ZTiopRD2SNRaOlxf2jaQqfV6w24xf2ocwIIeG1Zh4i7dRvjSVvUyqaD//1wWG/ELVGOlr6YRAUL87oBuLJDTb8ngdFn+MpVaQ1rQnjC1ar/hImT9zplh/sytLwflzapXQANS//ovp5M9i5KqQbnKH79QWQfUThMv+DOoZv54MPqniuGZWVzPwXlEuowrNiGjmLxDxGEnsDsxwVC991MfsE+ZS1LznZwo0+M6uWpwmi503tYxMANV83nxAErFc24inh4qqLQknSxp3eWoKyBeC2XptN1uZO+eY68fpNCu/kF2qhX/slGXUH9zJtlso4eiNe29u6GwvEy+fxqr0vbDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFjoNzBIl6aQpUkOPSiCNsNqweRXdnEIG1xf1vpUef4=;
 b=E6+vBjCBg47GuGNVvskVDCCfxhJPSy04oIkYkh9iKIlj4k5Jr8xtND1KXUgwb6DEzeAulRRaYR/J/xUOSexlYKFx5VbBQGBH+YObxFS90Q6tGz7MpUXZupI3RG7bKFHsjITdA+cfQywaR1uBIKnaypTuEB0/ij9b45p5B+H2Kjo=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Fri, 22 May 2020 05:51:40 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 05:51:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+4Ytr41evJ0yEh2yg17cX8Kizd/CAgAAW8QCAAAvYoA==
Date: Fri, 22 May 2020 05:51:40 +0000
Message-ID: <DM5PR12MB1708563850356414C1427EFF84B40@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Gavin.Wan@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T03:42:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=56b9b592-8362-45e3-af5a-0000edae5c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8b4d05e-e521-4180-5354-08d7fe143302
x-ms-traffictypediagnostic: DM5PR12MB1180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB118003FC8A8F716590D9B27284B40@DM5PR12MB1180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukDF+kEL4T9id/kFi98WTP0NO3/uYUwG5oF5sKVedwzFxTQ1z37G1/0jMecct/ZERGR+4MGre42A1WTmv3zovmGSf7LFiIdhOiX1aPQfRjlpOTG4dW7vQAIdqxaUXCX+KsuhRoIa6XXO9CmIqqTU/La4lo4Yr5mtOkL8e5pRAoqDCuloqbnfa6wQgFtWWDJVTwlM8K5nk7WRlZf6vSzpDrhd0RT8wskFPBvBOyANRgBbm2FBZUyRHisdypVsL0ECGg+gvI3nyvmvmvIZ03LRPoBbSjsnCGop8Fwd+D+HGksPe7YPhKS7AsefjQLahAIThbQj3MVmp+ukbYtMIGRWNz0alTePrby9iBv9/YZuImQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(76116006)(71200400001)(6506007)(86362001)(64756008)(66556008)(66946007)(53546011)(5660300002)(7696005)(186003)(66446008)(26005)(52536014)(33656002)(66476007)(316002)(45080400002)(478600001)(4326008)(9686003)(55016002)(110136005)(966005)(8676002)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +bI3I37jiF0vSTfvKbakY7I7igf5jPJVu1G5UcHzsKji6SAJX8lr6oltbfQpweqtSBRNdImsuwippY+AMerI7CelowdwG2/OS8eX+EdJFF1H1NVQqwO64qxzf1PnZTfsDE33QIRfsuQtR2ErajFci+09GjzGZL5eTkYXCoa0Mu4MYuVBh0SExX4H8lEuHUfDXLn24CGoAo1CW5F5iFEeh+FkoZEi/VCNrHeTIjk/xI7GySCcO0KRAQD4hBEo1fWpPZ6Kk/pYZSOCSS4IYu6fE7aS0A5IyguD3DEAytFBzEOue4oJRIQKCOJUrljXAV5zyH+fzapvgB/kKCidpuU+qT+lnKbhkh3IpbcrjrKrilhT6LzmVMu6Z3M82MCc5LxylXKJEZOpgsSbmAbBx5XzocFpzVh0ojMCOEc7lo9vB7zSqY2yodn6t617rFBDaSzygWoobDFr2fJYP0q9rm1O1tRvbo/LVp1RtKWfvy7xYq/8khoAvoXCcKMNRBcTYiqT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b4d05e-e521-4180-5354-08d7fe143302
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:51:40.2716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WhFMySfSKs8keh/akl52xwFWfP2iSuPinYk6WJvZYupasospcEdgSib+DMeKlus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: "Wan, Gavin" <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sounds a good idea

@Wan, Gavin can you try hawking's advice ?

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, May 22, 2020 1:09 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Can we leverage existing CG flags to control this rather than add amdgpu_sriov_vf(adev) check everywhere?

If GC CG feature is programmed by host. We can just mask out the following flags for guest driver case (amdgpu_sriov_vf(adev)).

AMD_CG_SUPPORT_GFX_MGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_CGCG |
	     AMD_CG_SUPPORT_GFX_CGLS |
	     AMD_CG_SUPPORT_GFX_3D_CGCG |
	     AMD_CG_SUPPORT_GFX_3D_CGLS

There are too many amdgpu_sriov_vf(adev) Check in amdgpu driver, which actually add unnecessary sustaining effort.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Guchun
Sent: Friday, May 22, 2020 11:47
To: Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

[AMD Public Use]

Please see one comment below.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wan
Sent: Friday, May 22, 2020 3:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

For SRIOV, since the CGCG is set on host side. The Guest should not program CGCG again.

The patch ignores setting CGCG for SRIOV.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..52b6e4759cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
[Guchun]This coding style is not correct. You should put the check after the declare of 'u32 tmp'.
Maybe it's better to split below line to declare and execution parts respectively.

 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, @@ -6842,6 +6845,9 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -6911,6 +6917,9 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,  {
 	uint32_t data, def;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */ @@ -6953,6 +6962,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -6994,6 +7006,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C99086e3adedb45ad03ea08d7fe0e3fc9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257210092457510&amp;sdata=ntHm%2Bgwj4Q9Tv30c1irg%2BWf7y9QxQUSTO4%2FWMhpjK6g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C99086e3adedb45ad03ea08d7fe0e3fc9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257210092457510&amp;sdata=ntHm%2Bgwj4Q9Tv30c1irg%2BWf7y9QxQUSTO4%2FWMhpjK6g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C99086e3adedb45ad03ea08d7fe0e3fc9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257210092457510&amp;sdata=ntHm%2Bgwj4Q9Tv30c1irg%2BWf7y9QxQUSTO4%2FWMhpjK6g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
