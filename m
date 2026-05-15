Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB9CCD4F54
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABCE10E74F;
	Mon, 18 May 2026 09:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="CDjLuGz5";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D1910E61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 13:59:42 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-902deb2412fso1022531585a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1778853581; x=1779458381;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=45LaM1Fr3Zq3iiITdQvbYZ1is3E5sWAW6nvjjI/+KtE=;
 b=CDjLuGz5Ya0jCD27U9MXyy2R4vF0oDP0hFnFcM1QTU2rpHgYnYVVAFLp82csxRA8sI
 9G+ORGsatLf+Ds/qnez4zP6aSKVdob0bKsF8xz/gsswqSXXkMtl5oqNjYcwzT2BR5+6x
 HZo2DaZsZtmm5r7q2Rsm8nVvFbhrpcOxHIPWFBlch9FomhGUhhz6h9DTyQz+1dVGWCT3
 Bd9eZUtzeihDLjzuHUtYIuBt8OiOuZgsi+xY5Gi9J+34vsK8ExptOF1E97I2g4RyMoLQ
 zIHXYUdYWxRV962Yrse4biIEdNGjD+ajiJtR5pnejgJ+bBdB9dcRvVp93C2yqahRX536
 2ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853581; x=1779458381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45LaM1Fr3Zq3iiITdQvbYZ1is3E5sWAW6nvjjI/+KtE=;
 b=CjyqdgJ8B9URhyzWzlhjskOpcGBXLHVpzl0/Tm2uHSKSSm5KtUBlimfGE/BZxb+mvf
 6AjtrDZZJLDf2kRt63SlC+LdlU0hfzydlWaXD1I9xHg66AqlR+HktSpiaJ2XUhm+LQVE
 va+QzYJ5zTo4098pOG7k1MeEBCZBLMA4dPIaKAM2ncgJyzGiOWdldAOMTnmZvs9vliRa
 7waTXVtTB6Ag4swkO9KMm9cuOuipSx7y/OMSizGlQHrfm1hSrO8vtPdOcQqbq/ezi8bA
 cJgrx1h8258bTbrP1AOuLb0rRwNmrmmOQBaWQxNLKrEdh1Red2mgtxWVoRgxCkA3LVPR
 +GIw==
X-Gm-Message-State: AOJu0Yx12JDI/FdRkcLbQg/TrVRBdvmIdrjRozWkvXu8a6Lr4CJX1WH9
 wtf77gVBqw0kyv7dmKsMXKcoy7LRL6lUU0O7GLSijJAZH0Yvqe/tgkc1SicetoH55gM=
X-Gm-Gg: Acq92OE+egoZBhdIMSU7d+JTW2xHPViNknFZ+5GOpsUUW3Y+R12QfRIwcwoVLOiiV9V
 wEHmQ1t70cxh0Mko2/gvwuvzZMdebwa8INU3mgzJU5Xi7not2E2hShsltdVtBGNGrn8TtTgn48W
 HJ5XOt3X6PNmzzMMMhCtTC/r8cmiqgfh9ZeopB858Utq+8SHNtI0OrgVOo4dh7l8r2EIEPoJhia
 b41ifiCK5ydb/IFXbHW3ZR1IK6zx7hqOz3YGswy4pYS+dMwEcELQEd3elBDHqBLe2KGy8dOPVbb
 ogfOCLbrxbnc4vSgYgG+58KkZizdXWU4wUNHXN7NZVV15JJDcvrkt78SO0KyBIIpw5lqfXFcq7V
 WCxKXY20GRSZjgXOqbTEz3jeG0f0ig9Dw52EsqBFKHKzrRDppKQcIvmvrQcQS+Q/l2RenOJpFOC
 OQ3x90B42dNPz60eGlyRaWIZazWEiF
X-Received: by 2002:a05:620a:29c9:b0:8cd:9665:9eff with SMTP id
 af79cd13be357-911cd46b36amr659332785a.21.1778853580911; 
 Fri, 15 May 2026 06:59:40 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd02f12dsm564638885a.40.2026.05.15.06.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:59:40 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 06/11] drm: Use trace_call__##name() at guarded tracepoint
 call sites
Date: Fri, 15 May 2026 09:59:32 -0400
Message-ID: <20260515135932.2238842-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
 drivers/gpu/drm/scheduler/sched_entity.c          |  5 +++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b24d5d21be5f..cb0b5cb07d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1004,7 +1004,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_call__amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ba9de16a27a..a36ae94c425f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1415,7 +1415,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_call__amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2183,7 +2183,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_call__amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..fbdc12cdd6bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5263,11 +5263,11 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
-					   user_brightness,
-					   brightness,
-					   caps->aux_support,
-					   power_supply_is_system_supplied() > 0);
+		trace_call__amdgpu_dm_brightness(__builtin_return_address(0),
+						 user_brightness,
+						 brightness,
+						 caps->aux_support,
+						 power_supply_is_system_supplied() > 0);
 	}
 
 	if (caps->aux_support) {
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be..185a2636b599 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,8 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_call__drm_sched_job_unschedulable(sched_job,
+							entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +587,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_call__drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.54.0

