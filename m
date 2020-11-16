Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D12C61DD8
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4904204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwu5Oe3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4904204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A72389D7F;
	Mon, 16 Nov 2020 15:11:48 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5483A89D7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 15:11:47 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id o66so3659331qkd.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VnklGGZGvqyucBiWuraWq66FndKZrdf5BDQzKmUKaQ8=;
 b=Qwu5Oe3rRYFnp2Hol0fgwMEl/BvSre6uJmyEWk89mQcmRlaZ0+IkfL2/qTNKl+Rubo
 vW6MuUt93qjmsjwlQFTbZ06u+xAqzev8N77yitqIHiE5nKndi5SXFWaeODlip3NwHGgE
 lLSj4w9UohS/FCX40uIw1Q2bjskNjW7x3wL1AWTrsbrbUl3Ip466qK5sqrpXk42OKjuN
 cGmqBb0gedV9YHpD2vjnQs6MmFgr6R01XE6c+M7kWnkwsYg+IYy45IioeJVdo0SguzV6
 f6zzwR77boKxzW21Iv7VxUwRLcBjNaigTr59lU9QYykq1buz5FEojER3Nn2WiJONIhwI
 fGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VnklGGZGvqyucBiWuraWq66FndKZrdf5BDQzKmUKaQ8=;
 b=kmty1V3TbiYKYONHgcMVyLeFOchQlBSRqbl6OpreAnJ64CoV6RzETmileqP41OTfxh
 1M1iSTV/nbL88V3Sba9wSU91jLVHAUwHNHYClwGfBu4YRunWJGgYjJsAQaL9yIZWu1gT
 u/tyIjUhWCs3vu2Yzk77tXcLIlcNajpFfekFCodWvDr8PVNed3wEJJ7IRp17XJc6fYIb
 cV+k0OFs5QQ6gpUANafvaJ22aV/ZKVbHXERH6zEuIIHVOmcq+pxaT9VDviVhV6+CPwhH
 n0TdDQ1JH+LXkl7vKH/67lJ7Yxh6mVCx/wIjjNczV6oyg1o7mUdsI9jSASihyoESpaDE
 6EPQ==
X-Gm-Message-State: AOAM532Mi7nqFxStZeZsMxrGaWtIsX3Z6qugfCCvVHHk/UoSYThCEAJR
 M4bBWONO+Sqmyewd4FrqO9hMvWcUA/A=
X-Google-Smtp-Source: ABdhPJy1rPlGEc9s9sijrwRqr5rODML37fzJwX0WCVVJ7Kospy23s99sJgTY6phbhnUchg8qq3q5hw==
X-Received: by 2002:ae9:ea14:: with SMTP id f20mr14556039qkg.239.1605539506299; 
 Mon, 16 Nov 2020 07:11:46 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id 9sm11499289qty.30.2020.11.16.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 07:11:45 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove experimental flag from arcturus
Date: Mon, 16 Nov 2020 10:11:38 -0500
Message-Id: <20201116151138.1532420-1-alexander.deucher@amd.com>
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

This has been stable for a while.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 26cf369003e1..4825b33f83ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1063,10 +1063,10 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x15dd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RAVEN|AMD_IS_APU},
 	{0x1002, 0x15d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RAVEN|AMD_IS_APU},
 	/* Arcturus */
-	{0x1002, 0x738C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7388, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x738E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7390, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x738C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x7388, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x738E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
+	{0x1002, 0x7390, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ARCTURUS},
 	/* Navi10 */
 	{0x1002, 0x7310, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x7312, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
