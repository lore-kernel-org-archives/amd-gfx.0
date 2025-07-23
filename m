Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C014C87FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57BE10E816;
	Wed, 23 Jul 2025 15:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QW1cFtLq";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7653310E810
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:37 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so75840425e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286316; x=1753891116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6XKx0aaSGrbM1HvTIqh0C1NEFkbPPgmojaMX56CTZI=;
 b=QW1cFtLqjh8k2XVMAEWs9qEBwaI6EwFI8yknMgFPS+BfyBZev+6DfdG/aebvfrwnTt
 hopoQz80L4K0/wJt3u+JFxHd7PNlY5YkzMaZWQYyCy+AEmuV+mT4Jwj3Uac4rtcqtrGk
 PCtrKrIqPR4lIR/I6zc4v4FXz+rMEWTfBVK73gybjT5+P5Xlyp6ICGrOCQvlJAbwv3Io
 0vY1Bz68sKJCGdSVy0X/qNCzXdW6SsPMmDCTJP7Tzds+S1lv3/kfqfxWXHENMRq5plbq
 R9tKENWB3LqjtyLfOneaqm5YgiUHd4TZlTWhOYjP9zzbQlLArydhVM2ScKDHoToSk3EU
 7Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286316; x=1753891116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6XKx0aaSGrbM1HvTIqh0C1NEFkbPPgmojaMX56CTZI=;
 b=r/L9mHQ5gJzzJ8U5xgsoe1yrSYJdwyTSMpuZNDsgQq9T4EZNd9gLa2Qi5nOQh7yUjz
 9WNdiSGjTSjxixPelPZvaUqcdFxlmphX/Tw0y0LjsoCfbJ9ebacwqCMHyWyGBoGREk92
 twB3WS3CPL34w2DMxmxac+5FsUzOQztdWtC3WNUVn+ZDOWycC1GBmaIccFZVppvvwnwT
 9x6Y0XmFTYrCLrr4m+JufJVdwFQwKtGEuQ5HWFj5EfGDCChlaQViJTDt0qNZx+JmSL+J
 WkHyNUzFe1CW2ok7xOQ2tTE6NsDLELtsk18Ym/n+h2Tue30DYpHthk8V4C31X9HF5LP7
 XcGg==
X-Gm-Message-State: AOJu0Yz76r3VJaAIgXBvpKqe1THrMBIjA0+WBXGh/GFFEMWlb7Hhxd5S
 UYUoqdh1Etn2NYWVs7GMESpEPuooR32ANLTsYMAX6F/QFK9MxYMmTPDfLPNhew==
X-Gm-Gg: ASbGncv4ITkCX/ZscQ6B2ZSusXT8vbMvYVVeCSZ2zOcRMxX75IHTZupJxmJdKovjjyO
 1V8/AbsdObz72//u/tqc/uGEOJqMWX0jAuDfx6Lm21DGwLW9FkjCACWTjaNKcpSt8eYgoDJW/cI
 A5XvJt3hopR3Qys3oQPwwtmQrbNj0vfQRdxspdyCOtzgR+omCyEabQElPdiD/4fXCnIVS+hs+mM
 TFssMEb0OMTqfoX8U4VaHOtDGDCPo6DokmOBgoIxQLxQvrLqtvU+ej5ZgDhzrzVF39OM2YJ+UjT
 crhrpJR4b6dra8y8opW2ehgePy2TedtQdQMrqcwoOK/oXOVW8pn8vEmKPyd/m4eCsHlk/mph95b
 T/oUbY7Ugxha0Io7YyxKktLyVrB+ZC1ByE/PReLNrPvJfsJgrTYWsfaLmmyE3z/8VplqrWjtYHa
 xe9VyD41WnY4Fdvz80BY+wKTTtpg==
X-Google-Smtp-Source: AGHT+IFGKA+BQ/LeavSC2EwDQj+7/j/hFfVi8N2ni2L6hhwSxBz9+MtSdqZuEX8fVyesN28syP7GJw==
X-Received: by 2002:a05:6000:2407:b0:3a6:f328:22b9 with SMTP id
 ffacd0b85a97d-3b768f2f2a4mr2839692f8f.51.1753286315767; 
 Wed, 23 Jul 2025 08:58:35 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 20/20] drm/amdgpu: Use DC by default for Bonaire
Date: Wed, 23 Jul 2025 17:58:13 +0200
Message-ID: <20250723155813.9101-21-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

Now that DC supports analog connectors, there is nothing stopping
us from using it by default on Bonaire.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3757634613c3..e0798dcb9551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4125,7 +4125,6 @@ bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 #else
 		return false;
 #endif
-	case CHIP_BONAIRE:
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
-- 
2.50.1

