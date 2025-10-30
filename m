Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB64CCFA02
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAAC10EAC2;
	Fri, 31 Oct 2025 08:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="XRmxI93m";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803AD10E9FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 16:10:23 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-429b7ba208eso605986f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761840622; x=1762445422; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTPZsf+rmUI4vnLNPtXQcosAXrq3VoTes6fLwzo6HcE=;
 b=XRmxI93mrTuGbcdCnRfGmYR7ChhMhyuOajQUswq7KgEmahzCQWBWhRTqh0YeZHcytR
 rAutSOIbUXLTNQo/kBAKDII8ZRv/Oo5VVCcktbK2nzEC6VlVCnDZMyvWweaYm0TzWPXR
 9uuUQvMVNbzqfKhoFSsE2iloez2rJVFTpp7z+n4SNQuzK0PzNHV7mXJ+wXtSHMXUgro1
 jaR8bQ7c5k8BfUc7SxQ5NzjvvFtMZuNM2/c3g8L58BB7nTyWq9DcLSM9p5HhqLflpmdh
 xonsdLiYru54t8jOCl0kBcdl6toeBPDx3DcPg3qHhdv3eO9N0UVjzrRkyjBhZrW3gKs+
 DNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761840622; x=1762445422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTPZsf+rmUI4vnLNPtXQcosAXrq3VoTes6fLwzo6HcE=;
 b=MmapfA/UGAfTODsJ/2IUJbPr8BVaTcr6jBi7p+XBVrLEKYbXgHCI6iA3siZwHPszwb
 T4v2jeg71g8nwNmOqlVsbQqG9sO+Ks5zYPwWkWYL1dzvMIt7h8DkFQBHcP2PLe7KaZvJ
 OPQGTbc7InLhcwQl/sF3qyXR831ZgIg+NElfPlVzjBGsXfdg+P1mDgrRSIznKdVauik8
 SnAMwps7Cjdq6JvGtw/hmX57NYVmPf4ea9n5gW/BVnoYRTAPOke/b+IIMvytGI+mugwA
 iAYvfBd2iR2DVE32lRXUM0IRie0zq5dKy7Ndrna5O/4OXASkHt3fFNX6SDD98E0/NVCP
 RSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8O4RhJw96gX2uTpNNbWgG3ecQBKadbMKJ6qBrZdsTXsSTm4pQKCMRgrYfcQSUaSQxO+wnDJgi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydxksVAVCssOIube6fUFeoEe7IpkG+V9ax4y9IbAMu32Qp3NoJ
 SIV6xXuhdDAZxXHPdV55qoii6pKgS20dIc0+ZqaTvvU3z3bari6GPfMdY37iDm78jlw=
X-Gm-Gg: ASbGncviYi+ukc3OWFzNt8XjE4tonpqjb2bFGK+Ln4Aw6FG9KQ/iDJ0t8+ScpyaAF8A
 EG8LQ711gnHcsGgAu/ufsm3WngWP92Fwh7EC/bolF/juHKOVHSz7dDtTlwTk8gOlS+GcIzUn2xx
 T9HqELUwojqrZDDCaoDv4KQg+Ygy3yazIQGSt4djlYZS9XMrm72HpCKr3MXhmwODZxSOJTCAtOT
 FECQ2HZsas56OEhCQDUjyXPBdv05xUEewqpLuPOV0/uG7a1kO1bwnzwVqidrExjZkbbAjUmBQ+l
 Wf5Crs3bxLb1D+dILuqIj1TK4isrTPRsqW9WJmX/kEb1g8mtWoTzg1DB+m0hQylTqSfQXPhMSCr
 c1cNBLzjK5RywXsqwWKdlwAZYWhkLLDbOlmPcErBQwrgjMCrK+yJkv4Z2CLdTMm/LXj1wLE58E3
 xeE0HJOgM3zlS62+EcA0ZmsbkuEg==
X-Google-Smtp-Source: AGHT+IFyyXNW5PdLb1EAji6FZwxk9z7oFuqaX4IQuCCEMfZdy25gAvQgNKkIYiereVgd1Zd4VZyqew==
X-Received: by 2002:a5d:5847:0:b0:427:7cd:7b1d with SMTP id
 ffacd0b85a97d-429bd6a4d9fmr100959f8f.40.1761840621896; 
 Thu, 30 Oct 2025 09:10:21 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:10:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
Date: Thu, 30 Oct 2025 17:10:08 +0100
Message-ID: <20251030161011.282924-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030161011.282924-1-marco.crivellari@suse.com>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Oct 2025 08:12:39 +0000
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

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 9569dc16dd3d..7957e6c4c416 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -175,7 +175,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-			if (!queue_work(system_unbound_wq,
+			if (!queue_work(system_dfl_wq,
 					&tmp_adev->reset_cntl->reset_work))
 				r = -EALREADY;
 		} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..8c4d79f6c14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6033,7 +6033,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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
2.51.0

