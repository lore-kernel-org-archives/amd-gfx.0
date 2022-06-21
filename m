Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3372C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 14:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CEC10E6D6;
	Tue, 21 Jun 2022 14:42:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B396F10E6D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 14:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okd+LlOdxC1xYeouQoPt2apB05O+HuI++jCEln2lp8+wBwX41LlCHtBVLBDyacbi24rHauL9tX2Vz+f0vYrRuqTHuftO1r8xw4uloyXrP4OHuSUcQS4lMd/9E8laZjjttbLRkwzc1RtquwSnyp2Y5sVa/fcbaO6UHqkt+pUCWLboVL/SmIzA623hFMRt0Wmn/zoDlJdqlTrbRG11ezu/0kYdFS/bSj+xfuM7v6wIsWqMuEgdk0lJt8HNBh5MJu4KxfCnHhg96L8uQ56HLjBJw2GScB06a//ELHRpw4P24Fn95G9D+i9Ki6lSELy4UQKq6sxZvbdJ0YLg9amj4+mx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3mX9XCVT7l5QWS+mD/BBXFAIODlutdW5L3dYT+dI70=;
 b=hP83na4AQLNXaRu0HQvRbgMruwusj2XDaZz02PjL1C3pSOK+m8k8B77CfTPkxjcUTZ1hZxu9bz24KM0CyxPqX+JjObWRvi+h+agHkARS5kyPbvtRmhObxu/aoe23mFGQE5HAUbvzqgIzwL7fMVEVs4SkrD9gaAiiXQEn4ypxEP5xzF6nGvO4Y4bOgUWIeCQyabKPE/gJIaNsL2oEtxEOi0m0EFN/rLE2JCAdkCdH4ElCYksCbpGcXMhngm6MLo5VnD8s17PTrjBR4evROMvN2oSffmLxtPpM7WJccLlwSF0VgGuyJQJoQVDKeineHuXoQIwNxIqgP4q0nQmVodHPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3mX9XCVT7l5QWS+mD/BBXFAIODlutdW5L3dYT+dI70=;
 b=X5AWcEJ83N5h7vQqaEXzWO4VhVSrUybwrkn087ZQjjPFITlvAqkrvfmwGAPmM+EVTD3gpvtDf4PDBAVWqlrfub2FMb3TPz0ETHAHWQN/2TlYoGsOoQn7n5KXeMLWA0HsrF8N2jVzacMf7mI35kEddh67kVSQtPLyN2kWIC1fYlU=
