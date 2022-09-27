Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7812C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C4610E2E1;
	Tue, 27 Sep 2022 09:14:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7531B10E0C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdFfT+VGphe24nYBBa72X5MMoKiCHcOJLOrbQHs9yYIYNP0u2znJ4+IPSY+YVApZvhm/VpiFxnWVA6eLhmayTOs46qW4vUYr1f8xWIy35U2hmtA5BhILSrs7jAuIVp+aR+SCVxaeo7UGlUwPmfuvhaTxI5TSIMLzff+PNroLE1ERehr5r8zCioCIH0eq04jxUs2Xg9v7fyjw+D5TCRGu1kCOpkBNo1SV4Z9L8/kgM2YOjnG/C+miZSzLbXQf6llYqRRISolBMmVHaepy+3IOD9Gsy/W39D7nysFpWDpfNsEAY0wdtqYWvO5VHzqrepr6Pk++m4Zk9HYmUWDoseri0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKJcvy1veSL24Ay8uBAHgYHskutBH4VxnLnNlCx3a7U=;
 b=kvZrtT8JG89vDaKT5QA6bgVUaNPFEwJ6IODIK3zV8ML5NP8/aK7BEKMuujAr0uG6CXSgkErQ8q3EGejMej5mB/y/7/Y5X+0DkkgOwfPnWLIj6VTDNQolgP5oKiKSKQEdNknQjLgC664QxrPH9+VoGmvTP6HtbKQZiNLkQqRYGcCMpPl0xCXkesM1c388hH/F3qURBRUcmqEBBQLKAOpTQjOGQKsoTkPCgjyI8TUMQoI7g3tSWpv4laJkOzj8uP903mDm+2kQ87i+kGh1ihOUCgX6HAj72TLu7oQmIqw79tBcKwFDCD3N8QCGki0eq52ImfvT9OpTxAFnLNFpyH14CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKJcvy1veSL24Ay8uBAHgYHskutBH4VxnLnNlCx3a7U=;
 b=agNl9T5cR3+5fWG3fTNjgl2I//vTiQjb6SR2xiZEfZoqk9qxWv4SsUKlVuTYUg7Ush3qAZZKcfUuKyiVx7x/ZXFZQrgpTlhzPMovg9dl70EwCAUMDOfKLuOez+GMC27jLGW6Fn++Ha1bSZTdTHjxDAlrv8xdiyqlSH7oUzT7F50=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:13:43 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e4) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 09:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 09:13:42 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 27 Sep 2022 04:13:39 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9 (v7)
Date: Tue, 27 Sep 2022 17:13:09 +0800
Message-ID: <20220927091311.1784774-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927091311.1784774-1-jiadong.zhu@amd.com>
References: <20220927091311.1784774-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dce674b-b1cc-4d95-ece7-08daa06892e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVWXU/ubUR14ljMALjjZIWVd1CgUKDmQAyJ6OwlQl+T4A2h5/mgc1h+pPq2N84SUK22BSmrzLFbVVSvye827Cp8qSUy36KmrqfYhFV/BTKZTA3lMEF3eeIZp4iWNODUB5q65n7kZ1Lk8KflCnU45K4h0CGTjO4+L/UT3QkmGRB9roS4h2Hhq/LY2XcFOKYk0DW7H0aLs8Et3L/brYAQGnsr3zRy/T7oAmNH9MZz2ahUOCBvrVjkW56AEgmLMQWo5Q1970p7qMfqngkIuS3n1H17YDjozdfzx5q/J02K3Fp3g0KmzTDLYkxfsZBrszkDKbbyjS5HzNZLvLIni3vTZgyXUl3EvUpg/GBSaoaGVjff/InDBOb7T5C94HC2JwSZHOY0XkUO2fm6XYKKysxgKPgb+OzpeRVZ//wCbkItdNGOo6HNfyAtbPTfnbQtr6wtdmee8V1v5GE+pZ9ax0LWB5J18n4WAu7V+sSIQMzIllSm5QBl2NmuqZPAeXw7fHo7tKK91V70bArynXVEZVo0KV1Tx/guN0s16EuZUy31d5hGfi8kgqp+IagMdr2xGLToln3xytZifSgh8vtvQ2JL+HX5ajIT72kIeBs5vXC1tRgL1ccxZVy0T4xyF2K5jTaisMKmjhRZPgayfegfUJs4+7b7L+dhU+JYvWPd5yr/3eO38UbhN4tgy1chSgkxWnkEO1Hna3c2QYbOyG69sp1uIAttNvy77YIHrmRd1O9RaYrQ1Aqa8hhUFKcwUzxKylLsbeUt+WeTaIK34akHSsVk00a2BlWwCLb9o9M0KRVqdWvfOEO+XV74o9puJj27JMBx4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(6666004)(82310400005)(478600001)(36756003)(7696005)(2876002)(40460700003)(83380400001)(426003)(356005)(4326008)(2616005)(2906002)(47076005)(86362001)(26005)(336012)(1076003)(316002)(70206006)(36860700001)(54906003)(82740400003)(70586007)(81166007)(8676002)(186003)(16526019)(8936002)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:13:42.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dce674b-b1cc-4d95-ece7-08daa06892e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: Luben Tuikov <Luben.Tuikov@amd.com>, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Set ring functions with software ring callbacks on gfx9.

