Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC72C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 11:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7BA2053B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zeH6bW85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7BA2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF9689E0C;
	Tue, 26 May 2020 11:24:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D6C89E0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 11:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRJc92v4hS/VDGtn7y5mERrkpoFXeEEwxQ/NeMOzxmwVGMP4r3gWFTkZNNvuiGzpFLwTfrA52P4CLyK1QHpb5emlwoCXTkpJQt4q/UCkxSIkv7ZvAgIrXfXQ0r9mkcygPiAo4IWML7D58BvoUf0umUfbEN+qnCETuUNvx2RUAhjgQ+uVq0IqPCpfHjaKU/JjhWcb+UdSzR8V4jzAJ060cqyWE4ey+/swdJMVmGpyJAFaa/q7LiQzclRyfZNLreu1kopRBxyaQQhdIOtP1GRLcc8iSP5a9KEfasYC0Ac+9G+4gQyPgGAmyTDeFbhMNWG9haHgH/Ys+1T8T5QCVPcLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syovr+ItY9OKEdbKCjRWDxvSoZiMx2GNBUg9teeQ9Ig=;
 b=UlFyK2MWf26XqPZpl4f0nTxojkbzB3WK2GR6vXElUtYYkCh1CFaYtEmJ/0xL1MTzhd+CUBrDR4xYRRjaNMfyg7qBcjZq0Icrqa44gAO9da5RgwtUSz36teq69Ph04Y0XBi51/pihH9XF48mPOXFEIS+GFjvsRI7zE4VleSSXdE4EmVmh0lNKAIb/Uty4zJTYQWU9/YuRMmxL5vMUN0+FJTfFbo8ri1E+7/rywyBCa9kwYYzKSzJzonXa9I5EnnkuIvw12RHVBteR06e4oOytHvbgjBIcVrhtDafTPxQfyheCyXFjll09ugRhZk3ESaJbu/y4HpvOq7nQz24foWF5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syovr+ItY9OKEdbKCjRWDxvSoZiMx2GNBUg9teeQ9Ig=;
 b=zeH6bW85pLS4vAvSrq4ZE5OB1Yrqcb/8LTXTvz222yRUfY4mUFNBm74RbvXlkalmu0rqoD8h4xcEoCVCLvzDQAoUasqOnjUG6OptfT+9s1jOAq73KAEn+Z5vzypeMYxnoISl7hte2TiKXoMYSkOeXJzNRcRUnUd22QN8dSqawCc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Tue, 26 May 2020 11:24:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 11:24:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11
Thread-Topic: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11
Thread-Index: AQHWM0VJB5xEyG5QXEmBSUnXpOPFZai6OSdw
Date: Tue, 26 May 2020 11:24:37 +0000
Message-ID: <DM6PR12MB2619728FB6EE9724F7AF4A2AE4B00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
 <20200526100543.5844-3-Wenhui.Sheng@amd.com>
In-Reply-To: <20200526100543.5844-3-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3ebcf88-b80a-4fa1-0eb8-08d801676095
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29884DE8AC3BCC5729B08A0EE4B00@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:63;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWRqH846caRyBbGPq2ZGmn3CSrRaykOwnsS2xXj3TnAG9DUevsPg2wgTIywNzNzGICd4aD7bjbTS+KLYG+yVl/NoL9Vf0ae6kInJvt3lRaQyoE7wVYFdtbrhk3NE3s5kVJg4sGeAs8+eO72oLdHKxDgGF5wfBfmsU5HjVAZLAbGfBw5a0+Cq2UwzO77JyYIlUYw64GudwqOMuxfgcmW8XVr4HkTGRbR/xsrNiu5A0p1exaxCTXIJMQwyQecpU2k+/2caWg0lpxgp+vJPfXUt9syPpgsj34wfV7k38JTXXfS5raz+alA1DOyUWQF6C+RZBFjJdDgbWYxMmYakWbqm5DB9HlAKW4lX1+OZKg52iNI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(316002)(9686003)(33656002)(55016002)(86362001)(5660300002)(54906003)(110136005)(8676002)(52536014)(4326008)(19627235002)(8936002)(966005)(6506007)(66574014)(53546011)(26005)(186003)(71200400001)(478600001)(45080400002)(66446008)(64756008)(76116006)(30864003)(7696005)(2906002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Cexic7iXO04NElTSoL8OcaBtlDPeZnoUsauZc1m6tOYRzOc5Fk+xLDgQj7/s5Lvmu7oNV3Y/469AK/fUJ3qLrIVQi8YxmpLw97TcPwVemxb9K3ViuvdRmaxJ0MgYls7bjC5Zx1dfC5viF4JJt6ebdyd7C0htgJ2KxqacWcYA1FK3O1/dU2ylow4ujPD2gRwvYBkK2oyUOla60vprfFrB4dGvGcciEI39pOmgaCiplYlivrrihgkmF4PqOq+TJuzdtkYz5t+OAiLM2TY3XUtIBEsK+Zv1LXOtJCK/UbJ3WtalhnFjEmG84SYCtmZUc76aEHDAUBncQ3zjc0f3NZl92YjAtyvCDpalaIjLkmnhdU+mR4VOlbdyt89LaZKsup3rZE6yYkKx+yakAAXUR95VUrt4maYzacEQ0UJbZjFZZ+fn7JV9Ge4xQDxE6RlbbHxPR1xkpkCORNGMSotNDcXma6ysjUPP53pghNiVA8/OnuI0LdR8dQnzwqe56QuQEG+t
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ebcf88-b80a-4fa1-0eb8-08d801676095
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 11:24:38.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpyVhrBXha7AxNAM3QmgIOBASpbCf64q0Ig0ElnWWnZ/tu3Nt3Nb4OeW6FwSJSN1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

 bool is_support_sw_smu(struct amdgpu_device *adev)  {
-if (adev->asic_type >= CHIP_ARCTURUS) {
-      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
-return true;
-}
+if (adev->asic_type >= CHIP_ARCTURUS)
+return true;

 return false;
 }
@@ -1109,59 +1107,58 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 return ret;

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

-ret = smu_system_features_control(smu, true);
-if (ret)
-return ret;
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
-pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-return ret;
-}
-}
-}
+ret = smu_system_features_control(smu, true);
+if (ret)
+return ret;

