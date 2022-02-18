Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774ACC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B4410EEDA;
	Fri, 18 Feb 2022 15:04:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0266210EEDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia5ngUMfizBwoQPk/HBCVTNsAVjnv1KxQ/RyAEWgjQl5eUY2yO2DhI4sF8o1DJzvx5XIWR6mhtkuqgAzC2kdKY0TYhgxSWBWe1p4R9ykOJ/BO9XiIygAy3zMW657etbAn4zSeHR9KIk6hj6BwAx1VEMk7aFkelipYEWuVdmZB9K5CSjs6oAuReBpef2RiYeFhe3+OO9TtweubahB/gmpSeQK4POxG/ktEe3f2r7u1XMcZ/dllT5PUHnEj3dA5qui9DQvzynuPB3NMrcPc6/NtHE5foeqqIpq/djW4AUvTrvJXxbd102v101GKdckLWT+EVq5ID6Mfc1eS/DBIbK7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY0j4cnaSXj/khT7y2JmOubh6ZZaXPhqOEyjZlFdNGk=;
 b=IZyrMMiK9AXSpQjs6ckPK8o7O+8Z3SNrrBFI31tfxSumHr03VbaKVFEWmMVFldKobL0zV9vOU59935IhvnBhbNZZ325WBWiFU+2uUXBmFHrf+OnkZZ9C1VdU86fZvDpnIbB3EiB73OF4XPP2KZkDQSozXjlvidnVZXMkyClcCnsm8zMsYWE12vrUpV/VhMQwiMfwDrVkO+cSGA4CNnpTPavb/50YeuWpfkUMpJhxMo82311XG9H2pjylIvB4qRk3IQFmjBW/D26Is+QQcwV8GDdx46cv8RTHgdDb7/3rLUhTEisACKuu41tcF6CEICqVWJ7zfNgRB2AG6Z5utErLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY0j4cnaSXj/khT7y2JmOubh6ZZaXPhqOEyjZlFdNGk=;
 b=I13FieaiFG1WMdyqVMknexNWbCy1rc+WeMQLRmE0lduWJJ+LcsqJUJ9tSS+yc2763jOO2fjKx+JtfG84CO462WxOnPz3rK+cqn8DTOvMp2mBkKMlA1Wjj4/JqBtn6Kw2DK4+OSkVCtGI8BNBNRghmifYt1UWqDImozvQlSic45U=
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Fri, 18 Feb 2022 15:04:24 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::5d) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:23 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:17 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Refactor PSR DPCD caps detection
Date: Fri, 18 Feb 2022 23:03:21 +0800
Message-ID: <20220218150329.7976-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff00f15-ae78-4e25-179c-08d9f2eff2f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24172F30FF8AFC997C7301EB97379@BL0PR12MB2417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CtWjsUG05IExU0thf+0TRy1CfUQqA4dMqRMhXDBbK8DFrPg5U7C2cqpFTcfP4peBJ9Q8xu/BIicvnWZ3WijKjzPZwou1yTrYEvSjF+d4tPU4bTuKT9/SPFMUM7uidivgGdKBA0GZpqcxzJ/a4UywNXRodFakFaZBgTjTcevIF26vKGgoVTsk01ngu3lHY7CgVpkrEX1hUoY8ydD7U8yS7HlyRVqP3wvgxfxVqLVgkdbjwJ2gLv+/eazG1ahndn6gLTdOkN8y8/jOVEJvGkg+yFu6NWeVP3sXY0iDHZPiDDBczi8ghsyKw9gtPZRyAb8131jngyDK+UbBfR8iqxg+l8ZGHOoGuJHiuMKBrfKS7T3za5WTBU+SarKlkXgDagkC12KLa8MGQR/pFVgnPuxNk6n0yGbulestlTZc3EC8sXT9GnvFATicYoySpEVucGjXRzZGE1J6EREsDXzQtuY9GtJSLulmqtIt6uRLbGxqkDSFjSK4IZLao/b/lyGXrSygzO2pZRI+TdYGUuT5679SfuVSHpcxzagvxNwptavxGlnwQCXQ0jjX2bJwBFweubG/zS9eDQ5NEsxdYL1t0WSPQSpFjNpTRAxTR4n5ENjvVkEtaCx0wnthaBDGBJwavH1TZpMG37y9+7u1f23dCUhUlTA0+gWkER+S1PyDTPMmi6JAI9ZmaZFMtZiBsmWb8KUF5hAtd+Odlt84icT2wASHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(2906002)(83380400001)(5660300002)(86362001)(7696005)(1076003)(81166007)(82310400004)(356005)(70586007)(4326008)(70206006)(8676002)(508600001)(40460700003)(47076005)(2616005)(36756003)(6916009)(6666004)(54906003)(26005)(16526019)(186003)(44832011)(36860700001)(336012)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:23.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff00f15-ae78-4e25-179c-08d9f2eff2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Po Ting Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Po Ting Chen <robin.chen@amd.com>

