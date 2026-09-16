Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A387C982CD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 22:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C8910E1F1;
	Wed, 16 Sep 2026 22:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XLVrQrGt";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D2110E1F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 22:55:55 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so361071a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789599354; x=1790204154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rpGcUVXOajqsOTqSE8grGg42NJEQwWOaOEjI+9gopOI=;
 b=XLVrQrGtClYufeE1CBna/fihZqGC3edf4PUa0Tbgmt4Z+Bf98nNf3X7M/dEVWf+P1X
 C/j1mDvIZKZ8CQlaZcgK3g+nKLIdbaWbMrsD6u9d4Xxsg8iGLp0ff5ZDnd1OsVyH6QDE
 O/h/7jJkxvS2kgXbdC2XjbAJnT8KVmj2OxaMkCtEpoqytuc40mKhLmObPwuDXwPl/Ww4
 Hck8Ny6dQjNJKL6NBFCrnHYcx33xtETv2o0Dsf6kEzNG/BQgClX13g2B5bI79fyGFFbB
 2JtZQWwKcoKzhDzv7yojznP6hfKj0eAtL/z8tN6soS5EsO9BJbLUsZ7YreVEb9EN7e32
 Ix9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789599354; x=1790204154;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rpGcUVXOajqsOTqSE8grGg42NJEQwWOaOEjI+9gopOI=;
 b=IawLsRUgXFmb3vmfRQyAyusDzK8Nh/glkKYY/iI5O0hhBCYlTSq9dbAZ02yplL1svo
 d+CKdHZ6J0ONbCsykA8U/FE8Q9BLehOzb2/SyqRJOy6ufbob62HQIUnTT/p7oxLPEfMn
 CO8PlAvTbZyYBo6oaS2mNi9Mu6KQTbHtrRqElKmmXetbu5BUmoFbPRUJplC3ia49vliI
 kd+sI44w4T8QWVf5Gf91vDTdQfuU1A6QXo5hCOqMukQQol7U2/Sat7TOoHztBw5ZmpvE
 Rqbbf9vH1UtzzsUczmy3ezjpGKq3uvj+8NwzFKD8an1kq8Gf4Py9kpBtFzqGdLxm6GyO
 LbhQ==
X-Gm-Message-State: AFuF++nRENX4roq0OWVxLwhz5WsJ3Odk7X0hUhWHbu0WZn3d6fTXdJtG
 2Fm2mAlZ4QsNcw2ZeG77HLPTDn3kgHICFKqM13qNTzq802IVIrmIjA5QTU696w==
X-Gm-Gg: AYBFou2gVxNCaFAosqnOqFbPiMvd8efEFmVnbqJwldPw67NAYDoUjlGmtXr3CFhQw/T
 3uL/AGk3971zeUqgSHJULAV+TRlAwSmLqoU4LLKpAITDmR16+u8KBASbsBS00qkesVm9nfHsQMd
 F954EEoFZsgDuCZkMc/qwVjnSDrC0aulQte5xmWLuvB2HftWHpc/8/A621PywEB1KmUkCtRtn36
 A7JIiKIiDqykXp+0q6DydLTKxIcBdlgdavvLkVb81PuGjvB+kxwXxkmwuU/A7eKNwu2MuLlZR9v
 ONDwFG210tDUNC8DIc6sMsf/lPs74OQQVNWytQ9L9IZ1v5flpYWUbPTKdp8f8OMg8Z2t4ICv3lq
 Dqkb3QDe4X+OOxVW54g1npzCu5vfyyLiqAq/25xUaMFjgTnSwG3lLwvSv5xojP/tZ4zK5CJm3sU
 T7m2+S7HAQ+aQAuos3/uNALOb1bAV5DhOgQKxQP3ChMJ+huqpE3h/5m67K8GhZGsOXUrG95WsnW
 GQB2HgNZHoD+P0z4i6GsAri9EmceYr9danc4WI=
X-Received: by 2002:a05:6402:23d0:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6aa221a4b92mr5288264a12.0.1789599353700; 
 Wed, 16 Sep 2026 15:55:53 -0700 (PDT)
Received: from Timur-Hyperion.home (54001FD5.dsl.pool.telekom.hu.
 [84.0.31.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d29091bsm2370592a12.25.2026.09.16.15.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 15:55:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for GMC
 v12.1
Date: Thu, 17 Sep 2026 00:55:49 +0200
Message-ID: <20260916225549.282123-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Use the same helper for GMC v12.1 that is used by other
GMC IP block versions.

No functional changes intended. Just code cleanup.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 45 ++++----------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 3349e8bc1c20..cfc46f912d47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -131,7 +131,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	uint32_t cam_index = 0;
 	const char *hub_name;
-	int ret, xcc_id = 0;
+	int xcc_id = 0;
 	uint32_t status = 0, status_hi = 0;
 	const char *die_name;
 	char die_name_buf[32];
@@ -164,44 +164,13 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
-		if (adev->irq.retry_cam_enabled) {
-			/* Delegate it to a different ring if the hardware hasn't
-			 * already done it.
-			 */
-			if (entry->ih == &adev->irq.ih) {
-				amdgpu_irq_delegate(adev, entry, 8);
-				return 1;
-			}
-
-			cam_index = entry->src_data[3] & 0x3ff;
-
-			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-							addr, entry->timestamp, write_fault);
-			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
-			if (ret)
-				return 1;
-		} else {
-			/* Process it onyl if it's the first fault for this address */
-			if (entry->ih != &adev->irq.ih_soft &&
-				amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
-							 entry->timestamp))
-				return 1;
-
-			/* Delegate it to a different ring if the hardware hasn't
-			 * already done it.
-			 */
-			if (entry->ih == &adev->irq.ih) {
-				amdgpu_irq_delegate(adev, entry, 8);
-				return 1;
-			}
+		cam_index = entry->src_data[3] & 0x3ff;
 
-			/* Try to handle the recoverable page faults by filling page
-			 * tables
-			 */
-			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, entry->timestamp, write_fault))
-				return 1;
-		}
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, node_id,
+							write_fault);
+		/* Returning 1 here also prevents sending the IV to the KFD */
+		if (ret == 1)
+			return 1;
 	}
 
 	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))
-- 
2.55.0

