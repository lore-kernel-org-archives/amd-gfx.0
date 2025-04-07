Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D6DC369A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC1B10E4D2;
	Mon,  7 Apr 2025 15:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5O0VL/t";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932A810E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:03:51 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-af50aa04e07so418524a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744038229; x=1744643029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33vq/DxPKJdUsd5PDYguTsqn5v76zDaKvATH+Ml4eMM=;
 b=X5O0VL/tZtPhI0dCwFE2NEUtgXTZ33Z/yEX3MIe/yWJFA/ABsA5HafwwfSn7qZ1n7W
 eZQKNBDsFjdgTsiFDxyk14IrLoPD3DHBfAFqIx+b4Vbd7Qr1U5HvWSL4X9e2zsmyqFlu
 jtA5bWa9cUEDlTgFGbmdSPLKiFN0dbll8U2c/bM1i/Nw6RJv2uIOymfFN3XM8LcFT7rN
 NJoDSckGEllx3Ros+5i44J5mPySIbOSqpCFDxBGRIXlNoCXwxcGvXSlwGh4XGMyuInXF
 0dAHA3T+NcugROiQdx20Wel2HGMjI4mElO2Nt2o2xGQr7ZtUMpSQk07hsVt2m79tJpZa
 01Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038229; x=1744643029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33vq/DxPKJdUsd5PDYguTsqn5v76zDaKvATH+Ml4eMM=;
 b=L91igYeXyMbhzpTjkR2d2yrK0biGcP7SD/yluKaEXkCk+hnG4TbQDnhEYB9ftI1drS
 CfsO4I8mktzO2waDNnFSrKVkrJUdzjliXhJc+IwuiuBfIexBvyeReoTzmweiYmA4SD/S
 s3U1x0IQEAVagw7AgrGS9x7bQS9B5bNvkQAO9GcxVz8mStxxB1IemTXlrnvqR3Lb1KVf
 87SlU2AgOFYGRPAaR0m88QNvxmekewN6HIcws5AukYK8i+j1IoN8bAJpc36QmwyiURSN
 pomIUgzVJO6MWqVWCLAJyv6H2POz6ub47FXVO37ZqUm+q2Ts6TuKepkQRWeBrWC55sYW
 vzPQ==
X-Gm-Message-State: AOJu0YzbdP/jj9MHZgFXry9zvq76E9UoQiRB/WaiL7vgTyxlHNNZlzVy
 mNqSIGyKwm9ypVO/zrzpx5cybXintCd8JBnfwRx+n/AEBwuzJba61IPrENSuu5Wo0HOQiJshj2o
 K7LYf3VB77LrY2YzXlDjbOYwp+nXijA==
X-Gm-Gg: ASbGnct7qhAT0CS+fRTJQjTEYFbQPpuUzA5RIG5t74IyB35vwbR5Re6FbQT+Hy/kEWE
 QwIObdYUPEbMW2U2jtS7pm61ZsFEBE7KOng71I8R8473/rHsNA3LK/r1kZiKI+ueXHsLAaA5vxX
 y6Su7eA+znABxJohhpSHT4mZzOLA==
X-Google-Smtp-Source: AGHT+IEFkLPlLS8KA5/BWhIq/g4nOH6wtgUX2s2XwUXdd4FMLvnQJIiCQ72QdoimuswGk5czCWz9kBVJF+DnoclJcZM=
X-Received: by 2002:a17:90b:3890:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-306a48bf3f7mr6779340a91.8.1744038228970; Mon, 07 Apr 2025
 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 11:03:37 -0400
X-Gm-Features: ATxdqUHL5mUjSkraorC0xCvwpP4qPytErmPSyvXv3w-uYjelmwVq1zhhSV507v8
Message-ID: <CADnq5_OYjfyjkUfDCSkRPNrJ9ctu=o6TTFn9EoFxg2hvtk1TkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amdgpu: typos and standardization
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Fri, Apr 4, 2025 at 1:48=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Typos were found in DCE, where hpd should have been used.
>
> DCE6/8: standardize the "interrupt" vs "irq" usage in function names
> with DCE10/11.
>
> Alexandre Demers (2):
>   drm/amdgpu: fix typos in DCEs
>   drm/amdgpu: use "irq" in place of "interrupt" in DCE6/8 as in DCE10/11
>
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 +--
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  7 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 28 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 16 +++++------
>  .../drm/amd/display/dc/link/link_factory.c    |  2 +-
>  5 files changed, 28 insertions(+), 29 deletions(-)
>
> --
> 2.49.0
>
