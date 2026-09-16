Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421FC88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7268910ECED;
	Wed, 16 Sep 2026 17:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIslei4Y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0065B10ECDA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSIFpqoWiIadM9itPiGa8I/bkBtDZUy7IyOwhPkp+YjruBtlUPz5tevSEBiwcUpS0P0iro90SiFzZxknAfY7g7+/Ya7EHjNDnjyugn1/e8/meCuBlvdCehPS55pBMn3DquOjzHlk35e+1WFZzQjxi/smOJBjvyUfRnDI9hGtGermvWH7r+Q98Qvo9SZi3FjA8EBDzsGZpKmRcs4ap8O2F3GG9FNDyJhNjb0RBvspsDtCM6zr0/RyCS4T/LFfuH/FZdLllMJUcXRXOVYUAEmoBVghM7eNYdZ8TY9aBJwTO4m/p31XQT2OluOZ5nTLGRCWLMFEwKv1lcd3sV1NaCk5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34+Vd0lwaw4WBuo1X1NXCu6SWIO5xjAoFLcBWDUhAGA=;
 b=Wrp2jWDOiKa5TcX+2dia98505jzo0EuOASQ3QjT6ZXVxFMdQmHeIwDa6J49ogEeNYih2YdzUJBwgCPMLuqKgnzkKW3SxUYhEi74GJixG3QDrmDIDs/H6bVY6TFSfg1Y1Ny5yJ25IGvhx1jTt0mp6TZLdBO8ZfW301vEC8/HlE2wWFL1PmDDyduGLoJhWRKd0if8AnAIOCdk5ptASPPj81Pd8tkdTbGIH15Uibu1+vv11G7iuaXupPLTRMahSVDJzpi2t1B4g6u4bEhtUH2orqbZOwUZcq6VcEkAuY17yCiLxrVR4gUywyUj4GHW9l8vASljLwA+MmsO2wEIUQsrUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34+Vd0lwaw4WBuo1X1NXCu6SWIO5xjAoFLcBWDUhAGA=;
 b=fIslei4YAKhmTuNX5m6KGvwEyHuucP7zWQrBvernf5EOH9l4qF2HlAP94dtlU91fv6dWcDnbDohkaDGdHEwyC0fRuWGuuUia0+dPrU7UcHrRXITqKAOqpChkZ6j4VmRWG/MdYCIa7XT8Sfd61C8XCJYBVkJugvti4sZuWd8qGg4=
Received: from CH2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:610:4c::16)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:16 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::ab) by CH2PR10CA0006.outlook.office365.com
 (2603:10b6:610:4c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:16 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:53:03 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 63/64] drm/amd/display: [FW Promotion] Release 0.1.76.0
