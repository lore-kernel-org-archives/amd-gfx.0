Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C1C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 21:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B3204EA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 21:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLt5tX/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B3204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E356E960;
	Thu, 21 May 2020 21:38:16 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864C76E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 21:38:15 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id f189so8824818qkd.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wzskOGVudw8Rdlbz4T+OvYlXR9DGQ/WumPRU+XrZ7zI=;
 b=uLt5tX/lMFg7MmA8o/ky3q+KQqKZ7qGLer6OV/RdvaL8W34UZ9ohBFYEZBHDbmg3mk
 9wEdc1Nv6Ghs5LT29XBsuWUClvrBkwnK/6vFIU4DvuCVXFEEMRGHPM5LZGvfZHh8xSTt
 wrEandd+xs8yIpIMGSfSi/HlpcFhEyvq30n+byVP8CafJCtbz5852Kc3DZdwfE62i0Aw
 ukMimBhuFSi1t8gTRTBtbqXEPU4PswbgKVA1ONcDYuAt1x6h0Z7U42ZS9hqaNg82Tc6/
 o5XV9XfI4eLjaVNCCRptVDK90At1n+cY12I0k0L7VS/5hdaurbPcMzKuSsa1Bzg92DOS
 SoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wzskOGVudw8Rdlbz4T+OvYlXR9DGQ/WumPRU+XrZ7zI=;
 b=AsJGLoGem/0z0hb0regFV3SS1zRbSu/x04BGkNWvJdgTTe0s2zL4Em0PpCYTZMYaOX
 MCQv13NRC7Rzt5ImWXw2/jm8tiQBPQTxFmRUmQoo3MdYlQ22qwnz1n8JBHqeL4rVmcVB
 46kqQW25+avkDSbw7Y1uCmaChwJqR+u5Wp4LjYJz3NbkG0Q5V7J6x6p9tB7EeKI/TsAi
 tnfLJ972VNXMhH+1302ouNmZIhThFxvexLhFLvCDPtDtWQhPHLK6nfWzKFKx6mWDvK8v
 AkjkuKYHHQtVy71jCHYtHPW3maYjkm/d8RJ6mYrCfQwStnVOcnx3E6TKAn63iecRvsAi
 +Meg==
X-Gm-Message-State: AOAM532HrPDyMMdDVG4Yn++p1eVp/lh52MdRGVlS060f3RJuYYkjdzaX
 GDwVN0RVYbNSlV2+u9CJDNCoRyeO
X-Google-Smtp-Source: ABdhPJzcmKrIJ1HjXwUIfG6ipp8zzz5uWyLGuQQME8RElo9TTE0Hsnr6aprBh5Cs0gHhMXngTJXx4A==
X-Received: by 2002:a37:a603:: with SMTP id p3mr11306086qke.133.1590097094426; 
 Thu, 21 May 2020 14:38:14 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id 4sm5439130qky.130.2020.05.21.14.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 14:38:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU
Date: Thu, 21 May 2020 17:38:06 -0400
Message-Id: <20200521213806.4016-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

Reset the SUPPORTED attribute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

This fixes multi-GPU, but I think we could still race without some sort
of locking around the attr array.

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index e06fef6174e5..4c65444e9ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1790,6 +1790,8 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 
 	BUG_ON(!attr);
 
+	attr->states = ATTR_STATE_SUPPORTED;
+
 	attr_update = attr->attr_update ? attr_update : default_attr_update;
 
 	ret = attr_update(adev, attr, mask);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
