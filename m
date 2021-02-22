Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 20:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6185260C3D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 20:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6185260C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FD86E155;
	Mon, 22 Feb 2021 20:13:18 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E336E1C0;
 Mon, 22 Feb 2021 19:25:43 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d13so8372269plg.0;
 Mon, 22 Feb 2021 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=81xQbFqBfVM1puf6rirIzmcmTzQTCjqHgWWmAXvQ39A=;
 b=Xe30GRGYqLFy4shszF5sc+bWsKntX9Tqn20gS/o/ADejUnn9xqYjoVeWvve0El8qez
 aL9zOnJx6ipjj1Dag0qdQz+gAO06L30TpcqoXyVsU+0wdB9/AmhoiVvItg63DpA6S1Fj
 uKUWwTvCTbMjxNesuAQwV74tuUziLXyrJa5c6NHhFHRg63k40bfUOe64KqWF64Z5fn19
 RUxwgrCnDc5HdZ7JQcmPOrcRjrS5bRiq98KuoBk3bhgef/Za25niuPzyhs03zLYuZ94F
 gYGg0JNH6BgvHikaD7SBCgQElGmPlR3VEL3TU1uteP6uv8h1YWE2O9O3a93fPEreNS3g
 Qtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=81xQbFqBfVM1puf6rirIzmcmTzQTCjqHgWWmAXvQ39A=;
 b=RB6Lton+QKjFIQLWoMaAG2iU1XMmhiJSVVZcsfOA6XrxNISNWK14Gox9tbczRtzlrI
 KKWJNjmGu0SlUNw1utSE8xOo36VQbGgdqfJG24cuknASOUyKaOh0MBeA0aYgVws2GQqO
 MFAJWCF0ICZm0tnhFbqVEGQTbsdlHG+w6GHrMyIuNuCl8IcxWj+FercMpk5J1oL0Sga/
 cnJR4aF/3xuMS8YA7hYeUXRwGCdvV9B2Jjhc32G41W1PWtbO2vLmleoom43772rUoPrH
 gBBFRLTxtwjEwCqh2qSSfEsqcaGzoWZpaA6xqnQiD6RkH78PLXTMYUXPB5dwU4hyN1z8
 unDg==
X-Gm-Message-State: AOAM531xdg/YR5JUyMO9sIgL5TuWTydFcD6/OZRhIkXUMDpJte2ZAeCN
 bFKyKy0EiG4AyvDcE7Av2TY=
X-Google-Smtp-Source: ABdhPJwEunPRjSK3BfE+NLfURtzUMi+jTA9Vtz1FGyEaxZ2W0EhobibVFFUKsK6oezqOoTVluC2chw==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ec4 with SMTP id
 n14-20020a170902e54eb02900de8c702ec4mr23952108plf.56.1614021943492; 
 Mon, 22 Feb 2021 11:25:43 -0800 (PST)
Received: from localhost.localdomain ([49.37.83.164])
 by smtp.gmail.com with ESMTPSA id 184sm18688831pgj.93.2021.02.22.11.25.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Feb 2021 11:25:42 -0800 (PST)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 nicholas.kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
 aurabindo.pillai@amd.com, stylon.wang@amd.com, contact@emersion.fr,
 bas@basnieuwenhuizen.nl, Bhawanpreet.Lakha@amd.com
Subject: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Date: Tue, 23 Feb 2021 00:55:31 +0530
Message-Id: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Mon, 22 Feb 2021 20:13:18 +0000
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
Cc: Souptick Joarder <jrdr.linux@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
>> warning: variable 'i' is uninitialized when used here
>> [-Wuninitialized]
                           timing  = &edid->detailed_timings[i];
                                                             ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   1 warning generated.

Initialize the variable 'i'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a22a53d..e96d3d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 					struct edid *edid)
 {
-	int i;
+	int i = 0;
 	struct detailed_timing *timing;
 	struct detailed_non_pixel *data;
 	struct detailed_data_monitor_range *range;
-- 
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
