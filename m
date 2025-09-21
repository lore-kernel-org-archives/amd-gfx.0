Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B00CAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 07:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AFC10E3C5;
	Mon, 22 Sep 2025 07:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTYvftXf";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD9C10E317
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Sep 2025 14:55:05 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so3124752b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Sep 2025 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758466504; x=1759071304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pJFv3ChPUzhn9GkGU13hJh9Fbrlocc4W2rtrc3dBgJk=;
 b=DTYvftXfAqx82edDPPDUzpWcUJyi1tuqxAR5lYdAMPDBDOKWIMbWbe0Ta4MChpfO1Z
 RqfjjSzpjX5rfIQeVWVmC9Tl5ZkC11lmcf/T2+3C6jomZopjdQGBqtOVHDCQvMOwczzT
 WwhnYgclvmOIcws8i1gVBdc8ZUbuXFJBeIb46eaELZ7bApwcXrHcj1+ZJOxWnKLfmYti
 Hs32xpv+NaK/f0xS22T0HDfEn6cUr7xBFQRKjkVmGo46nsX4FLc11515FtcE9Tx8efI3
 8k2pq0fcyT3W4FkiHhDkaWPwk8LHtctaqeJu4tlWXEh+BF/ON4aWsj8chzEO7S+c+cO4
 iVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758466504; x=1759071304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJFv3ChPUzhn9GkGU13hJh9Fbrlocc4W2rtrc3dBgJk=;
 b=R2UmeKVZMWfOvi0oXtTXzMF60bCat5XU8ZYawx3vHDVHwhpYzYNFGUOt7iCml+FwD/
 iFh9/LxW02htOhQVBavXbdo/7r5EDD45saY0qThtWbuhBvzjjcJ2Yvpjctm5ZEXKJdsZ
 IEplTk1OSCu13gb79nbA2LSJwexUR3Z3a8SWTdXqFgSQnNW/WwyFN7vT9OdSei5gI+e4
 bLz8vbibOZbtQ8wzeH9Yb81anUlwtXHysHYz4k243YfnSSAZoxn/EQDW+s3p5t0AsV3F
 4y1MFhodk1lG8vzPLp9JGogxy9VH1LLXuodB/PNKJGzyu1EIHq9yySn5lDoVLM0dPpEj
 NsBg==
X-Gm-Message-State: AOJu0Yy7T2s9zmlwDBpl0uCKyMsqaiW02L/PdcHD/v3UN4B73bze6eql
 VTu+0paJdc56krHGGkxW+OxdFaJqUpaG28JJucWRju7GinndADgy0wP6
X-Gm-Gg: ASbGncu+Aq4AnNxcyVM9+ScjPkWrKmuqUE7Ybh8R23kZu3S55pHsprQchJ5UjoeZEoi
 shu1jlySoLi4DGE3wXW409NXi39AAo0Prxf6ReBJvw/JZ9bVjjT1FRqh87n8JjVKu0kRaya+6ru
 KoYgXM2HA11wVJbr0W3hY1KUZbY74VTAviQwMYJZ+rm21tj5jsre1v/7uJd17fdJEj91stUi3XV
 IftHCHAMLUvshtliYafLAKZKuoBRkEiGfFN3+9qXtlXcSA+nKtMUPXNEd8GKeVRYLPj73BqNwGb
 w5l0nQRLJyU8l56Pul+Wm8IJDF2IWOUYEQTr/9KWzI3vselLl/AIDlA5awM552feSnh+IWWKFfs
 pjpihvdA/cXs8OaHUiQ5wyQS1AUvNzIk4Le+vwq7piWg=
X-Google-Smtp-Source: AGHT+IGlGOrrC1qELYieezel6ZZpPzpPTwUZ/Hjhxs33BYHvkYGq6FWqHUkdWrQ5M/94vUUoWCRMpA==
X-Received: by 2002:a05:6a20:3945:b0:262:af30:e3c with SMTP id
 adf61e73a8af0-2921cafa18amr14329391637.28.1758466504480; 
 Sun, 21 Sep 2025 07:55:04 -0700 (PDT)
Received: from asahi.bialairport.com ([103.241.193.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfbb7aad7sm10415321b3a.12.2025.09.21.07.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 07:55:03 -0700 (PDT)
From: Shreyas Muppana <shreyasmuppana@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shreyas Muppana <shreyasmuppana@gmail.com>
Subject: [PATCH] drm/amdgpu: remove leading space before square bracket
Date: Sun, 21 Sep 2025 20:24:01 +0530
Message-ID: <20250921145401.22654-1-shreyasmuppana@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Sep 2025 07:22:58 +0000
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

remove a space before an open square bracket,
fixes a linter error

Signed-off-by: Shreyas Muppana <shreyasmuppana@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cbc40cad5..8f3a31952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -26,7 +26,7 @@
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 
-#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] = {hwid, mcatype}
+#define ACA_BANK_HWID(type, hwid, mcatype)[ACA_HWIP_TYPE_##type] = {hwid, mcatype}
 
 typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type, void *data);
 
-- 
2.51.0

