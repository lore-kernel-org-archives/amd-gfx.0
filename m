Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8169C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 08:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B8D10EA1B;
	Fri, 11 Feb 2022 08:24:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7130A10EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5bI8qhascBb8Cs5LErqzTgP1/SD22rOMRIwYXDABIoWtcptdNIstfKwXXxOp/hMPfQ1hkx6hkQ90TcsiTsPuZC3AIns7+r1zBrhC4O2FHRatqdfESZ/AxUDh7LAKSH0mlks1bTyhLmD7VaWbS5ka5kdK/0wSpH+jlKEuMifAIF90g/fadjvQ0n7dPW80e+rvUOH3mpcIBTL7jC06F/PPMPSq2L6Rd+wrBOk7NpuE2VvczDUhEcXnY6CuL7k5yTOVpg8yhcKD56/PXdH/qynLu6kib6DfXkSIlpRYBil+5FAanW2n72+v14Y1XjPGrJgKl2HzCCNVNISj5BKBWV87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEwTLZyc4DsnRlns+Vk/5vs/hmZDpd9ng/W009WxT7s=;
 b=FTiP0O47yBmU6+2AL2fNLiIe4F+mPB9FQrA58Kr7BCIY68pGC9x3pIxBwVxXP8+5B8skRKKt+I1KvpuFHcNh6Swwy4CNEIbbxmXMvUUk3q2560L2LAqxvLgOVpP3wyFCrYEaXQRNbhhMtSy4dWurPhwZQnvC/8S2umGpOuNRAlUOhu1YAvD8Y0K000YuQO+U/Gx8SjWX9oSyasurBNkoArVrbIWFOwS3MBDjUVaAbDHNPaZ8lx2beD1d4PcpPx7wlpQyiQIf3nNcXXpU5Q24vfdmX+mo+7kos61JIv+ZSD9FRlzSWBfjMRLuz2YuxFrnYV5p9nNRBfFRIJk6u9b5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEwTLZyc4DsnRlns+Vk/5vs/hmZDpd9ng/W009WxT7s=;
 b=bvQ2r0e+ATe4txxz7Z15hf/KNVVWxkrWEn+rdmxYiuI5RoUO4GPhoEt1ca2zdYwzZs1p/tBa8JRUjGU4LV665C0IrP4uULcrcta2vMsC4+xKx0n2Ji870utq95F3frBqhhNkMAT/3SsGffVpfhTR6fqHO2wELEhIZi0aDMWEGm8=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.14; Fri, 11 Feb 2022 08:24:26 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::a4) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 08:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 08:24:26 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 02:24:23 -0600
