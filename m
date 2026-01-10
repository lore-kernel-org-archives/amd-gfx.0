Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A4D232D6
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CEB10E221;
	Sat, 10 Jan 2026 17:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zk1QTtEM";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A516410E1E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 16:48:12 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-11b992954d4so5489211c88.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768063692; x=1768668492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pymo/XHo3xN1Q0UiU9ynvWIgTsVpB73mCjCSizmghhM=;
 b=Zk1QTtEM98iY61FnsGjypVPQy8rh3Oq11P6aotsTzubGBjiUcTdbC1NW8QPrfF5P5+
 vAXaetwkpGfuI5PzuHOJCEIBNfaqZWDDSsqu6b4iSlZuIudml9yP0G8tgBHwi4H/hAgX
 r6GFMdfEaKYgI4lhHlsyIfT49gQmSXtsjO5zEaFYNQFk0oC9yxWBZ5zk0TuNj9MTisEj
 ZBtwZHT9anLPuTU3KPbACts19VlSYcBjFiskS925udCA3+Q2eURN11ndWTv4O6JEsp3r
 NEumARc7JSNIXBFgWCRmJ/MyhIIJJRjnhCswQXm1TwX2jeA5vM1elSOLKQXGjIK5oVB7
 mNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768063692; x=1768668492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pymo/XHo3xN1Q0UiU9ynvWIgTsVpB73mCjCSizmghhM=;
 b=gOYwnKy3xitk8aEbCqolyhnqGLfYKj4YsrvgeZgDIkEpvLYRsYaPO9W+lIkOf+9QLd
 /axagsV63BdtLSfcc2denQQ6DK3u9PBnldik3wtf747ReVA9lTBJI0Te0XA7rqsXPZON
 JHG0MwSbkLrpeUBqhs2n3q/R2Z+iLagl006pSkAGE0lCsO2pypYaYAHiHCje2v94X+VA
 sfF5l0atwCLoMUJKKtxOLaAcOUqsnu8bt1Qvrp3kj2WCWFv54l/ue0jGCB9qnfyAuXtx
 ujfnLkvY5B4xUfCGdNg2xrPtqg7lNSydMjnt+2Vokp22yLg0gmzKb5w8VCGa3g9gatUc
 yNZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVG7lNV07h5udwKq029UcXspyIWmwP9reNm2/TEsC0n1jjEfqk3xPrdCAY2GHtKKLsjiGuUHA0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUBhE7SyM4AZZ0y442d67K6VdfE5AJfIA/FwB5vfU0j8fvnaQ3
 wgkoYKSIsHC/WKnPuF/uovyZQIyAWfIdMuyMc0dGLOxch4ou7RBz6gwq
X-Gm-Gg: AY/fxX41YY8Geols8TcN+TCJ7EJDYFAR7Usd+RQ6npopI9XHh6siiqTcCcHXKQ5pjhR
 DuQyoeePFliB3W3kebnZQQRDNuka3i0jPMalqWIaVxeWIAKXmRJ2mDrovfBVW5gRpSPL75GxDeP
 jMV7xVyWypSi+hSG+dmhh2kVI7I5KL7mnrpuAsN0Ire3Wmhdq2qEPXlzngX6+3YnUyNEjw+BNou
 TMpNa4l6OA8x3EeitzvGub3FbOVLfpHMui3FFaZkec+NQ3GO6ZifVBrRtSZdpDtMcRHd5N6dWz9
 CScxwO3/e2jC553FHOGjHiTSf7HxG5EwbvhCrBzh/r9B5ZT2P+GY9KuCcywbeCgys/adZEepD6o
 igs69eWL1xhYsCSmis4TL4HWzAZgHzfEbUdIThHvSs1x6NlFE4gRJaohXnd7hQk4JLUeBhvL4X+
 zTiiFet6ziSazgsNY52qHbBmE=
X-Google-Smtp-Source: AGHT+IEkR+HFL1Nq5SpvTf3AgMFECL3jz/y0NxbGAy5WuzwF5WmF+0vXkeRJ3kFSqnA+wrIjSWB1Lg==
X-Received: by 2002:a05:7022:ef07:b0:119:e56c:18a7 with SMTP id
 a92af1059eb24-121f8b14920mr9924771c88.15.1768063691770; 
 Sat, 10 Jan 2026 08:48:11 -0800 (PST)
Received: from localhost.localdomain ([202.120.237.35])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f248bb6esm19509083c88.12.2026.01.10.08.48.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 10 Jan 2026 08:48:11 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/ras: use proper error checking for kthread_run return
Date: Sun, 11 Jan 2026 00:47:55 +0800
Message-Id: <20260110164800.39203-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Jan 2026 17:58:19 +0000
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

kthread_run() returns an error pointer on failure, not NULL.
Replace NULL check with IS_ERR and use PTR_ERR to
propagate the real error from kthread_run.

Fixes: ea61341b9014 ("drm/amd/ras: Add thread to handle ras events")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 3267dcdb169c..c001074c8c56 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -248,9 +248,10 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
+		ras_proc->ras_process_thread = NULL;
 		goto err;
 	}
 
-- 
2.39.5 (Apple Git-154)

