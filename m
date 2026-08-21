Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DBAC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CF010F449;
	Fri, 21 Aug 2026 19:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYArXE+V";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E7610F449
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwT2FwAh1tRNNmwEfdHNPuw+ebfMbrUtDJu25KDtQ7Zv9PuIxhekl3iPTHQDMA9Yw/JkOfTHKd3IuRwkLR3IVAyxYbFeoq633zZJhYb5bVE9CIY7F9sl6MHESz9OxDEXRuuWoyLj7lTktaPQsRq0KWQrh4QBiVbH7wyEsEAIr9HuBkGW9dX/gdokfyPTA+7ZQW4vxcbhm4bwd7WZoY07db9yd8d+DWA2/JR1SsFSTx39o+ntzzbFXjVkiyFTKSQJjoYzjlOwnC8Cl/eb+vW5soZRjzfgplLm3VBGGgKmIr0crSVqr2Pewob+8pQEiO8NC06mCKfn5gghoW7vAUG6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99CJZCGiAZvA7LgBCWyduhacanYl3ZEplEo/0BWY7dU=;
 b=gWn5JNJ7FBezwKgGtGQcYY+kLUQdLpwjkwSAJG8McGqgWp7VUJQopHWCg2C45uIu07mu8+IPZt7FzgQx5bT1D5/ClruEZV822D4seffcziCMtL+vB8F+n+xzb3Vfsqakj0tpmLDLLNXT1Jc/L7jMNjAIWebZxWqdrNgwPgn5tPzBU5Jkm0o73EZS08q6ThCybNKRHLDcAJVETvBrl6S++1M3XRTKrJkWXbGVf6fX4RugLz6b6Q3UeIJ8OuDBY3oBjYdClZGbwyElyRbGB2k+hdXVM21lLBH69Gz7rrt2sZ87uroKA0oinLyXLmvpwEs+QjL09Blp4I+/vtHlBlCV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99CJZCGiAZvA7LgBCWyduhacanYl3ZEplEo/0BWY7dU=;
 b=kYArXE+VrXCZSjak4wk1xjIv+X9B1C7A9lcJXDkBgkGMSQ+k42P5nB94pPyAlPAfoJ/XZw9AbwttJUG+UfcemgNjeh8cequ0f7Ik89KjIhH5b3wFA2g+awa1sswDpY3Iq1K6YuZyimDVjAxYIsBB3ho88uzqBnGl/ZIEm26i65k=
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:35 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::3f) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/95] drm/amdgpu: Add UALink NPA address layout helpers
Date: Fri, 21 Aug 2026 15:33:55 -0400
Message-ID: <20260821193458.808626-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: bda7b859-38c3-4f38-506c-08deffbb5e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: FR8/cIBJ8qyFDWzH/Mo3YfeBbvPzBFuXZuzUmzUJvN/rTb7fcbOp8vcTNltgabL07/QtKin6FhGYfNIN8MIlNXjKua482dZ7BBg/NsIJ+Bzbb3uaPCM/rKLa1Ye/8XICqqXXEPjAwhtjD5E0UCsK6I7XGta7E4B0JOuqjcGtxB+VxC2+zprkrF3PNbKixEZXzE41ecsNnUCMeBK+6mq2K24ViBAJen9f9zY558pb+8aKjjrN/1HzSWBkTM7rPSnTGUM+l7j9AN5rfFTWSDjVlOCTvEhJ8YnteK3T9HnTUA5YJKASOzPWd/kSTF7sXO5QOfz/UtsWk2mnznVUJiQOztf3eaU+uYjG8p+gDXc22LkoJyTPFTu26zLxV+RgRoJRFTs9gJ6EXPACzeR2IGjRWGTFG1tLQ2/BGYeNfuhpiyw/O2DL2upLjCHcv56Ary0wjBGoM19US6nBf53P5cG+THe3Fg5CleTdn8rBOPf0aCnGsONXvhqlTrSC0cOEEdt9CRZKzz8fwyzgu/rMD35mBlQBrJcVN9wjNzKSchn6wji/ighQZoXE90ccNmf9BJosZzQaHPw9OjH+f9XDqgvLXmDVUjHHf7lYupfb5LIMclUw3DApZGZgFeAblgbvEMnvNv+Hnmm+r2CjmggCz06TIXPGDho02o/+/3T2ffjUL1HScAH631bJvaxgJuws0gfW9FuZlqZNl4OzPIn/tcZGHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rL2z00396dG5QHIOMhXL/DvNT1+biRUNxOVCLJ/dSuwJXN7M4KQcrPtLeuvRVnYioQ/OzODwRnx/Lhe1DOlJMdvsv0rgg/0KCUGuuCdtHzNtz6YyqGQJxYRZ1qpn5oEmll8Mkr5hR3Caq9p5x9sOYE8y7svtGLJPHH6Mxp53xzbqu8rdXsq2grmuDW8b59D0a4gJnMFIQKukO3mGKQfazKfXEY1kmIrBoYf/qk+qi+dlHv9F/JcY45PPmg4vQDGFMFINfwdGqNwxW3EvegA/u+7p/htmeJ8+Oud7aUykRuu3lhIbYclbz752mPiAV/I8aGIfksADSw4bBG21qNERbnDpq5hWaAh2n34mi06ov/08sy/x9Nfs/AlZGnHGrjkxHg3FXNMvwukkb4qkvSun0WEAhZ++Z2sThXnQk9+F/mRx6Bs6o5ONW4LKJWiuxjac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:33.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda7b859-38c3-4f38-506c-08deffbb5e48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

