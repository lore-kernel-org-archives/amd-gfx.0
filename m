Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB73C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 14:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A29410E7F5;
	Mon, 21 Sep 2026 14:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2xaQZpj";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435CB10E7F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq7HCUn1XZFD/hEYJvX43OCpHP8RGK4nvnq3OMHZvy8uzcLNMOX3zYAleisMg2ZNGyQ8dtOTaqFpP1bLun2WYzG+jFXGCes/fCXcf9Ny4TW9jd9jegQ1z4GF5Lrm1Jbn+fs5DNwv4i4LzqAiEWpizmUQIebtZ1Zn0WWDiGIkvIffbMsfUHyAxuBKCkpWsaRJ2ZQcf5Xn+7mmXtLvzNjW8EEhUrE0DmBz9UtcKkrcPHMH1+HjSR0NsEfwHsUdqO7zJwy3YzYBN0VV7IA0Scw81jtIRC4Ok8P4MFtrlVrZDv/2/BG/kJMr3QEEUgoi6G19W2zaW5jeypm5U59FIuG+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=174ubPrIc74W0n7vm3krPR+34v1XkpnNTDjoyugkHgA=;
 b=IKt59d196g4FGmLXWsLmpRPdjWjdJivSyuUUfwOVa7fowT/lqzaY+WxUysBRVWdoTF2KjbV3w9WAgxyPqcCPJQx3WxI1hrmkOiPSBq/BFWdj9HZEpOHEjUGZPxt0bawugV8/SVcu4YAujVjI3PhOZDwNkV+166gh++KftdXV3u1wNveTmwBdNVFn2ALzLLMRDEnl//nqM0A77nqxkrmjA+4FnQxz5aVgTuaSPg+eFztsHkOP2wUfVnKVAuOec83HBoZ1qolMd4qWKhSBNLaon9ay5aBTanCoqco+rpFbWw8uh6uyq7wCquWH8FC8zxUavQOk1UuTdHIZvTRfN3llFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=174ubPrIc74W0n7vm3krPR+34v1XkpnNTDjoyugkHgA=;
 b=K2xaQZpj8Zb8MXX6lFRKKQwcFKoZZemwU5w/Rj82NlTWbPDDDoQxB7wdgOAKzBlFF8rfiQHYizlJZ99rOSU872kwx6S4jfOaXZcBaE5lo/Gpkbc8agEiN3ultvAUIFRlrk3sL+Fe2CuDn9Sqgfk/lhhpO5PEUSdtsouq8ca6IwQ=
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:37:39 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::1f) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 14:37:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 14:37:38 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 09:37:37 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: update MES v11/v12 API for mes_dbgext
Date: Mon, 21 Sep 2026 10:37:20 -0400
Message-ID: <20260921143720.3698528-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6dc355-cf98-4134-6f58-08df17ede2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QcHujXkSdjHVmGxQJmJOz9NKJXW5qnKpwiJQKcbPi6whcF5JIAE6Y1g3k8YQoU2XKQUHSkz26s1tWBxIFmT0yHYxrhfYEjpJQXCdk0WziOuU4eJBiSXdRwQoUJrr6RsRFXAI/QX4YMs8pxfwEHMNwVsEyC4OPbAUFnebYtfaJj2PgiGZIWk9JkIZoyzwyDh9BjfsMn9vJBmYiOyabzDnCzm5/+5mlrKg4eBBThFT4/kobIVINVuMuRhjjwtBExFj1pMesIB9pfwO8PJK4NZ7lirr9l4UVRInH0VTSvAdL8yhim3RZVYwIc0JKzPU0eXp28oE1COGhGL7RDUFZHzbCgnNjZbE7IH4ORNT9nWrzFYKHrZ5ce9n7r0A3uM9QpwtnntsnAF3sQxaBsFMzM0jxdw1esoHEFKb79RzzCCUtH529enFWWkFKViJpj5rilWR14Lg554rJVI0KIO7uXcHXVGk8iLrF5JW9RjI7abz0cPmfi2hormyo0ZKzhs0jlPO7z0YtvCA6n+Q8zUvFXQ0Epx7AZUsnQqcDrfckB7VSOsb5vpDfVrdto9orjSWFFVWv62kMi7pHKk+3+loMXDR01Te40DVfF/2xn+bwex1wXot2h4edI04wrLbug1jQ+Okv8Ada/8EQjl+PNJy7envpghVzJ8N0AIedHgORhCVeClZHiDkOVHdKdSmxQVIne9uQsoIF/O28jwjiqLsYCvFRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ddf6t2vyFldwHQob67nufoByoeDzHgAGl9esvTIlY3dqbrWtr9r0kzbe4mTvJgTUanQX8xH+VP64QohR+41t1oIuthjJByb35E2/FW1ZLCETdBnH0wtbRzPnqBaQmJSij9jxalwgysp9NeUvGiUIziBK4D0/poEeYL+RlImtb3q08X4N/kUqUAP3VpJuIQwahCC2r3QFDvTEHG50rpv+OxgfypAFpCh/sS+Zoal1ByfHxISVx7luHPwGflKRPbB2uIM//3nP+4Bd2GwBOYbprx0EwabRiSf/x5Y60qHHQ2iN5Mlp2I/lyssGtlC7tfjFZNjJj6ZXCGLEZ1Sz4O5KaKBjm6ugdPOYzWayIb8zIs9kwnPrHb8g5kdQjhyeRhc1VCXRZLG2YZRUaSOp/zmJTn/XxrWejY0eC5OShxhmqNVxyoIgbcbzBCK64ysLUhZV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:37:38.8097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6dc355-cf98-4134-6f58-08df17ede2c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
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

Add the MES firmware debug-extension ("mes_dbgext") API definitions to
the shared MES v11 and v12 interface headers: the
MESAPI_MISC__SETUP_MES_DBGEXT misc opcode, the MES_DBGEXT_INIT_DATA
struct (log buffer MC address + option bits), and the corresponding
dbgext_init_data member of union MESAPI__MISC.

These describe the SETUP_MES_DBGEXT packet the firmware expects and are
consumed by the per-IP mes_dbgext wiring for gfx11 and gfx12.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 17 +++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index a8e6ccc7817c..e251ccc41f9c 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -622,6 +622,7 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
 	MESAPI_MISC__CHANGE_CONFIG,
 	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
 
 	MESAPI_MISC__MAX,
 };
@@ -702,6 +703,22 @@ struct CHANGE_CONFIG {
 	} tdr_config;
 };
 
+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+	uint64_t dbg_ext_mc_addr;
+	union {
+		struct {
+			uint64_t trigger_interrupt_per_new_msg : 1;
+			uint64_t reserved : 63;
+		};
+		uint64_t u64_all;
+	};
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -717,6 +734,7 @@ union MESAPI__MISC {
 			struct		SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
 			struct		CHANGE_CONFIG change_config;
+			struct		MES_DBGEXT_INIT_DATA dbgext_init_data;
 
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index cb7ebdfffeeb..3e214cb4f6e1 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -839,6 +839,22 @@ struct CHANGE_CONFIG {
 	} tdr_config;
 };
 
+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+	uint64_t dbg_ext_mc_addr;
+	union {
+		struct {
+			uint64_t trigger_interrupt_per_new_msg : 1;
+			uint64_t reserved : 63;
+		};
+		uint64_t u64_all;
+	};
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -853,6 +869,7 @@ union MESAPI__MISC {
 			struct SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
 			struct CHANGE_CONFIG change_config;
+			struct MES_DBGEXT_INIT_DATA dbgext_init_data;
 			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 		uint64_t		timestamp;
-- 
2.43.0

