Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFFDC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE46410E497;
	Tue, 18 Mar 2025 14:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="waO+Blfa";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D506710E497
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:24:38 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5497590ffbbso6322649e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742307877; x=1742912677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZSOxfNpsuHJ2r8f2irDmxZoea8ixqgNXdHmJ1iC78E=;
 b=waO+BlfaRRcsT1fT4ubzn6wpLl2fxj6cpvvRmkLdJAUYSaJngGs/Uc+dXczNY7H4al
 mMXdjzl9JnUtU7ksySRW7EIN8nSVEQpgk1E6wtX0iRbZUWyaqXJIwg8XLf2MWiRmXao0
 8ehuS2hly02jI3Qlh7gXg0X9vuUX3AgmG6KJQj+HdCWh+dFDAh6ZXplLfpXasMU3RTqq
 kDBSVAMCd88jxUAdxL2Waqh/dxl2gd2WOfJHeyGIgcNjQdUp/7fq15WPwSK/XGneD1rR
 a78s7Ext0BWO8IySz1XdAKLHUrWP8ClMiiS6SXgkXJan92+7IReuXg5PE47J595oz2j6
 6tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742307877; x=1742912677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZSOxfNpsuHJ2r8f2irDmxZoea8ixqgNXdHmJ1iC78E=;
 b=rCUgbQNwP08XuWvKIVHZvfPtet4jP137fimk7EU+S4lxNUEoztgdvoILGPksqt8c9G
 W6MmhS4VcquoIKxwmoFsYSrQtHiRlJjAr0Gq4ZIlJxdQQL+YRy0JVX6JoFYPI7nVeTl4
 yvBOvSJp3E2C7ksj5Jt9rAwyzpACu+IgI+gS5348BWZGe6T47/TKPIrUGsE0KeuE7dn2
 ocJQLLkRhDSA+7TuAtoFdZE5OkP30/CzChB4JfXJ0wuZ3ywlZFBEFPGcgaxFrG9FsCNT
 kULhnUgikpCi3JQvjKDmPUwBXOJOWPh0OFOCqnP1e7iN6dhvhEl2f71uAu81Bwrv1lWd
 U5dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgelr0eQQ+Lhm1yOQrnjcPMZBvR8yO3m5unDykXlCH+dmNjQnLNQ/B7xCaXctuw1bv98T2+uPt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycL3BzCvoXVRv4j2BBai/O4pcVsppmvRbI44i6LpoFCbqh8HW5
 i3njmxeTuSohEaIwOdP8XCEmKX1zehZ10OjEe79Be2u+zbRIzXv1BMTfnRsO+NVS3q3sYWq3Gm4
 7ETndLSxcgkibLN4cFFcdfuOfkqa18AmY5431CA==
X-Gm-Gg: ASbGncv1olfi3V2k2pyOtweAQ8REHUmXN43h/Jasa2uqf22ss/gjeA32rrM3Tnf5kDu
 P9slNonQbvI5mGhPzreZJeioRyvur2eZnXHnWv7qnHQzlonwIY2xH4gpOnV3ky15bwMwAaK0X8z
 0z9pPk7Lb/BLu5qbWQ/EPCri+JRA==
X-Google-Smtp-Source: AGHT+IG9CQGaGXwj83/CaWY1G56V+6jdIV2m+4yH9D/kfodrFtIHnTXnxFGbiTsYYiGMbs+jAqjCMmoxKtCUTvuxFTY=
X-Received: by 2002:a05:6512:3ba4:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-549c396e65amr9771645e87.41.1742307877094; Tue, 18 Mar 2025
 07:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <3685561e8e3cd1d94bce220eeb6001d659da615c.1742306024.git.geert+renesas@glider.be>
In-Reply-To: <3685561e8e3cd1d94bce220eeb6001d659da615c.1742306024.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Mar 2025 15:24:25 +0100
X-Gm-Features: AQ5f1Jpc7dAEv3PciQ-6RFgHdOpEl7a3cOhURtVt1riqmVcpakV2QbZsA1JHrvw
Message-ID: <CACRpkdZXc1uEXspd0EYRE4zBJ-sJGV7H6hPh59ROsh8w_CSa+g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: PINCTRL_AMDISP should depend on DRM_AMD_ISP
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 18, 2025 at 2:58=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The AMD Image Signal Processor GPIO pin control functionality is only
> present on AMD platforms with ISP support, and its platform device is
> instantiated by the AMD ISP driver.  Hence add a dependency on
> DRM_AMD_ISP, to prevent asking the user about this driver when
> configuring a kernel that does not support the AMD ISP.
>
> Fixes: e97435ab09f3ad7b ("pinctrl: amd: isp411: Add amdisp GPIO pinctrl")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied as obviously correct.

Yours,
Linus Walleij