From: Philip Yang <Philip.Yang@amd.com>

Add accessors for the local accelerator ID, addressing mode, and active
peer bitmap, plus a TLB flush helper for the NPA VM. Provide per-ring
size and byte offset helpers for both source-identification and
source-alias addressing modes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 511360335ed99..44abdf5511417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1335,3 +1335,104 @@ struct amdgpu_ualink_remote {
 	struct amdgpu_ualink_peer	peer[AMDGPU_UALINK_ACCEL_MAX];
 };
 
+static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
+{
+	return adev->ualink.remote;
+}
+
+static inline u32 ualink_accel_id(struct amdgpu_device *adev)
+{
+	return adev->ualink.info->ppod.accel_id;
+}
+
+static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
+{
+	return adev->ualink.info->vpod.addr_mode;
+}
+
+/*
+ * address mode and NPA address for ring wptr, rptr, wb status, wb data
+ *
+ * source identification address mode
+ *
+ * we need to export different tail pointers for different remote GPU accel_id,
+ * hence we need to allocate a whole page for each remote GPU separately.
+ *
+ * rptr, wb data, status share the whole page with wptr.
+ *
+ *     1 page reserved NPA address for 1 active remote GPU, max 255 pages
+ *     starting address: wptr NPA address + accel_id * 4K
+ *     offset:
+ *         remote interrupt ring wptr 0
+ *         remote shootdown ring wptr 8
+ *         remote interrupt wb status 16
+ *         remote interrupt wb data   20
+ *         remote interrupt ring rptr 24
+ *         remote shootdown wb status 32
+ *         remote shootdown wb data   36
+ *         remote shootdown ring rptr 40
+ *
+ * source aliasing address mode
+ *
+ * wptr for different remote GPU can share same reserved 1 page NPA address page.
+ *
+ * to save reserved NPA address space, rptr, wb data, status for different
+ * remote GPU share same allocated 2 pages NPA address.
+ *
+ *     1 page reserved NPA address for wptr of all active remote GPUs
+ *     offset:
+ *         remote interrupt ring wptr accel_id * 16
+ *         remote shootdown ring wptr accel_id * 16 + 8
+ *
+ *     2 page allocated NPA address for rptr, writeback of all active remote GPUs
+ *     starting address: at accel_id * 32 for each remote GPU
+ *     offset:
+ *         remote interrupt wb status 0
+ *         remote interrupt wb data   4
+ *         remote interrupt ring rptr 8
+ *         remote shootdown wb status 16
+ *         remote shootdown wb data   20
+ *         remote shootdown ring rptr 24
+ */
+static inline u32 ualink_wptr_size(struct amdgpu_device *adev)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return AMDGPU_GPU_PAGE_SIZE;
+	else
+		return 0;	/* wptr uses the ring buffer for itself */
+}
+
+static inline u32 ualink_wb_size(struct amdgpu_device *adev)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 0;	/* share same page with wptr */
+	else
+		return 2 * sizeof(struct amdgpu_ualink_wb);
+}
+
+static inline u32 ualink_wptr_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 0;	/* one separate page per GPU */
+	else
+		return accel_id * 2 * sizeof(u64);	/* two pointers per GPU */
+}
+
+static inline u32 ualink_tlb_wptr_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	return ualink_wptr_offset(adev, accel_id) + sizeof(u64);
+}
+
+static inline u32 ualink_wb_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 2 * sizeof(u64);	/* after two wptr pointers */
+	else
+		return accel_id * ualink_wb_size(adev);
+}
+
+static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
+}
+
-- 
2.55.0

