Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F65DC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6024410EFB8;
	Thu, 30 Mar 2023 19:18:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1642A10E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5I5InOj7hiLhPHJ4fnm8uD7PWABfm0on0mGf3a/4S7jCKt4kLxhTJi7pwvpS2tw2c06yO9yqhIptC1BxNL532CZvjcWmJqEa727wmH/wpqe0cuFWj1LJ4ENA0KHF32VcIlTbZ5xpO+3NZhuvUiCjqMbznu+D3kxrjmUCE36kwPniaKlwTuRh2WbsPt6+3S6TkPAcq9092Tnx75095UeFsN8Nt537CejpPg1OFKngQQkqCyq3ni2IwkC25NvK520rSsohuFLNyWNbAQKqhwZ2w04sUkjJilak6NZYXEkmJQb69kljGYQwHqHqtQssUdOy+Ip70xUhTGPCIg/j9mFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KInxS7VQOBgycXS/dnACRLPxqrrCSCtQtSqFKAbRrg=;
 b=CXxDqbwAfGEgxelCQWPx1l6g1HME73t4HoFpeKzIhBeDZ03pMr5dXm5bIadRoPMG8n+hjWbfOxQfjk0PcAsof/rHqTX0xZcykg1Kq3USsbHTfn/u54Qu+oDc0Vohzb0q27Ugcxmz7VEkukhZkRDPKU5Y72AiJzOC2RbqUndoLHPRyG9rpDW7pSfKeb6kQca7vu8TUowLuyM3m57C0gPTjg6rId6HQ1pX1XYuiX/H+wSrf0gzCRhcSDv7S/X+4K2GODOcsie5Vunrxg+xIKfCF9SroualQDSkKZ4PBMLOCKWZdIS1UI5JancWFQublsWaJanE1vA9QLodYGhw355okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KInxS7VQOBgycXS/dnACRLPxqrrCSCtQtSqFKAbRrg=;
 b=sIF/MpYrSp2bNxSWsqB6FnWnUrLyXZRui4vE3D11y5lGhoDvxIFaS+09UfbOYzmdhxv9qD6jsTLtbbsyd78W8yoa5C63pm6VOcoTqdpW4o09JxtlPxdqp2iRAv9379+R1IQL1f5M3k31SJm2p10h+VZLw2hv09v8UX9u7wGZ5kw=
Received: from BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::29)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:18:05 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::4f) by BN9P223CA0024.outlook.office365.com
 (2603:10b6:408:10b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amdgpu: add gfx shadow CS IOCTL support
Date: Thu, 30 Mar 2023 15:17:41 -0400
Message-ID: <20230330191750.1134210-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 670fbd2d-900d-416f-d63a-08db31537d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuSAWVf27YnJapEsnphkGNRU18Ebvj5blb7mVvLb/1LSiD0E+YwXecegG++Vgyt6nvx4jmkC+fUervZRmEotBF4isds0R5tnt6wXz3ZjJhmtiAlT1722oGFU9B5lniatzYQK5YRjS12TD21l9V6eMujFgVcb7yEufrL8mofbycguEipZJqm+abbnV80Ii1IbSQ1UdSRqsk7uGSIcyH7yq8jSmAhtUc5tNH9sCvQFIiE/9ElUHT1NeKdnh0xR85l54RGSWQEdAk5++fTJ3QhuC8vTzfPXP0/HVyMXiCxGZDzUhu92mS7fsmJzFVX6e1xnAAj/XLf0aFFCMs28XK3XZyxl9YZ1khrbCeAg+fyIyO7XA6T12bUju1lIeuD8RLIEs31YcD6OJqjct1pm5gCdbgey7TWvWoR19Fs2DgJOeUxjIBlGA6cUIMSG54C3sddCOGZbgWBdGUOfR7rDv4v/0/W01U2npgZ00UfRDha+yZ5Z3sXHTqQoVt5kGPRY4fiXd38PiuAyeddCrqgMJuxJPDkvPwqu2JqfPiqM8X+JfJCKRHDm6sOjDpGMAFvkttoW7MmgU3zWcBohyHK5s9z2ftwSKqZrDFWntCKHAh833BAfpQIvzAhyQARZzzGxqupY01DJ2GyABH6TjkNhQ2UeDh/t1Q0CYtrLorOkEyyyfWkZRvjXEBMw+gwQAGdzY2KIIOnkTgFfSnYEBS2jDUOvQVrRy0JmNN6vs+JhrEO71RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(81166007)(1076003)(82740400003)(6666004)(26005)(336012)(2906002)(66574015)(47076005)(186003)(16526019)(426003)(40460700003)(5660300002)(8936002)(2616005)(36860700001)(8676002)(478600001)(54906003)(316002)(86362001)(41300700001)(40480700001)(7696005)(6916009)(70206006)(82310400005)(4326008)(70586007)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:05.2693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670fbd2d-900d-416f-d63a-08db31537d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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
v5: squash in change to call SET_Q_PREEMPTION_MODE/COND_EXEC
    before RELEASE_MEM to complete the UMDs use of the shadow (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +++
 4 files changed, 63 insertions(+), 1 deletion(-)

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
index bcccc348dbe2..9bee630eb0c9 100644
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
 
@@ -263,6 +278,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
+	if (ring->funcs->emit_gfx_shadow) {
+		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
+
+		if (ring->funcs->init_cond_exec) {
+			unsigned ce_offset = ~0;
+
+			ce_offset = amdgpu_ring_init_cond_exec(ring);
+			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
+				amdgpu_ring_patch_cond_exec(ring, ce_offset);
+		}
+	}
+
 	r = amdgpu_fence_emit(ring, f, job, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
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

