Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE66AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B4210EA0B;
	Tue,  3 May 2022 20:09:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60ADF10E9DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIZgXHyWgfsII6fPMNn29QsToliQuyVPXpwux5HQo1AjSKuz/CWXhGeHoVHVtVz26PsmMWB3L3DtqCgPtH96WE8ZMiLosl0hyMFJtBELx8FEucxIcXFg+YFpa/ItJ7+FsOB64z0uBYcTrIq0UY/ZmnjSacYlwBSUbzqJMv1AZ68tjNoFma2IKIipIjMYfhh4dgo5eWLPdzzAY/dL/AuS9Qgw0Ckt39E8Go90Vdi4CsBXuKZBYKr1Mx8nCDpzwevnGlnmRAlpGcimez1r0Z+9KGgMcUy7bVGn2uaRBHEwhi/G+cb2FgVffuoiJq+WYjWqDT9oH9+Ey4u/ahkGX73Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8smyS1qUM4YrKNxI34KcY33praGoXMqGnRPrFKZoBU=;
 b=DsqzHtGVkHJomHbritNZV7h2cWFjKd+Nm5ydAcA7FfBYdArlDVY8JH7OY8AW3N0aAT5PkWbd5Ng9WxQYPQbqnZjURFf8HxN74QR8hEq+LysejdRhiTyZbriDEg4LFQdGSYt5DLcQ6LXLAxgG96cOheBqm3kDW4VykCfm/fDTGcNfi9NzqZSABobXwGCW7bJekw4W1vZd37Q4e9E+LoCDdNANweeNvfQMWR4cAG23/2w+6Ewpl44Pm+C3uobPu4kwkLOLiu4sdjoM1kabNt9Z4W/tH3fU8hY7i8Oql68bbuIaZj4xD+WH79fAq+DUfIpKta2hX47JSpiwaVrqUtfaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8smyS1qUM4YrKNxI34KcY33praGoXMqGnRPrFKZoBU=;
 b=SUDqlPvgOn+hHv0RtpSO3PWB3x4CwGJJBq2WlX2LrU/7GWCngFBUIvKQwKk+G6/FPTJMKQeUovti5V8yEeNiFKHlJN3EwjY8mKHcSBmQ+MP+kir1cHGi4buGYhNW1MXyaAumNArq/5VgOhHJJg+9dCwhMey7mYCGCHMuQ/JfF8c=
