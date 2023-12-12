Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CDDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 08:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C9B10E721;
	Wed, 13 Dec 2023 08:38:59 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8C410E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 23:31:37 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77f35b70944so381115285a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702423896; x=1703028696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:user-agent:date:message-id
 :subject:from:cc:to:from:to:cc:subject:date:message-id:reply-to;
 bh=bUkrAqsNZDipecIKdgep5YJgfJkpnoeFR9tV2P0/CVI=;
 b=ChbZC9w9xEJp8hJGM/sldHp5VnwNB9VzyjcdaaoENl7P2rO3XYp8Q5HE2RYyyguz2Z
 flX/knOGHM1Oiyj7PyMt3jS0CM49ksV96g+T53yZZKEkZJS2TLxr58FIidNgNLEB7h1m
 aSAM604TCyBs8VdMpEL/L8e2PoAIpjZ5ZPhqf/AQnC8sttQYWJ+JfKtlSYFr4KXugTQW
 XuYC9ukCKRNLOkRinD8/tcTToMd+72PfdQWh2qUNDY7gFIAw4jvG2JEq3YE5IeZCNBFL
 kZ0NjCXexaDCUu1fR1FMKY0LyaN1B82VfZZFzdbLE+U6bDDLA3C3wxtCV5vuxqz0c3a3
 s4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702423896; x=1703028696;
 h=content-transfer-encoding:mime-version:user-agent:date:message-id
 :subject:from:cc:to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUkrAqsNZDipecIKdgep5YJgfJkpnoeFR9tV2P0/CVI=;
 b=HGNEMyETZ375sqJEXR13i8+AN+AJ0L/hUmev+DA8YOaehNn8P2FrlINagDAzj/eJhk
 l4tQJroN9g12QtHIF97hLQExp1pEJ+an9EhhioRi8CT3T1oFpSesNcvBv1F+X6b7VbX/
 tjkUw11D10n4vv3qbN8MkaB7FbiJdYirz9WQkFdDRIRQLvrAL0HhHNKk2PsBZIEeweUv
 Rj0dAh7rsdfnqymyOHKB6D1VV5MjgRT6lorxwAITmDsYlt2lm5xgJz2rKi7xZFkk++ZN
 ze9N69lXnyAROQopJ7WFVxJp/Wg1EdOBLkIyg5TZeA977Vddx+xMRQ8Zkcyy+mK343BJ
 RF2Q==
X-Gm-Message-State: AOJu0YyH9drs+/CN4fMZRpOZuWRREvSP2z+wkPV29qK4AeWFI6DXnQox
 6iNGjbNEDBZdhOYnOvVSjvzW8xxSbw==
X-Google-Smtp-Source: AGHT+IFnEBMb/1kNAabQhPqpIwzqhQ/yL/C2XGBrclcybcx7/0ZRWNO4HWvaIzYuvA4HpOmRNtE/pw==
X-Received: by 2002:a05:620a:26a0:b0:77f:5d7:6a66 with SMTP id
 c32-20020a05620a26a000b0077f05d76a66mr8537756qkp.23.1702423896604; 
 Tue, 12 Dec 2023 15:31:36 -0800 (PST)
Received: from [120.7.1.23] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
 by smtp.gmail.com with ESMTPSA id
 bm27-20020a05620a199b00b0077d62e78db9sm4063251qkb.128.2023.12.12.15.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 15:31:36 -0800 (PST)
To: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
From: Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH v2] drm/radeon: Prevent multiple debug error lines on suspend
Message-ID: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com>
Date: Tue, 12 Dec 2023 18:31:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Dec 2023 08:38:54 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "<christian.koenig@amd.com>" <christian.koenig@amd.com>,
 Woody Suwalski <terraluna977@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix to avoid multiple debug error lines printed on every suspend by 
Radeon driver's debugfs.

radeon_debugfs_init() calls debugfs_create_file() for every ring.

This results in printing multiple error lines to the screen and dmesg 
similar to this:

[   92.378726] debugfs: File 'radeon_ring_gfx' in directory 
'0000:00:01.0' already present!
[   92.378732] debugfs: File 'radeon_ring_cp1' in directory 
'0000:00:01.0' already present!
[   92.378734] debugfs: File 'radeon_ring_cp2' in directory 
'0000:00:01.0' already present!
[   92.378737] debugfs: File 'radeon_ring_dma1' in directory 
'0000:00:01.0' already present!
[   92.378739] debugfs: File 'radeon_ring_dma2' in directory 
'0000:00:01.0' already present!
[   92.380775] debugfs: File 'radeon_ring_uvd' in directory 
'0000:00:01.0' already present!
[   92.406620] debugfs: File 'radeon_ring_vce1' in directory 
'0000:00:01.0' already present!
[   92.406624] debugfs: File 'radeon_ring_vce2' in directory 
'0000:00:01.0' already present!


Patch v1: The fix was to run lookup() for the file before trying to 
(re)create that debug file.
Patch v2: Call the radeon_debugfs_init() only once when radeon ring is 
initialized (as suggested  by Christian K. - thanks)

Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
b/drivers/gpu/drm/radeon/radeon_ring.c
index e6534fa9f1fb..38048593bb4a 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -413,6 +413,7 @@ int radeon_ring_init(struct radeon_device *rdev, 
struct radeon_ring *ring, unsig
              dev_err(rdev->dev, "(%d) ring map failed\n", r);
              return r;
          }
+        radeon_debugfs_ring_init(rdev, ring);
      }
      ring->ptr_mask = (ring->ring_size / 4) - 1;
      ring->ring_free_dw = ring->ring_size / 4;
@@ -421,7 +422,6 @@ int radeon_ring_init(struct radeon_device *rdev, 
struct radeon_ring *ring, unsig
          ring->next_rptr_gpu_addr = rdev->wb.gpu_addr + index;
          ring->next_rptr_cpu_addr = &rdev->wb.wb[index/4];
      }
-    radeon_debugfs_ring_init(rdev, ring);
      radeon_ring_lockup_update(rdev, ring);
      return 0;
  }

