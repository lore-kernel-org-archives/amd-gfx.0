Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D21C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F8C10E675;
	Wed, 19 Jan 2022 08:25:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC1110E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5maq3NWN6foCC6mZFOY79XhmE020fXg9RnFchTJ9LEyH/xiOxDeN7xStVwYGRcskpFzya12I/Iyv/W13jzxKgXTT1vW5fVwN9/8nbpSnLl5TDqumKSOgBNLAbI9LjWq0N7xYBZsQk890t18MYjCZbdVMXgoEpA+8Dkw4V0a20Q6M4in37ukfArK/g7MaBbqsOlLCyhYOhFniWcHYTWPGnLjmId7cd8zENVRSmNj/qxNrG8FHlOzglenCCLjQ29IphdQTZii2ftzsfqtjLcIdzFERKNiv1EfBrhhbI3KbKlEUGxgrnMbTmj+qiPqQoyUYRj1qODxfrISitbXif+mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu9soYcp0TrunRTe1rthIn/i/pQ5wTMtMVhyxPA2QS4=;
 b=HO7tmLfgGqpYNDaiZQvq5gBqLinEpF8+eKVfLxL2kf2VPi2fOUsFUSdYsZ+o+41ew586Dd/eVnfVq6Y9RCUaNUM2B1+8nEFCgsfkyQTfqIDUoOKmnmQrXaMXQ/7JNW1s71932Wo7pG0FYCqBxppr1yE2LOY3bd0ofOi1ztnnZim3Ww/TfbWvEAdg04cPQBM7r2+SB05QActW9YWHvKOvCk4x2UK0jPYXjKHp/phNKlZpP7Hlwuhf8OtNd9fbzVhbjk8lMQvW6iNg1jQ379WMzrF6bVcywO4oycoWDkJtxQF4qQNliWOXcsvD7VSqm1vh6qMdK9tO+f/DToVuYGhVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu9soYcp0TrunRTe1rthIn/i/pQ5wTMtMVhyxPA2QS4=;
 b=IbGzT7+vnMQ7kR3QHfvQ0AeDLdjNg11t4+p7kc4YRyT41kx1JSKIx7qIwan6TmRCTHzjmWlRQDWkVqNOwzR8VBnCymrWGr4n6olog5AunLxRH45fHzIuZq4H54kEA4MdsUe++ICm8ykAlMFqr+c1iHBvsZOK7GzJ2EhrW3N0bYM=
Received: from BN6PR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:405:4b::17) by DM6PR12MB4009.namprd12.prod.outlook.com
 (2603:10b6:5:1cd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 08:25:12 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::ca) by BN6PR1401CA0007.outlook.office365.com
 (2603:10b6:405:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:11 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:07 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/display: Add work around to enforce TBT3
 compatibility.
Date: Wed, 19 Jan 2022 16:24:37 +0800
Message-ID: <20220119082443.1046810-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b898e5-8c4e-418f-6eb0-08d9db253649
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40098AF66A4EF245A0719C53FC599@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpbhALSeahr2WGqAc7fPd76UGAAOuDpNVu7NB/qh0bM2f17LvzNdzUwOqP7kjGSvZgPFkFRlzxG9h3EzFsBBG3hoybv62gNJQxW9Aa6J/MpM8HdOwmdJlLmAn6Dre7led4xpKsyqRxSY+fNLoAPQDGcZqcMnvRU7fh2tjWwwQe8s2JAuO+Xoz9QRHqfAa3SIrSJgncnzgCma3WMLoT+tcyB7X04iQ+mJCx0medDctTlkpF9Loh7+86rDoonysaRoMTk5dy5JYJrYa7L7on4pVKpjAsG5Xae+vEpKxva9wEZ6ocdw+0+9bdSK2VFJ6oozb/dIFigR7TVLROS3thKliilkGmLRsfuvrejKR+TcGo99SAPhFKI6vvym7nGJ/QyAofslDnVY8i55yLcAtpmEenk95YLSJRfYi9UsKVHMrrAOZVEHwkgZihPALzBJzIG+ELhuzoiFyAY5WjuHT38gDhLc0wM/H3k21nKW6IPdaosCNFAFTHDco4GkxWCL3xMRBgw1md57R0g0LiuxLbYeU4T5V88qMm4d2KFi4cjFVHg983HKYkg7w3CQaFRPza7UGeKWp8Q2E9Pts24oAHgf7grr2YwwULw7ZHiMWbh93n2YooqxpANjA6e+OEWcOx1PmtxVuOO8DrOnJ7Md7rHuQ4oy3JSsyN9Eht9Hf5/QyIZaEKi/XnJD5IJi0J3zWRVhBLfyOhykXn0BqnNDUxSu33G5BZFgssdo69u/amcOmMuxprVXXm050P6Vz5io/40z7JTLcTBUWuaP7cgth5pX0QYxWMmHP2wG+Bvtmyu52KQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(4326008)(6666004)(1076003)(6916009)(508600001)(186003)(82310400004)(36860700001)(40460700001)(70206006)(86362001)(70586007)(47076005)(54906003)(81166007)(36756003)(8936002)(8676002)(26005)(426003)(356005)(7696005)(2616005)(2906002)(316002)(5660300002)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:12.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b898e5-8c4e-418f-6eb0-08d9db253649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
According to the USB4 specification, FEC and DSC should be disabled
when a USB4 DPIA operates in TBT3 compatibility mode.

[How]
Upon detecting that a USB4 DPIA is connected to a device that is known
to operate in TBT3 mode, disable FEC and DSC support if they have been
reported by the TBT3 device.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  1 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 ++++++-----
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 .../amd/display/include/ddc_service_types.h   |  2 ++
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5396a19eeebc..6bef6724a700 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -806,6 +806,7 @@ static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 			link->type == dc_connection_mst_branch &&
 			link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+			link->dpcd_caps.branch_hw_revision == DP_BRANCH_HW_REV_20 &&
 			link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
 			!link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around)
 		link->wa_flags.dpia_mst_dsc_always_on = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5cc8c2633558..b3b75a98beaa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5550,6 +5550,28 @@ static bool retrieve_link_cap(struct dc_link *link)
 				link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw));
 #endif