Received: from DM6PR07CA0050.namprd07.prod.outlook.com (2603:10b6:5:74::27) by
 MN2PR12MB3519.namprd12.prod.outlook.com (2603:10b6:208:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 3 May
 2022 20:09:09 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::fc) by DM6PR07CA0050.outlook.office365.com
 (2603:10b6:5:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.25 via Frontend
 Transport; Tue, 3 May 2022 20:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable power profile setting for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:33 -0400
Message-ID: <20220503200855.1163186-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc399d2e-7ae6-474b-0391-08da2d40c86c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3519:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB351978D1B0CA046305768E84F7C09@MN2PR12MB3519.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9osufwpJiLa92+est0P5lOg+XYYIDX1FhEFGbyVV4YuZTbw7yVCflSyl7P2WzbqlpNDJHMO/mZe0xgLgVC7zSG0Sb0CTTiGXuI9Yndi+P5NfCGyFJdLwc+Ye9ooQsIYMxllxdMebJn497upgoUBNpTZ6NPpiwRLQp7Zsm0AyNWPBMruruydlqXbJm7u4pHrUXhTLzs93qlpkqHrc2F39BAdAJFV+e8C6F4x9CaYUdiwBSLmnlaUKko0g1KzXWUalbsMK+1xIeyC57RqBrWy97v/T/dRVSJXllMxGtbEksLgMvyV7F5KwscBd/VBjB/McIrmjeeRCyPERMH1GuSkerBUX+pdO+tnEzEZcGBmWjzMGDK3HfUTq79eejeDeoa7hLzNcsJ1feCqcHYTjcjez4nLPyga612hjScPpqADM/wlSz+6VJh6u3sTdGAcs6vuNkGWl4asHfTclW/8rmoe7Y/gfKK5K1yfldPVVVY9r9L/KOiYx1ErwlBg2TeYF7PFxHcs7kwv/Gql9OihnEsmLCV2+IbuQW8LLAaED2a2CX75ig+5L/nhY2khHRhYFe0rybqCOAw5XVXMnTgadK8vGWN9Ft+3pcpD/ey3u6fIb5mQRTiIbHRXi05EYCiR0A7yjwj7N86lMBbRH/pS5lOGLRhU6g4c2ykQeBW8rZeO5kjlKuvLSUibmhFkDzGiSlXLjfDAjz5KZnICqy0W0W2YRMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(54906003)(508600001)(6916009)(70206006)(70586007)(316002)(4326008)(36756003)(86362001)(81166007)(356005)(7696005)(426003)(336012)(186003)(36860700001)(1076003)(26005)(6666004)(40460700003)(8936002)(5660300002)(82310400005)(2616005)(16526019)(83380400001)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:08.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc399d2e-7ae6-474b-0391-08da2d40c86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interfaces for retrieving and setting power profile
mode on SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2bebc69d6f62..ea549b9b01f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1345,6 +1345,158 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
+					      char *buf)
+{
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	static const char *title[] = {
+			"PROFILE_INDEX(NAME)",
+			"CLOCK_TYPE(NAME)",
+			"FPS",
+			"MinActiveFreqType",
+			"MinActiveFreq",
+			"BoosterFreqType",
+			"BoosterFreq",
+			"PD_Data_limit_c",
+			"PD_Data_error_coeff",
+			"PD_Data_error_rate_coeff"};
+	int16_t workload_type = 0;
+	uint32_t i, size = 0;
+	int result = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s\n",
+			title[0], title[1], title[2], title[3], title[4], title[5],
+			title[6], title[7], title[8], title[9]);
+
+	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
+		if (workload_type < 0)
+			return -EINVAL;
+
+		result = smu_cmn_update_table(smu,
+					      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					      workload_type,
+					      (void *)(&activity_monitor_external),
+					      false);
+		if (result) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return result;
+		}
+
+		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			" ",
+			0,
+			"GFXCLK",
+			activity_monitor->Gfx_FPS,
+			activity_monitor->Gfx_MinActiveFreqType,
+			activity_monitor->Gfx_MinActiveFreq,
+			activity_monitor->Gfx_BoosterFreqType,
+			activity_monitor->Gfx_BoosterFreq,
+			activity_monitor->Gfx_PD_Data_limit_c,
+			activity_monitor->Gfx_PD_Data_error_coeff,
+			activity_monitor->Gfx_PD_Data_error_rate_coeff);
+
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			" ",
+			1,
+			"FCLK",
+			activity_monitor->Fclk_FPS,
+			activity_monitor->Fclk_MinActiveFreqType,
+			activity_monitor->Fclk_MinActiveFreq,
+			activity_monitor->Fclk_BoosterFreqType,
+			activity_monitor->Fclk_BoosterFreq,
+			activity_monitor->Fclk_PD_Data_limit_c,
+			activity_monitor->Fclk_PD_Data_error_coeff,
+			activity_monitor->Fclk_PD_Data_error_rate_coeff);
+	}
+
+	return size;
+}
+
+static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
+					      long *input,
+					      uint32_t size)
+{
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	int workload_type, ret = 0;
+
+	smu->power_profile_mode = input[size];
+
+	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+		return -EINVAL;
+	}
+
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		switch (input[0]) {
+		case 0: /* Gfxclk */
+			activity_monitor->Gfx_FPS = input[1];
+			activity_monitor->Gfx_MinActiveFreqType = input[2];
+			activity_monitor->Gfx_MinActiveFreq = input[3];
+			activity_monitor->Gfx_BoosterFreqType = input[4];
+			activity_monitor->Gfx_BoosterFreq = input[5];
+			activity_monitor->Gfx_PD_Data_limit_c = input[6];
+			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+			break;
+		case 1: /* Fclk */
+			activity_monitor->Fclk_FPS = input[1];
+			activity_monitor->Fclk_MinActiveFreqType = input[2];
+			activity_monitor->Fclk_MinActiveFreq = input[3];
+			activity_monitor->Fclk_BoosterFreqType = input[4];
+			activity_monitor->Fclk_BoosterFreq = input[5];
+			activity_monitor->Fclk_PD_Data_limit_c = input[6];
+			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+			break;
+		}
+
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+	}
+
+	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       smu->power_profile_mode);
+	if (workload_type < 0)
+		return -EINVAL;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetWorkloadMask,
+					       1 << workload_type,
+					       NULL);
+}
 
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
@@ -1395,6 +1547,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_power_limit = smu_v13_0_0_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
 	.set_power_source = smu_v13_0_set_power_source,
+	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
+	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

