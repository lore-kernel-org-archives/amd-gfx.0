Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6990FB44CA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4717B10F42A;
	Fri, 24 Apr 2026 08:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azXxjU1Q";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DEC110F42A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvZza3pta1sdFB/lJcpHSY/eo2S4rWxS1ljrtKahK8Vo+8OxiGjzNhcU3TxcRSEtEN96czNJQiArCeHiV7n+apQP0xYZXQIqWuRI2nkpNeLNhEP6i3OdKZZSYiODHB0MzEp4bjlYTLMSl3RsUb5lrmKN6RQ479lzw9RYugeE5o8FvHQL8z0BkLwBDPDJdxDiWcN8W23eX0Sh1CDv18T0kuktCqi3RdKaZkNfP9fRHnsM01tLw7/pL+PyjGU5G8CD/rJEFyXZvAjZV3QFGiVGAnxpe0KxVd7XTstSs53zVFfZYtCFZKCBE65+hfdIPvQ0LBP6LdwKxCWQLzUdU4xNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d420HY4efD2TFFanCsYjgLaFll4hXOUgEkhoqv5xMEU=;
 b=iVOMY0CcRYTY4MIbwlCejPAnK+Fuc5bzG+EvsZl+2ZVnCUuByvvfpuxtYWw9qg4IJbid5CBNQ82uIBHXjF6heRJcFwhO2Z6z9fmrBpY+TG+9rfylIiefPl6Q9dGs85cEGqr1qNMjz4RAxlF2ot6tCJzq7/zGdgANITw8zNLSwJVPf1MskKC4lyGcr+l378e1vvap+OzBrVXgjDbjNZ3WI3YfGtrBxrV9Y9b+o3tBck7w3745zwSKsxz/7980IRi4loqwRTkSWLCmFPJqzq/HnX72XnLCxXPPjOFa50m2XND04vfg+VVNFGMtJtTdi50XTvDfO0wzOtBPdnQe02uYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d420HY4efD2TFFanCsYjgLaFll4hXOUgEkhoqv5xMEU=;
 b=azXxjU1QyRYTyKc1+XrMg7WD7/EtiwrRTsWZx5prnIjZvlPiQ5OdGtGMlpYPACGbI4zUQeisVWJLnxnRTwy1mGE5oXC+OShcjcxMw4NJKA80LKpD2jWz2RYklfI6n8SdbTKRW4gihlpnE15FkYLS7Dx3dAwoB5fqQW1Ynq59CMQ=
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:20:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::75) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/mes12: plumb is_user_mode_submission,
 unmap_flag_addr, NOTIFY
Date: Fri, 24 Apr 2026 16:18:53 +0800
Message-ID: <20260424081955.873090-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 730ff0b2-6e6b-42d9-4390-08dea1da698d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3SIAmKF+zByT0gDd8+292Yywz9IB7U2BVk9l9hfaTcn0AUVnFy9/xFpf1qF22YSOg6HanoguYYjNffm4V+a20TjBcDEPenfRTknQ0KJ/E761G1ZrzPG1jv6CXqJgkhqQxn3w7Wx75Y6mbLAFXvwxXKUXNioc4GI6snKb0se+2l//cxX9qrsHA9HTziBL2I4gjeHpRO/kcargRQ2swmpcSbTzpBoyPoP7TmzAFI2djm/PRobfyXr4IJLlD4V831PEOcp6bCvvB4S6m2a6B4x1kCdFcwP6riBH9edW85bUcUul+KyGn3DLx4+/71+6JLKTHtpacRxrgAcirVSaxJjzw0/eClWqu7kz+Tx6V8pXlpheCFdoxyHR63Y377AD8U48DyHqOLuEd/IipCJVQNu4m2Ms97SU/FGThmY1wUk1d3MiP737oOKK50w25uwZGIdaEv3HxlpWpiHDLljCfGqZF1U+9VKw5smS8yg7RfgxWisdzrt4N5fy3pgE0RoeQtrh0+1k/ohtud4t2VfXQL/EdOAKs9GRPMp01JTaVq7IxlZNQ51XEd5qDmChMYzLzc/3VQbTvBEthkssbujAipG2r2IzY7uhtOeva3gd4xRWeKMx1KZx0YeazNDz7+pkNzD/n23RR32M41OGzGMsxbrjKwMfbYWWgJI6gesYm/XTv8gNSqize56OhZ3BsXvfy48gLP6dpxPFw0spYugbMhIfS7wldr2zqUe3TNkR3CmlUCvY6Q80oLA+BtvdKtMgKz85rWyhSpXxDUXuscjgETwJvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JoSJlcduQN8sssmfuf8GC6QdusRlRxfoORv/dAe/ITdVNmqBuw3glIEOpNSjAQTHkT0ki0MgC8N3Xdh3DTsB8q+MRS698J2kouMStgfZKK3mkbU3mXveg/7qxEOPi/Tif0DjlfXftW32AuxjMasUq955XqVZZY3IvU+GCUwC/X9iKVMPnVS8x5Vbktv0LuI/8nRwHrSlocMVrzU1CVsq4WzbnaHlDBRXRxlRNpiewhu6bn2ePjCxunecshfeKkCLwaqKN3eerHMRPy6hUeQ/tqvJ+XKwveFAK7eenEYS2B5RmCgrbDPowqNdcjchJ+hkfGSQoIoSCVA9Re2fRd0J4vCv/hsxp64Fd7QARmM2gMGKSUv7mIlovZfb7oH2sV7dSqRWj70//93qUlBVrbCozH/tBjKvC0SCIexI0heSah3+vP7sZ4NZvyPGJtjCyGg/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:57.8563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730ff0b2-6e6b-42d9-4390-08dea1da698d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Pass is_user_mode_submission and unmap_flag_addr from
mes_add_queue_input through to MESAPI__ADD_QUEUE in both mes_v12_0
and mes_v12_1 add_hw_queue paths, and route
MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE to the matching MESAPI_MISC
opcode.

The kernel-side caller that actually sets is_user_mode_submission for
SDMA UMQs lives in a later patch; this one is just the engine-level
plumbing.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..5acc505533f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -342,6 +342,8 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_en = input->trap_en;
 	mes_add_queue_pkt.skip_process_ctx_clear = input->skip_process_ctx_clear;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+	mes_add_queue_pkt.is_user_mode_submission = input->is_user_mode_submission;
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
 
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
@@ -697,6 +699,10 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		DRM_ERROR("unsupported misc op (%d)\n", input->op);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 2d8a10d18939..235dbbf99ec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -325,6 +325,8 @@ static int mes_v12_1_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_en = input->trap_en;
 	mes_add_queue_pkt.skip_process_ctx_clear = input->skip_process_ctx_clear;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+	mes_add_queue_pkt.is_user_mode_submission = input->is_user_mode_submission;
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
 
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
@@ -598,6 +600,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 			input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
-- 
2.49.0

