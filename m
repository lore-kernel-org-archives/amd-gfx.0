Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC32DE9A048
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 11:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3154610E6C7;
	Thu, 19 Feb 2026 11:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FsMfai9s";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FB310E642
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 00:02:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48371119eacso3503265e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771459331; x=1772064131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S8E+BXCV8EBtKlA1y+aZMc2zEzyG2Wkm5hVPzVUHo2U=;
 b=FsMfai9s1NVmbImyw5lO0pIi+8H6xdSoZ05CmYrhM6brvcYWkwlZC+l8EEVLUxvhVQ
 naqiosG35FlElb0Ey4iqRj2LXW0xoXjSEpGU35usoE8ZQ74O6R4BA6fpQWvNlcyHfXZk
 CWFbRYfCVpF4EtHOGW8UNUKdT7xFNQ9UIvDi+6SzDf9AfnQhS8DXSChdqoO0NZOPukYO
 mj+K+rXXyP3RySTOaDW2I9mOtCXN0SqJAL4/10ct3YRuq94tcpyY7ID0ldOa/mJqwS7w
 T3S1mYeWBEMFXsvYPkoDpyWD1PKcXLNLOuFFP1WMwLzY+2TtgYg9tBudo3mmpRSLdfhC
 swUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771459331; x=1772064131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8E+BXCV8EBtKlA1y+aZMc2zEzyG2Wkm5hVPzVUHo2U=;
 b=R/wKSZG+meszuSYgcElVQnS3sixC1gT7HP0jSqc/JPK/9L043ankJGzc856i4OE9zz
 dk9AFhr6/xiAZahNOokK+rlI9f/r5APtybDlYrKowhLA6LmbqwXQo0Oh6G7sD0HD/5Ov
 fZ4+Cg86Z3qBhsuZxuDbzoAS/VezIl5KLjLJWNLoVVZ8tD+Inns4EzzDyTlFdvAFjJCn
 cY56VaWPkXVxO0f6Falkf0uWJRvVrbWVJh/7vRGmnvNH9dKkqwdJmVqk5/QQhl0K93jR
 sFA11lFJPs45lJhCpINDUD+C6hFkgqTt8BGk38/XVjZ648n75f2nHpSs1s1yWKLZMVgd
 OVHA==
X-Gm-Message-State: AOJu0YzR1qU1sWMTkB4JiJJ6FL3o82rGrMjDws1ruwzG+lskyg5xoo1V
 RMrB6XZMwrSLI/zCLWblHiL/y0RTrCj7KLMEd2MXYB9KXvzw0dgiokU8+Zja53Ia
X-Gm-Gg: AZuq6aI4kppdWs1zg/aSAvsIYMQGRMvA1Nc/9pnAmEjoXLERk85wLowpOgn5lH46Zjz
 qQPZmjxn4lDgnV0v8aIGF9+WEvX6i/V+67l6m8LQvDcLjbrOJefsUyzTqJUWfMjCTxx0CdnpM5X
 61tsTaGikLgMpbEDbhPZ2AZbHJSnlZMHr+qKMjSsORqD+UQtI+csEu4jfncyH2ftP98lCSuR1Ep
 8dyZMvRCqcZ2jtc/0/tBUW4yIorXRvgGXw3a3hFhXevAudtf+XdK/J27vi79B9GmUuzrha/wv1g
 2Djz7LQ3KeWTsMpSSOcL4nYxRzrwo62Umajb6ntkyc/tS+hGjKnbsUsliJu6QKNMXJfpoBi1rwQ
 8sCPG01SLWPNp9zqxd98kfHawiGr30akKOVnP2Zf+r3ysW9vlepG+Zacwf/66hE7+tpTf6D9VQM
 yqXuF46yNZnGJd1rvGHCRkebZRhSc7XsO7/+s0es/mIlHZg9LFSFyQEjn/hwCSFSEl5ELvs9chx
 x0nexdHIkApyr7X5KUroxA12zq2PNYym2g4zVHii6+hsuo6uvUy6p949pyusaAHnk1slOIDpbIt
 GPHExtYE
X-Received: by 2002:a05:600c:83cf:b0:483:71f7:2767 with SMTP id
 5b1f17b1804b1-48398a7dd18mr63602975e9.11.1771459330366; 
 Wed, 18 Feb 2026 16:02:10 -0800 (PST)
Received: from capaj-ryzen-7-9900x (185-219-167-224-static.vivo.cz.
 [185.219.167.224]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836aa0847asm712029075e9.3.2026.02.18.16.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 16:02:10 -0800 (PST)
From: Jiri Spac <capajj@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 stable@vger.kernel.org,
 =?UTF-8?q?Ji=C5=99=C3=AD=20=C5=A0p=C3=A1c?= <capajj@gmail.com>
Subject: [PATCH] drm/amdgpu: disable pipe1 for Navy Flounder (GC 10.3.2) to
 fix ring timeouts
Date: Thu, 19 Feb 2026 01:01:46 +0100
Message-ID: <20260219000146.21818-1-capajj@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Feb 2026 10:59:48 +0000
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

From: Jiří Špác <capajj@gmail.com>

Navy Flounder (Navi22, RX 6700/6700 XT, GC IP 10.3.2) suffers repeated
gfx_0.1.0 ring timeouts when multiple applications request high-priority
Vulkan GPU contexts simultaneously (e.g. VS Code + Brave browser, both
Electron/Chromium-based).

On GC 10.3.x hardware, high-priority contexts are routed to the pipe1
hardware queue (gfx_0.1.0). When multiple processes compete on this
single queue the Command Processor hangs, and ring reset fails:

  amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 timeout, signaled seq=107039, emitted seq=107040
  amdgpu 0000:03:00.0: amdgpu: Ring gfx_0.1.0 reset failed

The seq delta of 1 is consistent with a single job submitted to pipe1
that never completes due to a preemption/scheduling deadlock. Once reset
fails the display manager crashes and the login screen appears.

Fix this by setting num_pipe_per_me = 1 for GC 10.3.2, disabling pipe1.
All other queue parameters are kept identical to the rest of GC 10.3.x.

Reported-by: Jiří Špác <capajj@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4985
Fixes: 3b094d4df4b0 ("drm/amd/amdgpu: add pipe1 hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiří Špác <capajj@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb..a44103622 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4773,7 +4773,6 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
@@ -4787,6 +4786,22 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
+	case IP_VERSION(10, 3, 2):
+		/*
+		 * Navy Flounder (Navi22): enabling pipe1 (gfx_0.1.0) causes
+		 * GFX ring timeouts under concurrent high-priority Vulkan
+		 * workloads (e.g. multiple Electron/Chromium apps). The
+		 * high-priority contexts routed to pipe1 contend on a single
+		 * hardware queue, the CP hangs, and ring reset fails, crashing
+		 * the display manager. Disable pipe1 to avoid this.
+		 */
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 2;
+		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 4;
+		break;
 	default:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-- 
2.51.0

