Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ABAC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 13:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C04310EC47;
	Thu, 20 Apr 2023 13:24:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBB910EC45
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681996894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pvqliZRx3bFZXXj3TRlgYVKcTGcdvhWSve5Bdh4PePw=;
 b=WoCnfBBE+P1k9rg8mPjvCY4fRjclPLf0tgGglaFnOXWVhzWXxzY1dp2ppB8Fakk8EpwPer
 qzCxktIY3XygTfVZaSRSp1X5a19Jc6oWFcMrtWDQf/hUxGP7jdRcyTR0OEdrwR4h2sRsRl
 iP78zajLav1nfa9+Um44YWGEfBY0FIs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-J3is9vTsMl2WLYm6OrpQWA-1; Thu, 20 Apr 2023 09:21:33 -0400
X-MC-Unique: J3is9vTsMl2WLYm6OrpQWA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3ef566e9879so4949171cf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 06:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681996893; x=1684588893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvqliZRx3bFZXXj3TRlgYVKcTGcdvhWSve5Bdh4PePw=;
 b=XR67Cbjybw8H2dJaJzn9YMFqQuC1ycO5gGuRm3Ie2SiPlKIXNJkMa3hXd0wmPuOr+E
 qKa+wxYG3bXr/IvCy+rTcman/I9R6AM1GqTda8J7MfmapGjTCMwDJTfL52Gbg2qbaeSP
 ZRVer7m3ZcGdajdA5X7JDajLBHykIDic2C/K5d61KEzc+jscGX6AwYKWD+wYfaE1MTYi
 xqOertXSpVGXxyc2bSNueYpArrUQFd5G6Zv9iFD7Af5hXL1Fh/sEjND6R34vn+CvfzYm
 +f8qzhDGuDQt31vLfB6poL+WFkKd77LIUoSptUYtQ6nBp3BNH6sE4f829KdLuxsAhTJg
 6nBA==
X-Gm-Message-State: AAQBX9f6zfE3w11bLakVPUIaAPO/Frzqaxpm8vt25aMCig9sBH8B3FvK
 rKyr+Qy3uHuh2XcAnktaNLL3UK1UFuVq0jAUKgF157k7/QxDO8l0geD6VlJyiNHdHTg1aDOTKIh
 aOT9yXVJfZTbhr+Z+xCo8VKym0w==
X-Received: by 2002:a05:622a:1:b0:3ef:38a2:9fdb with SMTP id
 x1-20020a05622a000100b003ef38a29fdbmr1373155qtw.60.1681996893053; 
 Thu, 20 Apr 2023 06:21:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350auOzQ5hmP9e5U0LJ8lAJnmKf51VGzZATeBmsYh5r8XbqdU4pHx6XuM5qDCF95LyqUWmJx0nQ==
X-Received: by 2002:a05:622a:1:b0:3ef:38a2:9fdb with SMTP id
 x1-20020a05622a000100b003ef38a29fdbmr1373127qtw.60.1681996892824; 
 Thu, 20 Apr 2023 06:21:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a37f702000000b0074acdb873a7sm413158qkj.86.2023.04.20.06.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 06:21:32 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Leon.Huang1@amd.com,
 wenjing.liu@amd.com, qingqing.zhuo@amd.com
Subject: [PATCH] drm/amd/display: return status of abm_feature_support
Date: Thu, 20 Apr 2023 09:21:29 -0400
Message-Id: <20230420132129.3888917-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Apr 2023 13:24:05 +0000
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

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:
  In function ‘dmub_abm_set_event_ex’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:138:22: error: variable
  ‘feature_support’ set but not used [-Werror=unused-but-set-variable]
  138 |         unsigned int feature_support;
      |                      ^~~~~~~~~~~~~~~

This variable is not used so remove it.
The status of amb_feature_support should have been returned, so
set ret and return it.

Fixes: b8fe56375f78 ("drm/amd/display: Refactor ABM feature")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index a66f83a61402..8f285c3be4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -134,10 +134,9 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t op
 static bool dmub_abm_set_event_ex(struct abm *abm, unsigned int full_screen, unsigned int video_mode,
 		unsigned int hdr_mode, unsigned int panel_inst)
 {
-	bool ret = false;
-	unsigned int feature_support;
+	bool ret;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	ret = abm_feature_support(abm, panel_inst);
 
 	return ret;
 }
-- 
2.27.0

