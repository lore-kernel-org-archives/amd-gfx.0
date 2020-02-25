Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DAC35DF2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C8321556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 06:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HqQrhc0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C8321556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656446E865;
	Tue, 25 Feb 2020 06:44:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970626E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 06:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fErX89wZeT4Qz+B5g2mpGhydgvtiaFFR/PE1weaTRJdlh1xAdmVt/F5NZUgnqbKf/6E57dkJ8cfldnahhSI26We8GNAlm8da6aGtf5+f7iBfZ1x1FjroBQ38W2auM6Y/cqOablScPihyi7cXwbSfhzmLazsj84atUOPA2ioCBMF8a9EDPj+MYN6jD1Ivqbhw2xfuGsq8Z6OCgdb84yacFrM2YhjIyTiv2Dssye0+LgiUtE7b/oOm4Vm7Nc7xggGvh6AiqIZpWgUIowzxW1+iDlAAoQeUycydmWi3LA5t7sVB8HRNspjPLZ1AIIiwCMPGR/W9fXS/xv8BZLTK7VK20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Gm5jQB1domG4Sb307JAamwimEkHh6s6HHo2co5v/w=;
 b=gWVqaRYmMv5L3X5pgS8Ii3gTU+irGFEhQQyg7OYhCcur8Jh+lgVPV/44jXSElmEmYZIV8t6zr3/h2ywUpQANKTTyO6pvSPNIw8PzO69cYaQpf3Zzww35tEVcmy+Xz/lCM+yeLcGbd82p32EUynXKxGy0IkVIeq58cM3JLWZlryHLXqx2rNzm/1GyX6hgwMAUdzLXSonq5V0zCxSoLavJfET/tlKab0H2kaWywyiWsMA3cHXY3upXFrSHdPLXFpnfSntRcLjNoUcyIoYSB/hbcIHjyUo+BrVPZV362ysMDOZLCv7Qlz7XGLsIuH4wUecuae+LCPcrrOm79s+AXvVhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Gm5jQB1domG4Sb307JAamwimEkHh6s6HHo2co5v/w=;
 b=HqQrhc0JwlA+L6Na8EwUFW1/bmNmS/wVJB1KSzifbYtY9/uE88X9jrHIK+MI2/JTuXk68BsWppS+RNu3KpLhFpB1mO7Lt+osz7EOyWjivZw4hIzd94FdWmmFY+AiqC4JCdc8y6l4jAVqmpnNhxlvThQFIokAp/GoOSHPhQYunYw=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 06:44:34 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 06:44:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Index: AQHV6v5SJNrzE/yxTUaNEiX3ys77jqgqMdaggAESdACAAC+mIA==
Date: Tue, 25 Feb 2020 06:44:34 +0000
Message-ID: <DM5PR12MB14180BA2B58EECB3EEA2D7C4FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224103629.9344-1-evan.quan@amd.com>
 <DM5PR12MB14182932E713D06F6462882DFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB33442F892C84D75C2788E659E4ED0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33442F892C84D75C2788E659E4ED0@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T11:34:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b989024a-e732-4bbf-9cb3-00004960a5c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-25T06:44:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 348af8cd-009b-405b-8441-0000f7850caa
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f33f6ac8-f8de-4f33-2a12-08d7b9be2d21
x-ms-traffictypediagnostic: DM5PR12MB1259:|DM5PR12MB1259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB12592345874A00455B75B32EFCED0@DM5PR12MB1259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6506007)(66446008)(66476007)(316002)(53546011)(66556008)(6636002)(54906003)(64756008)(2906002)(66946007)(26005)(7696005)(186003)(15650500001)(76116006)(5660300002)(33656002)(4326008)(9686003)(55016002)(110136005)(8936002)(478600001)(71200400001)(81166006)(52536014)(81156014)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1259;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPw/g5P1HzJa202iKvTBD+B7IvXwEA5aEf0U0jDnYOy9hFA6zOf4PlcfAQJuge2B/ofyNOcZI0p2cejQ6FCcBSd8wQGyyV9Qc+5zIQ7NlmpPRry+IQgPIivjCTuhgPWz499+ECEZZPTlfma3m3EetxQNt0wG3XGI1nvXsTHGQiTXeFEXtedpUHrQxw/45bmUEumGGuhmPWPyb/N46BbfUFyTjpMvne8ES1DZeUDELaZzIOPGGcDN1bdqJhy2kJcgJtj7ZeZssmrp1uRu0WKrmbDD8uhMT1J0/jv+KinJf7lYXzd0WckTOOLlHn7VNFyuJu68lTMl9STMO/TbKPKj+boUV36sd/SwW84976SF/cRJMmMrxL3ygNSIibE1FDctiPV+PpEXUBGFrp8FIphfunfIXdPAJ+0K64TgJr0taTxI59IFpLYw0plK6CLh9jU4
x-ms-exchange-antispam-messagedata: 56xJ8sOvp6mpwh2cYKveeFOdvRM/7NhzJCOEsDICLFIj0AhdxNRj2i6YGL4XUAa+oVjujpu5Atp40+cqLckI8wI69WyuvBpmEISaH3BLXhHU8k9JjUurm7DIAb3m+3SlZEWVPjgVFUo5tt5Tp2/l/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f6ac8-f8de-4f33-2a12-08d7b9be2d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 06:44:34.7437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaBqk16paPG0gkyDnX7All9OYrYOWXh6kJoXBpfL4nmZFKmOg/foxASI91bQGWfl0KJm3Sx9nb8vdkd+ssDWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yes, we are not 100% confident on the sequence of SETUP_VMR command in guest driver, although it indeed happens after PMFW loading in GPUV driver.

