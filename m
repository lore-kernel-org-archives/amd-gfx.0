Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415EDC6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA0C10E10E;
	Fri, 17 Mar 2023 17:18:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B2E10E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hsy3dyoPC00Y8i1YTirVbaiUB7iMoZq97dRDYV7bSuT0gf2VxeYaiLtetcwCEt+jv4N+0nAuiC4NnKrlJGgHiDL94rpnNSlk8X2DIneM5GHKIG/FdtQiqsBIomMmkOcdSU8+hsyypWvCOJyrQl4nNtkgKW5tWiaSC6maqZ1qmQfqdhi++CDH9eme0Ksa0Nh4nTkAoYNIY2cQSiVtH4qX8vfztw1OrDqtlGc3NxkckJECkUiOFGPyWqvOnXzHtFUvrXqvM4OooxFuzRAcEi4/mwY1Oq59niFSISjmxXyR+Yop0RAUk/+U1ycYEU79rayuDahn9JlHeLjFUUm5vaYiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d+VZwXoSaS2LmDMAynFSLV0W7PjfwZotOCLGYmUFUw=;
 b=FhrVj8xooLOoUGJmSHFKuHGEK8YFCfvqEevVBzPovLwNvZZ9h3li0HgR0uGmRfiLbwNQjDQVIeUcwGKDkymHH4zeY1D3cbqqsDT6NVuvhGfwedycxa+S0kNoRegeYhLNYMS1Wkt/55dHZ3VPsHJMSbA7KqhPiHfSgXG856AXU0vEf7KWOmOauQwLvJIZ56sSCfJaI8JzkoB9S39XUL9vfBvrOq8wNL275v7WMcTtkElu+g+tZwWFuYbxYiyGuLFXvrW3wf6cZUFLYoyiIkbAVehLY1tAQWEViB70hIQpdmUIxHAWL+npjH+MCht0XuCgXCgt9VkY3GxVC+TAEJ86zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d+VZwXoSaS2LmDMAynFSLV0W7PjfwZotOCLGYmUFUw=;
 b=neCz6sOykswYqWeLo+0Q0e6KlTuziQ4YpT8NjamUv4UJ8epbIUy8lgk3aLv0HmsptbM43qDfpziDykjTqOB67z61N1rQmSJzzJmxOaix3i5dCUiG/5JP7iOMrJWsaT87q/gbuvu4xzlWoGjqzdtHPadeOgzFhyysFKaD5xuoaSM=
Received: from DM6PR06CA0047.namprd06.prod.outlook.com (2603:10b6:5:54::24) by
 CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Fri, 17 Mar 2023 17:18:06 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::5d) by DM6PR06CA0047.outlook.office365.com
 (2603:10b6:5:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 17:18:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amdgpu: add gfx shadow CS IOCTL support
Date: Fri, 17 Mar 2023 13:17:41 -0400
Message-ID: <20230317171748.682691-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: f493e8b4-681b-4db6-f446-08db270b92d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZ3xH0a4GXzvS4iX42oeIXj4FUC61/Est92BaDkdatd+7Lv+GNWN5GOCWAG471TeWvSBRkjjcdRTUOWaUPbFlIQfQm8d8e1alC1voJ41kBeMIKp6Y/98QcMePa2iApOuFtVOG8klJvGPCUh7bMuWq2FvJ1UX0QPrLtZyAFORV+aG2yzv7+E/608/sQ1cR8YUFe1Z9xV6cDcJ921FxAlgWJWrN2FTb0YlMiw3dOfftv15/5YZgownxCQLowngcnBIn4iVgVQWrCZWpq89QKPXNmVGY2JbVuTVN7caLbjLgfqcEhL3pEAaRwq4oXmmeb4EBNd6YS0TURWY/teL1vx8w3BMSU+JcYmiYPNuobqotC+JBMO+zhIjrcorzL5mSCcpkl9KpswYDYWaSjXjL70XwGKBSHB3EpnK2SDSxEG0kgOG+SonhTM/aL8OtyiHPQJ+McdGIlJPtYp+DRWjlLLagBKqbWdnoHGq10zNMdDSvXBDITCfJN0OzdmqJ4wyW8jlLBOKZq1pkLmPETGNaV6NZTxO7vNivL6ana2Ybo8S35m/67pKZFKnXO4wzUMYPnzklu4QjMKBEovXQs4BNhdQU+F2F4FQvcrOOi/umnCM7amzVsegbcgRKJSF8QKGZvmu7NlZeSQLXmY+8MohWJn/kRnW5N+SLCgaIetnihfdPbZsrrep9XW/+8Jc/LI0UFwE2WPIF8xLkdIJ4vOFYEqwLHgwdvtDba7Nn2Jmgd3ZcLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(82740400003)(82310400005)(36860700001)(356005)(6916009)(70206006)(41300700001)(2906002)(70586007)(40460700003)(54906003)(36756003)(478600001)(86362001)(40480700001)(316002)(4326008)(8676002)(81166007)(66574015)(426003)(7696005)(47076005)(1076003)(2616005)(16526019)(336012)(26005)(186003)(6666004)(8936002)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:06.3894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f493e8b4-681b-4db6-f446-08db270b92d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 5 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f6144b378617..9bdda246b09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -280,6 +280,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
+		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
 			break;
 
 		default:
@@ -587,6 +588,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
+static void amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
+				struct amdgpu_cs_chunk *chunk)
+{
+	struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
+	bool shadow_initialized = false;
+	int i;
+
+	for (i = 0; i < p->gang_size; ++i) {
+		p->jobs[i]->shadow_va = shadow->shadow_va;
+		p->jobs[i]->csa_va = shadow->csa_va;
+		p->jobs[i]->gds_va = shadow->gds_va;
+		if (!p->ctx->shadow_initialized) {
+			p->jobs[i]->init_shadow = true;
+			shadow_initialized = true;
+		}
+	}
+	if (shadow_initialized)
+		p->ctx->shadow_initialized = true;
+}
+
 static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 {
 	unsigned int ce_preempt = 0, de_preempt = 0;
@@ -629,6 +650,9 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 			if (r)
 				return r;
 			break;
+		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
+			amdgpu_cs_p2_shadow(p, chunk);
+			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 0fa0e56daf67..909d188c41f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -57,6 +57,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
+	bool				shadow_initialized;
 };
 
 struct amdgpu_ctx_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bcccc348dbe2..d88964b9407f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -212,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	}
 
 	amdgpu_ring_ib_begin(ring);
+
+	if (job && ring->funcs->emit_gfx_shadow)
+		amdgpu_ring_emit_gfx_shadow(ring, job);
+
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 9790def34815..b470808fa40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -68,6 +68,12 @@ struct amdgpu_job {
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
index 3989e755a5b4..8643d4a92c27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -212,6 +212,7 @@ struct amdgpu_ring_funcs {
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
 	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
+	void (*emit_gfx_shadow)(struct amdgpu_ring *ring, struct amdgpu_job *job);
 	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
 			  uint32_t reg_val_offs);
 	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
@@ -307,6 +308,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
 #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
+#define amdgpu_ring_emit_gfx_shadow(r, j) (r)->funcs->emit_gfx_shadow((r), (j))
 #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
-- 
2.39.2

