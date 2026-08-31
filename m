Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A291C624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E31910EA77;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7ENk27k";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A5F10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz4FPkUJjR5sJfNMNUE0qZd/qWKwjwPKUd8qT0gGQvtXtMfivcY/kJszkTaaHgMUwPawJFAlBBBUcgpI4TEgojJqv6mmKD+IicX3LggyfWr+Q+jTd31V4Nx+xrBklxhYoaebA8g01RCwp0SBhoU3dnevuStQPLxDn9ZwIhAhYqzmScV5D5j17y6BeiTX40lLoLjYYiydGDX8Cy09UlT3jRnC2LpPdKnm+XNYBd72d3MRapinflkeI4KeKT1h+ENNWXsHqjLmRrD0n2hPsgvqZfIAv/ieMLM3jIOpatwL15aEoKRiUdeHfyKiWB3okMaYhk1JmFwHxHyA+ruQvkeEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNevbVPbawKuOsEExJgWt0Z/EPOO+/4Jtn0SIBrshsw=;
 b=DY3u16frZk98tCA+eaNAwj0paAFhVAk0Dtx8koTE07Kjxet/fEssV23yEb2uGarus/e/k1mQqFxICK2BZSZFgKMHxK5KxUqf9qnIKT7181q5GQV6gZrJnJZlxnif/8jkRpojR4pBh5naVNrOJNvAF1UnlVrf9PzobZ9ietSb+/yultyHX3JHUrh2H2sSiByFG2bhEottofhOswOojp3X53Aco76wugPRLKbGNLvYdFiLZUE/lMwuOow4Zk0MzIf8alHa1XLqXUi+wOCCKUGLT4whbF64KBT7NoPwsZyX8XijqV2mnlTlRJbketTqMc4STKolf9oqptQ/wgDCeawFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNevbVPbawKuOsEExJgWt0Z/EPOO+/4Jtn0SIBrshsw=;
 b=S7ENk27kxG82yOxrUXhyvsWpcxqddcTu/rjM+zBYMj1eJmVnO6hPB0LuHMmPbqd6sXGEW+DXhsqkvE6m2CWyuKaapw4CQ8OtONKmD9WUxTagrdQ6aoS4PD0wZqQfBx/Q5PQsxdBK6cjAn9Esoe9TKNXzDcXaN2vW5keQ7Z3S2EI=
Received: from CH0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:610:75::32)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:10 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::46) by CH0PR04CA0117.outlook.office365.com
 (2603:10b6:610:75::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 73/95] drm/amdgpu: always use MTYPE_UC for remote memory on
 GFX 12.1
Date: Mon, 31 Aug 2026 14:27:32 -0400
Message-ID: <20260831182754.1089811-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: e2892e0d-f934-4eb5-c7c6-08df078dbfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UIhN4Z54pZmgr2whEPPKcmZymOE4ENW/PreeviU6xlSGzuxGoxpoBcR/6oSA8pNn1KtU6N3qpz10WBKgaVDqH54BnTYJeGLbCuq37cvIKaQbYgydN3VLzGrohqZ2/Gwjgj8UtO18Ioyj8xqe/0+roRMXt4S6Dci919jKW06aiZrHk7I5mN08UCfrsD62iylhIG6yeLXWSV60qMM5YWi61YJXTYzhWoLgSGGqBlQEqaJfVfCLBR9gJcE799yt6f68lK34lBcJgFgWxr9sJm0uW2PgXfR7ir4WVl9I56DIuT7LJzKsCb4zDxBxv6kTWkny6lcHof/zrfS0C9Hl0cMx1BlPPQkCQnxpO7dem2FldH1PmQ1M7h+SNpGVjjtzQDvjuEBbN/X5Kf3gHarqOjlHH0ep1TRFIYFVgynsj7HlkI+GEEUV7+uOmysVh+ZkOqeAQTGmHf6q14mcdF7t/LBfTSaH10MD9JAMIWqEK5fgN392ce6HAMnl1VUpG5SeIVa5rL29FnsUtzbj8x4D4bCcRtRltwVrkhk0I/aUQ76j3V8u4FxSn6HMAAMnZO5GOpog4q+K40zcl5ZKz+HUWdcy7OGa29L56IlVCt7Y3VV7+IjI4lGWEoOFuU2q9g81ycOLRo80F4TsWoMB205Q1vP4Rr4DDSIDYYNk7rWTEUHPK0MQ1jNowf6Dm+h8jaaHGU/Ca0C7LRMkBnOjkd1L7t2TcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A8jds6CT+HqvhlsXG+Iy8enW1XwYfH+YwQiXH2EBr820XChdLsi6rzZRI95bnl0ZySw6f8GGw1Owepb0VRbm1pFv/+JcNOZ1Gi8+OuxwpNWM7rsD12KL1O1S9aZk372WvuPIF32ukhiWqOh7X1tE0ykepKh53QC0sBgFL8aMZv5L0xc6DztDsy4i9JYnmhmR/emX9ZohqYits/zkVeojCAe6PcHzX8IgcfoHev/btsgeUQlyJahaJN/l/jy9XPURBwYhwPHfxLoPm6nFyMObuzJeh619WEINLRrNOoj7eaKD26RZvh2r//8Cg5Rnh/eCaLo02/wsotXiWQhJJBsMGy/tMShzjyGeWKZXGEk//lrroEhc9foieuT5KUtVliSDmMpXDboMLfyEOvxN7Y7XDP1xJvHYm5t+4rxfJfq0SHxaUKYaE0qrjIO91Iqp7cem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:09.9694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2892e0d-f934-4eb5-c7c6-08df078dbfd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1 remote (non-local / system) memory accesses should always
be mapped as MTYPE_UC.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 11 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 302ebf2f3ccd1..fd24d66290f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -638,20 +638,19 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		is_aid_a1 = (adev->rev_id & 0x10);
 
 		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
-		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
+		mtype_remote = MTYPE_UC;
 		if (amdgpu_mtype_local == 0) {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory and MTYPE_NC for remote memory\n");
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
 			mtype_local = MTYPE_RW;
-			mtype_remote = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 2) {
 			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		} else {
-			DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
-					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC",
-					is_aid_a1 ? "MTYPE_NC" : "MTYPE_UC");
+			DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
+					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		}
 
 		is_local = (is_vram && adev == bo_adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fb5eca38e6a93..64fb38400bd1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1348,8 +1348,8 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
-		mtype_remote = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_NC :
-				is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
+		mtype_remote = AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
 		if (is_local) /* local HBM  */ {
-- 
2.55.0

