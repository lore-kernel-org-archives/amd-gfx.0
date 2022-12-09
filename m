Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB43C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D45610E574;
	Fri,  9 Dec 2022 16:38:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6114810E565
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB1vdnntbV9a8hiyT/zBNLs/5dFkZI3QwSh9ghqiDloV893gfNUvQb/FzRNEJe/6aji9SKS5eeAySPAQkIzZiUpRjU3lJw9ip/8beobp9Z71x5QCLMGSXbtuKq70SA4wRanT2EWAvaFlmzZWI1mRMfCRWikW43k+QMdD7TCPi+A1w14ZwIUpCAWQJ1OCM8HOD7hmxePmlVDB6Dkw0VOKnp4xis4/gEjzblBgRkBDqwun406dSNltPms8q+UjLm6fczntEaFsYYOwwZ+nV6eJspuJejuX2QTTSCxo4sa9nMAaRUDbcX9AH4Cxzfe9JBvvbjksdSwrAz/YppUVIOgaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvD06skAZq/IGhcHxhewhQFNtAMMmwMJqhf7a1DyAjs=;
 b=A4BwO/glQwaTQdzNcJMaIl+LYbPQ5Hcf3Q7UDggbxLkTcip7kzsfU/OARrodl1cy5rC8pX4RF45yW+wF8wVD49j+xLn3DV7XUKCMTwmtNB+/FlPO9KMm+tGZSffxwVRRFdmrZdojelywU3HikcS5NaOs/EgGIGhKvXbHJHsBGTWc8J95vXReyZIZBJrSdDrjEzs0lr3FwOwYxhhI2BOWOS/TZhHlNVCNXGi9ihFQk6v9PBnPDP+lOYiu2RH9eCDe/Yq+k9lRJFcH062450nzsUlqiB5HSlFiY9trOK1mva5i3BwXr/oat133ZsiKx2M4Xq/DbEBq6TTnLHV9o1K/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvD06skAZq/IGhcHxhewhQFNtAMMmwMJqhf7a1DyAjs=;
 b=MQGOZW7ls88YA576PxRB5R8cIsHnwF/tmq4L63e9xnCGcJ4TEnDtL1lnw5Yv8O2VBn3Wgo9rvYYvVdmZSV35S9Uuj66ES3Hxxx2z8Tn8R2021HGL7XX51tHnFq73ROsl7oVq/Z9enOnlK2QK6LSumgyDxLygAW5mQPnCRw3RWaE=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:31 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::46) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:31 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:29 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/23] drm/amd/display: Add DPIA NOTIFICATION logic
Date: Fri, 9 Dec 2022 11:36:38 -0500
Message-ID: <20221209163647.25704-15-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cc20ad-9536-471c-c900-08dada03aad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/CGzQZaZw3ZtF53uwLmO/VDzN37Go3QDlG305W8xo300EVjW2HbX2fdft95rJFch/GKNEMw8/rcsQ43jXuU5pvdJ4WkzPEgvu5/PDdVqrPj8oM02p9bHlNkcq73W9vWBhJ2jlphi/5nujGQU04hCVlO1Mj/Gf4BdJj/TmwAbvDmsu9iHg3yqjtPGFU7aO8GXZBZ4rX+EpmB09RLX/OMCAqGID12qtBcfrG8UiGnlUaEcSrdX4ckAxi3t0R+QdcXX0y3vGgauI4kc1JXfiAGr3BAH9SSK1HQH/QxAsybgPdt2OssFRKiuUmSAZI7nVFy4qnOI+x14zd/fBTiJNQK4P6EcKEHGy/8IVon3aoUGIziESiXoaMLtYIHoILy0o87J3vLKXf4CJyAet22M80wqLBAuZaiBV5cEmteeRFi31HZU8e5H33eNxOx3TD3hwO4i+hWIzjiFSbGMxIS+WEskW/V6RkIrK4NCXr6+A81+80ZfKLSKh3WvRGvxTjGdYnpUOUqadcEAsFkhuqw83Aoba1ZJnIw25RqnyLiICcUJyfYPOUi+sV1caKk6ZH6lrnwy4UwKeU8X3e9CPDj/wfiUYJvQAEv5K/W5okbAkDqutea9/1yNXy6oMKUy+BaOYAvRRlcU4NHKZh83DwGB+dClLZNGtmGx5YbGs9p9diUa6hKw90wM7x06NDYbll9+3jEA4wQ9I8dtUoTXdjY4EJlwt2RDrvEiztrhS15Hv2cXb0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(81166007)(356005)(15650500001)(4326008)(2906002)(40460700003)(8936002)(5660300002)(41300700001)(82310400005)(336012)(1076003)(8676002)(6666004)(40480700001)(26005)(426003)(186003)(47076005)(16526019)(6916009)(70206006)(316002)(54906003)(478600001)(2616005)(82740400003)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:31.0416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cc20ad-9536-471c-c900-08dada03aad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
Adding the new DPIA NOTIFY packets from DMUB
As per the design with Cruise to account for
250ms response delay otherwise

