Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7C3ECAAD5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 01:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F4F10E1D1;
	Fri,  9 Sep 2022 01:51:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAD710E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 01:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP6Te83gz2KHjtKGC6nwWsLMxGS0P1HgXY1m+pBE27ptXTTDaUipv529tv9v1n0Dqz55ublASvTgrVKixXGDfEawPhJqiu3Tj+D0WPEA6Wz1vQUhHSJdQj7jK1zUMuZuvgxIafEpmHBurBZ9UomNrv/x8J83/ma9qDTS0XjjOX5I7AM9PlFbrjsswzXY9KURYYB47P6CmQq9UiMHANROdduAUE59i8nAHaOwHHpOGkbvt1/7es4fkYPljQ9NffB5OOQ5H/m3uLsH4/KIOAxAy9FQ9fRGTiYtjoIaTOMGE3ltVSnEKxWJ4FizOq4stcKLH2YXtVRzN1/Rv+WTSvQMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwWH7URrQCIVC8/UZPAfT6K8z6uqvigwgtkjvKnbQkc=;
 b=U7gyVcyZSmWAWLLY2jnCl+cIjCW4k62SoGB3sOyinZkRUd8CXFoX480Jh1cmd7458Cbr63CCcgKW/habzyPfL8mIfA7l43QGSAX8YklOyL7EQ5h37iBm6Adbc/+g8In+1Q1Ndeg0Q3djColQtNMYylnHPpXWtMbDgnL6R5vKUaPTv5/EieS+R6vR0YEXiyufI44q4m+xmkMX54yy7lG6JDJTTA2RkJQECuGszhFJ4FF7q28z9kSAYAFnQCEl821uzBWXJTgNicprZqjZOQdlbUcoladTcjoIklm1fFvxNCzwOiaSUEptlLGAsHhHPmmXU1aH7w9VFwQZjPUzEX0nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwWH7URrQCIVC8/UZPAfT6K8z6uqvigwgtkjvKnbQkc=;
 b=Pky4iqO1rqafkjap0eEfGUrN3C0Gdtgh+7UgM8hmtmFZy0sJEDose6XH/sBAXMSRvVLmRKT52Q5Lfkht90wcWrHInO+zcobuuUJCDvlzE1qVyEcAHyKKdmROwPuVgS7mNKSbOCTLMznCo3HlM9NqPkvZvbyopGdo+9o2pdJde/M=
