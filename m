Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE5DFF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E35E10E5D1;
	Mon, 27 Apr 2026 07:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxzdEEoO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2A610E5B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThTTl3fZK0gm8ynuDfXPGUw8hbBaApZ30MLtnBfca+ZeJsxoiie42gltDK2xHBtLjsb5IPmnjZOzIPPKzSHBFy+lUK8V8tFy+VFeDUM5D1lGxreRreSL5KztqUBNsplN/m2WmpXvuVNr2IRANSJZOMXWLBkjAB0tKP/XNr2hYAIJk2naZyc0QxoIVaob7+fEiTP40mX4WQ9zLBwZeAm5cTiF6bAzxAElWnkZyBR0ubJIHUkiLvtj7mPN3btN9jgXanl696SKWdK3lc+oYdnbgHyYRXab6ILKDjxr3Vxd/Db8Jj3UHcKsrptyVHYPOxsckrix9brh3UN2sn6Se8MWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phrxuv0CKURW5rcHisl3G11GJs05yKX38i3w0fK4/Ok=;
 b=eZgVHIVIGQFiZMUX9RgN1jorXFakuU25+t78UDxQhJ6a/U+G1QnJN0hwe15dfSmwgYdQ4F3rDhQn3grXAxuy63wnDfKYQXYdkxkuYeSimYu+AOZ1IGi+TQoQLrFrcoBetdH+41ROvqWtK+o9hHsDKOS2Rs0bhttJcDnbhXWqWju07Ut2ChrqZ4FZInORUXw8nGT7k3hz9tIc4/LEHHUOlbRx/SMtamwAoGbOKCW8DEVNr+ynx2vx/UA8rdrS18tXdUDzbwVK27aKcFQhxSdOenXcCiulDokesfPfTOLpYK8AiNG8L5xM/+HAnP6uHtAH7vYOqtYVqE6oHrMFbhYMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phrxuv0CKURW5rcHisl3G11GJs05yKX38i3w0fK4/Ok=;
 b=pxzdEEoOyAYzaZQttpGNFbE8k4sUtBzXMChI1EYFNtEgjKWkyxo6OW2Xz3e8+HKIkAcCtKl+N1nOuF369rNrDQrVuK7Cf+0yycy40wj91SPOKC8LM7LkWtVk8gLV/dUoVErCIGCENQR79UYPuR8Qp3KlIFGmmZjNQy4MkjyO7oI=