[HOW]
Added th DPIA NOTIFY logic as per DMUB logic

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 83 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 21 +++++
 4 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 4b372aa52801..6c06587dd88c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -65,6 +65,7 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 	/* For HPD/HPD RX, convert dpia port index into link index */
 	if (notify->type == DMUB_NOTIFICATION_HPD ||
 	    notify->type == DMUB_NOTIFICATION_HPD_IRQ ||
+		notify->type == DMUB_NOTIFICATION_DPIA_NOTIFICATION ||
 	    notify->type == DMUB_NOTIFICATION_SET_CONFIG_REPLY) {
 		notify->link_index =
 			get_link_index_from_dpia_port_index(dc, notify->link_index);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index eb5b7eb292ef..c8274967de94 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -126,6 +126,7 @@ enum dmub_notification_type {
 	DMUB_NOTIFICATION_HPD,
 	DMUB_NOTIFICATION_HPD_IRQ,
 	DMUB_NOTIFICATION_SET_CONFIG_REPLY,
+	DMUB_NOTIFICATION_DPIA_NOTIFICATION,
 	DMUB_NOTIFICATION_MAX
 };
 
@@ -453,6 +454,7 @@ struct dmub_srv {
  * @pending_notification: Indicates there are other pending notifications
  * @aux_reply: aux reply
  * @hpd_status: hpd status
+ * @bw_alloc_reply: BW Allocation reply from CM/DPIA
  */
 struct dmub_notification {
 	enum dmub_notification_type type;
@@ -463,6 +465,7 @@ struct dmub_notification {
 		struct aux_reply_data aux_reply;
 		enum dp_hpd_status hpd_status;
 		enum set_config_status sc_status;
+		struct dpia_notification_reply_data bw_alloc_reply;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 33907feefebb..4dcd82d19ccf 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -770,6 +770,7 @@ enum dmub_out_cmd_type {
 	 * Command type used for SET_CONFIG Reply notification
 	 */
 	DMUB_OUT_CMD__SET_CONFIG_REPLY = 3,
+	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5
 };
 
 /* DMUB_CMD__DPIA command sub-types. */
@@ -1516,6 +1517,84 @@ struct dp_hpd_data {
 	uint8_t pad;
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
+/* DMUB_OUT_CMD__DPIA_NOTIFY Reply command - OutBox Cmd */
+/**
+ * Data passed to driver from FW in a DMUB_OUT_CMD__DPIA_NOTIFY command.
+ */
+struct dpia_notification_reply_data {
+	uint8_t allocated_bw;
+	uint8_t estimated_bw;
+};
+
+struct dpia_notification_common {
+	bool shared;
+};
+
+struct dpia_bw_allocation_notify_data {
+	union {
+		struct {
+			uint16_t cm_bw_alloc_support: 1;	/**< USB4 CM BW Allocation mode support */
+			uint16_t bw_request_failed: 1;		/**< BW_Request_Failed */
+			uint16_t bw_request_succeeded: 1;	/**< BW_Request_Succeeded */
+			uint16_t est_bw_changed: 1;			/**< Estimated_BW changed */
+			uint16_t bw_alloc_cap_changed: 1;	/**< BW_Allocation_Capabiity_Changed */
+			uint16_t reserved: 11;
+		} bits;
+		uint16_t flags;
+	};
+	uint8_t cm_id;			/**< CM ID */
+	uint8_t group_id;		/**< Group ID */
+	uint8_t granularity;	/**< BW Allocation Granularity */
+	uint8_t estimated_bw;	/**< Estimated_BW */
+	uint8_t allocated_bw;	/**< Allocated_BW */
+	uint8_t reserved;
+};
+
+union dpia_notification_data {
+	struct dpia_notification_common common_data;
+	struct dpia_bw_allocation_notify_data dpia_bw_alloc;	/**< Used for DPIA BW Allocation mode notification */
+};
+
+enum dmub_cmd_dpia_notification_type {
+	DPIA_NOTIFY__BW_ALLOCATION = 0,
+};
+
+struct dpia_notification_header {
+	uint8_t instance;							/**< DPIA Instance */
+	uint8_t reserved[3];
+	enum dmub_cmd_dpia_notification_type type;	/**< DPIA notification type */
+};
+
+struct dpia_notification_payload {
+	struct dpia_notification_header  header;
+	union dpia_notification_data      data;   /**< DPIA notification data */
+};
+
+/**
+ * Definition of a DMUB_OUT_CMD__DPIA_NOTIFY command.
+ */
+struct dmub_rb_cmd_dpia_notification {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;  /**< DPIA notification header */
+	/**
+	 * Data passed to driver from FW in a DMUB_OUT_CMD__DPIA_NOTIFY command.
+	 */
+	struct dpia_notification_payload payload; /**< DPIA notification payload */
+};
+
 /**
  * Definition of a DMUB_OUT_CMD__DP_HPD_NOTIFY command.
  */
@@ -3422,6 +3501,10 @@ union dmub_rb_out_cmd {
 	 * SET_CONFIG reply command.
 	 */
 	struct dmub_rb_cmd_dp_set_config_reply set_config_reply;
+	/**
+	 * BW ALLOCATION notification command.
+	 */
+	struct dmub_rb_cmd_dpia_notification dpia_notify;
 };
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 44502ec919a2..55a534ec0794 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -92,6 +92,27 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 		notify->link_index = cmd.set_config_reply.set_config_reply_control.instance;
 		notify->sc_status = cmd.set_config_reply.set_config_reply_control.status;
 		break;
+	case DMUB_OUT_CMD__DPIA_NOTIFICATION:
+		notify->type = DMUB_NOTIFICATION_DPIA_NOTIFICATION;
+		notify->link_index = cmd.dpia_notify.payload.header.instance;
+
+		if (cmd.dpia_notify.payload.header.type == DPIA_NOTIFY__BW_ALLOCATION) {
+
+			if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_failed) {
+				notify->result = DPIA_BW_REQ_FAILED;
+			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_request_succeeded) {
+				notify->result = DPIA_BW_REQ_SUCCESS;
+				notify->bw_alloc_reply.allocated_bw =
+						cmd.dpia_notify.payload.data.dpia_bw_alloc.allocated_bw;
+			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.est_bw_changed) {
+				notify->result = DPIA_EST_BW_CHANGED;
+				notify->bw_alloc_reply.estimated_bw =
+						cmd.dpia_notify.payload.data.dpia_bw_alloc.estimated_bw;
+			} else if (cmd.dpia_notify.payload.data.dpia_bw_alloc.bits.bw_alloc_cap_changed) {
+				notify->result = DPIA_BW_ALLOC_CAPS_CHANGED;
+			}
+		}
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
-- 
2.34.1

