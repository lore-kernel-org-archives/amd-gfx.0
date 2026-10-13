Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E49FCC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F86910F78B;
	Tue, 13 Oct 2026 11:20:39 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D963E10F788
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHHA3coXq9IUNFNC/HgjGsCHh4k31JX8hbGRZeVdxuobjDe35HSCny3dYWl7Q4FI14wyg/vWH9OJk/nTQ5scDXEVdwjKy+wimTlKmioCvOACCM1CU+5JN2XaeZ82dV6Yq6mgu6nbUmqhrakL7DsZrxrcAw3PUHOcGhUDL7C/1gzjU548aLmicmfHDU5uvwfqzOPh8A1zx2kmh1Ae9b+fEi4ILuVR/nUxJjuLRUn9QC9vlQ43NbH5EMfoafPMdxE3tum+B6p8h+c2yYyz0RmLYsSiCYi1rMWDDawDrzaJkBPwWbF268D6K/ZaSdPhjFUYiRICTebXb/zyUyXeDtmYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XNChN4fh4icfBhsWktmUZb6iCtxLRSe35hC31HUhts=;
 b=ucJYNvNs+XrfQXOW7Jn16F+sEI/dflwB0pjm1WBgAXpysCwxRxEbHmHDVs0jT+iWykikuLX+kt/D8FV2moFpuVreCSLgcnCpNnGr7OpCLrPLOgzLHyPoEiNYAudvuGTNYx0+rCbsU9jopFn4gWVB86Q2sYIu8yN4br/8hycBR1l1IAJcT/ojSKuJ1rq995DkT1WH1TY8v+UJ6+NC7EpP0t9lB1ZXb/5H9bB2omWYjYFAGXozGiZXkpaGim7kAjDk9UHUXW7Odaj8Uf+THBisUTm+HxnEv16tRG8kNzFoozt7qpjVDfc1slGJDMjZeBDozDSdmVh3Xyw0+oBKNxfM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XNChN4fh4icfBhsWktmUZb6iCtxLRSe35hC31HUhts=;
 b=NrrdzkfQb9kOQn67QeHs5ouZYECIMWaN9TP6WoKelhw2++I6N+4dGrWZsjENKuPx0PTwhW4JGVLk9o4D2UfmNU4wWqeX3V8OWnR6ZH8IEH6JJuETc/9g4IfEXyk7/zdvCaKI+9i9OMh3M7CunOrAIjw0/bLz279ju6+WmtBxPVU=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by FT1PR12MB679827.namprd12.prod.outlook.com (2603:10b6:170:b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:20:28 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::a7) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:20:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:20:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:21 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:20:13 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 29/30] drm/amd/display: [FW Promotion] Release 0.1.80.0
Date: Tue, 13 Oct 2026 19:08:16 +0800
Message-ID: <20261013111616.2267344-30-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|FT1PR12MB679827:EE_
X-MS-Office365-Filtering-Correlation-Id: d0953940-9389-45f7-da77-08df291bfc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: JtXjU7D2kzolWvZngErjfhMkNkzYvQOEtjxnmekxZxa7etGL1k7nDSPJ+wRegsZ4bBIonwN/kHqx0VKbwtTWBQixyP1/vj6fyl2SwmsNad7vtiAdjpRLZdGEbKrGeWxygPJeB1syApKRuawSw924HSEULJQXhn7ZvU4Y6PngfdKJo7sI9B/rs/pl2cuvnMZijfbGeEeGbGdOcL+dgpeoVmLgCJfsPWRKFNBoH9WF5NhEPp2sjuv32E5wi1UUa6RM3qjlrPgoj6grfaFlaYvDd8oXb8yNzbL8MHZNOOA6hb9P2Iy6YAHVcE54Vz73PsuqHNc6ONMXfgBqN6hG6zARgcbh13iaTmt8vUZC9hSwZDQ5UWwlgFGHdQftsWios4oGdmCmuREQbQN6aQc2a2HcPD6+mNlzI3FlpcVQECaguoE34mA8r9fw/ly39Ds2XsVMy+H5rdBnHT5tQqugD2x8cgmdPY1ITQUVEuYvTVdVJ1wYvMVxd/BPis6nQgJFJCJwGYMSh6p6RXpFfLdNy0xLvtNz6ejHArUDDdR2G4CHhHM6SnZpb/fjDxBrwSPqQv9F7iP5+epwnUM7wwicTSpPLTn5yeRnQYPYchBI/FQLOPAPwRioyZUjuhMSpVrwlEGjU7K5NLn44ZqPlb7JpZ9RLUDPgUWf/IGrJijQMg5LYY1ZzOxhMwtjSMRARBeI/4dGSgR38j/3bmHIPfriK6n/DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQoOjYMaLOaw0nE41NKcw057a6Nx7CLd1Zts3uFH733r8cqufz7gvhN9oB2zLmRJ35BKAGQG7W6dDg5GfWhxN4eC5LW8c3MtsKsffIgfE+4zqTZLR6udVNI/BZOZD5NvKIw+UNR+jiuR2PrkP12PEkuWBI/MNTvsOGcUfb5T8Ih2GvStIZ5LVtq6FQvsNYI47fcuJmfclz9r4lpZcn83jHNJfrGpVna3J5Uw42l2/IBBwBJMZlbJYkrrMM7G4U4GkxPa7rd4NTVnmWhjCguoFxMMG74Rh7tkCetfWR7LLimjfWh91PceM03Bjo7sPhoHEJfM0euWKyio6h7far+jocY8cVvBQ/D56esNA0dXfWRyANxy8dGDqvXr2F5CUEuPYN82Zho/xSM+WXl5oSP1XLG9mLd0vi5XQOiOCEs+WqDIYeeDSh0IO6QoA0K1+96t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:20:28.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0953940-9389-45f7-da77-08df291bfc2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB679827
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
- Add DMUB_CMD__DC_BLS_DCN_INIT command to run the fixed DCN
  hardware init sequence

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5dbedf09baa9..1df67376cca8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1192,6 +1192,10 @@ enum dmub_dc_bls_command_type {
 	 * Placeholder for block-level initialization of the DCHVM
 	 */
 	DMUB_CMD__DC_BLS_DCHVM_INIT = 0,
+	/**
+	 * Runs the fixed DCN hardware init sequence.
+	 */
+	DMUB_CMD__DC_BLS_DCN_INIT = 1,
 };
 
 /**
@@ -7694,6 +7698,17 @@ struct dmub_rb_cmd_boot_time_crc_init {
 	struct dmub_cmd_boot_time_crc_init_data data;
 };
 
+/**
+ * Definition of a DMUB_CMD__DC_BLS_DCN_INIT command.
+ *
+ * Runs a fixed DCN hardware init sequence after the pre-OS to post-OS
+ * transition. Carries no payload; anything driver-configurable is
+ * programmed by the driver after this command completes.
+ */
+struct dmub_rb_cmd_dc_bls_dcn_init {
+	struct dmub_cmd_header header; /**< Command header */
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -8098,6 +8113,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_boot_time_crc_init boot_time_crc_init;
 
+	/**
+	 * Definition of a DMUB_CMD__DC_BLS_DCN_INIT command.
+	 */
+	struct dmub_rb_cmd_dc_bls_dcn_init dc_bls_dcn_init;
+
 	/**
 	 * Definition of a DMUB_CMD__PANEL_POLARITY_ENABLE command.
 	 */
-- 
2.43.0

