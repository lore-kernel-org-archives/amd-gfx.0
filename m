Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A77C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB3207DE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hYCWpZig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB3207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF736E11E;
	Fri, 30 Oct 2020 11:48:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3308D6E11E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGz35F43BGgMmOfSyDzIjVBRUtdIh9cwy5wLn/aarvPj1lBUai/751teFP6lHhiBwmNK8o+Kl5puv7vOQxAtDdF6J4Ai/UdB1rnYJQjPpafp6zhGrkyCWmsQpb5n/2U4edhhILeijnoeQxV9xapA1J3eZnYLJ1eSqDnqf0MGinkDE2pNteiyhrvcXrxXf8AH6YrXAdhMtLB2pyA46qnYX7tnf03BgEH+heDprYHce9qzPHLOR7kNGsXUMBd53bDSwZlztPPbO8kB//ODul1TwXMF5OkY38o3HJqinyqZj3ZBol58mADlEANEx5DUOEX9NFa4/f48p168/1Q2t+LOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUxNOMxii2c/6ClXNi+iGmTpTICS1VUCT5jhrxbEmGw=;
 b=MPEIRBxLcn+PTqYFRDMfZA5ghMoDfySLGmG8rgz28I6TcDYrQxnQhvRawuU0LvY49TJu9byqmr66Lt/bKcfhVTBinhcM5WI1GSVkShZG8qOV6aIlAJIn96XzHhCIfZGYHt+7KYaDt9JyHnhAwPY1ne7mtVns0sf08RH3mIVRcMxmwfgV9fLKcMblPcKhXcZxv/7YoCx2YAfo2qmXw/nI4ME/++F8353WDAlvj59PP+53J87qRnfGXYZuDUE9c0UEKOeHlwOfIaUw1Mwr419EDP6wvbuFVULcoMqlCK+osUBg8O6trDh5eSRktk6TfwEbJd3KhZ67o1zycNL44GT4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUxNOMxii2c/6ClXNi+iGmTpTICS1VUCT5jhrxbEmGw=;
 b=hYCWpZigPplccxYkvEYyYVv2biiJai+vrF5pMbmWQBY+L/YEda0Plekfnz+rwAP86oNp9ghy8MqQ2ze8MV+TpZCj/1ox9Hp8COvvlonMABppgI3QnZ1vg+yL5PKensksiNIoJNmFoWHzY3JXWZR7Jsr85fc7dy+01laLEh0Ug+Y=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1450.namprd12.prod.outlook.com (2603:10b6:4:3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Fri, 30 Oct 2020 11:48:25 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 11:48:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrBd3Q2HThetLk6rZZhYE/MTkqmwBwfg
Date: Fri, 30 Oct 2020 11:48:25 +0000
Message-ID: <DM6PR12MB407500CE6EB454B4DA0AE713FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201030113225.12675-1-tianci.yin@amd.com>
In-Reply-To: <20201030113225.12675-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-30T11:48:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d5812304-d04a-4b4d-a0da-000009bbbd0d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-30T11:48:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 167d88e7-3def-40e6-bf74-00003979d35c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-30T11:48:22Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0d93e753-fc24-49af-9623-000084654b23
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86a38ef1-a631-4ec6-26fa-08d87cc9b626
x-ms-traffictypediagnostic: DM5PR12MB1450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1450201D3BD7CC4795CDD4E7FC150@DM5PR12MB1450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCliy+saVr7ZA1EDpbxKp2c5+Ft9+9b2+Zqb3mlU7ZKQJpm+/QiJLDlAra6l2unYX/eN5G8udEZcyGjxgJEgxV8PSliDtGbwi3hWOWmKx5CumB3fFwJm23gv/m9iRmoutZqlokUngaVc7srpqm4S1acvFx61OvzXgFcsREPXoM3QZrq6BsGmIrYjMl9yLlR33vldFNqY+7/kkLrkw95W2vgWfhaaybgP8TiuEb2dJvhmEdsyeZywGHHK9JTBU18wCqLDeRJB2XicaZ2Csnu0HvfJ953dii6PFHBDdcNoUiTrK8ObpouHt0pymwOzW3IB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(316002)(83380400001)(71200400001)(52536014)(76116006)(55016002)(66946007)(66556008)(64756008)(66476007)(66446008)(9686003)(478600001)(53546011)(54906003)(5660300002)(33656002)(4326008)(186003)(8936002)(26005)(8676002)(7696005)(86362001)(2906002)(6506007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1LjRWa1sqikbt2j7t5A06ncEZ/t1U5eXElQE+61rwUMjUTe14q6BpaIzMvAaMO4lM6FGGGdlTPV7ehqDDkNDeciVR6MG4WRIB3ftpk/jsbK9RIdSCBxN10WeCoIlEf1GB/aYeKssZCUTfQvcjdbyvt8l/QRJ8bnDc6z/A5h43vRMnIR42kEdOK6W/1jGA7Yn+6uQxBbwhuHdrMeHv7MQfnvitPtOHiExmczKp5R6xLfk2UGnbnS/ildN2s4jUIbG6Wf+GiU3fJIuz+9+BjT+nUYCLZ1D5qPMWqrb7GcBBiwpW2A1nsEij6Y+M6qFK0qTbDhK9ekXbRnVJzsjeg7SUTNc0yeHds3+FF6LXzQFr43Q/IlVOfOICA2CMsWkYx+gKJfXSu1e+darNKBogcJg57GXYjm4vEUvPOayj0uzRupYM4vuypXvophE/fLAMcklKAjcYNnAmmKnIXXzddYpWFhu37aE3V75ksrY1Q4Lkl6e0zrqYMyNig9o34x8O+8E2BszXODHO/hbRdKPBdxptW0aeJTT6BiR2+nsG3BcHwYw4BfCuPICOzl5UGOMKOQRrTgUoAwDirl2qEwGEe2g7KiXI8rUymb+BY7PAziNYdwH9QvahfD0uGsrQPVN23siOcm7r8GXo65cj4MswByscQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a38ef1-a631-4ec6-26fa-08d87cc9b626
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 11:48:25.3569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2U3ZYbkHLg2nZZNlez7s5Ce8w0d36jl5Za9H9ue1cxryhjW+HV2ICHpvqRLieclmjmsAxdRkC4lqEkHcB0p1EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

I'm not sure I get your point on changing amdgpu_device_has_dc_support() interface by adding new parameter. but it seems to me change input parameter from pdev to adev for nv_is_headless_sku is more straightforward. 

Regards,
Hawking
-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Friday, October 30, 2020 19:32
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

The crash caused by the NULL pointer of
adev->ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),
but this function should not be called on headless SKU.

Fix the mismatch between the return value of
amdgpu_device_has_dc_support() and the real DCN supporting state to avoid calling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().

Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 10 ++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h             |  1 +
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ba65d4f2ab67..f0183271456f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 pcie_index, u32 pcie_data,
 				   u32 reg_addr, u64 reg_data);
 
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, 
+struct pci_dev *pdev);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fe850e0a94d..323ed69032a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
  * @asic_type: AMD asic type
