Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6754C20672
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MU3bj3F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6754C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1BC6EB6F;
	Fri, 10 Jul 2020 06:53:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67606EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 06:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIzqs7q2aX2XPSYv/NcduyZvDQjubfXmr+hrKRCScYUrXr+NdQW3DQdwXhA5HptO1CYBWK2iTT/UTGXn4diVIvvGVObW802TJLecsLZwq/WZcmpoiHazZkng/Kq29fM0F37XiU/AOvTyMkGbMLNbH+0G/kT4K0e8OG6uqtE57noAdb8rDtjFA25Awc86upBQi19vihbWluxO2F1Qm0Su3Dt0u5GcOmMaEJ00sVe+B+L6GZLT70i6XF1f1CoxMVWGFhbx7BM+VvmLKUBM3KhRCn8xdrvwbgCSh/Cyfiij2vEUbOZVQrMPimx32b1TN+EmLohZC42TnXuhol/B3LaWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpCVyACC4oh/Ii+4sRF5x4AZikT2oi5lE1HJtmX/q7k=;
 b=OhvHIfvgXAi+ADxweIppvGPjq1DN0n26cl8GdZ7wc+qKZ4F3cNTWLFyRyggFfO1ysgJNuAHOsG9Ov6DjXWAWkDQont0LvXCuLuZA4YLLdH7mu0Gct62Rlsnr27XlhyrWyvQUt2xsMyU+kVBgxuLzf0KydkacLOfHh/Nyu2Vfi8UccEoBWdgO7TyUzoZCIyfZo1KRZj9BlvLe+c9ml1w+h1y2fYsrx/RMyb8hn3UpmkH3CItGB3uP8hWAHQDR1JZiLkDBxBfUo8taEpa4oyzr44xo9zGTh3FuDeOj/zGGV0e3Ivbz28LUWQXsoRYua0vjg8uDIixhd5lYGS+YLdmpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpCVyACC4oh/Ii+4sRF5x4AZikT2oi5lE1HJtmX/q7k=;
 b=MU3bj3F5QRrfoo1pUWnsEUbifh3yZleimVqSPFktSYLiRKZkePoef7Dbn98Nn79KwhFiXX/vheL5e7oLKDmx23H1IsR4FTYC5gSgah40C4LxlTjt+NpcssXKqfF50iVpW6Fm3sbx1O+XbSQu7fY1qtdKonuJn2z4oMaZYqMiFYE=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 06:52:58 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 06:52:58 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Topic: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Index: AQHWVn18m6ktZHNKBkaqeZkRCPujmKkAW4+AgAAC5fA=
