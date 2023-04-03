Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2920C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 19:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2A210E18C;
	Mon,  3 Apr 2023 19:41:21 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC9A10E176
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 19:41:18 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id i9so30535163wrp.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Apr 2023 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1680550876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdKXVkAVOqX9vK99Q2g5Z+5QvHFDzkHWbDD4urN+YpM=;
 b=MGFH3KHyvJPi7+iWaRXLrIdFo4TAx4Yd8kqhc5xXzrtsrsl2Wxc3ASN1wGO7kRc7VF
 QyLSJaF1vnfW06Rmp0+U4dd6UuETmVctr4BZPeDSet6uRjo7fXfhC52EFnxwQ9M7SJ7V
 X4KAJ8y2/DK3IZQ28qnPOLLmI77Ru6oarOnIA28+7ILZUXjaVhe+EMSm6iAGz2U0jXcz
 GShsIaU7w+z9ZAk59TMv7YFI/4M3rPhSAVjmocX0xjC/jlAJ4cKFkGJJ8yycKIBtCvFT
 6Trg4LyLvXvX4N3/fDq3CJOVKHXG8ytqCxvOk1X0uIbz/jznXVnNm1VJgOWhmyAY9FIb
 6D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680550876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdKXVkAVOqX9vK99Q2g5Z+5QvHFDzkHWbDD4urN+YpM=;
 b=3cY20T/GVxsKXlMqQlmdgufVIaDCdJtmDdZw4Pms0sx3/McUTIB0UKDC3CUoh4syj1
 J/04M5YR01AvL4wRoIG2OvpMzIuAetG1trhobTccJOTzIMYCc1nyyNpZyT1BvTjoeOGd
 m0c79bbnMDjWEmvttMrkHawlgNSfbQyWxMcdoDlTjQVzm/JKAyJ0wLDXVMBFioTBcOF0
 v0fVVLaUt0GvC9LzT7LEL/R0OmjnIwTDibZo58B79gJ+6MpdzpsaMbBwKqfL/cTQXD5w
 iTu++sRxAURS8f+C+xMs+O2YH8QJ4TxKiySgPJN95rLryzyPjrghS9y6kzFJTJqKJcIM
 muUw==
X-Gm-Message-State: AAQBX9f8xY4dM+k7kmjpIe61VrYUkZRlVExwTESmwStB1JwIwVOp038c
 4pCf32G/9/wlSUeOkGb4qhfJY9TGSiJmQ5n6mro=
X-Google-Smtp-Source: AKy350a0CUTa/6G0VaCS6DSNTzq+edRh7ekL35jspvxMho65Mu8MeqFKneOW/a0LnHPTyQXGPRqx8w==
X-Received: by 2002:a5d:67cd:0:b0:2d7:babe:104c with SMTP id
 n13-20020a5d67cd000000b002d7babe104cmr26935034wrw.15.1680550876616; 
 Mon, 03 Apr 2023 12:41:16 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a7bcb11000000b003ef5db16176sm13036342wmj.32.2023.04.03.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 12:41:16 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 3/4] uapi: Add RLIMIT_GPUPRIO
Date: Mon,  3 Apr 2023 20:40:57 +0100
Message-Id: <20230403194058.25958-4-joshua@froggi.es>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403194058.25958-1-joshua@froggi.es>
References: <20230403194058.25958-1-joshua@froggi.es>
MIME-Version: 1.0
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce a new RLIMIT that allows the user to set a runtime limit on
the GPU scheduler priority for tasks.

This avoids the need for leased compositors such as SteamVR's
vrcompositor to be launched via a setcap'ed executable with
CAP_SYS_NICE.

This is required for SteamVR as it doesn't run as a DRM master, but
rather on a DRM lease using the HMD's connector.

The current situation is bad for a few reasons, one being that in order
to setcap the executable, typically one must run as root which involves
a pretty high privelage escalation in order to achieve one
small feat, a realtime async compute queue queue for VR or a compositor.
The executable cannot be setcap'ed inside a
container nor can the setcap'ed executable be run in a container with
NO_NEW_PRIVS.

Even in cases where one may think the DRM master check to be useful,
such as Gamescope where it is the DRM master, the part of the compositor
that runs as the DRM master is entirely separate to the Vulkan device
with it's own DRM device fd doing the GPU work that demands the
realtime priority queue. Additionally, Gamescope can also run nested
in a traditional compositor where there is no DRM master, but having a
realtime queue is still advantageous.

With adding RLIMIT_GPUPRIO, a process outside of a container or
eg. rtkit could call `prlimit` on the process inside to allow it to make
a realtime queue and solve these problems.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 fs/proc/base.c                      | 1 +
 include/asm-generic/resource.h      | 3 ++-
 include/uapi/asm-generic/resource.h | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5e0e0ccd47aa..a5c9a9f23f08 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -589,6 +589,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
 	[RLIMIT_NICE] = {"Max nice priority", NULL},
 	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
 	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
+	[RLIMIT_GPUPRIO] = {"Max DRM GPU priority", NULL},
 };
 
 /* Display limits for a process */
diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
index 8874f681b056..cefee1a8d9db 100644
--- a/include/asm-generic/resource.h
+++ b/include/asm-generic/resource.h
@@ -3,7 +3,7 @@
 #define _ASM_GENERIC_RESOURCE_H
 
 #include <uapi/asm-generic/resource.h>
-
+#include <drm/drm_sched_priority.h>
 
 /*
  * boot-time rlimit defaults for the init task:
@@ -26,6 +26,7 @@
 	[RLIMIT_NICE]		= { 0, 0 },				\
 	[RLIMIT_RTPRIO]		= { 0, 0 },				\
 	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_GPUPRIO]	= { DRM_SCHED_PRIORITY_NORMAL, DRM_SCHED_PRIORITY_NORMAL },		\
 }
 
 #endif
diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
index f12db7a0da64..85027b07a420 100644
--- a/include/uapi/asm-generic/resource.h
+++ b/include/uapi/asm-generic/resource.h
@@ -46,7 +46,8 @@
 					   0-39 for nice level 19 .. -20 */
 #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
 #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
-#define RLIM_NLIMITS		16
+#define RLIMIT_GPUPRIO		16	/* maximum GPU priority */
+#define RLIM_NLIMITS		17
 
 /*
  * SuS says limits have to be unsigned.
-- 
2.40.0

