Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FF606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yjBSTtpg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2419410FB67;
	Wed,  4 Nov 2026 11:12:36 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E59810E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:33:14 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8ad98c3fb15so35771947b3.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 06:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716393; cv=none;
 d=google.com; s=arc-20260327;
 b=HCBYKdsGjJEuiJI216o63RswGVz7+dUXqWcjra4RpK9DNWLnwzV1VktDJ4fAGNsK2x
 MnjZ5MrvsTHJBh2CfNNOT3FMu2/mLQuH9n8oPnO0vnqOwiOPjnEA8yNRQyrS5py+d16H
 ZVaGnyW/yurR93GxXE7sQPMGeKAXgEX8IjbohQGkWhze07nayY+dOxriFk31k/skuiiL
 4RFgo9qBn1f/2yJEq0PiyYdLvIWFBN86GwcJx22+xoF9akZgGSr/1QjIfyoDv6vnVyf+
 aJM68ol6ZC6CHC8gsJmOTLrfvkKWZux+FjEEW9XDJ8/AWwgBuYWrz6zDFmpcoWfqRdtH
 MiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=8d5wD5dfHYhIC7Dn7bSCspPbcbS20fJq+vjrYiTLluA=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=hTl8Zdc74/41NuupthgoSOZXcxWs4L6EoKK2ThIONfIZy0/hTgON/6D0Glhp0nDDcB
 mUNC09lFj8G0N21XCL6sFMDb5B18GAiErZc7GGy/4auTtKosatt3TFT+KztlXoG7WWBT
 wRW/wTbxV/IwUrZwZIoevq/IrJ8yEpRSwYSYYcCCb/F6sxcp8uPG6/YSsZklDDALciUN
 8JZ6NObJG81cjqfIfdEhcuyaH7qzx/30zd2nxE+tlznDCasYEWccL7FNQPKkA4xNhtMA
 Q35fZuVHvUxbuMjVnRkMkr5AOyBDYtZpMFyi9KdHYsCb5pHdNYDaN69GkM7xmeuHSmEP
 xm6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716393; x=1794321193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8d5wD5dfHYhIC7Dn7bSCspPbcbS20fJq+vjrYiTLluA=;
 b=yjBSTtpgbU/E8BuvmxflTujA+kyRcPuSWagqAfqoVFwp8KFdegWNPWjmmLrqDO+FmP
 82dFr5dyhpcPSRRfDsE3ccRYHsWmrIDuaQ63iKkHK5zIkxR6Qqdf42l6g0ukb3cuEijT
 OedO8JCiO+I3a1EocDuo37AuqUsULrK/RF48cTeClgzUH7ZdlJRIx356gobTUzyZvXNf
 vR6V1iusPWNEr5Uar7p/Vrq6wnwXTKmp9M/GEh9bNVKuYNEpA0FMuKAq0l0OMyoBreGU
 5LkaYvxYyIUPTs47YID6eG+pk6uMSjDABoH2YUbPyhn6f5OGkrwhQgyHEMe0BpcvWV64
 Rdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716393; x=1794321193;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8d5wD5dfHYhIC7Dn7bSCspPbcbS20fJq+vjrYiTLluA=;
 b=EdximhbF+QZ8EM5I92Ks7t0JhNu8S3fC6wC9Fvx5UaTDIftc9a6a5aZcQowNnH5fGe
 BfmpT4BSuPn+LkJDw8t5zT+v0GMBFsa1V84faMbwg6CSyiaNDyh3m8w0r6cVCVZt3XHv
 VUWSu9Hz3oUwJ1o2KjaQX67iPVvUqSocFNhIv2wXiojFhWmz81ZNR/HftqxfYGlTRFMg
 cEDXHqfakXoBZw0PVyJlz1xdbRfevkm7jBa53zNOVCFk1ZC9DSJ/ufyDfty/EpKcVprz
 CLaeU/pNULQMlzIgU/ccuQCXnsE+ybsHtrnLtlqb8lv4bbQONeeZebYpItAAzRw4WL1d
 8Uuw==
