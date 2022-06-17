Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FC9C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EF910F44D;
	Fri, 17 Jun 2022 19:36:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9415D10F454
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciIG89QGsWXH88ftDvBvD6Q7kQTSjAsSZQtdBAvCPId0y3P7f7x2puER5NiZcFglHhpssnMCIwRc8WO80uoM2ejkM0lJBqe2N135zbwjiTalox+xIsasvbSXxO54ZSpLS1vtqoMMU9iBxYqTH2RY+18ipJEyhzUy3KrsxMQ/RReWCPw7AEogbdF1r6AfHidvsKZU+651ft8OHn03Fix1BaQN29UWFmIc3lLWAmYI2KePte1blPJ5azxKzFVNXQoMU0Q5txTMIDDCV+CEnKEmwCKqRmn/xHYaOloYMFGgNc5tc/JWuhwN1D187mMjiCYeY0zuIXxO612bHvlbkQpj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9F4Woq3IOrqacRawAsX9M0qVXSfeuBqPr6/xeZUUFg=;
 b=oCRhZ3zo5UGY7wnIK4M0fJKNj0lVI2iqRKbiH8EemLfCGu6y+FsAMY9Pczcqrvw9CrPgG61VPSGOuCavzdneSO7eagra0VVYUMcir8B7APVv63KxyLi83/dXpi9YfqalZ0jnVX5dWW/hVLaVRTXmioKmBR7xFBbSc7aflGRVJvt1pleHmfzGL7+oY6F7pK7G48VjdnXBD3SICEqlm/T6Ejx4IIxvv8Auy0xDxgM6JGKJ4x5UeMuzZlspF/7FmklB3NSg9K8Hc87jiTg9miytndFtecygH1uPkb4KxdLcglD0/NLg9niR01gC5PW4Qws91Rrc0s++U/AbIzO6730TlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9F4Woq3IOrqacRawAsX9M0qVXSfeuBqPr6/xeZUUFg=;
 b=18QHBX39CkOikwzCG/3foaXFV3djUGxE/S3Z5kz9JS6oUDF+ylQhjWEJva98dviJ9WzYuQPNTJASGzXu/pyq+8Ex+8EY7lsfZKcHS2QUOx7FLSO3Y6rc+Syf/bHdKHSeINOuRrurOR+tDYDR8iut7BuwknylmcWsPnn/hq40MUo=
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:05 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::88) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:05 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/31] drm/amd/display: Handle downstream LTTPR with fixed VS
 sequence
Date: Fri, 17 Jun 2022 15:35:00 -0400
Message-ID: <20220617193512.3471076-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca790bc0-577b-4ae0-f45d-08da50989ef7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53285F4A2AD0812E5D515E8D98AF9@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzmAx87n/z1shU8ps48thryLZfBjinLdkohYPGK5yVtnFhCxjbDn2cnBsyqaRvIUTECW5OjgWCVnj22XbZ2+HXVTYWqBppL91Tyygz/o1ay9iY3g9cj2Rb//N4HIxzWZ/X5sXtub5HnvSKtpuYpGhwfpLXG1o4Mbdu940aYUEGX4R3Wpvp9ejLJgz6JraX9o0TYfUNkRZxaa7EqQFhobPfFMxcGi2XknAbjlqSSUhBuQxfocVoGqIbYJLT89F6UjmzSD3+78xC7+xdY12HqWNrMKw1K8QrUJX8bSuEYRF68IqdFWjgkwsuw1k3v04YyuPZrR/b3AoVhY8zQt8vkV3PuYKjq4GI8xbQx3j9R7vWg/ODBMORHAYOEtFqlxhYV/vPIKKxKsvcDTYqkNVbuk3gVOG/0th155bWO5iY2IUHLlVEU6gUuUP6GDcbzaw6ltTEkU56VB8/1FwQ6eezCNj7Ys+hhdBdHwTRTj84DuDaw16YqD5gqZGt7vSWYBseVhzlncu6DSZgVZ2gWRB2k46vxmXeQLMCpCPURbTmc9+OWBLuwOdme4eSKvvpJb14L5bxC8fuaU7Ko/Nh01QAGYVYzfVO4zTxL8S7Ji/cmVKxWW10llc1zJyYHQuw2x/drKIFmdqzBEbcrG9xA+m9gbulr6Ecwaw0ij9T1plduw7CenMssxXybFmJY7yMmn9hjKIbnOQmGpZSCRJOoyNWh7YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(4326008)(336012)(36860700001)(2906002)(7696005)(1076003)(498600001)(356005)(70586007)(8676002)(70206006)(2616005)(81166007)(86362001)(316002)(26005)(6916009)(54906003)(186003)(83380400001)(5660300002)(82310400005)(47076005)(6666004)(8936002)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:05.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca790bc0-577b-4ae0-f45d-08da50989ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Several issues were discovered that caused link
training to fail when an LTTPR device is
connected downstream for the fixed VS sequence.