Date: Fri, 10 Jul 2020 06:52:58 +0000
Message-ID: <CH2PR12MB41012FB7A7DE5B1F13ABC3AB8C650@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <20200710054626.2487-2-Wenhui.Sheng@amd.com>
 <DM6PR12MB40752D83CCCC8F1891FF3115FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40752D83CCCC8F1891FF3115FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:35:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c7832111-3d76-42aa-9bd4-0000dacf5f0d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T06:52:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 45d4e68e-269d-4766-ae0f-000017650832
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffe3f3b2-e97f-4b8e-6506-08d8249de173
x-ms-traffictypediagnostic: CH2PR12MB3958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB39583199FF8BDA2EB35A04BA8C650@CH2PR12MB3958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtM+/n6oVjicOJ2SZGzhw7lnqFYq8iPyG6K7saZR8zNBkgg/OHZcqe3mkv3KA4qTKMwaQgXTLFnSoAWS7CtHU9Jj/WHr5FfV4LyGxZv66et7OSVVfK+SUoB3qnZehu7fmZRr8QqK4FKWOVoL2omPCdut+nisQjbPYImFv1WHvgs7GBNRojeNcLh2yVoJS7RvndPGGU9DkodkSVuu+9AJuw+QMZzPkiJknyat0yH1sgfduC9HUeakSpUJt6I9tBlMxBWNjlq4KujGkhczXdqICUk/XWa5fH6iarKNNuIPaztATRTAaivnU4L3XgIKmkrsRtvnuKE4soc8/wcRZ933MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(7696005)(53546011)(478600001)(71200400001)(4326008)(9686003)(2906002)(186003)(5660300002)(26005)(8936002)(6506007)(66946007)(8676002)(66556008)(110136005)(52536014)(66446008)(64756008)(66476007)(76116006)(86362001)(83380400001)(33656002)(316002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PgYlPmmYqIMIwhoBqPxJt7mjgzJQGGNZPi3YM00mOviqz7kAfc6e6PIJ4/m5TPsJP6rdT25HeUDgh4TO20rrQbeADRxZP42IILmjaFK60EbdBlwK7OPoTIDlbEGOXXBFcFwV+aJR4VehazK6kVtLoFW6I/dGXsNV7VIvLxtSj2AOvFDN9z52ZM0fcSTtC3a/bzHM/qrDjyxI+P02zmaamki7D9oLpAlWLqJV6yjGqrSUG3ivw+wc8JV1GGn7Dwi3pVKmDxm3V6wWGbx9uwpiAJyQwnXrPxUYkVGmuuPlhFaxx2QuZvwZqmwilswTO91Ay9BTVma0NSa0HJAsnMbxwScQdM2Ay7R5nMKK7M/oSQzTUZdCfEnVrd10Otk5kNGQnZIWEK5f4IxHWjaf+VSE3xvdA5k3sUCK4h8DC49bvGlBJMF26j+38l5QC58fq/aYCwf9qjy59PWZ6zX/V36+U0H8PYCH0rO9WjFO0YXsaIw3Sktj/hh3aoiQ7J/tMa/P
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe3f3b2-e97f-4b8e-6506-08d8249de173
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:52:58.2253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhjKBSLo3ymrlK4nfEB1t74hClQacCtfwagrtVLChV0gy+XeO56ANqgXPq8KbQ+jazDkE4sZXRd/N7oKcgMy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3958
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

Hi @Zhang, Hawking

I tried to hide mp0/mp1 mode1 reset under AMD_RESET_METHOD_MODE1,  while it seems that we need to tackle the difference in function amdgpu_device_gpu_recover, like following change in 3rd patch:

@@ -4275,16 +4277,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool is_full_reset = false;
 	bool audio_suspended = false;
 
+	if ((amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ||
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE1))
+		is_full_reset = true;

That's the reason I add new AMD_RESET_METHOD_PSP_MODE1.

Brs
Wenhui

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, July 10, 2020 2:35 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

[AMD Public Use]

Hi @Sheng, Wenhui,

I'm thinking of hiding the MP0/MP1 mode 1 reset under AMD_RESET_METHOD_MODE1. the callback function reset is per ASIC function, where nv_asic_reset and soc15_aisc_reset serve for NV series and pre-NV series respectively.

The new mode 1 reset will be used starting from sienna_cichlid. It should be quite strait forward for us to either initialize a flag like is_smu_support_mode1 during sw_init or even check the asic_type in nv_asic_mode1_reset to decide whether we use psp_gpu_reset or smu_gpu_reset.etc.

That's saying, we don't need to change the reset_method interface, where we decide whether we go to BACO/mode reset/pci config space reset.etc. We just differentiate the approach (i.e. psp or smu) in nv_asic_mode1_reset.

Thoughts?

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

AMD_RESET_METHOD_MODE1 will be used by SMU
mode1 reset for sienna cichlid, so add
AMD_RESET_METHOD_PSP_MODE1 for psp mode1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/nv.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..0682a270c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -580,7 +580,8 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PSP_MODE1,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..565dc59a9e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2119,7 +2119,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		return true;
 	default:
 		return false;
@@ -4174,7 +4174,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
 	atomic_inc(&adev->gpu_reset_counter);
 	adev->in_gpu_reset = true;
 	switch (amdgpu_asic_reset_method(adev)) {
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		break;
 	case AMD_RESET_METHOD_MODE2:
@@ -4220,7 +4220,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	 */
 	reset_method = amdgpu_asic_reset_method(adev);
 	if ((reset_method != AMD_RESET_METHOD_BACO) &&
-	     (reset_method != AMD_RESET_METHOD_MODE1))
+	     (reset_method != AMD_RESET_METHOD_PSP_MODE1))
 		return -EINVAL;
 
 	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 356849136d1d..1d27dd3676ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,7 +265,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -274,7 +274,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -310,7 +310,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..86ce2f165038 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,7 +479,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -488,7 +488,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -559,7 +559,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	if (baco_reset)
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
