Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 16:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97E822CB8
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 16:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97E822CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8708989A59;
	Tue,  5 Jan 2021 16:45:57 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482B389A59
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 16:45:56 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id 4so14950256qvh.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aBm6ZT9oGLVCakfH8Hpy6tlKHEkp0qXnXJR7JSm6nAQ=;
 b=ZCtXuAxyux081ZvkuKevJgWiZtcIriX9z9mCdqFRiVb6MA43Fa2oWk/z/QiZb6S1V1
 c/phumsLilMCktii8eio8/w+PWMlUTTwBCJ/Ww14cPB/7sKBIkTKQBm+bw/O1pcY/FSJ
 MEo0Npn+xLKKpXuJKBbcaWTSlJPKa43PtrHgeA/a8VlfvBdIs59YHZ2HZfkMDYOGSurh
 2svSbUSFvOblFSltbFqvlwxvckXQzT9CbrO/CZjUp5UxoJBJhTlqJijVCICkgukz1QXS
 lWDL8WPgOQCyGmec2EDrDEBASw++PlvZBeSW4gyc3jEKiwtqeCzxn6G7k1kjvpiEIeTp
 OgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aBm6ZT9oGLVCakfH8Hpy6tlKHEkp0qXnXJR7JSm6nAQ=;
 b=JDJZ2nsvk89xlvjpt6oa5vIK29zx0a3TAOkZXmQQy4keY5UUUpvtt/RzxLa0VvPKUb
 vnoCJ5jYNXe3WAYWEGkr5dBqd6KJ3rsdt6i2wbBV/iNWf+Yu6dDm2jQwLabcG/Kvl0G3
 /wY38H179blcOPDb4Wj5Yg9eMJ4WqCFFehsA0psxf93HlwdET/0u1F0xAvxiVJcIGAS9
 DDlnOFB3Nyl+5gnWNEhAGlAM6VapD4EJP0zTbXY1lARjrhB6dHdImdsUw5nA5e+Dfp7R
 IO3hvyG+dqQpTldGYUHwYQkJLb9yDEKdzTIePz8d8gh1ntKA6IndMQS+Of1DqgeiBE9G
 NOUQ==
X-Gm-Message-State: AOAM5333FyMvOL9z5bZd6cKKsM7xO2VWzqsCdLfQ3j2mikj0o/icWmzt
 Jbs9poaGNEwbKKvv8Ip0syBazHY/vq4=
X-Google-Smtp-Source: ABdhPJzJDiUxVbUAmBAWOnnLMe88Xfw33hnunLEdL4FaKQxE5ZKNzVXQkjwIXRCVaQ8TH9kJI+Mw/w==
X-Received: by 2002:a0c:f991:: with SMTP id t17mr370061qvn.6.1609865155307;
 Tue, 05 Jan 2021 08:45:55 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id a9sm301843qkk.39.2021.01.05.08.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 08:45:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Fix memory leaks in S3 resume"
Date: Tue,  5 Jan 2021 11:45:45 -0500
Message-Id: <20210105164545.963036-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>, stable@vger.kernel.org,
 Andre Tomt <andre@tomt.net>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a135a1b4c4db1f3b8cbed9676a40ede39feb3362.

This leads to blank screens on some boards after replugging a
display.  Revert until we understand the root cause and can
fix both the leak and the blank screen after replug.

Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Andre Tomt <andre@tomt.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d2e334be87a..318eb12f8de7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2385,8 +2385,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
-			drm_connector_list_update(connector);
+			drm_add_edid_modes(connector, aconnector->edid);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
