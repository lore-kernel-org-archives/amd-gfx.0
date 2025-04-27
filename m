Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED2EC369D3
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 10:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E339210E176;
	Sun, 27 Apr 2025 10:13:10 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912C410E059
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 00:53:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso24667145e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Apr 2025 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745715224; x=1746320024; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg/AfG6d3JczyImNyyVER3OHCaw2iBjHC4i8p26sPM8=;
 b=A0AqErKUf7mcdfzdXuO1Ivnslx1SD2fJaJmUpwUKOjtyO9YzSpdmKQ8TLKp6iEUeFw
 /h9xWkeFzMQQU5YALz5Rubsf6pBlnoVqSd0Q05i5xf0RDux7TMZcsc4EbGk4MtXyTyct
 GPaJfJU6ezCxDR93a3rfih74c+x5UO19YLHrRJIXS9Rt2g3ynzcI1W0Be0vEjrpRA9PK
 9dj1zY/dgIvQpw2D+GgJrj8h+oXhL8i97nXhZAIkihH0u4PM+IlAm2d6TSK/6ZilDo4n
 +Uk3xsA9O0IaCsnon5HwfBzvZc031eBcBuWsu/oBAhTNbwovS+c3ZcIOxhprvTBO2vlM
 V/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745715224; x=1746320024;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yg/AfG6d3JczyImNyyVER3OHCaw2iBjHC4i8p26sPM8=;
 b=nh+986khJELPgjikCYdwVOOVTqc+vPkBNvYOUC635720MQZwZCqTq7MxMTHZ8dIkhs
 BRGVtIyAOVhwIu/9iH1+kUEaplqtwTzU9teE0RnmkWESKG3jyuYbaia/nNqMkESv+3/C
 0In7roTScyN3mYUOUO72nU82IN7JBPBbWbBN3dxQnayap1jiWH/t5nfRhz+gfUgDI1fl
 GYYn7/Nvs4Y8O5PJA1RvEkeNHPI3mLqI6iVCGi5SRa70/u74QocWlNecg3c68357BsF7
 fxs3shNncIv7oSpaGCT64yHlTXdXC2SMPhPnkKuTgxyqx4heBA9gvaXGXEJavIZZBz9l
 pxjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaL8gn+/phCahr2k/k7GpD+wAdfM1HptVqj8jPjuVUUG4tJHZ+tAZcoQbi0yS8ul6vEHv9wMPz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh3j2deOaeimSySaCnXjeNOytv/W6iJab5kSIzfo2jvnuB+9Qv
 DHROeo8YMjvExidL/OWNeAzF0dMgTXV8V0zOInAVHlBJA+Hx5XYAfbYKAgHqwbw=
X-Gm-Gg: ASbGncu0a3Vg97seUVqr+1vQJJnBNlaSWgz/rhlYt6lAyYxMt0CZeEnH1ZY+7bA4gV6
 lRiiRTzJNhL/yGC8UZv/Ffa/VP+4hv2Wmh4TcfV53Av1yYDo8YnI12krpJIgB5+5T+i4Bb3CZpb
 aV3Gx61SkWFw5oX8Fb1MVMzhnrjCd/z2vrVFoT4jwgYXuEmfS3UpmJjaDu66mlZwe573JKEiy8V
 NlQSqYAbvddiYGEwnHmw/2QYNL+2GGgyAGwsBI0DSMB1gtHmKHExvoOtQ9NSSu90jW6F3iDiGB8
 Xz+T4mgbYOsZNDkIqDIk4iR6MlQXuo3LdF9BloaS
X-Google-Smtp-Source: AGHT+IEnEOE8s/jn5h9e7kU3bltg5EX2JIC76F0AxQxbtSMX6UvKDOXzNuCNjLToXmDOse7ngGKscw==
X-Received: by 2002:a05:600c:1d20:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-440ab7b279fmr32316045e9.14.1745715223597; 
 Sat, 26 Apr 2025 17:53:43 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5369cdasm78929175e9.31.2025.04.26.17.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Apr 2025 17:53:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Apr 2025 01:53:40 +0100
Message-Id: <D9H0ED4B6PSP.1WYKOXWOZJ90U@linaro.org>
Subject: Re: [PATCH] drm/amdgpu: only remap HDP registers on X86_64
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Alex Deucher" <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.20.0
References: <20250424175819.3181101-1-alexander.deucher@amd.com>
In-Reply-To: <20250424175819.3181101-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 10:13:10 +0000
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

On Thu Apr 24, 2025 at 6:58 PM BST, Alex Deucher wrote:
> We remap the HDP registers to an open part of the MMIO
> aperture.  This doesn't seem to work properly on non-X86 systems,
> so only remap on X86_64.
>
> Fixes: c9b8dcabb52a ("drm/amdgpu/hdp4.0: do a posting read when flushing =
HDP")
> Fixes: cf424020e040 ("drm/amdgpu/hdp5.0: do a posting read when flushing =
HDP")
> Fixes: f756dbac1ce1 ("drm/amdgpu/hdp5.2: do a posting read when flushing =
HDP")
> Fixes: abe1cbaec6cf ("drm/amdgpu/hdp6.0: do a posting read when flushing =
HDP")
> Fixes: 689275140cb8 ("drm/amdgpu/hdp7.0: do a posting read when flushing =
HDP")
> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.ht=
ml
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Tested-by: Alexey Klimov <alexey.klimov@linaro.org>

Maybe also makes sense to c/c stable since the posting read patches
are taken by distro kernels already.

Thank you for fixing this.

Best regards,
Alexey