-if (smu->ppt_funcs->set_power_source) {
-/*
- * For Navi1X, manually switch it to AC mode as PMFW
- * may boot it with DC mode.
- */
-if (adev->pm.ac_power)
-ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-else
-ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+if (adev->asic_type == CHIP_NAVI10) {
+if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+      adev->pdev->revision == 0xc3 ||
+      adev->pdev->revision == 0xca ||
+      adev->pdev->revision == 0xcb)) ||
+    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+      adev->pdev->revision == 0xf4 ||
+      adev->pdev->revision == 0xf5 ||
+      adev->pdev->revision == 0xf6))) {
+ret = smu_disable_umc_cdr_12gbps_workaround(smu);
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
+ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+else
+ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+if (ret) {
+pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+return ret;
+}
+}
+
 if (adev->asic_type != CHIP_ARCTURUS) {
 ret = smu_notify_display_change(smu);
 if (ret)
@@ -1214,9 +1211,8 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 /*
  * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
  */
-if (!amdgpu_sriov_vf(adev)) {
-ret = smu_set_tool_table_location(smu);
-}
+ret = smu_set_tool_table_location(smu);
+
 if (!smu_is_dpm_running(smu))
 pr_info("dpm has been disabled\n");

@@ -1376,9 +1372,6 @@ static int smu_hw_init(void *handle)

 static int smu_stop_dpms(struct smu_context *smu)  {
-if (amdgpu_sriov_vf(smu->adev))
-return 0;
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
+pr_warn("Fail to stop thermal control!\n");
+return ret;
+}

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
@@ -1369,7 +1369,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 if (result)
 return result;

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
+if (smu_version >= 0x360d00)
 size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 title[0], title[1], title[2], title[3], title[4], title[5],
 title[6], title[7], title[8], title[9], title[10]); @@ -1386,7 +1386,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 if (workload_type < 0)
 continue;

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+if (smu_version >= 0x360d00) {
 result = smu_update_table(smu,
   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
   workload_type,
@@ -1401,7 +1401,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 size += sprintf(buf + size, "%2d %14s%s\n",
 i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");

-if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+if (smu_version >= 0x360d00) {
 size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 " ",
 0,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 5f7373e86d90..ef4952afb365 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1818,8 +1818,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 int power_src;

 if (!smu->power_limit) {
-if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
-!amdgpu_sriov_vf(smu->adev)) {
+if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
 if (power_src < 0)
 return -EINVAL;
@@ -1962,9 +1961,6 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 OverDriveTable_t *od_table, *boot_od_table;
 int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
 if (ret)
 return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 906bc7f2e686..3af439a77876 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -768,9 +768,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)  {
 int ret;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 ret = smu_send_smc_msg_with_param(smu,
   SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 if (ret)
@@ -814,9 +811,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 int ret = 0;
 struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (tool_table->mc_address) {
 ret = smu_send_smc_msg_with_param(smu,
 SMU_MSG_SetToolsDramAddrHigh,
@@ -836,9 +830,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)  {
 int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (!smu->pm_enabled)
 return ret;

@@ -853,9 +844,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int ret = 0;
 uint32_t feature_mask[2];

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 mutex_lock(&feature->mutex);
 if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 goto failed;
@@ -884,9 +872,6 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 struct smu_feature *feature = &smu->smu_feature;
 int ret = 0;

-if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
-return 0;
-
 if (!feature_mask || num < 2)
 return -EINVAL;

@@ -942,9 +927,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)  {
 int ret = 0;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 if (!smu->pm_enabled)
 return ret;

@@ -1107,9 +1089,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 int ret = 0;
 uint32_t max_power_limit;

-if (amdgpu_sriov_vf(smu->adev))
-return 0;
-
 max_power_limit = smu_v11_0_get_max_power_limit(smu);

 if (n > max_power_limit) {
@@ -1860,9 +1839,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 uint32_t pcie_gen = 0, pcie_width = 0;
 int ret;

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
