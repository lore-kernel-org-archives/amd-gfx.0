Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B63606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=paiNJXAn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4AA10F509;
	Wed, 25 Nov 2026 06:55:41 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5BE10F120
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/vs9j+r6EXgPJWuf51CYXnAvXBdOCKbvPUCbame2hpKP+FFv13hokQySOMv1DchmEIyZlpUJTMxz56Cgc1cKFvVgSoPvNMm9JL+8mxO4rqnnATOqUoTCpkMfwWmI4V5shHtNqllv5z9BrXqFAFWR2bCmbN5yv6kGYvNMDu1fKCNERpXHOUIZ7JVRCuY93AjE+LHzzIMkQmo8rm9znAlGp9UvjbnXwUpNCIh4Fen/bBQcqutDo+1cRXg7AaBkcGSL2OS10B1LkBRWyHj4IbM83xmvektKZLd7m5fqUCdcsajTctX6hAV9h5Q395vnQey/NpLO94niQusz91tiMtFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2/7ZcGnE4bdpRUr/Ag17h2UJG4c+HAUFprRjP+u1RQ=;
 b=ngpukKD8byu+oLhjeBjR1r/4t3OXYGk4dC8Z6/TtuFQDGG+cL68DLCd4RMSEVVHbUjkEsvrkz+GHfHLjc5dylSFdd/8sINPR91rfI2EpE72RSXpBQ2UZ0W52m8/FY8VMRbZFCcM3eRQ7gJ0MnhOZtIpm0QosYa9x65aCnkrVAfb0fXBS3GfKTAmnP6AohvuiiP0niQMB81m+IKKdqTFifCaPQFfGVatw4c8cERZ1aVxsHd4NNHqOUDQCazMWRtXPG54JXzV59nnKhqS4CQHrfMwHXP3SPWrL5S6CqZvWnwWcxZS+x7Z5ad081uZaROZtP39hGBohtVkeuMBb4+XHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/7ZcGnE4bdpRUr/Ag17h2UJG4c+HAUFprRjP+u1RQ=;
 b=paiNJXAnmOml8zHvE/Q+MZGlJ1YTPl+YvOLFMelWwzfoYcjanemQ0xzayaQCndgcZoaXBeqwzTBN/OY5iMpvhbZ7lm9Nskzh0Ei7etbPmem/OfACCtCc6bpcbbPNjOd2h0eobSr3LrXow62Z+QuhkmsWaTue+C3sFY2jqhYuX04=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:55:30 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::27) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:55:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:28 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:28 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:19 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 02/27] drm/amd/display: Capture more diagnostic register state
