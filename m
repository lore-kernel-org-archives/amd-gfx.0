Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1491CCF256B
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 09:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD8E10E5BD;
	Wed, 19 Nov 2025 09:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R0HdI7ZW";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142A310E086
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 09:25:55 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso10424881a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 01:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763544354; x=1764149154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6T3Z9EJ0i2DniMUuPck8BxNYPJBIQ5YiH3G0gyeFHE=;
 b=R0HdI7ZWgQILsouLmYbR/93HNnAOjFtPTyVW78h9xxmesWHUee4/bmRm3tQ0JKDnBn
 E9rwYx2oUXw6JDoaA2RmdXmNDNQgBz3jUsJGTGWBBEDTyHbbYqJ+4akNRgVCyMGqRfWH
 WDvVnkp3hj7GD12Dn0KobnZkw2CBX9i9IzxMpJ2UTrogY/aJ9DLZJ6Ms47Nhbwarhr4N
 KodV/CwIV8o4h7JfMulvsEJTQtGM/t7anxPNTMT2rtWexehVIqB+IUOUbMe7WzZqFHK4
 Mc4wm/3bAMtdWEkgNVu6IFSUo27/VMBYxH5Jr/YydIZSvGpknqHqxsQ/2+a6wemh/x6h
 6ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763544354; x=1764149154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6T3Z9EJ0i2DniMUuPck8BxNYPJBIQ5YiH3G0gyeFHE=;
 b=Lhl91B6BE6Bjokk9ZWxisonc7BHa0NeIb4JnqCT/TCZEJ5ePEbch9W9SLKX+jurpuz
 VTOGoy33sldNGsOqC4U926PXhYAmRSDBzMAwJg3PoszZx8hjOV9xPlKZnMJxjg18sY2D
 zxWYOdu4LQKDh/yMJqKWIs50I6jHYYXaYNQ0QguTOAf1fEC+pLavJqr+5U940TvQZrKT
 rUq/+7DY5RD9AcsvbF3rtIT84Vdxu2aP9KgNRYp9vb8cvIdCE6stpXu3keKj15I1oUAM
 DRVzO+d2f6twMNpSsxUD1ha8x+IaoOEF28Tklu5HJYYssuc0oZMciYy85zZ1uhb2EbW/
 +kLQ==
X-Gm-Message-State: AOJu0YzXrHTawKfPGrlAPhBEbIb8RhVfWK7rwJiyHS+hD/CbfLEX83SK
 Sf9AyW1XM+J29+M62lXG3/pqSBGQI58fAPLp+zYM/NSHQkhoKMcqwVjbA+SvYlqp
X-Gm-Gg: ASbGnctlSivGL3tFRfdgF6EpdOqFt3byfTSN1X2/16BekFlWHpjlPGEOxjAnhY7jjfZ
 vSERZh7RrBHz6RCuG/PPwLDPw5D/LOFkiDeRQMG2Vruf08tPk+GGUezmVL9yjEL1EnDLFt49kZe
 ULFeHKxVRNcJ6viQsg/fpN1E989rQPrxuge6K/+4pbeZ5hDSZ5GnyJ9g+wyZOOm97KV18wtOmQa
 TYnHdETdpwtaHdqgOZvbYdm2kOOooMIEoGK29lCn1AJOBd03OjACclmJoPz6RJ+8Pd4uW9BWlJ0
 b6iVWadTDvJZ6CU1Q1Yuu2tDfBSTpgUfNwKW9Z0nnsTA9qOdQ64VIF37KKX3vAKFBk+XssfBeq4
 G45HbZaMr0yUV4cc19o0EUciwK9I1K7KnQTT9At75S1un8OJpO0v212xoAgNuJKbHWNuy6G/AzO
 tZAxKg+hKr7uIZAhl/YxoyzP9RYt+fNhg6Lt8B
X-Google-Smtp-Source: AGHT+IGXs9bYSr8ZEaFi6k0ugIeT36FFrTIbFTDgOSYVLmxAikZA13AcE+6CCimkt7vXc5RFJSdGyw==
X-Received: by 2002:a05:6402:52d5:b0:643:c8b:8d30 with SMTP id
 4fb4d7f45d1cf-64350eac57bmr15648343a12.30.1763544353361; 
 Wed, 19 Nov 2025 01:25:53 -0800 (PST)
Received: from Timur-Max (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a497fc5sm14698634a12.22.2025.11.19.01.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 01:25:52 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu/uapi: Clarify comment on AMDGPU_VM_PAGE_PRT
Date: Wed, 19 Nov 2025 10:25:43 +0100
Message-ID: <20251119092544.222670-2-timur.kristof@gmail.com>
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

In the context of the amdgpu uAPI, the PRT flag is referring only
to unmapped pages of a partially resident texture (aka. sparse
resource), but not the full resource.

Virtual addresses marked with this flag behave as follows:
- Reads return zero
- Writes are discarded

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 406a42be429b..f43592997b49 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -883,7 +883,7 @@ struct drm_amdgpu_gem_list_handles_entry {
 #define AMDGPU_VM_PAGE_WRITEABLE	(1 << 2)
 /* executable mapping, new for VI */
 #define AMDGPU_VM_PAGE_EXECUTABLE	(1 << 3)
-/* partially resident texture */
+/* unmapped page of partially resident textures */
 #define AMDGPU_VM_PAGE_PRT		(1 << 4)
 /* MTYPE flags use bit 5 to 8 */
 #define AMDGPU_VM_MTYPE_MASK		(0xf << 5)
-- 
2.51.1

