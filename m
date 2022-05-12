Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2CCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6498A10EFC9;
	Thu, 12 May 2022 03:23:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8CA10EFA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF6Op6hnbLpXEVYs0tf/NOFV8SK8SMe52rsilRGGl5qAVgsft9rbiK75wMvUUjxygXiE78LHn3mW3RgQ/lrngRlH1daDaSFzXwuGCrMQ24RZb1/Z10cyvm2MmlM0P77vbLUCvVlY1PfYI1OM1B0gq9BRV9vuvCA505eQLkVNsaDo72sPhc5FW3zEsSWmf5M35Z+cM5J5M/HFMuB+kH00FSRhlLCIhpKtkuogBKObiaDuME06osxfobq1QFamTu7jibJzt3/NLZ70MrW0i68PZVMIlTFuomCSuQLlr6+m9oX6DjFsEFANCMQ5/Fle38uslZU4mFqvfHB8XL+QPCp6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUrmTaytNxzluYVDlVHDV/OO2IyjIxTQmWHIjXhIYww=;
 b=K8EZmxcNp0x/TCd9DYRzGk4CMJu7K0C30NpTTxHPkmsldRkILbG2sIrAd/hX2ztnYbPYNlV1t+MuDb6r7uOm1VXL5RfeYELZbBbq4iTuvbpglqoGjGkcKaPQpO2oQJdgs3urrI3ySlulNPAkN+Xj3LmAa+m1k+dukFL8qnGSTnN8w2GrKK91UYGVzNdZqpLGimJJacabsuCDw8wUulz01t0POtj/QSj3M1QejnxD6pffXN6ZcdQI4XlM6tBRl2FrEfNrEua/zW2RrVLC3uXO4UogQxuR6LzfN3/q5oDvwZeFE2L8/mW0jcc3QmiVKEQn/ujDYZqhed5XyssRtH3efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUrmTaytNxzluYVDlVHDV/OO2IyjIxTQmWHIjXhIYww=;
 b=CNwuKP0q3SWrit3K8pvP5lcevxePWh2MjL93T0O/kT26tNU4GADX2kqYNLUHJqpDoG68bEvU1zHIrvsTUpeb63T6Frtv5bAHS9GWMHvgvtC1tCZmU3zvwBoDBbzSC3jot9Mah2lumeROfgfLXI7frMiuXPJJlMhMpPzCy8S9piM=
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by MN2PR12MB4655.namprd12.prod.outlook.com (2603:10b6:208:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 03:23:04 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::74) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 03:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu/pm: add some common ppt functions for SMU IP
 v13.0.x
Date: Wed, 11 May 2022 23:22:42 -0400
Message-ID: <20220512032247.528556-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a41ec94-de09-41e7-1b7f-08da33c6b9f8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4655:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB46555F4ADE0B34606F61C3F4F7CB9@MN2PR12MB4655.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Udb6iu8Pu936Qd2zw7FNQ9S5QYE9wD46ieIQ3JAWKXKxmf9PQBk2OyPTyLwqti3UHFo6l06U627fSCnKqxYk/EIJsXQmDtEEc8qNBN1s2AtUv3MZDe9WXJa85c4s0ZPNjaY4hurJCDm067G/MTolsuUaItzemQwYcj55VWzaRLifWxzOfT8oV7zuVXPFXbnznj5hQIir8Di0H4UtHQTn25Wp0yfI7kfunUgHb0bBRTwiRYds1/jeEhw4E33mb0NhtW0MaXD3ncHvIfSoezoA6V7s/fkUoIOZjlIDPpKQT2mp+Ym3I0QPlkwKIVuNqLy72hg6Bgt2kTlOVBBe4BorFufItgfJkccs/kJGn9UnLd4Gs5Q1ZAgrdUjcRSzI/nlVT2buK9wLdx+6uh+JwKBZytDOHX5ZLq8KQYUC5cVg3Txyp3UB4B/mIC/jwy4NPaLhe+Qif9BVE658/9DT9tHhC3VSozEhdaeaNLtvWicfYM+AXF91sFU+sYAf4ArXhPHF7tJdOsdcz46Zn5ZK2WjHUJxcbR5E0geHThigwQUm1cWKbn2N2vrh6ROuyDWu/B0mh45R/I+ha6B5TT2Z0iWsF90Nt4WMfCfghcwWrsTSe3g/g9LhYAGDVdT8WbQpbwGV9eDlN553eI0+NVeWhpBybhH5R+RQjGcvfWSZB4GD3Dy0Xo7UXWiNwOVHXPvD2xauiFCrakgSFLr9V+d0hZaojw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(26005)(426003)(70586007)(316002)(86362001)(70206006)(508600001)(6666004)(16526019)(40460700003)(81166007)(36860700001)(2906002)(7696005)(186003)(4326008)(8676002)(54906003)(6916009)(336012)(82310400005)(356005)(2616005)(8936002)(83380400001)(1076003)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:04.1995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a41ec94-de09-41e7-1b7f-08da33c6b9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4655
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Add some common ppt functions that will be used by SMU IP v13.0.x
and drop the not used function smu_v13_0_mode2_reset.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 106 +++++++++++++++---
 2 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 013be82db1f3..2b44d41a5157 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,6 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x27
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x28
@@ -224,8 +225,6 @@ int smu_v13_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
-int smu_v13_0_mode2_reset(struct smu_context *smu);
-
 int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 				    uint32_t *min, uint32_t *max);
 
@@ -293,5 +292,11 @@ int smu_v13_0_baco_enter(struct smu_context *smu);
 
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
+int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
+				enum PP_OD_DPM_TABLE_COMMAND type,
+				long input[],
+				uint32_t size);
+
+int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index aee1741d98e9..14a7eef0b15f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -295,6 +295,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(13, 0, 8):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
+	case IP_VERSION(13, 0, 4):
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_4;
+		break;
 	case IP_VERSION(13, 0, 5):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_5;
 		break;
@@ -1516,19 +1519,6 @@ int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 	return ret;
 }
 
-int smu_v13_0_mode2_reset(struct smu_context *smu)
-{
-	int ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-			SMU_RESET_MODE_2, NULL);
-	/*TODO: mode2 reset wait time should be shorter, add ASIC specific func if required */
-	if (!ret)
-		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
-
-	return ret;
-}
-
 int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 				    uint32_t *min, uint32_t *max)
 {
@@ -2282,3 +2272,93 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 	return smu_v13_0_baco_set_state(smu,
 					SMU_BACO_STATE_EXIT);
 }
+
+int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
+				enum PP_OD_DPM_TABLE_COMMAND type,
+				long input[], uint32_t size)
+{
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+	int ret = 0;
+
+	/* Only allowed in manual mode */
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
+			if (input[1] < smu->gfx_default_hard_min_freq) {
+				dev_warn(smu->adev->dev,
+					 "Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					 input[1], smu->gfx_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_hard_min_freq = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > smu->gfx_default_soft_max_freq) {
+				dev_warn(smu->adev->dev,
+					 "Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					 input[1], smu->gfx_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_soft_max_freq = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+		if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+			dev_err(smu->adev->dev,
+				"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+				smu->gfx_actual_hard_min_freq,
+				smu->gfx_actual_soft_max_freq);
+			return -EINVAL;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+						      smu->gfx_actual_hard_min_freq,
+						      NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Set hard min sclk failed!");
+			return ret;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+						      smu->gfx_actual_soft_max_freq,
+						      NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Set soft max sclk failed!");
+			return ret;
+		}
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+int smu_v13_0_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+				    smu_table->clocks_table, false);
+}
-- 
2.35.3

