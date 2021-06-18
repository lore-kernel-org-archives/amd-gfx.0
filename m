Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADCC48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67575613E2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67575613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A10588284;
	Fri, 18 Jun 2021 18:38:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549D56EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 18:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6VzQS/yWSqBST91MfYgL6MxSeXnz3lbCB5NzUv5cz7Orzdz2rIWNb9ag4aTzoHrfbmRg7dj9ifYX34ziHNMIFTiHo2mWhnSb5VQc8eQAJ+shpPXurj+ld85af96FKjoWXfGlo3Si6lsj14i9HdZH/a788UX+JkGoQSRuiIUHqSTLn79VzXLgJGsLoVh4OTqpLd0LVx2pXKeDw3NB6OJ3L0ej8mss80LlVwbqOOufQFFpiycUpS0PilsP78VlxF1rXBURkoEuvMPC6m4bthmFyc1tfBzn9iDtd9pbhlS2zQMPV+GDwn77HoO5RBMA8KYACP0c6vvFRl7ienzMrQuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJcaiKYDC5ZueYYbgHB/f+VO/WlyFo2uNhag83+MC1c=;
 b=gQG+bjrN2b1hJrGlP8kHaZwQIgsBEXJphhznlp1QCMtFyqrwpZ5CMW3w9zzgNTOF//MBvWGwR4XDK9+plEdybfQPqK5Rp/kVBDfZxY4OmvuI3zmBLoFfkWecfSfF4yjsADwfuYa+4dPafrkOqvtQrqJ/7g6ieOlihS/a5NFJbwZlnM899DCNwr+0t75OR4xnDaUoBDNUBGQVHUMsNmStt7XrnQXvhwheER9UWnODzgcpB9ROl7JbxYW4V4vLS9keKjGJOyr44NZzx7O0idfT3VOZSt1o8DL5P3w2zPOpa6zYxB9HE266bAQkcpM35bjyZKOa0e4/yToHEDIcGL8J0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJcaiKYDC5ZueYYbgHB/f+VO/WlyFo2uNhag83+MC1c=;
 b=T29RnwFiAFbTgeRR4ocvMrQ4GFZoaxoYWYovXCmwf0QhLy2UGVgrY9ruEfnHPXD3YuPwCVp0cGpj0S67ZmSKK2Qta3NVaXhxLO8aHNWPOwnkj6m0a0nBAkGLQtWx1OAZ3TCrcY9WWsAC5r/3Kf54UPsv5I8qokC+j4LjwgmkiSo=
