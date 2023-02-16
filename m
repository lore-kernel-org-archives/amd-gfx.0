Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9C9C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 10:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2AF10ECE0;
	Thu, 16 Feb 2023 10:11:26 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A64610E733
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1676540785; i=spasswolf@web.de;
 bh=CBCQamnoohYQJAg4KfZxKlXm6Y38I0LwGbwUe+WeapQ=;
 h=X-UI-Sender-Class:Subject:From:To:Date;
 b=SfD1J7BE0el+HqXvqkvDqwEkkjggSR7N4rSwm4Ngso3Y/2z/iqrJKBegvZWC0lhI2
 Aw3Jx7287NkWNdJWJCweE7uX9L2H9X7+kzmgNo1oVoJQpKcOtR1h3ao9hBwn+U2YOg
 u7EVIoHQgC5SO1lxhogRJBzCZJHdK2hSqKEbjfv12rrTnpIzLIxci6d1GrzsddChtG
 gdNawQSetVsIJq3jkVzmCUkA2iRtwNIFJpnkcoXOIcwaVrxwEMeguo8y32w1vSNFjP
 QOLEZyGxSnihGM7+V2vu8F3QAeXVY0cOkRJewd9oDzQLEaOdyn7coxFyEsqBct5cag
 9fZwPE+nE9e+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mgzeb-1ou3q80i7x-00hLc0 for
 <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 10:46:25 +0100
Message-ID: <5dfb45ae90725c63232e063852e761ac11e6bce3.camel@web.de>
Subject: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 16 Feb 2023 10:46:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:kXLslh8xBMcf2IzMYdG+9FTi7W3vNl/7CXfgxmjjUK9B4ycb/FH
 W1SroRVppLdrgWwFGP9kx+LF8xvcbg7Xj/f96REBENWKqbiHZmfVtlr+/iAXGjfJpWs/bZO
 eyAtLqFIz2JaW2+5nC0UZD/fyF4rVsC69liGcOlp1qLR+5i4G4xXRKcXXPH7n0Xiqh+NqiX
 xeq8DUxrTZZSGg7TIrHuw==
UI-OutboundReport: notjunk:1;M01:P0:UTegYW+jq6s=;fXqf6Ner50sQ4gD1fVzOjSLqn1d
 qfdN8AA7CVBU/d2F4mXdFygQ4GchayBFj9PGQtSyEEBh2t8OySJgL331t2KXdwrvonal6R4RO
 5dZsMzL9a5CsvqjHsaVcphIwCAVmprwEfFioMYLXaE0seYSJ/fWiF0yQnwtU0sl57dy0SMhWU
 xgyVLTa/ZisnX/9Tm96oU6l4HBW6XuICJ8dOW/dQctcRxLw/X+9AIRhloPmeU8w7JiUsvjuBF
 tW+Lq2GckxDE/VSpzKnxgZrh7X8AqOAzrmm7kxMdQ/B5w2VBpFov8JfpM70h+RjBEoBLLb2Uw
 10jMJR6hSjlQBx4cVp0+4MANMAfTvuJSAbwKQ8X8nwGsO/8y+u3LjD81N4w9zGHlpMBmNrWzf
 WEykTPsHCt+K85UUHbQHxGMp6npWueG4JFs2I/agOKjpoA+V34yMLryhTDZI8TAgGYBeA0nI2
 e6/+F5TSu5kzludlDkXUsxgTt5qXbDxLoGZvRlvU/SP2dvTctVty2zldATvFvFlmxBkNKOqhU
 VWuYz2m1fq6lfa6zRkJse2yEzow3TxNirbXA0yexNY86THAD//G+uAMyqSCmx8mb/crSYBBhN
 O5eEEKOceCedIOcY8PfiQJbplqyeA/r/PzxMRayZWFxYLFMqrq0DfGUHihZqJZAGWimMCrWZy
 6B5zmmmbgvKeEC3f4glS1RjM5Jm2MpTAMEPzeO+BM3CyhIh1MxiNV+wuHmZFzsEa/7iTZZwh2
 TgsNjiCfq+GzFq+qyZtmGR6HWNRFpAlu+lqc5I7A3yFPdZz2gh9HGq3V0nMyZtdLcvbeK+Yfe
 HQBbCUN/amLKvuHV9ya0LZgBZlpg/gHM3OuYa6XE/3Ljd7vFSFqtCn3TfySInMNQhFTYqYjcz
 czOVcU+SXjWKI9qaixyfOwK63c/Wyp0X4xc56wH/6CFwYc5WhYNRO9fVQBWfWO/CnGCSYw5mt
 b0sP8Q==
X-Mailman-Approved-At: Thu, 16 Feb 2023 10:11:24 +0000
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

When drm_kms_helper_poll_disable is used in amdgpu_device_suspend
without drm_kms_helper_poll_init having been called it causes a warning
in __flush_work:
https://gitlab.freedesktop.org/drm/amd/-/issues/2411
To avoid this one can use drm_kms_helper_poll_fini instead:


From 51cba3ae1e9f557cca8e37eb43b9b9310d0d504d Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Thu, 16 Feb 2023 10:34:11 +0100
Subject: [PATCH] Use drm_kms_helper_poll_fini instead of
 drm_kms_helper_poll_disable in amdgpu_device.c to avoid a warning from
 __flush_work.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/drm_probe_helper.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b325f7039e0e..dc9e9868a84b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4145,7 +4145,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
bool fbcon)
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
 		DRM_WARN("smart shift update failed\n");
=20
-	drm_kms_helper_poll_disable(dev);
+	drm_kms_helper_poll_fini(dev);
=20
 	if (fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
>fb_helper, true);
diff --git a/drivers/gpu/drm/drm_probe_helper.c
b/drivers/gpu/drm/drm_probe_helper.c
index 8127be134c39..105d00d5ebf3 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -842,9 +842,10 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
  *
  * This function disables the output polling work.
  *
- * Drivers can call this helper from their device suspend
implementation. It is
- * not an error to call this even when output polling isn't enabled or
already
- * disabled. Polling is re-enabled by calling
drm_kms_helper_poll_enable().
+ * Drivers can call this helper from their device suspend
implementation. If it
+ * is not known if drm_kms_helper_poll_init has been called before the
driver
+ * should use drm_kms_helper_poll_fini_instead.
+ * Polling is re-enabled by calling drm_kms_helper_poll_enable().
  *
  * Note that calls to enable and disable polling must be strictly
ordered, which
  * is automatically the case when they're only call from
suspend/resume
--=20
2.39.1



Bert Karwatzki

