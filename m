Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493B606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=09J5hPbe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E0010E64D;
	Tue,  3 Nov 2026 14:30:38 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE43E10F5E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzZDLxelMF6vaJJx4j1I1VcKFlsGpSOmPA/EQbH+JTGrHj7fR5G7zLtwWXZ6T8z6QfHckvnUQtRaWKO8Dz872UfBG4QJ229GRVyitjK8VVKJilvqzM6Zf0uyLX46XLpMu6JHze2SvCwbMsQ2VTp1mloe/K7yj6u+Whap2mdeGg7VN2ZkezWy1BSlhUbABYwrXozSX8JjkTzWKdTJvNW1gHqpbqdZAx5AfvZ0BHlne06XOOmbigrCM4nyg+wyqrR7od4cWEwk4hWkozH2A04bhWdakq/bH/b8Fxeobx9wNMPf/TPqUtjtOPp6l8ugA35DXacc1HRLnaBG3l3U4AxEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHRnY6x9f4omI3vYPJUk70+YRSS40SLJ9IgWis32eMg=;
 b=mmrd/X8UXZ3g7TUU/5aqmblCokNvyWMbnD89AOhhepLCGsE0rehTTHlE8Qngrq2E4M7vFWQOqzwx4iuOAANEex95nCOMRo+MY0ICoFHOf596fho6CjBcxBQWxD8bwYUhqWOoCl1JNBjMDHL8ft/ZTj5HLASQBtikKH3aOqnelND9gcX9uHA5ez+dN9w4NkBDsqEcLcRo244z8AGZC9oEB5rSUpatS4KrXo+aY1FtEttOC0LKhLuYO66bSxTU/l76dYem5ZvU2mJcyX5n2tsuKPKOgAqXdxwQYCvO4w19TplDrXgXjpbylz9XHOBjAG3sRidFZhvJgY3sSUTobNYosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHRnY6x9f4omI3vYPJUk70+YRSS40SLJ9IgWis32eMg=;
 b=09J5hPbexB3GPM1dMGuCtRTDu0oBX5po2IedlIR4zKcdHwDfrXUv/oY6iUjQOKdsi3AdFEj72q+KcTuXnC+oezmHdJwGgigd3+4GUrMqmSD6R7X+uaH+xTY2i2wWv22mym4n9eIIQgrXrKzFq9z6unyh92BT1tGr91FoWu3OTlw=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:30:26 +0000
