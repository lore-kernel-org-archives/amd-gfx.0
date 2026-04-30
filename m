Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3058FFF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A505D10F393;
	Thu, 30 Apr 2026 16:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Q25gGhC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6134210F39F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx0w71+AO5yj1sxtRNgOJ3HQgyh9Poq5+U6s/6Pjc2D5cWU213+nD3X/mRnSylkp3SFOsqPbkszAOx32GMHllrQGUw7nFIA4r0S7rwZgY5jCPpdyYasaEF5+4NWNpSO4y8bhutBFDLYOSyUsrdmIhViiHtvhuKozPhEIO9p5m/YQNsJItWaj7TPuRzNYT9ByG/TVKc3y2hs5/ZcaOd0TVFdjprmVooInmxnz+7FwAB/+T5LKNjUV4Yut9zqoMAV0W/Se88aj9404877jxIKYBuqTjPtVFu6OdMTm0IYxGQi0l/woQL+FojzS56SUX9brjq/eB6pjTHynIFVATiFiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=NwNAsLT0Gbfwsv1OvJSSZZxyU8D5FvNcPFcvTQYvkPGkGBTwwPcnEwXQgQ+Vf3+5uN0+es+ceQn/M8utfXZrXidj95kBm7uT0j1nSetzQmX5wl9spW3DtZjquAznPFLD2dis+0Xktdis7wogUr1uagAurGnwDfy1MLqgvogt0J4OHZMX9frbxbwp+nK/DHdo8p0+6YawRBPGYG1+uNlcWyGuWU+IBFVgu9RMn2DqCNoFwNCE4EaHUjYe5tX8zjrM9rEon1r7nG5ulO6YWk8dFNd+O8kmrpHgQXSm0WvFyN3ywv3OGpXcFCBFj1UxHjwq8ipea1ixDdl+baWD9Lqhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=2Q25gGhCNLbDPjNXSce1vqmH50q5r3uPitYbMKIAS//Qs6bV+YkLEPf7H2YgNwQG5MdylvJVRPabAeqArV9Lh++dJmtwRIetq47nSzhlBG16w4EXiGu2p5p0JNWFASRw+3ttYdsHOezT/0bJxb6psDRcTk5FWChpdsNtGEFda2o=
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 16:12:08 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::bb) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 16:12:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:05 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 03/10] drm/amdgpu/mes12: plumb is_user_mode_submission,
 unmap_flag_addr, NOTIFY
Date: Fri, 1 May 2026 00:03:31 +0800
Message-ID: <20260430161146.2851078-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: d619bd81-9352-4445-d069-08dea6d33a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wGtZaBnu6zZmfzVeMdKgKA/wjJpUrcbrWInwp+9nNOkhrWDvHKpqO9UY9bNHsaEVa9Cl15gNyQq5boRl+OOGkqhV15R4jdV6q7yhREDJmZze4Dp5AjECL/xkkE70i2NkNwz+XXtqHEx8WK2J3JZJAcqxILmfZ0rZQWOgLVaqgX94i/L2DmlyQztTRihZv2L5QGWdywabbaoVfflYckDj4QDe0s6ZPOO6KUq4jugg5TglV/fjy6Hf1ohTn0457gQhHdyAkLVhsHu40tpbY7HoNt+QWG4BNsnH4ZabxAzFoeLdCxnnCRX1jFoM8SSqYFiC64KcbZAJMXfRZWEBhP/sxx80nes9AsN7jCsiDcjdxXwof/ft9VfiuO1Z2kjjDWWQM86Y75pQmc495026b3XfgARO6tAUjJRK18sTpJracmcmXBYUtpF81yNXNDEPI9gdb22K9Vtfmn7DiiXXiPZhu1hu/sIY6eBfsqza2PkTdE6xvV3Fwjt8J0ScPbP27QFdCNRPN4vU2S/afrJ88yBidlvpauRpBuvMYkkT5sOrmssm4Q6zuVdXZYtHyA1QJWFDj5UKHSyEKKv5Wr6zfre2bLibmDpCXV3gy/dRCZuHVhkWfmVwFrKuLow+lpsM274Ayw2WDbAV4fGVbKDoCEMrfZndYSc4XgoPTI6Kf+hVrOdhx0MhKYB37P1+jI5NeZJke8xnHIzEGwN5ibtLHwbRTD8QOn5t85M9bK8JJyKquIbRC45v20iMGOPzgdC8nYx3CPbqzaNxZiiH2jW28aP4ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nzac0RLsLnWjOpNT5NkhFydOLnPbbBslDATy8clhJoOxxq5OYDllNlg7bqcs3ipEUKkWWfKmT/qDOFoyc9d3SM8gVgsl6QWvlZPgAXsyQVIhzNkjywugFS6QutjU1PXVavDYGD+BiKLc/6R6fOABqVf26mf4YRxwHYt1uuYmY5IRLN4mprLuoS7muY505u6J9GXyRpdMmR3+uKL5DbZQ9tVv6PsQbPU8T1FAjYq7hSxmOaicJ1tiPDAjskrpvRTgrGp7Bvhf8AHgY+JHCchMTKr/z7pfv3nLvWLLFnYcPxW0Ua8Y5S5zJmWrxp1YM9usE4UU8zzxseXYXpvMvXwV5R08gz8TKUvL810QgQhHnZPXYvPA2Cfld+uEC5QFnoDUkKJ3GisP2dKY3k9KITywjTy/3yOHuDITCZ2vwmxoIsLd74yiB++XMfimNbIbMrga
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:08.1482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d619bd81-9352-4445-d069-08dea6d33a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

Pass is_user_mode_submission and unmap_flag_addr from
mes_add_queue_input through to MESAPI__ADD_QUEUE in both mes_v12_0
add_hw_queue paths, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

The kernel-side caller that actually sets is_user_mode_submission for
SDMA UMQs lives in a later patch; this one is just the engine-level
plumbing.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
-- 
2.49.0

