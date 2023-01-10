Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02701C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 564C310E611;
	Tue, 10 Jan 2023 16:57:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A3710E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPAYehd9aUhFTpEBi/RDu0Zl29nFlzDyiLhAWyWAaLvVVLaUUMARPcXAfSN3JwMyMosFx+Cs2jcu1owXy625EX4iYeJu9MRiIsKAxsb+T86iqVMsJUpapzsd+eOD7uSnTmULz7jTFb2oCHEqEvbuaijVgNJwi3kVs/Rze363oa0Vt3tC05q3S7srgnYGD0i8bkKmR+tX3a2OvStBVCgPsULMaY1kwG6GyofhXS4H1BSBJvowEyy8cCte27pYQU0JcL+5PdBH4PGDtng+0my4NnbQt8C6fuO7nGZNVgctSNQCaKIbyp8JqNxdKWqB7FGqy8byJ3DCyIqneMscqZwkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niinEzBNNj/+axC/x3wVnJTwYvofw+tTaJkgPfkGgdo=;
 b=SjFUi7dgKR1IObugO0hVIqEVHC7u0D5X+/xYKHNxY8cj5dxPl2RZssdIj1dG7BZZGeRiDgGmm81of1SFGFCMV0jHRVkxrG4n4Wm4v76DNHL+B9Df2qaE/xnSw/cJnkYqgaMwyyeHib4Mi8uX1Ez7eR8jceyzhEUzS093W/jqaYjJSuLzqTL+8eCt0JTWneZHbiexsV4jqeYwqcFSMhzgExIfxrnBGh7MHwZe06ymC1Fs7blu2VnPfaLqgBzWUma/+oFPfUzEc8ZvzG/dlH93uNwYG9CQRKoqTP/Suy4aCChICJB/TmoGcw+jgLu9lImWHwqCbD7/nDYG6sWywzu5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niinEzBNNj/+axC/x3wVnJTwYvofw+tTaJkgPfkGgdo=;
 b=L7TDJ5Xs5mET8f0sdGpk4FNutvr0ZWRQpwSePoWjhsa1fW/evNEMr3V+kfVB7lYZkI6bEMTag1J+GivRzQpG/ChZk+MS5pdTO8mkzaBWtGFHl4QfkZ4XFwZeSo6Ixg2oD2UsyABOIZp/mubtS5nvhdTENDGOLsnWHIOW9njJxYU=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:12 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6e) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:12 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:10 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/37] drm/amd/display: Update dmub header to match DMUB
Date: Tue, 10 Jan 2023 11:55:08 -0500
Message-ID: <20230110165535.3358492-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c25ebe-2fef-4adf-997d-08daf32bb823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvggAaxeCpTlepvDgdIqry5wAeS6QUSzZqF14F5ZLCABocUXAx3wi9Yn1E1GQqBmKRyZXBDXWYKtDKX+nK2WIhzGKF2gIuedRsnbpGSXDEfrnSkyydYH1m+YNWHKHHLZOnTwDQTKweg/RUAOg/taQLKbjsqfnRUAnFzBWYZxzBK5NL+b7h1d5i9Uu8F5jyMm+XZXMYXGEjD9gIxdljF6+HFbWDwEJLCLBNzkpGLWFJs2YYab7NKfEFidDd/obEqx1SVdXLfaAzF8RHe9FY1EN2HmITWM7Vag2ymgD61XTXjmdU4WQ9BUjzWUq08f5cLq3DhgA2T7ITm3djQKnJK6PpZiys1xsow1WzXjoVStjzYtPmCi1B1AkPg11BY8fgVpJaGwVEv+E9ka8cqlHBN/F21w/VxkDYB+YjGWG4DSCDVazeX5eLtbZEH3gFlquhZBGzASswfSf3aTiLqQZBZo6z/eHOUqLHxE5O9ltx6uusWmfynbWxNHuAp54rBX7pu6x+V6wEpBlhrwsZMdVbYHCSfGNUWPF1QuaHcQN3bsffqOLOszD9uqm3f9tXkPNI7vjt6XRQnD465I+zadw+uuyT5Z5Axlyrlu+nxk6aQfnY2du1ycQb2g7ssq7VDekmQn0NGPe768CZjsgFF7fczIfRjBLosZQ29jU/BDi9wDPZZaOvhb0vsQr3jaw60tFDOqnrOgRaYN5FCpWsX5KB+QY0i9G8teh9x/S1VQ+kh5xa4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(40480700001)(478600001)(16526019)(1076003)(186003)(6916009)(336012)(70586007)(8676002)(41300700001)(70206006)(2616005)(4326008)(54906003)(316002)(7696005)(47076005)(83380400001)(36860700001)(86362001)(81166007)(82740400003)(356005)(40460700003)(426003)(82310400005)(2906002)(8936002)(5660300002)(15650500001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:12.3424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c25ebe-2fef-4adf-997d-08daf32bb823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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
 Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Mustapha Ghaddar <mghaddar@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
Last PR missed name of a struct to match in DMUB

[HOW]
Update the logic in dmub_cmh.h header

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  16 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 165 +++++++++---------
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  20 +--
 3 files changed, 109 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c8274967de94..a391b939d709 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -130,6 +130,17 @@ enum dmub_notification_type {
 	DMUB_NOTIFICATION_MAX
 };
 
+/**
+ * DPIA NOTIFICATION Response Type
+ */
+enum dpia_notify_bw_alloc_status {
+
+	DPIA_BW_REQ_FAILED = 0,
+	DPIA_BW_REQ_SUCCESS,
+	DPIA_EST_BW_CHANGED,
+	DPIA_BW_ALLOC_CAPS_CHANGED
+};
+
 /**
  * struct dmub_region - dmub hw memory region
  * @base: base address for region, must be 256 byte aligned
@@ -465,7 +476,10 @@ struct dmub_notification {
 		struct aux_reply_data aux_reply;
 		enum dp_hpd_status hpd_status;
 		enum set_config_status sc_status;
-		struct dpia_notification_reply_data bw_alloc_reply;
+		/**
+		 * DPIA notification command.
+		 */
+		struct dmub_rb_cmd_dpia_notification dpia_notification;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4dcd82d19ccf..328978ec6814 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -770,7 +770,10 @@ enum dmub_out_cmd_type {
 	 * Command type used for SET_CONFIG Reply notification
 	 */
 	DMUB_OUT_CMD__SET_CONFIG_REPLY = 3,
-	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5
+	/**
+	 * Command type used for USB4 DPIA notification
+	 */
+	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5,
 };
 
 /* DMUB_CMD__DPIA command sub-types. */
@@ -780,6 +783,11 @@ enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_MST_ALLOC_SLOTS = 2,
 };
 
