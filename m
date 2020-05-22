Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F956C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9961F2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QmJziQC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9961F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5D86E090;
	Fri, 22 May 2020 05:09:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CF36E090
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWBgCcw77kK+r2MmitUIavYqtPPLDm5Fw6ZrGRF8i/lt9GhiKFrm7ty9cr7Z9F5NC8HrXxMZbZs4L53Iqi0wh+IM02oM1ikHfzmg9Ksyudnyec6GddRmNYidDcEA4HTNxc2rCbblyFol46rTU73TXqQrePNmxd5R/fupAyWQbSTubWLORFS30/1GrVDbuR8WNuabiQZPtd5c8DBZd79jkFqC6b5GZZA5tU7JHHeannBPxk/Z/jus5xp9f5t8BZGzNd3qfHCCjw4C9XISw947W1ugJRmuaUwvW9l7LyUF4UVKTnm1wK2XVl9CdX1cq5rxWyeGQ6r5ADzC00lef7QAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmmKtLLbBegcyxcDcaMlYJVGD43faz032tvPwUNgiNQ=;
 b=LE7fihZIVulOzHV3wEdZeJwxvwdC+Y3aRUbjP10f6/oBE4QTIAzWRgv66W+wHVrb2RHQdexGz1c6MlIMBpqy6cgKXSxS75rABcxBi6SG+pw3zZZ6flfaSx0fRDbu/rRwrmO+pyhv+ztSikuuKKecAWGArxilJcv0viS16VBA1bloD0jY+pybhvJvL3kSyNJNawj38cTVygym5HSttbZy2TIO7LApppuJlpk0Rk4wlJWqOHsAPvXT3Yg/r9eTfUmCo6Ab/bSZER14bQejDDlpEMlqqb0iURoEM71XbrvtFNyRyvC60CeHpyHJI1HlF+G7DVfBh1YwPzHUBkj4Uv0GlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmmKtLLbBegcyxcDcaMlYJVGD43faz032tvPwUNgiNQ=;
 b=QmJziQC9H9s0cFP5gA895xiZSPHcFPVbl87d2xmVr1z4Yb16FE+u4sSBS2szs/73SBH+EVrqHCxQJTGE4/GPpHem71w1xnTdH86SPFG9a0pOpzl0bfxWO26Q1mV1/+HAhZEMjOsaMM6A+xH1uBqJRDUbkuxtuW/d6P1QJsv+Yc4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Fri, 22 May 2020 05:09:00 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 05:09:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWL6l+XbGPfE28U0GMJWSqbrawzqizd/CAgAAW6ZA=
Date: Fri, 22 May 2020 05:09:00 +0000
Message-ID: <DM6PR12MB407522AD24A74063B1771BFDFCB40@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
 <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287CCDE92924A2C5BC25FC5F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T03:42:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=56b9b592-8362-45e3-af5a-0000edae5c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T05:08:57Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0baf1e41-c5e8-4f4b-8318-000074c57864
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a34aa9c-d7c5-491c-e08d-08d7fe0e3cf9
x-ms-traffictypediagnostic: DM6PR12MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4281C432746D441260FFEE2BFCB40@DM6PR12MB4281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ItJyiGay0f8LGzQLJI4+M25pnls72uq6H2chZ95NmyUXNA2SgwrnCsQdz4SHffqrF4fTlHmvNadxVZ+RvVVYqcO3pTwlBsiYgzAx+oVlVEm+OGo6R2z8oMToEvw7MVaI1dAN+yVrh1YEkWxSIg4IQZaKp8tYhxMh+NGPeezCCt5ZJ+tpKfl48yUYPo4fa8kE0GyiqUGRutE0PRH8wRMlBMD2Yu2xjmrbJoVBtFXZajphWgFGB6McvHh2IC09/Vd3LhBbsyh95x5aAEFOc52VIzAwuqbd7JnE8O+/INiU8wXhvyiG1LRXrxQyqqFETLhmQohMVA6iBNa7PGH2Va35BXU5m/I2xQ8IG/3P146Ty8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(4326008)(52536014)(71200400001)(66556008)(9686003)(2906002)(55016002)(66946007)(8676002)(86362001)(33656002)(76116006)(316002)(66476007)(110136005)(64756008)(66446008)(478600001)(7696005)(45080400002)(5660300002)(966005)(8936002)(186003)(26005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 86ewnfodGumbNZq7bMno6wDaWAiaGmPI0kQKec2NRj5vGkSTEubcYZsuDeXpVLyjCVIPYvkyUot9Qgce3W4u+dZX9LnIuIbe0DTpA3G5W+J3Rjczp568+FVTq/gbRXL+LKsX8VSA0FdsLReomWaRBEiCuVMc+QN+hzOZ/MLi55qpoEulGoLpFkjgJYmTvA43wFJiaxTNX183wGoI19gKjYiXjoLbkXx9aJuFgt0zi0ChGtqKaZLsZGZoWy2ye8WCNNI3NJMO2wS579cjHwoM1tbHHnPvPxITJxX9yuVouUL8YZAX4dXgMd4wdRCVCuPjV2ax5QvGW7LoFZkqfFkkLs8dthPpbWUC1rGcWI7QN+hQ+SRjbGApRlCD4X8kYeW6kC/82CbFGOVzsL6d6i6uhgmngnjGv73aRSDU4pJBt/7MN2GZQdLXENFa2Vu3lF1/Uo5Qf2aoDWzNju/ezDHJHa5bmDx2IWtgPpb3m+IzorBtG8gjG8wHMixsL6+RHFaD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a34aa9c-d7c5-491c-e08d-08d7fe0e3cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:09:00.1842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjY1zFg2BB4L0KLj6HhTLwrd2+w4iTIRuIgMoFQeiquN9RTvf7VXVNa8TG8RZCaqGRRI/gi+7xkIkZM6tIpWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cab787c659a654d8e6f9c08d7fe02c725%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257160214567792&amp;sdata=gTreRUn9%2Br1sS%2FrMEA7bJ630LusX1396szicn2ZDwrg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cab787c659a654d8e6f9c08d7fe02c725%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637257160214577779&amp;sdata=yVL3hqGTscc9HtIj6YHRxo113b0VO0rqtorm1blUa4U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
