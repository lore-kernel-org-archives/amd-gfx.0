Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A44606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sWPaowe6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCC710E2E8;
	Wed, 21 Oct 2026 13:09:26 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710AA10FD9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:41:53 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-7cc0e865dd1so179579137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792582912; x=1793187712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fx75j4SxhSfx9/iSOVIDoOGsjmIu6P89n8oQ2wrar1Q=;
 b=sWPaowe6ngjS0YD/gPl6Is9y0HUgKrXGM2HpjkokH4ckunEJYdRiYLzIdr6ZhgkgZQ
 mQ5s+/BKyAsT/lB19KlkO0qD/VpKtSX8DsWugTMdyz9Mh/0l+JMOGJmeZr9reGptyDRh
 YRNUMaVQij5sr1zxznXM98nx41am+FAliS4QV2ckemMrFdrsV+rxnjS3crZzaVMMCejY
 ngwtXttlMUjONvf0CZRIqfIX7PUpFvJfCXyfJOqr8/PIaOzgDrAec95CvMv3DV9/01WY
 nsUwmjZz6Nmxw4lOloctgLxST0fafCfP4IFQgcTbyjVqH8x0+TFHPAND4lgd51FylCDY
 xDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582912; x=1793187712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fx75j4SxhSfx9/iSOVIDoOGsjmIu6P89n8oQ2wrar1Q=;
 b=rG/Nx5ILlcm4AnUCgJwDvEisgJ3kbc85WX/rHqZKJnp03LgfPcDRCn4gVkq3sGKMTj
 IO90AgTgOoDxI2tBxMtyNco5BWzUXAr6s3v+ZBeWz81QVXr1qeMIlMvr+unCAYtEM6FB
 0hJE4NUa5SQB+Rpf1BOqr3HdDSCEAX5CwhqRASJ/41POkv+cZ7KJ0T+eSQ1J1+FFZI86
 y0dkp3WW9eXzAlsOpGfVaorjWkQvrWz/dUbwF+7p/cLG3BGWO93qiaOMNU5Leyc+gS9H
 ibPLt0sfpeTTET5aW8x8kXEgJ5CudGHBePO2Ousvt1F2Ukvpso6ezAU5PXC7NqodvEre
 j1RA==
X-Forwarded-Encrypted: i=1;
 AKwUvByIbGYp+mP/XflSj1x8TTx+L3c2avQPnfamhj+v9KTjomGZXbv1Te6PI3RRVMO+KyelaSLPSw44@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLWcsqug/e2/tIG0qopdYKaCTzvX9DHRypD+WY2krRkzcvcdzCs
 uqK9uVEeyZG26Q0Rx2F6ltkV2FKA+iraTBoK6kuoNtBb8SGpvienZr4odiSpwarS
X-Gm-Gg: AYBFou1JIvai61BYlvHAijp+l3SrD3yMiY6qv3aFlb2jobd6K2HUKxPFzCNfWUmQEoP
 UWfBwlWGpHYkgPJv64eWEid6QT20uo3bFG6t4o0JDCRssIiX3FnrlmAS7rRcz8urotBDiuMs1ZX
 u6QRc0wg+YUZfvxM1L2MDxOqBw1Y9fFDAwD/R7W630k2cuTLgDK2Ti4eUajqEUJDZzn/CbipweD
 S7sqYTZpU+PHatL41QsQXKw2LAapp4wfhGuQq1NEw5NP04Kb8PN+MX2VxAXQi2Kqi86pCGHke3c
 NKGalf+Yjy4SR7puUdRkuIsPHuOTVP06cktP058dqNdgx9VV4H3NUexiO7YxgcPBQb8hQI8sv9J
 CXrzYGCnlb7XyBlcCxKrgRM8b5CdOPy37A/t8abEWlYVa/51qzcNI9Z5OTqO2yUx+MJTH5fLUB0
 qP2v3JoQxfihpDslph/Ie7edMdAGh0YDR38ikzDd+XLE0XSywDPgB3zVXucI62blDx4XvO+P76w
 NEbF1x6n8rWpmQAk2vw1El8U4GlBBv7pSivsCM3u3cpbi7RX00e7f1e25XbhQvs7NmO6P0=
X-Received: by 2002:a05:6102:5346:b0:7c0:9788:b46e with SMTP id
 ada2fe7eead31-7cc926f8856mr513003137.32.1792582912106; 
 Wed, 21 Oct 2026 04:41:52 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc91f9c7f1sm2365006137.0.2026.10.21.04.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:41:51 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the VCE
 interrupt
Date: Wed, 21 Oct 2026 08:41:16 -0300
Message-ID: <20261021114122.94008-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 13:09:26 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
RDP server, which encodes through VAAPI, and reproduced it with a
plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
8870M (Cape Verde).

The VCE1 code never enables the VCE trap interrupt and the SI (and
Trinity) interrupt handlers do not process it, unlike the CIK code and
amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.

Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
none after, and 34 fps instead of ~4 fps for the workaround that avoids
the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
client, now encodes on the VCE ring for several minutes (about 40
fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
clean kernel log.

Two caveats:

 - I have not worked out why the missing interrupt turns into ring
   lockups instead of only added latency.  What I know is that the
   hang needs the VCE ring to wait on a hardware semaphore (disabling
   only the waiting side, or both sides, of radeon_vce_semaphore_emit()
   avoids it) and that handling the interrupt makes it go away with
   the semaphores left enabled.  If someone knows why, I would be glad
   to improve the commit message.
 - The Trinity/Richland change is compile tested only.

The series was developed and tested on Debian's 6.12.113 with the
radeon module built out of tree.  It applies cleanly on drm-next
(fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=1,
allmodconfig) both after patch 1 and with the whole series.

Matheus Tagliari (2):
  drm/radeon: process the VCE interrupt on SI and Trinity
  drm/radeon/vce1: enable the VCE trap interrupt

 drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
 drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
 drivers/gpu/drm/radeon/sid.h       |  2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c  |  4 ++++
 4 files changed, 34 insertions(+)


base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
-- 
2.47.3

