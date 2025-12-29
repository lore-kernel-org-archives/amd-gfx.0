Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F71E92FD7
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 21:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A1210E73E;
	Mon, 29 Dec 2025 21:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Vu+2SDlJ";
	dkim-atps=neutral
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F23210E73B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 21:59:48 +0000 (UTC)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-4ee2014c228so57564131cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 13:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045587; x=1767650387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IB8+29ViFF3HgSBOU+iv2rB43ubUg7MMKbsWRsTRATY=;
 b=lfao8sHxVGpICwqye2JfEtWduaMUsvSbkONCIs15te2BQQXQveLanBYTKMy+ZjzFW1
 s8ZeTTVqYKDS1ZL+xj5F5yZurD9JFPRw5N6RRGOU8aqZ7zvjOxCrAx1WNx9676sqMxll
 JSisBZrc/ZDEwaZ8mfie1+qToRPRAuVKilusffRMnpUfgPgmdqUZwak2hedBhIPajdYN
 k+KudgeQmF6Z+dPqJWxPJwvcY6DJ4vhAO6FgYbgc220DX7BS5ogwgTH4F6J38cEakkaK
 /u82GsQYRkIxShqTtEdHe38SnpPczqXn7EQQMbF7SjbBDIlbneGxEXuBGVTwl/RsfDYx
 TsLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZFtg5EqrDDSZF6Jid7lGQysjeCZeztAdlItm7jIh2dh8x+8iO465cvnYA8UhxeRl8iIX+sGNA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL3WFv5OqPaJEPe8kd9AiZZQfx5v0/ZRjFac4oWfnGnKpfWr1P
 1/69rXmRcNH5zM0aKrOT6n0qTEexyr7waxf1Fyp1iZEuXgQtrx+CICoKoVI1gxZEBdWQy3BNCrB
 OxZCLDzf8BPtx1p2W/+wojaykT4Fvefz/VDqtupsCCAcgdWUNiVzIi+itbyFzDBXpvVvurKEzd1
 /PjHat9RCcvIoQfhv6w3Fsp61xl1WrIH7xsfHfm69mp4AJNMp2kBcoahdgxzI9mx+k2K/qOKWdc
 T8RJgMF0L38ikxVXg==
X-Gm-Gg: AY/fxX457wWPihvWFSjgzXed3UdMGG5GVYPRfXnSesLu/j9Y6irqtYod/eCNx4IQZja
 lslty8N2+wksUlZWgWWN2Wy95SEGhTUViDYByj3xa1bhts2npuNqYUioom7zcIHWtp3U8DjZW/l
 9jIaQ7cuuud01DgKWb68CeRoZFDF8ZJ5aBJmS45+HFMk/I33e+FyYeNImz8s5e46OpQEVn0AL7H
 TUsWNfOdY8f5Gt8wFUC5b5y9YSmKY3mKHWvZAmLOo9D1JAcGnpjAaG1JbCAZ4Md+kPuFXYkU2GE
 WiwS6GPMfdx54YfIl9ANJjYPoOl1pOobg+VqLNtf0/yr0LiFmilq42HncFA9miCJS+Ek1VwMhmZ
 yrZ/K5YQ0wojsnfcJpM3b7RM8H95teoPbL0Vsyj163vcMr5ICcUqMVAa5a8abwCSSuj//0iWfld
 SbixPyRuRhlnDnYgAtqi5REm4mM8oXJO2QBsPw36waqpso
X-Google-Smtp-Source: AGHT+IFiaU3nX+exs1ab2LCb8hX9X8CuGu+X45JxAAck2AP4hVLN1SQECaZjxTp6nU4gOizAzpQEIN/choTl
X-Received: by 2002:a05:622a:4d43:b0:4f1:b9e1:f08f with SMTP id
 d75a77b69052e-4f4abccef46mr614636061cf.5.1767045587401; 
 Mon, 29 Dec 2025 13:59:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-4f4ac603962sm10164641cf.8.2025.12.29.13.59.46
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Dec 2025 13:59:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b9ff555d2dso2301863685a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 13:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1767045584; x=1767650384;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IB8+29ViFF3HgSBOU+iv2rB43ubUg7MMKbsWRsTRATY=;
 b=Vu+2SDlJXcENMM1kIUXAzx8luxKh4uvBwOLAJiMKFm2s/dQCW/Ih5+x1cEJi0jIcFN
 VUHkQcloxfnjVf5GpIzhfoz9KqINrzblgHqOgYBVBvJ5dwunjPVP+1ZYr/XrKc5iJfpQ
 gyhCav+ph2fwWHiI0ui1mE6n5d4gkZYjC3F6s=
X-Forwarded-Encrypted: i=1;
 AJvYcCW5TuOZcPqqQkXx4HCvgQYKfDM2hCNFjabG9+2ElbSVftUb5JuRVDIBs4NzKLvEapqUd5p1VSLG@lists.freedesktop.org
X-Received: by 2002:a05:620a:2911:b0:89e:b8af:f72d with SMTP id
 af79cd13be357-8c08fa99987mr4700270085a.57.1767045584543; 
 Mon, 29 Dec 2025 13:59:44 -0800 (PST)
X-Received: by 2002:a05:620a:2911:b0:89e:b8af:f72d with SMTP id
 af79cd13be357-8c08fa99987mr4700268685a.57.1767045584169; 
 Mon, 29 Dec 2025 13:59:44 -0800 (PST)
Received: from localhost.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 13:59:40 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] drm/radeon: Use devm aperture helpers for sysfb restore
 on probe failure
Date: Mon, 29 Dec 2025 16:58:17 -0500
Message-ID: <20251229215906.3688205-12-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Use devm_aperture_remove_conflicting_pci_devices() instead of the
non-devm variant to automatically restore the system framebuffer
(efifb/simpledrm) if the driver's probe fails after removing the
firmware framebuffer.

Call devm_aperture_remove_conflicting_pci_devices_done() after
successful probe to cancel the automatic restore, as the driver
is now responsible for display output.

This ensures users don't lose display output if the radeon driver
fails to probe after removing the firmware framebuffer.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 87fd6255c114..225f716d5db9 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -324,8 +324,13 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (vga_switcheroo_client_probe_defer(pdev))
 		return -EPROBE_DEFER;
 
-	/* Get rid of things like offb */
-	ret = aperture_remove_conflicting_pci_devices(pdev, kms_driver.name);
+	/*
+	 * Get rid of things like offb. Use devm variant to automatically
+	 * restore sysfb if probe fails. This ensures the user doesn't lose
+	 * display if our probe fails after removing the firmware framebuffer
+	 * (efifb/simpledrm).
+	 */
+	ret = devm_aperture_remove_conflicting_pci_devices(pdev, kms_driver.name);
 	if (ret)
 		return ret;
 
@@ -361,6 +366,12 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	drm_client_setup(ddev, format);
 
+	/*
+	 * Probe succeeded - cancel the automatic sysfb restore action.
+	 * We're now responsible for display output.
+	 */
+	devm_aperture_remove_conflicting_pci_devices_done(pdev);
+
 	return 0;
 
 err:
-- 
2.48.1

