Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB021CD4F55
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7B610E75C;
	Mon, 18 May 2026 09:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KEc+2POH";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972F410E174
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 13:41:36 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso1142601f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779025295; x=1779630095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0Fqrssiq5EKJqOqnUySdSTXrmaCviyXE8eaNVLH4Wo=;
 b=KEc+2POHpjliCpwMjzbpr29fe3fwG92xQFdT7EhA32MwQbSBoFMOVRcD3BKia3vPcj
 H1uj4muEP+HV1wk/Y+sxQrxkhkH/v6rFOpqDkOJ9LNe162UnWwfqiTy2A4D4knkEN5kc
 4Dja1Levf+E3SpBUlNibkU+PzOC06/5DZWzvEOKhEKsbhWUOgApHs2FcvPOIaVyRSEmk
 jGT2pYMeSlGJgWocxNZputcXcv3xUHoSL9Hwq0buXQMph41wH4q/xZOBEWsJIcRus/Kv
 g3oQK9GkQT6xGLyhFCw64wyqYljVChDM/yQsK/BT4L2p5Nr6CN2KH+MrGYUyB23KQfb8
 5Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779025295; x=1779630095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0Fqrssiq5EKJqOqnUySdSTXrmaCviyXE8eaNVLH4Wo=;
 b=PaB5XvyRquNtkDBsxw1V3KLwk1fLYC5mcHm7c6NkBe0PMWK5m4R3vVlt/Alo7kA79H
 7DMp8/j0ITSLkVnWk6oCjHqJFFwiy2wZUOhzUeuY0YizCqz6m4zu9qbB4ya0DYnfy6V7
 Sh+tYX9XlGGWhid0/KgM2IxbChTFexA7tV5akbFD+o3p1GfpsZzVaMtx3p3bwcUiz1nt
 /yWlO7KFo0OoOKMCcHvCEw22afA/6bZ+IyGscVIwU+a+pzHWYy35pudldzGI2M8J+/KO
 qKgDC2uPYr98MVPxV7U3d2JMZPkiy8PflTRNRXVf0BCmUKpX6O1rCcrwtIVaWJvTHMIK
 G5Ew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cmOpQX3h5fHnsSGywDU2qm+TIjxGTiyD9vm8pckXOTN9BjdHPuiNDLh8nF1+L6CrwedcwcKrg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1uNGPd3MI2ivlVZWdxq+L4mi/nh1I0J5zNrX/t2K2HMd1w+Y8
 +NSNZaA4JZNAxhSRNOktBd2qohthaqc4pZK+gIj3A1JhnMvOUeiwXyCI
X-Gm-Gg: Acq92OFHCRY5UQplH+mcskJ5G+leSilYM7YhTdwsKO0Ol9qCpAmgs4QzjDBVd2wloer
 vYYrP963oaEAdfBIicB2PEMKjMs87fSqXyxP0nZUpi0Xq6OynyPRYZ6zsAIjdVQ7zNukLEXkHvP
 rFqfntvkENodob6F9sT4CwXEXFN45xGB0jOr95ndisk3x5P1zoqoY7V3neH7/z0aMYWLZtlkxOs
 lVs11JEayzz4MTXXQaeDtgQ4eQJyKGeyi+4HAApfVddeCa7mrUPxRQaofmytxxdi2RJNmLrNemK
 /vJJOA8TboEVD0MnoQGH+yWDE6Ghs380s0PxUBwIba87SNHa9bwr3wXNrtAJnq+ktJjVCrNr8lR
 XGIdV6oAXY764NDuq6cc1BVC68ut89v/Qd9FxUDOg37PWmIyFccQ2I1qp2EME6N3PgNGrFiU2qu
 JLx3c62JZlIYiObITlgq57oenwhi2HJgU/u+ou6KsbL70MiaM1+NHx5zYaqlOmFF02m2pZo/Lye
 A==
X-Received: by 2002:a05:6000:4010:b0:43f:df1b:9e07 with SMTP id
 ffacd0b85a97d-45e5c5a5580mr16862802f8f.42.1779025294346; 
 Sun, 17 May 2026 06:41:34 -0700 (PDT)
