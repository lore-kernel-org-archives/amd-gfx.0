Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E45C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 07:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517C310EAFB;
	Thu, 17 Sep 2026 07:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LbuJhhcM";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D664310E2E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 04:44:33 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469f204f6so247621b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 21:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789620273; cv=none;
 d=google.com; s=arc-20260327;
 b=HslE6HrTqoyBZrskqGe25HaEGgs/azFsUXRi6nIjE9DaC28fXeFsh5dphgqASbN+ut
 0QTI6KzUyIFM07S90Xrtlj30M9+RCzXtglGWiHyJ2M3iXuOcTaw++XMzfadmjle1llUM
 CV5FKt8k8EqpI6DIdqEFCXtTC48Bqz2HeplA6kO7zs/A+2JZGTVL4OUum2ay5C0RvH0g
 QMiy663u2q5VTHiVO+24jwX7kWTSn+qI0sTuh7whNBOHkxDMnJLjSy5x9t/UgcJqY43o
 ySExGoNuETNLLwRecErk+GFvRNWMscZjxGAA60IuI8y9OGGhJKqIG2PHDtnxLbSCTNT0
 lE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6i3JoZy6C1V7fXOfv3bvsIlHU6zj+GVM9e0GX0h0LOU=;
 fh=QIxx9forRpXuDFewm7+XdbhEwQt9gpUhxgLOyjALaHw=;
 b=Q/+lEQss4tChZvyqW6KwT7uVTZEyUsG6ENUtKjHsQXSKOAfEq5B5AqMO2BVBwIRxee
 NZ5p2D2jvu7MuDPGZQcKtgOXyHHZFBYwftqvWP/ApMe9d1TTf0NZwl2w7+jaPK4lbnxT
 Ot4uSQb/nmrKVm/ZC1pnHDCtTEo7zp3L1HBbLE2Bz/ifn+JUa0pjC3Lm/0gqPdX6MCGv
 gV9BDTUCLPxzyMTfyv45x4AJS8spGWv6Z5BCH9/kfYr8c1VTIHYFi21KR6CAiF/2leu7
 2Per2VA+YgjxhlXLy+XiNLoG2hXm3ElryLn6vyHidVMa8/zjnI0g5+izB/P0TLo7K5Rw
 0hXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789620273; x=1790225073; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6i3JoZy6C1V7fXOfv3bvsIlHU6zj+GVM9e0GX0h0LOU=;
 b=LbuJhhcMRKPxNVPRWRlcn41WxKc7lnjsjge4Z+Xd9xfbqQBhCYIl5l21fDy2twGXxI
 GWq1l91J5X4SB7bK58tOQOaCjEPkETKpXR21yo1c3TEv2+9x32O7AaKPDME/8iYG60KV
 WDoP3d1kaB2Ce6+kf2verZaV4BTrLQ+VaEc0D7E9mvARiab+HDd+zYxTbMLlqJ6GhIcQ
 NQ52MFvq9403p/BECiiN4TPTFjdObIZWkbL7bVxGq18Gr+MoIeuyNpKWWizrD0n5VhYA
 Tc1TxrdAICl5xOFfRXvYDRQX7AYVirqm+vU8T1sNLKEx39tbsLko/EAmk1Rum7+wu4xC
 yH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789620273; x=1790225073;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6i3JoZy6C1V7fXOfv3bvsIlHU6zj+GVM9e0GX0h0LOU=;
 b=ym/c8JvA2aqr09+nthhiJGRHke9JcoUEl9Zo2hPEoUSzAnUCWZ8vDH3WwUHneGStlK
 EyMeI/xk9OvsIaKxOKbv8GLWxyuzkde54fgWSR2wYlIJMMKY4l1ygl+gesH/MGduAXN2
 mP7rQRU42AHYcuaguz7mEh1BVME1ZYAoaEtw62pqkOihULoFL1WWIaHJNiUyMItHQlzv
 rxaNs9676K1RWv9RP5S2GMpPDU2xztfGZJ1z6xQYvxrp/4RBlssbuOKB8M8gTcW+58B1
 6mUQ2P6voEP33vtSX/3a75lYfQ9VBteuS33VhGJl+jUgLK6aNlEUgG/Mg4lVGVHEKDWs
 5WAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/rTcFjZhBZsan21LvFApgWuYklH4Y+O7JpRjpCY07v5+a4y9E+26TsKA8l+hBuCDWjeBgAQsM@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpHdXlSEkXf1yoJXdzAglBeTNV63KTnIUtZ2M3z6NoVFlIhL4s
 2SxvDdH9LqEarl60Sv5wdpz90ETHsnhdRhInzJcL2dNkC/kUkOTUJ5GuKwIQQdm8jMfCjEe3oUo
 V2Z2YvMwNkhmrLqg5Y1dr6FB9GN95FHXxutr9
X-Gm-Gg: AYBFou1+PKoGup2ENggX8J9bjp879kwFQGeQUWvbT6jlmxwy6oqq/FDa7bOPMM1vPSM
 6CZcCQPIs3GIvYn0CwJsIbSkSW6m+N/wKXzFT3CqJn77Dk+fvcctmgVVh98XqpUbjKjlqEGuBrK
 PY0dxSkggLLIZ4z1hpfiBLCBKR1hwDscbW4yh0MVMqHGgiy8osMHLzU78q/q1ADU0QB2YRjkJMT
 U1gcynIbZk63b0PUEXy3vjkm4hZhQkSXbQb7NOUShzyrwrbtRRUgO644epExGMAirMVeeFMdIup
 QquB5psxb3MgHHR+nUnXm4CxDcmU+WX94pIkTuT9zUemXxPudo+V+3Re
X-Received: by 2002:a05:6a00:9094:b0:85a:bc69:bfc4 with SMTP id
 d2e1a72fcca58-8723412fe92mr12964700b3a.0.1789620273335; Wed, 16 Sep 2026
 21:44:33 -0700 (PDT)
MIME-Version: 1.0
From: Jacques Serfontein <jacques.serfontein@gmail.com>
Date: Thu, 17 Sep 2026 06:44:21 +0200
X-Gm-Features: AcwNN1WWhl0RHjb5F6CxLVUUMLymgDbzXzm9TtsyM1X-5aejmFqeZfIrNGpsx7Q
Message-ID: <CADGM-+Xgh23YEf4Un1oz+hKKv-_E_Va9-8Q23UyxfRA4ridfxA@mail.gmail.com>
Subject: Re: [RDNA4] RX 9060 XT - Pageflip timed out causes complete desktop
 lockup under KDE Wayland
To: Jacques Serfontein <jacques.serfontein@gmail.com>
Cc: alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org, 
 gabriel.aquino86@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:07:03 +0000
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

Setting power_dpm_force_performance_level=high has given 11 days
without incident, versus multiple hangs per week at auto; no other
changes.
