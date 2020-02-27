Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D56C4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753C024690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lhfFXhvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C024690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7C26E855;
	Thu, 27 Feb 2020 11:38:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9419C898C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuHCtt8p5A3icQEvKb3Jl+Wwj2lSWISDSRiPPCDsPR8blY3DbTM0IQ894hFmww0xLK3tHY+Wk+dk8X4qnTMrc5nibDnCrXzmDak2uXWSDR4+fYRD1Arj+ZEX/m2omX8nRlDfQSGQAlXWvgzS3Gi+C7maMEvj6hwGCF04uKeQX6P93is19QATLHoqh5aSwu0HI2T8c4kiLbAIalHG4XwD6H5IGYsuD5b+iQBYQmO8Z7mbXgB3yu0RNRvKq5EaYsC3YxRAhfwuJEhvu/PJBtnJWswCoD0qpnL/CLtfS5/CcsGa2Rhyh7ehnSnXMTXiIhKo7uNj1UUZN8CslWdhNSVG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wok4glKASO+QmHyRYaYykPbDeiXumK7arv7O1uTQMGQ=;
 b=l9WBfgvRE5RdMKmP7vgI7MyDv4m9XwU7GEBfBrwoDrUGLmErqWbCLVw+XCZzwg0I3o1VxokKsCwtcZV5m5/mMPjgH2KHCF4J/gHU18EVqDG+Uy2z75KNuScbmS5rjTqDK+nY/WfDHBjjAueyuFM8oH7l3CDzOdekgc7B4zrIfl/aZUCnTtFXXQZc6QWKdDvVKvtx8vXGpI3hf7WC8lsJf1lpqe8CoW9pV8i9n3HhFvXZVcLBhdG6/MMhwV7W9NP/tuNlJncjQrnrOBjNgseHvE5qKq6Pwlpjs1TVwZImkYK0QK9enumlO3RgxzjsSPsNsyOv8v/GE1mTSanMAs6HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wok4glKASO+QmHyRYaYykPbDeiXumK7arv7O1uTQMGQ=;
 b=lhfFXhvHdmjoa//k1xvDfUHJjHGMpcT14c9iy3/jUDbMd36tIOfs9CnWDc0ux8qOFOhRcs53Ul2MHfugn5mu4/glDR5J5Bsz7/dg/ba4zlajmVbZ8as6d0pd62CQm8IyDCYP3KDGzXuy8HUzhxiNWGEzxzP60tJ4b7CeBXY/R+Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 11:38:27 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 11:38:27 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix the gfx hang while use per-ib secure flag
 (v2)
Date: Thu, 27 Feb 2020 19:38:03 +0800
Message-Id: <1582803483-27446-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (180.167.199.188) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 11:38:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a49c506a-9844-478b-a223-08d7bb798f60
X-MS-TrafficTypeDiagnostic: MN2PR12MB2896:|MN2PR12MB2896:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2896E5F254C5BEB5B983EAA2ECEB0@MN2PR12MB2896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(6666004)(6916009)(316002)(81166006)(54906003)(5660300002)(2906002)(8936002)(36756003)(86362001)(81156014)(16526019)(8676002)(186003)(66476007)(478600001)(2616005)(4326008)(26005)(6486002)(7696005)(956004)(66946007)(66556008)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2896;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWzDV6rcCwOu1UHxWO44Mlanf5LEGazAaOBXcy94f5mgW+xYC4IaFUWfsQkdjyBDoLFfZqffm8nsQ4WgKfEHAP/fYs14KwwNgqS+w3updFsT2XICeTBWRwN1RzkW9sc0NeuPUn7GCNjWGGQO/Tsg9dSGk7eZO/yE344ASNjVl8LpgOdXkAZrIspS7liz76M0RvWmXCwVLkm0bAjcjDT6faENEZvRwt6XIUvrx5pbofOE23d6N1giSMqLMrNrj5wRR9rS0OIKTtrs/8on/Y5AkrDlQ/OGgL4uL1Nw0DLZ9Sz8u5pz5RgED7XYXciqWz29LvMylmy6j2WiaZgZpXmK6a41nWfdb2GyKhdO5qG2jVzd353MCyrgQijqzURI6+VQY4LUPzvbZrmbrJTxReobgMMYOon8trM+qANQ4ZFkBFmy7q3WmCdKeXUmVnmNmqTp
X-MS-Exchange-AntiSpam-MessageData: jVMUK77XHH28SBxkiwx3wCh11lOa33v164+uhTB7wSKU+UK/L2OXz3AD2K1WzT2Rr9JpE+CgSJl1Hdd5sF0h34jrnwyNKBxMe9WBw/MiyQUBa3cXpQlOLPqT0ou5uX4R55ec0gLFqgATLC1C8sYKUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49c506a-9844-478b-a223-08d7bb798f60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:38:27.0274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMZnVCQ7p6E6dSmhBF4eTsFbOJtd4Q3F4lqnROXbH+Pu8Wzorc1Xpn1kkecV70ZMNbDfDPKftvgdt4Y6QZlj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2896
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

v1 -> v2:
As suggested by Luben, and accept part of implemetation from this patch:
- Put "secure" closed to the loop and use optimization
- Change "secure" to bool again, and move "secure == -1" out of loop.

Reported-and-Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++------
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4b2342d..0f4909a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -216,7 +216,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
+	/* Setup initial TMZiness and send it off.
+	 */
 	secure = false;
+	if (job && ring->funcs->emit_frame_cntl) {
+		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE ? true : false;
+		amdgpu_ring_emit_frame_cntl(ring, true, secure);
+	}
+
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
@@ -228,27 +235,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
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
+			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
+				amdgpu_ring_emit_frame_cntl(ring, false, secure);
+				secure = !secure;
+				amdgpu_ring_emit_frame_cntl(ring, true, secure);
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
+					    secure ? true : false);
 
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
