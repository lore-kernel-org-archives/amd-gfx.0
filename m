Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A55C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 06:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2518221F0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 06:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WYyC6yAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2518221F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8466E8C5;
	Tue, 14 Jul 2020 06:39:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E006E8C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 06:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeQJsmeuYciGc5TKONLziV7WB79X6OBeJnwYwDcW1kHsGsWUZaTojW6jHmYT5EWpUSQTHlCxZaalleSY6fpgL1UO9vuw74g++nciJVVSSewu5wT/L7Jw4OgSTCRBzOImd0A1S7bIGUobAn7p4AA1jDhsksrjomkTN3xjKlmgQh+NM6uLNhzYzQwCOANpzZVdbfs31iYRYMIqX3zauJzmX+cyDnh3ZnM8Gkt2ZO9SijCIm91O13YISUhCJbfgzIjIosE2Q1SdvyluvSMk8N+yYygHDXbqkVZ5wxofdqdZax5fZnQtFfZchfhhIBNp0fcueesl5KiZQx4U2S9SeifmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbnU4CYP3sf/B4tqOYU4guiTdAO/XEKcx8UF7JMC8nQ=;
 b=fpOkX3jLEIms+y2h7e7OfFkLLJXyIQsucYwJKX+UwMmb11HRRlXBchH2AqH0iITB3+GDZ6klthUJOpOcDurWmS3rXC4MDTeg37syCCF3q4VrrDsjg9MosNZDYhfjK/uB2WSZtsSU9QDwTVkGaqUvW5bC33Jy2j3nQrRonx0fJt6Y01mOc3VCZC1JZziclbePEIFpDFt1XfA+abtZ14S7GfrMJP5s0MEE1sN6hqry/GU60DBIIKOee9ZUrId3o/nRHtH9aWoZ5FFkbQITn4DrSgbCcJZBaigfMWT6W3oC36/UDYJH93ZcbNFWZJ2MK/KppOieesyvOpHpXAVtHXAY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbnU4CYP3sf/B4tqOYU4guiTdAO/XEKcx8UF7JMC8nQ=;
 b=WYyC6yAZBtApLyUxT6xsliQ8BC57WTvoY7SD2QIo+3S++oZRHKaKQwu9/ZCVzC8Sn6mSBDkW+E7HA+LrA6DTuwLAiuPQyxEeI4H/u4mb0y2Jb9LZDdzqEF7/UsCt2s7SNCkHdhG192r0V0V9ogX7u2o4uhAXJiYk+ztkClBr+70=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 06:39:02 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 06:39:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add module parameter choose reset mode
Thread-Topic: [PATCH 4/4] drm/amdgpu: add module parameter choose reset mode
Thread-Index: AQHWWYabGRMwZIwHYkW+XUsJCMrhxqkGnvlA
Date: Tue, 14 Jul 2020 06:39:02 +0000
Message-ID: <MN2PR12MB40780445CF5419B7D4104E45FC610@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
 <20200714022911.3006-4-Wenhui.Sheng@amd.com>
