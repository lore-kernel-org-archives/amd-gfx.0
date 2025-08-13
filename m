Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9357CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEBF10E4A1;
	Wed, 13 Aug 2025 00:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USXTd6Q+";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B3F10E4A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:02:03 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-4fd6c638f20so2840718137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755043321; x=1755648121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQL0dZ3en7BGhZ4m3CV0877SKjxeiEy7lIniUqv3CRU=;
 b=USXTd6Q+5s4mG5lRG+jeZQS6rlaqJMVUFyORx43NLVJqRz1Si0jyOEVpjWkOnp/VUI
 t0l37Y0fWaZnjDvyOM3OaaY9ne/ZCKhFCH6lFMAf98wsakUnVMvQZW8fENJfurnZEVZl
 tBt5lzQ0NenYOIMPP0IzcYzlMNt2e4DKLS/XUFeM6EPhgjqXTx85HelJb4ami0ovjEZD
 8CZ66lkzo7O7qA3ckT7V58jsVQZDUjClyomQGxkQbjemRCM5rrceECJg8+9P2bOLxDqJ
 Hc54IY4QaI3b0Wbjg2vJXMjoX8F0Mdb/M+wpY7N0znb2Uj5R68kpElDPFLHcnM8XCNAC
 /CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755043321; x=1755648121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQL0dZ3en7BGhZ4m3CV0877SKjxeiEy7lIniUqv3CRU=;
 b=iN9vlTml0hzvWS7719QR8Vp6qT+5RjH9OOFM0Nd18kkIG8dGaub8Ivv1QwwDCiwc+W
 czBXkZQ3j+X1Y2rLHzFGHqyxGP69mP9O+zBdWX6eEfK6K0CdSBzgcGap0r8arJ3LjADI
 FzZV0LfwFL2hdzYsuwImh3p5Ja1Zt4zUVM5eVVzz23E39rZp7tlj+d5+H5n5MGvoGU5O
 8FlZ/MhEy7VUEiO6smUvx4jN/f7U7Mx7m9yvB3TQSl6KGKEjhLIXsXAT15OvBfR0UiY2
 s76rTQTL9VhKU+H/OvdJOnlwILoxz2PNjICuLe6i7ZVxVUIz9MEhmVJDsY0HipGUzcRP
 aoUw==
X-Gm-Message-State: AOJu0YxWh21wXREt99t2xIQ9xQL/hRSHN6p152ioTzYE1s5LFKM2+RAs
 OQivAssB7LFP5gMtfVXtjoctGXz0bwh5AfrzJ8QCu/31se8jz7GT+XiEKe0JkrNy
X-Gm-Gg: ASbGnctwfQXIfdQsUdLfnUm+k3eV5bC9yeGqCMI/iyvjn5y8xvJVD8pxE7qwy4XBFud
 x6mejk/Ew7+G6uMzETSbRFp1SNRt884HTbZeuYLR7YOyaxxOVfK1frxGaG0qaF3SxxgdrnPaeHo
 xAmwXBH1zfhISvoZoYAyP1Ywv7MN4fCR2kvFldcBF47lZmvuOmSx7GQwm8dp/pS6HtQhMNBSBD9
 37L7joaxWIbaX4PE0oMiXz4zjkxM71OdGs/NOm2LJHdlE/qNN+9LQMkqTnhv5vU3E3CgdeIhieF
 +bHbYwbvnq6tw9v3n5uwlTvcXf4u6dbXzemZ4VQehZ2Oes7JOBEbzs3WKELRYeD0b3608s9byMx
 t3tG/VLRxS06tMiJPqlltt+2Paoc=
X-Google-Smtp-Source: AGHT+IG54FqVoA02iR5K1SgYTUfbzjQNI3pPA78SNWWrd06pwQCnMWV5YyNf6hSdni5ZTwTWkRV8DQ==
X-Received: by 2002:a05:6102:508e:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-50e4e5d6d9emr433120137.3.1755043321538; 
 Tue, 12 Aug 2025 17:02:01 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce3a099sm185937416d6.81.2025.08.12.17.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:02:00 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 1/4] drm/radeon: add name member to radeon_ring structure
Date: Tue, 12 Aug 2025 20:01:38 -0400
Message-ID: <20250813000141.105508-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

This will allow us to name rings and use it in place of idx in logs,
as it is done under amdgpu.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index fd8a4513025f..16298557079b 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -810,6 +810,7 @@ struct radeon_ring {
 	bool			ready;
 	u32			nop;
 	u32			idx;
+	char			name[16];
 	u64			last_semaphore_signal_addr;
 	u64			last_semaphore_wait_addr;
 	/* for CIK queues */
-- 
2.50.1

