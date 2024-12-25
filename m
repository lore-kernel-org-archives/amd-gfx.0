Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCA5E7718E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 09:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C2310E7E1;
	Thu, 26 Dec 2024 09:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZ4ipnVS";
	dkim-atps=neutral
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC06510E5E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 23:09:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3ea065b79so8930200a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735168194; x=1735772994; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9v+px78eG66InOEEBnkMK4cXXwgTr2T0JPbH4BNA8E=;
 b=SZ4ipnVSiI8zDR2iKOuUEQItLNSpUdMl4WuAESUVsnfUum+6E1vVfEV8DRlnKAuTMT
 xlgHUHSZG5UZGZkjyPFvDaiz61b3zpNqIsCb9ATvejGfCdb0rSoJkHKJWepKwWJu5n7c
 MxFkdm2fTDFIXXUiNswWs+CnmbSvca40NGiF1JYeUPM6DkzytShG8/6Xl355fh2/LfSm
 8/QGJeBdOqfSJsoo3b8CfdgdE2HQPV62mMsUzlxrpz4XEJ20T4krLzRs87x5R7V556of
 HSQomOiJHEMceLMkyYd4qjMF68+xvWqAu6g4+NZL/ziOkUf4eLee8NcFql2QLOHyIV71
 i7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735168194; x=1735772994;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9v+px78eG66InOEEBnkMK4cXXwgTr2T0JPbH4BNA8E=;
 b=Z+q0tIExXG2PenT0laTlAB8zuqRuzUze4c9xaZDm8Re0C83Ea3Ypqj8uuWTIkl85ti
 VFJ9hXtrvmkjTamHucFAwlYIH/pO3JafAXnOSzr6dgKGf/kPUypZa7fD/NBgv3PDRjMO
 M8WIPQujH154BRiSiYUCLQk8VcRQxYxiRsmg5SDaMqdRfWXiTIN6N5peF0BzEM426XcG
 oDD+cb31K2ZdXy6Og7gNGDsU6Oa+FfWAA/rLS9Lo3eyKLh3mNa3/UrSuZXy8lKA7NLiA
 +BftiwHesKz8OTnTBWQ0q44xaHnO+DkzcAd4WvcNjPPNSWdueY7Y0BVvYMbEHca10C9E
 LIcw==
X-Gm-Message-State: AOJu0Yy5/gftalZ4o1ZumxkavKTCADX9gOzEjnz0sbyUlCi/7nQ99pNQ
 aPHzCvl/KXmb8cpgOguhTTWJFNrXLq+10EOXsYUmJdlyMbioxidO
X-Gm-Gg: ASbGncsMDfR1p2iJcmtWZRyZExS347kgNaPYR6JwlFHHwB+l1lBlxB28SUMIf12LhBX
 z4O8B4RiGnzwaRO9//OkkFVxClKFA6OcMeuZxGomIg/V8hk8qDPBhOpPnj/w7Nt3UQfoLMQNh9T
 WMJZVBgJhHOcZJ2TMkOVB+KFTJk1Ce3PRqpKXpeM1HmJAKTTApFhpQuobceId+/8/UzSIJguTzr
 5vyWwDq0iKR9MXz1vyJeyeD6i1zbQjcZGBJK7FCn1av5yg5H7eBWZ3O1TszpzA=
X-Google-Smtp-Source: AGHT+IFmA+25Ix88Cs6aGxcufnGYvRlbbn3zhK/hJN7bbVC8PbiIb0lazhzgSE8YiH5F8BHuqE5i5g==
X-Received: by 2002:a05:6402:50d0:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d81dd849efmr17082749a12.4.1735168193836; 
 Wed, 25 Dec 2024 15:09:53 -0800 (PST)
Received: from debian.local ([31.94.62.22]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm8065745a12.40.2024.12.25.15.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Dec 2024 15:09:52 -0800 (PST)
Date: Wed, 25 Dec 2024 23:09:49 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, tjakobi@math.uni-bielefeld.de,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z2yQvTyg_MWwrlj3@debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 26 Dec 2024 09:00:11 +0000
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

Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
available for eDP") added function dm_helpers_probe_acpi_edid, which
fetches the EDID from the BIOS by calling acpi_video_get_edid.
acpi_video_get_edid returns a pointer to the EDID, but this pointer does
not originate from kmalloc - it is actually the internal "pointer" field
from an acpi_buffer struct (which did come from kmalloc).
dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
resulting in memory corruption which leads to random, intermittent
crashes (e.g. 4% of boots will fail with some Oops).

Fix this by allocating a new array (which can be safely freed) for the
EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.

The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
remove the extraneous kmemdup here as the EDID data is now copied in
acpi_video_get_edid.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
---
 drivers/acpi/acpi_video.c              | 3 ++-
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8274a17872ed..151d1d534264 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1485,7 +1485,8 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 		if (!length)
 			continue;
 
-		*edid = buffer->buffer.pointer;
+		*edid = kmemdup(buffer->buffer.pointer, length, GFP_KERNEL);
+		kfree(buffer);
 		return length;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 8f0c69aad248..21b56cc7605c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 	if (ret < 0)
 		return NULL;
 
-	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+	return edid;
 }
 
 bool nouveau_acpi_video_backlight_use_native(void)
-- 
2.39.5

