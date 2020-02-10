Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5DBC352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 23:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE65C20715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 23:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="053ssVUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE65C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5DA6E266;
	Mon, 10 Feb 2020 23:26:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690067.outbound.protection.outlook.com [40.107.69.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716F06E266
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 23:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQCubuopKBKLLOQc1SpP/0m71K3EfdhZFeRhEdMNC4WiDEEMLUDKuz+jgu4aXGK5Xmw0ybo0uGrYjK7jhg2Mvjsz7i5K1AqSA79S6+79jhGL+ryAldOZAE/X5TOZHYfO8hkLXWGg/B9KzC2Gdnmm+GKvCYG4oOQ0BoNF2P8QDVlfW5Q5Vb/HeBWbgkA5S4iO4Z+IKBqgbS8IJhGplbJWhXkfWdthEza279ReyAd/8T2n3q8ZdnrNguJvc0qAF6zyxv7ptw0e5KMhGfJZpTvtCfy9jf8KRaLZdsyDUTuVPCBSJjrBHKCoZLcFL7DxMNCyIPsEL3MdVHMPesEE/cIsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikk4JX5RqTRdCjArdWWWvJb3QODgfiXwTRvdjMLE+4g=;
 b=Gmr4NtCzr6xElucW9+me09MZEwIbfdnQzfOp/BkHo6Vr/Ma6TWS2vHea7pRMWjiWzjmMA4pGdnk12hV45cMTBptGms0wBhJXFNxNN+ewulKz9Y+ypg/8EsWJ5A8k+X7ttNe6ulpmKlwiSyLa5y3UpdgCS8ByVp7aqwCf1h/wuanSJYo1btO3zaefCW32Y7oYLEp5zANiEu5chotyXUJe5XlNcPCZza/XVMWS7Zcq6OxMFgL1hW4V0TcU2ifeHpgVLTGvncVsxtkvupTGOotBuT0GNzs9iCjLv9ql+QoVSMBBGgmLVM8TCn3ephHxhYCGlKr7leL4ccxDC/XMBHQfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikk4JX5RqTRdCjArdWWWvJb3QODgfiXwTRvdjMLE+4g=;
 b=053ssVUgqGXd2Ylv+C/8CwRzmjTz8E5qtj2AYfOl0dgpRWbfSmvrzzR7JPJ76o08dbbRhpSsI8NAENUlzL8jRDCrQvwZ3XYPIOEQ2xAnD4F/cKcFTegAS3WL2TkyyLVD5dNH0eIaVjETRI6feTPZk1n+iJ5ww2Qdlwqdq74qsg8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3403.namprd12.prod.outlook.com (20.178.31.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Mon, 10 Feb 2020 23:26:11 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 23:26:11 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray Huang <Ray.Huang@amd.com>, Marek Olsak <Marek.Olsak@amd.com>,
 Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Move to a per-IB secure flag (TMZ)
Date: Mon, 10 Feb 2020 18:25:55 -0500
Message-Id: <20200210232555.417820-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.0.26.gc7a6207591
In-Reply-To: <CH2PR12MB39125C58ABA40856F1CBF8DAF7190@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <CH2PR12MB39125C58ABA40856F1CBF8DAF7190@CH2PR12MB3912.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 23:26:10 +0000
X-Mailer: git-send-email 2.25.0.26.gc7a6207591
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6f9667f-a5b2-4683-9feb-08d7ae809d04
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:|DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403131628FDE9316D75C41B99190@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(478600001)(4326008)(2906002)(316002)(110136005)(1076003)(54906003)(86362001)(6666004)(36756003)(66476007)(6636002)(8676002)(5660300002)(52116002)(7696005)(66556008)(8936002)(44832011)(66946007)(26005)(186003)(81156014)(16526019)(6486002)(81166006)(956004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3403;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uFhRltTu44Yv5fYw2sLT+wMCQu+A2LHk1cBabh8TwgRn55fLXtbzmZxwhDnrRuauPbZPnZPszYS89PB9JdKGbkftCdiOp6s5REZQ8fCOggXB8S7/KzMVMXQNPeCIdS/AOMa3+w88aVa3i8sJrP12PIWKS14zzUvlZQ+aYwweVfEKZ5diGfWmz1KCt9dJjab1u08ZUzKABP4DOJDJGr3ubk3ZR3MN7nOd40jOZCz9Ss/QVuXK6yMXDW0RXOam7NVay3JD++DCpWrHbWH/Kwd7XyKfqUjCGWCGNiScViREGQF4uIVvxUkCBx415E0BDDmVbJcHls7xkZDJJsBCabb/ZXmYhWjmDc9eM5a+jBovfLZFjWaHGpPoYBlUd176rCxa5wHn7BQCIDq9lAyBweKwOllcpVDyGAiMZq/17aD9sgI1Y5SjAHy7Uw03/FI19xe
X-MS-Exchange-AntiSpam-MessageData: LXVbIzLtVK11bDEMuy9VclkMtVcQEG8sIc18zZ0n3LPBcscnbbzKKBrDKQf9ajgltmfBjCkgDT1pQ78psKZnl6s7nUrAMvEGZakUlMeNIabBxisbWZ/SI6a2IetBzfQ3cbBq1Qj40LJ22jb7FDJJkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f9667f-a5b2-4683-9feb-08d7ae809d04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 23:26:11.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2ES5T9lid0mNK6rI/zU3cIZicgXv3gzreyAG/PbQi10WqrIGBHNwUes1B1y2lYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Aaron Liu <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move from a per-CS secure flag (TMZ) to a per-IB
secure flag.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 23 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  5 +----
 include/uapi/drm/amdgpu_drm.h            |  7 ++++---
 10 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 80ba6dfc54e2..f9fa6e104fef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -231,8 +231,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	if (ret)
 		goto free_all_kdata;
 
-	p->job->secure = cs->in.flags & AMDGPU_CS_FLAGS_SECURE;
-
 	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6e0f97afb030..f9515db2823b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -132,6 +132,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned fence_flags = 0;
+	bool secure;
 
 	unsigned i;
 	int r = 0;
@@ -213,9 +214,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (job && ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
-		amdgpu_ring_emit_cntxcntl(ring, status, job->secure);
+		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
+	secure = false;
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
@@ -227,12 +229,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
 			continue;
 
+		/* If this IB is TMZ, add frame TMZ start packet,
+		 * else, turn off TMZ.
+		 */
+		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
+			if (!secure) {
+				secure = true;
+				amdgpu_ring_emit_tmz(ring, true, true);
+			}
+		} else if (secure) {
+			secure = false;
+			amdgpu_ring_emit_tmz(ring, false, false);
+		}
+
 		amdgpu_ring_emit_ib(ring, job, ib, status);
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (ring->funcs->emit_tmz)
-		amdgpu_ring_emit_tmz(ring, false, job ? job->secure : false);
+	if (secure) {
+		secure = false;
+		amdgpu_ring_emit_tmz(ring, false, false);
+	}
 
 #ifdef CONFIG_X86_64
 	if (!(adev->flags & AMD_IS_APU))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 31c4444b0203..2e2110dddb76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -61,9 +61,6 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
-
-	/* the job is due to a secure command submission */
-	bool			secure;
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 5134d0dd6dc2..34aa63ad5799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -158,8 +158,7 @@ struct amdgpu_ring_funcs {
 	void (*begin_use)(struct amdgpu_ring *ring);
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
-	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags,
-			       bool trusted);
+	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
 	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
 	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
@@ -243,7 +242,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
-#define amdgpu_ring_emit_cntxcntl(r, d, s) (r)->funcs->emit_cntxcntl((r), (d), (s))
+#define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
 #define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4e25b39ac14f..42bdff7c2add 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4564,8 +4564,7 @@ static void gfx_v10_0_ring_emit_sb(struct amdgpu_ring *ring)
 }
 
 static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
-					 uint32_t flags,
-					 bool trusted)
+					 uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
@@ -4573,8 +4572,6 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 		gfx_v10_0_ring_emit_ce_meta(ring,
 				    flags & AMDGPU_IB_PREEMPTED ? true : false);
 
-	gfx_v10_0_ring_emit_tmz(ring, true, trusted);
-
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
 		/* set load_global_config & load_global_uconfig */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 95bb2422b27c..31f44d05e606 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2973,8 +2973,7 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	return clock;
 }
 