+ * @pdev: pointer to pci_dev instance
  *
  * Check if there is DC (new modesetting infrastructre) support for an asic.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, 
+struct pci_dev *pdev)
 {
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
@@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_VEGA20:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case CHIP_RAVEN:
+		return amdgpu_dc != 0;
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+		if (nv_is_headless_sku(pdev))
+			return false;
+		else
+			return amdgpu_dc != 0;
 	case CHIP_RENOIR:
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
@@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
 		return false;
 
-	return amdgpu_device_asic_has_dc_support(adev->asic_type);
+	return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..97014458d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+	    amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev)) {
 		switch (adev->asic_type) {
 		case CHIP_CARRIZO:
 		case CHIP_STONEY:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4b78ecfd35f7..b23110241267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	bool supports_atomic = false;
 
 	if (!amdgpu_virtual_display &&
-	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) { diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 026e0a8fd526..97446ae75b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_is_headless_sku(struct pci_dev *pdev)
+bool nv_is_headless_sku(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x731E &&
 	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) || diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h index 515d67bf249f..7880ad0073c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -29,6 +29,7 @@
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);  void nv_set_virt_ops(struct amdgpu_device *adev);
+bool nv_is_headless_sku(struct pci_dev *pdev);
 int nv_set_ip_blocks(struct amdgpu_device *adev);  int navi10_reg_base_init(struct amdgpu_device *adev);  int navi14_reg_base_init(struct amdgpu_device *adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
