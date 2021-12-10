Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F70C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82DB10E495;
	Fri, 10 Dec 2021 23:05:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5F510E397
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4n8cGZy6VoSZZ4iE1Lf8VduQg+OT8EhpW3shNq0gGRLctYv+Jzw2HCfWf+9xuzP4+aLIRsrB1NwYFYGQd2WCJ09XDq8Xjlwec36y9SJpEie8ZQEFIS8i+cdVS9gmWtNJf6Fu9D67vJK7gp1oC5C8i2EdcZlvlgyUNDnzdTHBHdrDlRW6wRiMyfamabxJsvZxRG2s/PO7bze5KQx3cSNf4gAL5PFjqFH73XMjKiM7tarnArvBKyvRc1zjZoJXdy+MPRCJlg8D5/dqlQmfyslxvi5jFu/Ct38mUe4dLDkQyHTt2fvn05i5lDHMDHI5cdNAcDlzYnrgJ0ZwbqrNCB7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRdFuw3QcxAZ+6+HxT/YDchcPVnRUz1sv1BFs96M4mI=;
 b=Tgmff7kglAPFNGjpLHSAO7QBX1HcLoUjRKGptj2bNlJ8j2ROwxzky4oxMnoUcTapCy9V7l//OGjm2FxSiCaN/4lgCXL06mNjOVuqzfN/c1n8nRlRXM943zP3pWQ8AU0+f/QU06W5GNh3rv30nLP6hAgoH9dA2DErBlEjVJX7Utc7YvQD5cvVegVCmdhRZydzHYitwQXPW77kHZOui4EnWyVKDQBQRoGRSZo8buofAA9lz5Lhq4GJ+wosOwGeqJMK0q15RYBIbayZwXIxKc//qhe7WpNwvTMpJhYBBbwm7RVZEcQrkMeBMcpdJVxkahdkU08ekp4xKqTx85TcKNeCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRdFuw3QcxAZ+6+HxT/YDchcPVnRUz1sv1BFs96M4mI=;
 b=K11/HUUNLDq6B27NgEruCTlmW2rUUs3MJkWv4kI/aFiu5VGZNJLiyI5ykkLVGQ+Q/QU3nycJBAvU/9bzqawezboYF8zVh9/KevXeXKFEEC9A3fZcEosfbg6dyZFXOAmqfR/qFS8VBWPK7H8xe4urv/U7arUc+66/H8+4H1Dl9xA=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 10 Dec 2021 23:05:17 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::bb) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:17 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:14 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amd/display: parse and check PSR SU caps
Date: Fri, 10 Dec 2021 15:04:02 -0800
Message-ID: <20211210230408.619373-5-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba04d63-1f27-47a0-eb74-08d9bc31880d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5151:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5151C8EB22EBEA7661B0FEEAFC719@DM4PR12MB5151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuDe4wqqFkj1P9tZHrnZFzM0EJ98qCAnwKxzFP0i5tkwra6zm92U2J2/G11dvq76FVmK+q0lAp23PI7pN56AIvXV97NwSjMfc0FpHCfpg5FeXSn1l4ptCLjGzDmEdY3uKneNL1SG6bT4Q0alsUcnwnfqk66Cg0sQimRoVkDL+QTwCSEIPO9aWxe5ahTfvMjZunOpZLyOby9eC2SiLKDmU7jvAILvOkcCGgvgLkRbjlWMfmRDS8Pcqa+tg/LtaY5YeAgCDBrW3dvjf2nMn3aQOgqdZeBT2nsU9Nuy6O+8skZR2BqFFdwcUX7mNv8ya89dBn/MXTOsooS1cuARiJc6TbuS+BaJnrT+SfW85wjuRlv1KhHwWljzS1b1CgDxbEpKDMWXqr6OR9tqQFSsLcbaOsRXnWxYcqufhbW57h2BgrJaa0D5gd+kepCJesehIBLdsvR9Ptz6cM8QAMuGA0TzPafsopLuwLbkPQudmmWjocH0kxa+7uGUVYYjq7Wmi3898MbAvaTSsWwdFTgQsZdzSAbs3qe6cGK/a0AlbBKGUHs7lBskdgFKzMRqiRpiWR6wFVqjj+OZmLrvDm4vDBLUgdHRSNuo0quuOvNsQU40odIcfi0p+E3QCS+Ns81fo2H5WhJSU1m99S2v3WYvdWj9x4055PbKVMHXEa/EkFWkykLsMnrFgeSjTx+EgbKDDG7KBjYzLoN4aRUAKq4Q4bV3oZgrHaGvXiDsRVafyIRrD4XS30MUV6vg/H7qEjLcRj4NOQmWNwJioUjOYlOuV3BNiMnVhU2ocH/DEGUz+f5N0BA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(186003)(86362001)(66574015)(2906002)(36756003)(26005)(356005)(16526019)(336012)(81166007)(82310400004)(70206006)(2616005)(316002)(36860700001)(6916009)(8676002)(7696005)(83380400001)(4326008)(5660300002)(47076005)(1076003)(6666004)(426003)(508600001)(40460700001)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:17.0887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba04d63-1f27-47a0-eb74-08d9bc31880d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Adding a function to read PSR capabilities
and ALPM capabilities.
Also adding a helper function to validate if
the sink and the driver support PSR SU.
[how]
- isolated all PSR and ALPM reading calls to a separate funciton
- set all required PSR caps
- added a helper function to check if PSR SU is supported by sink
and the driver

