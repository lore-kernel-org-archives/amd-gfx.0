Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF703C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 07:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9A910E03C;
	Thu, 18 May 2023 07:05:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C6110E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 07:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHlOo4gF9qcP25Yt5UMinq8kUsvtByPn/r87zNSAQTskVKyGvvzd8poVoKsd8Jejvk+186n9uHMQ5Oi93QVD2ugYVhxjGyNZqZgjAs/YAH/SEp0m5QOAXa4H6goTbUhXu0LWu49geoRNNEboWFvmP5pMMaZ2qL5Pa+1I+L4ecVBNf2v7DEpTlarP57Toiy5nzroD8A9w7k1Vrb05rhDBnmXWWMflcYlqogH6+pnhfUVRGceGubjnvp1AsmWO/NNTii7AKgFGKBybP3I99mWEpmPWSSO7KG3uFX3wtct7ugAR9Dmcw9Tw2iti7MxxNfQiOlLleJ3aOVnZ1sxvRnQjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFSd6r4TpfRTmv8WgxiY/b6WSrT1AFfdTkCo7KE/Fc0=;
 b=dcYieI0JtgBIzfAsVaN4hrWtnhHYLd+W04iEdqrIkATigKkfi2c8EfEsn1eI0NmweZeUL/GVSdHe1yj2v6pxrJtRv9AiOLp6PQ47/P0vT7Byitr92AGaGlk5ZvM6ROoe3TaZdrkLcA7nZYJG21MfQ9HuUFlr6+tBT662N+z8uZGuBMq0DgtxCGwqsYf8NTEKGhnd61VxJ1RoQBKuis2DJidCjukHv4N3+wIYiPx3d7bjaS2dcqJhV/ZVYzOtWjca7momcW7N8H/S2oBkQZlnB/mzrhzwtePUvO+PyNNPoZcknQNuvITN1IO0eca4cIuVn//Rw725kuRjfJdSiPU9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFSd6r4TpfRTmv8WgxiY/b6WSrT1AFfdTkCo7KE/Fc0=;
 b=mrRyGSUKyk6nXpDYfb3WavMh7uWom3Kqa1rES/VlbR8S8zVHgatYZ0otkZ0K+sb3d4J2es8rIz+mxwKe/geIK/CCJA01/v4gJKqZX6L6eN+47IsSFaiWruxMfhqx7opCWlYtBRfQZSCbJzpzsp2ozCWfYY62XODT0MZmF+Hn904=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 07:04:57 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::62) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 07:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 07:04:57 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 02:04:54 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: switch to unified amdgpu_ring_test_helper
Date: Thu, 18 May 2023 15:02:15 +0800
Message-ID: <20230518070215.3556653-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518070215.3556653-1-guchun.chen@amd.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 7198d71a-6811-42df-a5d7-08db576e30c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKnb/ZPWLzLf18cbMXjQ8WnLJXoOL+FK5aQGbHDJDe1a5EAgPErDa5xDT+7SU5e24Zdt55Z9tD80IWe28dmRABi/4mkAMCzpqwCCk04N9s0xwtplU3PwMgz3vU2HOALbAmeZ+MW2EpJlVkfbmqI8FW2IUpTrc2Cr3wibBJvgvQGTpG/8E/lLoYXZB7KIQZ0ha+zWNRAft2x/wvlbffJpO8UiM4wmmbVT+ZZ9G5sUA8TczQ+UwrrX+3pth3Nd/bipv+L+eA6bT6pgFP/8vcDX5FcomWVjicelIA8VtOUbxENWBihFTG5jtCNSDNdyGnscQRxnqyHM7847rQzwKLb9kLKxeJbHPLMhOFP/ELbwYGN/OUdMAIMy0GDSNK8S5azgcg/RqyQ52i6SBuSvsfiXSW2fkM+aABxSD8eFLWjME2MdoPJq+VfsOfxVd56URGVOLYYICBL+qUfWjMtGjc9rRRTPwtlZush1ka0SsfcYLjQvOZmxfC4q2lA1C/805XUT1eNsHu+Cz+vXT2/TvqyDY893s4q2HjZwkrf8L6vSwthjBEkcBoZ6LdF2vabqG/VrbPPEdIsuKeFWO6QvbGVSCsGpaeyMGJ64zmbFboARBlqFWGMqNotvO3A5d3gOEBWsUMr5eD5bdQ1YKZ/caeW6LNNE4vSY5+HXmJAry+JWmcBx4WxmMZmYYv5nKmWdx1/elJBMlPX89wPGEJpbGksAWv8+JbdiBEj9IDK24HoAGWw2HEZKmA1UgoWaJbZNuz5Tz6dsvEb5p1zeyfV/p1knAycFpXviELeFQ3/IZG2hq9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(316002)(478600001)(41300700001)(8936002)(6636002)(4326008)(8676002)(110136005)(44832011)(6666004)(70206006)(70586007)(5660300002)(7696005)(1076003)(26005)(40460700003)(82740400003)(81166007)(356005)(186003)(16526019)(2616005)(83380400001)(40480700001)(47076005)(36756003)(36860700001)(336012)(86362001)(82310400005)(426003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:04:57.7576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7198d71a-6811-42df-a5d7-08db576e30c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will simplify code.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 8 +-------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 8 ++------
 4 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f0f00466b59f..49bb6c03d606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1305,14 +1305,9 @@ static int amdgpu_mes_test_queues(struct amdgpu_ring **added_rings)
 		if (!ring)
 			continue;
 
-		r = amdgpu_ring_test_ring(ring);
-		if (r) {
-			DRM_DEV_ERROR(ring->adev->dev,
-				      "ring %s test failed (%d)\n",
-				      ring->name, r);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
 			return r;
-		} else
-			DRM_INFO("ring %s test pass\n", ring->name);
 
 		r = amdgpu_ring_test_ib(ring, 1000 * 10);
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4560476c7c31..af66e985a33a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -812,13 +812,7 @@ static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
 
 	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
 
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r) {
-		DRM_ERROR("kfq enable failed\n");
-		kiq_ring->sched.ready = false;
-	}
-
-	return r;
+	return amdgpu_ring_test_helper(kiq_ring);
 }
 
 static int mes_v10_1_queue_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3adb450eec07..b8eabb37d48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -879,12 +879,7 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 
 	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
 
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r) {
-		DRM_ERROR("kfq enable failed\n");
-		kiq_ring->sched.ready = false;
-	}
-	return r;
+	return amdgpu_ring_test_helper(kiq_ring);
 }
 
 static int mes_v11_0_queue_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 23667605c372..3f722d21b17f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -622,13 +622,9 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_2_enable(adev, true);
 		}
 
-		r = amdgpu_ring_test_ring(ring);
-		if (r) {
-			ring->sched.ready = false;
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
 			return r;
-		}
-
-		ring->sched.ready = true;
 
 		if (adev->mman.buffer_funcs_ring == ring)
 			amdgpu_ttm_set_buffer_funcs_status(adev, true);
-- 
2.25.1