Date: Wed, 25 Nov 2026 14:54:51 +0800
Message-ID: <20261125065631.3889665-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 44076163-b45c-4ff1-619f-08df4ac117c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|261026140227099003|5023799004|56012099006|11063799006|261102123227099003|261022105027099003|261021123027099003|261028144727099003|261021121427099003|261021135927099003|261009223027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: K/1ffRrnBHsBOUfYqfjmJp/dU6m22S1o/wcYf5jUCKn1O+IJqcFdSCiXg9BON4t+JGQtFO7ygWBsgc/WcdGvXrq4qEYf/SdScEAaRAjzyIWIm2Gbc5WVWkWmqa0RXmbaidoXOLIonDua8XARZWr6daWHvcRocnDf4VHt+ffsmg1CB+LCp5cxjuozlrZjX3myMgqvlLbfyAcwQRVBRHDJu/x+et50h31JSxussQq4qcQYtaqZri4X5vHhAtngNlkvAAwO0xlF/a6SDkIqeGWQ/4zKIE/JBE8VUtsb6MarK8t8eFDX1QmM5vO4uf7RB1aALhMX9ewG+vBk3Rp2y4Dr2yGRKxhTd7Je3H2saEj3PbgVGTxiKAWEK2rZfulTBqfaA43CLsAg7dXjOvZzZ2YJ+Mn7J3+b04bYPvyZ2u6mib5GR5fnJyJ1vsmXwR6038mnDG3Ohy/VraMpeGCp5EAUknDh/TFCTsogmvOVcbs3axRVrZSyZKc2MqbP/u8WvkyTfBzxIUEDTDtJQoSEKahrSeZHZahllWWgOOoPePpFLdoK8u/XVL1ZrG+y4WftQNppHP3LA5FYopBuDw3ZugKnVmwZEzuPzGlRcCnkRE6v5YZA35V4fovIH8JsMvdrhx+hTm4PSvXI24mZnuuJ8R7E5J1xgxrndoqSm8H0jfAJVyJZ2UApdE7GYZJmrVYJU0+IyhKB2KJ7BNi/Ky2CClQsFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261026140227099003)(5023799004)(56012099006)(11063799006)(261102123227099003)(261022105027099003)(261021123027099003)(261028144727099003)(261021121427099003)(261021135927099003)(261009223027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X2ZEn4BAJzap+kw74ZV8zx/MEQbcHtvAuMCR+M/kBqgjnSVSYGFnitvw0H8OVQhHkJSzRrH183VCcAmomT5++koaP1aP5sqN00A0Xxl8Q7C71rJd0qGhxZRpdFksxal4HSBHP8jGA/Zcg1xqv2zmdyEyTFP5i64ukg14ML1feKkQxqpT+ZkOdKNuXF/u5AfVtaoOsbSgRMEPd2T4TSx1vvDmh+0upctef9nFXFxVd6jTnZnDtH8G7ktSJI/RjFoCYFyXkb4KhfBh5uqHBhepJZLg7QgHAgpH210P5Yu4UHHkZh5TbjWnw1iz5LuwYUHWPDOcAlaXWkOB2/sVDf+6z9xX3yGPN/yI1pK6y+NwZeLtzad9kP45Z2KYd3nLQqaKFA5IgPgrhgR0WQgTBw/C17yMi+9fm0O2ZwKXTRMezTObJqr4MVf0C2sujf/XFw7+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:29.7050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44076163-b45c-4ff1-619f-08df4ac117c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Captures more register state for diagnosing potential FW and interrupt
related issues. The values are only stored in the diagnostic data
structures; this patch does not print them.
- IHC interrupt status (DISP_INTERRUPT_STATUS and its CONTINUE
  registers), per ASIC through DMUB_DCN401_IHC_REGS, DMUB_DCN42_IHC_REGS
  and DMUB_DCN60_IHC_REGS. DCN42B uses the DCN42 list.
- DCHUBBUB timeout detection control 2 (DCHUBBUB_TIMEOUT_DETECTION_CTRL2)
- DCHUBBUB timeout interrupt status (DCHUBBUB_TIMEOUT_INTERRUPT_STATUS),
  added to the hubbub register lists and read into
  hubbub_state->timeout_interrupt_status
- DMCUB interrupt status (DMCUB_INTERRUPT_STATUS)
- DMCUB external interrupt context and status (DMCUB_EXT_INTERRUPT_CTXID
  and DMCUB_EXT_INTERRUPT_STATUS), read into ext_int_ctx_id and
  ext_int_id. DMUB_DCN401, DMUB_DCN42 and DMUB_DCN60 also add the
  DMCUB_EXT_INTERRUPT_ID field.

Reserved placeholders, not used yet: the client_debug array
(MAX_IHC_CLIENT_DEBUG_REG entries) in the IHC diagnostic data and the
empty DMUB_DCN401_IHC_DEBUG_REGS() macro, which is expanded in the
DCN401 IHC register list. They are reserved for IHC client debug
registers in a later change. Nothing reads or fills them in this patch.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |  6 +++
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |  1 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.h    |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 .../dc/resource/dcn401/dcn401_resource.h      |  1 +
 .../dc/resource/dcn60/dcn60_resource.h        |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 12 ++++++
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 40 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn401.h    | 39 +++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c | 37 +++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h | 36 ++++++++++++++++-
 .../drm/amd/display/dmub/src/dmub_dcn42b.c    |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c | 38 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h | 36 ++++++++++++++++-
 15 files changed, 247 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 581e2c1578b5..69316b284e5d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -201,6 +201,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_MALL_B;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL1;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL2;
+	uint32_t DCHUBBUB_TIMEOUT_INTERRUPT_STATUS;
 	uint32_t DCHUBBUB_CTRL_STATUS;
 	uint32_t DCHUBBUB_ARB_BUFFER_FULLNESS_WATERMARK_A;
 	uint32_t DCHUBBUB_ARB_BUFFER_FULLNESS_WATERMARK_B;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 6cfcce7bb48f..a145c3692f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -656,6 +656,12 @@ void hubbub2_read_state(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_s
 
 	if (REG(DCHUBBUB_ARB_DRAM_STATE_CNTL))
 		hubbub_state->dram_state_cntl = REG_READ(DCHUBBUB_ARB_DRAM_STATE_CNTL);
+
+	if (REG(DCHUBBUB_TIMEOUT_DETECTION_CTRL2))
+		hubbub_state->timeout_detection_ctrl2 = REG_READ(DCHUBBUB_TIMEOUT_DETECTION_CTRL2);
+
+	if (REG(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS))
+		hubbub_state->timeout_interrupt_status = REG_READ(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS);
 }
 
 static const struct hubbub_funcs hubbub2_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index 831b9888c831..08d4897a0e95 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -189,6 +189,7 @@
 	SR(DCHUBBUB_CTRL_STATUS),\
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),\
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),\
+	SR(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS),\
 	SR(DCHUBBUB_ARB_QOS_FORCE)
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
index f74d5690c89d..9b673512b80e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
@@ -119,7 +119,8 @@
 	SR(DCHUBBUB_TEST_DEBUG_DATA),\
 	SR(DCHUBBUB_CTRL_STATUS),\
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),\
-	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2)\
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),\
+	SR(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS)
 
 #define HUBBUB_MASK_SH_LIST_DCN4_2(mask_sh)\
 	HUBBUB_MASK_SH_LIST_DCN32(mask_sh), \
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 0b5fe1ca04e0..71658a4c775a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -153,6 +153,8 @@ struct dcn_hubbub_state {
 	uint32_t test_debug_data;
 	uint32_t watermark_change_cntl;
 	uint32_t dram_state_cntl;
+	uint32_t timeout_detection_ctrl2;
+	uint32_t timeout_interrupt_status;
 };
 
 struct dcn_hubbub_reg_state {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 3cfc1a39a103..065c9fffee3e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -633,6 +633,7 @@ int dcn401_get_power_profile(const struct dc_state *context);
 	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),									 \