+/* DMUB_OUT_CMD__DPIA_NOTIFICATION command types. */
+enum dmub_cmd_dpia_notification_type {
+	DPIA_NOTIFY__BW_ALLOCATION = 0,
+};
+
 #pragma pack(push, 1)
 
 /**
@@ -1517,84 +1525,6 @@ struct dp_hpd_data {
 	uint8_t pad;
 };
 
-/**
- * DPIA NOTIFICATION Response Type
- */
-enum dpia_notify_bw_alloc_status {
-
-	DPIA_BW_REQ_FAILED = 0,
-	DPIA_BW_REQ_SUCCESS,
-	DPIA_EST_BW_CHANGED,
-	DPIA_BW_ALLOC_CAPS_CHANGED
-};
-
-/* DMUB_OUT_CMD__DPIA_NOTIFY Reply command - OutBox Cmd */
-/**
- * Data passed to driver from FW in a DMUB_OUT_CMD__DPIA_NOTIFY command.
- */
-struct dpia_notification_reply_data {
-	uint8_t allocated_bw;
-	uint8_t estimated_bw;
-};
-
-struct dpia_notification_common {
-	bool shared;
-};
-
-struct dpia_bw_allocation_notify_data {
-	union {
-		struct {
-			uint16_t cm_bw_alloc_support: 1;	/**< USB4 CM BW Allocation mode support */
-			uint16_t bw_request_failed: 1;		/**< BW_Request_Failed */
-			uint16_t bw_request_succeeded: 1;	/**< BW_Request_Succeeded */
-			uint16_t est_bw_changed: 1;			/**< Estimated_BW changed */
-			uint16_t bw_alloc_cap_changed: 1;	/**< BW_Allocation_Capabiity_Changed */
-			uint16_t reserved: 11;
-		} bits;
-		uint16_t flags;
-	};
-	uint8_t cm_id;			/**< CM ID */
-	uint8_t group_id;		/**< Group ID */
-	uint8_t granularity;	/**< BW Allocation Granularity */
-	uint8_t estimated_bw;	/**< Estimated_BW */
-	uint8_t allocated_bw;	/**< Allocated_BW */
-	uint8_t reserved;
-};
-
-union dpia_notification_data {
-	struct dpia_notification_common common_data;
-	struct dpia_bw_allocation_notify_data dpia_bw_alloc;	/**< Used for DPIA BW Allocation mode notification */
-};
-
-enum dmub_cmd_dpia_notification_type {
-	DPIA_NOTIFY__BW_ALLOCATION = 0,
-};
-
-struct dpia_notification_header {
-	uint8_t instance;							/**< DPIA Instance */
-	uint8_t reserved[3];
-	enum dmub_cmd_dpia_notification_type type;	/**< DPIA notification type */
-};
-
-struct dpia_notification_payload {
-	struct dpia_notification_header  header;
-	union dpia_notification_data      data;   /**< DPIA notification data */
-};
-
-/**
- * Definition of a DMUB_OUT_CMD__DPIA_NOTIFY command.
- */
-struct dmub_rb_cmd_dpia_notification {
-	/**
-	 * Command header.
-	 */
-	struct dmub_cmd_header header;  /**< DPIA notification header */
-	/**
-	 * Data passed to driver from FW in a DMUB_OUT_CMD__DPIA_NOTIFY command.
-	 */
-	struct dpia_notification_payload payload; /**< DPIA notification payload */
-};
-
 /**
  * Definition of a DMUB_OUT_CMD__DP_HPD_NOTIFY command.
  */
