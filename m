Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208CDC88E45
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A281A10F4F1;
	Fri, 11 Sep 2026 06:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkiU/3Vd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CF610F4F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsglR+sRYwzRflC17OCz0M311Y59lvpuXluR7IqLE3OLurJSeSTV1qRWmVT1Z0GG2plIPImL/fjIFOgJYDPEIusM87dz4VCr6xrArTuTJPYrqZi0Ygj8LGa0GMWZSaziHOaohzKFpb3l4Nt1vPkUZCGy9+Q1Y8kKOgN2NRQOa9NZRAkCPXLQ5i1SR5tUKwgT40xL6WbCLy2QYbbb39hhRyn/DTEjVVMeG7R2fZLcK/WgbRCQpmevIYg7oz/L/adF1osIaYYECW+K6w5RuOiVyo0YYNNk9skE6MJIcK5bPeK+M1GXi+y4/lCmrvBy2Bw0uerTHRtBkWO5Hdk06kmzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoWDr0CMbygrN+RQ19IYO9qOaX59tYWG4qKeMZP6nG4=;
 b=mpCbDJm1mm2ygTvYlLgWHaefuTQxcD3immg547gQ6rBdbeZEceskbca+Ae49GBUnJxa2I+DpUO4AyhBFojvZmK9UZx2CYofOHWZE3YH0ErbfuwvQj18JXILredqCIXaytnbtluYAONZl+S0uHcbtxCu5BThGZvYy2wR5EwpsjkXkv5wWDRiZv8nnFN0OASNM7S6cIoOOxDihvNkw0a9DmE/ZWRb45kJ/nt/JOBoN4oFbzxKq+1irVjtjE+AENov+SXGinfv0Tk97/SuWHOZHLmChh9FqSqFHQASrYOlJERkwGlTjDmEZlnUtsgkkaQMw+H9RUMWy2AFLjkIF9R8yCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoWDr0CMbygrN+RQ19IYO9qOaX59tYWG4qKeMZP6nG4=;
 b=mkiU/3Vdc5hzYIIeXsxEY/mqOfGLYheEKH4S8vPlzgNmbVwVlAIO9IV2o5lxnMCZqGvnwgNn5mbF38AROm5twPWhD1t2JQSMHmsrdEiwxHMEouojF2GzU/431Zq6+y6D6L6KqahQsc9M3Do/66B1Z87n6cmRZAJyHGbRzdjEGQc=
Received: from CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:46:07 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::46) by CH0PR07CA0022.outlook.office365.com
 (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 06:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:06 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:04 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 3/6] drm/amd/ras: support aca debug mode for mp1 v13_0
