Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B286C4BA2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 22:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B28721D7E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 22:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4VNj5XVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B28721D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC0E6E27F;
	Wed, 26 Feb 2020 22:39:32 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EF36E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 22:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVdvEzqMvZq1DLlUuULAZ3NaZTjKdM27IUF+jJCxOh2oO+BofymmtSAd9LweJPYT+j6yR8f+I112Ei18J6wUfxXQoyE8qMAAOhMr1AdWyuJBd+C3JAou4507xCqdQJfS7V+KQx2TMfiFKHISDo7vhaTeodqmsDORENblbIb1F4ZL+It2i0EBL789nCsoKI+bEPHXxB3jntXWSG2Ol+zcE5nTEpCqWxjf794WYzM8DjlYI19cQKXU6vqHVX+OI44g+hNtwN4A4Ir1xQ3cP/JuQ7uodss19epfJB39RJBM8CC2Im+wrtxi7qqOl2RvkJQ9vgqlQiNfHm3TrPb7pYwi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8+GAgWXH8JDmXc+QnK3qP3lupluC9ct8ZJio8JpkwA=;
 b=TpJTMPy2vhM0bSyvFJS5tc8KfNkcNqCp4aUJQG/kgYRVFwKZF2Ypggni3wSeaoR5LiH7F5L9ZykHpJ0FPAKU5+V0P/XpIvxOUqnmrCEsrD276E6Xk8/4IaNbWvaCJMZOAjL+Iw39KMQeMlFTKnethlqQe3jjpiXwPNDfGabSmsNpW6FQR/Hkc5EUUFJyqn3C3+9pIg26/v89+FG4X4pmD5K0VFTB781JHwzeTwL0tHxFp7HAsruYy/274X18KZiesL3ptXYHiHzs4LQv1tg1KTu/bNU3zV95ccqc2DBAiGRKnKm33NLw4zXA8QHqrGaKQjcxQ0xH39rQZGPcjV7N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8+GAgWXH8JDmXc+QnK3qP3lupluC9ct8ZJio8JpkwA=;
 b=4VNj5XVIM9uPh2V8g1rTFfCMsM5mfTixCJTrrvQxfj6rjTWG8Hx8DCJ7uW3bK2xwkmwEesbIjWc45s7c7dk6uKqyF3W4DcMU4sUUjzT+WmeS2ohnUcyEfa81PA28IFBxlCPPZOgYy6oGMuj0i9ONWeKh7a7GqsfjZWoI8rRJQ6g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 22:39:29 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 22:39:29 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Fix per-IB secure flag GFX hang
Date: Wed, 26 Feb 2020 17:39:03 -0500
Message-Id: <20200226223903.6088-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200226223903.6088-1-luben.tuikov@amd.com>
References: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
 <20200226223903.6088-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Wed, 26 Feb 2020 22:39:28 +0000
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3c0a27a-e13b-4489-32f5-08d7bb0cbd5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:|DM6PR12MB4124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41241D082496B92351EC3F5099EA0@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(6666004)(186003)(81166006)(316002)(81156014)(6916009)(5660300002)(478600001)(16526019)(8676002)(26005)(8936002)(66946007)(7696005)(36756003)(86362001)(2616005)(52116002)(44832011)(2906002)(6486002)(1076003)(66556008)(66476007)(54906003)(4326008)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4124;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vev3Jaaflhbpa6nyVMnDI476EfhPfG7PgnDZT2OlQ6dB2kymUc+MMtARR+5fZNDK63nZGmBSk2zYcrkdjtngv+EU9NDFCaPVwWdfi0tZz4y+PZ1mSTOUEyHo/uMk1kz051x5NnRYCfYjW+yHNWX6SlNUMiu5uI7dnGsGRdJYZQUJQo3Q4DHd+rA6etE1VqlGQsQiMg553y5EKLtRclVYq7NIuzNxM/T/AzqPuJ5pvTBh/wza+MPiRJaP7KXTLsEzvU8tGHnIer9YXd9IbhyT805HWQyZAWfXrC+xh2AGBXVzbrM6IZqBOSF972jbkTOTbf7nDhE1CqaF3e5eIyf4+2GbVtZuJVVhMJ3rad/oJVQLCiEZIc+eCKowimkdLiUEbJ4VH2O+q4F63J1o2nQKyZTLkYxtlk+plGq3xKhjN9ylFBDHyZIgZknnMvNKWXVp
X-MS-Exchange-AntiSpam-MessageData: FRmps3zFQyQjh3yZFuDwHlADTK7PQkgROzziyshAVWCfY7BUJauXJQNGps1miYZzp0ToqIvhLl3FU1QztA8I+8obZtyt5Ew0ee6C0SjqnUbOp/N7o9DpEASuISWGoBawax081mvEnVfBkWHFMLagVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0a27a-e13b-4489-32f5-08d7bb0cbd5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 22:39:28.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rf+70ooljGplY2eqZBPv61NxqSEzxOS9mLlu2LpUJl1urUp6tJTpZQ6D1/NhTPpG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
 Aaron Liu <aaron.liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since commit "Move to a per-IB secure flag (TMZ)",