X-Gm-Message-State: APuU4Z8uNQYzQ4qZh4hoH3QMw+Ze4gfp7hOQLgtasvxzryQYFGvPWs7c
 OgbWfooLuWpRvNhejY3y1uyDBFgCfTAOaPtJlp7pDWMXi0zVf+IBXgEBEqISjLWBgYugKuuWgwB
 ykBotZs4OldvuS5AETNC7stb61+cSTbF7MQ==
X-Gm-Gg: AYBFou3FQdiXfTUrq7wAbZ55y+llzzy8ue1o0+2IuNgFYLnDLrGIqMxZUhNmwzFLKOG
 a4Ms0u1X94JHkaapz1snak0fs6xhDsBpae4b/s1eVf5ceS1FaNcZ3phv1/EBkk1oqSYZzetPAzO
 lw+cE5plRJBXZy0WQoEFFvi1PqhBaB9PhwlVbnq9zGD55qfpiMLpwFDLyhN0UOXzTJUwEfT+W8X
 6scd+1jwEY6ekaXjXNp2/H5eAD3xljX9zTJOEpQqA8tUp9jVrIWcB+RQzdO8k+RNa644OT3vO+E
 mq24c0L7UJp53wrS3MkS+tuaic0aO3NHCH+xcpl19KN/gWu5ovTftlhe332rl5xreRBKxj0BaT5
 nBxPWaHT3necvoIC8DD6OpBfNAZ7VVSKEp5PhOdI6tf567Zwp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690c:8008:20b0:8af:511e:3b11 with SMTP id
 00721157ae682-8b2b67c87b1mr71450007b3.48.1793716392893; Tue, 03 Nov 2026
 06:33:12 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 06:33:12 -0800
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 06:33:12 -0800
From: =?UTF-8?B?VG9tw4PGksOCwqHDg+KApsOCwqEgQ2h2w4PGksOCwqF0YWw=?=
 <tomas.chvatal@gmail.com>
Date: Tue, 3 Nov 2026 06:33:12 -0800
X-Gm-Features: AclHuK_yaxYA9wkiXYIo-uvkyZJZPUsFH34fi5VYa5wVV5OeA4ATDy818rpu1mI
Message-ID: <CA+NrkpdBi6cw2Sjahkrnf+b0osXwX3A_ymiaSm6-ETkN0s0GDA@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: refuse runtime suspend when the master has no
 displays
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_runtime_idle_check_display() refuses runtime suspend when a
display is connected or a CRTC is active, but it allows suspend when
no display is connected at all. In that state a compositor or greeter
holding the DRM master is stranded: output polling is disabled and
HPD interrupts are suspended across runtime suspend, so a display
connected afterwards is never noticed. The console and the greeter
stay dead until something else resumes the device, e.g. a
display-manager restart.

Refuse runtime suspend when userspace holds the DRM master and no
display is connected. Render-only devices without a master are
unaffected, and amdgpu.runpm=3D-2 keeps its existing override behavior.

Link: https://github.com/sddm/sddm/issues/2168

Signed-off-by: Tom=C3=A1=C5=A1 Chv=C3=A1tal <tomas.chvatal@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 731fe8f..792022f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2840,6 +2840,17 @@ static int
amdgpu_runtime_idle_check_display(struct device *dev)
 			drm_connector_list_iter_end(&iter);
 			mutex_unlock(&drm_dev->mode_config.mutex);

+			/*
+			 * With a DRM master but no display connected, runtime
+			 * suspend strands userspace: polling is disabled and HPD
+			 * interrupts are suspended, so a display connected later
+			 * is never noticed.
+			 */
+			mutex_lock(&drm_dev->master_mutex);
+			if (drm_dev->master)
+				ret =3D -EBUSY;
+			mutex_unlock(&drm_dev->master_mutex);
+
 			if (ret)
 				return ret;
 		}
