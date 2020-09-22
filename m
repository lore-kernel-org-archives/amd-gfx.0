Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F5C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59D23A60
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nbmoSy6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59D23A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1157F6E5D5;
	Tue, 22 Sep 2020 02:02:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4216E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 02:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXUs8UH/7hGuI94HZy0i6zgaKt/2UItu6jzD8uKdfd1+sKbDb4EeT4zvhZ4lfMdZe23bt3pzBL3JaBJZ8gi7ZuADgJn/MUeHJLU6Hu1FiV1/LL+QZNWfF2m+tNyldpREHMNvwciu47ThDMTRnmxOhRe9N5/bjlJ+F/3Lm/Ac5rasU5IECTWQHwBAdApMl/OGL8oZQlw3gQ+H7ngGDLrgEv7nPLpuC3al9PZU1jZAmVveCmkDKdcBsSJAkdr2WwMWy0utKPKgJK07Xo8+Tuci2OWc+SxoDb3OqBCYltNlK0q9SKKPDnV7KAUub9j4GKg0hIiznOG8u99hycrZEDUn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1ApR9KJglOWPV31uLQFjABn2OEkJBxVbf2PkOIc6AQ=;
 b=Kh55EPmmFghaaJ9Xz209HrGawl7zwm9ZCKdyOfCx4QhSBJLqSlfvtQB0t2v5id7urX4+CRAkQgFMdHzS/Ok0lrot+xfp+PX7Jw4mWpd5YIYr4HdKGI190hF5ncSlefXikVVujFctLdshUlnp9n7bWQa4e6+dztZSiHaqd9Ncoh9erFuoDkm8wFvgWJOjKTJxM4ajtF/Bic3PuOWLz6T6tt+Epp76jDXKHeUxiDtjAPkmM6GulTg3s1THe5OtH6ClCNDU/8FGxE6Dbuu1KcKLb7xfu7WeNa34H224bDpO+zwYQq77vsb2uWJ41caZd/KekQJ7bA4/T66YC3PoZUtb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1ApR9KJglOWPV31uLQFjABn2OEkJBxVbf2PkOIc6AQ=;
 b=nbmoSy6xfqsHzKhhqP6zZJ8r7NEjwB8nuh89feF1HB29zyq0o0VMXUPt6v9eTkqE9+2bSYZlvTE1AvNIikWhIeIxtQxe2VdSX3/YTtqnIozK0K3ELQO+3ZOro0lSETO9dMVlHdfLuFt87krLGjxbLsOFJ9/keus+FWK8Gdmro5U=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Tue, 22 Sep 2020 02:02:17 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 02:02:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna
 cichlid SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna
 cichlid SRIOV
Thread-Index: AQHWgjxlQ0y0sagecEiXuzscIaGVt6lztEaAgABO7JA=
Date: Tue, 22 Sep 2020 02:02:17 +0000
Message-ID: <DM6PR12MB4075BE5E30C2F23D66AA5FE1FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200903215027.6823-1-rohit.khaire@amd.com>
 <BN6PR12MB162088225A53EA064E648697873A0@BN6PR12MB1620.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB162088225A53EA064E648697873A0@BN6PR12MB1620.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-21T21:14:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dd94a889-ec62-443b-b06a-db0ef43069c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T02:02:13Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4f660f69-50fa-49aa-8249-0000fff88b3b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4a73845-89ac-4cb3-ab33-08d85e9b888d
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3274B057620BC0FB96656E74FC3B0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mwjhwThERTRsuupF7KfVd5t6tresklcZWZian1/tyZxc5sBwJWU1FAo1VRXbnMQWpR0wpUeFy7NbjpgTPtEwNjU6lR7Q0AgyoZOQRRIgPfk5vGnuQQX3Ht+IqtLvkRXRuvmnPSLNHbjuUXsqtGDbGCIvBcUzyHXT5TdTvnwugOWJ6NGd2zcLytnCAzmOOB03jwEK5WA3hwrPDWEpNB4VoK4QF0jnw2UF7Gd40mVbHJVyNixS52dH426HdImpIElZW4xt17bqlmPRy/LkKyWkmzT8ZguzIPkD6JWHWbxLx3OCp8+nfzLKy3FYmS0XA32lNCsdyP94rRRrcGYvAnOUuyN6jYrVgNHsjar81uzZtP6pCIYrE0HSgJkUVo/2u0v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(33656002)(71200400001)(9686003)(52536014)(6506007)(30864003)(8936002)(2906002)(5660300002)(7696005)(53546011)(8676002)(66476007)(66946007)(66556008)(66446008)(64756008)(76116006)(110136005)(316002)(26005)(83380400001)(86362001)(186003)(54906003)(55016002)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TMhvrFw3yYPdORnzJyjyBo75T7Y+HgyfReJaiAPNOWn5kJBu3Yh6JszG6d4059x3AdoXCSzIy0nOq0re9g9O7pjEm25ZkgA7RCfnU9TcDmsy8FOGb8zWE4nnu4Pv6Y/sxzFeJn9TSkM3jm3ZZcZKjeG//9rBQlU6usrzkpbDwm982kCBOqBwNgOISlxNnDgg9t+pcnvCxKHPOCpugTfGXWU+Jyu1ItoYXAUiS9lWySeR+i4Q/nVaWwEGjT1CVMyRdltLsTmgHPpu6S9NigvYKy5pnJEDZJuHMgKcW1Ek+jZ4FEToUfw9WGaa+Zj31oYRN/IN9gbgXYg6diEoUfa60SPjlgrUN6qp4fM+Tb8Bve+AZzTKI/Dkv6KVf/ok42qTrgjjcItIomNocUAF+8NpejwbYwJW5DyxNm0MIc3AaRBd+e78BhjA5tP2rKETG6FPsOg307FlS/ClBK8pLBWeRCICRy3OasIWK60xKVc1prYZu6ZEW5S8T8cyPzoUotMK7qq4JRdlUTrmRGGWuKq3INGeQ/dUoDwowLplf38q+OxzbFcKRpIJKCNzBSV8/Kdguip2OyZk4P196ZTVL4H/YdaUC7ZO23WXTiQWGngOoZ/eSLoKokiVqSXExXG7xgCVR2VrVOQ28P+bcsvzUy7RCQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a73845-89ac-4cb3-ab33-08d85e9b888d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 02:02:17.4891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gb1OdFVKowAI8utBNkB0agFsa6eEJULQ1tUY+oI0mYApOhH01Lbdoj4Mx5YXJMOlqUlyp9RY2O3E10zw2U6gXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Li, Rong \(Zero\)" <Rong.Li@amd.com>,
 "Min, Frank" <Frank.Min@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

