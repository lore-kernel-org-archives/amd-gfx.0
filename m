Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC74C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAABB20725
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g2FfRpRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAABB20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8C26E41D;
	Mon, 13 Jul 2020 03:30:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2132B6E41D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdNm80q4of6PR5ZK0+8pCxfJf50a8aiRtat+zSFcdP5I18clcssNKsGfgFc4WGpbP5S/JYqRJpHt0zeJ9wiUtJZb4H1/0SBd71Sci2pMUfLFpuvD5WgzmEVMKkL6AGxqGhcC3D4q+Y6EPwGmlMxL/PYWJmxkyaxhp1ryqe/uppscfQDqKGY2+kKdTPyk5Q5B1pZ7egfNrQr7c0n5ZRdlmJgua2XLd7ZGvLE0cLwaHkf9qSOpdcXiMNE0tgdVA6sHpjp5afsJ/0BaCiylNHyPC9ntmrewZwR7PChxqtzZgFra9KZ9qPwye6H7uc7AUbtr5xX+Aq+VwDFowbkZZOk9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPc6SKg5IrTImTXK1D3PY76wH0Ung/fd3dg9X7rMxww=;
 b=EYx+uKKAfuDlr3mkKE97xLSExsRwF5ai7lgP+Fz27uvehdjo8tM5FElDvIsqMth9sx4afNX1yfH2dEYvaNIa7LzHV7lT2U+khbI5zJpX3YsoUySjO12euSDNbmreFAyuU7JlvOKmZHVQ3khir0D+Ut/9f7VL9bpKD9332tUs+0nLme64vY0l12ca4pBWEmXlRDjT+gtEOtVLgcY0zndhnnLPQw3TAtE/YlY8/qjJZK4Eq7aRezh4MDRT89yaW7uCnt7lsdfajaGmLORtCTrRE5yToin8LRDGccCnv41OBQnWsi5aeEJV4mZvp6fg19GxpBWjTpE/tbKUx1WHowXeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPc6SKg5IrTImTXK1D3PY76wH0Ung/fd3dg9X7rMxww=;
 b=g2FfRpRM1jpauMPXPbUBSwFVRvTXAoYemoyHvoJwhVKgdF7fbWB+hfDAfIl3hqLpo6pi2tCJ7RA6ofy1bI7gHZYUXVIHCCz5BgHjwMVzmij/fxNClXYC6cUx+q9tQD+2xIXDy0bRFgVB/q3DIqX8csWnrbnGmWU/d9PudBEAhUI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Mon, 13 Jul 2020 03:29:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Mon, 13 Jul 2020
 03:29:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Topic: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Index: AQHWVsTSzJUVripL0U2ueCU6yaUeC6kE3XLw
Date: Mon, 13 Jul 2020 03:29:58 +0000
Message-ID: <DM6PR12MB2619E50018140895EA78C7D7E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-3-Wenhui.Sheng@amd.com>
In-Reply-To: <20200710141644.1601-3-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc815b64-27ce-45a0-8466-000090a8eab2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:27:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab6be051-ac26-41a4-ea5c-08d826dd0525
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18368DEBF8FB49B3C17CDA18E4600@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2pcpjU61visbt7sgoZ/jOoaaBNHTQYtYUnx9lgdaHyylywF32QIwucWYRoTkC/KLK7hUfD+0D3RTzyJP5qpZKyuH8W1Uxd1o7s4LnLGa1EBx+rbvGBBI34w3e2oah0gUtA5KT1Sd+it+WwkZcfOe0UdZMGOZC9r79EHhfUY7K07w+z5sj2ZAfJWZiB6EesMNtYDnf4/Au0ehVx1AV7bScMjM5zA1KgfELDjMcF3BTzPZRTTaP0gbXRoqmRvDAEHdtU+soEhjcKSyAVlK/cjHlRjfWNqUz0cIhXsWu18wIy5UH42OX3KnZiJOcsY49ukzfTcw8cL2hpbXdCLzhROpNGaFh74OYmUDOcv/iPXgf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(8936002)(54906003)(66556008)(66946007)(66476007)(966005)(66446008)(64756008)(86362001)(316002)(5660300002)(8676002)(83380400001)(6506007)(55016002)(71200400001)(45080400002)(9686003)(76116006)(26005)(110136005)(7696005)(33656002)(52536014)(2906002)(478600001)(4326008)(53546011)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: //5m2IVrnR7rajNMM5KY1mFhy641iwSNFLr8QEYvvgPqd1LtRjZHF28FgLvwNXDhscuw7IAz1n5YVq25ogPR4v76w1JvAS1SSzHiDl8lH3pN0L3jIbi0fmQkfiUkZQ4aSdNi+HM+cPIW1wyEnu44gzmOOMON1RZICKwlirX8OYlpI+Rb27tqhYPHAN/5DXQNfFXiQd+vCkmfS284zJQkrAyTGhaRISUO+smX/3dh4MZlim4eb4UtPupGhg++Wo5W4duxp5/LdCxxxQgCrKm2Nz7Nl/3QBTkbWEIa1q/f7K++YGWNj+c0hCsHRVgffCcE86rF3PdU569S3qsCvYW2TSkr3i5+HRm1n5LhwLJdBCiy66etK6iVyJtMj7Z+Is7Kv1bZK6VoY/yzYgKxEOypqu74cBl9Aud7OpAISsNdX6mzc8AxlJo243hgekMiWqOayD9FsAWs0OFQ8Hew7gUTIyeElQj3kyBBU879UvWRa+DSBqc8d8hyBhSMXUPxirWZ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6be051-ac26-41a4-ea5c-08d826dd0525
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:29:58.4376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0Y5BDIC/G7Owa5LiNkO5ccaqmdqaZmjbYofAA3xVBbq/UpYt7o0BhsUhFPHUmTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Sheng, Wenhui" <Wenhui.Sheng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Friday, July 10, 2020 10:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode

Default value is auto, doesn't change
original reset method logic.

v2: change to use parameter reset_method

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 4 ++++
 6 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..06bfb8658dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */
 #endif

 extern int amdgpu_tmz;
+extern int amdgpu_reset_method;

 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..ed9f32b89f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_reset_method = -1; /* auto */

 struct amdgpu_mgpu_info mgpu_info = {
 .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);

+/**
+ * DOC: reset_method (int)
+ * SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
+ */
+MODULE_PARM_DESC(reset_method, "SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
+module_param_named(reset_method, amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..a99418cd2f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,10 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 {
 bool baco_reset;

+if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+return amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_BONAIRE:
 case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9f1240bd0310..309ff402d7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,10 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 struct smu_context *smu = &adev->smu;

+if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+return amdgpu_reset_method;
+
[Quan, Evan] I kind of wonder what's the expected behavior if user specifies amdgpu_reset_mthod as "0 = legacy" here? User's settings seems ignored silently?
 if (smu_baco_is_support(smu))
 return AMD_RESET_METHOD_BACO;
 else
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..a8a134f7bb61 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -532,6 +532,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 bool baco_reset = false;
 struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);

+if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+return amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_RAVEN:
 case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 4e5e91888d87..2cc8ad19ebed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,10 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 {
 bool baco_reset;

+if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+return amdgpu_reset_method;
+
 switch (adev->asic_type) {
 case CHIP_FIJI:
 case CHIP_TONGA:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C259262f416404c23d64108d824dbf044%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299874389349093&amp;sdata=uyCH2W4ox82ta%2BZRO4PXeYhHf2o7RH3fMoawcsFy3M4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
