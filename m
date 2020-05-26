Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F465C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AEB2068D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="irNbBTdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AEB2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3840A6E144;
	Tue, 26 May 2020 10:06:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B547F6E13C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGDemgBGQl9P4piQtU58GZTIphSN3yyn+9DtaRI8uPr1q8utlRiRcZSHGQPBhfcwiknEQQErcarhOw0zP2pxahDFs4pxgqYlrLs6M6G9Y0Dx2SukZ55u3u+BglRnjM4fkOJpMVT5C41fJh0pcfqY2QxNwcKspeMA5mJc9n/ceuw3SXxndtkFtdHKBQ7KWI2MzvlYyY8FbsAbuAWjJAQtlGhZlXLmWCep9369wIDDMgGZrf/VqzmBFc1m8DCv4MrBTocMRy2xRb5HL7ipOD0fea/9gDW1X9Oylpbk/4n2FckEaPjoAeGtR857gWuX0PUDDvlItk/xPPx3Yxv0xq6B3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1XDgujwEz4jYSCANvBmLwcoy5ka0Eb48TB2UlmYoJk=;
 b=IqEN8A3MsFPlzsiVNFBjxWOvh0sIBcdQ4ovpmxwCBb7ivreNxczSWCpK16gzf1P5fRXl8hS8YKSlL01lsq9yvRLvopsqL6s66XtZTPBhhf+GtWW7wnhev976W0DThGJx9IZQPgKKFZtFBXnf+dLw/H82vsdYF6kktyJHimZNPQnQDQHfEi6Dyuk3An5hVCGat7idVNfjhskWDTxAt03DyHxmnMbBweTffh/0uxzTVr39kii7XAYE/+lf7zL4AKPjiulrWPNUdkKgy6yerZ/xwZAKsqEYJnaRIRRbemt1CMRXYWvkgbi2ysfVJvLwxmwBuGM+znOxPayzQQ2auYaY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1XDgujwEz4jYSCANvBmLwcoy5ka0Eb48TB2UlmYoJk=;
 b=irNbBTdocw49U29UfVaiG894eD2BjgxzjhwabmIbfcDDX4E+fGd7MIJ3zQ5Ziw820ep5brFrW5OuhadBTLdOkerlF/1s2OVhDsQAFvcZvQWGTaEBVqxO0tC6EL62AjfWmL2HijwZYUXoHO1/ApFsgN/hM9CtvdNbArM+RyUH/S4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 10:06:01 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:06:01 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: remove SRIOV check in SMU11
Date: Tue, 26 May 2020 18:05:42 +0800
Message-Id: <20200526100543.5844-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 10:05:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40c616eb-926a-41fe-4e16-08d8015c64a4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3958E7A6C0238EC47D909E5D8CB00@CH2PR12MB3958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtKV30jXnaNboBO15WbtLAeM76UDSXXdK7/IopE0TaF3clDeE6weLdUExvHrbYzH0nJpkbXv+8n1ZSOKuGn2e+fE+ZAk4ae95Un3qOpWdrzn2oTBzEOnFlboMELzxkH/UADpE8B6M+KctQrursZBEpK1rWsjHF/9MBeWdW2lSanyXvH0CX2hU9eTZaB65UiABz1g5K+Zdf5T9aoOcv08t1KjknEEM/0HaDECfbYZ8BAcyyFbaNrT1M1WAj0shrR46utnAk3VXEFHGl15KaoWSIL371T/Ex+r+pdLHrMNLwEoq1CUvOreH+WKqcMBC6zTbaNdeUxSJcR4IPSRPwdxeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(30864003)(36756003)(16526019)(186003)(2906002)(5660300002)(86362001)(8936002)(8676002)(6916009)(2616005)(316002)(4326008)(956004)(26005)(66946007)(54906003)(7696005)(478600001)(6666004)(1076003)(6486002)(19627235002)(66574014)(66556008)(66476007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rOQQrB/mfq0hZ9zzjwlMWC4DWcUIOuzQG2io6RuBn/OaGe3QOrBmayccuuKaVG7o46nQ6tb4E25OhA1LZoGRNxadch9rZ6YOAxRhE+vkQk4GWH4zPvxet41xhhfhdqvYIMPS+D88rjAT/gryP9qE4VOGUlTmwNhb0atzMfm7Wfblw+jmffWQzVs0nnwwGU435p1MAk1hgk9hEkIJQPoL68GORfRo3zcW3i/lzWuCJEMPRvgOdhW3i6v0D3G5y0jf30e98FQN91hSsgSiytBAtM5F66QyAi2waVWqWYltb1w02hh7XF0REeQZ9iGwbnnwIbfxo/I7SQbnT4XboKvbND2oirvUM7xiJvyDKYRsYngTLGThF9PimGUkXd43+k31o9ZUbxvR3+xp8EJLqEGvj7opC+RqDcencaRQ1zLkQ+0xitGYuhuIgfPSF4PQdcuhwfiwgslgm5cbXAushS4WexQl5WkbJ8wzRlsbc8Vqba4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c616eb-926a-41fe-4e16-08d8015c64a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 10:06:01.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6nVpcAFIjiXihQDLd5FxVVLjhTEvhLRwU3EE3dCqX3snC/A+ftHXYgGvCAnxaPUtbxvXqj+b9akJDsXa8mvMg==
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
 
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
-	if (adev->asic_type >= CHIP_ARCTURUS) {
-	      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
-			return true;
-	}
+	if (adev->asic_type >= CHIP_ARCTURUS)
+		return true;
 
 	return false;
 }
