Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A728D232D3
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEEA10E04E;
	Sat, 10 Jan 2026 17:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jD6DlzBQ";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86D110E919
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:25:13 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43246af170aso1856433f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jan 2026 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767975912; x=1768580712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6D61jCcPKdIzLOh1VTWA3yx/fr9rhqVqmFGIMjfLvdI=;
 b=jD6DlzBQ8b3umEHA5KBKdl2+sVzHdGneZm8tb8taJFFKc7hMsj3VdeyHqsJXbu8XhY
 0QOhDoEZVU0BKCH1bXzlldkugetGhgAXgq8XtSV0kK+3jM7DXVnPNq1LTZEl5hRHVwKn
 eFdXWOzt/w2iBpWoLn7qobA9bu9b5u7QRQfC1DvtGTQklMlXfBEIIS80somrEkipRsBl
 KPpyAZr5kL4DXBsinyCHziDV9ZgM/HIlEaUVO52wXfRsMFuXtrj8uKVUiQ3SXZoPmd43
 UzDiF44WzNHUr2GpxBqpJZsuH3+DhQEz5v/s3RyvqHRUJb6nDFq3PbVilaDz2eHmhUs+
 F1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767975912; x=1768580712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D61jCcPKdIzLOh1VTWA3yx/fr9rhqVqmFGIMjfLvdI=;
 b=rIF9Wajdg6hHyJu0/LTqyXXCyHOFp4g9xGItBmDIM+pgSTgCCeXe4Luz5U60JSr1jp
 eNtzQQX31cNYPquFR7aRkJyD0muTUK49H3U5AGbZlSeL2bjAiNBC73uEmhah32I+nZD6
 paiyJoLtj2Zp47T0DT0RQJNabeAuKnglzb94dMLgZXfVTSuY+Mf47Ue8Vfedq7Wd1VcH
 0DLJVXBhiH6CzJdkvwcXf7QNiYR7PCVrxXGndbjLgdKMOcoKtGarrRJ2qAIWGtcWnLmS
 z2FfjF3ksRslNJGIQgNed0Dw2+YhR0KJK9mMCa1BTgmPv7Egqpqv6/g/FvBAlI4pv28g
 y7bA==
X-Gm-Message-State: AOJu0YyY1rd/h8mZ4raiDux/JghrRqYL3V44CjA3MqqIT3/jYDz46jyR
 aNVsAZDfD8fsPLVDHu/oXt6oNKrLYupWNyOdjQk/O8DWR0V2vedYlb+O
X-Gm-Gg: AY/fxX77DwnzKfFRtr8TBCziTyPW/ZsgvHxz0OTp6CHb4hU+hTe7+2ci8Q7DJaPcTjJ
 gb9UBUCZOy/M/cjEhAQUG7Np6os3OY14UanPebsmSWm14Cm/tKXyNgTNRTVhYAld7Slyr0YxxB6
 sO4TuHIj+Da84ckyyRn4haBFtndREU2QsSZgKbxPgYTPg5HB72WIwhKDv713x2FVZ4fSRW9nrp9
 iJjRYCuKbwnapA9AfXvc1cLjGp36QIq7vTI9Co8I5hjM0YilHW+JpYz3wYqOQm2oFV4wLS9CYke
 SWB7jXrwobi2iuV7kIHajqlbPN3sybjH12WgJ+8L324uEtgt4VcLjF2K4vd7oSphBH4z0pNj+zk
 TkHeDE2If+EzIhhJCTe5XxdDX38v1ysy0gAfVirMa3lNB7cTpItify3nyLlVP/UULn7nVddvfc+
 /j+dOnErptO4FzLJD7lE2aFSKN
X-Google-Smtp-Source: AGHT+IETHFe1bt83p7OLl4C3e0be5VCh+jmS63D91zqEYAh74kxUAD5M7+gilHthbzHGo+uLzSlcbA==
X-Received: by 2002:a05:6000:2010:b0:431:f5:c36f with SMTP id
 ffacd0b85a97d-432bcfe4cfamr17880196f8f.31.1767975911920; 
 Fri, 09 Jan 2026 08:25:11 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm23201743f8f.42.2026.01.09.08.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 08:25:11 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-hardening@vger.kernel.org, Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm/amdgpu: Replace deprecated strcpy() in
 amdgpu_virt_write_vf2pf_data
Date: Fri,  9 Jan 2026 16:25:14 +0000
Message-ID: <20260109162514.308143-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Jan 2026 17:58:19 +0000
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

strcpy() is deprecated as it does not do any bounds checking (as
specified in Documentation/process/deprecated.rst).

There is a risk of buffer overflow in the case that the value for
THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
replacing the deprecated function will pre-emptively remove this risk
entirely.

Replace both instances of strcpy() with the safer strscpy() function.

Changes have been compile tested.

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 47a6ce4fdc74..1c4e74e35cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -604,10 +604,10 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 
 #ifdef MODULE
 	if (THIS_MODULE->version != NULL)
-		strcpy(vf2pf_info->driver_version, THIS_MODULE->version);
+		strscpy(vf2pf_info->driver_version, THIS_MODULE->version);
 	else
 #endif
-		strcpy(vf2pf_info->driver_version, "N/A");
+		strscpy(vf2pf_info->driver_version, "N/A");
 
 	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
 	vf2pf_info->driver_cert = 0;
-- 
2.52.0

