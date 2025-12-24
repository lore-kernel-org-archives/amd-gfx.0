Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CC0E77361
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Dec 2025 15:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E091510FF49;
	Wed, 24 Dec 2025 15:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="GjlchcBK";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E9210F87E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 14:47:17 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so4756566f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766587635; x=1767192435; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hj0iAOC3x7YMFIhG9hf7cZjPZjj1pyUiQuk+2YzLAvQ=;
 b=GjlchcBKAFCOlfFh7j4MGg81Euxc9HCzhPEtGyrQgHegPWVC9rtpAp9glFSyW9AVSW
 zkoZZaQQsWhgkeRI7lOab83h10UfD9/0ER+tW0elYZZKTJ41Ylb8pczhvd5gVrMTmrVw
 Se79evecAc6b6VRxt805KzsLusUpEutWfSEB/q89ERXsuBg67MU9SBm0QEbuGaoVttWx
 4wXDHOoQ7AqpLNd0av5oRi0nPdT4oEt8Hqxi27Cp4WUoVGtaeTFELJ/4ap4R+odF/KEL
 8VMhxXk9fazy/h8qFqzzXuC5loO4HZ2hEWc6r+RFMQcHm9LqBzLtMtauS2Vk25BkZyye
 iXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766587635; x=1767192435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hj0iAOC3x7YMFIhG9hf7cZjPZjj1pyUiQuk+2YzLAvQ=;
 b=rFASV+QRmWj9T3sxuqzVb5NzrX/ACMR4Lc6Bjs6RnhQayAtfhYws6v7QfUVMI0VyXU
 y+rX7B/UePsfcHQYkFHXKUefUY2YanLtCa1WMF/VF9+5Vemuf9F0kunJekMFQ7EsmddI
 6dI2ZvYZRNHeRYIG/akNpbLL18c/vG+mkaD67AL8zIEnRVcT1NzRfpITMZc7dXcbZgbD
 +A1JXphP+b3aAbpLxybiQxBSIDIfvNWH9dE3hJ/Ybld4VHrg6kFAstqiXxidsAhhpNW8
 ueRmxElTCuyIgrvtVp0NXCnssCAkJPnVsoFI3ZInSZTDhxV7pCl7PNhDYmB94UI7EK3u
 R7qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq1ay1pBsoX9PaM8IVMSfknZjI22I3fxUHX5eKzKBPx5WCmAzM6Kzf5DHybGn8exreVgs1TCGJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz95OEjHojLVCDq2kcfDtzItZwRLyi/Yzf2Cm0b3h1QHpSDn1Sj
 sft7j25O/dZgkwOGHCChAXUmYDjKrARl6FfxDZt0miY8KXomkkjcE/I7a4bmbivV9cU=
X-Gm-Gg: AY/fxX5OAA1clEy1IZ45v/OoRI2O9flyRWV3aG5OTe9AilvU+sVIfeGM7EiBVs0KZdQ
 jcDvyFTqwcLs3xfkNOV4Ju5lAC+Wxy9/ZmHthWCphMuDTh5eNjyFdTuaReifsgzQqfiw3jXd1pI
 xYnTCrpaiHuX9Nlm5DTpjxozYaCBtanxezKRNaxlTxP6TbQ2OqnAfwlClyWGK4hWlFXc/9BuT4t
 4GOvEQ5RgnIIcqGCVW3ttisvISeh0HoIi76xfBJG7JPYHYaZ2vkcLsILrHnPks/bh955xmfDhlc
 tEHedDCTAcUl0pBHJyqgNn1y76u9nvCU5fupQo/CSOKyAJp8fiVcNarjVsUfm4okl//ifMQYgeY
 mLJsNgUecHKEwQhUBOvL/o/oNBTyNlyXpHSxurChmEZZH4eqZ8SZo9h27TbY5tuTfBGfJbgQWc7
 mze8rEIgVH6aOuDb3jFSQ4lPFx3IwCGZ0IVvo=
X-Google-Smtp-Source: AGHT+IF+pEHq8l5EIBnNkchakW8xGfUXFzadra3xxwPBkYTZLxRWsB6KafEKjh9p5ZSsVQDQvBxmXA==
X-Received: by 2002:a5d:5f87:0:b0:431:327:5dd4 with SMTP id
 ffacd0b85a97d-4324e50db43mr19052616f8f.46.1766587635608; 
 Wed, 24 Dec 2025 06:47:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm1041109f8f.6.2025.12.24.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 06:47:15 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
Date: Wed, 24 Dec 2025 15:47:05 +0100
Message-ID: <20251224144708.61167-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224144708.61167-1-marco.crivellari@suse.com>
References: <20251224144708.61167-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 15:51:46 +0000
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

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index daa7b23bc775..a7bc65099755 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -179,7 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-			if (!queue_work(system_unbound_wq,
+			if (!queue_work(system_dfl_wq,
 					&tmp_adev->reset_cntl->reset_work))
 				r = -EALREADY;
 		} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 12201b8e99b3..2ee416c36ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6173,7 +6173,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_unbound_wq,
+				if (!queue_work(system_dfl_wq,
 						&tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 28c4ad62f50e..9c4631608526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -116,7 +116,7 @@ static int amdgpu_reset_xgmi_reset_on_init_perform_reset(
 	/* Mode1 reset needs to be triggered on all devices together */
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
-		if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
+		if (!queue_work(system_dfl_wq, &tmp_adev->xgmi_reset_work))
 			r = -EALREADY;
 		if (r) {
 			dev_err(tmp_adev->dev,
-- 
2.52.0