[Why]
To move the PSR DPCD caps detection into detect_edp_sink_caps()

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Po Ting Chen <robin.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 58 ++-----------------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 28 +++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 30 ++++++++++
 .../amd/display/include/ddc_service_types.h   |  1 +
 6 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d7611c81fca8..d49aa8d1c2c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -857,9 +857,9 @@ static int psr_capability_show(struct seq_file *m, void *data)
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
 		return -ENODEV;
 
-	seq_printf(m, "Sink support: %s", yesno(link->dpcd_caps.psr_caps.psr_version != 0));
-	if (link->dpcd_caps.psr_caps.psr_version)
-		seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_caps.psr_version);
+	seq_printf(m, "Sink support: %s", yesno(link->dpcd_caps.psr_info.psr_version != 0));
+	if (link->dpcd_caps.psr_info.psr_version)
+		seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.psr_version);
 	seq_puts(m, "\n");
 
 	seq_printf(m, "Driver support: %s", yesno(link->psr_settings.psr_feature_enabled));
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index a009fc654ac9..0c923a90615c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -28,49 +28,6 @@
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
 
-static bool link_get_psr_caps(struct dc_link *link)
-{
-	uint8_t psr_dpcd_data[EDP_PSR_RECEIVER_CAP_SIZE];
-	uint8_t edp_rev_dpcd_data;
-
-
-
-	if (!dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
-				    psr_dpcd_data, sizeof(psr_dpcd_data)))
-		return false;
-
-	if (!dm_helpers_dp_read_dpcd(NULL, link, DP_EDP_DPCD_REV,
-				    &edp_rev_dpcd_data, sizeof(edp_rev_dpcd_data)))
-		return false;
-
-	link->dpcd_caps.psr_caps.psr_version = psr_dpcd_data[0];
-	link->dpcd_caps.psr_caps.edp_revision = edp_rev_dpcd_data;
-
-#ifdef CONFIG_DRM_AMD_DC_DCN
-	if (link->dpcd_caps.psr_caps.psr_version > 0x1) {
-		uint8_t alpm_dpcd_data;
-		uint8_t su_granularity_dpcd_data;
-
-		if (!dm_helpers_dp_read_dpcd(NULL, link, DP_RECEIVER_ALPM_CAP,
-						&alpm_dpcd_data, sizeof(alpm_dpcd_data)))
-			return false;
-
-		if (!dm_helpers_dp_read_dpcd(NULL, link, DP_PSR2_SU_Y_GRANULARITY,
-						&su_granularity_dpcd_data, sizeof(su_granularity_dpcd_data)))
-			return false;
-
-		link->dpcd_caps.psr_caps.y_coordinate_required = psr_dpcd_data[1] & DP_PSR2_SU_Y_COORDINATE_REQUIRED;
-		link->dpcd_caps.psr_caps.su_granularity_required = psr_dpcd_data[1] & DP_PSR2_SU_GRANULARITY_REQUIRED;
-
-		link->dpcd_caps.psr_caps.alpm_cap = alpm_dpcd_data & DP_ALPM_CAP;
-		link->dpcd_caps.psr_caps.standby_support = alpm_dpcd_data & (1 << 1);
-
-		link->dpcd_caps.psr_caps.su_y_granularity = su_granularity_dpcd_data;
-	}
-#endif
-	return true;
-}
-
 #ifdef CONFIG_DRM_AMD_DC_DCN
 static bool link_supports_psrsu(struct dc_link *link)
 {
@@ -82,12 +39,12 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (dc->ctx->dce_version < DCN_VERSION_3_1)
 		return false;
 
-	if (!link->dpcd_caps.psr_caps.alpm_cap ||
-	    !link->dpcd_caps.psr_caps.y_coordinate_required)
+	if (!link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP ||
+	    !link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED)
 		return false;
 
-	if (link->dpcd_caps.psr_caps.su_granularity_required &&
-	    !link->dpcd_caps.psr_caps.su_y_granularity)
+	if (link->dpcd_caps.psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED &&
+	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
 	return true;
@@ -107,12 +64,7 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 	if (link->type == dc_connection_none)
 		return;
 
-	if (!link_get_psr_caps(link)) {
-		DRM_ERROR("amdgpu: Failed to read PSR Caps!\n");
-		return;
-	}
-
-	if (link->dpcd_caps.psr_caps.psr_version == 0) {
+	if (link->dpcd_caps.psr_info.psr_version == 0) {
 		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->psr_settings.psr_feature_enabled = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d62b59d52ba8..bc6161f52bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5565,6 +5565,34 @@ void detect_edp_sink_caps(struct dc_link *link)
 				(backlight_adj_cap & DP_EDP_DYNAMIC_BACKLIGHT_CAP) ? true:false;
 
 	dc_link_set_default_brightness_aux(link);
+
+	core_link_read_dpcd(link, DP_EDP_DPCD_REV,
+		&link->dpcd_caps.edp_rev,
+		sizeof(link->dpcd_caps.edp_rev));
+	/*
+	 * PSR is only valid for eDP v1.3 or higher.
+	 */
+	if (link->dpcd_caps.edp_rev >= DP_EDP_13) {
+		core_link_read_dpcd(link, DP_PSR_SUPPORT,
+			&link->dpcd_caps.psr_info.psr_version,
+			sizeof(link->dpcd_caps.psr_info.psr_version));
+		core_link_read_dpcd(link, DP_PSR_CAPS,
+			&link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
+			sizeof(link->dpcd_caps.psr_info.psr_dpcd_caps.raw));
+		if (link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED) {
+			core_link_read_dpcd(link, DP_PSR2_SU_Y_GRANULARITY,
+				&link->dpcd_caps.psr_info.psr2_su_y_granularity_cap,
+				sizeof(link->dpcd_caps.psr_info.psr2_su_y_granularity_cap));
+		}
+	}
+
+	/*
+	 * ALPM is only valid for eDP v1.4 or higher.
+	 */
+	if (link->dpcd_caps.dpcd_rev.raw >= DP_EDP_14)
+		core_link_read_dpcd(link, DP_RECEIVER_ALPM_CAP,
+			&link->dpcd_caps.alpm_caps.raw,
+			sizeof(link->dpcd_caps.alpm_caps.raw));
 }
 
 void dc_link_dp_enable_hpd(const struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e2b3ad70635b..6176904e22fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1230,7 +1230,6 @@ struct dpcd_caps {
 	union dpcd_fec_capability fec_cap;
 	struct dpcd_dsc_capabilities dsc_caps;
 	struct dc_lttpr_caps lttpr_caps;
-	struct psr_caps psr_caps;
 	struct dpcd_usb4_dp_tunneling_info usb4_dp_tun_info;
 
 	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
@@ -1238,6 +1237,9 @@ struct dpcd_caps {
 	union dp_sink_video_fallback_formats fallback_formats;
 	union dp_fec_capability1 fec_cap1;
 	union dp_cable_attributes cable_attributes;
+	uint8_t edp_rev;
+	union edp_alpm_caps alpm_caps;
+	struct edp_psr_info psr_info;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index ac2c59bd024d..5f848a2fa21d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1068,4 +1068,34 @@ union dp_128b_132b_training_aux_rd_interval {
 };
 
 #endif // DP_INTRA_HOP_AUX_REPLY_INDICATION
+
+union edp_alpm_caps {
+	struct {
+		uint8_t AUX_WAKE_ALPM_CAP       :1;
+		uint8_t PM_STATE_2A_SUPPORT     :1;
+		uint8_t AUX_LESS_ALPM_CAP       :1;
+		uint8_t RESERVED                :5;
+	} bits;
+	uint8_t raw;
+};
+
+union edp_psr_dpcd_caps {
+	struct {
+		uint8_t LINK_TRAINING_ON_EXIT_NOT_REQUIRED      :1;
+		uint8_t PSR_SETUP_TIME  :3;
+		uint8_t Y_COORDINATE_REQUIRED   :1;
+		uint8_t SU_GRANULARITY_REQUIRED :1;
+		uint8_t FRAME_SYNC_IS_NOT_NEEDED_FOR_SU :1;
+		uint8_t RESERVED                :1;
+	} bits;
+	uint8_t raw;
+};
+
+struct edp_psr_info {
+	uint8_t psr_version;
+	union edp_psr_dpcd_caps psr_dpcd_caps;
+	uint8_t psr2_su_y_granularity_cap;
+	uint8_t force_psrsu_cap;
+};
+
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index fb289a5c873a..f561e213bf98 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -34,6 +34,7 @@
 #define DP_BRANCH_DEVICE_ID_90CC24 0x90CC24
 #define DP_BRANCH_DEVICE_ID_00E04C 0x00E04C
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
+#define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
-- 
2.25.1

