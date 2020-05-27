Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2FFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 02:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E442075F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 02:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zl6mDJSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E442075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566C46E27F;
	Wed, 27 May 2020 02:19:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AA06E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 02:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwSHs9Kof2BovhJrDM3UEwCePF8R4eCx9sMM4lBJH2y5HkXBYy2R6BOh+OOJ7fFlyo1Wsg8z1Equ28xNphFqUBsd87WP9dEO7UqQpRf3TFpdgFlOE+wZZlByHXF/5rQczohIIqPHahgWt2rTwaVelJfc+Xd2uAJN7R3rGrkYkQgtLBOXnfVDzK4FBQsCujBuKso3zu8YWfpUO/6UlrRvdy0l7KAdZEjg4X5MIWrV9Tpb+wv90ggDqfg2Tc7W/ke2qcT8YucnnJmK29q79iibFIeEYbRLreQfU5wkiHyYVdUOeuK/ylTuh5lzein7w9sEiE8Ei5Ssunznw9jDpOJtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6vHi0VuCRJPoRXaBK9NiteT6G9hNur5NdnwmZcGNI4=;
 b=AFZ6ipz/J8gX7a6fgyTKjNynmZ6ScH6VMGMUPOpfUwv48WbL9d5/Uwj7Vcx+00U2pFaQYuWLFVelKfc9COillFVr7FYFlkP7x+zo8U4Q1MVo2yvVNDokdkaRb73VOvFdieRxrrW1IcStnx7lq0GYbSL5RyXhkZ3PYtAgX5kZLKMCsnhdDM/OYpkJqipkHqz4ySVk3/6AVLvrhZLMeq86ouyEoCXCf4tDShIxOBa4O9QOqQzURgtvyXc3uNBfB9FU4g0PzSNfWNnChS1pxL52t5APm0QvROUrF6eE0z8Ab0Qe5PeiVplFhVyh/ZT9zo6HBBHfuOWYTnoE4N9UjxM+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6vHi0VuCRJPoRXaBK9NiteT6G9hNur5NdnwmZcGNI4=;
 b=zl6mDJSQ4sHHMmntlw3ir6zN+nD8Lcb/sPXoNfxV1EuGYOT1lfjjBu2s8wnYzIZ+WDcVS9fg5n0XcqKc+jzUZChSaVEsm3kwRl3z49/zzCBIxEy4o2x0aD9llIIcN/+xCXqeHYs0eRN4WOeBG2pnxlENcXoyUxB1YkriW4n9PCo=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 02:19:24 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 02:19:24 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11
Thread-Topic: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11
Thread-Index: AQHWM0VCzfuVKLVRG0Kl+yPymMpYvai6Oe+AgAD5SSA=
Date: Wed, 27 May 2020 02:19:24 +0000
Message-ID: <CH2PR12MB4101BA91C71DBFC9DAA8F7E38CB10@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
 <20200526100543.5844-3-Wenhui.Sheng@amd.com>
 <DM6PR12MB2619728FB6EE9724F7AF4A2AE4B00@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619728FB6EE9724F7AF4A2AE4B00@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=44c14cd2-3f9a-4400-8086-0000c8538451;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-26T11:21:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-27T02:19:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05002259-d97f-4eee-969c-00001930f2b9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d93c0d1-cfba-454b-ee1d-08d801e45fc1
