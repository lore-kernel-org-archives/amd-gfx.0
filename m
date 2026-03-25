Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F3F103A9BD
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CAA10E7EE;
	Wed, 25 Mar 2026 14:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNm404jt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3F410E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/aBMa0J0GujePqrUKhMcmDHctJpwUfXttojcZKLUNsJUsvr8e4T4lwjGBKN7glOlMgX6Qtqjv9nYJ/RCZOCcUbdOWJnLarfXK+ui+MicTT69lzrETZHm27letWSZ9FTFRGmC6se8znGYKurAFfEM+a4LMh2r0sGbHo8YbJHFKKp2R28C8Ab9jsMq6PZDzEG8SBZrDTvt33M599+LteVHU30dBX63mDW7h8pUw56Swz0W+tO6pgLDyro68H8M/IERaLDhDkUMlkv7aLMZWATl7V3d7wkofSSH3iCMl0wThnfmU8hEumet0jVC1kQBv1T7P7hgNX0am4WMv3Pwyq5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftqJNxLPbozgW8X1OCmRn2BThDVaFwQWKkwgUdJRzmo=;
 b=Li/g/MkQCGb/mG0BIaQOSZ8RXzA93hdffpdwH0reaJ1qmAI7V0Fm6RF/jTn74FK57kdx4QJuDwgEJzrikB+1vPMei2ehakOfRKHZLNaznqrMTrMatdkaiDLNfV43zgMqFpYa/9K7T6Mz7H6VbG5FbK2v+uLVIy/SGhCubP67lI6qXPewOfr7QIaH6+QoCxiz0XoTrydEJdek4sLgQ44pHuJMPv91oN8q8rMWQQVBSfXRSzUvegIuxZLXk0QuS9ZUGbmKiHBoZIA0/7/PJ1d+vw+Jb4szWgYGC85TeL6PC9Ck0sDbl+1Z6RmFu4/LECe6sayLkD35Q0AnDV9Tt9N3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftqJNxLPbozgW8X1OCmRn2BThDVaFwQWKkwgUdJRzmo=;
 b=QNm404jtmApwZ72ylXXADQxUk4nWM7QTUFs7RHKnZUvbyhR0grlKa7r13RCDPZOyHXVCCQhZIECTvWmD6Nwd5sHlBbaiF9WhIy1LpjkgQnBo3MwGFw4HjCPFQv1p4py28DpbnI/bTFqJ8oYgPPHyurIrU3D8Vh+jRlWhlPXkAdM=
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 14:12:58 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::54) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: Add fw_reserved reserve-region
Date: Wed, 25 Mar 2026 19:42:22 +0530
Message-ID: <20260325141226.1173216-5-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 793cbab5-fae0-4dd4-4248-08de8a789dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: C4f0/cHRNeNzryrUj1ULL5uA7TtMlP8eL5W76YKmqTZ0J45+I3QjKxZbCOZMkbrbCcGpX2P+aHwTlxswRFSHjIiGQQHFlhhJh6S3sWSwlUZUCVkELrMby0Zq3SqKMfAYG7Yv5+kJVum61Du17qXEmLCB+spVOY+xIL8x/XXLiInrtc5dxwXLpXF4FtXVQthaVEk9C+scukOMQFRC6mUkK2rC9wvUOPqqPHfDINHLoQNAMQqvCBcgX3viNtDRM6N6KMGxQAGIaJGyqJHYg3pZrq9M5/kLW82uUtUIsS6cRJBF75gwQK7JIkK78Ffd7/4xepz59k+5wNm0dehQr1VhFsRl8MIX7QibtQQ9wi3aX6Hi2icI88WQnBGzrqcqbvsc9efx3Wj28iuXNnoPuWzAWETBbicXu/h2XIfNOqRk7BZ7Bq9IIrCmJp07ZiV5G28CHjhxZKq74w8nB37ZecIckAXWGRUWjhgXZq8DhrmNn4jz++aNz4Yk6OQD7JriE4fnNGi1VKV0uQx3s1n9NyJTXTwQ6f61DQ8gd/IPEsVsDMbv+hW6Jd7qhuHZijHw16bbHFgLK1k5YxqfpnHTfnxZKEXfZeRlKopvzURJ/wXaOgVrD3kqWG7D7c8uYKcd/oABx8RvCRmRlJGUm6LlxvDAppqguCQ/yjJ3avvF2tM+f4TGByk369AreEmP6HxGUY0zTKfvgPya2LS2Vtsxiro/Id2IDBVG1N4Z4PEN3fhqKC2VaqZZS9CsTrdz/ysGqcOUEJRB9Z2RxU08KEsxefyxcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: geOv4EdZuaT94AuL4zXMECsDl63o+kifrw9b+JX1SJjpLv/uwz+teaSxuLQP8q59R+/P9JU4z6qtLaLNkRuXuyczN4Su5k86n3gjaDTRDK5wM0309RXdFHmOV4BV/TlcfiHJiIf9qtjanYd7l8mrylnTLvJadIzwqa5l4CU6yanw2/UFjTsvkC0qxwRwv+/Up7WtiC9Sy5ry1wVKfOnwmDOMx+xpgNoIc4k5LfLXQjDJyiuAGT6nFQMndmpYkqUJazgMtvisSXkFdAzIUQvyCNzaIil7u3ktZv5eWvuCi3TxBbspBVpVnHpQL0zmeC8ps1eXd/TJWXkwwKmIKU1F49izJnHjgeJzhW0wLwF+I0B2SacprqsUBEU8XvWz2Y5P4AFY8Aw3bum0fhPKOV7EiqcklRwaPlnzRVxqCysf7a/fi/HdRo/8RuRzZGz7L/rY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:57.9078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793cbab5-fae0-4dd4-4248-08de8a789dc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Use reserve region helpers for initializing/reserving fw_reserved region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  1 -
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b35180ace35..1da1c409762b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1076,14 +1076,15 @@ int psp_update_fw_reservation(struct psp_context *psp)
 		return 0;
 	}
 
