Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0861C54EAA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 03:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C01E10E3E2;
	Fri, 27 Jan 2023 03:26:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F04110E3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 01:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674783513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZaWLbVYYzGv21vJO7aGswdiJnWhUW0nGAziQI0ZtQyY=;
 b=O6xmflnlnNYsQc6v7552ELIS6XWueVcPW2wFmLYrDd3ghk7IhZJcHeEGHixSS2V+9phwSQ
 uUh/Dge9ISSjSBBVlCipxsLR/TTiVzhLVz+gtctA5A9ZoZT3QS+izltxoYSx7BKmQfCVRh
 H7KVj0nzYCjkzWEZSN647Hu73S4Z0W4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-wYbwcWffPDChZTk587D2rA-1; Thu, 26 Jan 2023 20:38:32 -0500
X-MC-Unique: wYbwcWffPDChZTk587D2rA-1
Received: by mail-qt1-f200.google.com with SMTP id
 bp43-20020a05622a1bab00b003b63be6827dso1615408qtb.23
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 17:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZaWLbVYYzGv21vJO7aGswdiJnWhUW0nGAziQI0ZtQyY=;
 b=ZKu1x6xqvt/GqLLlxROGoeZPcHUjfu/wf+Gh+wDf2XGj0P2z5kx1puF2TNfHf+PkwQ
 0wyKHh1M62qVDQV6TZo9DzbiAMYIH5Sp0jOcgZcPSzxg6oBtrZM/kfKI5pqgqdfSzj3M
 z0cs28f+pyBHpA2kJ9uK8GX/2JZuJcUY8QgMwe/cFiQokPln+w6Ipppis2zVRjXnzOpJ
 pr6Uo02KBZnQziWyvuP9hFWFnt7kXwEJ5/7kwVRxtRAc0/kX9FXWeA30IjsjuhMjxbNC
 j7UVC3LjVE1E4NYGZiJXgFhjjlsZOlKPclbcetILNezrzlQaHrUBmRmQYQKThfwcs8JI
 pJWA==
X-Gm-Message-State: AFqh2krV23IHcVYpStDO+rtQNLOE3+txAxdXuIir+Y2VlRz67tYkjnOK
 eD7tcq+Znzns4QIrbQw2dxldwoX2/MLrDoX5CIX7hM/dKNwuSDn+MOGH9Jpj6iD+RV+AsPY9mXH
 wuzAzqYiRdezo3n/WyKJYx2KEpQ==
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id
 hf14-20020a0562140e8e00b004edfb729186mr82795461qvb.0.1674783511681; 
 Thu, 26 Jan 2023 17:38:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvj0I8ZKFown/tFr5t6mdJxPm3gmzyISiA4AAWzoztipBf2zfexnkIA+fwENP+IzIKg1Fl40g==
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id
 hf14-20020a0562140e8e00b004edfb729186mr82795411qvb.0.1674783511392; 
 Thu, 26 Jan 2023 17:38:31 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 dm30-20020a05620a1d5e00b00704a2a40cf2sm2013364qkb.38.2023.01.26.17.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jan 2023 17:38:30 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Anthony.Koo@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, Roman.Li@amd.com, wenjing.liu@amd.com,
 Dillon.Varone@amd.com, mwen@igalia.com, dingchen.zhang@amd.com,
 martin.tsai@amd.com, aric.cyr@amd.com, Wesley.Chalmers@amd.com,
 Max.Tseng@amd.com, sivapiriyan.kumarasamy@amd.com, Tony.Cheng@amd.com
Subject: [PATCH] drm/amd/display: reduce else-if to else in
 dcn10_blank_pixel_data()
Date: Thu, 26 Jan 2023 17:38:23 -0800
Message-Id: <20230127013823.832698-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 27 Jan 2023 03:25:58 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

checkpatch reports
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: style:
  Expression is always true because 'else if' condition is opposite to previous condition at line 2895. [multiCondition]
 } else if (blank) {
            ^
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2895:6: note: first condition
 if (!blank) {
     ^
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:2902:13: note: else if condition is opposite to first condition
 } else if (blank) {

It is not necessary to explicitly the check != condition, an else is simplier.

Fixes: aa5a57773042 ("drm/amd/display: Vari-bright looks disabled near end of MM14")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bb155734ac93..f735ae5e045f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2899,7 +2899,7 @@ void dcn10_blank_pixel_data(
 			dc->hwss.set_pipe(pipe_ctx);
 			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
 		}
-	} else if (blank) {
+	} else {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 		if (stream_res->tg->funcs->set_blank) {
 			stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
-- 
2.26.3