x-ms-traffictypediagnostic: CH2PR12MB4038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4038939D7F168D936C4EEDD08CB10@CH2PR12MB4038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:63;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHDPDcRfbe4/m8e4jXXFDmMKu4DzVfK3B2qXMI6N/J3YJZVLYposNL1To49BxM+97JA7LwfWGZTBqV0yXx01Nz96BlzlgIfUWFK5lFyDLu+f5cxzYMt3f5bLgvepQpPBpppyMucE0rXHXEVeYaU4aJAkhBoFMhAq6JVi2K0hSSySKFVwY44gRtKqoG1kDnm90KIww6oYK+yuerj4ArQWcY5cCkyZSdD080DNmFxTLb9XUkRX1cqbwnQlZ3yzwN4yyMKKj11NH+ZpWJOSYpep8X38Ihr8FycBZ6iVc7b712iG4Qys0LteKL6BKZqxcTAeSr8ZWPvrJrIOpt+xCocTGjlByKejyMFmyN6jT9+otHA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(9686003)(316002)(55016002)(33656002)(6636002)(5660300002)(8936002)(19627235002)(52536014)(86362001)(4326008)(8676002)(54906003)(966005)(30864003)(53546011)(6506007)(66574014)(6862004)(26005)(186003)(71200400001)(7696005)(45080400002)(66446008)(64756008)(76116006)(66556008)(478600001)(66476007)(2906002)(66946007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JRYUNtqBCW3NiWzq6ae2vtX4C3AoETDSg6IdQENCGtcgkFm1TvtNIbKxVFl4oOM5kvWn3Orovdh6afKC4qeaXTWBBKhsGe7zrB9rDFzA038ntQRyBL5n2pA5TOL3byE86P9pJbNoEh4DSCGvl6TLnIB2A6SPGVXKriyFwqG6U7OQw3Y24s224rr4b3gvLNl9DpSvamHtj6lhANPgt5r0OijpGM0uaIIGpPDWCybC/+iAIaH+pC3Kck6+4bNcBhHyjQuDyvn3GEU6CSk7KvhOx3rpmZj4vDr3zUVEB1hFaA7WLiHqvY9B0R0h6m88PhL7xcJ3m16rns0vssWz5TnzqHpqjRTiEPLzICLF1/POv43HVVBs6yf7x66BK9iFaKTx0U5eP2WJMHTPU8S4xT4ETlYhGxxcsZI9F3PnaN4UQXadqQnOBv0v4g+ZtE+5VuxV6CP7dG1AK3ukXLA08CuuMTvY7E69ojP9/QqvgBh5MaJbCbxBXY/Z9JVNCp1aTjFJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d93c0d1-cfba-454b-ee1d-08d801e45fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 02:19:24.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCCe9TcVjmVzhh+houPCQvSVCDjkvSm2lOHjhzhG0AC1Fw3GU2mJ0M6yeweozD6JZfBQDAWINhn04UH+tyoqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Hi Evan,

With Kevin's previous patch, we will not create sysfs node pp_power_profile_mode under VF mode.

Brs
Wenhui

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, May 26, 2020 7:25 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11

[AMD Official Use Only - Internal Distribution Only]

Please confirm the changes of arcturus_get_power_profile_mode() do not break SRIOV.
Since this seems skipped before but enabled now.
Other than that, the series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Tuesday, May 26, 2020 6:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11

We don't need SRIOV check after we enable SMC msg filter in SMU11

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Change-Id: I14e1dc5669cb4bb2c112bc100d699bfb380574b3
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 159 +++++++++----------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |   6 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   |   6 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    |  24 ---
 4 files changed, 80 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f7428996cc74..1e9be1dcc62b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -563,10 +563,8 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int

 bool is_support_sw_smu(struct amdgpu_device *adev)  { -if (adev->asic_type >= CHIP_ARCTURUS) {
-      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
-return true;
-}
+if (adev->asic_type >= CHIP_ARCTURUS)
+return true;

 return false;
 }
@@ -1109,59 +1107,58 @@ static int smu_smc_table_hw_init(struct smu_context *smu,  return ret;

 /* smu_dump_pptable(smu); */
-if (!amdgpu_sriov_vf(adev)) {
-/*
- * Copy pptable bo in the vram to smc with SMU MSGs such as
- * SetDriverDramAddr and TransferTableDram2Smu.
- */
-ret = smu_write_pptable(smu);
-if (ret)
-return ret;
-
-/* issue Run*Btc msg */
-ret = smu_run_btc(smu);
-if (ret)
-return ret;
-ret = smu_feature_set_allowed_mask(smu);
-if (ret)
-return ret;
+/*
+ * Copy pptable bo in the vram to smc with SMU MSGs such as
+ * SetDriverDramAddr and TransferTableDram2Smu.
+ */
+ret = smu_write_pptable(smu);
+if (ret)
+return ret;

-ret = smu_system_features_control(smu, true); -if (ret) -return ret;
+/* issue Run*Btc msg */
+ret = smu_run_btc(smu);
+if (ret)
+return ret;
+ret = smu_feature_set_allowed_mask(smu);
+if (ret)
+return ret;

-if (adev->asic_type == CHIP_NAVI10) {
-if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
-      adev->pdev->revision == 0xc3 ||
-      adev->pdev->revision == 0xca ||
-      adev->pdev->revision == 0xcb)) ||
-    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
-      adev->pdev->revision == 0xf4 ||
-      adev->pdev->revision == 0xf5 ||
-      adev->pdev->revision == 0xf6))) {
-ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-if (ret) {
-pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n"); -return ret; -} -} -}
+ret = smu_system_features_control(smu, true); if (ret) return ret;

-if (smu->ppt_funcs->set_power_source) {
-/*
- * For Navi1X, manually switch it to AC mode as PMFW
- * may boot it with DC mode.
- */
-if (adev->pm.ac_power)
-ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC); -else -ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+if (adev->asic_type == CHIP_NAVI10) {
+if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+      adev->pdev->revision == 0xc3 ||
+      adev->pdev->revision == 0xca ||
+      adev->pdev->revision == 0xcb)) ||
+    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+      adev->pdev->revision == 0xf4 ||
+      adev->pdev->revision == 0xf5 ||
+      adev->pdev->revision == 0xf6))) { ret =
+smu_disable_umc_cdr_12gbps_workaround(smu);
 if (ret) {
-pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+pr_err("Workaround failed to disable UMC CDR feature on 12Gbps
+SKU!\n");
 return ret;
 }
 }
 }