Reviewed-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 101 +++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   9 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 3 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index c022e56f9459..c510638b4f99 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -26,6 +26,73 @@
 #include "amdgpu_dm_psr.h"
 #include "dc.h"
 #include "dm_helpers.h"
+#include "amdgpu_dm.h"
+
+static bool link_get_psr_caps(struct dc_link *link)
+{
+	uint8_t psr_dpcd_data[EDP_PSR_RECEIVER_CAP_SIZE];
+	uint8_t edp_rev_dpcd_data;
+
+
+
+	if (!dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
+				    psr_dpcd_data, sizeof(psr_dpcd_data)))
+		return false;
+
+	if (!dm_helpers_dp_read_dpcd(NULL, link, DP_EDP_DPCD_REV,
+				    &edp_rev_dpcd_data, sizeof(edp_rev_dpcd_data)))
+		return false;
+
+	link->dpcd_caps.psr_caps.psr_version = psr_dpcd_data[0];
+	link->dpcd_caps.psr_caps.edp_revision = edp_rev_dpcd_data;
+
+#ifdef CONFIG_DRM_AMD_DC_DCN
+	if (link->dpcd_caps.psr_caps.psr_version > 0x1) {
+		uint8_t alpm_dpcd_data;
+		uint8_t su_granularity_dpcd_data;
+
+		if (!dm_helpers_dp_read_dpcd(NULL, link, DP_RECEIVER_ALPM_CAP,
+						&alpm_dpcd_data, sizeof(alpm_dpcd_data)))
+			return false;
+
+		if (!dm_helpers_dp_read_dpcd(NULL, link, DP_PSR2_SU_Y_GRANULARITY,
+						&su_granularity_dpcd_data, sizeof(su_granularity_dpcd_data)))
+			return false;
+
+		link->dpcd_caps.psr_caps.y_coordinate_required = psr_dpcd_data[1] & DP_PSR2_SU_Y_COORDINATE_REQUIRED;
+		link->dpcd_caps.psr_caps.su_granularity_required = psr_dpcd_data[1] & DP_PSR2_SU_GRANULARITY_REQUIRED;
+
+		link->dpcd_caps.psr_caps.alpm_cap = alpm_dpcd_data & DP_ALPM_CAP;
+		link->dpcd_caps.psr_caps.standby_support = alpm_dpcd_data & (1 << 1);
+
+		link->dpcd_caps.psr_caps.su_y_granularity = su_granularity_dpcd_data;
+	}
+#endif
+	return true;
+}
+
+#ifdef CONFIG_DRM_AMD_DC_DCN
+static bool link_supports_psrsu(struct dc_link *link)
+{
+	struct dc *dc = link->ctx->dc;
+
+	if (!dc->caps.dmcub_support)
+		return false;
+
+	if (dc->ctx->dce_version < DCN_VERSION_3_1)
+		return false;
+
+	if (!link->dpcd_caps.psr_caps.alpm_cap ||
+	    !link->dpcd_caps.psr_caps.y_coordinate_required)
+		return false;
+
+	if (link->dpcd_caps.psr_caps.su_granularity_required &&
+	    !link->dpcd_caps.psr_caps.su_y_granularity)
+		return false;
+
+	return true;
+}
+#endif
 
 /*
  * amdgpu_dm_set_psr_caps() - set link psr capabilities
@@ -34,26 +101,34 @@
  */
 void amdgpu_dm_set_psr_caps(struct dc_link *link)
 {
-	uint8_t dpcd_data[EDP_PSR_RECEIVER_CAP_SIZE];
-
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
 		return;
+
 	if (link->type == dc_connection_none)
 		return;
-	if (dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
-					dpcd_data, sizeof(dpcd_data))) {
-		link->dpcd_caps.psr_caps.psr_version = dpcd_data[0];
-
-		if (dpcd_data[0] == 0) {
-			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-			link->psr_settings.psr_feature_enabled = false;
-		} else {
+
+	if (!link_get_psr_caps(link)) {
+		DRM_ERROR("amdgpu: Failed to read PSR Caps!\n");
+		return;
+	}
+
+	if (link->dpcd_caps.psr_caps.psr_version == 0) {
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+		link->psr_settings.psr_feature_enabled = false;
+
+	} else {
+#ifdef CONFIG_DRM_AMD_DC_DCN
+		if (link_supports_psrsu(link))
+			link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
+		else
+#endif
 			link->psr_settings.psr_version = DC_PSR_VERSION_1;
-			link->psr_settings.psr_feature_enabled = true;
-		}
 
-		DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
+		link->psr_settings.psr_feature_enabled = true;
 	}
+
+	DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
+
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 99d26fb31566..353dac420f34 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -883,6 +883,15 @@ struct psr_caps {
 	unsigned char psr_version;
 	unsigned int psr_rfb_setup_time;
 	bool psr_exit_link_training_required;
+	unsigned char edp_revision;
+	unsigned char support_ver;
+	bool su_granularity_required;
+	bool y_coordinate_required;
+	uint8_t su_y_granularity;
+	bool alpm_cap;
+	bool standby_support;
+	uint8_t rate_control_caps;
+	unsigned int psr_power_opt_flag;
 };
 
 /* Length of router topology ID read from DPCD in bytes. */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index cb26ff8a54c5..0285a4b38d05 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -951,6 +951,7 @@ enum dc_gpu_mem_alloc_type {
 
 enum dc_psr_version {
 	DC_PSR_VERSION_1			= 0,
+	DC_PSR_VERSION_SU_1			= 1,
 	DC_PSR_VERSION_UNSUPPORTED		= 0xFFFFFFFF,
 };
 
-- 
2.32.0