Received: from localhost.localdomain (i59F7ABEC.versanet.de. [89.247.171.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm28231673f8f.36.2026.05.17.06.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 06:41:33 -0700 (PDT)
From: Elliot Tester <elliotctester1@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net
Cc: skhan@linuxfoundation.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Elliot Tester <elliotctester1@gmail.com>
Subject: [PATCH] docs: gpu: fix spelling errors and remove duplicate sentence
Date: Sun, 17 May 2026 15:41:22 +0200
Message-ID: <20260517134122.38389-1-elliotctester1@gmail.com>
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

Fix various spelling errors in GPU docs:
- indicies -> indices (userq.rst)
- umap -> unmap (userq.rst)
- pre-empt -> preempt (drm-compute.rst)
- buffer-leaks -> buffer leaks (drm-uapi.rst)
- Additionally to -> In addition to (drm-uapi.rst)
- unpriviledged -> unprivileged (drm-uapi.rst)
- fucntions -> functions (todo.rst)
- varios -> various (todo.rst)
- implementions -> implementations (todo.rst)
- complection -> completion (todo.rst)

Ale remove a duplicated sentance and stray "uff." in the todo.rst, add
missing period after drm_ioctl.c reference, and add missing newline at
end of drm-uapi.rst. Fixing this would make reading the docs just a
little bit easier.

Signed-off-by: Elliot Tester <elliotctester1@gmail.com>
---
 Documentation/gpu/amdgpu/userq.rst |  4 ++--
 Documentation/gpu/drm-compute.rst  |  2 +-
 Documentation/gpu/drm-uapi.rst     | 10 +++++-----
 Documentation/gpu/todo.rst         | 11 +++++------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst
index 88f54393b..94427e18a 100644
--- a/Documentation/gpu/amdgpu/userq.rst
+++ b/Documentation/gpu/amdgpu/userq.rst
@@ -156,9 +156,9 @@ IOCTL Interfaces
 GPU virtual addresses used for queues and related data (rptrs, wptrs, context
 save areas, etc.) should be validated by the kernel mode driver to prevent the
 user from specifying invalid GPU virtual addresses.  If the user provides
-invalid GPU virtual addresses or doorbell indicies, the IOCTL should return an
+invalid GPU virtual addresses or doorbell indices, the IOCTL should return an
 error message.  These buffers should also be tracked in the kernel driver so
-that if the user attempts to unmap the buffer(s) from the GPUVM, the umap call
+that if the user attempts to unmap the buffer(s) from the GPUVM, the unmap call
 would return an error.
 
 INFO
diff --git a/Documentation/gpu/drm-compute.rst b/Documentation/gpu/drm-compute.rst
index f90c3e63a..35cc8d654 100644
--- a/Documentation/gpu/drm-compute.rst
+++ b/Documentation/gpu/drm-compute.rst
@@ -7,7 +7,7 @@ seconds. (The time let the user wait before he reaches for the power button).
 This means that other techniques need to be used to manage those workloads,
 that cannot use fences.
 
-Some hardware may schedule compute jobs, and have no way to pre-empt them, or
+Some hardware may schedule compute jobs, and have no way to preempt them, or
 have their memory swapped out from them. Or they simply want their workload
 not to be preempted or swapped out at all.
 
diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 579e87cb9..0ef498bff 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -150,10 +150,10 @@ separate render node called renderD<num>. There will be one render node
 per device. No ioctls except PRIME-related ioctls will be allowed on
 this node. Especially GEM_OPEN will be explicitly prohibited. For a
 complete list of driver-independent ioctls that can be used on render
-nodes, see the ioctls marked DRM_RENDER_ALLOW in drm_ioctl.c  Render
-nodes are designed to avoid the buffer-leaks, which occur if clients
+nodes, see the ioctls marked DRM_RENDER_ALLOW in drm_ioctl.c.  Render
+nodes are designed to avoid the buffer leaks, which occur if clients
 guess the flink names or mmap offsets on the legacy interface.
-Additionally to this basic interface, drivers must mark their
+In addition to this basic interface, drivers must mark their
 driver-dependent render-only ioctls as DRM_RENDER_ALLOW so render
 clients can use them. Driver authors must be careful not to allow any
 privileged ioctls on render nodes.
@@ -568,7 +568,7 @@ ENOSPC:
 EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
-        this when called by unpriviledged clients. There's no clear
+        this when called by unprivileged clients. There's no clear
         difference between EACCES and EPERM.
 
 ENODEV:
@@ -761,4 +761,4 @@ Stable uAPI events
 From ``drivers/gpu/drm/scheduler/gpu_scheduler_trace.h``
 
 .. kernel-doc::  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
-   :doc: uAPI trace events
\ No newline at end of file
+   :doc: uAPI trace events
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index bc9f14c8a..b13cd4347 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -55,7 +55,7 @@ There are still drivers that use drm_simple_display_pipe. The task here is to
 convert them to use regular atomic helpers. Search for a driver that calls
 drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_helper.c
 into the driver, such that no simple-KMS interfaces are required. Please also
-rename all inlined fucntions according to driver conventions.
+rename all inlined functions according to driver conventions.
 
 Contact: Thomas Zimmermann, respective driver maintainer
 
@@ -301,7 +301,7 @@ Various hold-ups:
   valid formats for atomic drivers.
 
 - Many drivers subclass drm_framebuffer, we'd need a embedding compatible
-  version of the varios drm_gem_fb_create functions. Maybe called
+  version of the various drm_gem_fb_create functions. Maybe called
   drm_gem_fb_create/_with_dirty/_with_funcs as needed.
 
 Contact: Simona Vetter
@@ -326,10 +326,9 @@ everything after it has done the write-protect/mkwrite trickery:
 
       vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
 
-- Set the mkwrite and fsync callbacks with similar implementions to the core
+- Set the mkwrite and fsync callbacks with similar implementations to the core
   fbdev defio stuff. These should all work on plain ptes, they don't actually
-  require a struct page.  uff. These should all work on plain ptes, they don't
-  actually require a struct page.
+  require a struct page.
 
 - Track the dirty pages in a separate structure (bitfield with one bit per page
   should work) to avoid clobbering struct page.
@@ -914,7 +913,7 @@ Querying errors from drm_syncobj
 ================================
 
 The drm_syncobj container can be used by driver independent code to signal
-complection of submission.
+completion of submission.
 
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.
-- 
2.54.0

