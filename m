Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E817C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 13:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D0810E205;
	Mon,  5 Aug 2024 13:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="Cns48WTc";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A546B10E1FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 13:11:45 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7a1d436c95fso630743085a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Aug 2024 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1722863504; x=1723468304;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
 b=Cns48WTceIRcZ9dmvGs155YEvrbRR3IjNr1gBQMB776ihh1UnG319OwsQKHyw1PwQ6
 SZZryWqcuSX+Ws1rbAAmAG0wAh17CYk387b+zbMY5Rngt4EstBGQLj8gtWcEDG8uoa+/
 JnrWzJRwVlCIyjlsPX51WB/GIb+Jw3Zd5/vL42Og9tZsjQv2V/T3xCZKHmywvbOObpB4
 rFcLlPUanpqbEo4jxyjkZCJAUb3BSMyOnctTKfEQ14SJEPsIqJetyLqGGgQJGdz/5UH5
 Lv3FWAK2dEE/xWqm012V1rxI6D7M32yOu0X7+Ei3kgYbB6QjLT1dm7j+zkmI1oeys5WA
 CHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722863504; x=1723468304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
 b=nKwhLZ3qfH2ar6lMAEL7n+ClfUEXYy+k/ccEg04koPMgb1xHG9SUOlw/mrNyYe1j8j
 k7MpPle0tRwhTNKKLaiQ7FX2QrNNiXQKZ+Vk1YJt9OW+ECoBkbkld5L2pYLS1Ju9D8gV
 p5DZCUkNMWaB9BUD2xLy+p2hiLKm/aroDvO2M1t8Gz2QVB21Xe5U0tMZ52zv5lUFKg7O
 QYw8qbF7df8ujTXuJaKFMtlKh6VARgRIoXyU9lBJ3D8TENVf5zjkPtsKRVq/2SDTkkfb
 VAS0PRDa7FbMYGG8Ufcef0pnPQUB2eZHMHUvIrNSKGVqnA0WcoKO5riWgaQ/KmSRghmu
 9+Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjFWXX5B9QqyW/ZWj2s7+sZYplanNKQ9j+yq9rZ3uV+dsSJdKUGt76MbaRwUX1C4d2n3dpWomZNxrXb3StERCoY5eiJqciT7B1ENq9jg==
X-Gm-Message-State: AOJu0Yzfaz/fcsRXRdIt54kUZfW3ZvQ1mzS5+XMRbMLGP5Ju5pOto2cC
 Mfl9UTHkimZcuQIRaORlzI1ZcDguwWgdVMoHEJR2Ez3BtRaDsGapkXd/m71B/on6Kn/phuCDYxT
 LYqsPss1dxPFJA67N7rU3WxaMUJ+/tYH2kVaPhw==
X-Google-Smtp-Source: AGHT+IF/O5ePVsP9F9/4LdJgMcHnbAiRBVz6rWucn4L0+VzzRP1U+YIN/SKoA9Ocbj/mAccdLjT4/BuXBtCo084/sM8=
X-Received: by 2002:a05:620a:24c6:b0:7a2:e6c:41e7 with SMTP id
 af79cd13be357-7a34eeb959dmr1463955085a.9.1722863504285; Mon, 05 Aug 2024
 06:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240730021545.912271-1-vignesh.raman@collabora.com>
In-Reply-To: <20240730021545.912271-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 5 Aug 2024 14:11:32 +0100
Message-ID: <CAPj87rOYVCG2A10ruyYan9y6NmMY0fUM6Z5-9ht7dEp_THYmNw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] drm/ci: Add support for GPU and display testing
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
 dmitry.baryshkov@linaro.org, mcanal@igalia.com, melissa.srw@gmail.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Vignesh,

On Tue, 30 Jul 2024 at 03:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson G12B (A311D) SOC, the
> GPU driver is panfrost, and the display driver is meson.
>
> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run tests
> for both GPU and display drivers for MediaTek mt8173/mt8183, Rockchip
> rk3288/rk3399, and Amlogic Meson G12B (A311D) platforms.
>
> Update the expectations file, and skip driver-specific tests and
> tools_test on non-intel platforms.

Thanks, series looks sensible and is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