+	SR(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS),                                 \
 	SR(DCHUBBUB_CTRL_STATUS),                                                \
 	SR(DCHUBBUB_ARB_MALL_CNTL)
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
index 34cfdc6eb8e5..b73f9616b3ee 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
@@ -133,6 +133,7 @@ bool dcn50_program_mcache_pipe_config(struct dc_state *context,
 	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),                                    \
+	SR(DCHUBBUB_TIMEOUT_INTERRUPT_STATUS),                                  \
 	SR(DCHUBBUB_CTRL_STATUS),                                                \
 	SR(DCHUBBUB_PERFORMANCE_MEASUREMENT_CNTL),                               \
 	SR(DCHUBBUB_PERFORMANCE_MEASUREMENT_CNTL2),                              \
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 84f825c924bc..eb3b34aec745 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -79,6 +79,9 @@
 #define PSP_FOOTER_BYTES_512 0x200 // 512 bytes
 #define PSP_FOOTER_BYTES_1932 0x78C // 1932 bytes
 
+#define MAX_IHC_INT_REG 32
+#define MAX_IHC_CLIENT_DEBUG_REG 5
+
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_srv_common_regs;
@@ -394,10 +397,16 @@ struct dmub_timeout_info {
 	struct dmub_trace_snapshot trace_snapshot;
 };
 
