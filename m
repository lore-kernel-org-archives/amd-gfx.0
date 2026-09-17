Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87C6C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF6310E6E3;
	Thu, 17 Sep 2026 11:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nz3zZt+X";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F4210E6E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh0GiSVWymEWXNdw09nzJDmPI0gLHvPA1JiQK28IHt9LNmQSvaygVyVc91vz9k4wweebcUuI5XbiUUEOfGATPnD1zhJ2P65cC/iUxUklbGUIlXzBVBIV0jrD5HtGahhtIDlRPWqjvJ2aWMhJj+Id6cyM0+i6KgjiBsNYRWHmQElQ+E8aOC14mhmCJNNtIXsaXWMqulO/jwd9G2ujLV7pvZFdEQl6kaqPxlljaVd/mCRkrr58ASpre0NtEwoT5WJOO+DbK+iTCm+iwAAIBDP09k6dw6KovR369U+TyQzy+rCNQlu2GZdLq17ZSfpDR1w2hR+nr/QEPRDMQMek0Su46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noUjbjoq8oSOY4kFP4IaP5hWxiFH69sKQVUAIpZ1zSc=;
 b=l3W1FLAjtcCj0CeZuXhEGlkshQT9x/3BB/bcAwAFczzL3W9TSszwc/eC8eiB5H7BrfjJTR3Rg1HTQf/0WOHUJbRuJMJPY6mWBPgAzVZ0sFUI0+fAr4U/IAgC19dXJuxoBiJx4KTIREkrEp0YgYzItgsEF5FL0u29Vijm1FTXCGhgIYxpnFtQ6bA6ybfOpl47GbRL0+JAjdqKkBPaXDNzcaL9NCUHPujs/jKCag1vnvtfZwqVxfaFWz1XR3MQwEjh4HMUdlOuoxplPqlcz8mx3XBU5LptcibN6NVwrFlv1g2ULNH7EK1gAXcVSAaLpCPXFp8Hmd09dZolcLLvWNIe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noUjbjoq8oSOY4kFP4IaP5hWxiFH69sKQVUAIpZ1zSc=;
 b=nz3zZt+X+iGbUAAV6tkFv6frFxZbqBnQJXyJcUjMENTJ7Xv8r5Inue6AaUD/CDcSYy4oOsUZWVJLDkd0URL3GrRTuYv51W6UwMAp6JVMlFQkHGOAdqbxNe5cxCGI0IE0Grb6nfH2mLRkT/rrxQA1/axmA4skmynNPV3dOdvlQmI=