Received: from CO1PEPF0001885B.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::29) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 14:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF0001885B.mail.protection.outlook.com (10.167.249.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 14:30:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:30:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:30:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 08:30:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 =?UTF-8?q?Andr=C3=A9=20Eikmeyer?= <dev@deq.rocks>, Ed Schofield
 <ed@aicharmers.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Tue, 3 Nov 2026 09:30:14 -0500
Message-ID: <20261103143014.522592-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885B:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3029d1c9-c6e2-4fd7-1951-08df39b70027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|56012099006|11063799006|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: YiVISbSUXPi7khrgqkMLu6hzCvBNStl6uGcDxQlT7xxOzDmLaiYuh/hiPhEK62hugHop3N9wSpFHIJWzOifN1HvEqK6lZXLiMRLMc05hLe2JnmwyBvsYfc5SgxumKnbbU3IOIxyn9rTFnWpbcBQBoG+2vzwwUa6vsJgYAYF5hytxvWmyzHxiBfxBv+VGOzC1edNCe5jj0J35WeL0bRqunYs1W4OxV12+SEK9D2ywP64IRCHSCeAAM9pJJaobfdAaj2w2EV9IQllRF5JQMIKy/5kcc/NE/dQqoS8HCi1N5RUhW1y7Mp06L0t6hi2UXrCiHHVc6pjvaTVja1WOQumdibFeM8VTzkarAtdf37E3cXlgguUmhhQTsL8vI7gDVqQfFyhUWny4xG59tIh+ttZSptppbebVFJS9iogrArfsYSBmGPV8acjKOKHqTCzVDmS1CCB0O/PDGDAQh1HTCWubj7qJl4N51en1c+Y+3seebSR7vtH1CH/VKvZDjv08K5s11Vign7q+wp7z0ZPZbgDtVO8xH6OXKP+uz8EZhnVd8dDURrtKzB1X1WOyTLM74KUZrDff3DSi9sMpMzth5zgEcgXqNY0U2wWLSI6Rj7/fP3Hq4lS5pRVmnR4H8MXxSY6LpkaZBXG3dBKFqB9KH9R29w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(260925021911599003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YpuOe9AGEiMEEKBoB6S+lMiEJz4TDGqHtHvfMJhtXH8zY2Mpw4rElfLC2/9xZN/96oiWMDDp279fG3ioz9ZpM/TMyi0xgAiKFdKobzb8D0jiHGVhdC3exY/DSoQaUlSXBwChyXihe8/ysVO8hIYSuUl/SsunqN4UZfC2zFO0lLIwx4tCdak6sC2j2o1WFzI6R6QigVdyMJoMOF1PNlhRvDSuwU2qsr0V/rpAhQYc7vtTO+L53HKJipf4NHF3Dc29pX00bPZsEx8xyfhmSaSb+owA5hVK3uuxM+6c6JgjnMpAMCU+jH6EIB1izsv209shq6AOAE9ScFhUCznPLdbR1N8LvtZYtjZEUXo1Ms1uzgDNsWo7XxIFtUcJNzHdTAtaDJ+K+95MQV7BXQJZAvt8u9qXlGpOvI5V/G2A6aYJ4NoihWI/ZgvTMYzQxtHxh03m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:30:25.3553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3029d1c9-c6e2-4fd7-1951-08df39b70027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Apple Navi GPUs intermittently time out during SMU initialization
when EnableAllSmuFeatures includes UCLK DPM. Leave UCLK out of that early
request and enable it from Navi post-init, after display hardware init
and before the UMC workaround and UMD clock setup.

Read back the enabled features before rebuilding the memory clock table
and sustainable clock limits. Also check the PPT memory states used by
display initialization before late enablement. Keep memory-voltage DPM
and respect the user's memory-DPM setting and the secure Navi 10 exclusion.

This builds on Atharva Tiwari's submitted 0219 delayed-UCLK patch
and Guna's diagnosis. Ed Schofield moved the enable point into the
Navi callback, added state validation and clock-table refresh, and
extended the board matching.
Independent tests of the related T2 implementation support improved boot
reliability on 0219 and 021a; those are not tests of this exact AMD patch.

Link: https://lore.kernel.org/amd-gfx/20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com/
Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5637976466
Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5645652752
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6005
Assisted-by: Codex:GPT-6
Cc: André Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Co-developed-by: Ed Schofield <ed@aicharmers.com>
Signed-off-by: Ed Schofield <ed@aicharmers.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

v5: Apply to all navi1x Macs.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2d05088619f6d..e6412eded4715 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,25 @@
 
 static int navi10_init_ppt_limits(struct smu_context *smu);
 
+static bool is_asic_secure(struct smu_context *smu);
+
+static bool navi10_apple_needs_late_uclk(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct pci_dev *pdev = adev->pdev;
+
+	if (!(adev->pm.pp_feature & PP_MCLK_DPM_MASK))
+		return false;
+
+	/* Preserve the existing secure Navi 10 memory-DPM exclusion. */
+	if (is_asic_secure(smu) &&
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0) &&
+	    adev->rev_id == 0)
+		return false;
+
+	return pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE;
+}
+
 static const struct smu_feature_bits navi10_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +375,11 @@ navi10_init_allowed_features(struct smu_context *smu)
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
 	}
 
+	/* Defer UCLK on the selected Apple boards until IP late init. */
+	if (navi10_apple_needs_late_uclk(smu))
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+					   FEATURE_DPM_UCLK_BIT);
+
 	if (is_asic_secure(smu) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
@@ -470,6 +494,25 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi10_apple_check_uclk_states(struct smu_context *smu)
+{
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	unsigned int count, i;
+
+	if (!navi10_apple_needs_late_uclk(smu))
+		return 0;
+
+	count = ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
+	if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
+		return -EINVAL;
+	for (i = 0; i < count; i++) {
+		if (!ppt->FreqTableUclk[i])
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -490,6 +533,10 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = navi10_apple_check_uclk_states(smu);
+	if (ret)
+		return ret;
+
 	return navi10_init_ppt_limits(smu);
 }
 
@@ -3219,6 +3266,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+/* IP late init follows display hw_init; refresh clocks before UMC/UMD setup. */
+static int navi10_apple_late_uclk_enable(struct smu_context *smu)
+{
+	struct smu_11_0_dpm_context *dpm = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *table = &dpm->dpm_tables.uclk_table;
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	struct smu_feature_bits enabled;
+	int ret;
+
+	if (!navi10_apple_needs_late_uclk(smu))
+		return 0;
+
+	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT, true);
+	if (ret)
+		return ret;
+	ret = smu_cmn_get_enabled_mask(smu, &enabled);
+	if (ret)
+		return ret;
+	if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
+		return -EIO;
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
+				 FEATURE_DPM_UCLK_BIT);
+	table->clk_type = SMU_UCLK;
+	ret = smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
+	if (ret)
+		return ret;
+	if (!table->count)
+		return -EINVAL;
+	if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+		table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
+
+	return smu_v11_0_init_max_sustainable_clocks(smu);
+}
+
 static int navi10_post_smu_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3227,6 +3309,12 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	ret = navi10_apple_late_uclk_enable(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", ret);
+		return ret;
+	}
+
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-- 
2.56.0