[How]
The following were added:
- workaround to configure AUX timeout
for fixed VS sequence
- additional delay before disabling
fixed VS intercept
- detection of fixed VS deadlock state and
performing DPCD sequence to recover

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 43 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 972dbbcc36da..c993b428ca7e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2384,6 +2384,7 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
 	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
+	uint32_t pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
@@ -2406,6 +2407,10 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	if (offset != 0xFF) {
 		vendor_lttpr_write_address +=
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+
+		/* Certain display and cable configuration require extra delay */
+		if (offset > 2)
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
 	}
 
 	/* Vendor specific: Reset lane settings */
@@ -2485,6 +2490,7 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 	/* Perform Clock Recovery Sequence */
 	if (status == LINK_TRAINING_SUCCESS) {
+		const uint8_t max_vendor_dpcd_retries = 10;
 		uint32_t retries_cr;
 		uint32_t retry_count;
 		uint32_t wait_time_microsec;
@@ -2492,6 +2498,8 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 		union lane_align_status_updated dpcd_lane_status_updated;
 		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+		enum dc_status dpcd_status = DC_OK;
+		uint8_t i = 0;
 
 		retries_cr = 0;
 		retry_count = 0;
@@ -2522,11 +2530,23 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 						lt_settings->pattern_for_cr,
 						0);
 				/* Vendor specific: Disable intercept */
-				core_link_write_dpcd(
-						link,
-						vendor_lttpr_write_address,
-						&vendor_lttpr_write_data_intercept_dis[0],
-						sizeof(vendor_lttpr_write_data_intercept_dis));
+				for (i = 0; i < max_vendor_dpcd_retries; i++) {
+					msleep(pre_disable_intercept_delay_ms);
+					dpcd_status = core_link_write_dpcd(
+							link,
+							vendor_lttpr_write_address,
+							&vendor_lttpr_write_data_intercept_dis[0],
+							sizeof(vendor_lttpr_write_data_intercept_dis));
+
+					if (dpcd_status == DC_OK)
+						break;
+
+					core_link_write_dpcd(
+							link,
+							vendor_lttpr_write_address,
+							&vendor_lttpr_write_data_intercept_en[0],
+							sizeof(vendor_lttpr_write_data_intercept_en));
+				}
 			} else {
 				vendor_lttpr_write_data_vs[3] = 0;
 				vendor_lttpr_write_data_pe[3] = 0;
@@ -5190,6 +5210,19 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	determine_lttpr_mode(link);
 
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+		if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+				!link->dc->debug.disable_fixed_vs_aux_timeout_wa) {
+			/* Fixed VS workaround for AUX timeout */
+			const uint32_t fixed_vs_address = 0xF004F;
+			const uint8_t fixed_vs_data[4] = {0x1, 0x22, 0x63, 0xc};
+
+			core_link_write_dpcd(
+					link,
+					fixed_vs_address,
+					fixed_vs_data,
+					sizeof(fixed_vs_data));
+		}
+
 		/* By reading LTTPR capability, RX assumes that we will enable
 		 * LTTPR extended aux timeout if LTTPR is present.
 		 */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 51f5d75bf9e3..236a204d41ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -737,6 +737,8 @@ struct dc_debug_options {
 	bool enable_z9_disable_interface;
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
+	bool disable_fixed_vs_aux_timeout_wa;
+	uint32_t fixed_vs_aux_delay_config_wa;
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
 	bool force_usr_allow;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a67475251188..1a67d04cc017 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -890,7 +890,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
-	.apply_vendor_specific_lttpr_wa = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 };
-- 
2.25.1

