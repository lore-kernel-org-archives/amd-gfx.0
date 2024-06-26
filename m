Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A2BC30658
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A787E10E999;
	Wed, 26 Jun 2024 18:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mBxKJGZM";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B4410E999
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:06 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so31492726d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426725; x=1720031525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlWN5nCQeeyKorQHMMEOa4D16E75azE5GGd9I/2GGcU=;
 b=mBxKJGZMsJRzmpuQMjRxcNuBRDzD/0Z6SLIXzgmA9D17Eek9xJUY/651LcnzHubZhD
 LhEdxKLfsbJxFHjrV0V+8XQtKHi/LMu7apdqohmtriZQlIxXxoeHqRAMWnA00tr3AsDc
 2WpuKZrcIeLbttF/2Si9xRMRiU+COsOGgz4EQ2OdIfSpSrabxquapgKyongS4Ydp6jcG
 6rik7Q2xkbKVxLSV6f5VPXPp6ShAiYKUE+0vQMxhaeGEne+DfVp93qVKrYG0PmU2vbN0
 /RjBqjmHvoLhYWEPHYL4XfHjNdzYZunhNoumpFuoW+28smdhiOb100TwrVQBpg/jn6Sn
 XNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426725; x=1720031525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlWN5nCQeeyKorQHMMEOa4D16E75azE5GGd9I/2GGcU=;
 b=dT7QXpVx7G6uvEYrXju9NuApryRBWtuALIm1VgBWSVo+kG/bbW92EdlB3jQjLO9+bH
 58KpHUkzBUnjBMCGBrPHmr8IP44ZUQdFmbPtWjQ9rDIqOaWjMEYxAk9wOiGihVbQwpvk
 MzhAhJ0z03FMqmgn29qjBl3HEVBvdgqpEbtwzMjR03MUin90D/QXznRrjEsIfIhq6wAL
 S7mjrMjTxspgG41FXZ/3w7H3bV49B+LbdXXPrh5eX/kxTjVKylf3anv/a3b5+C0hA51D
 FC7qo2Q8rXlwaa6naxaj9fu5qQNMKcxsrIa2cC2er0HX8ikQOOZ/FCX2oqVKtCpyOsII
 P4ig==
X-Gm-Message-State: AOJu0YwzxaXgasMO9ppXuDLyjB2l9eyh0auxZ+imkzTpdU0KRkFX/iwT
 pgJMlvbWEJVT8o92sy+LHU74KUR7ZBgzN6gN9P84sgS0BOFHYtEe1+UFlg==
X-Google-Smtp-Source: AGHT+IEtiffpF8eS4rvxFvGsHLXuwbNfrN7bw5RauW+AuoXQ7GLSdiSn/vcJ81TrzcKwD8b7Zc0FuQ==
X-Received: by 2002:a0c:e48d:0:b0:6b5:23eb:3a4d with SMTP id
 6a1803df08f44-6b53bbb69fbmr102808096d6.27.1719426724856; 
 Wed, 26 Jun 2024 11:32:04 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:03 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 08/13] drm/amdgpu: don't use amdgpu_lookup_format_info on gfx12
Date: Wed, 26 Jun 2024 14:31:30 -0400
Message-Id: <20240626183135.8606-8-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

It only uses fields for GFX9-11 related to the separate DCC buffer,
which doesn't exist in GFX12.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 3f431e6b155a..3a7f6e77806a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -654,6 +654,10 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier)
 	if (!IS_AMD_FMT_MOD(modifier))
 		return NULL;
 
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) < AMD_FMT_MOD_TILE_VER_GFX9 ||
+	    AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX12)
+		return NULL;
+
 	if (AMD_FMT_MOD_GET(DCC_RETILE, modifier))
 		return lookup_format_info(dcc_retile_formats,
 					  ARRAY_SIZE(dcc_retile_formats),
-- 
2.34.1