Received: from BN8PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:ac::17)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 01:51:31 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::72) by BN8PR07CA0004.outlook.office365.com
 (2603:10b6:408:ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 01:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 01:51:30 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 8 Sep 2022 20:51:28 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9(v3)
Date: Fri, 9 Sep 2022 09:50:20 +0800
Message-ID: <20220909015022.557099-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909015022.557099-1-jiadong.zhu@amd.com>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c92c3e4-e96d-420b-66f9-08da9205d133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PoVGHqDMBA3rD7IBWkr8WC26w5V8wfqtn3n7eUh00Bg9D+HzjkMFZYaJfeLF6pL9ND8ElhE1whx4r47PGDw3jY1Jj/Q9hldG38qqf0cECk9v/bNvriO7v4AOqlTTZVLgARTDaQKMtd7ZEaehufLud6J1sUa52YANBylUFuuXKLgb5Hg+DYCw02RnlQ0iglj3SWT2C3od1LJhEENv6A/DS8soKQoAfgsHaIVpm2yhqz3pNz68ed3/9yRPnrwRwqjWJpKkD95s4rH1cwkl++Njpx7qTALUOHj1q3n1MmRY9Lrha9aHjaKkRJ/3XL4jGUFTknOglPlo2gVc0Pt7z5b8t/oOjSGA4P/3YAKuQD4GrBrB+o+iMXynQNh6MRxULDIvNyuC2blr/Ga7sDq9JaBToHGPbZ19dPuursRUQv0tMTnUrWKuRoaIHmu9UzdW5R18OF74i6i5i1B0CNWhhhv3+h86OOndQNRy/BV5KvDmogUqPnINjTEQKm3sBYTXxJ5SpC2iV1177+UWpcXdx4HzB/EYzOvtn2gMDBxg/3XsnOZB/D68iZgL4O74QUaLkNSsCzeIiUmLrVeyDfuZtBA+Jxf8a9sPJ0/6abaXGgyYG6LoTvVji9pLo9v84NDVnA+NMQg6vRJtOYQcQcPNminTsFRcO3EMXSAzCHCPcnrtdDLpzKeGdqtex1inrqIq7KuIhj30pEmk3feFcX/ldGmnom7/MYqAbw/gqFUPM3t6ZAMNfoVjt9i0/RvMwmbo8HOBPVWCasy9N7OKrysj18VuwR9IDHmpV5r3erCYzOZdSur2rmKBynI5O4I1jamEJTy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(40470700004)(478600001)(81166007)(6666004)(356005)(41300700001)(7696005)(26005)(36860700001)(83380400001)(47076005)(186003)(16526019)(336012)(1076003)(2616005)(82740400003)(8936002)(426003)(70586007)(4326008)(86362001)(70206006)(40480700001)(82310400005)(36756003)(8676002)(2876002)(2906002)(40460700003)(54906003)(6916009)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 01:51:30.8020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92c3e4-e96d-420b-66f9-08da9205d133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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
Cc: Ray.Huang@amd.com, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Set ring functions with software ring callbacks
on gfx9.

The software ring could be tested by debugfs_test_ib
case.

v2: set sw_ring 2 to enable software ring by default.
v3: remove the parameter for software ring enablement.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 116 +++++++++++++++++++++--
 5 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 96d058c4cd4b..525df0b4d55f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -207,6 +207,7 @@ extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
+extern int amdgpu_sw_ring;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_mes_kiq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0de8e3cd0f1c..5eec82014f0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -348,6 +348,8 @@ struct amdgpu_gfx {
 
 	bool				is_poweron;
 
+	/*software ring*/
+	unsigned						num_sw_gfx_rings;
 	struct amdgpu_ring_mux			muxer;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 13db99d653bd..5b70a2c36d81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -33,6 +33,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
+#include "amdgpu_sw_ring.h"
 #include "atom.h"
 
 /*
@@ -121,6 +122,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 {
 	uint32_t count;
 
+	if (ring->is_sw_ring) {
+		amdgpu_sw_ring_commit(ring);
+		return;
+	}
+
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
 		(ring->wptr & ring->funcs->align_mask);
@@ -183,6 +189,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	u32 *num_sched;
 	u32 hw_ip;
 
+	if (adev->gfx.num_sw_gfx_rings > 0 && ring->is_sw_ring) {
+		return amdgpu_sw_ring_init(adev, ring, max_dw, irq_src, irq_type,
+			hw_prio, sched_score);
+	}
+
 	/* Set the hw submission limit higher for KIQ because
 	 * it's used for a number of gfx/compute tasks by both
 	 * KFD and KGD which may have outstanding fences and
@@ -343,7 +354,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
  */
 void amdgpu_ring_fini(struct amdgpu_ring *ring)
 {
-
+	if (ring->is_sw_ring) {
+		amdgpu_sw_ring_fini(ring);
+		return;
+	}
 	/* Not to finish a ring which is not initialized */
 	if (!(ring->adev) ||
 	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index fe33a683bfba..ba6d8c753f7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -38,7 +38,8 @@ struct amdgpu_vm;
 /* max number of rings */
 #define AMDGPU_MAX_RINGS		28
 #define AMDGPU_MAX_HWIP_RINGS		8
-#define AMDGPU_MAX_GFX_RINGS		2
+/*2 software ring and 1 real ring*/
+#define AMDGPU_MAX_GFX_RINGS		3
 #define AMDGPU_MAX_COMPUTE_RINGS	8
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5349ca4d19e3..774e44e1074a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -47,6 +47,7 @@
 
 #include "amdgpu_ras.h"
 
+#include "amdgpu_sw_ring.h"
 #include "gfx_v9_4.h"
 #include "gfx_v9_0.h"
 #include "gfx_v9_4_2.h"
@@ -55,7 +56,8 @@
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
 #include "asic_reg/gc/gc_9_0_default.h"
 
-#define GFX9_NUM_GFX_RINGS     1
+#define GFX9_NUM_GFX_RINGS     3
+#define GFX9_NUM_SW_GFX_RINGS  2
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
@@ -2270,6 +2272,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 static int gfx_v9_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id;
+	unsigned int hw_prio;
 	struct amdgpu_ring *ring;
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -2356,13 +2359,40 @@ static int gfx_v9_0_sw_init(void *handle)
 			sprintf(ring->name, "gfx_%d", i);
 		ring->use_doorbell = true;
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
+		ring->is_sw_ring = (adev->gfx.num_sw_gfx_rings > 1) && (i > 0);
+
+		if (adev->gfx.num_sw_gfx_rings > 1 && i == 2)
+			hw_prio = AMDGPU_RING_PRIO_2;
+		else
+			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
+		if (adev->gfx.num_sw_gfx_rings > 0 && i == 0)
+			ring->no_scheduler = true;
+
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
+
+		if (ring->is_sw_ring)
+			ring->wptr = 0;
 	}
 
+	/*init the muxer and add sw rings */
+	if (adev->gfx.num_sw_gfx_rings > 0) {
+		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0]);
+		if (r) {
+			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
+			return r;
+		}
+		for (i = 1; i < adev->gfx.num_gfx_rings; i++) {
+			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.gfx_ring[i]);
+			if (r) {
+				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
+				return r;
+			}
+		}
+	}
 	/* set up the compute queues - allocate horizontally across pipes */
 	ring_id = 0;
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
@@ -2413,6 +2443,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (adev->gfx.num_sw_gfx_rings > 0)
+		amdgpu_ring_mux_fini(&adev->gfx.muxer);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -4709,8 +4742,9 @@ static int gfx_v9_0_early_init(void *handle)
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
 	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
 		adev->gfx.num_gfx_rings = 0;
