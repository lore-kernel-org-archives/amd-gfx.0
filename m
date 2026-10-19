Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA10CCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8899010E871;
	Mon, 19 Oct 2026 08:34:26 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3181D10E871
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhqF71r1xsaZ7kkHmGsQycdT6qPr1LrE8LAvrYXnmFOMrVrtaO8tFkgkXAX7R1Vz60BrjxrqjoaHx8lmK5J4FC2cutu+CLKWwMIPFxNd7NHCD3uvHkVN/nCF7ebskNjAcXPe38871yGN3ww3eRJZZFsU17AXZZ1Qr/KAN5TB3zy7fL4jLIQ4mf12YvPz5wpoDLLzmHLZyI0QrG31h7hE59rMRLNFnHgQgwPQt9wC1NAq4o+HW7vleQbdEXSXM0T245hccstcMAmwRARFhTm94HOoodECROOPNenZdAXF7HrHL2fhRIIgsJxqWKB7Cft0M7Sm8/8WjzRxfNjX2q4A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38qtC6GCXNuK78wrxXVjQ8SjnlMe4Nh7iAvPM81BbYU=;
 b=r08zeVxvgKJkzz0/FhM5Id9nyJV6etFedC8pIjnM/XIIPHx5Y27s2RtRfb6U87bZmu3zexNwKC6QhhC0pw4E6wcbzfyB/CGmYRYN8Kjdy/9jkm8/7Ajt0E8CRzAy/g5StnN7EGbMe7Ni/47eGEN6klNadPvFOKFleq/9FC86dxYS2HWRdkhrCBIZIAFpdEBwnvdpyuhabe6cTUUUYpQCdllQZqkv7QA+ky2MmcYiTxMouO3Uh5YExOhk7+lO2Lb13EtEAet9mbkq8XlO4dZUh3NEFRyB1RIpvq7d6aG1eokOSmrAKO/JwUMxU+Vm+Uu2AvMCB4SsDrJdW7KouxC2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38qtC6GCXNuK78wrxXVjQ8SjnlMe4Nh7iAvPM81BbYU=;
 b=Iuu6AFOrpCiTOEPdLHQ4CQ8WSaPVk2mjcsWzrNIlc2hmVHcq7Pb81HZigUNkKiQlU8f9cz6tcQexKcRkasaNwXbTG360dK7YlWblVUxOtaza/y7bNDF+fWMqgwpupAu1F7zpyD/iK23q4XeWjlmEKwNtkuPAmpSW5+HHWAgoVC0=
