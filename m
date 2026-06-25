Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4C9CDE001
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 14:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE7D10F2D1;
	Thu, 25 Jun 2026 14:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sCyQUHhL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6794210F2CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wg1NdVj+d82DRQG0tz1bwmU/jF6ULOTWhs0g1be4YQU=; b=sCyQUHhL4z/J0QrCjLi3UEckH7
 8oqr90zzHbfx9BiNozO5uuOqxXjt4juWBRw1fZrG0StyctJscyRHMV0llGgEfUBbjmT7KyGWLZuWl
 KQPwJ3iPMa+gfKr5IWTQKZe3IKC67vCbTF9TdD43KcF8xeebgki8vH6CrWfM9UIWTElyUFCkbQx/o
 ERLZ8xLKupQ61sSOhPFbdKTsESmwSU4ndHmCQZeNU8ud0pJDypTQcIVimGqHqDeTird68Uh1rehjS
 Y8L0Ad0FIISFjjrxvyGZp+wNM85Un2CU36rHOPlP2uSovwBa53kS4ZCP6hDu734pv1seDQMWt3JR7
 ojfNyXIw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wckr1-0055O4-PO; Thu, 25 Jun 2026 16:14:55 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [RFC 1/2] drm/amdgpu: Save some cycles on the job submission path
Date: Thu, 25 Jun 2026 15:14:52 +0100
Message-ID: <20260625141453.83100-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Every job submission on the Steam Deck ends up walking the list of IP
blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is like
the below, while the second half is from amdgpu_gfx_profile_ring_end_use:

 amdgpu_gfx_profile_ring_begin_use
  amdgpu_dpm_is_overdrive_enabled
   is_support_sw_smu
    amdgpu_device_ip_is_valid

On a game menu screen at 90Hz refresh rate we end up with ~840 calls per
second which sticks out when the submission worker is profiled with perf:

  13.78%  [kernel]  [k] __lock_text_start
  10.86%  [kernel]  [k] __lookup_object
   8.76%  [kernel]  [k] __mod_timer
   4.94%  [kernel]  [k] queued_spin_lock_slowpath
   1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
   1.54%  [kernel]  [k] preempt_count_add
   1.42%  [kernel]  [k] amdgpu_sync_peek_fence
   1.18%  [kernel]  [k] amdgpu_vmid_grab
   1.17%  [kernel]  [k] amdgpu_ib_schedule
   1.14%  [kernel]  [k] kthread_worker_fn

Lets short-circuit this walk by simply remembering a mask of valid IP
blocks. We could go a step further and remove a function call as well if
wanted.

I do not think the improvement here is easy to measure but it is at
least conceptually nicer to avoid repeating the same walk so much.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c     | 8 +-------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b09410d6d8f..5b3dd6c0baf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1029,6 +1029,7 @@ struct amdgpu_device {
 	struct amdgpu_cper		cper;
 
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
+	uint32_t			ip_block_type_valid;
 	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
 	struct mutex	mn_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e6b75ecafe4..e3c51ae2e61a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2071,9 +2071,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				total = false;
 			} else {
 				adev->ip_blocks[i].status.valid = true;
+				adev->ip_block_type_valid |= BIT(adev->ip_blocks[i].version->type);
 			}
 		} else {
 			adev->ip_blocks[i].status.valid = true;
+			adev->ip_block_type_valid |= BIT(adev->ip_blocks[i].version->type);
 		}
 		/* get the vbios after the asic_funcs are set up */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
@@ -2923,6 +2925,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.sw = false;
 		adev->ip_blocks[i].status.valid = false;
+		adev->ip_block_type_valid &= ~BIT(adev->ip_blocks[i].version->type);
 	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 6aa54156bbc9..d5cd3f19d2bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -401,11 +401,5 @@ bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type)
 {
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, block_type);
-	if (ip_block)
-		return ip_block->status.valid;
-
-	return false;
+	return adev->ip_block_type_valid & BIT(block_type);
 }
-- 
2.54.0

