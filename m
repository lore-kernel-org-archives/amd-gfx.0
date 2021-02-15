Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BF164E0F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BF164E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A136E0DB;
	Mon, 15 Feb 2021 18:32:51 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB6489F89
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 18:32:47 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id d3so5443753qtr.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Jk11fxXfaNOmZ4FItu7OonkV1OM1LGAjwjFQ1i1HbA=;
 b=PALPAuaevF1UKbPNyYpBEDVt15jn8ia2mVMnZSFTLtI15Iabd6KjAJLjARbf+PWSTk
 ugWkpCpfr6IhpoUsN4tb6LiCEd3u6rZeJHdFsgqyF8EOFxSJIaGf+cQUT5yUOqxhwSfg
 L8211q6XGQzaW3miLJXqxwu+GuqPTftAM8rFYo1Wrvok7ce0DZijKNVdBG2YNyKymITw
 wG6k7tkwA+L/zj7GSg+nT8rl83YRnPv0NrH//of6BlbbxD18ZjOfeb8yOwmOy9wuCHCc
 7f1SzxA6AbEYkB/CGctWEbnaqlpEDE9CNtA3SxsphXh22B0vvhU3Ff+mzXfmQY89D96a
 MPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Jk11fxXfaNOmZ4FItu7OonkV1OM1LGAjwjFQ1i1HbA=;
 b=Z8FAXNc+EIVv0AcueR3zUEn3yktL5QLGYPKN2POjRfsHmLCdD3nz2QcnQsqAxiEL5L
 lLa0JJewYRFWjQIOQxPI+uQ7PKSHS/ZqU9FL7mFqA38dvGD1JKy+dhyizEHAeO2+sDEo
 tUqxUWsHaL4gcjjVQqX1CNxEErX3guiHGo/FpkfaMimGakxExc/yY6wlAQL6/xPZy8wf
 6BPM3gcHpr/GFJSlwe6RRomt2T0oDy9MoWBBT64/uLV58iaJdvOdKChnz3Cy9AX2U6AN
 7yF2HU3SOotYEtbRuRjDoZuRpL7uewqtsF5nbsKbOEmFrtrSeT1i8j/KIyPJ1papfs0y
 sYvQ==
X-Gm-Message-State: AOAM533+KgyIYMwb8HWtohXnII49cj4EqV1X6mXK6usy9qWEMx2ovL1Q
 ANqzymCXrdAu8wy+7XHkNCa+cUPcO6M=
X-Google-Smtp-Source: ABdhPJzmICj53hk4U3PBCd/Q7VMRfMCYgJytY2CpwWfZnZMStx1bm/ix8tI793vXYXSIv+cU+fpM8A==
X-Received: by 2002:ac8:d44:: with SMTP id r4mr15249707qti.7.1613413966779;
 Mon, 15 Feb 2021 10:32:46 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id 76sm12859275qke.95.2021.02.15.10.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 10:32:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/display: don't assert in set backlight function
Date: Mon, 15 Feb 2021 13:32:29 -0500
Message-Id: <20210215183230.911939-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215183230.911939-1-alexander.deucher@amd.com>
References: <20210215183230.911939-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It just spams the logs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa5059f71727..bd0101013ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2602,7 +2602,6 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 			if (pipe_ctx->plane_state == NULL)
 				frame_ramp = 0;
 		} else {
-			ASSERT(false);
 			return false;
 		}
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