@@ -1109,59 +1107,58 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return ret;
 
 	/* smu_dump_pptable(smu); */
-	if (!amdgpu_sriov_vf(adev)) {
-		/*
-		 * Copy pptable bo in the vram to smc with SMU MSGs such as
-		 * SetDriverDramAddr and TransferTableDram2Smu.
-		 */
-		ret = smu_write_pptable(smu);
-		if (ret)
-			return ret;
-
-		/* issue Run*Btc msg */
-		ret = smu_run_btc(smu);
-		if (ret)
-			return ret;
-		ret = smu_feature_set_allowed_mask(smu);
-		if (ret)
-			return ret;
+	/*
+	 * Copy pptable bo in the vram to smc with SMU MSGs such as
+	 * SetDriverDramAddr and TransferTableDram2Smu.
+	 */
+	ret = smu_write_pptable(smu);
+	if (ret)
+		return ret;
 
-		ret = smu_system_features_control(smu, true);
-		if (ret)
-			return ret;
+	/* issue Run*Btc msg */
+	ret = smu_run_btc(smu);
+	if (ret)
+		return ret;
+	ret = smu_feature_set_allowed_mask(smu);
+	if (ret)
+		return ret;
 
-		if (adev->asic_type == CHIP_NAVI10) {
-			if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
-							      adev->pdev->revision == 0xc3 ||
-							      adev->pdev->revision == 0xca ||
-							      adev->pdev->revision == 0xcb)) ||
-			    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
-							      adev->pdev->revision == 0xf4 ||
-							      adev->pdev->revision == 0xf5 ||
-							      adev->pdev->revision == 0xf6))) {
-				ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-				if (ret) {
-					pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-					return ret;
-				}
-			}
-		}
+	ret = smu_system_features_control(smu, true);
+	if (ret)
+		return ret;
 
-		if (smu->ppt_funcs->set_power_source) {
-			/*
-			 * For Navi1X, manually switch it to AC mode as PMFW
-			 * may boot it with DC mode.
-			 */
-			if (adev->pm.ac_power)
-				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-			else
-				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+	if (adev->asic_type == CHIP_NAVI10) {
+		if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+						      adev->pdev->revision == 0xc3 ||
+						      adev->pdev->revision == 0xca ||
+						      adev->pdev->revision == 0xcb)) ||
+		    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+						      adev->pdev->revision == 0xf4 ||
+						      adev->pdev->revision == 0xf5 ||
+						      adev->pdev->revision == 0xf6))) {
+			ret = smu_disable_umc_cdr_12gbps_workaround(smu);
 			if (ret) {
-				pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+				pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
 				return ret;
 			}
 		}
 	}
