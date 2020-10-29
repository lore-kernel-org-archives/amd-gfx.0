Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88038C5DF9E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140BA207DE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT6cCg/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140BA207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0660E6ECC2;
	Thu, 29 Oct 2020 13:17:04 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F45D6E0DA;
 Thu, 29 Oct 2020 09:46:54 +0000 (UTC)
Received: by mail-pl1-x644.google.com with SMTP id t6so1018985plq.11;
 Thu, 29 Oct 2020 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AYPEHTouurF1cTcYUar98MQMwBtfappOluNio1ar5uI=;
 b=FT6cCg/TyF33N24iefJhPYkrUdJUIMG9w8XzUmMXPt/B67H3VnLcxkvGAe76NsVVpc
 31Sx3VY+TSqi+EdQ/L3WImdWmMxzFCgKeUyDuOGoKtMYQjyQvhbz3r8jWXYLX7yOf/ku
 ZGyarUSm/j13GSwmYfPIsnO8Tat0QsKD9bZePu5o5cYljD9o0bHrcAWKgi9dxqgCVAxa
 uiilL86xFx4TMJUVRZDjbp4CUATO1kE2sBqy++veKhDQvK/7iDsz2dEKftaYXhdxwFpr
 UWB8FkJ85g2o8VXVfzr9uEjfEXISyBH4s9/ygZdoWigqdK37uYuFULZJKmzHhhGWahGo
 xhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AYPEHTouurF1cTcYUar98MQMwBtfappOluNio1ar5uI=;
 b=GokaEEwKNwO1yG5aXuZZZS4IunOMlO3KSrPpkfgh0W49NfxUmvb3F2iGnrzFWHoGFY
 a/6mZmUHpOJsCivNes5UrdnTHBzcHKMUEzEjcN67PKgsdi26QPya/9ehhEdpizZbWmdt
 UK/CUeceVhxfKnkORFQFhWrjMcy9H3q+uiYLNS2kSx19kKJCukbt23XSYw5WE0KMfYkq
 ljwpA5P4wtilhlTgqKry7GA72Ht2aJqnm8wEOV284Z6yhn/U6KVQ/GhcX33gdXNLLg/V
 kPSNwLVMJMN2YYJ5D1Six8fS/ickfWBuSxmiP+ircyEH/AJ4sIL+J3wfjcLDnEt7pynZ
 z9IA==
X-Gm-Message-State: AOAM533slGpxObYYXMLyPMvsi+TtsC7yk+xpmUXSBt6EDrNMb0Xjzbya
 rH9ElP45aioiul1ERWSjNdA=
X-Google-Smtp-Source: ABdhPJzMMslfXX/O2/ZByYkV35XMo8LFDyOwhWwNQve6kdjZQT7DRckAa2snIGRQsiWbAPY0tNHNnQ==
X-Received: by 2002:a17:902:eb14:b029:d6:5a66:aa31 with SMTP id
 l20-20020a170902eb14b02900d65a66aa31mr3050480plb.53.1603964813977; 
 Thu, 29 Oct 2020 02:46:53 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au.
 [43.250.207.1])
 by smtp.gmail.com with ESMTPSA id d10sm2052270pgk.74.2020.10.29.02.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:46:52 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: harry.wentland@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: amdgpu: Correct spelling defalut to default in
 comment
Date: Thu, 29 Oct 2020 15:13:46 +0530
Message-Id: <20201029094346.14185-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 29 Oct 2020 13:17:01 +0000
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
Cc: gregkh@linuxfoundation.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct spelling in one of the comment.

s/defalut/default/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 CCing Greg becasue it touched drivers file. Trivial though.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8cd646eef096..cdc8dd220a77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -556,7 +556,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	bool disable_hpd = false;
 	bool valid_test_pattern = false;
 	uint8_t param_nums = 0;
-	/* init with defalut 80bit custom pattern */
+	/* init with default 80bit custom pattern */
 	uint8_t custom_pattern[10] = {
 			0x1f, 0x7c, 0xf0, 0xc1, 0x07,
 			0x1f, 0x7c, 0xf0, 0xc1, 0x07
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