+
+if (smu->ppt_funcs->set_power_source) {
+/*
+ * For Navi1X, manually switch it to AC mode as PMFW
+ * may boot it with DC mode.
+ */
+if (adev->pm.ac_power)
+ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC); else ret =
+smu_set_power_source(smu, SMU_POWER_SOURCE_DC); if (ret) {
+pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" :
+"DC"); return ret; } }
+
 if (adev->asic_type != CHIP_ARCTURUS) {  ret = smu_notify_display_change(smu);  if (ret) @@ -1214,9 +1211,8 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 /*
  * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
  */
-if (!amdgpu_sriov_vf(adev)) {
-ret = smu_set_tool_table_location(smu); -}
+ret = smu_set_tool_table_location(smu);
+
 if (!smu_is_dpm_running(smu))
 pr_info("dpm has been disabled\n");

@@ -1376,9 +1372,6 @@ static int smu_hw_init(void *handle)

 static int smu_stop_dpms(struct smu_context *smu)  { -if (amdgpu_sriov_vf(smu->adev)) -return 0;
-
 return smu_system_features_control(smu, false);  }

@@ -1403,35 +1396,35 @@ static int smu_hw_fini(void *handle)

 adev->pm.dpm_enabled = false;

-if (!amdgpu_sriov_vf(adev)){
+if (!amdgpu_sriov_vf(adev)) {
 smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+}
+
+ret = smu_stop_thermal_control(smu);
+if (ret) {
+pr_warn("Fail to stop thermal control!\n"); return ret; }

-ret = smu_stop_thermal_control(smu);
+/*
+ * For custom pptable uploading, skip the DPM features
+ * disable process on Navi1x ASICs.
+ *   - As the gfx related features are under control of
+ *     RLC on those ASICs. RLC reinitialization will be
+ *     needed to reenable them. That will cost much more
+ *     efforts.
+ *
+ *   - SMU firmware can handle the DPM reenablement
+ *     properly.
+ */
+if (!smu->uploading_custom_pp_table ||
+!((adev->asic_type >= CHIP_NAVI10) &&
+(adev->asic_type <= CHIP_NAVI12))) {
+ret = smu_stop_dpms(smu);
 if (ret) {
-pr_warn("Fail to stop thermal control!\n");
+pr_warn("Fail to stop Dpms!\n");
 return ret;
 }
-
-/*
- * For custom pptable uploading, skip the DPM features
- * disable process on Navi1x ASICs.
- *   - As the gfx related features are under control of
- *     RLC on those ASICs. RLC reinitialization will be
- *     needed to reenable them. That will cost much more
- *     efforts.
- *
- *   - SMU firmware can handle the DPM reenablement
- *     properly.
- */
-if (!smu->uploading_custom_pp_table ||
-!((adev->asic_type >= CHIP_NAVI10) &&
-(adev->asic_type <= CHIP_NAVI12))) {
-ret = smu_stop_dpms(smu);
-if (ret) {
-pr_warn("Fail to stop Dpms!\n");
-return ret;
-}
-}
 }

 kfree(table_context->driver_pptable);
@@ -1548,12 +1541,12 @@ static int smu_suspend(void *handle)

 if (!amdgpu_sriov_vf(adev)) {
 smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-ret = smu_disable_dpm(smu);
-if (ret)
-return ret;
 }

+ret = smu_disable_dpm(smu);
+if (ret)
+return ret;
+
 smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);

 if (adev->asic_type >= CHIP_NAVI10 &&
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index dcbb273674d1..70cc1c12f196 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1369,7 +1369,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,  if (result)  return result;

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
+if (smu_version >= 0x360d00)
 size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",  title[0], title[1], title[2], title[3], title[4], title[5],  title[6], title[7], title[8], title[9], title[10]); @@ -1386,7 +1386,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,  if (workload_type < 0)  continue;

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+if (smu_version >= 0x360d00) {
 result = smu_update_table(smu,
   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
   workload_type,
@@ -1401,7 +1401,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,  size += sprintf(buf + size, "%2d %14s%s\n",  i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+if (smu_version >= 0x360d00) {
 size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",  " ",  0, diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 5f7373e86d90..ef4952afb365 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1818,8 +1818,7 @@ static int navi10_get_power_limit(struct smu_context *smu,  int power_src;

 if (!smu->power_limit) {
-if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
-!amdgpu_sriov_vf(smu->adev)) {
+if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);  if (power_src < 0)  return -EINVAL; @@ -1962,9 +1961,6 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali  OverDriveTable_t *od_table, *boot_od_table;  int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));  if (ret)  return ret; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 906bc7f2e686..3af439a77876 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -768,9 +768,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)  {  int ret;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 ret = smu_send_smc_msg_with_param(smu,
   SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);  if (ret) @@ -814,9 +811,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)  int ret = 0;  struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (tool_table->mc_address) {
 ret = smu_send_smc_msg_with_param(smu,
 SMU_MSG_SetToolsDramAddrHigh,
@@ -836,9 +830,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)  {  int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (!smu->pm_enabled)
 return ret;

@@ -853,9 +844,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)  int ret = 0;  uint32_t feature_mask[2];

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 mutex_lock(&feature->mutex);
 if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)  goto failed; @@ -884,9 +872,6 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,  struct smu_feature *feature = &smu->smu_feature;  int ret = 0;

-if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
-return 0;
-
 if (!feature_mask || num < 2)
 return -EINVAL;

@@ -942,9 +927,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)  {  int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (!smu->pm_enabled)
 return ret;

@@ -1107,9 +1089,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)  int ret = 0;  uint32_t max_power_limit;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 max_power_limit = smu_v11_0_get_max_power_limit(smu);

 if (n > max_power_limit) {
@@ -1860,9 +1839,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)  uint32_t pcie_gen = 0, pcie_width = 0;  int ret;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 pcie_gen = 3;
 else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C1cec0ad4526347481e9708d8015c67be%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637260843725484475&amp;sdata=EXruuZmiUCQdu824UO8eLcg1WEbJVwghYChj2lAK%2FqI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
