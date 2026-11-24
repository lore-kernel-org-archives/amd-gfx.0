Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE0606A68B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B094B10F753;
	Tue, 24 Nov 2026 15:54:53 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 14:30:09 UTC
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A147D10F665
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:30:09 +0000 (UTC)
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus003
 [74.208.114.78]) with ESMTPSA (Nemesis) id 0MGCMz-1xiFNA1WNj-00H1IT; Tue, 24
 Nov 2026 15:25:03 +0100
Date: Tue, 24 Nov 2026 09:24:57 -0500
From: Jeremy Day <jsday@noreason.ca>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: Keep bo referenced until
 amdgpu_userq_bo_validate is done with it
Message-Id: <20261124092457.95ac1f6267acac49b8c202e9@noreason.ca>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zPNuL8W1xREEVKdDETdzVOKD0wV3gSxkiQvnCHlmCjFm5bbzbBU
 xBvvwg33Jfb3cMaZ9IhDOhx3NdDGSdgIgyLF/a8PKCYPwnVCLwbRtiTcOp9s3wB7ckE0wlO
 0wdQ7G9dwNLqxxl9fIwmu7zcLAbG6Am8TkqiBdhC9mAkGxMsIAoMf3xcQfA2GiQF4PZmbfJ
 JqDykLSbJk3e8qfIAGBSw==
UI-OutboundReport: notjunk:1;M01:P0:QqrOhXjr7oA=;WNJCzYq8uzjmAmLpoHkZuJSg5zY
 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
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

So far this change appears to have stopped the intermittent page faults
that were causing problems for my desktop 6600 similar to what's reported
in:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/6022
  https://gitlab.freedesktop.org/drm/amd/-/work_items/5914
  https://gitlab.freedesktop.org/drm/amd/-/work_items/5761

It was consistently happening once or twice a day in 7.4 rc builds on my
system, which I tried in order to find out if the bug had been fixed.  That's
much more frequent than in 7.3, and prompted me to try this.

Since I found no way to predict when the problem would occur it will take
another few days of running smoothly for the evidence to be strong that
this fixes it, but after three days it looks good so far.

Perhaps someone who understands gpu drivers could have a look?


---
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9fc8e9e97595..dc6c3fa598ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1015,17 +1015,17 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
 					   TTM_NUM_MOVE_FENCES + 1);
-		amdgpu_bo_unref(&tmp);
 		if (unlikely(ret))
-			return ret;
+			goto unref_bo;
 
 		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		if (ret)
-			return ret;
+			goto unref_bo;
 
 		/* This moves the bo_va to the idle list */
 		ret = amdgpu_vm_bo_update(adev, bo_va, false);
+		amdgpu_bo_unref(&tmp);
 		if (ret)
 			return ret;
 
@@ -1034,6 +1034,11 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	spin_unlock(&vm->individual_lock);
 
 	return 0;
+
+unref_bo:
+	amdgpu_bo_unref(&tmp);
+	return ret;
+
 }
