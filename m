Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1485C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 13:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B5D10E997;
	Wed, 26 Apr 2023 13:11:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD87410E04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682507927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D7k9+FthuusJl7if54fxaYap+uFJWroS2RQ6a9bGb4Y=;
 b=UsK6itzuHAEJjAUvSgc3CD49PlveMMUaU+Q4FMPZwv5TKK28OUCdSv4x3DtHAs1/ndowfO
 bKDTs7W/DowhlqHu4t58DUcBUQk2/rzIGJ0x8hbsKTnejkz1/Odp7ASpfWHV2Hisl6IrX1
 F/pKhkOkGqL6AMjNVWifMsVc0T9jlOg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-nVh_hQp4Onix3FUZ0UxS6Q-1; Wed, 26 Apr 2023 07:18:45 -0400
X-MC-Unique: nVh_hQp4Onix3FUZ0UxS6Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-5e7223aab07so42920196d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682507925; x=1685099925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D7k9+FthuusJl7if54fxaYap+uFJWroS2RQ6a9bGb4Y=;
 b=K882hhvDq4uI2Hq5r8xj7gHryPX9JNZ6MaQi/uHbcMgsL5ROTPIfRzTiCAeDEwq9oI
 DUbS1sGoqZd+zcKSvYFFcHWhHWrw/WzYc2zYd7WZACdqP7l20FPJY4eBzF49JDeli1nk
 +lb6dS2E6wnJcYYTS7xBTCqHiWH8eUmvIvgier0LQh+VSIG3nPlsZFGSLMTpFyElN+yi
 I+OnATJ/Yh1oYnhMjTrLoaCr0Th5gD4iLiYm/jPWdjfmVQxzAWNPs9X1eYEp5hTki8sc
 5MfXk6NU3hK/JPsuuH/HNhAvu/CfjXZUEWK+WGa9SvLoRLH/3guB+weXRZc9VtWqK3an
 wmMA==
X-Gm-Message-State: AAQBX9cLFLcGGOrORvP0WIreRZmlLGXtHW9wouQwib5Q0sQExI9Pa74i
 th22KmZTUjvWx44V4krTIPt1WU7uo49OegsMLf2WmR9nVm30UjSEl3i8EAcQkr4QSXDtPjAKqEc
 r9FkSo32NzeE2QSAFuqf7SRf16w==
X-Received: by 2002:a05:6214:262a:b0:5ef:52f0:7b1e with SMTP id
 gv10-20020a056214262a00b005ef52f07b1emr36095418qvb.31.1682507925367; 
 Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yei+ST19kHCsL3KHPalEzKbRARMslLTCav5d681fG95b97NunP1uQSjWSZdSykEIvd9sYpKg==
X-Received: by 2002:a05:6214:262a:b0:5ef:52f0:7b1e with SMTP id
 gv10-20020a056214262a00b005ef52f07b1emr36095368qvb.31.1682507925004; 
 Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a0cf551000000b005ef59a383e6sm4789002qvm.119.2023.04.26.04.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Apr 2023 04:18:44 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, qingqing.zhuo@amd.com,
 hamza.mahfooz@amd.com, Josip.Pavic@amd.com, robin.chen@amd.com,
 alex.hung@amd.com, dingchen.zhang@amd.com, jiapeng.chong@linux.alibaba.com
Subject: [PATCH] drm/amd/display: set variable custom_backlight_curve0
 storage-class-specifier to static
Date: Wed, 26 Apr 2023 07:18:38 -0400
Message-Id: <20230426111838.728441-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 26 Apr 2023 13:11:15 +0000
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:119:31:
  warning: symbol 'custom_backlight_curve0' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 68d95b92df76..30349881a283 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -116,7 +116,7 @@ static const struct abm_parameters * const abm_settings[] = {
 	abm_settings_config2,
 };
 
-const struct dm_bl_data_point custom_backlight_curve0[] = {
+static const struct dm_bl_data_point custom_backlight_curve0[] = {
 		{2, 14}, {4, 16}, {6, 18}, {8, 21}, {10, 23}, {12, 26}, {14, 29}, {16, 32}, {18, 35},
 		{20, 38}, {22, 41}, {24, 44}, {26, 48}, {28, 52}, {30, 55}, {32, 59}, {34, 62},
 		{36, 67}, {38, 71}, {40, 75}, {42, 80}, {44, 84}, {46, 88}, {48, 93}, {50, 98},
-- 
2.27.0