-	else
-		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
+
+	adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
+	adev->gfx.num_sw_gfx_rings = GFX9_NUM_SW_GFX_RINGS;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
@@ -5877,7 +5911,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
 
 	switch (me_id) {
 	case 0:
-		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+		if (adev->gfx.num_sw_gfx_rings > 1) {
+			for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
+				amdgpu_fence_process(&adev->gfx.gfx_ring[i]);
+		} else
+			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
 		break;
 	case 1:
 	case 2:
@@ -6882,6 +6920,62 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 };
 
+
+static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
+	.type = AMDGPU_RING_TYPE_GFX,
+	.align_mask = 0xff,
+	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
+	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
+	.vmhub = AMDGPU_GFXHUB_0,
+	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
+	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
+	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
+	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 +  /* COND_EXEC */
+		7 +  /* PIPELINE_SYNC */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
+		2 + /* VM_FLUSH */
+		8 +  /* FENCE for VM_FLUSH */
+		20 + /* GDS switch */
+		4 + /* double SWITCH_BUFFER,
+		     * the first COND_EXEC jump to the place just
+		     * prior to this double SWITCH_BUFFER
+		     */
+		5 + /* COND_EXEC */
+		7 +	 /*	HDP_flush */
+		4 +	 /*	VGT_flush */
+		14 + /*	CE_META */
+		31 + /*	DE_META */
+		3 + /* CNTX_CTRL */
+		5 + /* HDP_INVL */
+		8 + 8 + /* FENCE x2 */
+		2 + /* SWITCH_BUFFER */
+		7, /* gfx_v9_0_emit_mem_sync */
+	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
+	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
+	.emit_fence = gfx_v9_0_ring_emit_fence,
+	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
+	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
+	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
+	.test_ring = gfx_v9_0_ring_test_ring,
+	.test_ib = gfx_v9_0_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_switch_buffer = gfx_v9_ring_emit_sb,
+	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
+	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
+	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
+	.emit_wreg = gfx_v9_0_ring_emit_wreg,
+	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v9_0_ring_soft_recovery,
+	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+};
+
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.type = AMDGPU_RING_TYPE_COMPUTE,
 	.align_mask = 0xff,
@@ -6956,9 +7050,15 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
 
 	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
-
+	if (adev->gfx.num_sw_gfx_rings > 0) {
+		//first one is the real ring
+		adev->gfx.gfx_ring[0].funcs = &gfx_v9_0_ring_funcs_gfx;
+		for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
+			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
+	}
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
 }
-- 
2.25.1

