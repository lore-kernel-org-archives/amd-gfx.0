Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F85C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 01:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FBF2145D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZY2uh/+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FBF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA0C6E083;
	Thu, 24 Sep 2020 01:18:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 031756E083
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 01:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT+hW2XDY56tXs3Zuh6BnuKcu3/1FcRGmvksbEWRjDBRZ6qf/Jc3zExAmLxUTKm5nSj6zj/7LxU/Jie45Q8gs6mZFdHPMkRGL//zX/iEqImqKsLb6LOesVa1g804gi8zAKvx3/v9W84sN6BMoB46depun31kP6uhLwGGg094u4lb3AgQwrf+DXxjfTHp63vpBGLfbFVHQQEM9gRZ8ByDKLjL2nu8q7kdB3YPM85GqxTIZfygET8uHj1tPwcR9tNpeyqeyx+OxW/XvmjPJ7rcTpjlqt0IkbGaQjqVTazb1PenLdIXZfU2zodaJgPiv5Hw2Pizd/CEca17Q4/Bx5XZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZguCS0IX5HbxEium+TeHd6PmzdaiBlU2HRNeBVB9G9c=;
 b=ge0oOGMRH6HrByg5YrRY7gNb0DCegPEvhRmvlIIDsO9/T55bZXNUG0jYeXvh2YoeevJXUuijyC96CuS+6cJywaE8uQ/6FvyE/xWcux7gMDpK7GhVzMJ/bLD284ddhOaZ8rFPlsINuyppOevOjla3FBKu5IbXauMptuPvbl00rn6mhplUVlNqTeuKquphwuO6jgbJ2z/080HMkGbne2Kb2kpX2ivVicj50XtD866Tu/gIvYyaDPD6BJy/dMSTgNDiFXz9GtbtDzDctJ5jACCVYDTabixBMh66APcWAjJnydmJlsc3S+z8P5WdxOGE+VXjs0BgN2OsxRAU7kSn4Impeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZguCS0IX5HbxEium+TeHd6PmzdaiBlU2HRNeBVB9G9c=;
 b=ZY2uh/+8Nbd31kZ7fbpJ5nkY1unbpkFeX3AzWqQRwgfOyTpM6WrQxzNYvPYd6iV+aCbWy211qbSUE8N2rGiFS/Ut2aFsy0TqOs3mD+N67VxJ63TNtuZS6EU3PzX9WsxaJU0T2QKyFJLEPHGkC8e3f7DZvXLiOcLd2LzVaMh4VkA=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 01:18:45 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.026; Thu, 24 Sep 2020
 01:18:45 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Topic: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
Thread-Index: AQHWkZFeyzNoW94oMEufk8M9ciZfx6l2/cjA
Date: Thu, 24 Sep 2020 01:18:45 +0000
Message-ID: <BY5PR12MB4115957CCC0EF910ADB3A71B8F390@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200923100653.740198-1-Jingwen.Chen2@amd.com>
 <20200923100653.740198-2-Jingwen.Chen2@amd.com>
