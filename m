Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13979C55171
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D6E10F18A;
	Fri, 31 Jul 2026 06:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+UnfM7G";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F9110EFBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 15:36:16 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c1c24ec9525so389937566b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785425775; x=1786030575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3SOhHIxVhGF41c8QPWamnwAmuGY/uvO36Ylk3s7hbw=;
 b=H+UnfM7Gmd7uTPLIVQZF73t+9qbUl900+tb1fc7r1dbIqgCicslyXuBg37X20ZWm5a
 DnClRz90lZbeCDBSQf5H+VTuWFdKHPNBUrspxwGaexyv7whfrGW8EQUJNlFst7T2J9+D
 4nbnkFO8auyJ7ZqKrJQ8cybKtsQHGfKFa2ecFbY3+lxCeayHOTB41/2wopYoVKaCV8na
 42zoDoIKwio5J0VsPeg7kpIP9tISpLa4wG+t8qhZN+SOk2DaCMmtq9+pF2sW6RpvfHUs
 xyGWxmx1K8q2wfnD0k3xWG74/d/8NDM09bJ9eMeImfBcofvzzqsLoV8LEZfeJFYEJ3Cs
 k1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785425775; x=1786030575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3SOhHIxVhGF41c8QPWamnwAmuGY/uvO36Ylk3s7hbw=;
 b=B3N0+3dzPEoO/nvrn8buMzuWCTsycPydZeDwz6yHEXVV180/b6w1laH/q1hTTlCMhG
 heqXYKXf9DH8ZEeKPXeo3m39wmk0kBc1moW3jVgpbTsF6FaWjf7jW9rNDg436rsGbiLX
 j4yg3YNNf2f6s/5lVJkJ22bRZJeWK8VKqQlE7yzVZzshpRfqQYZUqRDT0ncFowHCGNEB
 Bo2VQZoqOzx/9Y9JxaBpEjPG+n7GIQ8GFL6sYhSaU8KilTe/1P/lac52wYuaqOeG3e+7
 VHbbnWXAqxQmoyFcIWEgpUKgVoudTs3reIk/wYFJ75L6rmXkD4O4mploEFDeBDFPlJDG
 YKBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSeBxUd01ctBBdB0oZ62faTh9mJjlOaOg3/f2L7c9USmXsrxpjMB2GZ/sLTTW0ufFVg2duxQh6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytbECzo7UGhQsn4AExKdk5gFm/TF3c2DbAIQi9+kfcur1iwI1N
 25ImkbA0e3uIlxzgdkSHzq5ebx2DXTvkQyfU5GzWnw36IC/IwvtuWiMm
X-Gm-Gg: AR+sD13IzZSIS83G9guv3emUfdyJjVJNYwk7lVZD3h0V1KjE+iq/XF60Hs8wzahMjRW
 kW/a179SSePz7ymrYX4/NrT03UEgrA62hln/M3iRx+Ifgp1CBSRyDPbvvz2Ax3w4Mdu4mT32GXm
 wBdWgpTdgHd7V/NGa5Exn3Nih4aha9pXuCeao85C1cLmq5n2G/o8ootkN+qLymH0t20FEjBTkHb
 PJ0hfPmo/Ngo7XnjQBhXf9k2OqZoM/5eUL0AWnHVSnQ6W2J/YCi8uMGsXKeFNWZ/8uSySLR1DXO
 DYaK3xZg5dV8+urD5Qie7JY1wp0abGmdqLoTYVNYvW6cKfUM39BqjoxBZ338r7CV32hxo3RHCcF
 3y6lp774JWIWwSpSn2ZUFSI2vvr8zxKH5pHwlhV7oZTdGvOW5UYwHhHfYIUETa9e8lWvdpt6uzR
 /1siRtkFqig3IjhJscYz+qUISLeytQGbISdF7NuiyXVysV+yj+Lw1a+JNB+cN1yMPmemiZrXXiD
 IV/tHkdnTQgrba/eCmNZ4SF0W3Tds80BOh4mWIL3Dtj62Dfq7x5
X-Received: by 2002:a17:907:d10:b0:c12:959a:1477 with SMTP id
 a640c23a62f3a-c1fa57076cemr160900866b.40.1785425759630; 
 Thu, 30 Jul 2026 08:35:59 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-ee66-8497-94b5-6e78.fixed6.kpn.net.
 [2a02:a463:a071:0:ee66:8497:94b5:6e78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8b762dasm84986366b.38.2026.07.30.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:35:59 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrapping
 va_addr/mmap_offset
Date: Thu, 30 Jul 2026 17:35:55 +0200
Message-ID: <20260730153555.15176-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:58:24 +0000
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

kfd_ioctl_alloc_memory_of_gpu() computes the SVM overlap-check range as
[va_addr, va_addr + size - 1] (and likewise for mmap_offset) and passes
it to interval_tree_iter_first() with no check that the addition can
overflow u64. With va_addr near U64_MAX, the end wraps below start,
interval_tree_iter_first() sees an inverted range and returns NULL, and
the overlap check is silently skipped. /dev/kfd is unprivileged, and
va_addr/size/mmap_offset are plain fields in the ioctl argument struct
supplied directly by the calling process, so this is reachable by any
local user with a single crafted ioctl call.

Reject the ioctl when either va_addr+size or mmap_offset+size overflows,
using check_add_overflow().

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..12954d65503c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1089,10 +1089,15 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	long err;
 	uint64_t offset = args->mmap_offset;
 	uint32_t flags = args->flags;
+	u64 end;
 
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (check_add_overflow(args->va_addr, args->size, &end) ||
+	    check_add_overflow(args->mmap_offset, args->size, &end))
+		return -EINVAL;
+
 	if (p->context_id != KFD_CONTEXT_ID_PRIMARY && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
 		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
 
-- 
2.43.0