Received: from MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) by BL3PR12MB6522.namprd12.prod.outlook.com
 (2603:10b6:208:3be::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 14:42:49 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::eb) by MWHPR2001CA0005.outlook.office365.com
 (2603:10b6:301:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Tue, 21 Jun 2022 14:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 14:42:48 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 09:42:47 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: remove ctx->lock"
Date: Tue, 21 Jun 2022 10:42:27 -0400
Message-ID: <20220621144227.664800-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <62d06aef-ff23-93a3-dc36-c4840b1f6d80@amd.com>
References: <62d06aef-ff23-93a3-dc36-c4840b1f6d80@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c670afde-0e2b-4287-5541-08da53944fea
X-MS-TrafficTypeDiagnostic: BL3PR12MB6522:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB652225B62E9703917722014599B39@BL3PR12MB6522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/UYr6bYFLru3J7bWLPfOgZHZzGJBiV5VdnUKAX/BxDeHLhGBqxftsJEYd/YVGS3K6YogD3rjuVuPUxyW8Q6CkQNzX9oXGHDOF6C3WmUNOBBx7mG1gSKAd1yRrUQg6CvoOm9jj/gcoDDUJyREZXB96yFHcF5WF4+PLk2bvCBVmIorjMvg+imk4lT1uc7YMoRDDY27MWEDKXiC1lL7G3Xkci75ZPKkF6bo0icE786do8vdeR1KPFuWnJmDdk+KnH3EH9AbMtzyXwO8QeNX61KzIYEUxiunAzjipvqWW+Y8wqB74/6yGzYPfF55tWdOtahwfQmHmWmRUnoPIT6bJVhWek37+USqEwvNezWG6Lc1bIZCgFs2emv2jYr18Oqx50I8vY09vV7t9fJvIS4pF0CtS4aN1i4pL8+6PX+inszjwGPbQL7PIYTW37bn4yijN7n77v8je23CnKSrO40zO31jwDdq71G3DptvNUWHX6O5kCml6GTDFS6b9wb7ecOaJnDlD+KfzQKCe5OxfqLot7XcIYAY/n4M7JPjZTOf0fn1nJvOv/fAiRLPKlYiu2UH94uGFSlCxPAJF8ifZ7gq/eGwF0hviehHz5HYFBfKtUoegQAQEKGpI3Pm96VAygt8UqPdjBwanO7h1mcb5N8qwmuxVf114MewPlmls6Tk9yNW7CQcMw3P7qP1XGlf/1sLeoZffyqU+Je6yfe+a9ZcjWZG0/W2hRgh+P98i0KCKnuaBfBgeTBxnO66YRnyRXDJ+j3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(66574015)(47076005)(426003)(336012)(40460700003)(1076003)(16526019)(186003)(2616005)(86362001)(4326008)(8676002)(70586007)(70206006)(36756003)(316002)(6916009)(54906003)(5660300002)(44832011)(6666004)(478600001)(36860700001)(966005)(8936002)(7696005)(26005)(83380400001)(41300700001)(2906002)(82310400005)(356005)(81166007)(40480700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 14:42:48.5337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c670afde-0e2b-4287-5541-08da53944fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e68efb27647f2106d6b545667f35b2ea39746b57.

We see that the bo validate list gets corrupted, in
amdgpu_cs_list_validate(), the lobj->tv.bo is NULL. Then getting usermm on
the next line, references a NULL bo and we get a koops.

Bisecting leads to the commit being reverted as the cause of the list
corruption. See the link below for details of the corruption failure.

Cc: Christian König <christian.koenig@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048#note_1427539
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 36ac1f1d11e6b4..e619031753b927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
+	mutex_lock(&p->ctx->lock);
+
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
 		ret = -ECANCELED;
@@ -585,16 +587,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	/* Move fence waiting after getting reservation lock of
-	 * PD root. Then there is no need on a ctx mutex lock.
-	 */
-	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
-	if (unlikely(r != 0)) {
-		if (r != -ERESTARTSYS)
-			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
-		goto error_validate;
-	}
-
 	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
 					  &p->bytes_moved_vis_threshold);
 	p->bytes_moved = 0;
@@ -722,6 +714,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx) {
+		mutex_unlock(&parser->ctx->lock);
 		amdgpu_ctx_put(parser->ctx);
 	}
 	if (parser->bo_list)
@@ -965,7 +958,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 	if (parser->job->uf_addr && ring->funcs->no_user_fence)
 		return -EINVAL;
 
-	return 0;
+	return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
 }
 
 static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
@@ -1384,6 +1377,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 
 	r = amdgpu_cs_submit(&parser, cs);
+
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 53f9268366f29e..2ef5296216d64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -286,6 +286,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	kref_init(&ctx->refcount);
 	ctx->mgr = mgr;
 	spin_lock_init(&ctx->ring_lock);
+	mutex_init(&ctx->lock);
 
 	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
@@ -400,6 +401,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		drm_dev_exit(idx);
 	}
 
+	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 0fa0e56daf67e9..cc7c8afff4144c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -53,6 +53,7 @@ struct amdgpu_ctx {
 	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
+	struct mutex			lock;
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;

base-commit: f4b3c543a2a759ce657de4b6b7e88eaddee85ec2
-- 
2.36.1.74.g277cf0bc36

