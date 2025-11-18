Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1797ACEE33D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC36310E500;
	Tue, 18 Nov 2025 16:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVlqx8Fg";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D99410E4FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:56:31 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64166a57f3bso8941441a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763484990; x=1764089790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3w9Gt5NYwoaLCiTyCIK5avu9ry+Nf4iEfOl4viPfYY=;
 b=jVlqx8FgFrH4+xET6lo1j5a4jUWicilumK+HlYGzdJLRy7eb4VWPbSdE6pgOyNFu/M
 ntLuJu/QtrBf1xHB0cKBSuBqF2NNXpNxxkU3l5LIfTg2Qea81LJA5WZGTuN848Avhein
 L/H9xfF+oJAoXddzkLZJoE9+iROEcCR3MLQsZYaap8PcahmRSpXgVoj90ZpQQMyjPtjX
 oYbRx5ebSOLJ0T2VKuM4nQdDyHSxqDJm96gh5rJ61YBCKbvbAGGtpbriOKLlyDzK99iz
 W07kyQpDR1/TUAadVUIpax7CnVMWcKPd0d2gfFGOgHTNS94onJO3Acy/OXqI8JjdirX1
 MvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763484990; x=1764089790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c3w9Gt5NYwoaLCiTyCIK5avu9ry+Nf4iEfOl4viPfYY=;
 b=AjHh5SzNpiCBGSrZliTTNTrZW4khEAPfbyzfKvGUuDGWtaxvMYcWfEXL1xbYKN1E0x
 BMd9mxYk24zSFneMTLcQaKcZJu22lnzPxx91muw5Q0HbeFpavk8ijYzfYSbKMEXZCfUg
 wW7ZtXCFm0IlBAHZEDdU1EDew36+5Y493JVLoiGGOglugfIyXBbUaY+O1+3bG6a4V6/V
 zbpMF3XXo8EwS5+2wws+BSA7b4OnQlEuuxx70v/s56kYJjR0bkoHl/l7A37G9CBcDNqm
 g89Xidca4pBXejZeESh2478Y4HNYbTOJBizC4Y79fCV2IxV1IijWimwzJ0kk/fWPiz9D
 Obog==
X-Gm-Message-State: AOJu0YwSxkZm4JNV47e+X3WlrOHWf7J6pshKSRoJjYBjfJ1KsW54kKdQ
 LxG5lGdOGJPF1bnRRoX5f9NHwLn/apFztIcARgcuzmnw4HDmyJSIeIZ5zGyiD5hU
X-Gm-Gg: ASbGncv3itbKRbaDO2f2OC5C0rpB/8KTS0/9HnGU6JfaIku6VCrlcd78ydogFmrGdss
 3cLmXUVRPIWpmMlrI7/72N3/ZMGqTVoG7NeWM3a4E1X0FQVrnoa9lsVkagNptUqxEFzeyAoVf/d
 Ocx04eH1N8ZNvjPfAjCEXcqv1oypKeIOhSst/eCrK3Jd8cv14XZHvVBU6TyGzm4ZbwWN4+Wp4zs
 XEcnwyWPHqq5f0DEhQ4fd6Tal+oLNc4nORQ8Fk5UmhT6lQaDTM5VZBTcFc0njgxx18UkZKh6dgl
 QO1Zz5XANvzxNPDnbsxAVR34OeI631QVjKpec1i2R7g9veX4JOnDPUA23gqGMWTebhW/3clGHat
 +wwZ4WO4CmyRZF2Dl/UcJHLjRozi2TNSdt0STm0JMtTcL1LXueLwSktaxlW7FdPUijvYpZADdic
 rUGuMWTLn/P/dTxCVyqIY6VKOME+dPwo1xOH8Z
X-Google-Smtp-Source: AGHT+IEueWqCPC9NincYD5yq64NSQEM1cBeXue/e36LLJ6v6JJb9nQkz5c+Mdyojcpd2duYOSWFB1A==
X-Received: by 2002:a17:906:f5a9:b0:b73:8307:4e95 with SMTP id
 a640c23a62f3a-b7383075af5mr1340701166b.4.1763484989591; 
 Tue, 18 Nov 2025 08:56:29 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad44b4sm1408197766b.28.2025.11.18.08.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 08:56:29 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] Documentation/gpu: Add PRT, PTE to amdgpu glossary
Date: Tue, 18 Nov 2025 17:56:20 +0100
Message-ID: <20251118165620.216753-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118165620.216753-1-timur.kristof@gmail.com>
References: <20251118165620.216753-1-timur.kristof@gmail.com>
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

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..1270e2c42ec6 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -149,9 +149,15 @@ we have a dedicated glossary for Display Core at
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