From: Ken Xue <Ken.Xue@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>
Subject: [PATCH] drm/amdgpu: remove ctx->lock
Date: Fri, 11 Feb 2022 16:24:10 +0800
Message-ID: <20220211082410.31186-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f83b2c7-bdb9-4135-649e-08d9ed37ea70
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686B53BBF68679B63ED2B1EFB309@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lx6Wh74uyYgD0BasP8gxJyGd2Ks2qbZDjOamxtHsBW81pEBiYl2uu/+ND/qxK9SmYsQFYpBUyo09q3+E1idR6u2k/zO1tDHe1aErRHrWaJA4F2Z3cL5RzgdzcGzneY32jvTa1Vj99zm0BdnuKTRlp7Uf+JDkIbqrl81nnGnAgkxiKCawKmwHWWVaZUlAq5pGGN705P2bbzJOk8tyQxbW6JyzGc95V6LCa5rienqkqmq6atEOVTpIGIw5EUh2R7exi9I5GE7o+jWaTffXb2zljzdqtF7SJvPfNTgWOSrcUdt8+zcLUAFNr8u4tzFED0XNV9CmNzUqkly+obqrcrbq1jY65Ehk3NHJ6wQcFhFIq+SCI+TvmZDIz8wuybwkjMQJjf1+oUV8r5OdXn3NgWV5kuxtBG8j0fkeVYSGxeQB/sp38TTEBv8mzCEJSsKLCPMR2Qk36y5Q+Z6iD66cwU7/xLW0eBkKWQtSe1JMHaAv6DKNLWBeT8wPqGSS/vBvUpvpr0Ra5k2S+1gPxguNjUAMGb+AcYrvA/fD0GByu1zjY42bqUfJwobaVgRWVA+b66GEgnN9BKEzHrvFBmPMKeOhMkvvnls8mMV7mV7zTdVmHHCoYW4WvTb3dtU5OPL8P9XVoToIY/IB67VHaUh3v5hYqbkQ9Wt/QuOnDTzoE6mN/76IBvaTdwEXzzN5HMBiS7DXr5LaY3f4egESbc6xXJhkFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(36860700001)(82310400004)(40460700003)(2906002)(356005)(6666004)(316002)(5660300002)(86362001)(6636002)(81166007)(110136005)(26005)(47076005)(70586007)(70206006)(83380400001)(186003)(336012)(36756003)(426003)(4326008)(508600001)(8676002)(16526019)(8936002)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 08:24:26.0760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f83b2c7-bdb9-4135-649e-08d9ed37ea70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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
Cc: Ken Xue <Ken.Xue@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD reports a warning on holding a lock from drm_syncobj_find_fence, 
when running amdgpu_test case “syncobj timeline test”.

ctx->lock was designed to prevent concurrent "amdgpu_ctx_wait_prev_fence" 
calls and avoid dead reservation lock from GPU reset. since no reservation 
lock is held in lates GPU reset any more, ctx->lock can be simply removed 
and concurrent "amdgpu_ctx_wait_prev_fence" call also can be prevented by 
PD root bo reservation lock.

call stacks:
=================
//hold lock
amdgpu_cs_ioctl->amdgpu_cs_parser_init->mutex_lock(&parser->ctx->lock);
…
//report warning
amdgpu_cs_dependencies->amdgpu_cs_process_syncobj_timeline_in_dep \
->amdgpu_syncobj_lookup_and_add_to_sync -> drm_syncobj_find_fence \
-> lockdep_assert_none_held_once
…
amdgpu_cs_ioctl->amdgpu_cs_parser_fini->mutex_unlock(&parser->ctx->lock);

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1cd677bd5d7e..b32a7cfbe1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -127,8 +127,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
-	mutex_lock(&p->ctx->lock);
-
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
 		ret = -ECANCELED;
@@ -571,6 +569,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto out;
 	}
 
+	/* Move fence waiting after getting reservation lock of
+	 * PD root. Then there is no need on a ctx mutex lock.
+	 */
+	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
+	if (unlikely(r != 0)) {
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+		goto error_validate;
+	}
+
 	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
 					  &p->bytes_moved_vis_threshold);
 	p->bytes_moved = 0;
@@ -682,7 +690,6 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 	dma_fence_put(parser->fence);
 
 	if (parser->ctx) {
-		mutex_unlock(&parser->ctx->lock);
 		amdgpu_ctx_put(parser->ctx);
 	}
 	if (parser->bo_list)
@@ -926,7 +933,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 	if (parser->job->uf_addr && ring->funcs->no_user_fence)
 		return -EINVAL;
 
-	return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
+	return 0;
 }
 
 static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
@@ -1321,7 +1328,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto out;
 
 	r = amdgpu_cs_submit(&parser, cs);
-
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2c929fa40379..1c72f6095f08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -230,7 +230,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 
 	kref_init(&ctx->refcount);
 	spin_lock_init(&ctx->ring_lock);
-	mutex_init(&ctx->lock);
 
 	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
 	ctx->reset_counter_query = ctx->reset_counter;
@@ -352,7 +351,6 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		}
 	}
 	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
-	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 142f2f87d44c..d0cbfcea90f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -49,7 +49,6 @@ struct amdgpu_ctx {
 	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
-	struct mutex			lock;
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
-- 
2.17.1

