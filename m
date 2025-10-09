Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E99CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0505C10EAE3;
	Thu,  9 Oct 2025 18:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/NkyP7v";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 434F910EAE3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:54:11 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-26e81c17d60so2317675ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036051; x=1760640851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GNmZAsn5rGIi5zLyNFozE0h/Mklyq/QJG/gNFoBN2U=;
 b=C/NkyP7vcMgMUd+Q43YRK33bieZX+rGp0gjQlnI0vV/Qfjy0WXcnf3o9SgBgpWmc1P
 wD3Yg1zaTuqG23nr2tOg8wgBtcmsSiH5h4RPKjyiE8wo6hG6APP68IhQ2RVXN05mHab5
 /QvWHS5HTjIdM7sUs+AQSHs/kvMv+qzStNLPONkHAkoDueaEm5Yzjc/PEgX1ZApdlO34
 etWz+AiWW4NJRHL1RYPmTy1xRZtzbM9h5RbwvNI0Qjz4wmlTdOKHY4D3TqyUIgPbIef9
 HlgCXjzPjNyCRem+Pf57hGdfgTJ7OBp4aesMzKKMtpi3zMHH0/7Y5yBa1liI42P/OdfM
 mg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036051; x=1760640851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GNmZAsn5rGIi5zLyNFozE0h/Mklyq/QJG/gNFoBN2U=;
 b=vBz4Gb3o53QquZpltucSzZ9rxAX6cZdrA89mv2ln0B93mnCDYsG9Fp2cFcCBU6zgLa
 nffRpmvp6DDBzWFpvAFtA8g9u+0CiCoH+0+3+cUxO/FibmVXjVVQrCD+rZcmQ9C6uxBo
 1EOPUvTExp1Ue/215vnPyEbWIh6VI9HB1FWr1533EI3LXO+oUb6qgdpyjazFFbtJ0VL3
 /ZhDy0mr2jjV2E81JsSfXmp7QX71NyRYiVUNXKsf9P4g+HoK0zOHgNY4MC2+kf7/fLfy
 EfN6OVSm/7z5oxvpVHbSIrWqkdkVM9+OfioAvlR8FwyVmH8oCtzSQ0Fub4JW6Z2PzfZD
 wlvw==
X-Gm-Message-State: AOJu0Yw2ukcKLq6AnHScc5aMnLSJvSyRkiBrf594F2ZE0pcdUJsPYfYw
 yNJgdO2LDNBkXoW80h0fwy03xjKKsDr6TjWGwUdrMWs16kIqJ3McTttV+L3KJAokODQ0KWHbqAc
 QIa9ozUo1YEv2/0onfGOm4C7AmVYLE9k=
X-Gm-Gg: ASbGncvwbRLOH5tQpg2zLyA/lxmwJCz//xAmr0wyHDGdZFD3stlV56qMIl814yxxbLy
 fupxFHu2Yj2k75S725VYJJ0GdsxE/KA0pOBhm0V0dKu7JV//Hegi0pFoB/Xj5xHVcLTO8v9/W5/
 /g80+nLBjWe2Of6GK6i4S70eV/ozhLp9aDZI39nqXqgR45SspO6fdLPjWgODIsHQfAO/xFcZq2f
 IV2N33Tqidkc1LXrwEXIaHYzxO7g4RjDa2f86oakA==
X-Google-Smtp-Source: AGHT+IEvJfA75FxZD12U8rB1D8YIvh6qs2bIf28w4Y6hk7gg8QzHvSgwKTe6fSK0Wof1JSAAV3fNtCg5eS9O82DDQss=
X-Received: by 2002:a17:902:ea07:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-2902743e550mr62682835ad.6.1760036050676; Thu, 09 Oct 2025
 11:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-2-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-2-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 14:53:59 -0400
X-Gm-Features: AS18NWAnreeEB1LVVOk4Ml9vg6k3WGfK7EQTeQiXQPXGkkuMPjIZrbJZOk-9w3g
Message-ID: <CADnq5_NnzSVq53N5Jc0scyCGgAHcd29h-wAAE80f9HCcPYtZ2w@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: fix gfx12 mes packet status return check
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Shaoyun.Liu@amd.com, Harish.Kasiviswanathan@amd.com, Amber.Lin@amd.com
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

On Thu, Oct 9, 2025 at 2:50=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> GFX12 MES uses low 32 bits of status return for success (1 or 0)
> and high bits for debug information if low bits are 0.
>
> GFX11 MES doesn't do this so checking full 64-bit status return
> for 1 or 0 is still valid.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index aff06f06aeee..be8a352f9771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -228,7 +228,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                         pipe, x_pkt->header.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> -       if (r < 1 || !*status_ptr) {
> +       if (r < 1 || !(*status_ptr & 0xffffffff)) {

You could also use lower_32_bits() here, I think that would be
clearer. Please add a comment here about the status in the upper 32
bits if the value is 0.

Alex

>
>                 if (misc_op_str)
>                         dev_err(adev->dev, "MES(%d) failed to respond to =
msg=3D%s (%s)\n",
> --
> 2.34.1
>