Date: Fri, 11 Sep 2026 14:44:07 +0800
Message-ID: <20260911064410.1693567-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aaeb93-4317-484b-2ada-08df0fd05b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|10086099003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: ECEsP5oCNFWoZedkmQxyrIF2aPKS6vz7dUSCzcKxkGO/zXOA9NzILpUZDxyj1iUpTMb/DVc5+3hruvTUcMiMdxpwLxl41ehiDnybP3JWfcEyRYpiEzUW90BwW/D3gFaU+sDM4pWXUM6axX8aW3Jg5peTFXbyVR/m5pG2iQICmm+o7CygkNQ+XtLobKpANFaUfiE9YbpRTGRGAZQEbqwnVezBSa3CSLVsapJ1z0vkYlYfJ1TRCQN2+0epTWJiZRCsfh9QevO1NITkOvT6xGn1ITarP1heV7XEon+KjxILe0cOQ8FWE/1jTJbe5N/+ei0r7ZCSPOL/kO3mTZPklKQOiqWhBYxGS0CYHP+JNgfeFxb8EL24Y8TWUQ3AZL+3r/eY5rCGjqrLp6gZrIu4iKOIpA3iYS5+eC2xVqkKo3kc73jBgzFEOae/J9Dys5k25IzTK74Sh3GNSD1OtvAqIl/RPbwEptmxkRmnL/iOIdrRXoeZ23VflSlL1f04HOB7WvWnjs3EpNFXMbMajNTknzc+SZG0LdfxCSJ03foXiZjG+NSIFqbE6fUTJKNLeyUDaRHK0uTJXIWI6asY5YItNAaTuIO8zJXYiN7tWSP2hUKs0MUqHD2NDjYkpm42u/4iuoqLklCPDyRjb/Fheo7A2wUP30iVoDYpKmv1TdZOyinFUY6YpHYvQqcGFaHJm1B5NS8YCN7cutkC2eEq+PdhNpv7tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(10086099003)(22082099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sjp1PoYmA3bkPJNWX9gTtHONznN+7gyLSSFSm3qPrzcNzW/6+rGnX4J7T1a3WrVj3LEAtnT8cOn/ipojYZKKJdNgph9ERGc0oAehD/S3HpnXmPvD4LHaULdsXfArcmisjtdAkOxOu0sQrDoddFIhHTU6MoI5h/T9Q11Tazwx+3nqxh4NH63jtEXFuhDmzuGKYW9rJdsZ8LJInSjuKCUBxn+r5Ai7F6rlFZ3hr1nke4hOWjYozArBLCOrKPGIT5CAZVZymrxHuucwIOcQnncPUSN7E827irlKkGUL6nNo/TIFfSNqBwxSYRS/a2FfpbvjYk769cddolCu1eWL14sB5E+XeoDeDZAkrEKmEuqBsDcjB22nGpomrM0i7W8K6VgtbxOHOgg4SVLS1BNPnibobtJcQinaGPKsYJGr1hwIeI/xk6jYIdWM79Fbcy2wl61G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:06.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aaeb93-4317-484b-2ada-08df0fd05b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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

Use uniras generic mp1 message to enable/disable
aca debug mode on mp1 v13_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c     | 15 +++++++++------
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
index a450e79a55ff..713c30c5e5a1 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
@@ -26,6 +26,12 @@
 #include "core_status.h"
 #include "ras_mp1_v13_0.h"
 
+#define MSG_DATA_LOW32(idx)   (((idx) & 0xFFFFU) | BIT(16))
+#define MSG_DATA_HIGH32(idx)  (((idx) & 0xFFFFU) | BIT(17))
+
+#define MP1_V13_ClearMcaOnRead_UE_FLAG_MASK  0x1
+#define MP1_V13_ClearMcaOnRead_CE_POLL_MASK  0x2
+
 static int __send_mp1_msg32(struct ras_core_context *ras_core,
 		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
 {
@@ -213,13 +219,10 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
 
 static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
 {
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-
-	if (!sys_func || !sys_func->mp1_set_debug_mode)
-		return -RAS_CORE_NOT_SUPPORTED;
+	u32 param = enable ? 0 :
+		(MP1_V13_ClearMcaOnRead_UE_FLAG_MASK | MP1_V13_ClearMcaOnRead_CE_POLL_MASK);
 
-	return sys_func->mp1_set_debug_mode(ras_core, enable);
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_ClearMcaOnRead, param, NULL);
 }
 
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index 8dd4b678e13a..eb7ffa354541 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -28,6 +28,7 @@
 static const enum smu_message_type ras_smu_msg_maps[RAS_MP1_MSG_MAX] = {
 	[RAS_MP1_MSG_QueryValidMcaCount] = SMU_MSG_QueryValidMcaCount,
 	[RAS_MP1_MSG_McaBankDumpDW] = SMU_MSG_McaBankDumpDW,
+	[RAS_MP1_MSG_ClearMcaOnRead] = SMU_MSG_ClearMcaOnRead,
 	[RAS_MP1_MSG_QueryValidMcaCeCount] = SMU_MSG_QueryValidMcaCeCount,
 	[RAS_MP1_MSG_McaBankCeDumpDW] = SMU_MSG_McaBankCeDumpDW,
 	[RAS_MP1_MSG_GetRasTableVersion] = SMU_MSG_GetRASTableVersion,
-- 
2.43.0

