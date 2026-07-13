Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E34C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C4F10E5F6;
	Mon, 13 Jul 2026 13:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WIzwmD95";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D8510E5F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:59:04 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso226405a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951144; cv=none;
 d=google.com; s=arc-20260327;
 b=cyDgFAf45qFO+Ku0/73TtsvKXItC7YdVRL/phoynn6lRAdgbMEffakGjzY4QgKV3Uz
 JhEOzyQb4Kk4TErZGlJ8ZR1n1blwp7mXC8uowAwH48MDhDb/Z8qQqWzTM5UhF6/PO/+4
 rNVbPpfiB2hccVBuSx0EtynY9FxRcvwDSnUyl0pv7CNBwfOl3M0U2bhTaFA9As6DRxJl
 jXl2uTHrE0BgN/pGLb/EsLnr040+80T4bcDaiLYOpEn7fjNRfPQwr2Wpt5H5t/0DUhvX
 KRf3JkkBpNAURBNQEiV0/YGtLkSj7Ujkeuh0g4WwhGZPfVxv+4O4/Q6cZzbvqvK3SM0X
 SVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z5gQKINsqZ7Xg9A73V8LbB+qqm+qCfEMHj7E8brKthU=;
 fh=qr0IPIxS9c6TNW2ijUYjzCGCWKDvGaYutkTIfp6i730=;
 b=Uw8r28VZQuBOqjVu76mN3vycw0OKnPlIP9vWvznowbhXa4/uE06+XkTXsGsEy6yUPJ
 vRuvyuJJDQmHlOLLjSQRrZSQ/oVYrRpCsl00rn/KIMsrWyzt+xeNkmpxQJ20e1lg6TS2
 0rxDtljXu29FcK29aHokoH3zCRTiaAX5ZlSsEywseBk936HnvvC4CUuZXgNo1eN850IS
 NtY9QtnecalgtVJS57NnOMPJNUQV8Pcx30RY5gsMLJzMUXaFXobShezlBHPEGZZ3DB8a
 Yis/Och9HnTQ/b5J7l4hEy7S4jWlFokpuvMfurDAnOIxBFGbahoRDH000OT7Ivk8mlS7
 ZY7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783951144; x=1784555944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z5gQKINsqZ7Xg9A73V8LbB+qqm+qCfEMHj7E8brKthU=;
 b=WIzwmD95wL6yHCubSI3ql41uN2GwvfCzm2TeotbVLfZL6nCqvokxrsE60JlVyQIwbX
 eTIlLsqUsgBmEhHFGD/DxaLEAT3+WX01QBe8BscYfNslG+Wt5/ZrznseSC1HbriU/Ku5
 RC+ejozrRYPsdZzp31/IjJEB9GBzC03rlSXCd/bt2E5nqWbKRo8tA4wY8D5yUDXNk+LB
 EGMEGqRI32fUFjFYh+BWXts+RCVuWKgfuoGcmo7WU+0Hpt0ZXgAaRjghNscRAgfgOVxM
 QI8rRzB10FMS1NAmKC+LN3kk0YxvvkEdAcpLvNYGIho8H27QEFaFICpjf8rpzZ+7FcKM
 MWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951144; x=1784555944;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z5gQKINsqZ7Xg9A73V8LbB+qqm+qCfEMHj7E8brKthU=;
 b=i2jDyLdQs834k9eju4m5W9XifhPpJJI8LSn9zE1rvQih6sB+gLZP+xpia6NkRkrWyC
 KwosC8Hvja8WefPI3j7p0yAAwcEphhykhdCk6aTRC4tmjC6Nw9MFR1dvI+WVhsuyTpmS
 61WjETVmVCIBdhbzzEAM96Gbf04F/JSXxUIEYWU3U6ulMFmc7goh6y3mfcmjOkx639Xn
 oQ18Qffp25B6Y9BN/cysnL1bOCgC9lfUa5Z3/I3NoizH/Nqzps3LbBcthTTpi8bwk4Gm
 xww6/F1Nm1KpwpagKmeXXX7epNdqsfGdFBsK42GVuAaK6B5EVUWUL+Cq0U5zOsAe+L6r
 1+2g==
X-Gm-Message-State: AOJu0YyTj1POuQIp4q6d3OnZI3NWXg84HDtcXXOldy4NSdAhdLkXLg0Y
 62ezQVIAVM9WEKZfCgLXq+E+XYb+bsD3oOPv4csl267V+CxZoHXV/X7+g7vYybK1sekLTRpRywx
 7RbkN7l4VijWFEy0tHhg8G6EJjZd2p9o=
X-Gm-Gg: AfdE7ckZc8cw2wDPntfrW3+8pkxCdz6oEYdGqOPWNMwefebJT0NBD/2Su+WGrJtl3gU
 qFiHtq+RWCK5DT70hvhjUdiNOtRRGUciTC10NDGkUpnuamJZ5JCrjlOJdLt1GZz/R+mJXsJQFkl
 L9yhXtd24DBOASJ1+XlOW1zphU4HmxhkfOFkh63Eq5vLDkCgN8qrFTUp8CSa1PCn5qaWrAohdL+
 Omz/LmI/wgaxSiFpjCGXg8mu5c9G4pe53vJ9wDEuBSy+etdh9v0daW38GiEULedLN/yniNnXlwL
 iKrXGqHyClxGWRJk6DMkDlx7nUFLON7DCkacQ06pQhcb/DKyvzBPiuioLow=
X-Received: by 2002:a17:90b:562e:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-38dc761a899mr7127666a91.2.1783951143739; Mon, 13 Jul 2026
 06:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260711113435.28917-1-timur.kristof@gmail.com>
In-Reply-To: <20260711113435.28917-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 09:58:51 -0400
X-Gm-Features: AVVi8Ce6JFa7NxnXdQkx4H-CXgm2AMXLGQfCI386Pr49qhDLeYpckSVx4Zi2MQw
Message-ID: <CADnq5_MH5Oi7dpvZESQNHAR2zknyJvWy9JYxxgoUtNOt6f2mmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>, 
 Melissa Wen <mwen@igalia.com>, mario.limonciello@amd.com, alex.hung@amd.com,
 harry.wentland@amd.com, Leo Li <sunpeng.li@amd.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
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

On Sat, Jul 11, 2026 at 7:34=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Always set native cursor mode when the CRTC is disabled,
> to make sure it doesn't cause atomic commits to fail when
> they are trying to disable the CRTC.
>
> Fixes: 41af6215cdbc ("drm/amd/display: Reject cursor plane on DCE when sc=
aled differently than primary")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5432
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Tested-by: Viktor J=C3=A4gersk=C3=BCpper <viktor_jaegerskuepper@freenet.d=
e>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b97ceabe6173..61b0b7531959 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6608,10 +6608,15 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_=
device *adev,
>         /* Overlay cursor not supported on HW before DCN
>          * DCN401/420 does not have the cursor-on-scaled-plane or cursor-=
on-yuv-plane restrictions
>          * as previous DCN generations, so enable native mode on DCN401/4=
20
> +        *
> +        * Always set native cursor mode when the CRTC is disabled,
> +        * to make sure it doesn't cause atomic commits to fail when
> +        * they are trying to disable the CRTC.
>          */
>         if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, =
1) ||
>             amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
0) ||
> -           amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
1)) {
> +           amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
1) ||
> +           !dm_crtc_state->base.enable) {
>                 *cursor_mode =3D DM_CURSOR_NATIVE_MODE;
>                 return 0;
>         }
> --
> 2.55.0
>