In-Reply-To: <20200923100653.740198-2-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8dc8f95c-7546-4da8-843a-c4ade411e902;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-24T01:17:26Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b0adf76-5e43-496b-a0ed-08d86027c85f
x-ms-traffictypediagnostic: BYAPR12MB3144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31444BBEFDEED9C1F186C8E58F390@BYAPR12MB3144.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgQa6UiamVwp5o2B9KB5FQwBaNDETkkD5rTm0gtX8RfFthwTRctOjQ/RiJdTY/E02dG6oP/0kZaQPteLYGl+RA1vmSDpshWCM/MPFB0DJnhCu5tRt2ImaoRfGA33RcT1j4sTNeVpOV3IU3Fdaf13gztAK6EhsPcRLlBJu/U0VKLx5y302uZ1i+yTk2QBNav3ffTHZ9DDPkiELW4O+X4yT5zsBPr5dS7rCTPkH1jCxd5O8m8zyCoFeAwFoRXNMSttFtN7Ceo9ouqxqEsIqfunDFqC19zbQcpS+6uEQ/xuLAZLlLwB0qziKn/5OuyqQJDNQxi69u0oGQasBguxn2KThgjTTeNwtsWhjS98KkBFsqg2oBsjl8zl85V8srP6Oix3kSP95e8DV46TU4YEscH1F0JijXlG/oumi8bRnhTJNJE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66446008)(76116006)(64756008)(66946007)(71200400001)(186003)(8936002)(86362001)(2906002)(83380400001)(33656002)(55016002)(52536014)(6506007)(316002)(9686003)(66476007)(66556008)(7696005)(4326008)(26005)(45080400002)(5660300002)(110136005)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BvgC9iHSKOd5v2154FAw6NYSNvqEBC+PkRlqeNRk3udSvyaGrgLzcKrt8y2YOwpg2lbOg17iSiydna89d88O/aVZIyiW5ATPuv6SeDJCDwcxtUa3Cj8O0fT88AtCVyyiC0F/MXDWF3aLM+cH/il5kyxWnSV5CHgofKBPr3XDyrxC2C4zHH4qmfMsv0cYb4ro0Gw8Q3NTqMr/vy3eKhvJ/bCNJpR8biMWtGws/yXmdns0jfT/AQBDTq8Zcd6GgFVHkt7NOvwH2tG8t6fq1dHRnE0STzW2vT8U54KfSmjMz4meGXQPYd2+d9tWfzcxSNDzqg8kGqg2x0Tzk85Fr3TpIyTDZ34aLC8CAj0SpS2EhG5DdX0ZyT8FRNzGCzy0Yzf87nN2nlWU7aMEcaSQ+7ERH5+iuBV7LaGWg66r+T7yZBG/+8XRApwxD1OnGckshvmgtCOP5L2X9PVX8vboBBCTJdo9O7uZFe98lm0LeXHew1ZUCoZAovYW6N+Ix2jwJRCwOsTpYNwwFxNnfAEEmfNc8fhHrXLiAH5gf1b61WwR0XqT7uYlzFznvUWJxulol5DEx/w3H06QRnZzCYzda/c3j86Wtn6y+mE4Gmm8tu1EOKOxHc5nTgx0p800ThBlwzHoIFJP7VQHMQ7lWfjAMvG7sw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0adf76-5e43-496b-a0ed-08d86027c85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 01:18:45.2864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQo79KGN9CvcRcJqANeIh6HNEevQYLxTE2MZxitqgLmdkImlT2Ae6Gugwktg9WpE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is Reviewed-by:  Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Jingwen Chen
>Sent: Wednesday, September 23, 2020 6:07 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Chen, JingWen <JingWen.Chen2@amd.com>
>Subject: [PATCH 2/2] drm/amd: Skip not used microcode loading in SRIOV
>
>smc, sdma, sos, ta and asd fw is not used in SRIOV. Skip them to accelerate
>sw_init for navi12.
>
>v2: skip above fw in SRIOV for vega10 and sienna_cichlid
>v3: directly skip psp fw loading in SRIOV
>Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c              | 10 ++++++----
> drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c               |  3 +++
> drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c               |  3 +++
> drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c               |  3 +++
> .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c  | 12 +++++++----
>-
> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 11 +++++++----
> 6 files changed, 29 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 2c66e20b2ed9..18be544d8c1e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -161,10 +161,12 @@ static int psp_sw_init(void *handle)
> struct psp_context *psp = &adev->psp;
> int ret;
>
>-ret = psp_init_microcode(psp);
>-if (ret) {
>-DRM_ERROR("Failed to load psp firmware!\n");
>-return ret;
>+if (!amdgpu_sriov_vf(adev)) {
>+ret = psp_init_microcode(psp);
>+if (ret) {
>+DRM_ERROR("Failed to load psp firmware!\n");
>+return ret;
>+}
> }
>
> ret = psp_memory_training_init(psp);
>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>index 810635cbf4c1..86fb1eddf5a6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>@@ -592,6 +592,9 @@ static int sdma_v4_0_init_microcode(struct
>amdgpu_device *adev)
> struct amdgpu_firmware_info *info = NULL;
> const struct common_firmware_header *header = NULL;
>
>+if (amdgpu_sriov_vf(adev))
>+return 0;
>+
> DRM_DEBUG("\n");
>
> switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>index 48c95a78a173..9c72b95b7463 100644
>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>@@ -203,6 +203,9 @@ static int sdma_v5_0_init_microcode(struct
>amdgpu_device *adev)
> const struct common_firmware_header *header = NULL;
> const struct sdma_firmware_header_v1_0 *hdr;
>
>+if (amdgpu_sriov_vf(adev))
>+return 0;
>+
> DRM_DEBUG("\n");
>
> switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>index 34ccf376ee45..9f3952723c63 100644
>--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>@@ -148,6 +148,9 @@ static int sdma_v5_2_init_microcode(struct
>amdgpu_device *adev)
> struct amdgpu_firmware_info *info = NULL;
> const struct common_firmware_header *header = NULL;
>
>+if (amdgpu_sriov_vf(adev))
>+return 0;
>+
> DRM_DEBUG("\n");
>
> switch (adev->asic_type) {
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>index 1e222c5d91a4..daf122f24f23 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
>@@ -209,11 +209,13 @@ static int vega10_smu_init(struct pp_hwmgr
>*hwmgr)
> int ret;
> struct cgs_firmware_info info = {0};
>
>-ret = cgs_get_firmware_info(hwmgr->device,
>-    CGS_UCODE_ID_SMU,
>-    &info);
>-if (ret || !info.kptr)
>-return -EINVAL;
>+if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
>+ret = cgs_get_firmware_info(hwmgr->device,
>+CGS_UCODE_ID_SMU,
>+&info);
>+if (ret || !info.kptr)
>+return -EINVAL;
>+}
>
> priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
>
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>index 538e6f5e19eb..3010cb31324a 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>@@ -832,10 +832,13 @@ static int smu_sw_init(void *handle)
>
> smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> smu->smu_dpm.requested_dpm_level =
>AMD_DPM_FORCED_LEVEL_AUTO;
>-ret = smu_init_microcode(smu);
>-if (ret) {
>-dev_err(adev->dev, "Failed to load smu firmware!\n");
>-return ret;
>+
>+if (!amdgpu_sriov_vf(adev)) {
>+ret = smu_init_microcode(smu);
>+if (ret) {
>+dev_err(adev->dev, "Failed to load smu firmware!\n");
>+return ret;
>+}
> }
>
> ret = smu_smc_table_sw_init(smu);
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Ce86d2c737f474bb90
>aa008d85fa86c48%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>637364524587021372&amp;sdata=z6fkXF7odf2ZHXPu4wOELA3RuVBm4arFgn
>9f%2FB8Ie6k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