Received: from BN6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:404:10a::24)
 by MWHPR12MB1470.namprd12.prod.outlook.com (2603:10b6:301:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 18 Jun
 2021 18:38:18 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::ae) by BN6PR13CA0014.outlook.office365.com
 (2603:10b6:404:10a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend
 Transport; Fri, 18 Jun 2021 18:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 18:38:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 13:38:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 11:38:16 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 13:38:15 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: [FW Promotion] Release 0.0.71
Date: Fri, 18 Jun 2021 14:37:35 -0400
Message-ID: <20210618183736.647268-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618183736.647268-9-bindu.r@amd.com>
References: <20210618183736.647268-9-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb0ccbb5-9a9e-4310-a34c-08d932883d65
X-MS-TrafficTypeDiagnostic: MWHPR12MB1470:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14702AF71D94ACCF53B3F81CF50D9@MWHPR12MB1470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRFms4hZ8b4Z+1fK4NSoU0JYIrGQKNEGoVmkZvx8KvD3R0Dw9VgjuH7GLZK3wnV2qOxQ5m3ysgebvxwemg9JlKI/qgQnU9KA1hqqmMdOdFqB4YmlkMnrLAcTJlheL8PJLxgyKTlpeZYRtNERY/nbql1CME/fD8DOuiOXEFx+pb3dP2eUpRWpq/4ozAvBVFXKe1L2jS+viuJ2s68922ZppnqgTHcOYEnDmffIf3Gc6dMnIwWuOH7c2n0S5/6XKg1ULeM8RKgwVSLfUazfDxbvSx91EkTrpK9c0Kv+NTVzNzMc2Y5kxu12zANiuD4SbXpMiKCvCbenNz8oi1q6iJzRlP0Dn2ottYdMS3PlzXSTXKjrfo47Rivg3E7NrjE6C6wasM4RTNPY7sVgZje6DTcbNs6S7oq60B5ykVhsNb+uku9jvugsuebYlgY0uykHTPZGXhxZQ9zDb6kPGB7QLDXeHY8lNvYYOWIM90uETkvysAOG/OlzMsSjtBZyKM4LaHJh3kH1/tWshQ1GCzE1QuSNHkcYy+L/mdbfAwReboHqX+YQyFYUpJ+vfWF/XCyxbgP4oyznKgkvi3PV0SaErjtI6IMTjtkEEmmRzUMBcgtSDGB+/99yyLrczmtiBNW/8dH0gVHSaFAGjy+CT9aboZUxiHWTp3n+C4AddKxIf4YrjU5oFRc3uYeUORJi/glVos/a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(54906003)(81166007)(82310400003)(426003)(1076003)(2616005)(86362001)(2906002)(47076005)(36860700001)(186003)(26005)(336012)(316002)(82740400003)(70206006)(70586007)(83380400001)(6666004)(478600001)(8676002)(36756003)(8936002)(5660300002)(7696005)(356005)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:38:17.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ccbb5-9a9e-4310-a34c-08d932883d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1470
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Introduce CMD for EDID CEA block parsing
- Add SCR5 definition for reporting eDP power sequencer status

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 18d2f51eb50d..707c7d0e370a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x5cac099d3
+#define DMUB_FW_VERSION_GIT_HASH 0xf3da2b656
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 70
+#define DMUB_FW_VERSION_REVISION 71
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -309,6 +309,7 @@ struct dmcub_trace_buf_entry {
  * Current scratch register usage is as follows:
  *
  * SCRATCH0: FW Boot Status register
+ * SCRATCH5: LVTMA Status Register
  * SCRATCH15: FW Boot Options register
  */
 
@@ -335,6 +336,21 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
 };
 
+/* Register bit definition for SCRATCH5 */
+union dmub_lvtma_status {
+	struct {
+		uint32_t psp_ok : 1;
+		uint32_t edp_on : 1;
+		uint32_t reserved : 30;
+	} bits;
+	uint32_t all;
+};
+
+enum dmub_lvtma_status_bit {
+	DMUB_LVTMA_STATUS_BIT_PSP_OK = (1 << 0),
+	DMUB_LVTMA_STATUS_BIT_EDP_ON = (1 << 1),
+};
+
 /**
  * union dmub_fw_boot_options - Boot option definitions for SCRATCH15
  */
@@ -629,6 +645,10 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__PANEL_CNTL = 74,
 #endif
+	/**
+	 * Command type used for EDID CEA parsing
+	 */
+	DMUB_CMD__EDID_CEA = 79,
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
@@ -2152,6 +2172,68 @@ struct dmub_rb_cmd_lvtma_control {
 	struct dmub_cmd_lvtma_control_data data;
 };
 
+/**
+ * Maximum number of bytes a chunk sent to DMUB for parsing
+ */
+#define DMUB_EDID_CEA_DATA_CHUNK_BYTES 8
+
+/**
+ *  Represent a chunk of CEA blocks sent to DMUB for parsing
+ */
+struct dmub_cmd_send_edid_cea {
+	uint16_t offset;	/**< offset into the CEA block */
+	uint8_t length;	/**< number of bytes in payload to copy as part of CEA block */
+	uint16_t total_length;  /**< total length of the CEA block */
+	uint8_t payload[DMUB_EDID_CEA_DATA_CHUNK_BYTES]; /**< data chunk of the CEA block */
+	uint8_t pad[3]; /**< padding and for future expansion */
+};
+
+/**
+ * Result of VSDB parsing from CEA block
+ */
+struct dmub_cmd_edid_cea_amd_vsdb {
+	uint8_t vsdb_found;		/**< 1 if parsing has found valid AMD VSDB */
+	uint8_t freesync_supported;	/**< 1 if Freesync is supported */
+	uint16_t amd_vsdb_version;	/**< AMD VSDB version */
+	uint16_t min_frame_rate;	/**< Maximum frame rate */
+	uint16_t max_frame_rate;	/**< Minimum frame rate */
+};
+
+/**
+ * Result of sending a CEA chunk
+ */
+struct dmub_cmd_edid_cea_ack {
+	uint16_t offset;	/**< offset of the chunk into the CEA block */
+	uint8_t success;	/**< 1 if this sending of chunk succeeded */
+	uint8_t pad;		/**< padding and for future expansion */
+};
+
+/**
+ * Specify whether the result is an ACK/NACK or the parsing has finished
+ */
+enum dmub_cmd_edid_cea_reply_type {
+	DMUB_CMD__EDID_CEA_AMD_VSDB	= 1, /**< VSDB parsing has finished */
+	DMUB_CMD__EDID_CEA_ACK		= 2, /**< acknowledges the CEA sending is OK or failing */
+};
+
+/**
+ * Definition of a DMUB_CMD__EDID_CEA command.
+ */
+struct dmub_rb_cmd_edid_cea {
+	struct dmub_cmd_header header;	/**< Command header */
+	union dmub_cmd_edid_cea_data {
+		struct dmub_cmd_send_edid_cea input; /**< input to send CEA chunks */
+		struct dmub_cmd_edid_cea_output { /**< output with results */
+			uint8_t type;	/**< dmub_cmd_edid_cea_reply_type */
+			union {
+				struct dmub_cmd_edid_cea_amd_vsdb amd_vsdb;
+				struct dmub_cmd_edid_cea_ack ack;
+			};
+		} output;	/**< output to retrieve ACK/NACK or VSDB parsing results */
+	} data;	/**< Command data */
+
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -2290,6 +2372,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
 	 */
 	struct dmub_rb_cmd_lvtma_control lvtma_control;
+	/**
+	 * Definition of a DMUB_CMD__EDID_CEA command.
+	 */
+	struct dmub_rb_cmd_edid_cea edid_cea;
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
