Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA09D2592A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D3E10E657;
	Wed, 28 Jan 2026 11:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CFToAxE+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480EC10E657;
 Wed, 28 Jan 2026 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vcT4dAQSUci2uKuYtPzBeZUoVC/GfqMOELZB3V9MUL8=; b=CFToAxE+R3+CK1+GneHPIKp1iq
 eCtVKrwZ43on+z4O3SAAItkFi86kXs9sakmjeszF/3j+kdd7cyunD3LrMIeqMc/sybxZN/3Cqy1o1
 EdAr1JCJMCuYIQhk/f3jE7Z3yEIAkWZqdfEtecrl1UThbrOC4EDHwHHqg3+VxJPfBSaUHf1ECGLfK
 IpOqhvSzODbsfk+lU6sLn9oV+u0MxmAwItBHE+Z72KNz7hsPo/0+F6qKgKCmLXgUVCi7l+8kuIzJH
 6GXj9AhXtxi+L5fMzzeMbfiAIzvJ0vyXb0b7mHhirakZk6m+VMVMkVhin9JUeUYOjG2PSo/3jRBy0
 9GiohG4A==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vl3P7-00Aqa0-IB; Wed, 28 Jan 2026 12:08:09 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v6 01/31] drm/amdgpu: Reject impossible entities early
Date: Wed, 28 Jan 2026 11:07:36 +0000
Message-ID: <20260128110806.38350-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently there are two different behaviour modes when userspace tries to
operate on not present HW IP blocks. On a machine without UVD, VCE and VPE
blocks, this can be observed for example like this:

$ sudo ./amd_fuzzing --r cs-wait-fuzzing
...
amd_cs_wait_fuzzing DRM_IOCTL_AMDGPU_CTX r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_GFX r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_COMPUTE r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_DMA r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_UVD r -1
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_VCE r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_UVD_ENC r -1
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_VCN_DEC r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_VCN_ENC r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_VCN_JPEG r 0
amd_cs_wait_fuzzing AMDGPU_WAIT_CS AMD_IP_VPE r 0

We can see that UVD returns an errno (-EINVAL) from the CS_WAIT ioctl,
while VCE and VPE return unexpected successes.

The difference stems from the fact the UVD is a load balancing engine
which retains the context, so with a workaround implemented in
amdgpu_ctx_init_entity(), but which does not account for the fact hardware
block may not be present.

This causes a single NULL scheduler to be passed to
drm_sched_entity_init(), which immediately rejects this with -EINVAL.

The not present VCE and VPE cases on the other hand pass zero schedulers
to drm_sched_entity_init(), which is explicitly allowed and results in
unusable entities.

As the UVD case however shows, call paths can handle the errors, so we can
consolidate this into a single path which will always return -EINVAL if
the HW IP block is not present.

We do this by rejecting it early and not calling drm_sched_entity_init()
when there is no backing hardware.

This also removes the need for the drm_sched_entity_init() to handle the
zero schedulers and NULL scheduler cases, which means that we can follow
up by removing the special casing from the DRM scheduler.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: f34e8bb7d6c6 ("drm/sched: fix null-ptr-deref in init entity")
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5c344665b43c..c8a9af36f53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -239,6 +239,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 			goto error_free_entity;
 	}
 
+	if (num_scheds == 0) {
+		r = -EINVAL;
+		goto error_free_entity;
+	}
+
 	/* disable load balance if the hw engine retains context among dependent jobs */
 	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
 	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
-- 
2.52.0

