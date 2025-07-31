Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B343C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D890310E84B;
	Fri,  1 Aug 2025 13:29:30 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE6610E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 22:49:54 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so166150f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 15:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754002193; x=1754606993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wc9ek6aaVKonfIPjNqyESsyoNzdJmvCzdh+JBlfPVC4=;
 b=jIAxYhsmEXSflJLo258IsVj1k6cIscE0bLIUvSQcFP58zq3geymkl+jXqAUaXZIsOS
 rZCMIFXz6hUYMPdgBE6r2h1fut8qg8AvqzAocAgn6mwWRHoHlNk4SL43lf5Me2sB50fg
 fNeSJ+GFmZV/ndUk7aXXV6jt8BiTdvx+7kdlIrkCP5n/dEYgTjyTlM0YbiHob6ar76dF
 FnAhpKlGCLRwE0gqRGXxYtN+x9J0Zeos5mqxTfJiv73huDDoUNMyS+bZYPDGkH4IFjwT
 TvG2Vd6dJBED4Eb4KsLC5PsbNdrTBnWU8gkFtviquVYAzUOa56MEF/K3GQCZiE7zPsrY
 uKEQ==
X-Gm-Message-State: AOJu0YzN6bRJ7naTWWJABQkf6XTrt72J30sO/JiCJxJzWOTjuzv3N4NX
 nIe98Q5OPBirNtPInj2ax41sC/4oTwC53aTdzFhoH2wyat92b/isA2+XOETLVEX4/W8=
X-Gm-Gg: ASbGncvGWGB7ImgvyGDucFkBJon9Fof9wBf9jWv3YjNzsFLJhOYJzi9AbgKEup11ygH
 eHkZJWZ7biGVEd8EupHBJn+hlWw7AtEuiLktkhdJ/VYJojlocH/HXGlvkGypz7rUcmRPOPFQ+lI
 6ppyi8fMhhvdi1segaDgXFQJx8pgq+BNACnE1++cEI9qn1Fclnua+NArvBA1wIIwAiRJnXhrly6
 Z1RrR7sJWifA+B8I/0EfOhjerrQJjLtho2/QAkFKbs7ujoAE8eooNfL+kUMUHwoSokQUuZR+jS8
 m8JFuE06AzIL5aVfeN17v4pHHMv44i8Hy2PH5UanIV64amgjojp0a213uc0kAamob8hs3kth80J
 ccKgJsgY16OkBXTUzpum9J44Xpty2xWV23jfkCABdQIAF
X-Google-Smtp-Source: AGHT+IH/QRfHUl0ze+TBD94j9NRq5TgwFo4oY5S1WrliB480E7I6ymna+pJOU1WNQcbWSpmQ/ifiSw==
X-Received: by 2002:a05:6000:2585:b0:3b7:8b1b:a9d5 with SMTP id
 ffacd0b85a97d-3b795018812mr6881190f8f.51.1754002193375; 
 Thu, 31 Jul 2025 15:49:53 -0700 (PDT)
Received: from xavers-framework.fritz.box
 ([2a04:7d84:aac9:db50:f8c3:4ba6:f1c6:fef5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm3692560f8f.52.2025.07.31.15.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 15:49:52 -0700 (PDT)
From: Xaver Hugl <xaver.hugl@kde.org>
To: amd-gfx@lists.freedesktop.org
Cc: xaver.hugl@kde.org,
	alexdeucher@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] amdgpu/amdgpu_discovery: increase timeout limit for IFWI init
Date: Fri,  1 Aug 2025 00:49:51 +0200
Message-ID: <20250731224951.8631-1-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Aug 2025 13:29:30 +0000
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

With a timeout of only 1 second, my rx 5700XT fails to initialize,
so this increases the timeout to 2s.

Closes https://gitlab.freedesktop.org/drm/amd/-/issues/3697

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6d34eac0539d..ae6908b57d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,7 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	int i, ret = 0;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		/* It can take up to a second for IFWI init to complete on some dGPUs,
+		/* It can take up to two seconds for IFWI init to complete on some dGPUs,
 		 * but generally it should be in the 60-100ms range.  Normally this starts
 		 * as soon as the device gets power so by the time the OS loads this has long
 		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
@@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		 * continue.
 		 */
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 0; i < 2000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
 				break;
-- 
2.50.1

