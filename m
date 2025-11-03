Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FCACCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2D210E4BE;
	Mon,  3 Nov 2025 22:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQ5V6eSF";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3296E10E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:04 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64080ccf749so6174405a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208643; x=1762813443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cT+d//URVvCaDQGIqsRLhZbuLDoeonR8rNy8BEPdDbo=;
 b=UQ5V6eSF0sQIUhQJiPLiF1bQSkyvyxoOGnRyaXMY7QwH3JYd3/5Gn7iPvHl1lnUbey
 OWQyieuaH+c1wUy/7VeNpdpmAeoTTt5qiJg9y/h0hjdyCBfPwPLtmjNBHFYH4sqNPuNt
 yQ68dM5XjIV8NUyJI0FAf2f3d+cIQGlB/5iCVbIN7vap+gNVfMpgTHpHSbbrhnzdDI7j
 MTO0Jno32K+Pgfno9zvbYlm8pY7w9Is7SWI/xeHwLByCJ/AAE2ddEabsgcf9IA0kRG89
 QzUqqgYIa40p+uddi3yzImnvQTauj+B1eE/1f3N7ks+u0tn6Wdf8UEA0AzMBi1KVSoCr
 CXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208643; x=1762813443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT+d//URVvCaDQGIqsRLhZbuLDoeonR8rNy8BEPdDbo=;
 b=f13SjUMzOClbRAjmMbnWDxLUTAz3ceZmzogJdacKirf3LKC+ewfq+PpzJ3Ar9t0uS9
 z5jNYuGbZ5iUMbabtELBn57TX0AkcmzEXNc6W0EqAv3KBW9k5fHQgVRAd2xJwt66fcf4
 iIRC1Q4w8dq/pr2MNDHDPFy+FLNhNu8IFO4ehhNGNGXj75k6Kpm30vNBJ0mrTix5EEic
 o7lo7ttVJe5EwCDp1EqLzUeG5wG8SjcwDmZYIeCf0rT4yD6VoHQZhjy8LvZanGjg99ca
 btrzdsG2YySX/ir6JorpwVk1ptzzXP5tpSppZ4ocxOXQrIduOy1jd4X19MZB8EPBVKkO
 baJg==
X-Gm-Message-State: AOJu0YwEiU/MSH7MJLGyfzcFpRAmCVrDnsetWX6K+fGphfJadoLQKo7G
 H41TeBOGBBzFygRnuZknWZ0AeYp6+8gpoiDnOR0wHiUnAeQv2ecr+JK4Qx2Jq4cw
X-Gm-Gg: ASbGncsex3q1p7IRqfRTfyw54w5EkiySnOhGMfJ/vZ29AkR25ze/KAA4l59VXK6jlZG
 s1ORjtv04fbrkraNW1j5jwhdkFfDkb9CFHtb7ycRlwwzoQVNXmbs7uWfkqtMmMeUkGsBD63wuGf
 xiEQyb2xvIba1N2Gh50yFOv0WFxZU5sIH0sukIo59rT1JUP2AoXIhVb9eX9lPXzIGT8ot9sh6CC
 z7FJ5CdR0VwLYC7DRGhrl16iYmZiSEvVfKuL80f0uQA/1ebxXOiz6hT6D1MrXVOpz0XBxqMXXrB
 t7NelKzKqLzBPcRZhVde+N4UY23wMOe8HODfzoxd3u/1cBP7XRTKx7XJHqyJdj50daFwMqnKhCH
 SqRxjfeStT3zcfWsZINps78DfLF19Uvz7WYaKQkAQ7oNVE8kZ7ydlIA+3hYCzZhmFMONdsePVM7
 AEbg2iMdg1FhJy1BdXBQM=
X-Google-Smtp-Source: AGHT+IEG9N31KzHTeH78Jq5o2oB2PAcNY8e3auqHGvuCwH8GK/SUWN6MhoZAFmSYF5bQo1bd1FbtLA==
X-Received: by 2002:a05:6402:51cf:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-6407703ef39mr12616840a12.33.1762208642563; 
 Mon, 03 Nov 2025 14:24:02 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:01 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 06/16] drm/amdgpu/vce: Clear VCPU BO before copying firmware
 to it (v2)
Date: Mon,  3 Nov 2025 23:23:23 +0100
Message-ID: <20251103222333.37817-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

The VCPU BO doesn't only contain the VCE firmware but also other
ranges that the VCE uses for its stack and data. Let's initialize
this to zero to avoid having garbage in the VCPU BO.

v2:
- Only clear BO after creation, not on resume.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..e028ad0d3b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -187,6 +187,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 		return r;
 	}
 
+	memset_io(adev->vce.cpu_addr, 0, size);
+
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
 		atomic_set(&adev->vce.handles[i], 0);
 		adev->vce.filp[i] = NULL;
-- 
2.51.0

