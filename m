Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710D606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XV9jA+rE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E641123E5;
	Thu, 22 Oct 2026 08:21:10 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861701123DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAMm1qf+49fiO4AN4Kwu7uiaqQnaQHLalB/hwoOg45QdJzSCenZ8shOHtTU5+UjCjpM7by+yGXojNpRfBI5kqDcp9JQGBXwOHfFtXRw1fvXKMQJt8SJk8pN2yK0UOxWEAlOihvdHWv0ThFtEqgtxHpS9Sa2ne5NPoj3w++09OarCuzGad+UlERwuSQg0U4xepQnP74luFRxILzUw05HxfNbYrHMY3vFWX+ddJ2mrpO87XOTnN0hpnEtc+6ATDtxYWw9rMNTZtZB+a2iZbWCy1TzbMv8qjsODsJ4B09uPXZnvvR1jrql7dlhaBRk+GKNxZjK8TxiuHXyI6E4dut2frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGGIyfEM3Sez5L9BfzXjOLzeimhPUw+yX7LZEUgm2Mw=;
 b=YXMcmvi840diQ3pcgv2WaBD1tb4As35q7YWEK1coQH7LaUzjqzTapLCjwXItMtPRWhf57pF0CLrhRiWWX0DdYl9jkt1Tt9i2LZzO/wGQ8UEciADkT/TiZGdSIpl9ubArKoU6w8pbRf4/YRT29dk3pih/11kD2FzGf1CTbfDamV4rfRTtrk2yp5D/19qF6UW3JSKiCerIYUmA3Isxi8B/NiaX7wvUJiRBHWzxaCk6lj3E/zijjnpr1nU1CrCiBQQDvzH82saGdKp9sTf0zV+FNcukFUupujLGjCivlKE9Uarit9X4V2gFVtVTglMvqGn1gwJGxB29fCQLFAwpCkulNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGGIyfEM3Sez5L9BfzXjOLzeimhPUw+yX7LZEUgm2Mw=;
 b=XV9jA+rElR4SzsRdiMoHKoHGAROkFubkB+RcOrJPOLf0Sd84fyAs5Jp1oAObDeo5EKSTZIyE4A3T847uj1j4gJID51/G8d+lm+WLYGNyIqrZSAkz0u/EsjkXL2R1qsZogz0HxlNBKvHBlgehYgO8RseU8Tj5owjrPl84BuUcnNc=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 08:20:55 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::2a) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 09/15] drm/amdgpu/gfx: add a gfx engine reset helper
Date: Thu, 22 Oct 2026 16:19:49 +0800
Message-ID: <20261022082011.331462-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: fe390c1f-a3e7-4b57-5dd8-08df301564a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|22082099003|3023799007|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9xA9EWF2FiPTtLPuCmBm0hJgbxQKB67mUwxh8ujkI6qK4KSe18r5LxuK0AoRb61fCCmwNEWSmSnHQzoRoPXJym3DUIrScg1gpZF259jBUr1u4JqSogELpcmqa619HEqtRu0n9Zg5OQFuB60wqyIjiesIy7jByNNuda2cvttE/AGr350S28i56qGHe7q0EtOzAs/+GUm2YizVu4ht5pFAOvnFET1OHSMfUbUhHMvlQ4ZCDi1S9nT37Jrzq/FVANg3JcvfcZmsGhYSgr+0t0tWf8hM8CQTTkbr/t3j9jcuQfjy34ifAAokKHMwiEPtT2LQh2dpvWkhZkEugk8TJ6WpEOuiJncEbj7Bv1hMxGjbPLWhz9UCXre0z9Vtt7yGBsE4wQbTe5uSi6klIej7LHba48q7h9e+tnC4pq25xTmBhvVqzXYkmaegA4v7gzVrKiyCGq2DVsb/PrJ3lMj7TMHfXhhroQHhxb9glfBIeYTHsMsuYCc86lSZJTLyMyTwFi0WDsmttGhcCZXyfAheXwPloGur6fi+KlenZzyd+XbeJgQ1FPhB0VoSwei/WsgqGhOYB4nXH47PW22tsL3+ZPkU+9oDFBjLPEweLO8kYAkSX8AS4uQhlRMeG4TDRgLVMuQlZKIr2TEP1CyVCaDCNxVe6Go7bq/XfeLRW1HNOFS45aUk4ShYPjHn4OjaRf4XoShJgESemzKMRnfoCyn1gB1EmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iDiDwDXkbXJoBI4Rqnh0PEcvNgt/759eXFYVt/OPie5BJ3J5WAq1PIyEgNBOSViHN4LQ/KDSrAkkuayOm/hjhse2fQYd5uC3ehREjMeFTDcqLao8SZjMhGVqSzJM9pOYtpsUTbIupbOsTOyAkS+dFpwcNgpx9btCa9yp3EY06NYEYMFS14OCg1oLQvbJHMVvdTKVQQVdMxqk9trDMnKZX/f5hIjKJtzBU66Y4MGdvgKth0kaPCvT/cJTshvz8JLYnlZI/GYzNrQZqETt2obmbib1mzyh+EqebIiD/3FvfPE/kE3NSv+qN12dfQhXL97SGIoqUpe3Jqf52CGTNbIPHmx9sh4SECpcQMUVJYrpkQdDXfpsBRefZgjAaECQwxem9bmw5PLEO69UZy+aokKQWcmwlJIWXG2O8vvEnsG/RWUjoWiX+LS1Z9dxXI3KvIDj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:55.0325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe390c1f-a3e7-4b57-5dd8-08df301564a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add amdgpu_gfx_reset_gfx_engine() around the reset_engine callback, and
AMDGPU_RESET_TYPE_PER_ENGINE for a reset of a single engine of an IP
block, eg. only the graphics engine of the GFX IP, that leaves its other
engines running. The helper only resets the engine when the IP reports
that reset type, which none does yet.