+
+		/* Apply work around to disable FEC and DSC for USB4 tunneling in TBT3 compatibility mode
+		 * only if required.
+		 */
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+				!link->dc->debug.dpia_debug.bits.disable_force_tbt3_work_around &&
+#endif
+				link->dpcd_caps.is_branch_dev &&
+				link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+				link->dpcd_caps.branch_hw_revision == DP_BRANCH_HW_REV_10 &&
+				(link->dpcd_caps.fec_cap.bits.FEC_CAPABLE ||
+				link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT)) {
+			/* A TBT3 device is expected to report no support for FEC or DSC to a USB4 DPIA.
+			 * Clear FEC and DSC capabilities as a work around if that is not the case.
+			 */
+			link->wa_flags.dpia_forced_tbt3_mode = true;
+			memset(&link->dpcd_caps.dsc_caps, '\0', sizeof(link->dpcd_caps.dsc_caps));
+			memset(&link->dpcd_caps.fec_cap, '\0', sizeof(link->dpcd_caps.fec_cap));
+			DC_LOG_DSC("Clear DSC SUPPORT for USB4 link(%d) in TBT3 compatibility mode", link->link_index);
+		} else
+			link->wa_flags.dpia_forced_tbt3_mode = false;
 	}
 
 	if (!dpcd_read_sink_ext_caps(link))
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5ba6abdbd3aa..14abba495f4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -519,12 +519,13 @@ union root_clock_optimization_options {
 
 union dpia_debug_options {
 	struct {
-		uint32_t disable_dpia:1;
-		uint32_t force_non_lttpr:1;
-		uint32_t extend_aux_rd_interval:1;
-		uint32_t disable_mst_dsc_work_around:1;
-		uint32_t hpd_delay_in_ms:12;
-		uint32_t reserved:16;
+		uint32_t disable_dpia:1; /* bit 0 */
+		uint32_t force_non_lttpr:1; /* bit 1 */
+		uint32_t extend_aux_rd_interval:1; /* bit 2 */
+		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
+		uint32_t hpd_delay_in_ms:12; /* bits 4-15 */
+		uint32_t disable_force_tbt3_work_around:1; /* bit 16 */
+		uint32_t reserved:15;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index c0e37ad0e26c..704323654468 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -197,6 +197,8 @@ struct dc_link {
 		bool dp_mot_reset_segment;
 		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
 		bool dpia_mst_dsc_always_on;
+		/* Forced DPIA into TBT3 compatibility mode. */
+		bool dpia_forced_tbt3_mode;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index a2b80514d83e..57f92bd2814f 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -34,6 +34,8 @@
 #define DP_BRANCH_DEVICE_ID_90CC24 0x90CC24
 #define DP_BRANCH_DEVICE_ID_00E04C 0x00E04C
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
+#define DP_BRANCH_HW_REV_10 0x10
+#define DP_BRANCH_HW_REV_20 0x20
 
 #define DP_DEVICE_ID_38EC11 0x38EC11
 enum ddc_result {
-- 
2.25.1

