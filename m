Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812B8C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488C310EB53;
	Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2255388CBF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htzBxzGFXZwWNQNt7jBCSFfkCD+58+HWfsiaeyBVsrpph29jQamyx6Wc8dGV7i9us/ewJNy01FidJ125TWUki4BK9yg0maQud3GnC+tSkesjnST4WORm05WNNgdvFjZWc2o+yAsXB6GR02Yufa+FIoGZVp+MUrp55KZi91Mg4qEZdUuuGT1yMnAOGCxkgL1uCEbSTEqJyJf4lUfYmv/MQGYm8ED/DXKyPSq4/bDgznPMBP+/r/lCGNvzDm++1CqI6VgkG9A0WSm+JD0boJpUOKF5osWxY9sP2jWAXtMFBAHMw/+lrBNdl8Tby2y+J+XFq/nkXN2Rb9J9dKnRN3XLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI2AGH6j85mhlAHvHibGR06UQaRM0IdrSi8LtG5FL9Q=;
 b=IQaKiDVjdPQSGyHsR88FIormwXpWpq2EyPK5uEvON4s2s83L5KYx6VAXfPEOty3RKAOW4VZFoDK6QZ0Y0STQRBd+DgOtfRZmfOcvE2HQWppPulpqXLG56bCZXSNO3aOwsO81mwVIbMiQ86hN+1Gr3iCb3QpQHgf9rS96mxdiXVCELf1McLB1CLHuwH3Kc2qRTwPWF4zE8q1R9zpgvELP0JePJMqW786vc3650NK2O8iTEce/nA/b9UjjTeim1+gg9vRlcRLBSZobBQmHJhkkQ+4CY04NBtSMnEhis27XbGY2HBD8gtckVL9FlLfiCTr/wpHG7qw1Fbco3rrroPatNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI2AGH6j85mhlAHvHibGR06UQaRM0IdrSi8LtG5FL9Q=;
 b=lqapLb+oPso4f67MRh1GA9xnfTmIWTJrr8IbBckLml0E2Fc8aGMuFGY5jjMdXtVTLN2GA4f9F5oVJCYdm45ap7exlw0toL5OWr3JETQ4mKpyw2KxhjWS5519faeSx7bBksNWp81/VN/DWK5fvYbmSbecRw2i+yc6xrh9avBuDOA=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 21:40:51 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::dc) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amdgpu: add gfx shadow CS IOCTL support
Date: Thu, 23 Mar 2023 17:40:25 -0400
Message-ID: <20230323214034.1169310-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: f80f43d0-c4e4-4643-5218-08db2be745d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XpscHZtITCcKTNkq3AIXI+fN6i7SwaqiID8fo6r5C0oGKSD4RA4yYJP7JfAbU2HCBsx55MNNuq4+k6qLvJbEzhaP4sSWs8FBbEjQJL+8iKOiMcMFUulxDBK1fj7EOeEBtdLeaOD4RupDjCIrZTvNG4L4Mr0Qcicw2fnbNsg/hQivhp32WFuQGyWKuAOOrfTieeWIbfIiSC3G51IgJtDFYpPpWmharA2il/08O+5JkpmwbDQVMiC6l2zIe/3uVFOlmFxYIPTBK+vY8iCLnVY4aKdbb1GONiS/LA1XyWxJwxnPcdW3/xb4F9tDF2XZl6f93YpSbHUJlBgIh0ZCknLkj6chYzkPdRK/KdyVqcjNY45C94bwT8XDPcXSiGeqsMjdM8eLZuCsQ2ZqK4g98NC7aeNiwquy2nBiiRcDDu9y1n8x3LuMb7uzmXkqW4FHRWarS4bcz2Tvb/SzogtqfREEmsWz8cS9HaIYA/25YrQuTF2FrTqVvn9DKIcT2FSgBAXzvoNkLTZIqFc61UjvJwzVyGA0uGSYw+fb1jm1UTZ/1k3TocQ/T3UZCBnfNJVbCaVJYYY5+t9ShGVFc8o1aiR4D8qmIFQttMZ9jcX8iLDd8+38DeRVPpk3vBLcBd3aJvI5DPmNh5ydH+36VOS2mkuorBXLI7tKObYyFnFUWhQ4yfYOr0q5pclE2uVB4QGJpbbGSSJSEMdFkf9+0HyPe+2HiCMYsZQjhitPx4V0hHzJx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(6916009)(5660300002)(70586007)(8676002)(4326008)(1076003)(70206006)(54906003)(81166007)(41300700001)(82740400003)(316002)(8936002)(6666004)(426003)(47076005)(26005)(16526019)(66574015)(2616005)(186003)(478600001)(83380400001)(336012)(7696005)(86362001)(82310400005)(36756003)(40480700001)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:51.1258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80f43d0-c4e4-4643-5218-08db2be745d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Add support for submitting the shadow update packet
when submitting an IB.  Needed for MCBP on GFX11.