+struct dmub_ihc_diagnostic_data {
+	uint32_t int_status[MAX_IHC_INT_REG];
+	uint32_t client_debug[MAX_IHC_CLIENT_DEBUG_REG];
+};
+
 /**
  * struct dmub_hw_diagnostic_data - Hardware diagnostic data for the DMUB
  */
 struct dmub_hw_diagnostic_data {
+	struct dmub_ihc_diagnostic_data ihc;
 	uint32_t dmcub_version;
 	uint32_t scratch[17];
 	uint32_t pc[DMUB_PC_SNAPSHOT_COUNT];
@@ -414,6 +423,9 @@ struct dmub_hw_diagnostic_data {
 	uint32_t outbox1_wptr;
 	uint32_t outbox1_size;
 	uint32_t gpint_datain0;
+	uint32_t int_status;
+	uint32_t ext_int_ctx_id;
+	uint32_t ext_int_id;
 	uint8_t is_dmcub_enabled : 1;
 	uint8_t is_dmcub_soft_reset : 1;
 	uint8_t is_dmcub_secure_reset : 1;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 02ab26516584..ffe6ce231ae4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -20,6 +20,8 @@ const struct dmub_srv_dcn401_regs dmub_srv_dcn401_regs = {
 #define DMUB_SR(reg) REG_OFFSET_EXP(reg),
 	{
 		DMUB_DCN401_REGS()
+		DMUB_DCN401_IHC_REGS()
+		DMUB_DCN401_IHC_DEBUG_REGS()
 		DMCUB_INTERNAL_REGS()
 	},
 #undef DMUB_SR
@@ -423,6 +425,37 @@ uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
+static void dmub_dcn401_get_ihc_diagnostic_data(struct dmub_srv *dmub, struct dmub_ihc_diagnostic_data *ihc_data)
+{
+	ihc_data->int_status[0] = REG_READ(DISP_INTERRUPT_STATUS);
+	ihc_data->int_status[1] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE);
+	ihc_data->int_status[2] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE2);
+	ihc_data->int_status[3] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE3);
+	ihc_data->int_status[4] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE4);
+	ihc_data->int_status[5] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE5);
+	ihc_data->int_status[6] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE6);
+	ihc_data->int_status[7] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE7);
+	ihc_data->int_status[8] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE8);
+	ihc_data->int_status[9] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE9);
+	ihc_data->int_status[10] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE10);
+	ihc_data->int_status[11] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE11);
+	ihc_data->int_status[12] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE12);
+	ihc_data->int_status[13] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE13);
+	ihc_data->int_status[14] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE14);
+	ihc_data->int_status[15] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE15);
+	ihc_data->int_status[16] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE16);
+	ihc_data->int_status[17] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE17);
+	ihc_data->int_status[18] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE18);
+	ihc_data->int_status[19] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE19);
+	ihc_data->int_status[20] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE20);
+	ihc_data->int_status[21] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE21);
+	ihc_data->int_status[22] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE22);
+	ihc_data->int_status[23] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE23);
+	ihc_data->int_status[24] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE24);
+	ihc_data->int_status[25] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE25);
+
+}
+
 void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
@@ -498,7 +531,14 @@ void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagn
 	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+
+	hw_data->int_status = REG_READ(DMCUB_INTERRUPT_STATUS);
+	hw_data->ext_int_ctx_id = REG_READ(DMCUB_EXT_INTERRUPT_CTXID);
+	hw_data->ext_int_id = REG_READ(DMCUB_EXT_INTERRUPT_STATUS);
+
+	dmub_dcn401_get_ihc_diagnostic_data(dmub, &hw_data->ihc);
 }
