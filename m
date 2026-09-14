Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED32CC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499A810EE2C;
	Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHJGXwf8";
	dkim-atps=neutral
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com
 [74.125.230.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342E910EBFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 08:16:55 +0000 (UTC)
Received: by mail-lr2-f11.google.com with SMTP id
 38308e7fff4ca-3a5b0adf48fso12395791fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789373813; x=1789978613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
 b=YHJGXwf8r1Mr9pPaqn0tlAlgrSSw2KxmjjeE+RYA1USZjO1QveAJKcsYQfA4FTW6pL
 dSE9qv+DGWv+6LNKLFLFvOS/3w9moha7Bm3eb0zWxZ7ehMaYV/tjP9R93EDnAxbDoe+y
 ZP43OS/zgOEtNHC6nFDx551qVhq22NE4z2lkqWNyp7VJphuRTOqnqQYIvgqdESZmzrJv
 W8pbVUrvOKVUb3Pjma5j5au+V2RrMI3GZv+DpAIgYtNPT9tzgnLHk/dTOKsM/KXabr7d
 k/l/+7Bcc2L550ITncfIWJtiE1P7YcEZYM25IWsY0Z+YWhIcZbQCVEh9XYAfE9x95jtb
 NGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373813; x=1789978613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUYPK83osLZqDNXLlGB7lbQYloWd+rguo+bEtxrEyi4=;
 b=IgB0CrWXaRRaB6qcqDDdbwgRe0Jj6aCDiORja1O+63duh3Q4TJji3YN8vhENdwbNiW
 G90hlxpUEhONDaQGiWMYpI/FLrN9JX80DGTSh4JRwqsZwoSa0ee3mwX8Mzp1cx7KuvPC
 ShWf6oDk+t+CMbluOrkWYUM8TyU+j1POLyhD8m8ziQ3qpy+rqUmM3DVNToMK9ZPGUIga
 hBy3U4JrS8xqauyT2pMSICLtCm8bVynlwPZfasuh7ofKzk9z17/LBEDpcd2RPGLbLHeK
 GhEFFeq8inh0jSJ8qpzNiyr0WnHVwg90FLzYjzm8slYY5d4hicR7jgc3725kJJTdQ6/M
 v67Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCMIi3HCHtOtr9eerQsSEYeAw4b3J5CJeHNeMaoz/HS4M2fszDmiPxB+t/ZzP3qLBKB6sqmW4P@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWKVRk42C72zh+xlUl1h/eWKirinpgwkDlPkH9WTvJ9GmyT8Wp
 t2TM6u/g4KuXLY3CGP9Rj4whvTHNPqLqdvrfKMTpjfzM193PCPS3p8VT
X-Gm-Gg: AYBFou0KASh5CL0TLMzJN0dBimPBuLocYYSdIm7x9CMEZm2ZdWL4BKrGYKz2uAIsR4k
 S+twzPc3dilmny7beRUZGAFstiD4L8CF7ucUMG57aM6BN1jJ5JLMtLMYa6M4u0s2nubKHSedjQm
 2h3ixq2PioSESuIMOa7+F90HzYDJkADfYnaE2UiDfVGriCbys3xYFEYyTnEw3oTIyawrdMkswuR
 1GQf4RE5EFboDWBh3pt9ly6igKwj0Pe3LRn6Qv2dUyRkLPng0+7UiFbutY+IdnIwACoXDRzCIco
 hYxGx+bDfcwlr0JWcItd6pikXhk7sUQaELhymGIhWY5C4PrS3PpguuV7VooZlRKZaNyRTMnPS5M
 EkqUFcsY8JWmCpNgtVDgeIen+40mAi7lkNAT0ID2NJxXzP+FWGSxDhUPpvlmF4voo7gb9jREkk0
 upuVFB4d3pZMgSIxtPZP3y6jHfsxb506KYspYm/qqa+p8hoQP69xIsV/gAuENYXn/RJfvhn0QY/
 7EJZfEfwovxgurTkg==
X-Received: by 2002:a05:6512:3052:b0:5b6:1a7c:fd94 with SMTP id
 2adb3069b0e04-5b8ae6a92b4mr321128e87.58.1789373813016; 
 Mon, 14 Sep 2026 01:16:53 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047ab97sm2326043e87.76.2026.09.14.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 01:16:52 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sasha Levin <sashal@kernel.org>,
 Wayne Lin <Wayne.Lin@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>,
 Alex Hung <alex.hung@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 5.10/6.1] drm/amd/display: set new_stream to NULL after release
Date: Mon, 14 Sep 2026 11:16:35 +0300
Message-ID: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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

From: WenTao Liang <vulab@iscas.ac.cn>

commit 9fa26b9eed6195bf840f39ac183b9a6237548755 upstream.

In dm_update_crtc_state(), the skip_modeset path releases new_stream
via dc_stream_release() but does not set the pointer to NULL.

If a later error (e.g., color management failure) triggers the fail
label, the error path calls dc_stream_release() again on the same
dangling pointer, causing a double release and potential use-after-free.

Fix this by setting new_stream to NULL after the initial release.

Fixes: 9b690ef3c704 ("drm/amd/display: Avoid full modeset when not required")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-68236

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb5e3a6086f2..deaf98957cb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9293,6 +9293,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		 dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.53.0

