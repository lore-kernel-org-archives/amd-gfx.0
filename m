Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C0ACD4F3E
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 12:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0290C10F1B0;
	Thu, 14 May 2026 12:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gq9O/3HC";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436A010E3BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 10:38:28 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so70994235e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778755107; x=1779359907; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nitUXTwczWASa+N4nk3OM4knbU1wDNvKAJHSRzcwWjc=;
 b=gq9O/3HCOCXFFWWWJsUNhUe2j2+dc92BlMAhWXfjfd8tf9Wdf8yAk6vCGeLdA9wFz5
 KbW3V7uIrblFRe/mJS5UiFAOLnT4cEDxvxelxDWPSXWLX5cxp9LHk3dwetfC1Yl+S8uC
 z025Del13vj4hDGUpnMjIGpS1rXHeiwAh+tTMMFkRhsKfAXkv9zVfGtTX/Wu4k+CDg2Z
 +g4SnKP5T+E25DXIAier7VAmh8LNfjpPKkzrWxNadBHZDTGx3WkTkHXvDuGsL5zV6dnp
 6Bd041tZVMy/e4y0kGmSdMavPBcCpp2RP5gU8XTjQpQiHOkAh51JEo3gmTWUCk1NSr0T
 l+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755107; x=1779359907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nitUXTwczWASa+N4nk3OM4knbU1wDNvKAJHSRzcwWjc=;
 b=CKiWrpedrr0S3nx7Fb57hijnSnYxGFgmfXV90vr1nsgW1F9Mei2DaJT9t53UTVDqSA
 Qnvox1BogL+oc5NkXwvAaC71GeP/nieRU3Yh90SQIIpKwzHDgDvDilqt68Rc5u+HsyiK
 ufuaep/YfmH+vnQ/3fO82qU1sKktQGo+JTS7/W5dM1yKUsGlKvJicBXur3PN6iSXGVyP
 i4f7X97EUJrSft+SAzu/lFPxOFfnMlnqC4t7vIgfKcKR6rrfplaT06xPydZ/IEKYP9wi
 5CdWhN0cnXJDD4oegwPdl6KC/FnGSOf/uUCBaiPQoWyrTmvaINykt5CydY2ee3ZTAoga
 tfwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nO28w80pM8gMNy0WTikvjvrbE33ODo2nl21R+it1NbphlWjsBNPEoBNXk+iTk2SVIJ0x9xZSq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi4Ikq2SpaOpq0WB6YUrbtMZHLt2ihB/ofaMqJvtCurWYRNcm2
 jt7DLFclCs08E+Gk9bbgMcSUeQDFIhn6Q6CfyaQKvfEC5shNw0c2ncZGBfei9UW8TtpYbKMDiG0
 cjLX65VA=
X-Gm-Gg: Acq92OFM0803aei/hgnl8pywuyJkSXAElBflmgFLWDMmDdl7lGTuyn9R67N6iAXFLT0
 GRAFE59Vy4S/AezZ723ZFrFON+y8O1gM7Ewd6nyTGy0FNmBriDXzKjq89p0xoMv7lwx5oQF5uma
 HM1k/Mc20WdOiDMont6fOjAq7zgKSGIzhOHZVkDPvyyhP95eyth4nkZ3ueXwEL7imohXTjcasIK
 peVSGBnrEAEri9LfZBZWFoZ2ZEzpRD2HgY3QZKVFemxaZzdKTBNNGIX7Gp2Jh0UxbWb3DC2HgDs
 zeL9E96rOlspGr97RYIYfZmRv6xJYE12ebXmoBSNTgLaC7WXHqup8mOASic7SUFi3fiKWoH/ZK1
 SK4Br27Y2V9iWcIqJz5pSTQAK0blsMYUay7LEBGVqEXFqo59RQh7ndsGIzYv6AA52fwFq5EKNFq
 9Bnms2+LNBanp3D7BFhSffVphCmKEzJ7JD1jGLp3wxaOHcIhBUdt56DHoxqQ==
X-Received: by 2002:a05:600c:1990:b0:48e:75fd:9f9e with SMTP id
 5b1f17b1804b1-48fc9a3e58fmr99666465e9.20.1778755106750; 
 Thu, 14 May 2026 03:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64e2132sm57788365e9.15.2026.05.14.03.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
Date: Thu, 14 May 2026 12:38:09 +0200
Message-ID: <20260514103815.190628-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514103815.190628-1-marco.crivellari@suse.com>
References: <20260514103815.190628-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 12:46:16 +0000
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

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..0811593fca7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -586,7 +586,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	 */
 	adev->coredump = coredump;
 	/* Kick off coredump formatting to a worker thread. */
-	queue_work(system_unbound_wq, &adev->coredump_work);
+	queue_work(system_dfl_wq, &adev->coredump_work);
 
 	drm_info(dev, "AMDGPU device coredump file has been created\n");
 	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
-- 
2.54.0