The software ring could be tested by debugfs_test_ib case.

v2: Set sw_ring 2 to enable software ring by default.
v3: Remove the parameter for software ring enablement.
v4: Use amdgpu_ring_init/fini for software rings.
v5: Update for code format. Fix conflict.
v6: Remove unnecessary checks and enable software ring on gfx9 by default.
v7: Use static array for software ring names and priorities.

Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Luben Tuikov <Luben.Tuikov@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c |  20 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 104 ++++++++++++++++++-
 5 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9996dadb39f7..4fdfc3ec134a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -348,6 +348,7 @@ struct amdgpu_gfx {
 
 	bool				is_poweron;
 
+	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 40b1277b4f0c..f08ee1ac281c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -39,6 +39,7 @@ struct amdgpu_vm;
 #define AMDGPU_MAX_RINGS		28
 #define AMDGPU_MAX_HWIP_RINGS		8
 #define AMDGPU_MAX_GFX_RINGS		2
+#define AMDGPU_MAX_SW_GFX_RINGS         2
 #define AMDGPU_MAX_COMPUTE_RINGS	8
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 43cab8a37754..2e64ffccc030 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -29,6 +29,14 @@
 
 #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
 
+static const struct ring_info {
+	unsigned int hw_pio;
+	const char *ring_name;
+} sw_ring_info[] = {
+	{ AMDGPU_RING_PRIO_DEFAULT, "gfx_low"},
+	{ AMDGPU_RING_PRIO_2, "gfx_high"},
+};
+
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 			 unsigned int entry_size)
 {
@@ -215,3 +223,15 @@ void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	WARN_ON(!ring->is_sw_ring);
 }
+
+const char *amdgpu_sw_ring_name(int idx)
+{
+	return idx < ARRAY_SIZE(sw_ring_info) ?
+		sw_ring_info[idx].ring_name : NULL;
+}
+
+unsigned int amdgpu_sw_ring_priority(int idx)
+{
+	return idx < ARRAY_SIZE(sw_ring_info) ?
+		sw_ring_info[idx].hw_pio : AMDGPU_RING_PRIO_DEFAULT;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index d91629589577..28399f4b0e5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -73,4 +73,6 @@ void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
 
+const char *amdgpu_sw_ring_name(int idx);
+unsigned int amdgpu_sw_ring_priority(int idx);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6b609f33261f..3b607c09d267 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -47,6 +47,7 @@
 
 #include "amdgpu_ras.h"
 
+#include "amdgpu_ring_mux.h"
 #include "gfx_v9_4.h"
 #include "gfx_v9_0.h"
 #include "gfx_v9_4_2.h"
@@ -56,6 +57,7 @@
 #include "asic_reg/gc/gc_9_0_default.h"
 
 #define GFX9_NUM_GFX_RINGS     1
+#define GFX9_NUM_SW_GFX_RINGS  2
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
@@ -2273,6 +2275,7 @@ static int gfx_v9_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	unsigned int hw_prio;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
@@ -2356,6 +2359,9 @@ static int gfx_v9_0_sw_init(void *handle)
 			sprintf(ring->name, "gfx_%d", i);
 		ring->use_doorbell = true;
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
+
+		/* disable scheduler on the real ring */
+		ring->no_scheduler = true;
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -2363,6 +2369,38 @@ static int gfx_v9_0_sw_init(void *handle)
 			return r;
 	}
 
+	/* set up the software rings */
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
+		ring = &adev->gfx.sw_gfx_ring[i];
+		ring->ring_obj = NULL;
+		sprintf(ring->name, amdgpu_sw_ring_name(i));
+		ring->use_doorbell = true;
+		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
+		ring->is_sw_ring = true;
+		hw_prio = amdgpu_sw_ring_priority(i);
+		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
+				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP, hw_prio,
+				     NULL);
+		if (r)
+			return r;
+		ring->wptr = 0;
+	}
+
+	/* init the muxer and add software rings */
+	r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
+				 GFX9_NUM_SW_GFX_RINGS);
+	if (r) {
+		DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
+		return r;
+	}
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
+		r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.sw_gfx_ring[i]);
+		if (r) {
+			DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
+			return r;
+		}
+	}
+
 	/* set up the compute queues - allocate horizontally across pipes */
 	ring_id = 0;
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
@@ -2413,6 +2451,10 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+		amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
+	amdgpu_ring_mux_fini(&adev->gfx.muxer);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -5877,7 +5919,9 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
 
 	switch (me_id) {
 	case 0:
-		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+		/* Fence signals are handled on the software rings*/
+		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+			amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
 		break;
 	case 1:
 	case 2:
@@ -6882,6 +6926,61 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 };
 
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
+	.insert_nop = amdgpu_sw_ring_insert_nop,
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
@@ -6959,6 +7058,9 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
 
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+		adev->gfx.sw_gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
 }
-- 
2.25.1

