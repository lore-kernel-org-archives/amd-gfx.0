Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194BC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74D10E976;
	Tue, 15 Sep 2026 13:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZuIX6xkG";
	dkim-atps=neutral
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF1E10FAC9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:47:28 +0000 (UTC)
Received: by mail-lr2-f4.google.com with SMTP id
 38308e7fff4ca-3a48db5ecfcso22892281fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789458446; x=1790063246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
 b=ZuIX6xkGtBJGeZmOCiUguRHHEaO3VrF9LurFIO1CwtuKatmRe1hAY1MQVkqi2Bqjkk
 gRmQy/fMqJ/4oh46WBYBGdsRzpUBh/4qVkA4dFsWTN02mEaojRjoTtGSGtfXb+bvhBKk
 a6Xc5viSEmynONBJ0oD3QmgxApHNTouHV9Ak0Dm9TkxetFSkucgnq4/Xt25Af8qq+PG5
 iJjABk4v/TXyIVpZBfxen5/LKEcm0NWE4Ywx8cjcirljYrkZT4vSMR6EACJGV5sCWtpo
 QEk069eAdDJs+R+ttgRjEUKQ0k58e/+NpCka/jePCrnA0LeT+4YpQoV6GibgURjqU5uI
 9w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789458446; x=1790063246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=reJctIGiQbHHtQqBXNj1e8Lzl4odeNP0FCDfrK7fh/A=;
 b=bv1E9w/mEHdAW4WYCt3IztcrmHaf21pu5aJjPZKbiiJwhnp6KAH4WzToVMtnt7Qy+S
 T/dCa2wHqhdI8b70XvmC9rRKrZvjrb37ajUjl0ljInZIfkGpzG5QJZsPKy3btS45RbG3
 hZmMf6X26zWRYQ7wa2nAjVwA7VqHK8uWzIQ2QLiTBQC7Qs/HghfmwGGElz9wSQKbksyb
 LBLOl0I/REyMFhjp89OJWTPdJaF3DsEL7D6LKavM1PUEo8TBDaf1Blzl+NRTBvf3MSTl
 yPC1ie19Rz0+g5CXOpR+utrURjfg5dEu623+fRTh/UwPsIYaHXDsXyL3fDPAbDJl7+hC
 9Myg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+STt11xIUU42xWGfOouM2kb53qfO9kShFV6dT8mlun7SeliUISmEJDC+2+9Or7/BxLVxeWDMn@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFr/kpQsvgs4OW2BwCvZKuj0sxbMzOZelCNOwFFemjjX2INfwV
 gEgEX+jFddTgTVfpEb6rfmGKpA4zeDWdCD7mpst7X/7qJ1fQwx5fuF++
X-Gm-Gg: AYBFou2KH3EQcGZ7nojlwlb9i3uEyyw5JJQ5/CJDHcWJH47QnDP8+00r68EOf5IhlVS
 q9mcda52/+nIG+gBOWEyvGRQVf/KZ/JQskPdmXgkJmiZ1ya4PTDkL5XzT7TPIxM+RuWM8F54TzE
 9IGk4vVwmDTEVu3+uOvklPNUoyYPDXl5ABukT0nJqvTqcPfhFjN9+4iCxjk7NZDvfqPr9injr9h
 jquunG2L3lyZBc51hbSfnrbC6oNOKmlhNXfz0MeW/kj3bBh8EFTti4E1gOA86Tr3F1WFARVwEYK
 JWDWkV0dkaS2zhOp+lNXjJ4Fcg7Y88rFJgy1QlHK55WCNBOFlZt7m59EoLLzDD3Yw/LjoobyctE
 n3uFnuy6So5ToSQWyxSkk1zL7oIvEiL5z5up4vQGL65A9O1T+kNG5yzdi3yK9t19RwAIVJ+NiXQ
 1fpvaxGduggWEis99roZebye4OjJgSvdh6mTyNpC990eKXkFPaY4sNNFHbfKHu7PZsw3kPGUyXx
 eLgAih51LsLCc2K
X-Received: by 2002:a05:6512:10cb:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b8ae68c142mr2989522e87.8.1789458446213; 
 Tue, 15 Sep 2026 00:47:26 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0469a8esm3090013e87.50.2026.09.15.00.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:47:25 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15/6.1 v2] drm/amd/display: set new_stream to NULL
 after release
Date: Tue, 15 Sep 2026 10:46:09 +0300
Message-ID: <20260915074611.9133-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 13:14:42 +0000
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
v2: Include version 5.15 in the patch, as Sasha Levin <sashal@kernel.org>
suggested.

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

