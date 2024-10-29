Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C06D7497F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 08:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6AA10E3F5;
	Wed, 30 Oct 2024 08:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.b="Yn7q5Kvm";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF0610E3C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 23:32:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso57213455e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mandelbit.com; s=google; t=1730244746; x=1730849546;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lStBLLzkZ4IOiXePrysaFTO8S5eHIYxzOD5lofFbrsc=;
 b=Yn7q5KvmN9aRhV1EsHajHk7HFH05X08+y+aGVzH+CxBJJckezPVHCe5aCujTDLE3iE
 fvY7j6pEyxaW8r1cSKYuSjObc0DclnNoYu9ifoszxm4gsz548cAyUAfkd+sT6s/k4UjG
 0FU0bODmzaxhTDFEkpxl+z7nEWxBbAFgwxnRaEwb2uhxZgCIf7qt045KAyZrglRTWihI
 d33xEhRcFaufsSWLeBukcEgV/LUGP839sTGFoqqJGEuuyf7GY01+IpCPDPozIqK7zG76
 JU14lCaX397wiH6qVTt/sKI5pepDaBK6PiKjDRBVCKAWPXGLkAmmzlEQJ/F15AtlkLF1
 TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730244746; x=1730849546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lStBLLzkZ4IOiXePrysaFTO8S5eHIYxzOD5lofFbrsc=;
 b=RTmId8gr9rE8m1zAIeetCBcr86S5EWjz8eCeRg9fRPw5WlkWrsd/5ck6VnA8MimLI+
 QjYwTxkHL7eIDSDYRAhG0E8c8nM1TR8N0jCLFJGEztFAxvRmBLBv1J7DeJWIvKu/Vv3o
 D9NN5owfOLXwDphCF6oir+DyiCeOQJRP6qVOV8w9R2qIjXV/sytuNlfelXgFw3nyTz/n
 8YXJf6KJkfO9t9MXi0t9NkHDVJ1M37QNa7bzHNxz7+SS+tRg9IxlyTiqIG3d/HEPosVM
 FLn3kyoRIFW0B64TcBaE5/kpiwDppdVQOkh/55Wj/Ih+p0uZ8AAVi8PVvE1uF4OfVA59
 xQgA==
X-Gm-Message-State: AOJu0Yyq7vMJ6jzvB61DFu3+BkK/nudC8xdQK0BKTOWsxAZCov9Gtnf5
 OZ8Th5a9Pmoj+PFzGTO1nDQihcFOT9ylw20a4LynKLrBjno6eBoNsHsd1setAE0=
X-Google-Smtp-Source: AGHT+IFN08GgIIYQERPKFyJ+37fpuAaUFrLVX8d6AuuDSZctnK3MH0jcrfXMRdO8stPaqw7wQC8yUA==
X-Received: by 2002:a05:600c:3b9c:b0:42f:7c9e:1f96 with SMTP id
 5b1f17b1804b1-4319ac6fc1cmr134931455e9.1.1730244746154; 
 Tue, 29 Oct 2024 16:32:26 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c559:9886:6c0b:569f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd97d77dsm3515305e9.22.2024.10.29.16.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:32:25 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 mario.limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH] amdgpu: prevent NULL pointer dereference if ATIF is not
 supported
Date: Wed, 30 Oct 2024 00:32:32 +0100
Message-ID: <20241029233232.27692-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Oct 2024 08:42:29 +0000
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

Bail out also when status is AE_NOT_FOUND with a proper error message.

This fixes 1 FORWARD_NULL issue reported by Coverity
Report: CID 1600951:  Null pointer dereferences  (FORWARD_NULL)

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index cce85389427f..f10c3261a4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -172,10 +172,13 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 				      &buffer);
 	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail if calling the method fails and ATIF is supported */
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
-				 acpi_format_exception(status));
+	/* Fail if calling the method fails */
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
+					 acpi_format_exception(status));
+		else
+			DRM_DEBUG_DRIVER("ATIF not supported\n");
 		kfree(obj);
 		return NULL;
 	}
-- 
2.45.2