Received: from SJ0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:a03:39c::6)
 by SA6PR12MB999201.namprd12.prod.outlook.com (2603:10b6:806:450::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:02:47 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::96) by SJ0PR03CA0331.outlook.office365.com
 (2603:10b6:a03:39c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:46 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:44 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amdgpu: remove unecessary parameters from
 trace_amdgpu_vm_update_ptes
Date: Thu, 17 Sep 2026 19:01:47 +0800
Message-ID: <20260917110158.296198-3-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA6PR12MB999201:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f30fed-7e06-4423-3480-08df14ab34e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T/WZmPBDF3RqXi8kovcv86OOU3fgunkieMqEfjPT794HRlwoi1eBRf3Q13FxSZRUkA6mCORBlwnhJ9Ig9fOFUaCrCm8AiQF+4Io5Etbd7tNltDJ5OEXVcauSZCZicWs/8XOAtaoI7Q8axChyD9/O9xNfykoFQFD0YKpth8SreP3+QQStpaIXyCLrt88jA0JqzH9PMLcTj/McO0+RW60k5Jg6yDZOh+L9Cs1UCFmENZH0ZsELvcs+MRgxRl/VJg0UnYhGHPtPdYgwAvjZY1H1Ap+3zZCA/N64g9KNuJqWPQ+UOgrpSFYs33TdpEsF3jIWFY0azwtHqzTa144L4MZuchOVsjpsq0WtIb7Hu+xamdVUR1tQ2/S6RXJPVHQtSxcSxzuFts7fWzVtaLgAtkThMN6eITcunAbDyS/jB+HrumLDN4dxvpxVfez2gKLoNVgAwB419gHyP77K81CbgIcLNdAuwy7ghjMxfZ6RI1jVxfLfBPkqEivXpKGPSmW455qqSxL8tdlbBhYI96cSvNIA4yN6eZdDLfp6RoqAd3Z9zPGnXHvjBqxA9CXU/PBFnae35a9wB+qlHgyY6SuRlvc0H29vnlnyin5NoS6tgInAPWIPgzPgMCObmd8l7zGnyhycGVarrB7URjwHrCpkVKKUg07aAnNceJBgVvAZdnqtV6eC75+qgO0/NZCKXxmIHzQDriiGJrZ4hlqbo1JflzLNeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z+rJA7W5YO5bBPxOd5CYptFtafVllvyQ/UKV/uqx0UPj5Dv48Ktfg1CiPfone1hzBP7raqlcqUNuQMBChsadxkbOz9mMzXtMc800/UjpY2mizuBBgkJkV9L4qoNSLj8LExH8csYE5SBQmn0v80I7FDlloQKoCPRlQKzlUAlR4amq/+uWniY7TdAhOwDAhqO0s5Dsx00JSFEKRE5XANZ2Ba1xUEBKuNj3nPiSU5Lp5mqqs2YRjvZoXzDJyRI+u2Be+pSP0KmKkwlsmbdhuDAGKfKNqYLQYNaEK/w5h57S/6UxSLVwIhxqj+cuRzz1ZtWSYtuYNVcBpOEUEfrSx6Kyw3tNa8sToBx3RsZFtTwHRwB6KX8T7yBPPnE3UxDqx4zRapsLxrQxBh/coS7dche4bHU1J7jXZGpM41PgI0+uiwBtKUMkxEIFh5CmepOn8nmt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:46.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f30fed-7e06-4423-3480-08df14ab34e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999201
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Those can be determined by the parameter structure as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  5 +----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 784adf975b04..599c1d0e512b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -331,9 +331,8 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 	    TP_PROTO(struct amdgpu_vm_update_params *p,
 		     uint64_t start, uint64_t end,
 		     unsigned int nptes, uint64_t dst,
-		     uint64_t incr, uint64_t flags,
-		     pid_t pid, uint64_t vm_ctx),
-	TP_ARGS(p, start, end, nptes, dst, incr, flags, pid, vm_ctx),
+		     uint64_t incr, uint64_t flags),
+	TP_ARGS(p, start, end, nptes, dst, incr, flags),
 	TP_STRUCT__entry(
 			 __field(u64, start)
 			 __field(u64, end)
@@ -353,8 +352,9 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
 			__entry->flags = flags;
 			__entry->incr = incr;
 			__entry->nptes = nptes;
-			__entry->pid = pid;
-			__entry->vm_ctx = vm_ctx;
+			__entry->pid = p->vm->task_info ?
+				p->vm->task_info->tgid : 0;
+			__entry->vm_ctx = p->vm->immediate.fence_context;
 			for (i = 0; i < nptes; ++i) {
 				u64 addr = p->pages_addr ? amdgpu_vm_map_gart(
 					p->pages_addr, dst) : dst;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 0d7fe32d0c7d..b85b70a1a428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -882,7 +882,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		entry_end = min(entry_end, end);
 
 		do {
-			struct amdgpu_vm *vm = params->vm;
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned int nptes = (upd_end - frag_start) >> shift;
 			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
@@ -894,9 +893,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
-						    upd_flags,
-						    vm->task_info ? vm->task_info->tgid : 0,
-						    vm->immediate.fence_context);
+						    upd_flags);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
 						   nptes, incr, upd_flags);
-- 
2.53.0