we've been seeing hangs in GFX. Ray H. pointed out
by sending a patch that we need to send FRAME
CONTROL stop/start back-to-back, every time we
flip the TMZ flag as per each IB we submit. That
is, when we transition from TMZ to non-TMZ we have
to send a stop with TMZ followed by a start with
non-TMZ, and similarly for transitioning from
non-TMZ into TMZ.

This patch implements this, thus fixing the GFX
hang.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 87 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 ++--
 4 files changed, 79 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4b2342d11520..16d6df3304d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -216,40 +216,75 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
-	secure = false;
+	/* Find the first non-preamble IB.
+	 */
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
 		/* drop preamble IBs if we don't have a context switch */
-		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
-		    skip_preamble &&
-		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
-		    !amdgpu_mcbp &&
-		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
-			continue;
-
-		/* If this IB is TMZ, add frame TMZ start packet,
-		 * else, turn off TMZ.
-		 */
-		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
-			if (!secure) {
-				secure = true;
-				amdgpu_ring_emit_tmz(ring, true);
-			}
-		} else if (secure) {
+		if (!(ib->flags & AMDGPU_IB_FLAG_PREAMBLE) ||
+		    !skip_preamble ||
+		    (status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) ||
+		    amdgpu_mcbp ||
+		    amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
+			break;
+	}
+	if (i >= num_ibs)
+		goto Done;
+	/* Setup initial TMZiness and send it off.
+	 */
+	secure = false;
+	if (job && ring->funcs->emit_frame_cntl) {
+		if (ib->flags & AMDGPU_IB_FLAGS_SECURE)
+			secure = true;
+		else
 			secure = false;
-			amdgpu_ring_emit_tmz(ring, false);
-		}
-
-		amdgpu_ring_emit_ib(ring, job, ib, status);
-		status &= ~AMDGPU_HAVE_CTX_SWITCH;
+		amdgpu_ring_emit_frame_cntl(ring, true, secure);
 	}
+	amdgpu_ring_emit_ib(ring, job, ib, status);
+	status &= ~AMDGPU_HAVE_CTX_SWITCH;
+	i += 1;
+	/* Send the rest of the IBs.
+	 */
+	if (job && ring->funcs->emit_frame_cntl) {
+		for ( ; i < num_ibs; ++i) {
+			ib = &ibs[i];
+
+			/* drop preamble IBs if we don't have a context switch */
+			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
+			    skip_preamble &&
+			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
+			    !amdgpu_mcbp &&
+			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
+				continue;
+
+			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
+				amdgpu_ring_emit_frame_cntl(ring, false, secure);
+				secure = !secure;
+				amdgpu_ring_emit_frame_cntl(ring, true, secure);
+			}
 
-	if (secure) {
-		secure = false;
-		amdgpu_ring_emit_tmz(ring, false);
+			amdgpu_ring_emit_ib(ring, job, ib, status);
+			status &= ~AMDGPU_HAVE_CTX_SWITCH;
+		}
+		amdgpu_ring_emit_frame_cntl(ring, false, secure);
+	} else {
+		for ( ; i < num_ibs; ++i) {
+			ib = &ibs[i];
+
+			/* drop preamble IBs if we don't have a context switch */
+			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
+			    skip_preamble &&
+			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
+			    !amdgpu_mcbp &&
+			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
+				continue;
+
+			amdgpu_ring_emit_ib(ring, job, ib, status);
+			status &= ~AMDGPU_HAVE_CTX_SWITCH;
+		}
 	}
-
+Done:
 #ifdef CONFIG_X86_64
 	if (!(adev->flags & AMD_IS_APU))
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 24caff085d00..4d019d6b3eb8 100644
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
index 44f00ecea322..3e83ddb64c3e 100644
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
@@ -4724,12 +4724,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
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
@@ -5183,7 +5184,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v10_0_ring_preempt_ib,
-	.emit_tmz = gfx_v10_0_ring_emit_tmz,
+	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b91686..fbde71224127 100644
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
2.25.1.362.g51ebf55b93

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