+
+	if (smu->ppt_funcs->set_power_source) {
+		/*
+		 * For Navi1X, manually switch it to AC mode as PMFW
+		 * may boot it with DC mode.
+		 */
+		if (adev->pm.ac_power)
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+		else
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+		if (ret) {
+			pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
@@ -1214,9 +1211,8 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = smu_set_tool_table_location(smu);
-	}
+	ret = smu_set_tool_table_location(smu);
+
 	if (!smu_is_dpm_running(smu))
 		pr_info("dpm has been disabled\n");
 
@@ -1376,9 +1372,6 @@ static int smu_hw_init(void *handle)
 
 static int smu_stop_dpms(struct smu_context *smu)
 {
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	return smu_system_features_control(smu, false);
 }
 
@@ -1403,35 +1396,35 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	if (!amdgpu_sriov_vf(adev)){
+	if (!amdgpu_sriov_vf(adev)) {
 		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+	}
+
+	ret = smu_stop_thermal_control(smu);
+	if (ret) {
+		pr_warn("Fail to stop thermal control!\n");
+		return ret;
+	}
 
-		ret = smu_stop_thermal_control(smu);
+	/*
+	 * For custom pptable uploading, skip the DPM features
+	 * disable process on Navi1x ASICs.
+	 *   - As the gfx related features are under control of
+	 *     RLC on those ASICs. RLC reinitialization will be
+	 *     needed to reenable them. That will cost much more
+	 *     efforts.
+	 *
+	 *   - SMU firmware can handle the DPM reenablement
+	 *     properly.
+	 */
+	if (!smu->uploading_custom_pp_table ||
+			!((adev->asic_type >= CHIP_NAVI10) &&
+				(adev->asic_type <= CHIP_NAVI12))) {
+		ret = smu_stop_dpms(smu);
 		if (ret) {
-			pr_warn("Fail to stop thermal control!\n");
+			pr_warn("Fail to stop Dpms!\n");
 			return ret;
 		}
-
-		/*
-		 * For custom pptable uploading, skip the DPM features
-		 * disable process on Navi1x ASICs.
-		 *   - As the gfx related features are under control of
-		 *     RLC on those ASICs. RLC reinitialization will be
-		 *     needed to reenable them. That will cost much more
-		 *     efforts.
-		 *
-		 *   - SMU firmware can handle the DPM reenablement
-		 *     properly.
-		 */
-		if (!smu->uploading_custom_pp_table ||
-				!((adev->asic_type >= CHIP_NAVI10) &&
-					(adev->asic_type <= CHIP_NAVI12))) {
-			ret = smu_stop_dpms(smu);
-			if (ret) {
-				pr_warn("Fail to stop Dpms!\n");
-				return ret;
-			}
-		}
 	}
 
 	kfree(table_context->driver_pptable);
@@ -1548,12 +1541,12 @@ static int smu_suspend(void *handle)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-		ret = smu_disable_dpm(smu);
-		if (ret)
-			return ret;
 	}
 
+	ret = smu_disable_dpm(smu);
+	if (ret)
+		return ret;
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
 
-	if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
+	if (smu_version >= 0x360d00)
 		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
@@ -1386,7 +1386,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+		if (smu_version >= 0x360d00) {
 			result = smu_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
@@ -1401,7 +1401,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		size += sprintf(buf + size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+		if (smu_version >= 0x360d00) {
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
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
-			!amdgpu_sriov_vf(smu->adev)) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
 			if (power_src < 0)
 				return -EINVAL;
@@ -1962,9 +1961,6 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 906bc7f2e686..3af439a77876 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -768,9 +768,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
@@ -814,9 +811,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	int ret = 0;
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (tool_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
@@ -836,9 +830,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return ret;
 
@@ -853,9 +844,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
@@ -884,9 +872,6 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
-		return 0;
-
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
@@ -942,9 +927,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return ret;
 
@@ -1107,9 +1089,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	int ret = 0;
 	uint32_t max_power_limit;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	max_power_limit = smu_v11_0_get_max_power_limit(smu);
 
 	if (n > max_power_limit) {
@@ -1860,9 +1839,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
