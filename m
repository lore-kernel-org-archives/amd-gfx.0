Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77236C5B569
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2478E10E6CD;
	Mon, 10 Aug 2026 06:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSVpt1UN";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCD210E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:39 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so7003845ad.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252419; x=1786857219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uV1jDlXdjYzrBZ5UiAE52SxJwX6HGbMM4vfraaFeu8=;
 b=oSVpt1UNuL/L68khgH3VTwfZLNOg7XMZjQAGSnAQIaAi/brfw0OWm1NPrhO6GQb93E
 3pWLYlVdePSe7EkdezP+nxQZvJjv2yT5TBkBiHb5CFHCkvBz65dqM1Cj7fm76Vtmbev2
 Y4vprDB27rEF59hP8naElfc7uUoJl91XvtOMKShx9EEzPstcp7lZrih0tyK2YQOMdMyg
 GZjKQlLaRMQfMjhnThNQct2ePjeqh+H1yVsfrVONZbh0fEYVl6q6CxN05KiQChTqXh5g
 pq5yQo/AA/koHkG/AsA0A41X42YtMsglV3MPqa8GA0KOJCsHB4EbnaKxDhpmtPGq9ulL
 prcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252419; x=1786857219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3uV1jDlXdjYzrBZ5UiAE52SxJwX6HGbMM4vfraaFeu8=;
 b=DF7Ol/6gWvZ0vhUfaUpEH8BKG2LRy1VKgp/3s0EI+dMIhAuWayCJ8IYRNDrwTTFO4c
 /Yd1oTqqb2cIm//njOAsIkpiw5rgHZb06bOb+4AVmAB4slRbnqIEDMSGIcXZT0x21dNc
 h1GD7Ba1Qe9NjRb85rATbt4sNTzJoLZLRHZNgtVBO+F6rPLPXuI2H5Qi/vNVq9ZqcSoJ
 kLbEAuQYHs7dBSN234EHFLSPWLx6/+VLZUAyE+5kEQVxS5Sp78RLyGXYHRjpUjKSi4oy
 YyOmML0/3uD7yIoh8uI0yzA8W+SHfr7dyMdYTrgWWb8xTucbYeVzscX+1gCQ3yGk5P4p
 WSgQ==
X-Gm-Message-State: AOJu0Yx+JwYEfixXcu/I31KlQD1rEJbZRKK4xNzTnYeoKXRH599WX21O
 +VxJ6zkFu0VAvdaEKI5/TnA909X+hwHGhBHseqZeqBeyMJDnvF8wptfo
X-Gm-Gg: AR+sD13cmhbfNrhbSHB1ounhLQRNRAOpskClz0yf3OWkhgbJHBe6s6L6oP3B7aLJYPJ
 DxH+daGjan3KCOC6OfDzdu75eh5/e/4dJuqSAGPnTKJ1vtWec2IeSJa+NvVhH1o7cvazAVpU74N
 gVlRdRq5c17RTbjl2mPlzG+xyCOwQZAvgfjNa2RGH0xGt4i2YUxc25FYgkk9vSzRI2t9B7fWnp8
 aHAJrdRqh9NJCzPLgj7Ml4GITKyWHBee8AwArn89Z4ug93FGMDHM9GhezglrsawEMwnOXaNQyUA
 7yXRmjiBul1a1Tk5yawp/+wgGSbawE9k7G5iBbKS/h8GP1kJ8C7AzeEBwP4n3dfOaTS5CODrmNc
 IjzsRp1pHCQxlOlDftsLslf1KUfX4mADOZDRgM2DU0K5xCcFzDWboiYxv0WgUXvwLN2LI1aO3AR
 5tqB5V9llawVcR4WhTcZHacTmsJngXl7SMh1dh5gQIu8Qnah1RI7Qca5TSgMRn6glnJKQtwrygh
 wnoLUdijQyB
X-Received: by 2002:a17:902:f612:b0:2d2:a982:a388 with SMTP id
 d9443c01a7336-2d2b2eb169fmr124489795ad.15.1786252418944; 
 Sat, 08 Aug 2026 22:13:38 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:38 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 5/6] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sun,  9 Aug 2026 05:11:59 +0000
Message-ID: <20260809051200.3276-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 79326389d75c..4305092f134b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

