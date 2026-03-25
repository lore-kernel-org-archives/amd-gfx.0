Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF6E106B53F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CAC10E83A;
	Wed, 25 Mar 2026 14:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HN4RSn2T";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F20A10E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhkCGkuiuLkcZhf2jlrSDNijMV9ITxJ1u9tUpSOTLtKOZGvzMczSB2jZsJ46ykcqiCMaaoUaYIwCbRSRAcoZx5g8w0LKrHHwwgK8YlvCcNP/M5GcwtHKrrOawgh0v5CvcffLuT3zbywiLsNFv9NeBcYEFEelS+l9FbOhmoicJH+Ih8YpDurObHXupDuzcsxjmbrSrTfcrLQkE0fzfgm8Izvu6z2kwsc06yC+eG5ABbAIqJOE+6FPPYYj3zI/ZUB8xE+R86fziHuoDOojLA6Eu+NOS75EwB+zmWC5KrcT5Q+zM7QU5eKjnrA8/65klqbPAZVFvr7iDsWrZltCAEhj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNmfgkW6BV9z7r+aoCFLSHVlOzPphCMmgGrGwuJlNdA=;
 b=uxHq64k0iijX8oobMuxLyhPRTWkwP/t4nqISmt5dlQzMj/wVjEK7p6EbIIyuUOKp9TLFxjyqFysqG9ICKFVHQO09O4/DlskTAXvsL1vSLemAEg8si/VVDEr2wCy8gnngzVq5rzCuulcF8IrwxnnM+DrQ5rvE5lAm9eHIMhw+kBv2W9zpNGlD33Uh77o0kN+7B/AypX89uYVxtTcJyw1COhAaqptzWiln6VizPl/HOnJZFbrrU+rXrDkXnHJNbhQC5kMTW3Groge4lRLNu+H51D1n4JfLI95+acmo3xXkTQ+9M1gKulR/lcqoI1s5AvXL3vcGDreOdEJ6CWqnKUjPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNmfgkW6BV9z7r+aoCFLSHVlOzPphCMmgGrGwuJlNdA=;
 b=HN4RSn2TTI0RL4NOUBAUtINnJmuuMjWbzIjCh93mY9TshUvZEujFzNrWSUkoqamzcTw80F6J5hXskUVjlhN28HSDTJE4IjFny8SiG78uDL8VHHNH4sXzunm8SnAhxv52LMLRtM0oVEFJbSmnSpZFRkP56E+FU82b/AQYB8krJ8s=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:12:59 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::aa) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:57 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: Add firmware extended reserve-region
Date: Wed, 25 Mar 2026 19:42:23 +0530
Message-ID: <20260325141226.1173216-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: a59b2bb6-48f9-488d-c104-08de8a789e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hORL99hoSN63z+fm3yoDrTJc0P43oZD2OI1//HXCqpIcZ6oSEIJVgz9yT0UHQA9WYenunImYyVs/TDnM4iTE/yHC0BJrTS621NHOZ12yOhEjv1Xg8RYj3hGKgZgOvaqrFHNX2UUIOc21waO+Ya8sjXPUKzMWjQsYb/LlWkQwKF40mY1XcCDJVL8NZ60iHOLdMxbFw9E4CP5iRTzWf+ILz95/PE9aimJjKY2MRuWfX50poSvHIahP5P72K2V+dn5BWBDHbcvmH+68eihftlOFjvxETfv1bYYU8b7w8Yxp1D5Xsyqmj+6hYiuBs4JA6Z8oqcMovIWVu1Nz5lMOdAvwcmlW+eOrP6ftGQGyHqM6HNR/iHzAjV4OohJBmAQt93opqDSy+fUQTX/IZKFSDGPsKfdlRvGGSo7S3WJH27ajQT6cdoPuJsvWZL4mQJDJPJKDyyuY6UkvQPqq1L4PuEW4a+p4qrUyNuHaK6iZ24WW4XhcQZf1XTsBn4xbjTQC9xkB92vPodkNvOUpMAaqEDxwCGWPaXgUQ+B35TnBsbypyOwv+UXuyWDFQ4i8ANq5djzCDLjqk5/HceMCaGjIdRmKQab20tp9W4x1cvgEND2Ki5oVUOlgUg+pFHSZ0wcVW5pFnsLbgx0fkA5VhYX8XHsyuVs8VL0rM9vmGXtIZpz6Uvuh47HoruNKdZzD5MAKXjeG2nRp7Tg2W0W05ZlXi8Tc0flzMDJFJ7vwD9rCgC5/McRh6EbWV1IIKP76wi1aAoi8BVCTxaziY2W/hJDtvccV/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U7n1k4HaL5ZcGblo2473/DSXurdnI1oSfXeK2bY1qji7Oda0AwL7bxh0jizogtvUs0POkbX80E42jqGegDYsMOEkOsHw91vidXufhb3kVMxjCmhQce0ILHgjDDpEjhJtocS3Ncrw3qgHz54dpLKpWpriSTPxzBcEa00Cx9+ejuN0zRKvbH7g2/7DpI5WO01Nxwx/ljs63ti0Zri5nwxupcP2pN8Qmkf5xQpdtMjoRAbbNBHa5cPv9Jh4v5jKcBJ/XWZUGXfbKzZSyy7rZFvnFyiSLKtgfuQphGz/5+usnzV+5RuImP6oi7QR2ALKAUthckeAt4FbcKO9t5aKQbDCW/VyBLRuKAeY/qjjb88+ut5ByCUJ2Y8o1/jjoPtGhdzabnEyByxlZ9PY9i5rXoHyElUSgSGHKobMgxh9Qg5t9fu19t0XYj+Srv2uxGz1yEMf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:59.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59b2bb6-48f9-488d-c104-08de8a789e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

Use reserve region helpers for initializing/reserving extended firmware
reservation area.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1da1c409762b..cb2b9a3cdca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1090,11 +1090,11 @@ int psp_update_fw_reservation(struct psp_context *psp)
 
 	reserv_size_ext = roundup(reserv_size_ext, SZ_1M);
 
-	ret = amdgpu_bo_create_kernel_at(adev, reserv_addr_ext, reserv_size_ext,
-					 &adev->mman.fw_reserved_memory_extend, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_EXTEND,
+				  reserv_addr_ext, reserv_size_ext, false);
+	ret = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_FW_EXTEND);
 	if (ret) {
 		dev_err(adev->dev, "reserve extend fw region failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL, NULL);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0d9db87d5690..0dde3fbfba59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2341,8 +2341,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
-				      NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW_EXTEND);
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_RESERVED);
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2dd43aec5fc0..eaa26cda5780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,9 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	/* fw reserved memory */
-	struct amdgpu_bo		*fw_reserved_memory_extend;
-
 	/* firmware VRAM reservation */
 	u64		fw_vram_usage_start_offset;
 	u64		fw_vram_usage_size;
-- 
2.49.0