@@ -1636,6 +1566,79 @@ struct dmub_rb_cmd_dp_set_config_reply {
 	struct set_config_reply_control_data set_config_reply_control;
 };
 
+/**
+ * Definition of a DPIA notification header
+ */
+struct dpia_notification_header {
+	uint8_t instance; /**< DPIA Instance */
+	uint8_t reserved[3];
+	enum dmub_cmd_dpia_notification_type type; /**< DPIA notification type */
+};
+
+/**
+ * Definition of the common data struct of DPIA notification
+ */
+struct dpia_notification_common {
+	uint8_t cmd_buffer[DMUB_RB_CMD_SIZE - sizeof(struct dmub_cmd_header)
+								- sizeof(struct dpia_notification_header)];
+};
+
+/**
+ * Definition of a DPIA notification data
+ */
+struct dpia_bw_allocation_notify_data {
+	union {
+		struct {
+			uint16_t cm_bw_alloc_support: 1; /**< USB4 CM BW Allocation mode support */
+			uint16_t bw_request_failed: 1; /**< BW_Request_Failed */
+			uint16_t bw_request_succeeded: 1; /**< BW_Request_Succeeded */
+			uint16_t est_bw_changed: 1; /**< Estimated_BW changed */
+			uint16_t bw_alloc_cap_changed: 1; /**< BW_Allocation_Capabiity_Changed */
+			uint16_t reserved: 11; /**< Reserved */
+		} bits;
+
+		uint16_t flags;
+	};
+
+	uint8_t cm_id; /**< CM ID */
+	uint8_t group_id; /**< Group ID */
+	uint8_t granularity; /**< BW Allocation Granularity */
+	uint8_t estimated_bw; /**< Estimated_BW */
+	uint8_t allocated_bw; /**< Allocated_BW */
+	uint8_t reserved;
+};
+
+/**
+ * union dpia_notify_data_type - DPIA Notification in Outbox command
+ */
+union dpia_notification_data {
+	/**
+	 * DPIA Notification for common data struct
+	 */
+	struct dpia_notification_common common_data;
+
+	/**
+	 * DPIA Notification for DP BW Allocation support
+	 */
+	struct dpia_bw_allocation_notify_data dpia_bw_alloc;
+};
+
+/**
+ * Definition of a DPIA notification payload
+ */
+struct dpia_notification_payload {
+	struct dpia_notification_header header;
+	union dpia_notification_data data; /**< DPIA notification payload data */
+};
+
+/**
+ * Definition of a DMUB_OUT_CMD__DPIA_NOTIFICATION command.
+ */
+struct dmub_rb_cmd_dpia_notification {
+	struct dmub_cmd_header header; /**< DPIA notification header */
+	struct dpia_notification_payload payload; /**< DPIA notification payload */
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_HPD_STATE command.
  */
@@ -3502,9 +3505,9 @@ union dmub_rb_out_cmd {
 	 */
 	struct dmub_rb_cmd_dp_set_config_reply set_config_reply;
 	/**
-	 * BW ALLOCATION notification command.
+	 * DPIA notification command.
 	 */
-	struct dmub_rb_cmd_dpia_notification dpia_notify;
+	struct dmub_rb_cmd_dpia_notification dpia_notification;
 };
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 4948f9724db2..74189102eaec 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -94,22 +94,22 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 		break;
 	case DMUB_OUT_CMD__DPIA_NOTIFICATION:
 		notify->type = DMUB_NOTIFICATION_DPIA_NOTIFICATION;
-		notify->link_index = cmd.dpia_notify.payload.header.instance;
+		notify->link_index = cmd.dpia_notification.payload.header.instance;
 
-		if (cmd.dpia_notify.payload.header.type == DPIA_NOTIFY__BW_ALLOCATION) {
+		if (cmd.dpia_notification.payload.header.type == DPIA_NOTIFY__BW_ALLOCATION) {
 
-			notify->bw_alloc_reply.estimated_bw =
-					cmd.dpia_notify.payload.data.dpia_bw_alloc.estimated_bw;
-			notify->bw_alloc_reply.allocated_bw =
-					cmd.dpia_notify.payload.data.dpia_bw_alloc.allocated_bw;
+			notify->dpia_notification.payload.data.dpia_bw_alloc.estimated_bw =
+					cmd.dpia_notification.payload.data.dpia_bw_alloc.estimated_bw;
+			notify->dpia_notification.payload.data.dpia_bw_alloc.allocated_bw =
+					cmd.dpia_notification.payload.data.dpia_bw_alloc.allocated_bw;
 
-			if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_failed)
+			if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_request_failed)
 				notify->result = DPIA_BW_REQ_FAILED;
-			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_succeeded)
+			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_request_succeeded)
 				notify->result = DPIA_BW_REQ_SUCCESS;
-			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.est_bw_changed)
+			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.est_bw_changed)
 				notify->result = DPIA_EST_BW_CHANGED;
-			else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed)
+			else if (cmd.dpia_notification.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed)
 				notify->result = DPIA_BW_ALLOC_CAPS_CHANGED;
 		}
 		break;
-- 
2.39.0

