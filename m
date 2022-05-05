Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D5610E3A6;
	Thu,  5 May 2022 14:24:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5049C10E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCZDW167kpUSshrqRpMRvVXlagxZ0PpWEl1RCoQ0+6jo7SkT33mJT5ylOWwP4qHpZy8WX0qyYhPjdBGBJGDa9ecIcbADBoCOVvcFBEMfQOWU88kPKXX5b9oIgqo1JiJkCElHyjefJol/hW+wHWa5x1nWiLv5DrMSpnIURiS6vBiIOVZv4lLMxT7SmHDFY2pxUcPpk6Y3HIOFVWdXvHwNMby5uKCs19uWjfUrniSWYPmHaVRcpxeLR/08TBpYnRYkjnGmFOoll9/bMrxeoOJS3JnNUjW0Ngq2XP6x5OH2S1CnMc41mBglAWSMspmcYsdiO9SUZwNjK4rSIWtUg7IPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAfe0d7/9KVEGem1qWl4QtRNEQZRlKsCWR+qpVN8EZw=;
 b=V4cj9UCuhsc9OEJETpU54OENBBLqkFSBDZAB2BtM1lP8m2jaX/RI+ZiQbqIsVCUfQTp/M5kmpyC/aLIrRY8BRmtt8Am7PqjxC1zGwCRu+muhr6emF3LdkBdTNZn5Dz4ozI477xpPK8gt+Xjp1cH0UNzZC+jVNCbEIg4NZQkxWLyMcPLUpqDCzAgAOxoweSIWh6VdXabc2wjP2PoUo/Pse2ZXsPBmmpV6VW+RZyy2l2p6qrAY8lirnMXrcb3wtxhZ+1suEwNFyD+rgnemCJptIY5rHPqMQ0Wv9iV/20vccvDzcKHnxlbg1/KR+sjOUGoXFt2pLkwh7xg51N3NiuGq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAfe0d7/9KVEGem1qWl4QtRNEQZRlKsCWR+qpVN8EZw=;
 b=FSLWq94qHGbK41XIi8dnPOLpTssDGrCtC9FeTdVybqTlUkTiWTgx/QJOoCnb+roMfaJJYycmhpTfUKXudZOrEr5RY/JkNUI0rGJgWPBsK+8BXAsNbywIR/zi8k76X0lHR3lDnQxQMpToabTIyyMlgtCI2f+z6LER4I5dSZXT18E=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 14:24:03 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::37) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:24:03 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:24:01 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/17] drm/amd/display: add shared helpers to update psr
 config fields to power module
Date: Thu, 5 May 2022 10:23:20 -0400
Message-ID: <20220505142323.2566949-15-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b950bcb-d216-4d72-baa7-08da2ea2e7d3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB241634A014F6593309539D108DC29@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiS4UMREmr4AP5zSvhi/LQxXJYqQTVanuYLFGPtdRQnFu0dlt+PJYTPdRP0axM/Cv+xzsISDuHD4krmatAZN5q1/MpivmGGim8Jnmfw8c1FQBpglbI58CG24GZJhZeuc16p5sGJd51uqab0REEgJHyLJQqyEvIxRwGJhfPZ6tZY9ZSLzCBSI86zIzIuNj/fK0QI43cweAEvcHiIUf+OurxV2oJsZAe7ja9/YKkuQSKF47Exp3+3SBb9SmpVoXBCVN3gxyUYM3N5P4G1SH4G9ENsU/c6eG7KfX4b4DQqodcjCli3AIUe5BivLVKlMrQudQ5N9YqcfoBMwGqIVTSO1YCpxlp1fCog/mMC0rt6aR4IfURC6xqybT/hdLerLBBhsklXHnGOapLdvKScTwlsZpSjFDFpMQfEoTGntI/G0qOHQtV+p+sE6H8SRcjhrN1h0snzsKVHrB4oOmtWcYYgtqNBxBu4jcO4FPNUznBMyfQwv+sjPYJ40vhLeIPaw+c1udliNJXXjRTXau5IYfztBG4QlfYcI3N6BbhBCvIi+QXl8bHC6RVUfP5W0SJY/XjK9mylsih1p4+AQxFL0ttbiLW44WGBvVNA0dmRh8w42r4Se+4wH5VCewYzu0b86PVENVDHZY3JfCdpiXYYUIPUo3fxiwViQrVExY53/LWgJBDCfpv1AwNVUty7UF9qEVJwSkkevbvLGFkjDK5yBLYckJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70586007)(8676002)(86362001)(70206006)(36756003)(7696005)(6666004)(356005)(508600001)(54906003)(6916009)(26005)(316002)(81166007)(2616005)(15650500001)(186003)(16526019)(426003)(336012)(47076005)(40460700003)(2906002)(1076003)(5660300002)(8936002)(36860700001)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:24:03.4245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b950bcb-d216-4d72-baa7-08da2ea2e7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Currently the amdgpu DM psr configuration parameters are hardcoded
before feeding into the DC helper to setup PSR. We would define a
helper which is to calculate parts of the psr config fields to
avoid hard-coding.

