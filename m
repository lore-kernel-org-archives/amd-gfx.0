Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4E41067058
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC9A10EB44;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="X0iHErfK";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D571510EA30
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 15:06:06 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d77b179b52so672639a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773327966; x=1773932766;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8m3myjjGE3NHxUw5Y98XcFvEZdApgquTYgyBVq6daI=;
 b=X0iHErfKLdoDKEjF4wjQup9gaZOvMNsjZ9TMNmuKWN+Q4yMJmVr5HI6DPhPNsnVKYu
 oUGkmvzUDT12k19iHsTLMLH45MlCmcnLfKDcqE4O4DRQoSfZiPVL0kZAjIGq11r+ifCn
 56vP5o6xW2cOcnCXtkOHkruH9Cs2ONVPK8YhPjqnt/BiQ1wvpxUGwG4QbaSO30pWKsJO
 VRwXz2SnCeaekvvNNh5q6xOFdhV8ZB4n2JDzbVN3OfosrbCfZhXSlFfBVkA/F3aHhkqK
 QXZsm+qcyFspPesujnpvQ/z2PcGnJEcrcFr3WdMAJc0jVSELirL3uNCbJnR9RWiLnrCv
 +s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773327966; x=1773932766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8m3myjjGE3NHxUw5Y98XcFvEZdApgquTYgyBVq6daI=;
 b=ahYf6NRGNXII2sCGBmcG/3BWf3cbcDMPodkbm8z3vZsZ7LhGIsU4CQf/7CJ9T1Sn0S
 ixiRqZBmX9aY1pF9u7xeu83MFTYfUjLGS7Ki0ZQGiFuIIQ9EGDUrjLq4pUuOxH5lGgVx
 IZ0JCD3aarzAgU1rVrkiLwy22hIQOzuz2FQBoUziwlaHp+Z7OCaE027X5iYBDmCkakDa
 Bx/7gTFAaLgKxaLR2IH+IoBjqpjagDljAXUAGoGTkUXbOP+6z4IlxezTBq1YYhZqbYc+
 5vQQ1UfsSekqQCc+4RgsC2IzzX8orHA4bIi67IRrKVGomZcEZaWyoMPxwlVI7HyuXvsO
 cgGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyYN2wBC4FhkCAd1vhW4dlRHt/B7DU+Fuqq5OJ9jS+6+HuAsVEaHMjT66CoCiylR5W4ZFypRc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNdt0YxpbnKI3xLMqkEy5Q68s7/kRUJ491oE0OvH0TK5PQfvqo
 +WFig+9dJT/L7W2PEGFW5x7vH515iEQkddlmvRSZLucVizxuk6RnlU9XxoaJNni8ZF8=
X-Gm-Gg: ATEYQzyXmKPRwLMeHKugeZwnPtvLagZFgWExhxnH1a5W1yQBNJD87pyZGf0jr+HFSuT
 pSXjkkguvV/fgeSgB43cGUEoNg+fJEBVyxRRUH+BgUqq16adqS5Uv8R7rOGdATn4tC9N4PaxsA0
 WH/Xl6OTvMYHf9ba2kh6rUgMsnLn6RVp6ZLNKeMN0ATvGQpMuDdqSVqPjnEmmkJP5K3WcRwE6jE
 JuBUu6aKJ0EN5ccapbwDFNXNL0JMjX5m1s2YpA58+c6KB2Mjrp4aOfrHNWDe9ief2awrEzEVCQw
 EJaGdQEegoPBQIpwIuJU+4e6SWnrMIAHpz9UE94Xu5khMC5UP61GuG6vk33+jdSsnB5vMwEyEna
 rH1lteR/MG6Afwm4G8oW/B3s8TEnwmTGq9U6Bj7OpDXKuFOpEoSKdP1AYdnIFQr05QyStJIhBf5
 dAAMTrDIvWZuvd0YFj5DfKRcZimPP+5+bzFmyboWRrX+jBC2IYT0vkqZymjrsVL5YkXA==
X-Received: by 2002:a05:6830:4107:b0:7d7:466f:b2fd with SMTP id
 46e09a7af769-7d76a5a470fmr4892471a34.2.1773327966007; 
 Thu, 12 Mar 2026 08:06:06 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:06:05 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Liu01 Tong <Tong.Liu01@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Kees Cook <kees@kernel.org>,
 Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 10/15] drm: Use trace_invoke_##name() at guarded tracepoint
 call sites
Date: Thu, 12 Mar 2026 11:05:05 -0400
Message-ID: <20260312150523.2054552-11-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 24e4b4fc91564..cdcb33edb2bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1012,7 +1012,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_invoke_amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f2beb980e3c3a..2d34608fd7298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1394,7 +1394,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_invoke_amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2167,7 +2167,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_invoke_amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6f..844b8fc5359a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5190,7 +5190,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+		trace_invoke_amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
 					   brightness,
 					   caps->aux_support,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be7..003c015b3bfcf 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,7 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_invoke_drm_sched_job_unschedulable(sched_job, entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +586,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_invoke_drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.53.0

