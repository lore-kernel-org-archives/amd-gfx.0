Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75647E82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8310E590;
	Wed, 27 Sep 2023 18:13:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CE510E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnXel1AuyajoewLvPZVBC6sdz3Q8xyy9b0u6E6PporsDjfucRC6d+N/VprUBV48dz5IYBU5DgZ4W1Gu9JaDx42UNkQlm83Jl1bS7QF9rG/vFc7FJLL35Kngjby2fwLEJTm/ca/FSkXjDb0a9bmTG52KHMI9eNvFNZXvyhjBufHFmUic/CMWc1GDvKVSCSuxtthXwKpuMRlp6PVDOFQlyXxYde8Tr9qZ7elwPqEdPfguWgMgiJCSgNJrcshfn60wXl19AH480btHV4vTIC1qkUBIejzg6kODsFdWr3eJGchYaZaRpTkFmsP8B9MK2YXXlhGtihRg7dWWB5YbfJf2tfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYxByxRUUtUT5G9iGUzGXW628qHaElX+vkT1TWMeLTU=;
 b=YABaCt6cIE9OLZbmSwkuDgRwQKB+oHXU5ChZX6sQ3iiLQE90wEk02bJraNym642xJialoMqKGD8CSVwR+Yl1UZTWlqB962Uj3Of5hMIm5Z6szF7rWQusHlG7FiBsbdm7rjUWIwCq4n2L+WkN+1dVf0r6NiElrScs1iF9ONlxf4kz3dcoFFcS5uJeyAQG+Q0Wf9XWabf0znulR7jw36C48j34Lf+CLxhZf6pQAaQhQlnJe/MlqW1o8IcwG/seA+M/ykadMq5Mu/xGPQGsXfi/snfTdZziNwPFUhbWhTc8Uu7oSMBgTUgW2kAGjpMbm401WcfKeMOklxWWlLA3q6337g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYxByxRUUtUT5G9iGUzGXW628qHaElX+vkT1TWMeLTU=;
 b=z8dpM3a+fASR+cVl9zy4wEH0pM+d38FpMlBlqpDSVYQ/+p+B1sNx1EfNwE8xt9X5i+terEXN55jQrGyYs0HdNr+eio+PgcbGpLnZR1SVKq6GekeQD8SJsj67GLXxHKAduvf8Yx2jJB9QDYFU+O/mjEt4weD16fykFHQosA2Iwxg=
