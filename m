Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA73DC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 07:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8124210F7D8;
	Fri, 10 Jul 2026 07:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YfVnM561";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CAB10F7D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 07:36:54 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so365132f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 00:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783669013; x=1784273813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g4QjwxTAZcWMoicPC20mhju2EmWcZ333WEUscBQo9zs=;
 b=YfVnM561lr5+friUpbyHunYmsQprF+Ixe3nXjnsE0lW5LuQKQPuZwP3e2xSDu/vMh4
 qJu6futJFxCoTt7IAjWdXJfB810+8+85qPmQgvyW5BqKQCEGIVOUeD6Ikb5kef1FGMih
 mRtmVEDPCFyUbc9tv8OyBHXFK5I4sDhcMm4FSF7U/F6TIvxfYvCKtEfodosSqmzYz68k
 78YGUxhLQ8ZM/rPXCIqRvfILvnLOecKOSiwUPP0jRYP+qx7o07xsNTAs/rrc7XkzeEGJ
 hkAMunZbz+sJHkcAXxDglMwoLoLWK17kf+7adgfI9xbgCwUl4oA2PhI+9j3qwL2561xl
 hvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783669013; x=1784273813;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g4QjwxTAZcWMoicPC20mhju2EmWcZ333WEUscBQo9zs=;
 b=rVSKaZ+S90lKA0hcF4PTKA9TSH8rrX8+CzN9T2JXXO2A2/t5/FQg3WzR+nraWJWGSs
 yZ70u2ruSUCKgK1OMhF9VSdlb+aHFDV0R0cgg5Ofh7SpGG9jjV3KS0bPVr7L5A3kOMTE
 lNUnm8xI+CEIVwAl0KkLy3H+00tsTC6kce6VZlaYqHwTVvnldYg6riXDuwp8vDVscBx8
 74BGHcMfQfGnzniapH1EGlq/VDvXIcgrV3N+HmacRuGfdpBYD3HDvfZqBX2iThr7smGK
 eHgWcxC22aDpSQoEjKmws3kQIvqOqtLcJqLF5GG2WQr8bi46bxAgEcH8MNbrHAj1g9JN
 UAKQ==
X-Gm-Message-State: AOJu0Yy1f6ChlV6PThpG6vwV/oSi5RrB5/uhV27gbS+WyTO52cP0hCxE
 U4Yr/tQHZmhB7oXQgbNe1/6gBUycgg9TwYVlo9wLJH5x+SaHIJd4lkBYiLS0ig==
X-Gm-Gg: AfdE7ck1o/kfGzHmUVWBgJFo8C5fXkPObuafR6wtia9BCpwXJuG6hdZyGd+W4eqgvab
 Kn+ewdyHhDRr5KbxMz8ji4za8YuPkQc8YDtdmwTIGEKF/0c4aKGyuQmrIHMAF8PKdMVA8V3Dio1
 PkxV3z8KuiIcRxYO/KmD7DYPxY+gbpgxUW38TjM9Otm7KJ7ansYDtsG6dYQn4IgZAjI5Q1HyGTx
 GSSrc1T/sYwCyFLNnu3ziGQoxfPIx3sjieVD8ghFeZ434Z4cAy3g9KrhRHiMpTdO1E5BYDBRmfv
 Ka2kcD0MY+lDuYppel0T4W9PSMKKtvMzLT6D1o89mYZiB4GGmUlHpparfr4WKzb062LkTd80cIO
 Wmgm0sGP1GnyB8wpo17waMZyPnz+bjUJFogH+CJWWFiCvLzTNiBDZGqzEQ6qtfqGWs3EfqxdwEF
 6VamGw3MhzBWQBHeLkVplMYSAB9FU0pWwjdFBe7ahLsGav1pINjND6kWJMvQhIXUCMyMmA6fZHu
 TdnB2j9E1U=
X-Received: by 2002:a05:600c:1c18:b0:492:7101:3d88 with SMTP id
 5b1f17b1804b1-493e68c4ab4mr104543865e9.24.1783669012722; 
 Fri, 10 Jul 2026 00:36:52 -0700 (PDT)
Received: from Timur-Max.home
 (20014C4E24E4950000951480CE1AD54B.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:9500:95:1480:ce1a:d54b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f49755f9sm24652325e9.8.2026.07.10.00.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 00:36:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix IP block NULL check during soft reset
Date: Fri, 10 Jul 2026 09:36:48 +0200
Message-ID: <20260710073648.41408-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We can't print the IP block name when the IP block is NULL.

Note that it should never be NULL, the only way that
can happen is when amdgpu_ip_from_ring() is missing the
given ring type. The check is just there to be sure.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202607031711.yLwFhGfp-lkp@intel.com/
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 33a04113ed74..922f4b15619d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -489,7 +489,13 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
 	ip_block = amdgpu_device_ip_get_ip_block(adev, ip_type);
 
-	if (!ip_block || !ip_block->version->funcs->soft_reset) {
+	if (unlikely(!ip_block)) {
+		dev_warn(adev->dev, "IP block not found for ring %s\n",
+			 guilty_ring->name);
+		return -EOPNOTSUPP;
+	}
+
+	if (!ip_block->version->funcs->soft_reset) {
 		dev_warn(adev->dev, "IP block soft reset not supported on %s\n",
 			 ip_block->version->funcs->name);
 		return -EOPNOTSUPP;
-- 
2.54.0

