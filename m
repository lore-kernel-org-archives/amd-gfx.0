Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E01C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C010B10E53E;
	Wed, 10 May 2023 21:24:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAED10E53D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWh8MtkTgOzbIoD5QaMhMEnKD6239PUTpdgRCaqvXy6jllRgToWMnt1PiXlOz9yEl2JYLFjSlyqbRwetANnuhVp7yN9E1Wr9wZbFURYHu9HNO9CmuUOraj94MyLTMRepLNTXKxUwvLtUI61lhnW5mjmDGBovcpNLkqGcA+oLbKnrPROIkLaTuvsQb9AJKM4/JGjFBHKVpPQNgs+7YrsdgPxOTWIW8fh17a1TEhZHIQnS0Xc9MejdQJf62qEKM2cBAVM1xCjCU9kSnMGioS5YyjrMaE2ita+jaIDWHtKDi6H6DKcZVePXmiZArFvCCgWxsTz7wKS9r0JBE/7c3FjXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P4iucyYRp+RfPPWvX+vV3z38/DE2OtRSPeM0GR+nnQ=;
 b=IRKOx855I7ylx4fGUIAmYismiwKfxStoEQKBtQgdKurjoGKbj1a89+1joIdVIWUjOghUH7lzTSQ1DvAnwqXmd51mU7VyUJRO7bRjTFC6TP/ssTlPBZ1W5CfCoBhkvBOoODOFaFO/Ha3GAsVKNotrLVn05o281UYPze2TfdzFRDFS9MzNGNuKdoMySpVZG06WBj5/YsGfFr+9zFmLebMu2KSJkDe9Zwp2U1S4/RsrkUB9LMLuTwddXk+R4A7H+9m3vrO9chkJU7vgJB0wuXVzh1Sfv5FPyHduoiHkcMcr9uZnEAneYK0dKsv0HabJ73pNbcm2iC0ku4Y8C4RBYgX7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P4iucyYRp+RfPPWvX+vV3z38/DE2OtRSPeM0GR+nnQ=;
 b=2vfOLKVHzt1mx4l6qFrOo6eRHMNSOYv8Ma+jsYgGqDaaDyZaAavWx/EdSkWY7WieheAHXXCThuDRUbP/1fF2rDMoNiy+R2bjHBVR+Pdo2Zra9Hvs6fu76N1d6ikc9D1XiuwyLZ8vzUTkNQ7+zDVSIKxBJfrPTQ5Tbq31CSPsTJs=
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Wed, 10 May 2023 21:24:01 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::9a) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/29] drm/amdgpu: dGPU mode set VRAM range lpfn as exclusive
Date: Wed, 10 May 2023 17:23:24 -0400
Message-ID: <20230510212333.2071373-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceb8d03-950f-4fff-65e1-08db519cdf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbQmvX47jczrOEr2Xom14yHiqcFsjPyjBbIEI2SjYg55KgeiAeczk9cMqs2zqw/Qb3D0bo4jOyrMutrhN7N9iWAZraoO5VX12QN7nhMzcEQ5EMwrp+9rKOl7Z8a0jnuSWI2FbC5IN8XTm5WHa369Feui5lC7xEWYYrezt/K8656Og5E4HqdXcHBx/0xmuA5xGwT3wTi2kmMgrsXxcCkryJmzJtpdO59jbtWAS3jiMVmbgR5F7J+vCtvUSPLaVBmhLCf/o1ebH2uqVnHEkTP0NvZXO/25OgFpvSiSnJwB54aLCfvelvtB4wgvsoIfhbU0MCKmBLqxXSP0SvcFTLjnG1aAKNN/EoNsufJ3ZUy1mEkTnHA/yM3zcDcz6UlNLU1+h+ApMJLx+/O1+aHIqfMoH4dTr2oS7FaWBAbxkmTJBfrseqeDgZ8AgUVgqxdNNaaXG6V3cw1QXxyg9013lAQdqabglLyGCqAsrlGxtzsBJvApAPySz0frWB95swqXuZeU6DukeEt3YGLVAbMQ+f10qHLGZzDIY5f77tEn4H25/qRoIQhrUgW/coTl/Eo90SJO7ePRzgniaSlpKgzQFO3YoOlDBGNaiuYNs8SAnyolonCvfYfn+VbCydfD6G8MwQX6hS21pXwgh7jCUJ1sZAbNirbNde1CQYX59yOjCZ40uMl07j6kZuKpeGpQ4juAeWneDkCVaqeTMyQMM0rBbIcEksQIAL8FM2S+J1JFm1L/VsPtWrVDJ+/LvTYIkra1OlOcBjyYf2i0ZwszvvFnqKQSwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(6916009)(478600001)(8936002)(41300700001)(316002)(54906003)(4326008)(70586007)(70206006)(6666004)(36860700001)(8676002)(7696005)(5660300002)(186003)(86362001)(2906002)(1076003)(26005)(16526019)(40460700003)(336012)(426003)(82740400003)(36756003)(356005)(81166007)(40480700001)(82310400005)(2616005)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:00.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceb8d03-950f-4fff-65e1-08db519cdf81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

TTM place lpfn is exclusive used as end (start + size) in drm and buddy
allocator, adev->gmc memory partition range lpfn is inclusive (start +
size - 1), should plus 1 to set TTM place lpfn.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cfa14b56c419..3002d431ce3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -134,7 +134,11 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		if (adev->gmc.mem_partitions && abo->mem_id >= 0) {
 			places[c].fpfn = adev->gmc.mem_partitions[abo->mem_id].range.fpfn;
-			places[c].lpfn = adev->gmc.mem_partitions[abo->mem_id].range.lpfn;
+			/*
+			 * memory partition range lpfn is inclusive start + size - 1
+			 * TTM place lpfn is exclusive start + size
+			 */
+			places[c].lpfn = adev->gmc.mem_partitions[abo->mem_id].range.lpfn + 1;
 		} else {
 			places[c].fpfn = 0;
 			places[c].lpfn = 0;
-- 
2.40.1

