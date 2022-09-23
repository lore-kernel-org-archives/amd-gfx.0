Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E43BC6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 13:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39CE10E56B;
	Fri, 23 Sep 2022 13:17:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE99B10E53F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 13:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUoRGbSa6E+5O4necsibEdHd4dg5+jWO4PMySEXIYm+y1cUjWDuACy4rws0f85CZof16YLMdHVr772Z/j347NbcTF31Tw0tAid1deYG+Yl8Lyts8ja9acZv7rZ7r7E4qDB1JIdzOkfSGBl0AI7ut8kPEbsxAy5iBbcBb6r8x580susr2psuxuptcg+7wR08JYTGAT/Sm4juPLlWcB6Vj/VhGP6KcIe3ebY0dFnuOpwVA9sqAM1+yXtgW0qGc6nX63hxuZRjIIyeJrCJiCMdwJ0wocZ5g3ufLczOpqHF86Og4KN1OHzw1qxL7LdwL8wGoLPTt3JhG+HPnBLzij9U3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YQ7g1Du1Wpa7iD8+LL4KsQY4VvkBJ+7HUVI489XnpY=;
 b=Cod4948AaGDld2LJfYBasGu28GLzGGoKJu7sXfkLwRwheC+AMst+QZSKaMp4tmji1bf31MmrlwuiThZFLItCjp3/L/4lwyuRLpkV6wbVmrDyUM6cxB/Z48T5f5+/0tCUUzbXwrc/KmSpGFuzjeqxFCs019EmBRjnbQwPfvmiHSxEKsNUzfvKbYxokAX7Z5Vop1jip4CeS/5Cm9+st4cRu8NLSErU65jDkx7VEQxO7UEaSeubuJG8UsRx61LJy1aQ9I6YSid/JJfnzzI9H50h4lAcbPW3BYkrQQoomkTNfxITHgEtWJDjmKqdBR2ysEU6ZNVOiMllRAybbXJseQznHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YQ7g1Du1Wpa7iD8+LL4KsQY4VvkBJ+7HUVI489XnpY=;
 b=Oo8hP/ECg15PBL0grL3cD4/oIKDFdHDe3ZLS1eujLzuPQg/8PKps3EIxu5Sq4/eYnxuAzyNzl2y0VexmrwKSjTHqWqNnIsEj6y+LewQgZifXJzJHWf9A9YT/92a2mKO2+HCB1b0p7CXiVdZG7Y7zqrTV6QyyhL8cTaEV51MW9Cs=
Received: from BN1PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:e0::22)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:16:49 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::25) by BN1PR10CA0017.outlook.office365.com
 (2603:10b6:408:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 13:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 13:16:48 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 23 Sep 2022 08:16:46 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9 (v6)
Date: Fri, 23 Sep 2022 21:16:28 +0800
Message-ID: <20220923131630.1260501-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923131630.1260501-1-jiadong.zhu@amd.com>
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0d59e5-630b-4bff-165b-08da9d65df33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCQYOcTxsU/MX2QIwIYG+IKqHRNOjjmq4i86OgoLdZM1ZZFl6VXf8qHC41M3mvGnaM6Jn3gxwAj4QdlV5k8iXSo2q4z1uN+tuxZQ4CykOt23T7j/ICuM7h6ciOFA5T7/06AI1OSQQRkvFKmpnRxgnZPmrXUTgurXYVmANl2eTJKHuZar7XNABmN5TcWx60jsE2h4+Cgi6NiFyHFu3uJAAMs2jEDKJDZznwnRZtGSvLJnpppTReePvIK7plJIq4JnwNvXN67AvAa7wH4QOVD2hSjoQJP/K7uNo3xBc8zR7SIeRRo9PH7CJ5o8UCMgY2yJdfg5/UWoo+/NFrcvxP3yE7XQLOG4jC4w+gjdxnr1Sssw4XwydKXUhdBas0JO0KWniiR1V6SU3B3ejiOxjQUIgHGNTsWOntlFHHtGNFL8sBG75NV08Ok4vx9KOd6g0ugN4StHtAdPAFV6Mry/pJwq/F6CpD9LcOwlJ9ZaVRp2pQZQvfzpz8gkPWvENJTAaybZOthULumfkndxVGnmVhSVx3bDGoX66s+uXhrnQRlATKACzUQnp2INPu+/KAagvQ1A4u0GsJCMyogNKQdVSq5fCO9+qfVEUi6KbtCsLx+BOFFxI3PD9wKoulBU9AIF61NyzhDVXK3umhbKXrsp2NxlxwWogw4qGTjPu54H2Yt5ATTgmoezA3z0wMRNplAGYHgOV0AVDspBN7ramA+Tpgw6iXtJLDTMdiah3aW6vXg24n1iRfP98D/ncmhxSTrC6uzYcCvgZOn+Wv1V0bid/RzOHRFEYWZVB02YIbLf9yNbGwU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(36756003)(6666004)(7696005)(82310400005)(26005)(186003)(83380400001)(426003)(16526019)(336012)(47076005)(40480700001)(36860700001)(82740400003)(1076003)(2876002)(86362001)(40460700003)(356005)(81166007)(8676002)(2906002)(8936002)(4326008)(5660300002)(70206006)(70586007)(54906003)(6916009)(478600001)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:16:48.7490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0d59e5-630b-4bff-165b-08da9d65df33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Luben Tuikov <Luben.Tuikov@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 108 ++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 1 deletion(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5349ca4d19e3..e688665cd1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -47,6 +47,7 @@
 
 #include "amdgpu_ras.h"
 
+#include "amdgpu_sw_ring.h"
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
@@ -2363,6 +2369,42 @@ static int gfx_v9_0_sw_init(void *handle)
 			return r;
 	}
 
+	/* set up the software rings */
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
+		ring = &adev->gfx.sw_gfx_ring[i];
+		ring->ring_obj = NULL;
+		if (!i)
+			sprintf(ring->name, "gfx_sw");
+		else
+			sprintf(ring->name, "gfx_sw_%d", i);
+		ring->use_doorbell = true;
+		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
+		ring->is_sw_ring = true;
+		hw_prio = (i == 1) ? AMDGPU_RING_PRIO_2 :
+			AMDGPU_RING_PRIO_DEFAULT;
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
@@ -2413,6 +2455,10 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+		amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
+	amdgpu_ring_mux_fini(&adev->gfx.muxer);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -5877,7 +5923,9 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
 
 	switch (me_id) {
 	case 0:
-		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+		/* Fence signals are handled on the software rings*/
+		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
+			amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
 		break;
 	case 1:
 	case 2:
@@ -6882,6 +6930,61 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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
@@ -6959,6 +7062,9 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
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