Received: from PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::24)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:16 +0000
Received: from PH1PEPF00062F29.namprd02.prod.outlook.com
 (2603:10b6:510:32d:cafe::3b) by PH7P220CA0095.outlook.office365.com
 (2603:10b6:510:32d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 08:34:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F29.mail.protection.outlook.com (10.167.243.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 07/13] drm/amdgpu/gfx: add a gfx engine reset helper
Date: Mon, 19 Oct 2026 16:33:07 +0800
Message-ID: <20261019083402.2033724-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F29:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c5ab2b-0d33-449e-510e-08df2dbbc2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|10067099003|22082099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qSA0+MfGQ/tm9CPp/wjmiqTvIuS6GnY4FE9U9zqhiFwhxhyMTB8YfbawbOhem6Zs2D3TMqFJ4Yn2UM3HPU86XrKo7ZE5+UUmYvyLp3DhvqnutUFKMe05MNFHK6KJD1rpFZo42vO0F/aKwRllQZQaHsyqchSwTw9G6+xKzsScBCdsgsBdVA5bPIOVAO/5mul/e6KQHawRoKHPGUut4sWqVhLIct5/Swh8vbL97QE4gOxy2jtj4L64r0bdIkytLSsQwuvqhvN35ZxgvEKDjcJsUzkyZ/UL73xXVIe9NAkixHP+HdLiLEaiKH/PSxl73fB9uZkcqa8F5767Eo4CmgHngMLRwjMct7LThKau2Sjr6182Qer2f/gyN3D/3TuiKp3FlU5ZL1fz05kXqWGd16eKomTdtWuane9gtZvlz6TaI5qTf1Klm0iWNswuDjw9XUW5fE+/EngNp0v64LgGLjRJyw5nZrLr+RtTlYsenKVrZVPtCzEwO8pQihzKMcdt/5xbEacR1uBcOoP4sff9Olt5tbS0ezGK7MCszPcdZFGKcvQNpOmFb3EZpWjbWdEF8ybdEOCE4GGGwYRmBB0JN82gbpXPTGthaxdXCqqwqBJrlgwSCUT6oViv0hX06tDY7xDNinZzfs2Ore0lZRVExAsaXKANfuputDMKlIgWsXULH+wTIMvY3VoTEqE6nZTibBZVoFWCcm8d8uGfSO9yfvy76w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 88JL4ys6ves3v8Mbkv6UekZVO5cx0rIeRnhb4FiO+aQn4z7zrshLzCy+R7YadzK+mZBXZGuIFEqmHZSkUIzzedPtgyIjlWTH3bQH45y2hjMaU3iCmCpSRnFcCPyNA9v7KIGi4yjYLbtNTu33iB0Auj1I+MwtiQKpcMVNQkNIyNYozagcX8jmKLi7fk6qeCCYFUyzgE42gtVDk5RGkQD+IWZ+8M3PAd96AyVcdcvDJMdYOA+1m3RTlo7khaESKRiF7/AOQD7Tnz+RqqBhnYY8Hl3xB+EEWaogHzjGp4wIUvgDydfIXjRhEefyWWvLNDFgJOMMqTsPOFKSkOSn7ArXsakflhxb6PZKKrOwVqPjBSxATiU9063fpE80h5KVcFOEnipc0u9pLWI19y9Ur2+yk0SODI1r/G+eHW7VsOOWGszKe4q+S/9DcY9ZdAGuhQNL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:15.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5ab2b-0d33-449e-510e-08df2dbbc2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F29.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

Add amdgpu_gfx_reset_gfx_engine() around the reset_engine callback, and
AMDGPU_RESET_TYPE_PER_ENGINE for a reset of a single engine of an IP
block, eg. only the graphics engine of the GFX IP, that leaves its other
engines running. The helper only resets the engine when the IP reports
that reset type, which none does yet.

As for a pipe reset, the other kernel gfx rings are backed up, tested
and replayed, and MES is suspended across the reset, so that it doesn't
schedule the queues of the compute engine meanwhile. Their work is only
paused.

MES fetches its commands through the CP front-end though. A gfx stream
stuck in the front-end, eg. on a packet that runs past the end of its
IB, can keep MES from completing the suspend. MES responds again once
the CPF/CPG reset freed the front-end, so reset the engine anyway. MES
then runs the commands it was stuck on right away, while the engine
restarts: it maps gfx queues on the HQDs the reset just cleared, which
the PFP no longer dequeues, and the kernel gfx queue and the user queues
couldn't be unmapped anymore. Once MES responds, suspend it again and
reset the engine once more, which clears those HQDs too.

It only takes the reset domain for read. That keeps full resets away
while the compute engine keeps working. KFD, for example, adds and
removes MES queues only after a read trylock of the reset domain, and
taking it for write would fail those calls with -EIO.

The reset also clears the HQDs of the gfx user queues, and MES would
resume them from there. Hold the gfx engine's userq_engine_reset_sem for
write once the schedulers of the kernel gfx rings stopped and until
before the ring tests and the replay: with enforced isolation, a job
submission preempts the user queues, which takes it for read. Call
amdgpu_userq_pre_engine_reset() for the gfx queues before the reset, and
amdgpu_userq_post_engine_reset() after it, before MES resumes. If a
queue can't be recovered, the engine reset fails and a full reset
follows; amdgpu_userq_cancel_engine_reset() drops what the reset
recorded for it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 103 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   3 +
 3 files changed, 107 insertions(+)

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
index 0ae6e990c310..5a1774491bda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2181,6 +2181,109 @@ int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_gfx_reset_gfx_engine() - Reset the graphics engine.
+ *
+ * @adev: amdgpu device
+ * @guilty_ring: The kernel gfx ring that hung, or NULL for a user queue.
+ * @guilty_fence: The fence which didn't signal on @guilty_ring.
+ *
+ * The last step of a gfx queue reset, when resetting the queue or its pipe
+ * didn't recover it: reset the whole graphics engine, and only it. MEC, MES
+ * and the compute queues keep running. The kernel gfx rings are backed up
+ * and replayed like for a pipe reset, the gfx user queues are handled by the
+ * reset_engine callback.
+ */
+int amdgpu_gfx_reset_gfx_engine(struct amdgpu_device *adev,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_gfx_pipe_reset_ctx ctx;
+	int i, r, resume_r, suspend_r;
+
+	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_ENGINE) ||
+	    !adev->gfx.funcs->reset_engine)
+		return -EOPNOTSUPP;
+
+	dev_err(adev->dev, "Starting gfx engine reset\n");
+
+	/*
+	 * Only keep full resets away: taking the reset domain for write would
+	 * fail the queue operations of the compute engine, eg. KFD adds and
+	 * removes queues only with a read trylock.
+	 */
+	down_read(&adev->reset_domain->sem);
+	mutex_lock(&adev->gfx.mec.reset_mutex);
+
+	amdgpu_gfx_pipe_reset_prepare(adev, guilty_ring, U32_MAX, U32_MAX, &ctx);
+
+	/*
+	 * The reset also clears the HQDs of the gfx user queues: keep them
+	 * from being mapped, unmapped or freed until they were handled. Only
+	 * once the schedulers stopped: with enforced isolation, a job
+	 * submission preempts the user queues, which takes the lock.
+	 */
+	down_write(&adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_GFX]);
+
+	/*
+	 * As for a pipe reset, keep MES from scheduling the queues of the
+	 * compute engine while the graphics engine is reset. MES fetches its
+	 * commands through the CP front-end though: a hung gfx stream can keep
+	 * it from completing the suspend. Reset anyway: that frees the
+	 * front-end, and MES then runs the commands it was stuck on, which
+	 * may map gfx queues while the engine restarts. The PFP can't dequeue
+	 * those anymore. Once MES is suspended again, reset once more.
+	 */
+	suspend_r = amdgpu_mes_suspend(adev, 0);
+	amdgpu_userq_pre_engine_reset(adev, AMDGPU_HW_IP_GFX);
+	r = adev->gfx.funcs->reset_engine(adev, AMDGPU_GFX_ENGINE_GFX);
+	if (suspend_r && !amdgpu_mes_suspend(adev, 0))
+		r = adev->gfx.funcs->reset_engine(adev, AMDGPU_GFX_ENGINE_GFX);
+	/* Before MES resumes the gfx user queues on the cleared HQDs. */
+	if (!r)
+		r = amdgpu_userq_post_engine_reset(adev, AMDGPU_HW_IP_GFX);
+	else
+		amdgpu_userq_cancel_engine_reset(adev, AMDGPU_HW_IP_GFX);
+	/* MES must run again before the ring tests and replay. */
+	resume_r = amdgpu_mes_resume(adev, 0);
+	if (!r)
+		r = resume_r;
+	up_write(&adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_GFX]);
+
+	if (!r && guilty_ring)
+		r = amdgpu_ring_reset_helper_end(guilty_ring, guilty_fence);
+
+	/* The kernel gfx rings were all reset: test them and replay. */
+	for (i = 0; !r && i < adev->gfx.num_gfx_rings; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.gfx_ring[i];
+
+		if (ring != guilty_ring && amdgpu_ring_sched_ready(ring))
+			r = amdgpu_ring_reset_helper_end(ring, NULL);
+	}
+
+	/*
+	 * Leave stopped schedulers to GPU recovery if any part failed. A
+	 * failed pipe reset before may have stopped some too. The caller
+	 * restarts the scheduler of the guilty ring.
+	 */
+	for (i = 0; !r && i < adev->gfx.num_gfx_rings; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.gfx_ring[i];
+
+		if (ring != guilty_ring && amdgpu_ring_sched_ready(ring) &&
+		    drm_sched_is_stopped(&ring->sched))
+			drm_sched_wqueue_start(&ring->sched);
+	}
+
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
index c9736a3c298e..1d3bf3eaa68a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -732,6 +732,9 @@ int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 			     struct amdgpu_fence *guilty_fence,
 			     struct amdgpu_usermode_queue *queue,
 			     unsigned int vmid, bool use_mmio);
+int amdgpu_gfx_reset_gfx_engine(struct amdgpu_device *adev,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.50.1

