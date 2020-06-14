Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C7C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA092068E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si+mBzty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA092068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4D56E0FD;
	Mon, 15 Jun 2020 07:27:55 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54F589CCB;
 Sun, 14 Jun 2020 07:09:54 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id m81so14556328ioa.1;
 Sun, 14 Jun 2020 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=VPVqWxYm5OyjOv331996CGH9YiPFKfJycn9OwXQfzdE=;
 b=Si+mBztyXLpNw+lq5vPMpNGKP0EI+ykD3vuqlK8ZNIb6UkkFhoAM75WVjN+g8jSLhX
 hIJJyaxEmiWwfH5wcCzyDLENdFDvHBlpi1xEwIQ+owxGEDnzX+6UCXw2KWm0RXCVZ8xl
 LHMyFNVk/L/xf9JlK3iCt3bsP6NN2NR0TYct1K5D9kz23w5XWNCx7UNHpAnA8vWbr1bO
 h/L769+gQ5P8lKjDPBVsZPQ9y04jqz/kxNXDWf4GQb/M9XwDh944S2JfO/qTQRhvkxcQ
 fx+jW6EaXGWkKxT8IanPZXM4TtDgFUJrWisoD06Gd19DB3bNP+utRmrfnc9BT4uoeyY9
 oTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VPVqWxYm5OyjOv331996CGH9YiPFKfJycn9OwXQfzdE=;
 b=XD72jbHdcTYtTfkfccg/2QrdiBcUBgcqUmTdiEPCSi78gnRjgqu2S/Ltf75L3fLQ/m
 xyN7pcNteZg5wiaarlYCYJep/4dJUy/pQJ9PnWyff8LCTQ9gAJahg9BvVXaS5eNxS7c8
 KU0Ca4OkKsYT/r4ngCFVGuiDvP8Em6Cgd1B1QvxwuSMDvEk5BEBzhOXTNK9lOc59mq72
 3K0PkAdQ8Q1Rvi97rUoqCUpuI8JmWB7WywT8nbRliBfhb6K2soz9FefZbbUArK2P/omv
 tVvI1IX0GCS+WSQv07brchg4UMx31DjoUfMs7wndemg2BZnHfU0Lap4qoH2jsHXvkUHZ
 dmhw==
X-Gm-Message-State: AOAM531ncfZPghexKSVcs198B4Z0h9f7w617QPZZc3Vy9lOMkT60oD2u
 RhgDE40NyFVzFTx2WJNKpao=
X-Google-Smtp-Source: ABdhPJzvR4Y9Cg+Ilsim0VN1KWZMeO3R6+hDT2mOL+p/Qnv2PztUdKChVka4CMmVHQj6eU5oQ3nwIA==
X-Received: by 2002:a05:6602:5ce:: with SMTP id
 w14mr21839589iox.178.1592118594249; 
 Sun, 14 Jun 2020 00:09:54 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
 by smtp.googlemail.com with ESMTPSA id v11sm5944048ile.61.2020.06.14.00.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 00:09:53 -0700 (PDT)
From: Navid Emamdoost <navid.emamdoost@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lyude Paul <lyude@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Shirish S <shirish.s@amd.com>, yu kuai <yukuai3@huawei.com>,
 Navid Emamdoost <navid.emamdoost@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix ref count leak in
 amdgpu_display_crtc_set_config
Date: Sun, 14 Jun 2020 02:09:44 -0500
Message-Id: <20200614070946.65770-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 15 Jun 2020 07:27:54 +0000
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
Cc: emamd001@umn.edu, kjlu@umn.edu, wu000273@umn.edu, smccaman@umn.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

in amdgpu_display_crtc_set_config, the call to pm_runtime_get_sync
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f7143d927b6d..5e51f0acf744 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -282,7 +282,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
@@ -297,7 +297,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 	   take the current one */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
-		return ret;
+		goto out;
 	}
 	/* if we have no active crtcs, then drop the power ref
 	   we got before */
@@ -306,6 +306,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = false;
 	}
 
+out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
