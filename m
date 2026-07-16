Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC6C44507
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 03:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD1710E1DF;
	Thu, 16 Jul 2026 03:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2VQT4H/y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBB510E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 03:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Meu0kVV98ue58wOaRDTebtyNpCEdU1EVdhA2ZBXaWxcXhGY1EO1jYxRXAnerqv7pDmAPWRG3prTswcADNe1pLhHP8itQjp4ZFRzNn54sVkijrSVKgNLKxUQpcT711p6fuCW2YpaYctcCeEDpQkpJ6W3g6L9Kr0hYdMrWMYnAtMCOibfb8vrtrY1JM7ApresjuC+PPyswWVvyZjW57ln4OvL9uiA3hPNefUOwYD2hjwlo2BEnqIFINioDbrgJr9Og+U9SH9joYil2oroFctib+w2PjWk1Zxf7diRMsjnf4t1ejIPWBgJ+l+Gdq80ia0d0jnyVH2fzRW61ofCqQnmNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFIa3kX+jPU8q2K5kZmc/Nnf0g5bAPNlZ3P+qBz6/1A=;
 b=masziGVNb7fOU3IJKkvLNIR/fFwtL3Nv8GZYHETaEHLHJIS0igJgRjOeb5NORD8xSx8N+TPNONkl9yiqMX8+DfKW/hhVqxwvWd+PtxYfVD99VeTMaEtvB5JD2bWkb/c+b8is+qhM5moiwjyzYTjfUI/8Vc4rp5UMJQcKoOeySjAVfzKlUwq7xP+EqT7ZPDPedyaXi3XBdQ/3nPzwmccle7xMjyUmOvDEup+96OvKpVzEXzBAwBipHc0680X/LPrtS2WmBjomhORrmHFcMPDF1MJFuJ44d1wYquv0XDMsQb+MMRFjsp3V0lKqCAS6ygsJG6LNYalR7Z2Gm2vUtX8EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFIa3kX+jPU8q2K5kZmc/Nnf0g5bAPNlZ3P+qBz6/1A=;
 b=2VQT4H/yTwS9XSDULbvtd8pZYDHqAuntRSeWUriNnV/oo1NMywt0ngb3rtnLbTZSG4xV6ctERBtB8uB9Qs4wtLjSQou56LD7sMJnLaUX3ViRaAG4RVadL6BYeJyZwvF8PMTOpT58LALbMc30QKt7gzMP6l7SIV8LHvfwj2mEpN8=
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 03:26:37 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::76) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 03:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 03:26:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 22:26:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amdgpu/mes: document for the MES rs64mem funcs
Date: Thu, 16 Jul 2026 11:26:23 +0800
Message-ID: <20260716032623.585521-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8645fb-1e6a-4e3c-2249-08dee2ea0ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2ES+jSuoHlNK3ATskQ3EVl0mzq0zZbao//4OqsOZWuM4uQeHG7Dz/dea+321pI1eNJh3KLUCdZvVejJeG2ZqiJjjepXxgbs/XPUmUIK0UpGC757paoszYdKrmEo4oRogXb0RU8AWRf7bkoI8B9cAUfTuNcwoXhF13QBr6kzmBKpG/rygb6WnA/QIL2YEYRpv9pnzpTFTwldMgLeush/eUoqrlAoPBEIio+ViA2+DLgARbz6x7e1FohDbAiPjfYgDKlvmhSxvXzlLYBqvhnT1Xm1wLTmJVUFeJwZiZTazamHdUUg8eK/nlTxl9y5G4ilZnE6Og6pMIvB+eKF0EY5sSConk+eUZ+gvJd4jg056AiGrUzDCthC6Sv2lO/IiPYQyBd88KhvhQfcVitN1fq6Iq1FWDbgeUj+SFhPT+FlBmgDrk/01VAGGCjQY63qGalgsGUILPdfwF0pdoJmZYOXuyMUa2tRo9EcCdcS0+xfUKtodI3C/IYww3wP31oW9fwrNuLlQExIvg9TZDnI7vm2VsAMwBW9QSO3V4SENhIpNe/fZceVmjSRx0kE90o/YidlKYMwIjBQ1qai3qinPaZFgELFWLhkOt9/sMCaNaqj/TrHYbh2hAZNJlC8kimH+qvUIr20wn/ojSco7sf9jTlpKdndrKHOQYRl9NV043pk78S/NJYEIcSAUchVnS+9MjcWqxeEwEndETMGIUBD0cYhhGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: laEM+OKZLXQQWNM9Qcng67Sf4DVbR8Z1hT40gCPp0UfuoSFjIQ330qx9+rvVDt+7oNyX+B7Xg4PPs/qgu7fLd1B1J5M0Cjjs6UvA6VkY59K3JLVq74bO8Hs4YSbtTRNpO+F2B0yPGaZDHGI48bwtJiU/IHTRAIi/7n3vmX5zXL2Owzl37E8Q6zVyeAjq35/ReAUxkbQ0ZhYQRFWwM6sSoctYFYD3LzKlxhPAJY3Zmn1LdIt/0dYuy9KjQTjMFxpELVTaKvGItUz1R+/j9lTmXsk8UvLPaMlyx+dTgAOWQ+mIJ9kcZJkTfD/xIeAFw4pB+JgtllPr3mXWfhNXAYv2Y3guyQp8a0lrf7d/xgq747S/ra10owH9/tWsENg/5a2ukgNGL14EWrRCadc9E0jUbitfv+XQEiY74abX0TBEK+I+u/HsYLzTND864Iaw9deB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 03:26:36.5062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8645fb-1e6a-4e3c-2249-08dee2ea0ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

Fix the compile warning on the document style.

Fixes: dded4c22699e ("drm/amdgpu: add mes process context alloc/free")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607151416.vo4dHmX1-lkp@intel.com/
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1e3a23c81552..33fd1f3da078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -954,6 +954,8 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)
 
 /**
  * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
+ *
+ * @mes: MES instance
  */
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
 {
@@ -1038,6 +1040,7 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
+ * @queue: user mode queue structure pointer
  *
  * Returns 0 on success, -ENOSPC if all slots are used (caller should
  * fall back to system memory path).
@@ -1066,7 +1069,10 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 
 /**
  * amdgpu_mes_free_proc_ctx_index - free a process context slot
- */
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
+*/
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
 {
@@ -1082,6 +1088,9 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 
 /**
  * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
  */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
@@ -1107,6 +1116,9 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 
 /**
  * amdgpu_mes_free_gang_ctx_index - free a gang context slot
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
  */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue)
-- 
2.34.1

