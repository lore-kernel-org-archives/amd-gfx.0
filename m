Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D61088E78
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 05:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C758010E84E;
	Thu, 19 Mar 2026 05:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4arTBjk";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C80510E84E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2HRZTSsJELBrDZFHDfczmwk5Sj4DpieChY9jGXOrzyY/XbQs4DPTwcU80VVlE6+Vwj56MdnmZiZzPFeBrnulnexG9bJGot6zlR68BHVcATqgKv+ATKVWkdLTDI20g0TG3E4wQNV9ndm759/C6OGwUQQ+vPgvqx2Di+pJRrLS5WY08dIfZJJVPqVBjJd3J4SzbIkN/+np+ChSVCbEWZqAkNZcZA9sQVYqQLNDp6HDd+oiLe0k7oaXtoYClLosglJHqDCQ55TRDWTzWpkDY/rNh5l/L6njmY2ClGPNynlzygWcEQjI64R8Mjjm/kHOZHyQD2J279k3A3NOjtgdX7AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gMVjjvVKDyLFf2GM7UD79GmjlVKFUNd5A/ARQnkCRs=;
 b=bOcoZsOadeyGyQv/1qOglxaVu0BNwSBOET4EKFlA6BCWRkQFt4nMvzlqmsM/G6/d5nLdyCOGlCma+n/XKiGRlSq20ApPUGh1t9iQLNjSauOrcjIq5j3/EhH+8j5afKwEOE30L3tPXvuS8OBJgU/WY1+Vyynq5J3Xq9RK5W8qySQkI38fwix9f/peCfgOri0Ezzxel5JTIWY5t70d0C06P9k0Cxl44DOA2F6EBdO6hzE4tChYfUlSfUcfrxFAMyW5ZdavGGMcvlgacvPxKLMsj89DKcyDom9pBqtXY5+UHVTGUK9e5YCke6ZD80QxulN8U/VtUz3LbxKrbdNfdTBU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gMVjjvVKDyLFf2GM7UD79GmjlVKFUNd5A/ARQnkCRs=;
 b=l4arTBjkmC0/olA7zZxJNTRv6llja/V+DOo0hAtGK/ThPkeCwkNOu2MVnOu2AsSC4H1gBwkugUoEf/Pz0WRgKjCpshw506Ik/FSEC3UOZUiwSP1Irz61DvyfzPTSta2TBpYRL1P/jF2CQYwJZnsVNALrK5yfqK9RVMO3kcIaC14=
