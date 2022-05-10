Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D670C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2225010EA0A;
	Tue, 10 May 2022 20:46:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C4A10EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuKXgn6oDuBwWKzttPv4LneGwlawLwGSEF68/QrVJKtrYYZ6s+XasKpCTj/9scyADNxwJm2wNy2oy5m1410PTFUJzPCoA49IK1j+V1t+ZLRKEg/Qsxa6tOxwr/LlKTzY9LRjlnjPVDeL29y+AAA3sZVXZc9Qy0hL+iRvZpdHuAltf1F494bt8czj/3Vcb69ZnCJUKFIqmnxDbycyo0Rlw+if+pfd8D91Io30wtKyZT+jatLLE7RsD7wYxJhUfaEXvZgnstcuPrTlV/szEhIojDggvVZX4cgAAmSlmER0Mto8zQKXaEBs/62xocUbpt1yKVHO/6OwMNRjZSeABTXNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuxKCKNl64HBzBW9tJ9RHErQrkjiJnF3FmvUbd6gXUs=;
 b=U88qvYpGwRFYKnt5lXeWe8bEXK6wQI122lVBtOvVVIVlknjjGV+J6ncn8fZINPFBHOZGzW567PSscirz2nOic8r0xoQiUUv231wjpOIGVJs0lPUlthj1YXldVgmNqXkofWatWE2i4Q1+OvSuPN5G3tqfuDBIcJXt3jevRi3Zq4ocKlZHmUVvMfnKNAp8t5Dwe8m2HZyXk5TumIJYlhHUrsuGXPmpb4nq7KdQFrXzdnxdmku3/5pOhi/UWFaydbvxN6XioJNFDokUc2HhKWJYnYhXO2t10YWwHawNN1asqATfRPpkGqbxrASoP+HtNDjTna3SJqFhxY7J8nCURpc9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuxKCKNl64HBzBW9tJ9RHErQrkjiJnF3FmvUbd6gXUs=;
 b=plcAVX53Hxyuq5HKP439sGjupOwBZQ4luO4puNfgmeIsbUaJM1Xx5mQxagWh/9Qj5GVMkh4wpgMtZr3lpSv12jyasDtR8yzKdCyY/F4jsRaIP355GJDnfAP9abi4q9oUzoiebQYHQ+wpJcV7yHzYVEmZg9gxDgmDr5ReDKNW9Cs=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:46:30 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::31) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 20:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:27 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:24 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 14/19] drm/amd/display: add shared helpers to update psr
 config fields to power module
Date: Tue, 10 May 2022 16:45:03 -0400
Message-ID: <20220510204508.506089-15-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7bebc24-9c9e-48e7-be41-08da32c628d2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB193186AAABB3A1E72E108F068DC99@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhQrVCIRSuR5xhp28LgXMMA8cL2gxIpWiQ0u6l4RTKE/17Mo7tlvK8XtJYan3HJem9WuE6pLIbCnfXoejJ0bbJOgB5WLU2Mk+6dIHrtnzZKBrmmVIGNUlUl/tZ2bzbbogjW+iORtUNUYhxkt+C3sHEzFA9Xdp9jdW7Rri0TeXd+BQpFhsxE+OKzuG+HuJ0+1u4Z0Dlb32mIJSJ+EaGaZ+eB4uZckcAfnSp1BCAL38fScRQsrgCVUpAIXaRKrSG9BvtcbBiznIx9OxVB8CioIFy++VD7w0UhIZYYAQunnTO+aI6IaP5rbx4rdBQdNTbQIvxxm9tFlAs3HnYCIGen9SKRBI2x0sfTL97cy8KrVhi0U16VUmKjB90+6LGY8Pr+zP3AzFteofrDIDXsR8iWGGiGmEBl1Rgs54BBCw+v1O6wEjaezGa3jxeJlVu1QzANrMXy//FdA/jxp3E1uzcXNtdCaAXxZSX933w39xq3umdbAWIbR3owH6C5Yx6kLoEjYsMzUGl83KyIjV1izNH2eQpupyfXNJl03O6edOOdeMbqGmwQVT6SRA9jCJZv5+Rcszy9pmdB0Y2+TZydCFg6fpaAv664F3fuo67GT3nkAesoO6WZ8tYgJwJv3AsAo/ehPyaW4ZfP4V1egJr9uGplz2Zb5Q34UkcqNEQPJhYKFVEMBzP/8JAac9qg9CWQK6NqmyaB5OTGNSzl80bwX1rbTTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(54906003)(7696005)(86362001)(82310400005)(6916009)(316002)(356005)(15650500001)(6666004)(81166007)(2906002)(70586007)(36756003)(336012)(426003)(47076005)(70206006)(186003)(2616005)(5660300002)(83380400001)(26005)(40460700003)(1076003)(4326008)(8676002)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:29.4284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bebc24-9c9e-48e7-be41-08da32c628d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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

changes in v2:
------------------
- add detailed comment for how psr setup time is calculated as per
  eDP 1.5 spec

Cc: Chandan Vurdigerenataraj <chandan.vurdigerenataraj@amd.com>

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 84 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.h |  6 ++
 2 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 97928d4c3b9a..bc239d38c3c7 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -822,3 +822,87 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 
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
+	/**
+	 * psr configuration fields
+	 *
+	 * as per eDP 1.5 pg. 377 of 459, DPCD 0x071h bits [3:1], psr setup time bits interpreted as below
+	 * 000b <--> 330 us (default)
+	 * 001b <--> 275 us
+	 * 010b <--> 220 us
+	 * 011b <--> 165 us
+	 * 100b <--> 110 us
+	 * 101b <--> 055 us
+	 * 110b <--> 000 us
+	 */
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

