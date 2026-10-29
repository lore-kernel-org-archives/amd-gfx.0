Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E2606A31F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+52HW0H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B6C1126AE;
	Fri, 30 Oct 2026 09:13:38 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F2710E32B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 17:08:34 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso19844365e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793293713; x=1793898513; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
 b=T+52HW0Hmi7reX4DHWpMYdmabssBrDtHK8hPc6fa4jlrzjGQM955cuqY98TkuJ1ErI
 pvx8RGu8VM3OSrsr8p0VdlWRqAeEv1Jxv9U7hHFQ0awac++AusmnIjH3aZKlqToix4xw
 SlQuE0rzxNki5DPOjQJatU28CKipjYGNYCMcVvyjLCOXhGdQFzEoHThburU2jljh1s5q
 HUuk0DWOoQjqb7MSBgJr2KmnfGw8igd8IkjHHDzLdpvZfKSp5WbjMh3yMUV0dd9yyjn/
 baJD/Q3yP194BXFHLnDFJED49HzoBXO462SRBEmur80w/nL5a9vBkQ/koqR4uqfiUahi
 Xzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293713; x=1793898513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
 b=c4MtpWYU6MLV4orfYiHpkW4XiT1eNIB9aR2LcX9l243+LaSa2YHULYf43JXpr0fBNA
 WP7LXsY/brpG/S9s5yyaoc39YKjTJb0EuDDHLzAeSG+sklq24vTZnJ5v1cZQq7VMXg9b
 +/mAQ20KzCBvGMrD4RjXX0rSCmChbHMwpNT0RqR2Y2h7l8ZB3JIWQVGcwEE2lq9cajnQ
 HD4ziH+qg9Nr1W1edQbLv9Gvf+VU3eRTsqzDxzOcHBVlQ5/2rjmiwJUXDy4k8FI2MATl
 OMMuMOf+hWEHLQ1AVXgEwFV3rUGqnX1Rdy6B4qqOy+4q2RZxpzWMchPSPW+mFZW/1rFA
 D32Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaK8gq1056b9fq7hMARMYMaGgAhoqHeAOTbXN3/jDCCTbtE42ewXjn6vekrjXCkkOV141+oyCr@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQ1LmkAg65KDK1OnusZhiRJOwSAxLDl5D0codD7QcKk28FdrA7
 ZybE9XADrQ51sGDlkWOwyo3ri+FWN0303mvOXscAGbsAHBlgPrBrzQI=
X-Gm-Gg: AYBFou3IVJukDj14MHEfd7AcwXdbJlT59gTLs8lCBmvseIuOhcgQKZBbvwqLPRrPiFc
 GeyMVBG1YwSxPvauJBdCzPyAcJMyOS5iaCR5E+Lim5Si1vb4Pafn7A4fR7gpC0AyzEmjZSM6s+b
 EoXqf0TK4U/Hz8ui2X2dNggNRmC2GUniljcBrylv95dSOzCbpteLC5/fXDJdag2ed//GlbQR1uA
 y+FKGOMG8fJZUfMpHnzVb9OOBjP66QbNbaYCI8Tzetg49rldF8LsQ2DpDMfgSdla8k+v5r8oOn5
 LSU/5q09ZmrrTxFi4XMLWY7BAGcPCRtyYzA5AVpIWZag5lqeh9LMojH5eorig8dDMmyfNbvYUno
 bDEG2BTnVgsfOQXO77iqhXMJdB8PjSxGUNo5bqf/vRbFlbmE/veHrnpXL4xJDetFs6py9Hd4vJm
 aW1oo0nIW3+vWo0PlQ9akdTFUHpV5S7orzIQEMAMqFT6ujBrY+uuYEI0voGyE/0HJ98uqOyE63b
 SHBnRLEw+gB9AUHpls9hV9zKCxiZr8nQbE67YzKR8U6faXeGhpMsZ4o7zfgk082gFal9Uh776U=
X-Received: by 2002:a05:600c:4f55:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4a9661ab508mr141416555e9.16.1793293712558; 
 Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm82284925e9.9.2026.10.29.10.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] drm/radeon: validate ATRM return buffer type and length
Date: Thu, 29 Oct 2026 17:08:31 +0000
Message-ID: <20261029170831.915318-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:13:37 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tristan Madani <tristan@talencesecurity.com>

radeon_atrm_call() copies the ACPI ATRM method return data without
checking that the returned object is actually a buffer or that its
length fits within the caller-provided size.  If the ATRM method
returns a non-buffer object type or an oversized buffer, the memcpy
writes past the destination bounds.

Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
accessing the buffer fields, and clamp the copy length to the
requested size.  This matches the validation already present in the
amdgpu counterpart amdgpu_atrm_call().

Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX handler (v3)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..579ba1c1f23a4 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 	}
 
 	obj = (union acpi_object *)buffer.pointer;
-	memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
-	len = obj->buffer.length;
+	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+
+	len = min_t(size_t, obj->buffer.length, len);
+	memcpy(bios + offset, obj->buffer.pointer, len);
 	kfree(buffer.pointer);
 	return len;
 }
-- 
2.47.3

