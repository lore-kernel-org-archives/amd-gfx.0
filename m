Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B941C982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A821C10EDCA;
	Thu, 17 Sep 2026 11:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ln62Pxtn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30A210EDBF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5QS7Yr/6KamWTJXDFzaVPrWQNNtnOuUlNoWlSzgK82MDPM9766dijNKGWlk8hheXnvkjuNtXAT7qbgcDPTOrIRrQIMkBfkek09+1GBmD9zG5z97UmElruGtAG8Un7a56JLUOCiheRPyPIazQ6q/EN/0kcMRi95raqSg/CgK/QkQI0wJNMG0dmL1aq9s8CdierzT0UB0Y6mMcVO0dawpVplbt49CGvYTfR0kj/nQF9QnsR49olWS5Tgzr8pAlOd/t+e/mFV2+kKRTObrM+VtsxRJt/fjsaED+gAn+dWGFCSk7AefXj4h/qOrDpKO1EYPHWqtEW++y/f3tDbCUrNtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9a3ayDhwGE7KyGuLt+GCDKoQDw6IbZMS2iX/DZ4WCM=;
 b=sQX5geXGj9q21MrICvDKHE6yBp600anqw122jJq5m27CRelfcvkdIcayReQETP+T9dxK0vDwx61TjjjZE4y5YEIKjow57BMDKkJMCRRT54QSeHLubB86k0kIG4ILH5PuljqrZ853P4QIwyhwGIT6YbbQdVkLtTbT5p1a96JyGkyQe4C2qeMDFDH8oPByeNISHuDgd6Ak6Cr1T+Mzikva3kh7T4ga3lYdHU3Ti3zypFRMRlB2GOZSqHGSHVBGxS0UZvGXEZTBHUzZhdVbULhJOT305/e+HZbI3ePk0DNfAvCZX953/fV+BJVqeA9KU8fbK4lWeThvENoQFPVfuKWpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9a3ayDhwGE7KyGuLt+GCDKoQDw6IbZMS2iX/DZ4WCM=;
 b=ln62PxtnSuJAniwTK+jBSXhrIHKOupnvAmPPh7pjYI6ABModhoqXcJffqfJIq623Y2aelnVkl8HEwIv6itQidwYM6k9WH53rXKuVi2k8wKpGwkfMVYp6Gq/yFb1P9lW5tcv9nrFb+TnbOU9bzsvrZNgIyVpRWkkx6p9qMirfXls=
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 11:03:14 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::a3) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:14 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:03:11 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: use directory flags for dummy PDEs
Date: Thu, 17 Sep 2026 19:01:58 +0800
Message-ID: <20260917110158.296198-14-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a12160-d4e3-42bb-8e97-08df14ab4557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|18002099003|22082099003|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ZnFlobNyKo1hqMH/DVau1fmbF9PSXSUoYwDBUH9vR2xDk9VrcSa1xf1mZ/1R919RpC4WrIk1Xrp6SNhZ1hA/EjOHyN9uh3gwUI18XtejMKAyxyUH3odrbZk6wrbnxfI/usydxQXBnW6WN+AUyHdabGIYBG9AuxXZj2R/Swnk6dOZfu8buXv2+LZ/LpA5UB8ohVqrYGpblbX3u6lI/8cya+fwk3/T0hFFS/VszMaw9ZNlxsY6PpPiLcGOtilnAPUR6hsBfn6iLMTJ9Ymt+wQDB2Ool/2B0Gb9kP3Xo5BV4TIVGBXed+l4m4tHSJ3dAmXa+BawjGJTDyjbTDItijVa3zPZcjB8JI6i19QRkiaCtYQAxHx37Opq4FGH6Lv8ql0BB5REEIB3mY/HvRJwBVrBzDXFLMEPRtBvmH87ACguWEwEfYpcvNEfRLJOxRtCucWD/t9Wim2q43dFwxxslHsKDCE/7r5nt6w56qnlepSirkJRIIzE8XQ6Cdzj6vyBfQBSf2HxtnrbJrTvnkhSeAUHQY+6Gwdi8/CDvpBMeFjUcQuXX8pJlUqA04p4QempIfljn50RkiYUX9ulT61oDeAgWKdj9AJqdm/bkUGTljIQSFs4IQAx49CC3AbQs5T5TLHAwYFK/O5/xhBvDC+l3vjQ539nrD7TjmUrhE4FIOa5pjo9WPhxS/VgJl8YClVfa5Z/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tAckiUv35VPvYEHYni+jUOonWcIQPU202mC9qWr8jMRx7OMABu21pUKBUiLDKO4TAKGEhgz3hgTkXK0w5e4l6BbZvExb5YuOcb1N0a4ZexUy54oda4lvpIM0ft8IdXWDt9bcUjzzCzpM8eDDN7aGlZa8HKWC8tLUokNqvzyBuEmut8lBqSATOTh96u9X+kiZKxHpef1lvrZmJRY3epXYl+4gzq33QTKBmNEP3Zob/dUcIKaYHlYeKtM8yOyvnpsQJtyUy07AuHoxFerut7XDxvnm/Ts1kncUq1od8vx7qr3FKeHNBB0b+15XNGMyNEVNGySwyyxufZWnf5xKIQJlHmpSJHImL4HfczEFAi1FG6KKk8is3I8z4GVF4oYZheHQp2nmx1MzP2Diyc4XoVGue67E5fNO78EfTKiacKHgnMLfuyiViWVLI+3qRSsuah8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:14.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a12160-d4e3-42bb-8e97-08df14ab4557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

