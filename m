Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1514C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE2910E58C;
	Wed, 23 Sep 2026 19:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLo3CP7n";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F025010E58C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJqbUMMVF1f2rOxSXkLSkcW6zw64w1j0Z+c0D8gAtilJHC7J1Rm5lbfqXnmPAuD1vfsVf+HnrQWSxy/9rR9SG3GfSOXPlOh02bGw5R/kobaxDkd0jvEjUdMvp4wA8Q5WmcN+eADL8wXPGsCbA2OLCyqU34MHEKZlcOYMYR/yc9KXFKTLbh65rU5sYa7CYux6yFO/iOUByV9Zc56XrBhqH36do+bsTOQuzNYgC2V42BBw0V9Ikgced3kD0oYGtphilT04ydwJ/YgHgeBAJY87bg4YMb1z82IKJLQP13WO6lod8tQXHQ/WN/0IKcfvgwspnPhvdgLxbjW5vXFli1IDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=174ubPrIc74W0n7vm3krPR+34v1XkpnNTDjoyugkHgA=;
 b=WZxqQJJnemKyulcYfJ8OoJJgjHALq9RJfQJx05TP7CEy7X0pkiX2oUeWnZpP/Cy73F/ZErRcbFpMSk5St02C0mRra5yIyn3rq8x/XiCezZrfUQ0t2A8SOds3Tq6QoP8NLM0ghjmRmNcpg9amBtl8PGIJD4Q+mDtBsDg7CnPJVe8zEvrHmdfY47Y0bYjbbwRb15MRXZxBDMWX7w8R22mSKWNblmXI8MczxD+87khoNNeTRvLAsnNWtLLP6lXFtVqYWNAU8fCFqCHUgMLXASfF2JVM9dejreeS2OFFjDMv8F2spvV0x9sBakKTm8DxtmHSDlhfHPKMDRj++0XlJIdbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=174ubPrIc74W0n7vm3krPR+34v1XkpnNTDjoyugkHgA=;
 b=OLo3CP7nYK0cFnPPa+HbC7ecOu98hKizTC+vp7rIWk/qjjWHfYJhBzcAKuLX2a5RTIrUAhMWbDFOjyOwqPK0nexyjJo6YsyesUoArZtnq9sMpzAUVfY0+PthHeut+jMEolT3pvEdOKCr8SXDdzOhrVVN+flon4qlt/GT9p+TM4g=
Received: from PH8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:2cd::20)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:18:58 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::15) by PH8PR07CA0015.outlook.office365.com
 (2603:10b6:510:2cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 19:18:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:18:54 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 14:18:53 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: update MES v11/v12 API for mes_dbgext
Date: Wed, 23 Sep 2026 15:18:41 -0400
Message-ID: <20260923191842.976419-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 622fa744-17a9-4951-a43b-08df19a7825c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: jqDjs1YxCwlb+X0tQFII77iQvNjhAaeNRFAVDLnjpxL8Uo6r5kv1ioVaedOeB/G5jso3nnuMUHTWOuIlZ8FyRg4VfLIY5HciYsCTBdiLoB0FInF7/x8zQM+HjGV9zRXEHqty3Cbk7vsWwCbB+bQ5VRANAeNKUQpiqfva15fCi3obouwNSF9nJgRh0Z9gsoQUUNYjhwB5SRW21CuQGrzqPY8GvbAjKqM5CCsGo13qvsMtDmRJB3/2Nri9Idh7SgLnT5syqFPaSd9MlUrBj3VVS4SGFysmBbsEB8oSOW0zTeEGJqe9RH5JvMQY60FavJD8RTjHa/SSzsips3VnuVUPOJZPjfFuM2dc6SQS6/TroBGvcDSCyXxoTMjhygnD9eEe/VNDL3NP+o9YvnSZiU5r3jo0VIBcZOE+XdUS3XjJuZq3jNco9wE7NlkyH/snSIQPmkjGp3ux+u7IhuqfjumaVNPTmEXVUvmFQiUqAKlgzrm/o+3irWgvfm+Mt5IAnGGX2pHBJax/4iDJNnGYk1/KCXXKaOSy5wPcsrb90tVFjCNSPp8unsrdEFIghL2wLM+3IqzarZ0CsQky5UXt3JTBzdeeJQBkSmgAgXhgWoCvKN+w4bnCk0RuTDJqTTUTdN00PnzVbM95LNOWi135ZcLjHhCmqdP1tKsN3f2hSJ3K8dhYf2LbVrAZJu7byPArRaF4o2Wb87V89iYzUYkfdnfuLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPAwioat+k7zOF3I7Dof3NgCWggstmzT9e+Iqn/R1nMcqsNjrEbAb1ZdbRG/j2v7d7ARC7zUa42/YlsFdj1KSGLgSUAlLLnBz3cgTFpwF9Y+cCdT1whX54qJTOnIHXMejQibcqepE+pkj0erQuZQBIavcDdLv6PFIsR0OBugiHXLZd3xk9fmEnk21vukx6L9BYgGsQeahs1HUjb18+zxKLqQvZQtGLEmF9JMyCiiOu9v0M5eKEX7lgAvzXbCxY5jPdCJYxar5/E/Bu+o786btS7NdlwOmtY7m6qm2RR7lyRYTIFf4ZeLU926qRG+3cSxDRvX3z/hUClNkBplxzdEbJ/DDx1T67EjQMV4mUQXSN5MBiW3xVQw4jmFTiVElgDhJSCLzWV+d1AFpf55uwDk1idHzvWpdv/UXJTrsNYff59bzpTHfn2EKhLKRHPSwQ7t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:18:54.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622fa744-17a9-4951-a43b-08df19a7825c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

