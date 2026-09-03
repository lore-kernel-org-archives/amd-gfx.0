Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AE8C624D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6D510F5A1;
	Thu,  3 Sep 2026 13:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mV1kV7Um";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFDC10E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 08:02:49 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-39647184c73so695546a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788422568; x=1789027368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3NJLiu+EaUZYTx9JK9o8V3S8dlOMXCZdqBmUNi5lURg=;
 b=mV1kV7UmYZtjAm0wVIedmwu2sc3o+26keT2kOjb5XMPbgFII/yWduGnE+qspkJ9SOB
 QI5rQjt4U0gHQS6IQyZqtFEmUBn3nXUWNoCVT3uM92d5oAXxdSnsb1wX96W05wl6MSfy
 12Sxvpfka4d8siL3zfWPpP/eeEOycaya4paIbTcwBkFM/cTUepS2dCdiBv90vQ+HBinT
 pvErjEH+WWpfs4R+V/MfdM04Yc7tiB3L3ft3qy44wGn8UD/7WKIzH1X4YjndOrY7QLZm
 Ay6fGV/eT+B7jR/foI/58i0LHPsezH/gQwVh/pB0Y3D3/ec8m0JVNMXs6Xecg1QTJfGo
 SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788422568; x=1789027368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3NJLiu+EaUZYTx9JK9o8V3S8dlOMXCZdqBmUNi5lURg=;
 b=H1hEkEH3EanR5EgNtod0BHv4UjO3jYsD6kyhtkqAKQh1BpmuRmTo7YNK0iPhwDNjha
 5tw26BFolIv4wAHKRp4xaPnce9AkLjv6z1n7DZ/pwHyY/lyQzr9RTPoNDJ6FhEwO4Mkf
 EZZuSiqlp7lL+EVW2SeA8sRm/vb3ndbEIhDr0/344C3AJT2l0CoWDO1e57YczuLgAusJ
 O8RS1PhRA+V6586X4c2BvZleFC2wdiXwoO8QjPc7qkCg4PI4vCoOaKiQGh17BgpbuJ7z
 eeBuPIAgMto/HnIkzI01qJAnA2hbfUS8R7qmgM3kuh0WVxqObsbLdJDqc9u8xtMhFTeQ
 6sgw==
X-Gm-Message-State: AFuF++lC9IqdGMxtvd5d4FWdiPrhCxFZQWsMmanm8FWOBcWjsgZyp92E
 9I2WSRu8WQhr6gkhN77cbplr4s9TAhPJh+lWcjpZIvXHicG4lBEMPy3TjIuAQxLYKyU=
X-Gm-Gg: AYBFou32CqSz1huSVA0WXs9g4vo+P+7qkBGeYLUTqU07VN8o5XdYBxYcAm/4h3G1FG6
 Cj8jdF/D6mfL447cboLovDR99wFUZpSxXpEaz8jFCV2PvEmESmNgEYuGu+WIN4LSD5JBBadiNHz
 FbfZY1oalj0esRkEcezGP1urhgaBuPJWC8OiSWyKsqs7dYkdU0hR59PBQHKZtTlD5sT8X9S/VXw
 g7BlT+9y7tipuaojGJwjbEblUVkp92M9T2fJujSNW/0QCDMh99IdQyhX7OUEYv4ejZVkh8168IC
 JADYv+/Tbaq9C3/7IvteLXHCP9ekcbxhyw9ovTGtZmU4gQLoWbPuoXzfX2n6CWdV4S1RwtZbacB
 NB4MX8hndTpFtLsggeacitbZVE6rx7xWZDY8hSRrmEBaYeUGbk46XF6k2s8vTl+WeKxJeOgv5Qu
 sOfQomaqWfbhr8EPQrzXO5d7Gy6JasvOdEgiNOt8LWf0RywhIW7Vfls/FTljTvDsKQjbmKnt7hQ
 uh9bE/U9AZguK73S3bB1vLg5x0oGyWve8IBYBm1ZvpCBBvWsL77TxfE8TDsrH6pPRlhjQ==
X-Received: by 2002:a17:90b:4c0f:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-39b1325b61fmr1613732a91.9.1788422568460; 
 Thu, 03 Sep 2026 01:02:48 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm3742832a91.9.2026.09.03.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 01:02:47 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Thu,  3 Sep 2026 16:02:37 +0800
Message-ID: <20260903080237.5724-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 13:03:07 +0000
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

This is now runtime tested, so the "compile tested only" note under the
--- in the original posting is out of date.

I rebuilt my distro kernel (CachyOS 7.2.2, same source and config, clang
ThinLTO, generic x86_64) with this patch applied.  Hardware is Navi 23
(RX 6600, DCN 3.0.2) driving an ASUS XG279CNS over DisplayPort at
1920x1080, VRR range 48-360.

Unpatched:

  - the WARN fired once per boot, at the compositor's first modeset
  - after resetting /sys/kernel/debug/clear_warn_once it reproduced on
    demand at 280 Hz and 360 Hz, and never at or below 240 Hz, which
    matches the ~243 Hz threshold in the commit message

Patched:

  - no WARN at boot
  - no WARN at 280 Hz or 360 Hz, with clear_warn_once reset before each
    mode, so those are independent negatives rather than one suppressed
    warning
  - the function no longer bails out of the hysteresis calculation at
    those refresh rates

No display problems observed on the patched kernel.

Thanks,
Francis
