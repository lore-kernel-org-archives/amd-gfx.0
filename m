Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D89C352A4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 01:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C320708
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 01:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N2tV8dg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB0B6ED91;
	Tue, 11 Feb 2020 01:11:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2D36ED91
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 01:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZXBP2hNLZX0LW8GtmOe8WQRq+T/+SfbHCxr/mB7FMJ06pOZqNV01fMQyHf/gZrdsmA9kZtFdx2Uyl/CwRTKa117FfQA3st/Ojdv7s/NQQl1XYVUKR1PpfJzXDFnPuOgb1ZYS/QwtP9YwxwDW/IkEyDnbjPraApNknpDVoLZJUjl4st0eNArxO7txvmBIy9eG0kJI+sttQi5uvVpAr/DC0Kl7TdoGrm2hxvXERbXygF9hoxPwEmBH9qsp9XLZvfCUXLPldU0g3Hx/dmCQFizOCY9eRAID5jcxiBsboBTpP3eRS6PGyF298y22Zf+N+DRbprGGbqujrZm1sDGMHLlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOxG9lvPTAJmNMylxSgM5b6QDLOq1BZYSKcjYw9ICD4=;
 b=R1nbBpgo9NnzAFw9hmP3ZtvwhX3uyJFWfBDCyWAZ3aym7HKGtBb/X5C5wieKlaHh1y/lBQ0yqandW/xEDheUbezTJ6xoc2O0HuCzk7FYARKIHoI3aupmvgAl3J3jWW2EZKikeILcBlOGz1TJRkyfDt/VfbY8suv7tdblkG/phgh1K5xbFQF0ob+j+rmYVixyUm5f/mhr10N7KM2Y5PrOsmobAbHsTQpxmg/5gFQRkRA2+xZOjTVZYWqueAnXiJFac3rHBZVTc1CqqcUKmp0H/jvZyM7HqYDSSSVGNA/SCKjdeGVaosT3fEd9yv2KEJcIpYKLu7hpqJVzBtR69+BhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOxG9lvPTAJmNMylxSgM5b6QDLOq1BZYSKcjYw9ICD4=;
 b=N2tV8dg0JXQ+j/tA9BeMm/XCWN8BsUAZ6mi3KoMjAmM7WnVaQAXfQiIk0PmQtwW2j/yGynggVAOgdB8ZPTNRoMNnOd0/norM+OYHwtwn4LWrT4f9yWkX2g+XGPENhQU41DHXwRxFzhEftNudPMaEsSnNMPXIKJNQKBGVstcnWVU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4267.namprd12.prod.outlook.com (10.141.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Tue, 11 Feb 2020 01:11:52 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 01:11:52 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray Huang <Ray.Huang@amd.com>, Marek Olsak <Marek.Olsak@amd.com>,
 Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>,
 Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Move to a per-IB secure flag (TMZ)
Date: Mon, 10 Feb 2020 20:11:40 -0500
Message-Id: <20200211011140.433521-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.0.26.gc7a6207591
In-Reply-To: <20200210232555.417820-1-luben.tuikov@amd.com>
References: <20200210232555.417820-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 01:11:51 +0000
X-Mailer: git-send-email 2.25.0.26.gc7a6207591
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6bd6bfa-18f1-4825-358e-08d7ae8f60ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:|DM6PR12MB4267:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4267D9DB1391AC517B2FCDB799180@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(2906002)(478600001)(30864003)(6486002)(36756003)(7696005)(52116002)(1076003)(6666004)(86362001)(44832011)(316002)(66476007)(66946007)(6636002)(66556008)(4326008)(5660300002)(2616005)(81166006)(54906003)(8936002)(110136005)(956004)(186003)(81156014)(26005)(8676002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4267;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpBCQ2zHUM/mKIJDXsT+XuvpYJV0Dsyo4qWQNQ8p/VZFkzTV1/j3kss2OFdEPR/U+tpgO7tj/SpusfNTsIWDINumEIBAyH6mFeGIKX/JzVyWoumtMavFtdiHqwLeoszn113TQGUMijoj2hoC6aXicV9bJtwyeGXsnNBomezEe2M53tm2+VwoIOAzJ5182i7FMvKbEOIT/Xf9UUK5jjWQDvb29LE9/vdzUTh3NJjEc1kAl4tcYvWOBeEkImWNsCNYVUNuzCu9HMpVCw82IdnaItmnAPi3GsTxIg0PAmeTsz+oK9mDsTTr0RbC0e6d8vTv9wuzlFyqXE/dKLU4APTUQuxAAHF91bByH6Ksl+MZ7GkahFCQRFTvi8qQt17SLxvVeO5r6rplNXiysdF28TgMnJtW9ZZHpczmW04ZZlqAhuV0BCILl2cODVWtWufteBKP
X-MS-Exchange-AntiSpam-MessageData: /3gd3amzH6gFFOsiB7nyF8iLaNrDfTblZKL9rm5c7QZ5iAS4weKaEqML7nInsvdaxIhMkbNvxbwzJyUkKUpT/MnRwVhbToNLb/TP9+RobTkTBx9Zl9j8EPy64jyXI8iwqs0DQ4EcS0XplLZGvK7h1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd6bfa-18f1-4825-358e-08d7ae8f60ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 01:11:52.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9RpTvZiVEQ5lE4GWRSxFlOTvpooicX2TdaYBxLbkKOh5utfDZreUt5wDnHVF1vb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, Aaron Liu <Aaron.Liu@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 23 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++--------------
 include/uapi/drm/amdgpu_drm.h            |  7 ++++---
 10 files changed, 44 insertions(+), 52 deletions(-)

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
index 6e0f97afb030..cae81914c821 100644
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
+				amdgpu_ring_emit_tmz(ring, true);
+			}
+		} else if (secure) {
+			secure = false;
+			amdgpu_ring_emit_tmz(ring, false);
+		}
+
 		amdgpu_ring_emit_ib(ring, job, ib, status);
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (ring->funcs->emit_tmz)
-		amdgpu_ring_emit_tmz(ring, false, job ? job->secure : false);
+	if (secure) {
+		secure = false;
+		amdgpu_ring_emit_tmz(ring, false);
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
index 5134d0dd6dc2..930316e60155 100644
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
@@ -167,7 +166,7 @@ struct amdgpu_ring_funcs {
 	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask);
-	void (*emit_tmz)(struct amdgpu_ring *ring, bool start, bool trusted);
+	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
 	/* priority functions */
 	void (*set_priority) (struct amdgpu_ring *ring,
 			      enum drm_sched_priority priority);
@@ -243,12 +242,12 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
-#define amdgpu_ring_emit_cntxcntl(r, d, s) (r)->funcs->emit_cntxcntl((r), (d), (s))
+#define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
 #define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
 #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
-#define amdgpu_ring_emit_tmz(r, b, s) (r)->funcs->emit_tmz((r), (b), (s))
+#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
 #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
 #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4e25b39ac14f..1a9787a0177e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -256,8 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
 static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
-static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
-				    bool trusted);
+static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -4564,8 +4563,7 @@ static void gfx_v10_0_ring_emit_sb(struct amdgpu_ring *ring)
 }
 
 static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
