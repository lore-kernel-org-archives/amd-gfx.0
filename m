Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57A0FCB632
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C038A10EDCA;
	Fri,  6 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Jk12TY/b";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AAC10EDC2;
 Fri,  6 Mar 2026 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jmgO7N0zsIdTQUJwDxnVeD5XF/zTCefkjTgJxR1USaw=; b=Jk12TY/b2M+duROhN3/ImGDTj1
 UMQ9oRBQSZIqByAFly3tsC5gyobcntk2K8w5wnvoUScElTdpSlKPlp1X3kR+Md1V3q8sg3sNMv/yv
 wfsaB9LjSheopP6Ohvq5d8cUdLmVnj9zfezbaRvEwxg7If+sb9XTfSTEIgSqA+iEg4SoFejZxDyDT
 Mphnh2eSVvu9c6R3YbD5C/Ib7v9ky8qFMNXIyJkT82GF16HMJTlySflRJzauUIlzxAlq01fhnpHox
 eUbnglG2+JwXExuT9rcQWn/R9PZEg+goWklfjobNaWRIe49g+vVOyTR/wF3FY67zkSXtMoow3NVet
 lOCt23DQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vyY8r-00APX7-Q2; Fri, 06 Mar 2026 17:35:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v7 25/29] drm/panthor: Remove drm_sched_init_args->num_rqs
 usage
Date: Fri,  6 Mar 2026 16:34:41 +0000
Message-ID: <20260306163445.97243-26-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove member no longer used by the scheduler core.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c   | 1 -
 drivers/gpu/drm/panthor/panthor_sched.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f8c41e36afa4..63eab0927303 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2413,7 +2413,6 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	const struct drm_sched_init_args sched_args = {
 		.ops = &panthor_vm_bind_ops,
 		.submit_wq = ptdev->mmu->vm.wq,
-		.num_rqs = 1,
 		.credit_limit = 1,
 		/* Bind operations are synchronous for now, no timeout needed. */
 		.timeout = MAX_SCHEDULE_TIMEOUT,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a70f1db0764e..675aa98caa7c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3487,7 +3487,6 @@ group_create_queue(struct panthor_group *group,
 	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
 		.submit_wq = group->ptdev->scheduler->wq,
-		.num_rqs = 1,
 		/*
 		 * The credit limit argument tells us the total number of
 		 * instructions across all CS slots in the ringbuffer, with
-- 
2.52.0