From: Yu Huang <Yu.Huang@amd.com>

amdgpu_vm_pt_leaves() can redirect a fault to the preallocated dummy
page-table hierarchy when the walk stops above the PTE level. The
entry written in this case must point to the next-level dummy PD/PT.

amdgpu_vm_pte_update_flags() treats entries above PTB as leaf mappings
and applies AMDGPU_PDE_PTE_FLAG() before the ASIC-specific conversion.
This is not appropriate for a pointer to another page table and can
produce an incorrectly encoded dummy PDE.

Build the dummy PDE address and flags with amdgpu_gmc_get_pde_for_bo()
and pass them directly to the update callback. Keep the existing PTE
flag handling for other updates, including unmaps with a NULL
destination.

Authored-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 39 ++++++++++++++++-------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 06492358d85a..0c3ecd3eb740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -950,19 +950,19 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
  * Returns:
  * 0 for success, negative error code for failure.
  */
-void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
-			 uint64_t start, uint64_t end,
-			 int64_t *dst, uint64_t flags)
+void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params, uint64_t start,
+			 uint64_t end, int64_t *dst, uint64_t flags)
 {
 	struct amdgpu_device *adev = params->adev;
 	struct amdgpu_vm_pt_cursor cursor;
 
 	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
 	while (cursor.pfn < end) {
-		uint64_t entry_end, pe_start, val;
-		unsigned int shift, mask;
+		uint64_t entry_end, pe_start, val, update_flags = flags;
+		unsigned int level, shift, mask;
 		struct amdgpu_bo *pt;
 		unsigned int nptes;
+		bool dummy_pde;
 
 		/* Walk to the leave entries */
 		if (amdgpu_vm_pt_descendant(adev, &cursor))
@@ -993,15 +993,30 @@ void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
 		 */
 		nptes = max(nptes, 1u);
 
+		level = pt == cursor.parent->bo ? cursor.level - 1 :
+						  cursor.level;
+		dummy_pde = dst && level != AMDGPU_VM_PTB;
+
 		val = dst ? dst[cursor.level] : 0;
+		if (dummy_pde)
+			amdgpu_gmc_get_pde_for_bo(
+				adev->vm_manager.dummy_pd[level + 1], level,
+				&val, &update_flags);
 		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
-					    min(nptes, 32u), val, 0, flags);
-
-		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
-					   pt == cursor.parent->bo ?
-						   cursor.level - 1 :
-						   cursor.level,
-					   pe_start, val, nptes, 0, flags);
+					    min(nptes, 32u), val, 0,
+					    update_flags);
+		if (dummy_pde)
+			params->vm->update_funcs->update(params,
+							 to_amdgpu_bo_vm(pt),
+							 pe_start, val, nptes,
+							 0, update_flags);
+		else
+			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
+						   pt == cursor.parent->bo ?
+							   cursor.level - 1 :
+							   cursor.level,
+						   pe_start, val, nptes, 0,
+						   flags);
 		amdgpu_vm_pt_next(adev, &cursor);
 	}
 }
-- 
2.53.0