[how]
To make helper shareable, declare and define the helper in the
module_helper, to set/update below fields:
- psr remote buffer setup time
- sdp tx line number deadline
- line time in us
- su_y_granularity
- su_granularity_required
- psr_frame_capture_indication_req
- psr_exit_link_training_required

add another helper to check given the stream context, if there is
only one stream and the output is eDP panel connected.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 73 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.h |  6 ++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 97928d4c3b9a..1be4fcfa578a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -822,3 +822,76 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 
 	return false;
 }
+
+/**
+ * mod_power_calc_psr_configs() - calculate/update generic psr configuration fields.
+ * @psr_config: [output], psr configuration structure to be updated
+ * @link: [input] dc link pointer
+ * @stream: [input] dc stream state pointer
+ *
+ * calculate and update the psr configuration fields that are not DM specific, i.e. such
+ * fields which are based on DPCD caps or timing information. To setup PSR in DMUB FW,
+ * this helper is assumed to be called before the call of the DC helper dc_link_setup_psr().
+ *
+ * PSR config fields to be updated within the helper:
+ * - psr_rfb_setup_time
+ * - psr_sdp_transmit_line_num_deadline
+ * - line_time_in_us
+ * - su_y_granularity
+ * - su_granularity_required
+ * - psr_frame_capture_indication_req
+ * - psr_exit_link_training_required
+ *
+ * PSR config fields that are DM specific and NOT updated within the helper:
+ * - allow_smu_optimizations
+ * - allow_multi_disp_optimizations
+ */
+void mod_power_calc_psr_configs(struct psr_config *psr_config,
+		struct dc_link *link,
+		const struct dc_stream_state *stream)
+{
+	unsigned int num_vblank_lines = 0;
+	unsigned int vblank_time_in_us = 0;
+	unsigned int sdp_tx_deadline_in_us = 0;
+	unsigned int line_time_in_us = 0;
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	const int psr_setup_time_step_in_us = 55;	/* refer to eDP spec DPCD 0x071h */
+
+	/* timing parameters */
+	num_vblank_lines = stream->timing.v_total -
+			 stream->timing.v_addressable -
+			 stream->timing.v_border_top -
+			 stream->timing.v_border_bottom;
+
+	vblank_time_in_us = (stream->timing.h_total * num_vblank_lines * 1000) / (stream->timing.pix_clk_100hz / 10);
+
+	line_time_in_us = ((stream->timing.h_total * 1000) / (stream->timing.pix_clk_100hz / 10)) + 1;
+
+	/* psr configuration fields */
+	psr_config->psr_rfb_setup_time =
+		(6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME) * psr_setup_time_step_in_us;
+
+	if (psr_config->psr_rfb_setup_time > vblank_time_in_us) {
+		link->psr_settings.psr_frame_capture_indication_req = true;
+		link->psr_settings.psr_sdp_transmit_line_num_deadline = num_vblank_lines;
+	} else {
+		sdp_tx_deadline_in_us = vblank_time_in_us - psr_config->psr_rfb_setup_time;
+
+		/* Set the last possible line SDP may be transmitted without violating the RFB setup time */
+		link->psr_settings.psr_frame_capture_indication_req = false;
+		link->psr_settings.psr_sdp_transmit_line_num_deadline = sdp_tx_deadline_in_us / line_time_in_us;
+	}
+
+	psr_config->psr_sdp_transmit_line_num_deadline = link->psr_settings.psr_sdp_transmit_line_num_deadline;
+	psr_config->line_time_in_us = line_time_in_us;
+	psr_config->su_y_granularity = dpcd_caps->psr_info.psr2_su_y_granularity_cap;
+	psr_config->su_granularity_required = dpcd_caps->psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED;
+	psr_config->psr_frame_capture_indication_req = link->psr_settings.psr_frame_capture_indication_req;
+	psr_config->psr_exit_link_training_required =
+		!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
+}
+
+bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_state *stream)
+{
+	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 1a634d8c78c5..316452e9dbc9 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -27,6 +27,7 @@
 
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
+#include "dc/inc/core_types.h"
 
 struct resource_pool;
 
@@ -53,4 +54,9 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		unsigned int inst);
 
 bool is_psr_su_specific_panel(struct dc_link *link);
+void mod_power_calc_psr_configs(struct psr_config *psr_config,
+		struct dc_link *link,
+		const struct dc_stream_state *stream);
+bool mod_power_only_edp(const struct dc_state *context,
+		const struct dc_stream_state *stream);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.25.1

