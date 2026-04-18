Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5FF99C95
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 21:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA6E10E17C;
	Sat, 18 Apr 2026 21:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CSQRlyUT";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CC610E12C
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 21:49:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so26570925e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776548981; x=1777153781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiPG5VVxToWeY7xLO4NMO9rRYeBeK51W3HcnCOqq2gI=;
 b=CSQRlyUTs/km27xEA6DuldziOk/hE6E40GFDYLGRjCqmb5HzWSMleFl6q1jRbyIGjL
 1upuukKjLRy4FBnxlu3x3c7hMsKKl/xI0Ki2FdzXPvBbUUCJ8KmiA1XCigXa8qFta72z
 Vjfk2tduixBjP52iPGBykaULvAUi5Edv0E544581fk92tvCtzyhOnYGLxIbzllXrSPFZ
 nfoZtS979A9h+OWmEG2snxQ/f7gc+oPmpBMVMLbfCDFWZs7OuA2g4NhN1RGCQ3gRmgKU
 t5s90dxz0h/odlmVDAMNlaBEgUQbYeftz41hctPY/ExvPm/pagc1NCce6GJNv8dGcyAt
 HI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776548981; x=1777153781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SiPG5VVxToWeY7xLO4NMO9rRYeBeK51W3HcnCOqq2gI=;
 b=a2vfL6CRd5JhWIw44is0UGsCLzYv36n0ZhaUX8v4AEGgCV6ceXoBeMeZeDtNk574qK
 kSADZ5OFmczGmLZO1Mv7etumwtP8maBxG4CQHqU+d1klAmT5MS7SfUiaXqkSa5YyzWbA
 vZvnjHUxXhKy19fIwE0GMKDYFIrCZNGuj22E7qr8XUiPJJYXjIiL21rsxDyWBUwf6LnQ
 z3dI3UiY/hky/TtyKrnYY1QVQb+24n0/ppDZcxYpH7HEQYF9t/X9ZPCYDfQYaxi8NL9n
 UvZGjyZUGYmX7PbK5eSyWxRQD/Nh9zcxUAda+jbC0pL7oO1tY7EwHCe/zxnHdFZH/MRq
 JX/g==
X-Gm-Message-State: AOJu0Yx4t/WhrQl5K2STeNxpUQNWZDbSwPN3IWd2+rN/QtYpXETe7FLb
 JkAuVaEpNO+eA7Ri2Y9FVVXHG19XJwofZtgfkIweccthbRbpK0ZXORcYTAA2Yw==
X-Gm-Gg: AeBDieuUPmh2APuJoab7NzhR2Rz8puJAFkZ3noK9Mso5EzMUOL+c21YruZm2GSY0rSk
 p7uDulrI5p4d6m/9cAYEEdwN55CaGcMV/n3L98gtP0rSDFuzkDsounqWy7XbFM2q3qyZfYzWi8D
 0OyjOy3+ujAf6hqcaUrvn7DM3j6/zUTs6gGlcaoh7vJ+8WOqj9MuF9hk233Yhh35rfmzz38uskr
 37cqFL35jwwFKWLUL4q8G8Y44d2AYiNKSQ8VA0YB+OZbN4alnKtjt81R8WxOEubvXRU1T4xyj98
 l8UxXsO2wrV/Eo4YEUXV+AUmTnyC8vpUqWWiuY2RDF/2RFjOQ5ggbZaRPrMI2dQQEIEFlKKzjNh
 S/WTbL/LJIaHIZXWLjaNCtgWsgkvsiumIetVh7XzEFGNZxRmZIP+4IzaqNUpmaPttoYcaYxvt4q
 WbolxKx1VD3pbX7sBCqrzUIGD2svLMmjzo+LL6vjvncRgyzT0o5yi0m/dWg+hurk9UAcydtG1U7
 hTdHw==
X-Received: by 2002:a05:600c:c085:b0:488:acbc:b2e with SMTP id
 5b1f17b1804b1-488fb765b04mr83292985e9.17.1776548980657; 
 Sat, 18 Apr 2026 14:49:40 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm171531905e9.2.2026.04.18.14.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 14:49:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/4] Documentation/gpu: Add TCC, update TCP in amdgpu glossary
Date: Sat, 18 Apr 2026 23:49:32 +0200
Message-ID: <20260418214933.230912-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418214933.230912-1-timur.kristof@gmail.com>
References: <20260418214933.230912-1-timur.kristof@gmail.com>
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

These are the L2 and L1 cache on some AMD GPU architectures.
Add them to the glossary, keeping existing alphabetical order.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 033167025fcca..d553dd599c966 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -233,8 +233,15 @@ we have a dedicated glossary for Display Core at
     TC
       Texture Cache
 
+    TCC
+      Texture Cache per Channel - L2 cache attached to the memory channels.
+      May be used when shader cores are accessing memory.
+      Despite "Texture" in the name, this is used by any kind of memory access.
+      TCCs may be mapped to TCPs, depending on the architecture.
+
     TCP (AMDGPU)
-      Texture Cache per Pipe. Even though the name "Texture" is part of this
+      Texture Cache per Pipe - L1 cache attached to each CU.
+      Even though the name "Texture" is part of this
       acronym, the TCP represents the path to memory shaders; i.e., it is not
       related to texture. The name is a leftover from older designs where shader
       stages had different cache designs; it refers to the L1 cache in older
-- 
2.53.0