As for a pipe reset, the other kernel gfx rings are backed up, tested
and replayed, and MES is suspended across the reset, so that it doesn't
schedule the queues of the compute engine meanwhile. Their work is only
paused.

MES fetches its commands through the CP front-end though, and a hung gfx
stream can keep it from completing the suspend. Reset the engine anyway:
the reset frees the front-end.

It only takes the reset domain for read. That keeps full resets away
while the compute engine keeps working. KFD, for example, adds and
removes MES queues only after a read trylock of the reset domain, and
taking it for write would fail those calls with -EIO.

The reset also clears the HQDs of the gfx user queues. Call
amdgpu_userq_pre_engine_reset() after the MES suspend, to save the ring
state of the queues still on a HQD, and amdgpu_userq_post_engine_reset()
after the reset, before MES resumes, to restore them. @guilty_queue is
the gfx user queue that hung, if any: it is hung instead. If the engine
reset fails, amdgpu_userq_cancel_engine_reset() drops the saved ring
state for the full reset that follows.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 83 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
 3 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c32d3b0b4153..da99fa2f1b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -309,6 +309,7 @@ extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 #define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
 #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
 #define AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET (1 << 4) /* soft-resets an IP block */
+#define AMDGPU_RESET_TYPE_PER_ENGINE (1 << 5) /* resets the engine of one ring type */
 
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..fecf2c02973a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2181,6 +2181,89 @@ int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_gfx_reset_gfx_engine() - Reset the graphics engine.
+ *
+ * @adev: amdgpu device
+ * @guilty_ring: The kernel gfx ring that hung, or NULL for a user queue.
+ * @guilty_fence: The fence which didn't signal on @guilty_ring.
+ * @guilty_queue: The gfx user queue that hung, or NULL for a kernel ring.
+ *
+ * Reset only the graphics engine, when a gfx queue or pipe reset failed.
+ */
+int amdgpu_gfx_reset_gfx_engine(struct amdgpu_device *adev,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence,
+				struct amdgpu_usermode_queue *guilty_queue)
+{
+	struct amdgpu_gfx_pipe_reset_ctx ctx;
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_ENGINE) ||
+	    !adev->gfx.funcs->reset_engine)
+		return -EOPNOTSUPP;
+
+	dev_err(adev->dev, "Starting gfx engine reset\n");
+
+	/*
+	 * Keep a full GPU reset out. Only for read: KFD can still add and
+	 * remove its queues meanwhile.
+	 */
+	down_read(&adev->reset_domain->sem);
+	mutex_lock(&adev->gfx.mec.reset_mutex);
+
+	amdgpu_gfx_pipe_reset_prepare(adev, guilty_ring, U32_MAX, U32_MAX, &ctx);
+
+	/* The suspend may time out while the gfx engine hangs: reset anyway. */
+	amdgpu_mes_suspend(adev, 0);
+	amdgpu_userq_pre_engine_reset(adev, AMDGPU_HW_IP_GFX);
+	r = adev->gfx.funcs->reset_engine(adev, AMDGPU_GFX_ENGINE_GFX);
+	if (r) {
+		amdgpu_userq_cancel_engine_reset(adev, AMDGPU_HW_IP_GFX);
+		amdgpu_mes_resume(adev, 0);
+		goto exit;
+	}
+
+	amdgpu_userq_post_engine_reset(adev, AMDGPU_HW_IP_GFX, guilty_queue);
+	r = amdgpu_mes_resume(adev, 0);
+	if (r)
+		goto exit;
+
+	if (guilty_ring) {
+		r = amdgpu_ring_reset_helper_end(guilty_ring, guilty_fence);
+		if (r)
+			goto exit;
+	}
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring == guilty_ring || !amdgpu_ring_sched_ready(ring))
+			continue;
+		r = amdgpu_ring_reset_helper_end(ring, NULL);
+		if (r)
+			goto exit;
+	}
+
+	/* Restart the schedulers stopped by amdgpu_gfx_pipe_reset_prepare(). */
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring != guilty_ring && amdgpu_ring_sched_ready(ring) &&
+		    drm_sched_is_stopped(&ring->sched))
+			drm_sched_wqueue_start(&ring->sched);
+	}
+
+exit:
+	mutex_unlock(&adev->gfx.mec.reset_mutex);
+	up_read(&adev->reset_domain->sem);
+
+	if (r)
+		dev_err(adev->dev, "Failed gfx engine reset: %d\n", r);
+	else
+		dev_err(adev->dev, "Successful gfx engine reset\n");
+	return r;
+}
+
 int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5e9338563de3..007da939d135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -751,6 +751,10 @@ int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 			     struct amdgpu_fence *guilty_fence,
 			     struct amdgpu_usermode_queue *queue,
 			     unsigned int vmid, bool use_mmio);
+int amdgpu_gfx_reset_gfx_engine(struct amdgpu_device *adev,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence,
+				struct amdgpu_usermode_queue *guilty_queue);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.50.1

