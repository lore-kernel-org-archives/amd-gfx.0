Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C1BC19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E61010E8AB;
	Thu,  6 Mar 2025 01:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ne4ETrS3";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA9310E8A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:50:23 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6ddcff5a823so1329766d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 17:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741225822; x=1741830622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=Ne4ETrS33rVvheODn9WXdezIxKPcylE4HN6rOoSpe0NcZljxxFZkckhuEoooZbLa5V
 /SHHBeMMJmwBxEnQie7agEpykzYuBf+EAEJFVkwwKItJwdGZwSYF4Yb0H9rKDe+ObZJE
 WffmlLrvE270LjY+MQvnf1GnNY102iy06wToePDbCCAGfHI5j8qfPPsIPP6Nm+XFM5zS
 irARYf7iS95Mpo6piKrQ/cgbOQUmgzNG1Or7TSSdGS2FocT77WE+V168DS2mSLJVZkFe
 ND7nnfIIlzkskX2J8Z1UhXn4NroWrWtS4BS/Zkhfq4IbJ6ogTOggGR9GulRpzSl8OcV2
 gn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225822; x=1741830622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hx2v0ctrkqHf0wbfgH45MPnh1wqjGKTxlbAeUbASJlY=;
 b=aCLVOrpS9Cw2HBZx2QTgx336LZMB7Z32R+D67pXXinoT9yb3JqgtVo89Z8Ec8MhAJ0
 Bkq8uZE0oePuPiN156S03PluXXljgyY+amBzDaVrkpWenMfBrFwT7ggndOu4s1vhhve3
 jbIL52DeXZQAF5YzOTWE9kyNmTDJN/GytkV9nE+C6GW7FbmHwe1ESU/DtU3FVyP9LkMD
 KkM6rb/At56SnR/xCi6m8E1q3XgnIE1sTI8uJ+kloXzrjemYGasc/wHo5tNmZQ3qMC5J
 CRhMqHR1cqMOoEYeHUlZnvoCPMiMIH0EDqSPgSQy/CLAi9rJv1zqlzsBvbB8JHTXjFEl
 FbKQ==
X-Gm-Message-State: AOJu0Yytu31Qv+iPIjN1QCGjnueGbdnKAkFttBoqX6dpW6wJVgLZQC8E
 JgH3wrGNdFVW8Ecoaxe4ihqc5AaP2OLl1bDungnh2LyOHdt3y2LbyuiTbw==
X-Gm-Gg: ASbGnctPlIrB1T8FnOxLjTmFF2tPJOu5qP5JRrbbxB8jYk817vHG8Wr7d3aNAJABmvD
 MdijVGcWAVas8tiyRqJj+Xc1IAkKOrokrjWRg7X0gZEoMZC3v4gcthI3ZQd2ipl9nY/DrmW4B+D
 Ys/Jk0riY2yTlD+4AevBcTbbfcXUyAVSxEf0HltSG2Y26BBNgJLBxgl037KNzlpnY79i07a/ElD
 H5i34iR6EkmieYecQUiRWUEV2478BeRdpUqUa2I1OWQthfFv4AGFEcif5ViHIVkAwZAlHV3Zy3x
 Pe7fqTh4RRG+iJlOBU1Y6sSPiKARuffTFvhkeK3GtBIq5leasRepW1GBUP0lVXOyKnE=
X-Google-Smtp-Source: AGHT+IG3zgHkOXIzM9qnZkTzYzISsA2gGlXWWnPCTpsrNqX0qULMz9o73+2KNRYBQWP50quWaudWFQ==
X-Received: by 2002:ad4:5f87:0:b0:6e6:5d9a:9db4 with SMTP id
 6a1803df08f44-6e8e6db1743mr66080046d6.41.1741225822625; 
 Wed, 05 Mar 2025 17:50:22 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b65csm1489786d6.76.2025.03.05.17.50.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 17:50:22 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/4] drm/amdgpu: add defines for pin_offsets in DCE8
Date: Wed,  5 Mar 2025 20:49:56 -0500
Message-ID: <20250306014958.785021-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
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

