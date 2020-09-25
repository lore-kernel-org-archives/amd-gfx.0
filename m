Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67403C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A05923A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMQLX/bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A05923A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306686ED5C;
	Fri, 25 Sep 2020 20:11:13 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3667A6ED58
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:10 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id n10so3093623qtv.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EB7HmA9Syj4zn/qY8ZSbYdT7tKQDZsSgGwYkJ1ZdUeY=;
 b=bMQLX/bORALt9ncrL2oD+RUPtMKIFofon5tMjuxvvVfgAyQfGMkIPLEWQTvxHxxdUr
 T3wyFhII4QofkykOSZl1uqnMYLpgapx6gg+yTkndJV13n93YojZqi/E8I2Th6gIYxwbK
 UNchTwC4mYxObFCi5Z3YiylnJUZM2iAu2EdxZJHhLAsc5aG1di5wtdkr1FJWuFNw5t7F
 gRYbVysOSWvpoul5JKTOjT9SDjkFSj8O2r6S5LvwA4ugHfyZHq0+4gU7pqzXnm8M5khJ
 ItUyolGsQdlpN8dmMD77MzqVG7CUh03P1Bj3htSzwQ2ettGX69IsGJuHA/v6Z1D92nFk
 rl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EB7HmA9Syj4zn/qY8ZSbYdT7tKQDZsSgGwYkJ1ZdUeY=;
 b=SmhdDbc2pCpwseZzHQMVgXIqUxb1aqEnVXb4cLYFzWk0PoY7R5MYdBcdvjsfGyKGoO
 Fah9P9wdz3pJnmcOTm8kr3MABxj1kidAUxc7ufnxnvYQsuK7vcy7QPMaF0Cc+9TcdR41
 D36URQeOraHuzl0iZCARAojR7FDCzTo5TIDOCqdgjRrjX/vxrHfJQ0IHGYswyEZzhHRy
 gzSnJAsrkc953nsMaeFzZm1VorAnBZTxWC/UJnPW/Ed3ITmuMxit5aSooVUnqCKM91yx
 VP1rbtUYyNj8b+7TqJFLD7r7YKcd6ISfn5Xkav2vz9f88dRy69ECvQ2Wbxv92sDPOLLQ
 U4DQ==
X-Gm-Message-State: AOAM530u8KH6NMMZVBwuY0l93uoXCKJpj/8IkvECmT6BoIc5069TYtS9
 q0KGowvRqyia/BLfjLenj8dqfyQfzFk=
X-Google-Smtp-Source: ABdhPJwg/yHfV5mVdO4wcWClqriMQX2gSxu28kYI48+iwK9LQLAe0Xq/fN/B6KChtSaib16ZSPlR0A==
X-Received: by 2002:aed:3b78:: with SMTP id q53mr1431539qte.195.1601064669208; 
 Fri, 25 Sep 2020 13:11:09 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:08 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/45] drm/amdgpu: add uapi to define van gogh memory type
Date: Fri, 25 Sep 2020 16:09:54 -0400
Message-Id: <20200925201029.1738724-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds van gogh memory type as DDR5.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8d416188ddb3..d98d4e6f311b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -949,6 +949,7 @@ struct drm_amdgpu_info_firmware {
 #define AMDGPU_VRAM_TYPE_DDR3  7
 #define AMDGPU_VRAM_TYPE_DDR4  8
 #define AMDGPU_VRAM_TYPE_GDDR6 9
+#define AMDGPU_VRAM_TYPE_DDR5  10
 
 struct drm_amdgpu_info_device {
 	/** PCI Device ID */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
