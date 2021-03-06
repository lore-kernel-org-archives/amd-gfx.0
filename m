Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6047C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 08:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552D664F1F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 08:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552D664F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F6B6E827;
	Mon,  8 Mar 2021 08:22:10 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632BC6E4F9;
 Sat,  6 Mar 2021 10:47:29 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id 16so2445941pfn.5;
 Sat, 06 Mar 2021 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+OVArO45cIFAZDllkGVnvJRDcrMzTd8kZJ6zshsC9EY=;
 b=cS+ut13MTQYqZC81q17e6WqC26TgE19vcCvDknXlTxQN/o/aOdlCMKbh1WS7MF7LrO
 MGpVAK9HQhFi+tImfmnY69TGVP3cjERsOmtegbYTchJy3SQyrk7FO3CmQDEO0idwbAen
 r+zfjxTdYYI0qxny+Wkr0B41QRWHAYywnT6DXK/kgqFswlcD9z81EgyG0Bc2NDr6/gg6
 JCV7ttYE0yEPud/xNvmx1iG6aG+e5c43xw7432AfpOtR0fbuO9Ag91sxptBdWhetCc3W
 dntq/r93iMWPmTNvVLUedJRUxO0fZI3L3zQD640Xh7TBlwYJs9Zm8xFaWSF8K97kDY+z
 bXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+OVArO45cIFAZDllkGVnvJRDcrMzTd8kZJ6zshsC9EY=;
 b=CWoQJz13d8iDk3CDZam+6uEPq5tafVUp5zQLe7XyaGx0k3rCGZRr+O5cXyWt6/5PlT
 kgAgfCMF6R9PHaNrlg1SE0Seak6vKbaOBgvQJcvlgrMQOQXv0xd3Woro/u/7sObe9IBi
 hBRGs4iTsyWa0qY4+8/UYSMmkreyNxVQyQXB8MD8UcZo1QKciVy2DBPl59/5yDX4hA6h
 e6CH5eoL2Z4LsprJsZHGWIyXK+vqeudIW6uzhXT4XAUKXsBrIH6X25j5e5gh2ZPL0S5B
 07gM6ptwK8oHfoQDmexypJTAZTNjVkFYuQpRQYl6ykhjqSAE0rD2KOJFxAuv8j+GTbnb
 HLyg==
X-Gm-Message-State: AOAM533fgR3QY8gEERYSa7hhOY1Ed38cP6ffWKoeM6tUo9yyKrop+2OL
 UnFi5OChzTniTfyUaNaUIK0=
X-Google-Smtp-Source: ABdhPJyjym9wsWQn1eiIbQ3l+me663Tkn6GiPbKErmB1Gshj4oPC5Bw8MUW2B9eaGSZMPxxLNd8Ycw==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr12188962pgp.139.1615027648964; 
 Sat, 06 Mar 2021 02:47:28 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id o62sm4677955pga.43.2021.03.06.02.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Mar 2021 02:47:28 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: sunpeng.li@amd.com
Subject: [PATCH] drm/amd/display: remove duplicate include in amdgpu_dm.c
Date: Sat,  6 Mar 2021 02:47:20 -0800
Message-Id: <20210306104720.215738-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 08 Mar 2021 08:22:09 +0000
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
Cc: stylon.wang@amd.com, Zhang Yunkai <zhang.yunkai@zte.com.cn>,
 airlied@linux.ie, contact@emersion.fr, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, Bhawanpreet.Lakha@amd.com,
 aurabindo.pillai@amd.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 bas@basnieuwenhuizen.nl, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is duplicated.
It is also included in the 79th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e1fd1e7d09f..fee46fbcb0b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -44,7 +44,6 @@
 #include "amdgpu_dm.h"
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
-#include <drm/drm_hdcp.h>
 #endif
 #include "amdgpu_pm.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
