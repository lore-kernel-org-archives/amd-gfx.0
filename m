Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C8CD609A9
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 15:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB7A10E70D;
	Tue, 16 Dec 2025 15:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+yC3erJ";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFD810E71A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 15:16:21 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-bc0d28903c9so186777a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765898181; x=1766502981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Prk++bNPBbw7llSvdyWuyKrdatVuaHMUXvtiIeDQebI=;
 b=c+yC3erJCkYUfP/orrlyEvGpp4lD0pxjxzqopBFeNWnkWhH+GeSBMjp7Gv3nL/Lnxd
 Ozykjnq2pX6LUrSIQhUOeQss8HcePKHosnDjVhJhYLyC/hv0YqVdav0WaUTTyiGgsHt1
 wa8XvtMsZ+1ywzwjBSPnejjoS/KHr8qgT0XKxCunOeEZXejVy/lR2e+OtU36xJFC6juS
 byP1RX1VsMgMp7gxfcTBUK8fA8HpHwVpQf7ph9PYj2hy+04p9LPxeiCKrAQgxse5a3RN
 1gbYucZbEq3ex+HfYwJnIhk7kgVzRon0c80lR2EJRdvF9H3pIocmRRBqaFHWmCFhtz+k
 Nbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765898181; x=1766502981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Prk++bNPBbw7llSvdyWuyKrdatVuaHMUXvtiIeDQebI=;
 b=ChSzVp/oNptpwQI1WqYhTwG1v5SxaDnqpBwUeoqDgHhN5go/3jQS0kyvjLV69Wteut
 dVa791eHrEprVkRnK9kK2QlV8bpsqGWzy+2tX+p++cerb3xuZ2XqUOCnWQnsz7W8G2EN
 5Crk43bxq/KT8q+4YoudUqmHhHTpTbNnfy927kuu0zLj7NTDJ/NVz/x/18T2tSNkyjwj
 Qz4zudov50gomgewlfrTDRbHr30z7v1d1f3aVvJ0lKca4nQk+uTzesjNm4ZqT6OSfpw6
 QJ65xjkNoQ5PUYRP77bm2XdAFrNSsDYPY+Rmy6I2tZ3Aa9lseGPkbynlXTM3O2CUZZ+x
 h46Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC4OY8x3AoF6aaFSmrMnK7X/N9nW0CADV0mq39Q03Pz7xzQKyJgR0r4aWAkhDgdEvtmnY61W0P@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxkRjaHnOgRVFJwDVIubD3a+VoY3msoxUC7ilSZcCIdilHYavc
 fjrtpcV6xEdtBPRJaI1APLzCQbO8uXGZpr9ubrlUACwPBxDHoYNIQVy3v0aYwi3jbCfB3hJSiTt
 YP6gfchTVwVH4WrURWke0KTB2K+27j9E=
X-Gm-Gg: AY/fxX4/ADflFEoXOqIO5sFd//ZPkxNlql9OznEO+2J+jr6Le5wM4a/MNgrnIsbiLVl
 p4Rx71MSmYS9bh8xinOlesDRBX0CS8/PBJ7DAELWbZFRKRI5Rb4SLO8u0JgOcIyvveg7yDWduuG
 +0aqFujpUwjKRLrLNGsQJXYQdxI/7mwWe9GDv12sAOcZsbwUb6O6hH4XCSjB2HKwg8HUgwUT991
 1e24t/RE3E3dDpxRa54S0IihNI+47YXBpXSP02vDCULWeRGPUaVi8rHf1bFBqZIv/F1H1hH
X-Google-Smtp-Source: AGHT+IExL4bbWd8dGz3R1du6C5PQxAQFN3higbgXbHR2p3Vd8GWbSJj78l5nGqz1hyDQKAFC7gD/XLUbhsxrspplMLo=
X-Received: by 2002:a05:7022:698f:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-11f34bd3d6cmr7088129c88.1.1765898180806; Tue, 16 Dec 2025
 07:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20251213-dml-dcn30-avoid-clang-frame-larger-than-v1-0-dd3d74b76a17@kernel.org>
In-Reply-To: <20251213-dml-dcn30-avoid-clang-frame-larger-than-v1-0-dd3d74b76a17@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:16:09 -0500
X-Gm-Features: AQt7F2o9ouuY7f1i8nUGZF2nlb34bshqvLmZP02ymrNXjm02AX6gvFlIqpRP0n0
Message-ID: <CADnq5_PLd_v9n=dHFmAdPcWY2NbbyCocOtE-9CoMX4D1H4sL+w@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd/display: Address -Wframe-larger-than with
 clang-22
To: Nathan Chancellor <nathan@kernel.org>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev
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

On Sat, Dec 13, 2025 at 6:04=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi all,
>
> This series addresses a new instance of -Wframe-larger-than in
> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c with
> clang-22 (current main). This is similar to previous fixes that I have
> done in other dml folders such as:
>
>   a3fef74b1d48 ("drm/amd/display: Reduce number of arguments of dml32_Cal=
culatePrefetchSchedule()")
>   c4be0ac987f2 ("drm/amd/display: Reduce number of arguments of dml32_Cal=
culateWatermarksMALLUseAndDRAMSpeedChangeSupport()")
>
> This was done fairly mechanically, so let me know if there are any
> issues, as it has only been build tested.

I'll run the patches through CI and if they pass, I'll apply them.

Thanks!

Alex

>
> ---
> Nathan Chancellor (2):
>       drm/amd/display: Reduce number of arguments of dcn30's CalculatePre=
fetchSchedule()
>       drm/amd/display: Reduce number of arguments of dcn30's CalculateWat=
ermarksAndDRAMSpeedChangeSupport()
>
>  .../amd/display/dc/dml/dcn30/display_mode_vba_30.c | 545 ++++++---------=
------
>  1 file changed, 139 insertions(+), 406 deletions(-)
> ---
> base-commit: f24e96d69f5b9eb0f3b9c49e53c385c50729edfd
> change-id: 20251213-dml-dcn30-avoid-clang-frame-larger-than-36afd349190b
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