Date: Wed, 16 Sep 2026 13:52:18 -0400
Message-ID: <20260916175301.368306-64-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b4c45d-9d53-4f3f-dae7-08df141b62ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: gzUE2cWJmPgs4eeldQw9mk5+37GFaWHl6bOnGCsX1T2m3u/7dFSrAFYcIx4ahoRFF9oV5++7P5x1G4rMesrGbAEVVsIwIsZ8ty70oMo8wAUvEBirA9VWKurEZXxaiu3uonh3LbH6ECHmV0wREuQjw//h1P7FgbDjGs1miXxtvidj5wh6lgPq0LHR+0p64/74C7s3D7fF2OB70fiGHRM5FMIdGxkwUXwZRGc/rY1voodki6ClIiAbTzKuGjkzvKTBvhAafQneUQVrEhS01wiQpWvZwkVBr5dr/Ezx8mCDCDczc9CNL6kxRiNE2oKbqLsVmLB1dtKYHCJLwrqpYrJjOfD0ewN2d05nQgN2tBYhJ3I+8S6yasekOuSQ5Xg8PMOf66NhUfI0MUJJFiwOtXGoI9geNj/5fC4bwznsx1TGIDixC3QGoWjkMcVlX+7k7/n+ty++CHA02CUfX91urxkVz3CFgsqYmsax8gEx1JUmWoYk9IaRxqpllCQWSa3NLJdEs/WS1+eoJAIeI7GN4i4N8yNS2HknLsc+q6zpTA49e7T8tMynxsh8wuwLzfQQtzWHkBsxtg2/0ifkLNP4MY3PJ+QKHBNRqMjaogu29Wqcgryba5g7HtrYsd/7QVkvc7/0dNqfNxVuU/HotlnFNzVUv/SfLyi5IKFw9+zoEFHGhQkJdcBi0YWCgWU1t2zRqLSnFijGTZY9lj5YQujfAF67Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cd9FXDQKUH7ClQaXoSQQf3VpNAwSzKZsLqt+guQxifWWEMKnJv2I5SdyLpMCBzViB2+SnFeHjZB82o1OXmYhZ0XLkT3Aa+sJAd8+NMe3KZ0bMUg70jFenGd3ayzZ44GphasnFXTrxCXKR8J0jwyGtijs6KvaVKSv3clFvbGh1aUNBj5iC6gc0xinYZkk78j6eIBmL0hays+3hOesxO1nU81Jhg6IIIA6s59njNlhsJHHKgzDCWnh8Eqw058P8+HOjmWymR591rikBHLX7zfdiT600CxOMyicI8ETfT5C6Y8FdJqifJI6enXZPruMFUpfBcwnAwIbFElMT+5+j+/YU3uu1qxuPfTfPt7EfpdZhdBpXSFNiEnhC0QgtyOVUMz/GmYDvtXCr03aII6hdLlpxkf1EBuhX1PrrR9QYFYU7Hc9rKgQoMCTYZUav7xRE2mY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:16.3717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b4c45d-9d53-4f3f-dae7-08df141b62ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated DMUB interface
- Add OEM visual debug flags
- Updated HW lock pending error
- Add new DMUB_CMD__NBIF_AZ_PME_RESTORE command

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index af621b8552e1..5d534b91bc33 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -582,7 +582,14 @@ union replay_debug_flags {
 		 */
 		uint32_t enable_sub_feature_visual_confirm : 1;
 
-		uint32_t reserved : 16;
+		/**
+		 * 0x10000 (bit 16)
+		 * @enable_oem_visual_confirm: Enable OEM visual confirm
+		 * Black = state 0, Blue = state non-zero, Green = frame skipping active
+		 */
+		uint32_t enable_oem_visual_confirm : 1;
+
+		uint32_t reserved : 15;
 	} bitfields;
 
 	uint32_t u32All;
@@ -743,7 +750,14 @@ union pr_debug_flags {
 		 */
 		uint32_t force_hubp_on : 1;
 
-		uint32_t reserved : 24;
+		/**
+		 * 0x100 (bit 8)
+		 * @enable_oem_visual_confirm: Enable OEM visual confirm
+		 * Black = state 0, Blue = state non-zero
+		 */
+		uint32_t enable_oem_visual_confirm : 1;
+
+		uint32_t reserved : 23;
 	} bitfields;
 
 	uint32_t u32All;
@@ -2048,6 +2062,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__DC_BLS = 98,
 
+	/**
+	 * Command type used to notify nbif az pme restore.
+	 */
+	DMUB_CMD__NBIF_AZ_PME_RESTORE = 99,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -3637,6 +3656,28 @@ struct dmub_rb_cmd_query_hpd_state {
 	struct dmub_cmd_hpd_state_query_data data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__NBIF_AZ_PME_RESTORE command.
+ */
+struct dmub_cmd_nbif_az_pme_restore_data {
+	uint8_t az_inst; /**< Azalia codec endpoint instance */
+	uint8_t pad[3]; /**< Alignment */
+};
+
+/**
+ * Definition of a DMUB_CMD__NBIF_AZ_PME_RESTORE command.
+ */
+struct dmub_rb_cmd_nbif_az_pme_restore {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__NBIF_AZ_PME_RESTORE command.
+	 */
+	struct dmub_cmd_nbif_az_pme_restore_data data;
+};
+
 /**
  * struct dmub_rb_cmd_hpd_sense_notify - HPD sense notification data.
  */
@@ -7878,6 +7919,11 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__QUERY_HPD_STATE command.
 	 */
 	struct dmub_rb_cmd_query_hpd_state query_hpd;
+
+	/**
+	 * Definition of a DMUB_CMD__NBIF_AZ_PME_RESTORE command.
+	 */
+	struct dmub_rb_cmd_nbif_az_pme_restore nbif_az_pme_restore;
 	/**
 	 * Definition of a DMUB_CMD__SECURE_DISPLAY command.
 	 */
-- 
2.55.0

