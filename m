Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A6DC35DE1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A0B24650
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xifPGcvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A0B24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421D36EAD3;
	Tue, 25 Feb 2020 13:58:25 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53D46EAD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 13:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwU30/JdarW1gxeIhE+GVnXeHLf8oi9x28YhZwedAqWOd5uef60V4gHFNPswLyHW4czJH3Xv7sX+dgb2J9C+oQFV1/hAH8oMsnuEFSuV+UWmhpakOVMh96W9vEKc0aZr2pGjZySAZoa8jbebCfGTyUJxuPBWDqqDKkCBDSNwVZJdhf8wGelU26tfuXS7mUSXZ7nN0c0DN4XDHXQOGXIQE7LiRQM0cqv+ex/ABBoXO0+1KG9NglcJVOLnmBx7KY6U6AuTEL1U9ewiOHg5mQmtaYB4Fl/IIGrC5MtplDkNGJH5X08cJzbakjkRtxDDxa9+3creDVhjPc4buhnkJs0fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMd2Th9U0i5RqvclD5EMClixrNiWR8zn8FgZYC3CdGc=;
 b=ERsrh0oB9p8vBgIfAekMtWa4e9n3SWfckZ9eSgmqLPIJzk5fbf30XMmrCrmm+8wofXzTJQpNtNImBPeru6DOE4/6E1QYVISSmyozdo2rG9tmcXUtl9PbQB8Gzw0Glg6BBg2TpKf0C3ZPHZNA21cZnqvoSJGGzR5jnkVGp3HNyp++Rpf5xTIOGTst/90zHuFgIVp+DpIK4qVOilDPEhH6LEVc7OVrYoCm0YyM4zF21Nn1bC0c/EHCwa+THV5/nl6/mlJYS+wrX2n/2UI3wVRbS6XaXCSazybexEgrg6MRCs0PoEknjKiQJ7ZKnVf465TtSIj77Cd+sRw8lOKzwJLO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMd2Th9U0i5RqvclD5EMClixrNiWR8zn8FgZYC3CdGc=;
 b=xifPGcvLfgEaq9zwxpZIf3/fLuLZFFEPOc+vQN7WnXvNKEqoGKEhScW6uhaljpFDc6FKSBppAhO/pFCk0QP6w+VpqCAAp5ZEjLyXeRe0aYKt+sSxCjCfv+wpgXQLa/e2aw+SaCk61WLgW2qPpH+38gawxN0Sw5RimO5pxKKHhyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 13:58:23 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:58:23 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
Date: Tue, 25 Feb 2020 21:57:53 +0800
Message-Id: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 13:58:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f59d4f8-146c-4b5a-61d7-08d7b9fac6ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:|MN2PR12MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4176CB0307517A7973C9401FECED0@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(52116002)(4326008)(7696005)(86362001)(6916009)(186003)(6666004)(16526019)(26005)(66946007)(66476007)(66556008)(6486002)(36756003)(478600001)(81166006)(81156014)(8676002)(2906002)(54906003)(316002)(956004)(8936002)(5660300002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4176;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaNwlJYg1ZZWGFPqtV5xkjBwyGZ6Z7wCU24L/Lox/D5r31AcG8etuV5dzRgrE8ygTQKLuWeLGIhmj8nIlAGOawhlhVxbFO4vQIqP8eqmh4difmNxhMcpnbfqNszjjBIfYdcbKFsO2mhWgBkc80JCG+FVZrqXTI14voXiPzdrxbvGuZ2Vafb34FtvgQyzRgRqvGVbwhg8sLI2zj01/zjcOptopZ2sun/OMwJpLcPGlc7PWdiLhQHMBm5qf1LP3Z1yESVeJ94upzMzmHxDAcrpw6W057SAjCpzXvq4mI5Tlb8sLouKBFAyxTDEHcUYyY6llmmRo5OkAW94mG3VFR5E9omD77id3ozWVunF1A0fkTbOnotRNK+k+sXb0nv0pdCALtL4a9HOdbbdKThXJHFnNYPY8JmAEMnDyunFWrsRr3zmPoHXSUiTInXXZquca+ko
X-MS-Exchange-AntiSpam-MessageData: 8gozgWzTgYI8YRvTWON439OglHwzz4nIYVAFIb3nEb7TKfMOCZUxDmvYSy+f1aT2mlavgoDNJ+Mk1snbSzeqzrFa57m1KCyALCcd1MSfrpkCeoIlAk9es+WCj/EuG5W8olbZTB72POwA22bAH0J/ag==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f59d4f8-146c-4b5a-61d7-08d7b9fac6ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 13:58:22.9501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQac+OoZ84kbIwIh4a43fiBsIfNbz6buB1iMVNUyR1hvZUx1A/B+mjG5wpPLzzCiyE7qOyWg8grZkRGu50kS5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
This causes hangs on some hardware (eg: Raven1). This patch restores the
unconditionnal frame control packets issuing, that's to keep the per-IB logic
regarding the secure flag.

Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)

Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 41 +++++++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++-----
 4 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4b2342d..9713a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -131,7 +131,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned fence_flags = 0;