In-Reply-To: <20200714022911.3006-4-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Guchun.Chen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-14T06:38:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=63178957-8983-4466-86a8-00006dac8d7d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-14T06:38:58Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f8db4109-a64b-48ce-b027-0000baaf6aa1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2347a6c4-6b8a-4b93-298c-08d827c098bc
x-ms-traffictypediagnostic: MN2PR12MB4407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB440737A77CDD8383CFA2C2DDFC610@MN2PR12MB4407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5ODA8c2sxdDxqj16nL5VSv8Q67af3sppFArwDvbMsVdmokSX8rl3Bd9OUelB9fhJQhrMyQg74dkDgoIlgveM2pzf5fu8KoQnZW5SayCi11RrQ0yw9VQPAVjY+BpkdfEf+Tv2wDdknolC9rmy/kBNCYRbRIieo1/LgYCxLzPfbnlqTtGFWXKSgLoSo1CODkxAEVcJQuMkGHFpdZI6XbGLgSiTmbXloKKEYX4yIj6dvGZAWBqgpApwPiM9AmhCZQ7NLpgmeoXu/gp05nU1J60FUFT5Nn06HW/Ly59wNvNxgyO15cdA7EGe8KkUkRk82JG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66556008)(66446008)(66946007)(64756008)(66476007)(110136005)(316002)(26005)(52536014)(55016002)(6506007)(53546011)(6636002)(71200400001)(2906002)(76116006)(9686003)(186003)(478600001)(33656002)(8936002)(86362001)(5660300002)(4326008)(7696005)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cfAlZ1R5NFFKZHBaUCSltYuyZs73HOGmX2i44eM338rdA5vLk/TfcLDex+cDEZov5XoyO4PhfJklAUxSZ0rvZr0q3tBUYUmM+GZjI2NTfXlxul9FA2PuEgVtSLVWXj5nM4Mgo1DPEjdt63chALKgFqucrALfYGxGE4k1DDUbUdWn2uJPIdJCts4H6OKA4hF4bi+43LPrkZWLDmyuEIvkpio6uhxw7Ztr4+V9yq0/fAyh4g9SY2ZmpU15db2fXmkI530vzei1jAwuiPVFVMzopIKsFsSnl16EJUGmLJI/Io+pi6VvVjZNMargunEhRQxEvjaLw1X5Kv3/jy/AdHNBKLvZXN48uxu8L6ehrIg2on4xj8JKPLHPEMgbiiyaIa65mH6TGYAgjHA5UQhSw3JQN2Mi4hH+KAoPjHFEktGCVKax9K3IkVdBG2xBra5piB8x9errOPyL+bNggmnLTgm1Q6OLqN4obDXArVs45cW/g3oXzYqcZkclSAVFvS+xPUP6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2347a6c4-6b8a-4b93-298c-08d827c098bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 06:39:02.0875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R63XqOpuYDXITSl6563/CAWLBqjf2EWlc+HlplXkdl8QvsmDsA+7jJmI1uoopW9ZWuw0UnR50DAlP0SDeE05xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Patch #4

+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);

I would suggest explicitly specify the reset_method enum that is not supported per ASIC. Other than that the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Please work with @Chen, Guchun to validate the RAS Recovery before the submit

Regards,
Hawking

-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Tuesday, July 14, 2020 10:29
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add module parameter choose reset mode

Default value is auto, doesn't change
original reset method logic.

v2: change to use parameter reset_method
v3: add warn msg if specified mode isn't supported

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/si.c         | 5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 7 +++++++
 7 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..06bfb8658dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */  #endif
 
 extern int amdgpu_tmz;
+extern int amdgpu_reset_method;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..581d5fcac361 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_reset_method = -1; /* auto */
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");  module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: reset_method (int)
+ * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = 
+mode1, 3 = mode2, 4 = baco)  */ MODULE_PARM_DESC(reset_method, "GPU 
+reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 
+= mode2, 4 = baco)"); module_param_named(reset_method, 
+amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..310bcf81256f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)  {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 9f1240bd0310..486321bcab8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,13 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c index 9d7b4ccd17b8..1b449291f068 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1229,6 +1229,11 @@ static bool si_asic_supports_baco(struct amdgpu_device *adev)  static enum amd_reset_method  si_asic_reset_method(struct amdgpu_device *adev)  {
+	if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
+	    amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	return AMD_RESET_METHOD_LEGACY;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..40b343b25588 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -532,6 +532,14 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	bool baco_reset = false;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index 4e5e91888d87..e4628c17802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,13 @@ vi_asic_reset_method(struct amdgpu_device *adev)  {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != -1)
+		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+				  amdgpu_reset_method);
+
 	switch (adev->asic_type) {
 	case CHIP_FIJI:
 	case CHIP_TONGA:
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