Received: from DM6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:5:14c::28)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 18:13:05 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::32) by DM6PR11CA0051.outlook.office365.com
 (2603:10b6:5:14c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:13:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:13:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular placement
 for GART
Date: Wed, 27 Sep 2023 14:12:50 -0400
Message-ID: <20230927181251.2364633-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b9d9bc-64d9-4f1e-e8f4-08dbbf856566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYm3tGVmqb/cx05rlzNpJKSb0274+vL4woVwhHdVXRA+o0XnTP4q0fMsqGfUENveKGcIMtggS6Ir7vi0cZi9SgyLHanfipyGCRZIyoDv9A0DpBpHzhm+MqoU/fp4ARSYKTjp4Ds3QF+iQaI7M+rgSstvo+UTwx//U8NQpuDCa8lir/+7L7AjpnlmFL3UfRciQTI/oHRQmT4RqKRPxiM+DxGMGdhojjxtGZ0Eoy/RBQ+6FXUcmVTYkPpV7/OEVE67qex1s8ygNnS/khEc34DNcMGaMp0alff1jY0DdY4nFkCNr28hOom3/39UgtzSPmZ9ObrdeC5mcZMmXG4pKPy5B4m2O1ZZ/u9CLVGqx+cFXSTBrlwmVJvh3YDeeRSpPSi5OkSGzbjYUG3xPgZBz4H2EmgSzaGA/p6NUWi9Y3ytvMRbrTX3q7S7anwqfjNs0+SFSEiQ6eYa2BNfF5CM2+7vuOkmDKp/CNw8FOPpbOSN9elL3Ve1hMWbh6IxGUkaqF+jJbiUv5xjABBdovBZDz4SUjO0bSxVp6B1VbGQPBDXxVwu6q72JH91Qyvo+J2aYPJd/RENwRI5i6p+Ex18Gr3c/UWjMkoPgH+z+Q3uPryNyJCigSQcYZfQNc/JHgCfSP+yA5/UGrFyFwz1yM8eps5MapXkno/THeYD4qn9TmFuyrSixJ5rJcl6Vh1VEeXFxLA5Sdlc4KT6R780zWdeuOFXJcjDp/g+f/LdZMF+BqKgNyB677PAUwJ9JILdBWDovRZOxPQbvZrH28dOf03tsndtbxpKTy7kBZUHnJt0eW9mBUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(316002)(478600001)(2906002)(5660300002)(4326008)(8936002)(8676002)(70586007)(70206006)(6666004)(7696005)(1076003)(2616005)(16526019)(26005)(40460700003)(6916009)(41300700001)(426003)(83380400001)(36860700001)(47076005)(356005)(36756003)(86362001)(40480700001)(82740400003)(336012)(81166007)(43043002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:13:05.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b9d9bc-64d9-4f1e-e8f4-08dbbf856566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We normally place GART based on the location of VRAM and the
available address space around that, but provide an option
to force a particular location for hardware that needs it.

v2: Switch to passing the placement via parameter

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
 8 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2bfeaacd050c..60c81c3d29d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -269,7 +269,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
  * If GART size is bigger than space left then we ajust GART size.
  * Thus function will never fails.
  */
-void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
+void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
+			      enum amdgpu_gart_placement gart_placement)
 {
 	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
@@ -287,11 +288,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 		mc->gart_size = max(size_bf, size_af);
 	}
 
-	if ((size_bf >= mc->gart_size && size_bf < size_af) ||
-	    (size_af < mc->gart_size))
-		mc->gart_start = 0;
-	else
+	switch (gart_placement) {
+	case AMDGPU_GART_PLACEMENT_HIGH:
 		mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	case AMDGPU_GART_PLACEMENT_LOW:
+		mc->gart_start = 0;
+		break;
+	case AMDGPU_GART_PLACEMENT_BEST_FIT:
+	default:
+		if ((size_bf >= mc->gart_size && size_bf < size_af) ||
+		    (size_af < mc->gart_size))
+			mc->gart_start = 0;
+		else
+			mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	}
 
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f593259a66c3..e699d1ca8deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
 
 #define INVALID_PFN    -1
 
+enum amdgpu_gart_placement {
+	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
+	AMDGPU_GART_PLACEMENT_HIGH,
+	AMDGPU_GART_PLACEMENT_LOW,
+};
+
 struct amdgpu_gmc {
 	/* FB's physical address in MMIO space (for CPU to
 	 * map FB). This is different compared to the agp/
@@ -391,7 +397,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      u64 base);
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
-			      struct amdgpu_gmc *mc);
+			      struct amdgpu_gmc *mc,
+			      enum amdgpu_gart_placement gart_placement);
 void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 70370b412d24..8e6e36279389 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -670,7 +670,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
-	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_gmc_agp_location(adev, mc);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d0a9ee2f12d3..d611d2efce3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -634,7 +634,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	base = adev->mmhub.funcs->get_fb_location(adev);
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
-	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 	if (!amdgpu_sriov_vf(adev) ||
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
 		amdgpu_gmc_agp_location(adev, mc);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 3f31f268e0eb..7f66954fd302 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -212,7 +212,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 	base <<= 24;
 
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a72dc21cf6fc..3869cefab7bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -240,7 +240,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 	base <<= 24;
 
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8ce77d074d17..4126172feb7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -414,7 +414,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
 	base <<= 24;
 
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6b15677c0314..37e96d9d30a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1611,7 +1611,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
-		amdgpu_gmc_gart_location(adev, mc);
+		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
-- 
2.41.0