I think now the concern was removed now. The current sequence should work in guest driver as well, although they have further discussion on whether removing SETUP_VMR command or not...

Please commit your patch. And thanks for the effort to get this landed and validated on various ASICs.

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Tuesday, February 25, 2020 11:39
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Min, Frank <Frank.Min@amd.com>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

Hi Hawking,

Do you mean SRIOV may need this change also? 
Currently this covers bare-metal case only(SRIOV still follows old firmwares loading sequence).

Regards,
Evan
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, February 24, 2020 7:34 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Min, Frank <Frank.Min@amd.com>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

[AMD Official Use Only - Internal Distribution Only]

The patch looks good for bare-metal case now. Frank is still on the way to clean up our concern on SETUP_VMR command (i.e. SETUP_TMR for bare-metal case). After that settled, please push the patch with my RB. Thanks.

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 18:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

V2: skip possible SMU firmware reloading

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 65 ++++++++++++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..d33f74100094 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,39 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+/*
+ * Due to DF Cstate management centralized to PMFW, the firmware
+ * loading sequence will be updated as below:
+ *   - Load KDB
+ *   - Load SYS_DRV
+ *   - Load tOS
+ *   - Load PMFW
+ *   - Setup TMR
+ *   - Load other non-psp fw
+ *   - Load ASD
+ *   - Load XGMI/RAS/HDCP/DTM TA if any
+ *
+ * This new sequence is required for
+ *   - Arcturus
+ *   - Navi12 and onwards
+ */
+static void psp_check_pmfw_centralized_cstate_management(struct 
+psp_context *psp) {
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->pmfw_centralized_cstate_management = false;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type >= CHIP_NAVI12))
+		psp->pmfw_centralized_cstate_management = true; }
+
 static int psp_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -75,6 +108,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	psp_check_pmfw_centralized_cstate_management(psp);
+
 	return 0;
 }
 
@@ -1116,10 +1151,17 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
-		return ret;
+	/*
+	 * For those ASICs with DF Cstate management centralized
+	 * to PMFW, TMR setup should be performed after PMFW
+	 * loaded and before other non-psp firmware loaded.
+	 */
+	if (!psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1316,7 +1358,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device* adev = psp->adev;
 
-	if (psp->autoload_supported) {
+	if (psp->autoload_supported ||
+	    psp->pmfw_centralized_cstate_management) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
@@ -1326,6 +1369,14 @@ static int psp_np_fw_load(struct psp_context *psp)
 			return ret;
 	}
 
+	if (psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
+	}
+
 out:
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
@@ -1333,7 +1384,9 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
-		    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
+		    (psp_smu_reload_quirk(psp) ||
+		     psp->autoload_supported ||
+		     psp->pmfw_centralized_cstate_management))
 			continue;
 
 		if (amdgpu_sriov_vf(adev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c77e1abb538a..37fa184f27f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -264,6 +264,8 @@ struct psp_context
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether df cstate management centralized to PMFW */
+	bool				pmfw_centralized_cstate_management;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
--
2.25.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
