Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A5BCD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2728E10E74A;
	Mon, 18 May 2026 09:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5sdup77";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2816110E09F
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 13:18:01 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8acb09ddbf6so32440706d6.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779023880; x=1779628680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8qmzV4OG/gwgrFg2WjVRa5yFfeYJiaj+u8zvgWP2oxA=;
 b=R5sdup77L4kbL+l8/kbVMfHt21OiXaBTOg0BH6iK9mgMGCChhl+7vf6JTKCdIzTX8g
 uK1kYo4wJ/EcXuIYMOmMeJ6jMlD6ktqu8zrHZ7DdW3rHf4eJDHfpo5yxgB7g0Cusgrw5
 99aS/HRvr845CtRSAmheI5eTx5rx5dVegxHILKtMUtKjSfb805eIdB+tcrI8HIZ5uXNY
 5CD+JrFXs6M1Hvk0FToZ/YfJve9oTrbodWcZwv8mEdgy4I3bx3r7yKtTR7M6nJWyuBac
 zj8LwV89qNqoaYVbdFfi9oRsnQrXqWx+WpKdSsBhaP2imGJSREff8i9fCFKgzrhIxR1y
 BBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779023880; x=1779628680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qmzV4OG/gwgrFg2WjVRa5yFfeYJiaj+u8zvgWP2oxA=;
 b=SE5Vf2Wk3dxEyGWKkrp5/J48n71aKk6hYqlUv3clLsNcYp63gqbDE7kMoYGvATuCV8
 cDWkwc8oy02rw5RitfEiLEFae+CLtEaqFpDdC5yJwn9s2H6HDiDxXuzRmCDqnYN/MA2D
 Z68o+x5tao0kh/XRNFnDcz1+H+yrPhPhf+nAW03bkrcjJ1rUkpOMxuFwm3RxY8E8EFXw
 +IGNDEpfX8nusf2Rusxm7rnGJ9e6CbK3zXdm5G1IivgSnBRquN0ME3VV5XpeUeQs6SQJ
 0c12xMnsMV0RpX2qoPiL4U6rnDBfmR6Hw6ktXAuwkFW4uD62W+cdZr15rdoLo6osZ2MX
 NK7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sV7iymIhG0tPPau3RFR5t8LtY85Cyk6Y0mFa5nOjF7+dLC85NpntcW/Q1Jp6yvtS1+dLfnJvK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZYFIT0fQTctZrl9JkTQc00dYVFLVEV5DwU5kmfDEnOIyttwNx
 MMxtGw78WpS7lwU3mU1Mx9hSE+ls95sLTvVXTlhLl7enAiULDEb/dL5r
X-Gm-Gg: Acq92OFnY1Kt+qSFkuJlI9lvTqjFLDr7Lr/BEh5PzUU10k5hgNHJ0z3bSjNpjj0h66s
 8+nSvDDJlTCBB55i11vmDhVP2/gFdRdZnznp4r6fsdTFLypmbsQ+HzA1Ez4Qo2WrvT21GCCf+jS
 5faZRNAFB+VPM1Vh8GizrpkRViss6EhEybQzJg0zTeom1LqYKR7RKBfjLUglwaPWylDEO3zJuhB
 umHFHQGi2gH4rdbpedT+hwOPbuKq7BOwI3Eg81V7V/5rLpa0OqUBHcRtFUCWtBqbs881iobOfCt
 XBWGGxsfpQWmVmVrrGA3rc1NrcphmyCu/lyFjgizj/J2Te9SSgVBkI75S3rZYjnXVxearoYewWu
 HByQ/gvXW/VJoiMsUHcfbs/618FdRVbpN/xU1L/VnnNbSbng+9cg1nO3PB5TK7ar1LMk1+4KhfV
 kk5PDsnUTWbCwBVZ0kmw6ey4YpED/7IN/jUTC8m/SsyJP0qLzmMQMzBJbSo8hmy2w2GrYV63xL7
 K9VjyBK8uHLlujFVwTfOHeL3cpEpeFfFaIYC083p/Q=
X-Received: by 2002:ad4:4211:0:b0:8bd:6baa:6a0c with SMTP id
 6a1803df08f44-8ca0f611b62mr138164296d6.11.1779023879979; 
 Sun, 17 May 2026 06:17:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619c703sm22268846d6.33.2026.05.17.06.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 06:17:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Francis <David.Francis@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] drm/amdgpu: fix lock leak on ENOMEM in
 AMDGPU_GEM_OP_GET_MAPPING_INFO
Date: Sun, 17 May 2026 09:17:42 -0400
Message-ID: <20260517131742.3435209-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 09:33:27 +0000
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

The AMDGPU_GEM_OP_GET_MAPPING_INFO branch of amdgpu_gem_op_ioctl()
holds three cleanup-tracked resources before calling kvcalloc():
the drm_gem_object reference from drm_gem_object_lookup(), the
drm_exec lock on the looked-up GEM via drm_exec_lock_obj(), and
the drm_exec lock on the per-process VM root page directory via
amdgpu_vm_lock_pd().  All three are released by the out_exec
label that every other error path in this function jumps to.
The kvcalloc() failure path returns -ENOMEM directly, skipping
out_exec and leaking all three.

The leaked per-process VM root PD dma_resv lock is the
load-bearing leak: any subsequent operation on the same VM
(further GEM ops, command-submission, eviction, TTM shrinker
callbacks) blocks on the held lock.  DRM_IOCTL_AMDGPU_GEM_OP is
DRM_AUTH | DRM_RENDER_ALLOW, so this is an unprivileged-local
denial of service against the caller's GPU context, reachable
by any process with /dev/dri/renderD* access.

Route the failure through out_exec so drm_exec_fini() and
drm_gem_object_put() run.

Reproduced on stock 7.0.0-10, Ryzen 7 5700U / Radeon Vega
(Lucienne): the failing ioctl returns -ENOMEM and a second
GET_MAPPING_INFO on the same fd then blocks in
drm_exec_lock_obj() on the leaked dma_resv.  SIGKILL on the
caller does not reap the task; the fd-release path during
process exit goes through amdgpu_gem_object_close() ->
drm_exec_prepare_obj() on the same lock, leaving the task in D
state until the box is rebooted.  The patched kernel was not
rebuilt and re-tested on this hardware; the fix is mechanical.
Tested on a single Lucienne / Vega box only.

Ziyi Guo posted an independent INT_MAX-bound check for
args->num_entries in the same branch [1]; the two patches are
complementary and can land in either order.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260208000255.4073363-1-n7l8m4@u.northwestern.edu/ # [1]
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9ef80bca4102..8224fb499fdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1091,8 +1091,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		 * be retried.
 		 */
 		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
-		if (!vm_entries)
-			return -ENOMEM;
+		if (!vm_entries) {
+			r = -ENOMEM;
+			goto out_exec;
+		}
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-- 
2.53.0

