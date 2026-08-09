Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676B2C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5148F10E6D5;
	Mon, 10 Aug 2026 06:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kh20p7jU";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5C410E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:30 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso488392b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252410; x=1786857210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8on5LBVsYqwWr9ndoV0oVFp6EULFueLmmkrZV0DJAg=;
 b=kh20p7jUQ5Gr/h2SCSzSPuO2TU8RlKefwLDJaEY+O8zCmFg/egQpN1Mly6sw4NGVKh
 GM4DYu1LN92a4LUbQycg8KxICBGnxaaFiIAiB0j1CihpsHX7gzQXpHnDWM3k59lnbX2E
 Cwf/kjW8mwnPEaG0E484i/A5/rPiP7XXSn+J3JrkMHpAm8ASOQHp4/FQVbdD44mfO311
 de+pi8Kh14WTgiRUYFqoUI5Mi9S4jscidYTcu+m4sKwSqWGPSODQWn9Mank+d3uvo3qB
 Ev1YbTm/9IeAzc2nniZnA5f5scKXyRnnKqJZWlYNoPb89sdAQMqpbY/EEC+ZzulNU+yE
 fcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252410; x=1786857210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8on5LBVsYqwWr9ndoV0oVFp6EULFueLmmkrZV0DJAg=;
 b=ZT53ePPl6gFYkm+8dth3bBQwCYJf76yDnsB0MYI+g8ej7cRXmEJ8zg3V2n51GGVmKv
 IxO7rqGVshtXqlh+xmGUZtAngolx1fox6VQGwNhbQuSxPAiud+Vy23paGFZvg9UXXbm2
 aNQmC9qzpve9On4q0Xv0sMqfIYJcbIQZBAkft0+u7DYulLklYmDMVMSaFwVLKw9R9IMO
 OLndJsgb30yki0uXf55D3n9H49NElPFljp5QgviPCwCqKn2EYGbRppwWsXDV6Qkk6n9U
 Rfl2aEUnkgh8fO0yduMYl9qzrAW8eCq12iioVOoKiXNV03hKNNt8Cb7lWIWaHUFiAoYX
 xQKw==
X-Gm-Message-State: AOJu0YylMeAUxAOmMQCIOVuqqKWssohVyCKyKQpjaFfdvTU+128LjLmi
 E8mzZCft77k4YOpBlFLzFP4gwxgfgKT7jmAtnZR4ABNfW5jz338jigkt
X-Gm-Gg: AR+sD12Qim7kxDFwQLqCSCQzleK9RShHMyywAU66iUfX/0PFKchQit3LlvujPoJGdaL
 iru+UVk2XwQy6l7q8Cp4d480MLSTuE5vZAMU4ktGMmqS7b77eTZIFHVBikqW9Bn+EoyzGv3DCBk
 w/2fH5+ZcLBnxbPy4eEmT6MCk6XxcXC9C8C3SkQy3zO90Ic276+DudITn2cgOFHlJfOzL/yclfO
 eoLjWBMa5rCYNrWDn8Cllk9vWwD3LtGxJr9WM+Ho+POGWJIJS9gpbAMNGHVJU31a1kxqYJ8AGxY
 vQVGU504b2lSiWt0P1QkLzWNPB0fp3cgJDUF6Y0orv7F0nDDlPEO+GQ4U5Emds1zo7hnfnUJWD+
 pQHHfJH1CeZCk9AJjyZJbYhX2zPHxQErZPxiaTGhM/2eZlxltLVAS9JDrx/o0GGh1/zJxypPsMt
 8qx3FBzOcNQpOcrQEddS0M82JN3wIdCxiAeG9xNaAQh1QX2gqn8nQihsXpkHocxEQy10mjige6S
 qZ7AyhTZMHl
X-Received: by 2002:a05:6a21:3117:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3cbadc97c22mr27425139637.28.1786252410244; 
 Sat, 08 Aug 2026 22:13:30 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:29 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 4/6] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sun,  9 Aug 2026 05:11:58 +0000
Message-ID: <20260809051200.3276-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 06cb3ad1ce62..79326389d75c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

