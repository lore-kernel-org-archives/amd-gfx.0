Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967CAEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AA310E5A4;
	Thu, 22 Jun 2023 21:58:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E2510E5A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHiUTOt7ySwA9J15qBoTH4LrWNbSH+UJVIgzIQSaax8wIPDX4KFE1fwXNQBeb+vINITa9fkcdVDURf96yMVG6ELS9xVe3v7Gk1m7GfEOFsINpVqavnZR1gQSpwnmIH0n7+u0azBm0Kt6ivk07AuK6NUBIxM2r0/+Kg7iMdsg4Aa19sgOxIimqzoiv441mRnxAFVbo386CMQPPEgDqt0Vk6iz3cxhRlhvUhQetLB1e99c9VUZRjIJax+ZjhPcUvWMvWjVDam9lBNWn9stQZImVj1pVzahD9QhZ4vapN/RIcXtaHE5dfdCLKmRVH1LWsqoVIYP+yYQquD8RfIp0uPt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMPHcIOqdGqpZ3hHOFEC8/tOMsjtZ2otBnJsTPQQYSY=;
 b=WXcPT09JYYL+iVFFA8wzR1cjndpb4wI8Pwj1FvQ6H7+Q+IFQSM2pQ5Af87wxN+YsT8Jy6aofaPOZs+1ZEh3RcAE39zXYsZ6okxCR9xPxVcRpTHPjnwKIt3eDXmy/8pxocvFIN4fq0+0CaQCjNK5n3SWJ8GKjQYF1JaLdxFz7azNMOaXp0U6fpLhDuVBJk9JW5ufBJAVUXxBDqQ3BvhQmP27pX+DacwNEZR9T858WJyNEN0k+6ul8koQ/w6jQWOwxvRtU9sUN5ShIFWK/thBSmX2geHcreK67+8tMx5IL7WsRe20bb0mAupJZYRqx8g+kKKM/cpvogiXkjk/vVwuusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMPHcIOqdGqpZ3hHOFEC8/tOMsjtZ2otBnJsTPQQYSY=;
 b=FoEVDSGXIFJhIS6MN+8LGyija/Oubu4XkEfxJeKXpdvMx/UhR5wS0jHxOOSJgFU6zyBVsnX+DwZzWhbulhu385ZWEEPsDtfLlBzS+B6u2O8KGNkLfLcTrjyTwaPe5rU6NfQ3/rTCvfm/Tul005GrUr/LuOVani8JbMhiy4sQTqM=
