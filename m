Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E65D767E1
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 16:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308E010E848;
	Thu, 31 Oct 2024 16:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.b="Nk6JI7vt";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335C110E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 15:28:59 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so6821195e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mandelbit.com; s=google; t=1730388537; x=1730993337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rpxd1Wa3OWeEEx8H8WR2xSUmackvwxeKQOHoyz3QWko=;
 b=Nk6JI7vtY7//FfDQv018KqIrkLNltblRK+iK77C7Psd57uZfsxgAnTr5c+lgZfr4ko
 fKERdiry+YYt4mR7bipLeWOHbtQNqNrBvBlUqlrvdgdCscHfyrIs3sO9qi/XP6nIVjqi
 BlldnCeNYKTVydc27uQhoDIyPeDAlMXRLFsmFCW3VqL+kBMvoe95pTxRlxZPj2Ldp5UD
 DVXfYUgMfkiDcIEhd8Ql/3LPwz6/s9lgg5ZmmpllLX9T9Ue3R8H5sCyxj86KxNRFk+bR
 /v+JOcBQLbwTdaHGCRepekkkQpapiF6wy8Yr0PjJlcHyMOG+YhnjFVsszflj57G4ljdu
 pBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730388537; x=1730993337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpxd1Wa3OWeEEx8H8WR2xSUmackvwxeKQOHoyz3QWko=;
 b=HpozzRLxYn3YzrZGLR4NBrneVlirBkHnDlvVZSKYNmA5fKtC2IXq9TYH7TrWa/14oz
 yHAvDghO9ZTUqajAYXf94k2dGb4Njy04QG7m+bD4h2nABkCoCS1dsLRaSyc4dLVqfnCL
 OnEZQfhmkInka7djryi3lKqtzUS1RKpJm5dFlQ0l+TeXcUQwxsWQVeB1WP/FW7mPxspq
 KC6uqwiCLKTy4kn41Domm3TO4fobNi3WmfUt35nQHlqqGokRRWgaSlB11RpsYLds+Oh1
 AtWpKK9n8EIcy+GQFp+xrbmoLRZnTGN2l2vdppYtDFdS5DmfW08TRuImiwWCDGESpdHY
 6u2g==
X-Gm-Message-State: AOJu0Yw8MVChj/FC1Jfr/G5Qc9km0KECOo7JzhaW82MFU8L9Bs6XRUSh
 LCU6XEnd6uXgfb7DA1k3sjMJ7hUhvWfch8gx0h73gftyydQpASvlur8bHmhHbEI=
X-Google-Smtp-Source: AGHT+IFoBxKsLoz39uPKBv9j+HXWXkAGIl612NqZQoe4p4s5DLp2XLQRN53tAbxQ8nsfJYMNkdC38w==
X-Received: by 2002:a05:600c:3b2a:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-432830a19b6mr3477095e9.15.1730388537243; 
 Thu, 31 Oct 2024 08:28:57 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1189118sm2449976f8f.116.2024.10.31.08.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 08:28:56 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 mario.limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH v2] amdgpu: prevent NULL pointer dereference if ATIF is not
 supported
Date: Thu, 31 Oct 2024 16:28:48 +0100
Message-ID: <20241031152848.4716-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Oct 2024 16:36:25 +0000
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

acpi_evaluate_object() may return AE_NOT_FOUND (failure), which
would result in dereferencing buffer.pointer (obj) while being NULL.

Although this case may be unrealistic for the current code, it is
still better to protect against possible bugs.

Bail out also when status is AE_NOT_FOUND.

This fixes 1 FORWARD_NULL issue reported by Coverity
Report: CID 1600951:  Null pointer dereferences  (FORWARD_NULL)

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index cce85389427f..b8d4e07d2043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -172,8 +172,8 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 				      &buffer);
 	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail if calling the method fails and ATIF is supported */
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+	/* Fail if calling the method fails */
+	if (ACPI_FAILURE(status)) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
 		kfree(obj);
-- 
2.45.2

