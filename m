Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C3C352A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FAA20714
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qg0eVQaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FAA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901E86E144;
	Thu, 13 Feb 2020 00:55:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9EC6E144
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 00:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+CfS2GZ1NQ7+ZOyDjxgs1B0BLRf1c4GTFa/nawcWaHGCNMTGR2/8zVWt8HRxomIfoKEPiUVX5rCDK3mi+o9w/6xHZ+QIBdL/AtWpUwOpr6vR+6D3+EruGPkVE6L2zS49FoYLqQQOn+hjWSuHnOAxbVdYWtw8f9sEVLY6wolnek8CEn+LvK+FHbon105H6VdGIYL+7VhJolj1Ephch5suf/iPHiJoQUG9b3+WPmWJQcD/B5S29zyeSLMVUzENmakRMaQOi113kx6y8OPIwL+oV7CRFslVa2McmUqVQQCcHUF9CAd9Lwh5qh7yoMEU51N4sL6q11LJ1U9mKXov8zxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSkirNAAdJ2tDNvAWtgXftVSrt1rK4t2fKVoj6VuE3w=;
 b=nUWCvrRf2zpMeHZyw8XSOnKenZBq21wsRhDM03sz0ySbNun3+eGU7Z0PoMjuUm6PLc2/cTPbprrhAEd2Gm383+pNX/jDCpPLNDleuOeq2FfLr+xgH8ZREzImtk2vO1O4kDOpmhkLeKQMyvMvVl8yi7fvjeDIrisASK6+DSTfQCUB9IQ68iEafqaKs85jTrx5ppi6rvK85m4J6P+hTrEA3uUtXGoceNRX50PEgYEM6CKd4RSF/I5O1Xk7rQ6bU+QDIcX+c7I/hNy3xh9xz6aFXbbuwtWJlSNrqJyrbZboZyxdZne4tKIBA0Eyd873+d0aDmVLA4bRg0PeD7Ojk38//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSkirNAAdJ2tDNvAWtgXftVSrt1rK4t2fKVoj6VuE3w=;
 b=Qg0eVQaDeMojO4Ulx5fhqrm2f2v8wc4VyiGKwV2AeBAXrdmsr52kGtPYlascoo1YSwWBdF3yYwuVeNfTfyPIEzfM2xJIl3PmKcVU6VSuQl6CpMjaeWGvbAnujBpsPE5GbgE/f6ph7BqL9cJLK1QBb8SrvSetVdPswStpM8SpBNI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from BYAPR12MB3351.namprd12.prod.outlook.com (20.178.55.24) by
 BYAPR12MB2920.namprd12.prod.outlook.com (20.179.93.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 00:55:09 +0000
Received: from BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::e145:db75:af50:7264]) by BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::e145:db75:af50:7264%6]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 00:55:09 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Move to a per-IB secure flag (TMZ)
Date: Wed, 12 Feb 2020 19:54:55 -0500
Message-Id: <20200213005455.521401-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.0.232.gd8437c57fa
X-ClientProxiedBy: YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::31) To BYAPR12MB3351.namprd12.prod.outlook.com
 (2603:10b6:a03:de::24)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Thu, 13 Feb 2020 00:55:08 +0000
X-Mailer: git-send-email 2.25.0.232.gd8437c57fa
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cce9b921-6ebc-47ae-b42d-08d7b01f5faf
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:|BYAPR12MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29205546CA6E013B07A5FCCF991A0@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(6486002)(81166006)(316002)(81156014)(478600001)(5660300002)(8936002)(16526019)(8676002)(86362001)(26005)(4326008)(186003)(6666004)(2906002)(66946007)(52116002)(956004)(36756003)(6916009)(30864003)(44832011)(2616005)(66476007)(66556008)(1076003)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2920;
 H:BYAPR12MB3351.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peeZNrSiKRme/II2SBLO8szCKsm2GB2nE2GXkx5g/hCok7bOcreXE5Z41QAeEu2ECXodWiirOSfgO+qvFC2dt//bWQs2jzh1r1za9aF3T9zHU3EpaRywJWdS3EXvMLNFdA/h11NMx1h8DkOCtozk9jf2HKTqFHNlCLMbyyun1/pWr26nC6+aa8XnAUkw4VWDEMBMhOubX5uI4OJ4OqNWxZONtLG95bLmAc7zHEkgLnPwVQ29SlaSlABeO+pljxQlJlEqA99OhO01tccf/baCd2ky8uJCdT6bqqxbfaNMuuFYuS0NDrDYSK+Znb6R+Gi87ar1TJlyOhKuVPoY/vPqK2j5rqSAixCuiqs1EtIgcjnN4cg3RWArhm25VgDHgykR5WjllcJ72+vqxfAZWlmNPlrknh0GEZZsMndpH/B3HFpgv0s3ONTlnfsMLh+d+wDO
X-MS-Exchange-AntiSpam-MessageData: xQ7J/spHT7CyAuFuTN3Qz0hXQdtd4ZOlrgMRC5q9DxwhxHiLx1hPjG7ke4uU8LTmLQIO/0SZWHSKdXsqWxz4PLR907DHPjoet4ilQxUUfHUzsvNh1R9OS7VLPBrLIi0oobrqjfXSNb4oub86GqwkKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce9b921-6ebc-47ae-b42d-08d7b01f5faf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 00:55:09.5607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5PNDIjo3bEeA3oN7yQSOkkLrgyFaxFkFO5VRvIdPdWjn79oG1Qd2RkrynM/cORE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
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
2.25.0.232.gd8437c57fa

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
