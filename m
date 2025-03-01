Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18117C282D0
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 02:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E2F10E0FD;
	Sat,  1 Mar 2025 02:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jr7dkD57";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0162410E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 02:31:33 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c0155af484so406463685a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740796293; x=1741401093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=jr7dkD570ZdNdxwN3507oboGMkmqMTtSC5fLc9LAukaIAdydUj3JLl7/AbYcjs/XQw
 tBh5H7YH4KERomhIY/n5RK30Vx77R3Zere1D35AP0H9xWtV4ox1As62keqfm+pk/Cjce
 68re/6tKYV+/7c3NxFoBwBhGef723V1IrgDpVr5mvhCT4zfq3RO1l2pkbCaLLDaqRMWF
 cu8oES855FbwhEWxQ1l+GfQ7WpiE7ysED7zmy5kUrg71zzuXO4Z7xfli2URRxGy2DLHG
 31X9VmC2bVHaxSLDNFMYt85yO9TMIkedEOdhVROapKWYXHirzZGHD1mjOgdyyRPmXB+A
 2bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740796293; x=1741401093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=VG3gzQbOa06qj8Pb4gvi83zLcPSXQQXAhbGJyCMWRlxAbLq98isDTtJ/6II2GDHtcp
 +vkAdNYF7jZejv0itLmimYXcA4xxEF0Ef6FacXk96/R9XUWquubfFHnbdfvCLZYy2DMJ
 aqVLgvO3Wl2+N/uLzGh7dTL+JhZsNF+1YU6KsFx0hJuJHbLFXc+WrwjcY5ViflWXMAHJ
 h9oc+dyJj5zi4WJgrbGtrA2lnmy/cIWjrvDbMDETfsyc2Ibb3bUxpIhVvn5pOWbvuAo7
 +8hBQPmd1ZpdPD1i6PnVThmbgZEM6MY6YzPtslcKC4FeMfWgiqNPtni0wX1z/F/52kfp
 rjlA==
X-Gm-Message-State: AOJu0YwuoYzg8PsZtxHa8WeZ7Tp7hkzID1jORFJa6a3vrhUuCX2Zsrr7
 vQ+y9l8T/pkm6VGTNUUTLD6eE1qXnl9gSedfvd6wWGDXrmame6Tb58bQZQ==
X-Gm-Gg: ASbGncsx6+nEe+zZECix2k427tJpUlTNW62EQhz/f7DGqicF/n3vJ2Zu1ExbrKIry8c
 p7OkejO9oL4s7MeiL6wyBeRRcdWzJTYxcVpzZEGfavyEOGe7lIFqx9JdYxE8sR760yEs4NX3G/s
 mAuiZFKdBwyYUYupjKN90y662WYkfOJYEuCUXSuPhH5OPXR8qyVqGf8d9UVj8EVxKOcOGvWQEj/
 TAgMiTbi7rllgZP5nWjB7PUC2pyzoopoX5gXS+5WrNoRITkGTZIpVnJFz70lPZ7KD+9/t+8nR6G
 jFSHaNn3qJcf9c9qm/YKI76BWhE1wrppYQjvghTh3xS8pqBJQjwsWcxVB5rvbr4EPUA=
X-Google-Smtp-Source: AGHT+IE4Ix+7YsdDI9S46ePhgSv5hAWDbG+tf5h1bIPQmGf5jikJUxMpnChRokwenywFVuBkLhddMw==
X-Received: by 2002:a05:620a:5641:b0:7c3:9d35:2c91 with SMTP id
 af79cd13be357-7c39d353655mr573982985a.5.1740796292899; 
 Fri, 28 Feb 2025 18:31:32 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fef5beesm322857085a.32.2025.02.28.18.31.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 18:31:32 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: add defines for pin_offsets in DCE8
Date: Fri, 28 Feb 2025 21:31:30 -0500
Message-ID: <20250301023130.31277-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
References: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
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

