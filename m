Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93096C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD8F10E972;
	Wed, 23 Sep 2026 15:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QceKQms1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562C310E972
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2QXWxXA7/B7Y6QyRwtCaSnN1NqGgZxiKFq74BTOwy7vI/PcO7LpfLNLVQa8YFTy4dFAe3mOFPLofuhhi9z8pxOHP7JXdnhXrP4ozVVWU2E2EK1zvSNHJZ/LcqA/2Nioy62Ax7u0eev6HmUuejymuivqSS5vRcoo8NyRurNCiC4/9m4XtjmiQwhfJ5EkBW3RA6kKhZm5d/ZYspCqBiMga2ldTPbN5x5zRq2DS3M0zloBxYuZnmdrsJZsUzLcG1HxOh/9F1fPv+E04ZkSaosu3pGFhjU+4sp/DsQYSfqtoDKz4H+9k4kqyZXmsiu0YZAXkTzvNKIvu2YwlUGl+4x/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjzdHv/3QolAgd36CP2unIQgxfd2wN+s5mAdtuCYoNY=;
 b=mP+1SmJzHNk2LMm8nbwDIUdTel7vyfdISu5/oBOvRD44P5yLPUJOR7VRrpp4xpWQkD09sVfFoN71V08lalWiyn6H0hPQsrEFMxh/pqQCV0oysZ3Fjf0ZL8l7GkL7CYB37B115soN1ftBvQs9rDmpLxSOUuQcFC3uoxbq10/vBltQ2HVsa8sKA9IxdK0vjpD4g2n5CkQJvpPlFPYdiUatAnPxKFjKEBi84A4t4ldyyV3FNFQaW2PdTUR2xhRrRvoFjtNx5G6xzP8+yCAlPVLqWgqJsMt2whY3TzC1jblkRBPvs4hoZ0H6imjAGsPXbs00jeShvwf8gRLVJ4GYaC7KKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjzdHv/3QolAgd36CP2unIQgxfd2wN+s5mAdtuCYoNY=;
 b=QceKQms1hRahCuRQ1cDPZ1DZAHVHFCl+XUWvaahoBI4u7MWpoNO0Ao9hUBFB15IF0td4OVh28GdDufVugKwN0huL+J2Ss6X1qS/WOY6+kr0HBNSaH10sVQwngi0v/kAKlEYTCHhYZleDoUEJek4bPzCpgnKlkveT2x7U6LkPXt8=
Received: from BL1PR13CA0249.namprd13.prod.outlook.com (2603:10b6:208:2ba::14)
 by DS3PR12MB999240.namprd12.prod.outlook.com (2603:10b6:8:38f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:51:15 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::77) by BL1PR13CA0249.outlook.office365.com
 (2603:10b6:208:2ba::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 15:51:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:51:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:51:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Allocate VPE cmdbuf from VRAM
Date: Wed, 23 Sep 2026 11:50:55 -0400
Message-ID: <20260923155056.2816021-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923155056.2816021-1-alexander.deucher@amd.com>
References: <20260923155056.2816021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|DS3PR12MB999240:EE_
X-MS-Office365-Filtering-Correlation-Id: 29827ce6-dae3-4c63-44c6-08df198a7fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uffLCb0bVTMO+9PlEjrcQbnaolIcIj6Z8h8PrfWM0Dv+slKRdE5ApUxHaeAGPst7vcpp1OoxVUKK+i5OpR8KcegPgXf2V9jaOf1u97smAT3JZ5M8xTcoyKSId54md3hGshszmxLwYPVV5CY5MNfsSGkErLYHQ0kA9vx3SvV/QetUMAVqEgnKpjEMasYwLcq0ykqjKfEGi1yjLdCq+XrUagG4AjBzcB7ATv3Rq5VU56EVuN8wa8RQhgpQNnfaYG4ViCfVet0c27Snj+g6mns1S0OASkVwYDZAhtWk1sBsRpTTEphGKM3OeZ9Oel2VhlNP62mjXA92jc2vFeJDEPEWMOPPnot4d/Mghi49YpLsK3sKK/+UTVY+VX/TN9LJq08nY+n5aYOHZsryO0JQfdGUuibiTNsu509kzcXowe0WNoF6+egC/iO+0l0sMcQE9WOY9x1elvOHwoYtvMpovJik/FsOvk4LpS+to4H3Dw66BusxckKVO7+/AKN3kDvFOAWSdYfHXGUJlnfnqlmQkxNN4MgdtaLyzOz1jAn8+4nQEuYTcDsem0UejYpoSEA7hUe4IShoUWRMcplj5PA4uOetNWfNT2diAdxaxf54OQS5w4Ga+/JdAbmDXHICLsIWxa2gDztch9+BdNvdmYxvkjNlOOW8K49ioS7r9Zna8+DuBlN1cY611uOi0QROw25PuLsjmSt6PuY00rEL28EN64KcIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQAIUfSqQboR60f4rHatI2RZlCyBQhMgl7PLeqmi7MfTZuaD0nkofccLO24/8hAKO75rhT/xF+o2muiyiHtvp4z+I7zBdcjucabJXGcz+jMMft2BuSUp+LsIcsqdTDUev1p9v3tMMhqN79Ik9hnAzajoIlAd9VDPwGvtuRebUn7w9QdRWoE9qefFakpcj/Ly990MnDXzNx6vTIXn54PfMXodpLJVSiMyIHuMmW6hbgcyT8pp5VcVs4mnVYHnUP/kz2ejjE4tGk3/aWZc3rLepx12oSkEdSRKMwXNTAJKq+f8wbiLpl4TPpK8DSyTrvJcpcstJudKuTO4hQeXIMAisaO7GPNpi+ZiQHy53xXD0yMdAenNaKMVaMVUy3NijNzFCx+Siw5Txt82KbBoxwJwz5EqgA67ibywfLQfguM6qyLnsLJEbTdfljem6CHmWPUJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:51:15.1910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29827ce6-dae3-4c63-44c6-08df198a7fed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999240
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

From: Lin Cao <lincao12@amd.com>

PSP should not accept a GART VA directly from VF
Add logical to allocate VPE cmdbuf from VRAM

Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 39bf218b6f7cd..1f1e1a4343d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -378,7 +378,7 @@ static int vpe_common_init(struct amdgpu_vpe *vpe)
 	int r;
 
 	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT,
+				    AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->vpe.cmdbuf_obj,
 				    &adev->vpe.cmdbuf_gpu_addr,
 				    (void **)&adev->vpe.cmdbuf_cpu_addr);
-- 
2.55.0