-	bool secure;
+	int secure = -1;
 
 	unsigned i;
 	int r = 0;
@@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
-	secure = false;
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
@@ -228,27 +227,37 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
 			continue;
 
-		/* If this IB is TMZ, add frame TMZ start packet,
-		 * else, turn off TMZ.
-		 */
-		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
-			if (!secure) {
-				secure = true;
-				amdgpu_ring_emit_tmz(ring, true);
+		if (job && ring->funcs->emit_frame_cntl) {
+			if (secure == -1) {
+				if (ib->flags & AMDGPU_IB_FLAGS_SECURE) {
+					secure = 1;
+					amdgpu_ring_emit_frame_cntl(ring, true, true);
+				} else {
+					secure = 0;
+					amdgpu_ring_emit_frame_cntl(ring, true, false);
+				}
+			} else {
+				if (secure == 1 &&
+				    !(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
+					secure = 0;
+					amdgpu_ring_emit_frame_cntl(ring, false, true);
+					amdgpu_ring_emit_frame_cntl(ring, true, false);
+				} else if (secure == 0 &&
+					   ib->flags & AMDGPU_IB_FLAGS_SECURE) {
+					secure = 1;
+					amdgpu_ring_emit_frame_cntl(ring, false, false);
+					amdgpu_ring_emit_frame_cntl(ring, true, true);
+				}
 			}
-		} else if (secure) {
-			secure = false;
-			amdgpu_ring_emit_tmz(ring, false);
 		}
 
 		amdgpu_ring_emit_ib(ring, job, ib, status);
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (secure) {
-		secure = false;
-		amdgpu_ring_emit_tmz(ring, false);
-	}
+	if (job && ring->funcs->emit_frame_cntl)
+		amdgpu_ring_emit_frame_cntl(ring, false,
+					    (secure == 1) ? true : false);
 
 #ifdef CONFIG_X86_64
 	if (!(adev->flags & AMD_IS_APU))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 24caff0..4d019d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
 	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask);
-	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
+	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
+				bool secure);
 	/* priority functions */
 	void (*set_priority) (struct amdgpu_ring *ring,
 			      enum drm_sched_priority priority);
@@ -247,7 +248,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
 #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
-#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
+#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
 #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
 #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7b61583..748ac35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
 static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
-static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
+static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 					   sizeof(de_payload) >> 2);
 }
 
-static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
+static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
+				    bool secure)
 {
-	if (amdgpu_is_tmz(ring->adev)) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
-	}
+	uint32_t v = secure ? FRAME_TMZ : 0;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
@@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v10_0_ring_preempt_ib,
-	.emit_tmz = gfx_v10_0_ring_emit_tmz,
+	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b..fbde712 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
 }
 
-static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
+static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
+				   bool secure)
 {
-	if (amdgpu_is_tmz(ring->adev)) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
-	}
+	uint32_t v = secure ? FRAME_TMZ : 0;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
 static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
@@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
-	.emit_tmz = gfx_v9_0_ring_emit_tmz,
+	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