This is really not a sustainable approach --  add amdgpu_sriov_vf(adev) check for every callback function.

If RLC is not allowed to access from guest, we shall not initialize gfx.rlc.funcs for sriov guest..., while check the function pointer before invoke the function.

I think we really need to think about the approach we are using to support sriov guest. I'm afraid, in current approach, more and more functions will have to add amdgpu_sriov_vf(adev) check....

Regards,
Hawking

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: Tuesday, September 22, 2020 05:16
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Li, Rong (Zero) <Rong.Li@amd.com>; Min, Frank <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna cichlid SRIOV

[AMD Public Use]

Adding more reviewers to cc.

Rohit

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: September 3, 2020 5:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on sienna cichlid SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 49 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 64 +++++++++++-------------  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 42 ++++++++--------
 3 files changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d502e30f67d9..4bafbd453e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4808,14 +4808,23 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 
 void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)  {
-	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
+	u32 tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
 	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
 }
 
 static void gfx_v10_0_rlc_reset(struct amdgpu_device *adev)  {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
 	udelay(50);
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0); @@ -4846,6 +4855,10 @@ static void gfx_v10_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
 
 static void gfx_v10_0_rlc_start(struct amdgpu_device *adev)  {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* TODO: enable rlc & smu handshake until smu
 	 * and gfxoff feature works as expected */
 	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK)) @@ -4859,6 +4872,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)  {
 	uint32_t tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* enable Save Restore Machine */
 	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
@@ -4872,6 +4889,10 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
 	const __le32 *fw_data;
 	unsigned i, fw_size;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!adev->gfx.rlc_fw)
 		return -EINVAL;
 
@@ -4906,8 +4927,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
-			gfx_v10_0_rlc_enable_srm(adev);
+		gfx_v10_0_rlc_enable_srm(adev);
 	} else {
 		if (amdgpu_sriov_vf(adev)) {
 			gfx_v10_0_init_csb(adev);
@@ -6990,7 +7010,6 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_gfx_disable_kcq(adev))
 		DRM_ERROR("KCQ disable failed\n");
 	if (amdgpu_sriov_vf(adev)) {
-		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
@@ -7272,6 +7291,10 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -7339,6 +7362,10 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,  {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */ @@ -7381,6 +7408,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  {
 	uint32_t def, data;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -7422,6 +7453,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
@@ -7584,6 +7619,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	/* bypass PG and CG on SRIOV VF */
+	if (amdgpu_sriov_vf(adev)) {
+		*flags = 0;
+		return;
+	}
+
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 237a9ff5afa0..44ebb2722c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -152,33 +152,35 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)  {
 	uint64_t value;
 
-	/* Disable AGP. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Disable AGP. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+				adev->gmc.vram_start >> 18);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+				adev->gmc.vram_end >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+			+ adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+	}
 
 	/* Program "protection fault". */
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
+				 (u32)(adev->dummy_page_addr >> 12));
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
+				 (u32)((u64)adev->dummy_page_addr >> 44));
 
 	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+				   ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 }
 
 
@@ -350,18 +352,6 @@ static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v2_1_init_gart_aperture_regs(adev);
 	gfxhub_v2_1_init_system_aperture_regs(adev);
@@ -394,9 +384,11 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2d88278c50bf..99f697e63e3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -211,26 +211,26 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     adev->gmc.vram_start >> 18);
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     adev->gmc.vram_end >> 18);
-	}
 
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
-
-	/* Program "protection fault". */
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
-
-	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
-	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
-			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+			adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+				(u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+				(u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+					ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
 }
 
 static void mmhub_v2_0_init_tlb_regs(struct amdgpu_device *adev) @@ -656,8 +656,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)  {
 	int data, data1;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		*flags = 0;
+		return;
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
