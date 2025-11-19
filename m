Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AABCF3184
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 09:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A27610E5BC;
	Wed, 19 Nov 2025 09:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8HiYRCk";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE32F10E5BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 09:25:55 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso845782066b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 01:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763544354; x=1764149154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWWxJSGqbn9hNMfMnZGZYi/X6ktOsJm3dypr+d9C/BI=;
 b=L8HiYRCk+iIXAYzbO/qtxq7k87GEmP4waBuv91AGaIVqPIf4Re7dNa4bRI4Bvm2p0B
 Xji5T/9aeFuEBYHJzjiAtbwIFYHNXWtXi31lMSWr0Py45wuC5Vx8kchPwjkV7B2vjtdT
 V4RXCjhZR25/GX7xW3qyVDcJW2uaqkt15FFjjmOSso3a7jjTNXmtO+d6EH5RIorjIbb2
 S4jz0TUk8z//dsTNOGMVk3HmGtIfDCZ94MWqI5x04RpNz+ZpAM2V4l8OS6yad5eOZSWV
 zg5CvQNzQpV8QfaO459eLw5Z31W6Kkh004Q3szByXxdhhcgmh4H2siQYSyY7MKtWcFiZ
 TONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763544354; x=1764149154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uWWxJSGqbn9hNMfMnZGZYi/X6ktOsJm3dypr+d9C/BI=;
 b=TjfsnIHdEM0fblLdEqMev/dNHYtdVcjgRrpnYOnFBoJChnlFJ8Tc4yfUeQ/n4ZDP5W
 2niN//3KKtVyuJMpIhaB5ZeJ503JxO13w8fJERPGIChOjP7H6PHWUF1JR9kIzQLvsStR
 Ak6l3CL/Ozox915h5OKHTuUFaHIjXhvtzghTycjQjlGdS6Bl9sQrH1t2SCxCO0agvSLn
 jeMEEDRpU6A0qvL8yjbu+0jZ+oOAykaIF3dCKXkrUUwoaHHo075FfiLNZpkssEt5Jf6H
 KVPU8zNMnHl8/lxioUGNKn+/EpHslp0/o7k1nAhMCAN83fIcyIOakn3ciQ04L4YFdaVI
 T1ag==
X-Gm-Message-State: AOJu0Yz3IcVfgrT29paXbJJFJJCpfGvdaJjT9xbH7l+WMkTTncoJ/imI
 L3V/4uNHrcBRopdsn+7XVVmbNaMCjvcCN+P/5pxVRrZUMh+1a1ZpJjg+ZRjYMaic
X-Gm-Gg: ASbGncvadb6Cqr1gKkPaVxa8B0YEyWw9w2fl8YuRPkimR5XrecDrUklcD67FY5WjjM/
 I+fj6LfAgIIsiwFNdesiKU5MDgoKB0xGgJ9V7ouhoTSyyZlxN0WcqyBgNSftGpj5y6Cn7VY/wQl
 PzDDJsz3+ltNF4s/NoQChM+v/zHXWCuXB9cEdIAQ5qWwl54q27Sl8ha/oRQKovaJCDhjc0qBqNC
 ZUv/ZV+PMhkfozd99STkhP5DfPZepPHuBajmR4zMN2UXX77KkIiLhC3zj2l/QmwH69TQx0TDVsR
 QpXqNMMx5oUUy5zXXd/2huqJHNUwcolavfPwyuoQ3IJoxDQUdz8ixXO80auMBpnBQJ7UJbOFa0D
 uUDlRRCtAeRGXShiREmtZ3RALRT+zCCFYt9ZSifoRozp/gNJO+VfVzSe7G7GJDy2qr99MNWhdLa
 2tCwITMoThkGmi99XPCiml0FctJitllo+Nv1M6
X-Google-Smtp-Source: AGHT+IFhvS1WUFc0Bea6qwJxX5cuZO3vMHWDCU9vqGhsjKGN3hsY0Kls0JbY7Cr8zyzOrT3mDIrdgg==
X-Received: by 2002:a17:907:94cf:b0:b72:c1e9:5f1e with SMTP id
 a640c23a62f3a-b7367808670mr1970255066b.3.1763544354107; 
 Wed, 19 Nov 2025 01:25:54 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a497fc5sm14698634a12.22.2025.11.19.01.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 01:25:53 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] Documentation/gpu: Add PRT, PTE,
 PDE to amdgpu glossary (v2)
Date: Wed, 19 Nov 2025 10:25:44 +0100
Message-ID: <20251119092544.222670-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092544.222670-1-timur.kristof@gmail.com>
References: <20251119092544.222670-1-timur.kristof@gmail.com>
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

PRT = Partially Resident Texture (aka. sparse residency)
PTE = Page Table Entry
PDE = Page Directory Entry

v2:
- Add PDE

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..43a36362dc73 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -143,15 +143,24 @@ we have a dedicated glossary for Display Core at
     PA
       Primitive Assembler / Physical Address
 
+    PDE
+      Page Directory Entry
+
     PFP
       Pre-Fetch Parser (Graphics)
 
     PPLib
       PowerPlay Library - PowerPlay is the power management component.
 
+    PRT
+      Partially Resident Texture (also known as sparse residency)
+
     PSP
         Platform Security Processor
 
+    PTE
+      Page Table Entry
+
     RB
       Render Backends. Some people called it ROPs.
 
-- 
2.51.1

