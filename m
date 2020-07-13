Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177FC433E5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5011D20674
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oWALpgPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5011D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058C26E176;
	Mon, 13 Jul 2020 06:26:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF676E176
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 06:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icNjXL26VGlCJdsMCVBuH8VrK9bTNczbG2WvDXo4QoKhx+PWWnjbzCD4kLkSI/ARpcL7Zlh7CzsfMq2kg8MSOsftBsPELNoy3q/3UPHWIIidQKda+D0aHOUd6zeaIkfFnUhZiQfr9VjUxmvRN6k72KQFmyrAt9ngrjVhrtab+T7wgGhec9cdVPbtRIeQaJvWnfeaU71e0dXEL3QFzCLN7k+USzdNyIDWs4Km03SdgONkbFE3oBt/EYZNQ34fNizXWOOjDDRbe/6eQO+JzJxmif/wGNCWpcHENSElWmZQBMZYnPqmn9mIvlbHrQabt6JZRDh0v8y05V+TwXCwTh8REQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ3UK7VGptSy5Elk5G16GRPt3lKNCh47ZtZ7LteJSqE=;
 b=ne6MKRotzViyNBfOllSD5wKfy85JoabEFPBj3IzsOpwQopSQgNd7Re3PvVdSY6jgPyC2v7Pki/kayzdhetr0X+EMCnuwaJQun4kez1dJVGjDvzipXetCkk+LVRvYyku3RX3YqnZDT9U5cKRR4mJ9/faRnt6Hc+mSDR0o70TqSqKiP8AuUXfJfE9AWzdr2s1xASe8H/xJiEgMop8ittfEqteyROZsvN5y7FdHyFpSiQlbIvmxcUz+qzTzVfLhhNXFu8gGXXujzIqn5FzjQF9lsj4IClut8KULbgYGPeZzUkeGC7Z/p3kNWLe2jaMMzFEKB2MlfcC9Z6Tw8W7DZuEdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ3UK7VGptSy5Elk5G16GRPt3lKNCh47ZtZ7LteJSqE=;
 b=oWALpgPv1LpzHnbB5RClYaqtHwG5HBd8SEIE36pgLdWsGpjVDVbXoNiiPA22VbrlhYRnaszSiNOsil+PvcqtHPA36vYZuhG4jy8EvylpCFYSRe93XuCB8je9RdaYMW7qhR6jpHLeIW9JdLVU6uYwY5nf/NztMTePr3HW+wmKZso=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3893.namprd12.prod.outlook.com (2603:10b6:610:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 06:26:22 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:26:22 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Topic: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Index: AQHWVsTJimX8BCD3jEWMkXVx0EvoHqkFBd0AgAAI14A=
Date: Mon, 13 Jul 2020 06:26:22 +0000
Message-ID: <CH2PR12MB41011DCE6C593D40A006DD0E8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-3-Wenhui.Sheng@amd.com>
 <DM6PR12MB407551145160A51D1F8581E3FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407551145160A51D1F8581E3FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-13T05:51:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fc9a55c6-5b7f-40a5-8006-0000bdc2d38c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T06:26:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 847a909c-2326-40d6-a7d4-000058d2d77d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a1c9566-5ac8-4baa-1086-08d826f5a992
x-ms-traffictypediagnostic: CH2PR12MB3893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3893156D7AE52BC35C7C03978C600@CH2PR12MB3893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxRIuKbZ0xIOSjOGv4alQE+IOrK0Iygp+28AcEd54mdy/UYbyW2hbTnCTxo8F4QZe5NW0nUlYtC82zNhbCJ6WrKhNrJOIEj/HFM0jt+wwS+OS16iKozYY+kclmgx/VKpDkEH4DYP7sjGq5u+1EfuK2ZIeVJiVJQ2B1pniCcU8kAze7IeEQJx1d4FiJXXbZr78KirSZ1FmV7Jamc3OzzwrJ3zk53z2vqzKuduHGE2QHZUVqJi5CY13GL2+ieoLOE8650gh/HcJUKNZTA8EKBWRXL8mJtRNBhEUFvSgj46zppkDZh/UYUTfC4S8sG6iU2o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(110136005)(76116006)(5660300002)(52536014)(8676002)(71200400001)(83380400001)(7696005)(33656002)(186003)(86362001)(26005)(55016002)(2906002)(316002)(9686003)(66446008)(64756008)(8936002)(66476007)(6506007)(478600001)(53546011)(4326008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yY8/PiyBmSxcDgTuwmIQ9pVZMi5lNoYyJ1c0Pq6SIDVwEVSMJs5wjxSlLDPsggw7yVeEEWKrTnK9GsbkWnbtPlbrWWZcFEv7oF0FkpCWyDboPFvw4gORIEsH25jHoiMTl/WKeEj/IYfBYhLxnSv9Z1HRMOzScISBxbIeUd4kefxuLyFFcE2A2697kBvoGE+z5fji8CbCy4RR74+Bl38SyWC39YVnKRk1Z2lEjLWo/4aJ95GV5/eJ+5yYdeYsFDvq8gm060pHwYVrRynb6uLzyrjWpIlHX7izaDWwum+R9eKt85JOPm0v5muxJ2AUuUG2yEnsSW7zbtMSHOunc6ZPcjn22lL8xNA2ma+K0QgGcKhjKOjtiRGHoU4TuzrDGUQ9H6Ge9L7JTWdRdgqvdui0iLHrMO1RrEeHUsAaM9DeC4/Ug0liEpY1mgiDNTExoWYpV4q0ASlIrlbFf2HEmIIwg7iKhdE1RnBPCIAoEsu/GWF1pOGity477z8B4lpE0SlN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1c9566-5ac8-4baa-1086-08d826f5a992
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:26:22.5823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1xA89yDgo9QOqOBpGai9rvod6n7iYpF3fZqaREQXLWml2lpXbQKsDPZLGesy0oybFGQJdbkKEPWLSd0xmLebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3893
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

Ok got it.

Brs
Wenhui
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, July 13, 2020 1:52 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode

[AMD Public Use]

Hi Wenhui,

I think we shall deal with the case where user specify an unexpected/unsupported reset method via the module parameter.

So in each asic_reset_method function, rule out this case, force to auto, and print warning message to inform user.

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Friday, July 10, 2020 22:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
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
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */  #endif
 
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
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");  module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: reset_method (int)
+ * SMU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = 
+mode1, 3 = mode2, 4 = baco)  */ MODULE_PARM_DESC(reset_method, "SMU 
+reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 
+= mode2, 4 = baco)"); module_param_named(reset_method, 
+amdgpu_reset_method, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fe306d0f73f7..a99418cd2f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1326,6 +1326,10 @@ cik_asic_reset_method(struct amdgpu_device *adev)  {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 9f1240bd0310..309ff402d7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -311,6 +311,10 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
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
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
+		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
+
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index 4e5e91888d87..2cc8ad19ebed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -710,6 +710,10 @@ vi_asic_reset_method(struct amdgpu_device *adev)  {
 	bool baco_reset;
 
+	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+		return amdgpu_reset_method;
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
