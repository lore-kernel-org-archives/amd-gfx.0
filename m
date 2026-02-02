Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98DCE83060
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258BC10E580;
	Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P30SP+1L";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BAE10E531
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 17:30:24 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so3564130f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 09:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770053423; x=1770658223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RI/alqYAM4gO0/wt3nMxDoDmoSnVqh/ah5aH4qQn4kU=;
 b=P30SP+1L/9XiYivwfAOpmSDqRUzMN6k8RY/zDwujEZb5eAjb4tlVB7SNSPlaYLt2bk
 Tb0yUU02GGFKs8OLyI7MhZUDWex/3n/D4ulof6VW+39XNUH9OqzWZMF9SuFwpRq1/K5z
 kSgs95xfpln9Ca3ImZIwB1JGqRdiujXcLta+EJ9B8ePONbq31WSBjD3zZuQFg+mDYWbG
 fqmKflKrzsakU50bsWalT5FvfyzYaPdZ6U1BomPTCtVvCi6zdYoRB4SZj97o7pKVwRkv
 AOxPDGZx0QgHfcGX0E66jMx+wtDL8rmfpDzku5AOLCirV7tJZJt94DX7ak+PWu1WT7iR
 WEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053423; x=1770658223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI/alqYAM4gO0/wt3nMxDoDmoSnVqh/ah5aH4qQn4kU=;
 b=AhX1ewjZvaXYIECOZB2+FEo6lESgOGmvMBx8S6AFq5dApU49O7wNj3RIGbgvi3Io3j
 MHJRXP8UcAZhK+GHqqmfhfNDWt1KcJPyWSfJbHacCKKS73sBgankl3nJn9wWtO7c2uoS
 fr5oqDcXHEXN4CrwR6Gp6bpfFwjMToF7LRpAHYJEU4/iUBEA3J9uGZSnqkJ67JNtK8G8
 VAnAKIVbXe/mzaMCqUHMIyz1ibAzpE7OCvjXA/sRJth1FFyYkFXTP0Eq7lNRanvIavOY
 DNflU5eRxXOlczdhgqQJyuTG7hOh5IIoSqxws9ZUwN4dMdEBbYMUrgUi0pCEQSaMZLFj
 VDZw==
X-Gm-Message-State: AOJu0Yw8jaTRFsvMiy2kt6/QhQRME0GJavWyVF+Adom8fJ1m4vyEdf96
 xon33cO4QZpE+/X91oME811NTy3pnppyqbIfC4VURq1QJ5zxTsev5KlfohZWoNw5
X-Gm-Gg: AZuq6aIfzWeBpPy4t4/GnizYEzK4gD24DjnCddUXIquKR5M+E93Z157jCLdJBHyk/9C
 XM5aJW/SB/m7x8rXhCNpQ5kHkUZIgBikAsIy55SFXDE94fkSHSX4e5fCIFIMBv5JKclT7MBGARm
 IX4ZFF7PWUxrbR14lSY4Lc9KoOg4/5t/2PKk8iGy9meVhXkdfD6n7iwnTkowKSyDViMNh7dEdvy
 hljh2F5YGKH2gUNIn5dFeJGTlwf5VZxwTdX5fDODXbTiH5FhQGB9c7BPlympu6SbXyzWTDPC6nL
 Mk9arBP/IkSpFtv2Bpau1rAW5KtR+xUQiSY/cVuaeYV/YrAkXYACIZJor+ktMwt+sQUS4oyzD+8
 jKzEwhADeAf5ytaUiBArU74YrzOPvHAjliV5UYf4yT3u+Z1XuSCQMcfA6IAqfLJD7H+WSz/AS8K
 CiY0ej7FeKGg0LzNImDRYW2K22MpeIptA=
X-Received: by 2002:a05:6000:4381:b0:430:ff0c:3615 with SMTP id
 ffacd0b85a97d-435f3ab2695mr19181714f8f.53.1770053422479; 
 Mon, 02 Feb 2026 09:30:22 -0800 (PST)
Received: from hassaan-HP-Victus.. ([192.140.149.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm44324788f8f.20.2026.02.02.09.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:30:22 -0800 (PST)
From: TrainedPro <hassaananwar12345@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, TrainedPro <hassaananwar12345@gmail.com>
Subject: [PATCH] drm/amd/display: Fix ignored timeout in do_aquire_global_lock
Date: Mon,  2 Feb 2026 22:30:15 +0500
Message-ID: <20260202173015.33743-1-hassaananwar12345@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Feb 2026 08:16:06 +0000
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

The do_aquire_global_lock function was incorrectly returning success (0)
even when wait_for_completion_interruptible_timeout returned 0
(indicating a timeout).

This caused the driver to proceed with atomic updates significantly after
the hardware had hung, leading to system freezes.

Propagate -ETIMEDOUT to correct this behavior.

Signed-off-by: TrainedPro <hassaananwar12345@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 39df45f65..6546bc9f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10458,6 +10458,9 @@ static int do_aquire_global_lock(struct drm_device *dev,
 				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
+
+		if (ret == 0)
+			return -ETIMEDOUT;
 	}
 
 	return ret < 0 ? ret : 0;
-- 
2.43.0