+
 void dmub_dcn401_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
 	/* DMCUB_REGION3_TMR_AXI_SPACE values:
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
index de7840d93592..c90c0478e56b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
@@ -124,7 +124,39 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REG_OUTBOX0_RDY) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_MSG0) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_RSP) \
-	DMUB_SR(HOST_INTERRUPT_CSR)
+	DMUB_SR(HOST_INTERRUPT_CSR) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_CTXID) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_STATUS)
+
+#define DMUB_DCN401_IHC_REGS() \
+	DMUB_SR(DISP_INTERRUPT_STATUS) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE2) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE3) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE4) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE5) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE6) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE7) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE8) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE9) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE10) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE11) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE12) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE13) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE14) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE15) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE16) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE17) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE18) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE19) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE20) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE21) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE22) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE23) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE24) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE25)
+
+#define DMUB_DCN401_IHC_DEBUG_REGS()
 
 #define DMUB_DCN401_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -170,11 +202,14 @@ struct dmub_srv;
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN) \
-	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS) \
+	DMUB_SF(DMCUB_EXT_INTERRUPT_STATUS, DMCUB_EXT_INTERRUPT_ID)
 
 struct dmub_srv_dcn401_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
 	DMUB_DCN401_REGS()
+	DMUB_DCN401_IHC_REGS()
+	DMUB_DCN401_IHC_DEBUG_REGS()
 	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 8ebd3d948567..17b3a2304ac7 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -23,6 +23,7 @@ void dmub_srv_dcn42_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
 
 #define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
 	DMUB_DCN42_REGS()
+	DMUB_DCN42_IHC_REGS()
 	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 
@@ -633,6 +634,36 @@ uint32_t dmub_dcn42_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
+static void dmub_dcn42_get_ihc_diagnostic_data(struct dmub_srv *dmub, struct dmub_ihc_diagnostic_data *ihc_data)
+{
+	ihc_data->int_status[0] = REG_READ(DISP_INTERRUPT_STATUS);
+	ihc_data->int_status[1] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE);
+	ihc_data->int_status[2] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE2);
+	ihc_data->int_status[3] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE3);
+	ihc_data->int_status[4] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE4);
+	ihc_data->int_status[5] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE5);
+	ihc_data->int_status[6] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE6);
+	ihc_data->int_status[7] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE7);
+	ihc_data->int_status[8] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE8);
+	ihc_data->int_status[9] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE9);
+	ihc_data->int_status[10] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE10);
+	ihc_data->int_status[11] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE11);
+	ihc_data->int_status[12] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE12);
+	ihc_data->int_status[13] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE13);
+	ihc_data->int_status[14] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE14);
+	ihc_data->int_status[15] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE15);
+	ihc_data->int_status[16] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE16);
+	ihc_data->int_status[17] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE17);
+	ihc_data->int_status[18] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE18);
+	ihc_data->int_status[19] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE19);
+	ihc_data->int_status[20] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE20);
+	ihc_data->int_status[21] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE21);
+	ihc_data->int_status[22] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE22);
+	ihc_data->int_status[23] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE23);
+	ihc_data->int_status[24] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE24);
+	ihc_data->int_status[25] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE25);
+}
+
 void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
@@ -708,6 +739,12 @@ void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagno
 	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+
+	hw_data->int_status = REG_READ(DMCUB_INTERRUPT_STATUS);
+	hw_data->ext_int_ctx_id = REG_READ(DMCUB_EXT_INTERRUPT_CTXID);
+	hw_data->ext_int_id = REG_READ(DMCUB_EXT_INTERRUPT_STATUS);
+
+	dmub_dcn42_get_ihc_diagnostic_data(dmub, &hw_data->ihc);
 }
 
 bool dmub_dcn42_get_preos_fw_info(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
index c879e94272d7..cf901715ec36 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
@@ -150,7 +150,37 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REG_OUTBOX0_RDY) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_MSG0) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_RSP) \
-	DMUB_SR(HOST_INTERRUPT_CSR)
+	DMUB_SR(HOST_INTERRUPT_CSR) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_CTXID) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_STATUS)
+
+#define DMUB_DCN42_IHC_REGS() \
+	DMUB_SR(DISP_INTERRUPT_STATUS) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE2) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE3) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE4) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE5) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE6) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE7) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE8) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE9) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE10) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE11) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE12) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE13) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE14) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE15) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE16) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE17) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE18) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE19) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE20) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE21) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE22) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE23) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE24) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE25)
 
 #define DMUB_DCN42_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -198,11 +228,13 @@ struct dmub_srv;
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT) \
-	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN)
+	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN) \
+	DMUB_SF(DMCUB_EXT_INTERRUPT_STATUS, DMCUB_EXT_INTERRUPT_ID)
 
 struct dmub_srv_dcn42_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
 	DMUB_DCN42_REGS()
+	DMUB_DCN42_IHC_REGS()
 	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
index 97eb022b837b..25fde94df2ca 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
@@ -20,6 +20,7 @@ void dmub_srv_dcn42b_regs_init(struct dmub_srv *dmub, struct dc_context *ctx)
 
 #define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
 	DMUB_DCN42_REGS()
+	DMUB_DCN42_IHC_REGS()
 	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
index 8c3cc51c07a3..384bdb0410f1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
@@ -30,6 +30,7 @@ const struct dmub_srv_dcn60_regs dmub_srv_dcn60_regs = {
 #define MMHUB_SR(reg) .reg = MMHUB_REG_OFFSET(reg),
 	.offset = {
 		DMUB_DCN60_REGS()
+		DMUB_DCN60_IHC_REGS()
 		DMCUB_INTERNAL_REGS()
 		DCN60_EXTERNAL_MMHUB_REGS()
 	},
@@ -469,6 +470,36 @@ uint32_t dmub_dcn60_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
+static void dmub_dcn60_get_ihc_diagnostic_data(struct dmub_srv *dmub, struct dmub_ihc_diagnostic_data *ihc_data)
+{
+	ihc_data->int_status[0] = REG_READ(DISP_INTERRUPT_STATUS);
+	ihc_data->int_status[1] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE);
+	ihc_data->int_status[2] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE2);
+	ihc_data->int_status[3] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE3);
+	ihc_data->int_status[4] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE4);
+	ihc_data->int_status[5] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE5);
+	ihc_data->int_status[6] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE6);
+	ihc_data->int_status[7] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE7);
+	ihc_data->int_status[8] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE8);
+	ihc_data->int_status[9] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE9);
+	ihc_data->int_status[10] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE10);
+	ihc_data->int_status[11] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE11);
+	ihc_data->int_status[12] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE12);
+	ihc_data->int_status[13] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE13);
+	ihc_data->int_status[14] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE14);
+	ihc_data->int_status[15] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE15);
+	ihc_data->int_status[16] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE16);
+	ihc_data->int_status[17] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE17);
+	ihc_data->int_status[18] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE18);
+	ihc_data->int_status[19] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE19);
+	ihc_data->int_status[20] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE20);
+	ihc_data->int_status[21] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE21);
+	ihc_data->int_status[22] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE22);
+	ihc_data->int_status[23] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE23);
+	ihc_data->int_status[24] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE24);
+	ihc_data->int_status[25] = REG_READ(DISP_INTERRUPT_STATUS_CONTINUE25);
+}
+
 void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
@@ -544,7 +575,14 @@ void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagno
 	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+
+	hw_data->int_status = REG_READ(DMCUB_INTERRUPT_STATUS);
+	hw_data->ext_int_ctx_id = REG_READ(DMCUB_EXT_INTERRUPT_CTXID);
+	hw_data->ext_int_id = REG_READ(DMCUB_EXT_INTERRUPT_STATUS);
+
+	dmub_dcn60_get_ihc_diagnostic_data(dmub, &hw_data->ihc);
 }
+
 void dmub_dcn60_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
 	/* DMCUB_REGION3_TMR_AXI_SPACE values:
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
index 238cba46d366..7e8bae49baee 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
@@ -124,7 +124,37 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REG_OUTBOX0_RDY) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_MSG0) \
 	DMUB_SR(DMCUB_REG_OUTBOX0_RSP) \
-	DMUB_SR(HOST_INTERRUPT_CSR)
+	DMUB_SR(HOST_INTERRUPT_CSR) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_CTXID) \
+	DMUB_SR(DMCUB_EXT_INTERRUPT_STATUS)
+
+#define DMUB_DCN60_IHC_REGS() \
+	DMUB_SR(DISP_INTERRUPT_STATUS) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE2) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE3) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE4) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE5) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE6) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE7) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE8) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE9) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE10) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE11) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE12) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE13) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE14) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE15) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE16) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE17) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE18) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE19) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE20) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE21) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE22) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE23) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE24) \
+	DMUB_SR(DISP_INTERRUPT_STATUS_CONTINUE25)
 
 #define DMUB_DCN60_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -170,7 +200,8 @@ struct dmub_srv;
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_STAT) \
 	DMUB_SF(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN) \
-	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS) \
+	DMUB_SF(DMCUB_EXT_INTERRUPT_STATUS, DMCUB_EXT_INTERRUPT_ID)
 
 #define DCN60_EXTERNAL_MMHUB_REGS() \
 	MMHUB_SR(MMMC_VM_FB_LOCATION_BASE) \
@@ -184,6 +215,7 @@ struct dmub_srv_dcn60_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
 #define MMHUB_SR(reg) uint32_t reg;
 	DMUB_DCN60_REGS()
+	DMUB_DCN60_IHC_REGS()
 	DMCUB_INTERNAL_REGS()
 	DCN60_EXTERNAL_MMHUB_REGS()
 #undef MMHUB_SR
-- 
2.43.0