Received: from IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::17)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 05:48:18 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::f8) by IA1P220CA0007.outlook.office365.com
 (2603:10b6:208:461::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 05:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 05:48:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 00:48:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: Add NULL checks for ras_core sys_fn callbacks
Date: Thu, 19 Mar 2026 11:17:57 +0530
Message-ID: <20260319054757.1987819-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
References: <20260319054757.1987819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb86465-7d5c-4e4e-db9f-08de857b1efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Uv2LvMGviZpMMTQPE/Z5Pu/C7y3aPHT2/XQD2uWcrTkhOXHjYM7/GrbUVk17Esc110YyI6qkFqC6QNUYrO2MUwTYwaDYYP0uFpbu8ShR1f6yddrdOGlZxIAgxSNKXhgI7uMZgrUDS/TquOdr2wFiz/UopuyoDy5xXc77Tdcwssgc4Y2DguXXuvgHl/iaMWOgHA0rV0Mr4SyGXNLX371rW/j4CGIXwExemvSg+18kTnEMhU2SyUVf7em+RirkzbitynbMTKE7RY0xbcwkUeY+g/l5KkyfQ+v7yRvrhWHfYa21Aan2a9QZ2Ltm3jXZZDnNuCEtNghEDe6ncAByksAmBbj1OxSCb6mBtZyRUbKGFMwW1zFVZQQVEnxX0lUV6GfrkZYqW0eZfXiOgobYaAawhKbtBkCoXqW2be7ZT25vyV3ZGi9T8cFtRhNIRx8rDp438z4ENU7ruc35mp5NQ9dB/aVmhpLpe8K5GpQSUhoQHnkiAGrNvDY7eM2ddIXTmSIBkGVFxG5oS7qpzWI1QGLK+kll+6nJhMmMMOwrf4opzgRMcENTWf3pVpipi1HguyqA0e5RrDmLZlHK9uOM4NUbsMLMQI2fUIEM1XmyEExBvZ9UXoplK0EuqcT6m4/qjG2Vm4fxguPF1wE61IpEkxzLUHeHxbM1NmrlImblvhhSzi5g0iCdCRp65H0XXM1FJxg3mnecRXRZCs2eIc8XQFe5uSwCnsvxv8QC8U3oJ6/4xT5MLS5LQVrU1P29L2k+TkItVwVRrJXv//XHZfynAjzpFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t28tQW3cKFCGXq0yRI2q5XDXJCiehKG7DwJPQMMtGCHhBvI6CiCLLVizLBJdxr+2TwQDQLd1XHdfbp0vqT5hV4mGSTrhhiwoY88C8cl0FGZAbYA8VQBbLiGRnBKwLoVFAfv7wFsFuCBPmUEaI33hXYIwneWA3O3AexvVhsMlQVOH46+Pvz6rTathyb37yVJCLHU/MqQKkYs5pHBKgEixrXPxwIfkRq710tLjWsM0zRNMkFmU/FZjE/vUsa7/NJDn0r1l5Zx1NeExvqqVG2BB5k0i0cFDspeQZB1IOkl2hS+2c9SpftUqb+1h8UhFx9YRlk6ccjDJ3M80MH+OP0z5oe3toA89Yz0N+7Ze7Fx48upO08CyLNbEpAjQMYTFqeDJl/6ThxVhjNC2Q/XLnHUztbls5yrBsX6mUO/U24GwB4eeqZ7cqH1KJrjpXZtb2ju6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:48:18.0171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb86465-7d5c-4e4e-db9f-08de857b1efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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

Some ras core helper functions access ras_core and its callback
table (sys_fn) without validating them first.

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I2859a63a86a8f38585c98f7627fa1e19e83a17b0
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 4e84220ef152..29b1b8f0cc26 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -119,6 +119,9 @@ bool ras_core_gpu_in_reset(struct ras_core_context *ras_core)
 {
 	uint32_t status = 0;
 
+	if (!ras_core)
+		return false;
+
 	if (ras_core->sys_fn &&
 		ras_core->sys_fn->check_gpu_status)
 		ras_core->sys_fn->check_gpu_status(ras_core, &status);
@@ -130,6 +133,9 @@ bool ras_core_gpu_is_vf(struct ras_core_context *ras_core)
 {
 	uint32_t status = 0;
 
+	if (!ras_core)
+		return false;
+
 	if (ras_core->sys_fn &&
 		ras_core->sys_fn->check_gpu_status)
 		ras_core->sys_fn->check_gpu_status(ras_core, &status);
@@ -485,6 +491,9 @@ int ras_core_handle_fatal_error(struct ras_core_context *ras_core)
 
 uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core)
 {
+	if (!ras_core)
+		return 0;
+
 	if (ras_core->ras_nbio.ip_func &&
 	    ras_core->ras_nbio.ip_func->get_memory_partition_mode)
 		return ras_core->ras_nbio.ip_func->get_memory_partition_mode(ras_core);
@@ -568,6 +577,8 @@ bool ras_core_ras_interrupt_detected(struct ras_core_context *ras_core)
 int ras_core_get_gpu_mem(struct ras_core_context *ras_core,
 	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
 {
+	if (!ras_core || !gpu_mem)
+		return -EINVAL;
 	if (ras_core->sys_fn && ras_core->sys_fn->get_gpu_mem)
 		return ras_core->sys_fn->get_gpu_mem(ras_core, mem_type, gpu_mem);
 
@@ -578,6 +589,8 @@ int ras_core_get_gpu_mem(struct ras_core_context *ras_core,
 int ras_core_put_gpu_mem(struct ras_core_context *ras_core,
 	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
 {
+	if (!ras_core || !gpu_mem)
+		return -EINVAL;
 	if (ras_core->sys_fn && ras_core->sys_fn->put_gpu_mem)
 		return ras_core->sys_fn->put_gpu_mem(ras_core, mem_type, gpu_mem);
 
-- 
2.34.1