-static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
-				      bool trusted)
+static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	if (flags & AMDGPU_HAVE_CTX_SWITCH)
 		gfx_v6_0_ring_emit_vgt_flush(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 648d767d14e7..8f20a5dd44fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2320,8 +2320,7 @@ static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, control);
 }
 
-static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
-				      bool trusted)
+static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a46ec1c9846e..fa245973de12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6386,8 +6386,7 @@ static void gfx_v8_ring_emit_sb(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
-				      bool trusted)
+static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e5753746cbf9..0a47a5ca5ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5225,16 +5225,13 @@ static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
 			  | FRAME_CMD(start ? 0 : 1));
 }
 
-static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
-				      bool trusted)
+static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
 	if (amdgpu_sriov_vf(ring->adev))
 		gfx_v9_0_ring_emit_ce_meta(ring);
 
-	gfx_v9_0_ring_emit_tmz(ring, true, trusted);
-
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
 		/* set load_global_config & load_global_uconfig */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 918ac3548cd3..eaf94a421901 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -556,9 +556,6 @@ struct drm_amdgpu_cs_chunk {
 	__u64		chunk_data;
 };
 
-/* Flag the command submission as secure */
-#define AMDGPU_CS_FLAGS_SECURE          (1 << 0)
-
 struct drm_amdgpu_cs_in {
 	/** Rendering context id */
 	__u32		ctx_id;
@@ -599,6 +596,10 @@ union drm_amdgpu_cs {
  */
 #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
 
+/* Flag the IB as secure (TMZ)
+ */
+#define AMDGPU_IB_FLAGS_SECURE  (1 << 5)
+
 struct drm_amdgpu_cs_chunk_ib {
 	__u32 _pad;
 	/** AMDGPU_IB_FLAG_* */
-- 
2.25.0.26.gc7a6207591

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
