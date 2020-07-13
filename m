Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7421C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 05:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651222075D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 05:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bmqsIiDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651222075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3196E4A2;
	Mon, 13 Jul 2020 05:51:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7F36E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 05:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1CTi7vwvdOp24JzRRPbAFcqqJMsmMGVPNtdUOmBtzU9NpKJhMXytpLVEyYYxFTVMx6oZBo0y/LuL1mX3Ci1HjzwW/x9A+m5gut4zPuSDnn3x7t/BNZQxAd8nA6VXod54NVhhWysLw8QoNnDUgi5I6h5E/gMFm3nj5JVguA+kjjfY4sSrJuS3TZxtbo30GyMJjCwhIObqNBaE1Cftd/OMnS63DSKCm507HLDsxMXGruzl8DEbRWGfdVkQQRrvOnPwCrBfP2H4rOg45nTBultGx+RKwdgwm/aA4+e5rFbsREJJHhwB6KdTSERZyEpQr/Q/Zwt+le7ofhh4dEdlTCrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYWK8mgjOz75+sDmmjeXunZG/QYeBt931iKSebWpZQ4=;
 b=CAEZDHchsOKdzAxOu/+B5mNjnQNFD0tgmk5onoYqoY0rf42bUa+zRDCRtQibvwiVv2/75cJuMjf/f9bzV3a1N5z8M+/+PruaLEQKqOCpeTwqHrwI0V5G7zTBSq3ebvNng+MKwJs170/r3xklt8oA53FQ2IBsQVNPkswqMWf0oVZMUB/KYWb/mO2pNgQGtStlsXmtdtE3j0jrhDS14DiLkzW0AQNY1AJBpjvgoiFQQzJbY1voV4FA+X6WZxVAmfIiAhVeF61RZKGDErz+begNbPbdPKB82o9Q5VRJtRK8BEeAIQd5aZJ+bqjaqzvhhGGbAE5i+vjaPzb2myDXz/oCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYWK8mgjOz75+sDmmjeXunZG/QYeBt931iKSebWpZQ4=;
 b=bmqsIiDgjt9b1tEzSgofrZiO/+shJnltcK4I/wMpbl32VSvZToycdgxEsszg+1nh6gR3SMsYBYayRByM3lXg9T9FfAEszhcnk1bPdpq/cOzxMSzq7OdmEBq8cZ7O61r2daZFXfzek/pF3kmYdOFgW8++BS4u3pg6TVlXcNBUzAI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Mon, 13 Jul 2020 05:51:50 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 05:51:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Topic: [PATCH 3/3] drm/amdgpu: add module parameter choose reset mode
Thread-Index: AQHWVsTJpcRsRBjko0+6fvA/0IR1WakFBCPg
Date: Mon, 13 Jul 2020 05:51:50 +0000
Message-ID: <DM6PR12MB407551145160A51D1F8581E3FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <20200710141644.1601-3-Wenhui.Sheng@amd.com>
In-Reply-To: <20200710141644.1601-3-Wenhui.Sheng@amd.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T05:51:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e83860d1-0d32-41f9-9e33-0000635d45aa
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T05:51:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 74a84ebc-6fcc-4bdd-91a2-000013d6b3db
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32e1e271-cc85-44b0-4c8d-08d826f0d645
x-ms-traffictypediagnostic: DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2359735C44BAD57218492019FC600@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cS6btk1xJejiNF4gC+349N2qLkmUCmvrV5MoliPQTbcBoSglKoEuDnegh6ZvDgpDINpciqPKGNs7KL3pjLij6fu7ZwgIZx/nLPdxrJqaO3evKbOXC4YwTDAyQAPdR5CuyajpUb5OHZZLGBGOPuVE+Mk5BZkHeCrUG23NIqCdgfnBl8baLtUccoW7paUL7cv5T++fgIXUcC3WeG+P0DxyJRn7kkol9r49vInMqob8lolavkVyITwOhC9FdKcxvNTHIh9FAhJ3bCveDs8jdrp0IptJI1a+MTj+hVRBYUXUtbVa2j4AZqV3bm2zga9uXJ7h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(5660300002)(86362001)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(186003)(26005)(52536014)(83380400001)(71200400001)(33656002)(2906002)(4326008)(7696005)(6506007)(478600001)(8676002)(316002)(8936002)(55016002)(9686003)(110136005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vHa1wKG1nJmwEkL0jB1OjkB8lJACRYqf1wFkd4uD2K/WUvV4quiBgI2iinLBBP9jxEr16sNGGlV7CPpK4RpaSHvwa0MCROCBIY29IWbhAWqtWfB2SbkPHc1PXosPWDvfPmpJZ4MUuZ6ssfXFzPpBHqXP16Upk5Y5eM+UmzuLZ2BteLPvy9NvLimNZJrNIFAI3PY7wfZ5OCiFRE5hbKIz8n4DjjMxjsPYNHiVhdqzBMh6iZ7ygxCvxbkINJxVLWASjmEPnNaaIWa6DJNQc7q0Id31GZjx7FkHiUWjqmb3U81LmWJsAsZZ1yL/0g+Yrs3oj8y2c9Zt/6dfuwscl8Y0hHGfoO1O8wKYxwxxkqxUXjjfR9JB1UNyCD6SzK7o4a3X24Kfhn97Neuf2oiGHIX8lpwAq/+jQmU0pv28T8KkG1stKWzShfGp8BOTV/UlkOcmDpJj1OUP8E8f4wSwF6wHS3VPsrntotFG47sm/mUNvGCgZAG3b9s+9zeB/vz1YjPN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e1e271-cc85-44b0-4c8d-08d826f0d645
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 05:51:50.0772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkcRZYDhlTtdhYcQ2kFI0gr/cOv+oDkv2W7JVncnPgHVI43AxjU0Jd7jdXlhyCHHFhXRCjN/DmP94S0MCmidyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