v2: update API for CSA (Alex)
v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
    Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
    amdgpu_cs_pass1()
    Only initialize shadow on first use
    (Alex)
v4: Pass parameters rather than job to new ring callback (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 17 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 47763ac0d14a..41bd3a1a1989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -281,6 +281,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
+		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
 			break;
 
 		default:
@@ -583,6 +584,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
+static int amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
+			       struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
+	int i;
+
+	if (shadow->flags & ~AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW)
+		return -EINVAL;
+
+	for (i = 0; i < p->gang_size; ++i) {
+		p->jobs[i]->shadow_va = shadow->shadow_va;
+		p->jobs[i]->csa_va = shadow->csa_va;
+		p->jobs[i]->gds_va = shadow->gds_va;
+		p->jobs[i]->init_shadow =
+			shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW;
+	}
+
+	return 0;
+}
+
 static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 {
 	unsigned int ce_preempt = 0, de_preempt = 0;
@@ -625,6 +646,11 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 			if (r)
 				return r;
 			break;
+		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
+			r = amdgpu_cs_p2_shadow(p, chunk);
+			if (r)
+				return r;
+			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bcccc348dbe2..7fb8e6691d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -136,7 +136,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned fence_flags = 0;
-	bool secure;
+	bool secure, init_shadow;
+	u64 shadow_va, csa_va, gds_va;
+	int vmid = AMDGPU_JOB_GET_VMID(job);
 
 	unsigned i;
 	int r = 0;
@@ -150,9 +152,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		vm = job->vm;
 		fence_ctx = job->base.s_fence ?
 			job->base.s_fence->scheduled.context : 0;
+		shadow_va = job->shadow_va;
+		csa_va = job->csa_va;
+		gds_va = job->gds_va;
+		init_shadow = job->init_shadow;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
+		shadow_va = 0;
+		csa_va = 0;
+		gds_va = 0;
+		init_shadow = false;
 	}
 
 	if (!ring->sched.ready && !ring->is_mes_queue) {
@@ -212,6 +222,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	}
 
 	amdgpu_ring_ib_begin(ring);
+
+	if (job && ring->funcs->emit_gfx_shadow)
+		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
+					    init_shadow, vmid);
+
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 52f2e313ea17..3f9804f956c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -67,6 +67,12 @@ struct amdgpu_job {
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
 
+	/* virtual addresses for shadow/GDS/CSA */
+	uint64_t		shadow_va;
+	uint64_t		csa_va;
+	uint64_t		gds_va;
+	bool			init_shadow;
+
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3989e755a5b4..7942cb62e52c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -212,6 +212,8 @@ struct amdgpu_ring_funcs {
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
 	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
+	void (*emit_gfx_shadow)(struct amdgpu_ring *ring, u64 shadow_va, u64 csa_va,
+				u64 gds_va, bool init_shadow, int vmid);
 	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
 			  uint32_t reg_val_offs);
 	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
@@ -307,6 +309,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
 #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
+#define amdgpu_ring_emit_gfx_shadow(r, s, c, g, i, v) (r)->funcs->emit_gfx_shadow((r), (s), (c), (g), (i), (v))
 #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
-- 
2.39.2

