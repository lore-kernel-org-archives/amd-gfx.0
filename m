Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AAAE7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 08:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5C610E5BD;
	Mon, 13 Jan 2025 08:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/sEBwOd";
	dkim-atps=neutral
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7314410E02B
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 18:59:49 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so32882565e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736621988; x=1737226788; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L3DgohbenACHXn6wOW4eU9gM7Gu7Z7kDdY29V2QFR8Y=;
 b=j/sEBwOd/4JUWpelyO7vLJ4z+FK8e+Od4TVukhJtyqz7HjqYF8DipuIZqI2pxlVEt4
 pEgiyxTs4cbzESkvPriF2rsCMJp98oOjrGmDx2t1AqhSgL3IxAjfCYuMMW3KSmRja/nA
 bt7QcnZTCTjFWNYy5EG9ZoEEjSs0GI4ThTdzuDZCvWqxf4Lb8x9BNU0myJ7AG/xbYgZL
 qKQD+c9USqG7+BZ2TSwIRon7tF3Q6/HO9v3pRaOoQjmAj+bzRPuEvkEvKaP+sZOCXTBx
 J46+DQZPZgjAmB2XRzSSgGwmOptCmsEzqqYajkXgJx9IH5y60cTg8AlS2/NJmdqVqIBE
 Z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736621988; x=1737226788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3DgohbenACHXn6wOW4eU9gM7Gu7Z7kDdY29V2QFR8Y=;
 b=L56+WGi5udU5GCEINxFhVPqgQZcpnPYP3iM2zRmKxMWzZqAwdBAo0M5FlgToOIY0NB
 Qb6DMvP2ka8kspy5ReEslUlBSOGAoRO605dfXlQJcHh95cK9k6wpjy4HsI1LRRV5W+sb
 /8IR/K4lveEYkXH65a2ZgWweL8g5ctJurPXOnjuDckgfdtcdL4fLcCBGtxaogqOp0WL1
 8P+RbtA8pNiZY3fIQdZFixTTpFzqx9bt80D/ml7DYHGCQ9BI/krd8TKchALworzEpGRA
 /yoxxAf2KHmr/cMWM979GXYYKHi98BR/eYMvTTerKsB9fPDUen3LqG5xNSTJkSbDwOcS
 AyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVifKZZ6KGGpcPoV6j6DrDAusCseoF6GENGHE+vOvGxYmZpbwcvywyS2nkUUKRVz/Ef9P+jGecb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoAgUDSMcqWvMsg0bytGZlCqTqsHKg57b9j6owfKIozOtCh6VU
 wRX0FK2JtKZ7MmpHPlKhwKneI8m9q8ZPmFJDIfQTuXKz6AAkX+WX
X-Gm-Gg: ASbGnct5dD+nPv4ASg6x4BOY1wwtxZKHoswUJRPhj+8E1nZuW/8/bG+GzJlwU6KPDer
 5v8VdZQTMh5q8ojLmsEyAMq8ATlwIlBzYk2Y78n1dwHH25tPENXiCd9jxiPS5/6c3WTBWkH1Uxp
 UxBSeODwBqR649Z3UG9y1jDXMj0JuLx1gescR08BzNRBRCyExsckjU/wYqiO0As5IrrgFR2S3yS
 rgV4V5863bV3kh/bCtaSDLj62wedU3XoQ1jKjk7Pxtsmt6Xo1Uy8xSJqZcZTswySA==
X-Google-Smtp-Source: AGHT+IEPA1ZIEy2BVvJIreSvtc7pK5EpKKeAI+bCNXKQkeEEBtMKu5+tlqaQ1Ywp2IM9xt0CHUsflQ==
X-Received: by 2002:a05:600c:348c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-436ed3316a4mr93947005e9.12.1736621987670; 
 Sat, 11 Jan 2025 10:59:47 -0800 (PST)
Received: from debian.local ([83.105.230.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6263fsm92372725e9.39.2025.01.11.10.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:59:47 -0800 (PST)
Date: Sat, 11 Jan 2025 18:59:45 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
Message-ID: <Z4K_oQL7eA9Owkbs@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
X-Mailman-Approved-At: Mon, 13 Jan 2025 08:36:44 +0000
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
EDID data, and correctly freeing the acpi_buffer pointer.

The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
remove the extraneous kmemdup here as the EDID data is now copied in
acpi_video_device_EDID.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
---
Changes in v2:
	- check kmemdup() return value
	- move buffer management into acpi_video_device_EDID()
	- return actual length value of buffer
---
 drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
 drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8274a17872ed..3c627bdf2d1b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 	return 0;
 }
 
+/*
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
+ *	edid    : address for returned EDID pointer
+ *	length  : _DDC length to request (must be a multiple of 128)
+ *
+ *  Return Value:
+ *	Length of EDID (positive value) or error (negative value)
+ *
+ *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data is written
+ *  to the edid address, and the length of the EDID is returned. The caller is
+ *  responsible for freeing the edid pointer.
+ */
+
 static int
-acpi_video_device_EDID(struct acpi_video_device *device,
-		       union acpi_object **edid, int length)
+acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length)
 {
-	int status;
+	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
-
+	int ret;
 
 	*edid = NULL;
 
@@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device *device,
 
 	obj = buffer.pointer;
 
-	if (obj && obj->type == ACPI_TYPE_BUFFER)
-		*edid = obj;
-	else {
+	if (obj && obj->type == ACPI_TYPE_BUFFER) {
+		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
+		ret = *edid ? obj->buffer.length : -ENOMEM;
+	} else {
 		acpi_handle_debug(device->dev->handle,
 				 "Invalid _DDC data for length %d\n", length);
-		status = -EFAULT;
-		kfree(obj);
+		ret = -EFAULT;
 	}
 
-	return status;
+	kfree(obj);
+	return ret;
 }
 
 /* bus */
@@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
-	union acpi_object *buffer = NULL;
-	acpi_status status;
-	int i, length;
+	int i, length, ret;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 		}
 
 		for (length = 512; length > 0; length -= 128) {
-			status = acpi_video_device_EDID(video_device, &buffer,
-							length);
-			if (ACPI_SUCCESS(status))
-				break;
+			ret = acpi_video_device_EDID(video_device, edid, length);
+			if (ret > 0)
+				return ret;
 		}
-		if (!length)
-			continue;
-
-		*edid = buffer->buffer.pointer;
-		return length;
 	}
 
 	return -ENODEV;
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

