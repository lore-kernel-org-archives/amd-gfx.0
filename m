Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4634AC197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB0C10EA40;
	Thu, 27 Feb 2025 05:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lU03ITGC";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17C510EA32
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:23:02 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c0a3d6a6e4so50866885a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633782; x=1741238582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=lU03ITGCuCkSEuvFNyxOgag4P4Y11L0CRo2yXtRDA4p1fWPGSWUQp7kC4kawVUoJQ8
 JskNKST8PuhQvNJin/zkYsV5IgMtFoCgNI2v5m41Nfur0/mDiGX+AoMB5K1i3aY0kpe7
 8l60vHfc6egGMz19djzS/b9qHgth4PuHG90ZL1nyiVm4cU96Tsl9MyiyEi227K2Gnr4r
 ZrKSnMx4imeQwpXtA2RLBeK9JBAlN2USZWxET0EnksadQOT3JW4oUQaTpcjGi1rKnEJE
 c0S/x0WHL/5wZKlT2kFnuavVbTVIb84Pthrvb95InP601Urn/Dy60uGdhaKY4aR4Fzwn
 ieuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633782; x=1741238582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=jQpVmUG0unJExCpA3iE1pK9J5ACNtejEDMCltCbgy/2QYh0xNgTWeOPgpZ6mH9SnEv
 MJmJNHbueNvmIT2MC4vPu7uEA2HP1R2KgrLqE5jypG1paBBfXTuLjQqRDbnCQFxZ+n/g
 QJt09dnGEoi6PMwVPpOI9mN773VSBtuUBZHnH+Fyl+dRWE05ftgovIokzKV0YElzNKFY
 ZkipNQ3W9Ygq/CBJFf8URXHfq9caEkfWiAFg4oAAi4GBkJkmFsk0x7OlvyAbZGKVwyPl
 jdI5a0qeHpcguEWu5wnAoGOZWkKomNFy+BQp0HiYlTzobecWOAmUV+Ssdu0lAW+hjUaW
 /WeQ==
X-Gm-Message-State: AOJu0YxCVWixExs9lBNG4DH+E06d3aGGxu7H/1Qj3dt216D62n5fgKQY
 957GjNPGl/wWKFhCDjuJkto/CvfS+fQRfiimuACCzyxrHtTMFcaZ9LFb9g==
X-Gm-Gg: ASbGnctj51MwRGJbn7gKa+JvBlvYGpWYvUCDceW9Utjl/+zU1ornDxJVK852TKGfrgm
 LGv6xMGWXmZUyZj7yy3t9tKQa+ClO+qHWvS3aieNWV1eBPIrzT9KwQd7CNDUsZ6i4f1Me+9g60j
 NvAvZycv/u3iMOqpPN5YWccAovf87n9Cy4xEtAcnGKBvWg4Jf9jUYNEu+dcwvDs5UJXiiOLKHps
 APWCIbWxiGDdwcwXv8rwKrW830Ut8wXSeS0N7OOd8faedEO0du9TY4ha29PW7rBlDkASbX9dBHa
 rKXikfjsgsXn3cgrFMX2zSKgri+djpq0VW2JD/TTuEwpB+a3
X-Google-Smtp-Source: AGHT+IHwfWSotnI6wcWLMDCFcJmbWTM4Xsua2JmbYA/LHbvlGGtkL29UTsKfVFpY+QuXQjAcDNQguA==
X-Received: by 2002:a05:620a:3187:b0:7c0:b76a:51e0 with SMTP id
 af79cd13be357-7c0cef48528mr3679212985a.37.1740633781854; 
 Wed, 26 Feb 2025 21:23:01 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.23.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:23:01 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: add defines for pin_offsets in DCE8
Date: Thu, 27 Feb 2025 00:22:41 -0500
Message-ID: <20250227052241.171102-7-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
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

Define pin_offsets values in the same way it is done in DCE8

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdgpu/cikd.h
index 06088d52d81c..279288365940 100644
--- a/drivers/gpu/drm/amd/amdgpu/cikd.h
+++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
@@ -51,6 +51,15 @@
 #define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
 #define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
 
+/* audio endpt instance offsets */
+#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
+#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
+#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
+#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
+#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
+#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
+#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
+
 #define BONAIRE_GB_ADDR_CONFIG_GOLDEN        0x12010001
 #define HAWAII_GB_ADDR_CONFIG_GOLDEN         0x12011003
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f75..5e657b43a159 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1395,13 +1395,13 @@ static void dce_v8_0_audio_enable(struct amdgpu_device *adev,
 }
 
 static const u32 pin_offsets[7] = {
-	(0x1780 - 0x1780),
-	(0x1786 - 0x1780),
-	(0x178c - 0x1780),
-	(0x1792 - 0x1780),
-	(0x1798 - 0x1780),
-	(0x179d - 0x1780),
-	(0x17a4 - 0x1780),
+	AUD0_REGISTER_OFFSET,
+	AUD1_REGISTER_OFFSET,
+	AUD2_REGISTER_OFFSET,
+	AUD3_REGISTER_OFFSET,
+	AUD4_REGISTER_OFFSET,
+	AUD5_REGISTER_OFFSET,
+	AUD6_REGISTER_OFFSET,
 };
 
 static int dce_v8_0_audio_init(struct amdgpu_device *adev)
-- 
2.48.1

