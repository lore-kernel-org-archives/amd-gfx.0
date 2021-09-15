Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F141C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C50260FA0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C50260FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E4E6E9B2;
	Wed, 15 Sep 2021 16:40:44 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E386E9A3;
 Wed, 15 Sep 2021 16:40:41 +0000 (UTC)
Received: by mail-io1-xd34.google.com with SMTP id b200so4215076iof.13;
 Wed, 15 Sep 2021 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qA3NUvyu2tGFNX7HOAxu/xgx9RqpGEBzMRUtatJOsnY=;
 b=ZA7WbZMWdvlReOmZg5VAjoX3Llx5z7hhLnLehyJPA1dIdO3kXdcH5ktrqlZ2b8KTBg
 3ynx0SaVeDQ6zclboCS28vdU+vSenXA6WhQBLGos65K77G6KmTc5X7H+HBFBIGRP+Lyh
 6muVwfzshVOY/bsII5VbXeNGBZL32D4cioswF/DexD4NAJIZOgLe4PXJ2+eEV6uRqi2B
 YR5FtuMGO64M95epTyJFHBY86Ao0Ou19/wiXvGI/0xZ/am4GcYEBp7cLlC+IX6N8bMm8
 11bp/+gIxqDZcC7OLOMdzXx+l4lyxqKSc9d/6vJmXWddynl8EORL7Iw1mW4V9qjdFA+8
 2F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qA3NUvyu2tGFNX7HOAxu/xgx9RqpGEBzMRUtatJOsnY=;
 b=sGAMmaxX4RuF1RrUUJ6JoONbc8MGxgAx/rm8HLwyvQ2t0HNrADps9ePaJlDOgjNFuM
 VYUPuF7iuFRkjEnSmjIA3zy0A5RTz9IWuAgEveOzebrIiSJvsPwSV6pIf2LlyulMThVX
 2rKuThE/M9Y4PuHmhgK827yiuKkKI8yeGmunBAd2JlpEJggFDrB23QkB6PdoLUyOW0k4
 PD8mtFaklxFToA0lAxc+0p+aXToEHoOYGTJN2/7rhBy2UlWFFeBShQPGfg7pB9oRzp4/
 YSOhmht/DQH+ucf3aeSt38X1197KLLEgemuWK5zvLu6P1BPyVNXc5LIZsF8edzaL7s3x
 XOPg==
X-Gm-Message-State: AOAM532nLtRrRcy85Y1R17IGx4hIwbqH1q44rY4gztjVQ3YlEhHeSwLu
 GYVQllYRZ6xTfm9jx9dAyLE=
X-Google-Smtp-Source: ABdhPJwiob+KURo47U02bjMK4Ia5YLfcFSgmPIO+vMOvLDaPOh5EBN3EFlEEzVGCYJDWJrkIrZAX/g==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr801842iok.36.1631724040419;
 Wed, 15 Sep 2021 09:40:40 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
 by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 09:40:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 09/16] drm: fix doc grammar error
Date: Wed, 15 Sep 2021 10:39:50 -0600
Message-Id: <20210915163957.2949166-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

no code changes, good for rc

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b439ae1921b8..ebb22166ace1 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -522,7 +522,7 @@ void *__devm_drm_dev_alloc(struct device *parent,
  * @type: the type of the struct which contains struct &drm_device
  * @member: the name of the &drm_device within @type.
  *
- * This allocates and initialize a new DRM device. No device registration is done.
+ * This allocates and initializes a new DRM device. No device registration is done.
  * Call drm_dev_register() to advertice the device to user space and register it
  * with other core subsystems. This should be done last in the device
  * initialization sequence to make sure userspace can't access an inconsistent
-- 
2.31.1