Received: from SN4PR0501CA0118.namprd05.prod.outlook.com
 (2603:10b6:803:42::35) by PH7PR12MB7283.namprd12.prod.outlook.com
 (2603:10b6:510:20a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:58:05 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::e1) by SN4PR0501CA0118.outlook.office365.com
 (2603:10b6:803:42::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: Work around bad DPCD state on link loss
Date: Thu, 22 Jun 2023 15:57:25 -0600
Message-ID: <20230622215735.2026220-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8ab5db-d8a2-4b16-8ffe-08db736bc1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRcwKoLj1Xf4ii++dtzu+O/hu8Rpcq5+hPerKvBqXVK+5ldgUcOwDVkegc+cvgprU3eB2upWJ5zL/QHRfc3IVQ7U5AjtcJ3F6J2PMntLgxTuIO49D1VHcWYL0UKMiPgO0df1tbfPzrxlexjYq3weJXVYmDZ6rY0slAj/zrJ10WhSauOhKtdfflXXEkG7gh2NsivruBiF6Z8YIrjTw9lkPitmK4NJ8mbtsK2R2vOBsIjlSf0ALiYcXHOgv9olaWVq+I1KvzqANsjAQS23XXQ39BMy3n4YcZkXf12ZBhW+MuYbRPeSvBZ6vz0ckOjdhkZMxiwQ0SJUFh1qPz8W0ecWaJpgIEhM/DAwObAYo4VP4/Z/ESohvdykUvIcpcczuR1X33PYC07SgR6vLieo7Q4lPUpjTXtqqdf388gG5IxErQZEQ4m1VVeJWIOFcCIO2duWwJaNPTfBGs/TyvururBlAHVCYbDIAkuzmGpjxt2iM0OgzalJA0t5iUzj9O7EAcEaApUwNKZFXwVEczYrmirDM2puDcSYFy/GI4bk0Vyxi6W50809mjQkJ63cO5wbD0qhlSPiY+MLunpPNQbFMpP8b8YVYj+wgBc7ch9WOYo3yEn1zTnfamwhFstY33RTgCDhbL2io/AE+F14nLFv27xNoQYJaj0Ia22HmfPBENtJpQauHbRiHb8+F+STzSAp0LYvHuAu4onyof+kd2JyAdFDc5QuFl5jWthnyoiWWESdkV/wMeT8idYLB6WmVL12j+vUBTlHTpR4dwIOuHt69YXLIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(82310400005)(81166007)(40480700001)(86362001)(40460700003)(316002)(2616005)(6916009)(8676002)(41300700001)(8936002)(70206006)(70586007)(4326008)(336012)(5660300002)(426003)(83380400001)(1076003)(478600001)(6666004)(54906003)(26005)(16526019)(186003)(36756003)(36860700001)(47076005)(2906002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:05.0504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ab5db-d8a2-4b16-8ffe-08db736bc1ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
This display doesn't properly indicate link loss through DPCD bits such
as CR_DONE / CHANNEL_EQ_DONE / SYMBOL_LOCKED / INTERLANE_ALIGN_DONE,
which all remain set.

In addition, DPCD200Eh doesn't match the value of DPCD204h in all cases.

For these reasons, we can miss re-training the link, since we don't
properly detect link loss with this display.

[Why]
Add display-specific workaround to read DPCD204h, so that we can detect
link loss based on 128b132b-specific status bits in this register.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../dc/link/protocols/link_dp_irq_handler.c   | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ea0b78ef351d..24f580bdac6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1525,6 +1525,7 @@ struct dc_link {
 		bool dpia_forced_tbt3_mode;
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
+		bool read_dpcd204h_on_irq_hpd;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index b1b11eb0f9bb..ef8739df91bc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -208,6 +208,25 @@ void dp_handle_link_loss(struct dc_link *link)
 	}
 }
 
+static void read_dpcd204h_on_irq_hpd(struct dc_link *link, union hpd_irq_data *irq_data)
+{
+	enum dc_status retval;
+	union lane_align_status_updated dpcd_lane_status_updated;
+
+	retval = core_link_read_dpcd(
+			link,
+			DP_LANE_ALIGN_STATUS_UPDATED,
+			&dpcd_lane_status_updated.raw,
+			sizeof(union lane_align_status_updated));
+
+	if (retval == DC_OK) {
+		irq_data->bytes.lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b =
+				dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b;
+		irq_data->bytes.lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b =
+				dpcd_lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b;
+	}
+}
+
 enum dc_status dp_read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
@@ -249,6 +268,13 @@ enum dc_status dp_read_hpd_rx_irq_data(
 		irq_data->bytes.lane23_status.raw = tmp[DP_LANE2_3_STATUS_ESI - DP_SINK_COUNT_ESI];
 		irq_data->bytes.lane_status_updated.raw = tmp[DP_LANE_ALIGN_STATUS_UPDATED_ESI - DP_SINK_COUNT_ESI];
 		irq_data->bytes.sink_status.raw = tmp[DP_SINK_STATUS_ESI - DP_SINK_COUNT_ESI];
+
+		/*
+		 * This display doesn't have correct values in DPCD200Eh.
+		 * Read and check DPCD204h instead.
+		 */
+		if (link->wa_flags.read_dpcd204h_on_irq_hpd)
+			read_dpcd204h_on_irq_hpd(link, irq_data);
 	}
 
 	return retval;
-- 
2.39.2