-	amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL, NULL);
+	amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW);
 
 	reserv_size = roundup(reserv_size, SZ_1M);
 
-	ret = amdgpu_bo_create_kernel_at(adev, reserv_addr, reserv_size, &adev->mman.fw_reserved_memory, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
+				  reserv_addr, reserv_size, false);
+	ret = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_FW);
 	if (ret) {
 		dev_err(adev->dev, "reserve fw region failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL, NULL);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 666503534f17..c38af6d3599e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5726,7 +5726,7 @@ int amdgpu_ras_add_critical_region(struct amdgpu_device *adev,
 
 static void amdgpu_ras_critical_region_init(struct amdgpu_device *adev)
 {
-	amdgpu_ras_add_critical_region(adev, adev->mman.fw_reserved_memory);
+	amdgpu_ras_add_critical_region(adev, adev->mman.resv_region[AMDGPU_RESV_FW].bo);
 }
 
 static void amdgpu_ras_critical_region_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 835f140bfed0..0d9db87d5690 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1919,13 +1919,12 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	ret = amdgpu_bo_create_kernel_at(
-		adev, adev->gmc.real_vram_size - reserve_size, reserve_size,
-		&adev->mman.fw_reserved_memory, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
+				  adev->gmc.real_vram_size - reserve_size,
+				  reserve_size, false);
+	ret = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_FW);
 	if (ret) {
 		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
-				      NULL);
 		return ret;
 	}
 
@@ -2341,8 +2340,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
-				      NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW);
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
 				      NULL);
 		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_RESERVED);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 206267e95b9b..2dd43aec5fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -102,7 +102,6 @@ struct amdgpu_mman {
 	bool			keep_stolen_vga_memory;
 
 	/* fw reserved memory */
-	struct amdgpu_bo		*fw_reserved_memory;
 	struct amdgpu_bo		*fw_reserved_memory_extend;
 
 	/* firmware VRAM reservation */
-- 
2.49.0