Received: from PH7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:510:339::31)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:34:19 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::42) by PH7PR03CA0005.outlook.office365.com
 (2603:10b6:510:339::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:34:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:34:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0
Date: Mon, 27 Apr 2026 15:33:53 +0800
Message-ID: <20260427073355.3363500-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de4d5d1-2ca1-489d-4d8c-08dea42f64ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TihLoZ5OKzMUh3vozfwIWYYPMDyy4ZnhmRTl0i8O5Ryu8BfjpgP5NaOl1jh9ZForucnkCWtpRBWYED0qniUsWC8+oZHElwKvBLkKFCaQjSLIuS8qMLj3AlgZQoH1t3WQ9OjF3UGza8TJgeGZvFL9PryRQF0XFSs5FvPgYR5jWQ1CMLzmgb0u2cgddF7tjDvdU8GXtDBtsX6sNU83oMzaTg7m/KknLNrwQtgDLD6Wna1jyZg008jibTenyDYWSwxvpD+H13EZMxLzGm7faLngeuVPtFJTjuAwXYQz6Pz3kBCYHMWWrdB7ZlWbS1u5QR0OEtR9eobOL811ma/to1s33VpJO4XaY3h556UV9GfU28FrTcDROj+quwojUuX7Wp+CbjSMdWti456bOXXH5gqjRHywvBXkvn2iNqWCeN8A6SjWdHzEkxqY0fjGURJeJPjYjSw8LI7uXaCBKgZSks6OpvpoYuKzvzAlk5FzLFZOranNJk5Mqb+OHNzr5lb3YcGACwnaRjGiUgJrJ9mfeGtlOq/UBB/AlxB97gxSEbTmh1vemoht7VotzpNrQqN+wOUp15O2BOaDUNmUdg7R/O+YsMgaA4JWfpwXbIjo+iGs14F5Mjt2korrtuk21fAwUvZKomJqtiqyApajmHRjDWcc1wfY2PuEs7GfN1Q+IiTzbJVzPdFqLqCD6PqaUcsdRyWc2uoS5lEJXW5ZptlayIUhrwMj2N6RnAu6kj1l9ZeFBXG2MIhpI9ZfozoEj0PQ7OlrjYYbXNLG6aYTHMuo9OCdKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9Pkxv9J/P2/FZf2JbjeFvjckhWTu8+yls1FDObd1zsDN2h0J+iGhc/5DZsF/g3R2DUnseYtN6s3QO20nDpH3elW1FpFs5Nwr4NEW9L96qROVZZ/OUr+BHhVZMlz44bmTPj+g/6k5HGlUWnosrSZO6UVPDK1AhcG4TM5EpfgcIVXz4fOGpASvoKAJoaloQl+SzUitEVgVKLmKuR5EMFq/Cb/Xl9f7C3dEBIZzOwlaQSAB2sJUuLT20frPWvsfv4RDLJjlk4E3S2x46rnKQV2fbtxCt0uGjYuJoTQfflA68Otwb4sFaJ8UGSnkUJA9H3wOpw8AuQNoucCO7eqFEGfySDb2jyHAaMPS5Gng5/6MQVqtvgFfCTx3BagjYkgVp5UWa9lJrqxyN8kxySOr5YU/czaYnSh4ZuXbzAF9gtpwXzIFBJMGen3FtbUuZOXtEQxw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:34:19.2679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de4d5d1-2ca1-489d-4d8c-08dea42f64ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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

Convert the SMU15 table address messages to
smu_cmn_send_smc_msg_with_params() so they use the common SMU
multi-msgs helper instead of open-coding struct smu_msg_args.

No functional change intended.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 47 +++++++++----------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 5649f2e71ac6..4f0c94821e3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -590,52 +590,47 @@ int smu_v15_0_notify_memory_pool_location(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *memory_pool = &smu_table->memory_pool;
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_DramLogSetDramAddr,
-		.num_args = 3,
-		.num_out_args = 0,
-	};
+	uint32_t params[3];
 
 	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
 		return 0;
 
 	/* SMU_MSG_DramLogSetDramAddr: ARG0=low, ARG1=high, ARG2=size */
-	args.args[0] = lower_32_bits(memory_pool->mc_address);
-	args.args[1] = upper_32_bits(memory_pool->mc_address);
-	args.args[2] = (u32)memory_pool->size;
-
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	params[0] = lower_32_bits(memory_pool->mc_address);
+	params[1] = upper_32_bits(memory_pool->mc_address);
+	params[2] = (u32)memory_pool->size;
+
+	return smu_cmn_send_smc_msg_with_params(smu,
+						SMU_MSG_DramLogSetDramAddr,
+						params, ARRAY_SIZE(params),
+						NULL, 0);
 }
 
 int smu_v15_0_set_driver_table_location(struct smu_context *smu)
 {
 	struct smu_table *driver_table = &smu->smu_table.driver_table;
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetDriverDramAddr,
-		.num_args = 2,
-		.num_out_args = 0,
+	const uint32_t params[] = {
+		lower_32_bits(driver_table->mc_address),
+		upper_32_bits(driver_table->mc_address),
 	};
 
-	args.args[0] = lower_32_bits(driver_table->mc_address);
-	args.args[1] = upper_32_bits(driver_table->mc_address);
-
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	return smu_cmn_send_smc_msg_with_params(smu, SMU_MSG_SetDriverDramAddr,
+						params, ARRAY_SIZE(params),
+						NULL, 0);
 }
 
 int smu_v15_0_set_tool_table_location(struct smu_context *smu)
 {
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetToolsDramAddr,
-		.num_args = 2,
-		.num_out_args = 0,
+	const uint32_t params[] = {
+		lower_32_bits(tool_table->mc_address),
+		upper_32_bits(tool_table->mc_address),
 	};
 
 	/* SMU_MSG_SetToolsDramAddr: ARG0=low, ARG1=high */
-	args.args[0] = lower_32_bits(tool_table->mc_address);
-	args.args[1] = upper_32_bits(tool_table->mc_address);
-
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	return smu_cmn_send_smc_msg_with_params(smu, SMU_MSG_SetToolsDramAddr,
+						params, ARRAY_SIZE(params),
+						NULL, 0);
 }
 
 int smu_v15_0_set_allowed_mask(struct smu_context *smu)
-- 
2.47.3