-					 uint32_t flags,
-					 bool trusted)
+					 uint32_t flags)
 {
 	uint32_t dw2 = 0;
 
@@ -4573,8 +4571,6 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 		gfx_v10_0_ring_emit_ce_meta(ring,
 				    flags & AMDGPU_IB_PREEMPTED ? true : false);
 
-	gfx_v10_0_ring_emit_tmz(ring, true, trusted);
-
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
 		/* set load_global_config & load_global_uconfig */
@@ -4731,17 +4727,12 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 					   sizeof(de_payload) >> 2);
 }
 
-static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
-				    bool trusted)
+static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-	/*
-	 * cmd = 0: frame begin
-	 * cmd = 1: frame end
-	 */
-	amdgpu_ring_write(ring,
-			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
-			  | FRAME_CMD(start ? 0 : 1));
+	if (amdgpu_is_tmz(ring->adev)) {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
+	}
 }
 
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
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
index e5753746cbf9..9d3805488832 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5212,29 +5212,21 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
 }
 
-static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
-				   bool trusted)
+static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-	/*
-	 * cmd = 0: frame begin
-	 * cmd = 1: frame end
-	 */
-	amdgpu_ring_write(ring,
-			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
-			  | FRAME_CMD(start ? 0 : 1));
+	if (amdgpu_is_tmz(ring->adev)) {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
+	}
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
