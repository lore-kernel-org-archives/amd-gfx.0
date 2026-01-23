Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0696D778B0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DABE10EBD7;
	Fri, 23 Jan 2026 20:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpG+nYja";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2160510E2EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:51:29 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b1769fda0eso307101eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:51:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201488; cv=none;
 d=google.com; s=arc-20240605;
 b=PxsXMiKgBN9rS8M+myzWr8CCbCxfNv82rG2NHl0mwzuEk92SR3f01tlvt84AKLwSG7
 E0LC0LXhvV/EA/YQEJil4rU2/qZfKRRFE9+iG0Wfligv1zfPkUtWq5kVgmgTWoqtb4rF
 MoY25dqtJ3PPnEj4I7A7/WxCm0taSyUO2s/6pClSG8iOAC7kwA5FX+szh7cC5rwDbt0V
 soXxdiYMZfteTEbBKQoz8cExek8blZ2d2CNCJDPFCKGKCu8rbupFe5+yHiN7WLnINdyV
 tZyxlWPhjuJOa38r7Pte1kEk7RCVE6yoRGuvZ7Z1aphMbeZwZB/AMWPlZ+q/G761eTPx
 5qRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pcGs/IfEJClHzrWtfn1TlZv63+OZCnuZpsFKZ2KWBXo=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=F3epIoHI+jsI4NvdLeDZJ5OEnaF0mbmfBvh7eCqj/Yi1Naz9cfXmC4/SMCwpQI2Nnr
 Hdi/bVkbfbQTxe2efTKHHDkqvIa9aMyBSMLI1Gro588wlud0hvPuC+Ile7eiiJvSjF2E
 EXoxHNULANER+krzpxpbW/1JIYHbASRLVRrCsWmzF22VOlukShbPW6oG1togaCRuhMNl
 4SiWuVCpsv46Qnif6uOgapFn4sPSDEqIACsakPpBpYKrBqQVdLg7fZoDEG9xE1bkCp6s
 Ktp4As9ha2Xyk2hTKRJBtyqFDvBLdSaaJU1RDbZ4ZylA8/rgJsEQVuN0r/ih42Z1N5uu
 W5WA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201488; x=1769806288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcGs/IfEJClHzrWtfn1TlZv63+OZCnuZpsFKZ2KWBXo=;
 b=DpG+nYjaIB2K/ns/KS+TKaXO2pPEX+IGbBGQ5SaOMIKicCQDXijVTdvdc1T2wbCHKQ
 saWz5jiFRKlQh3eZ0+7aX03CAPX8CDjfdSmHIszp/U8gWGgXyenJ5FHVLGBZMKIdcEVp
 Qu1Qfc7PjdArT6xvrz9kpjULvLIdAryT2LnJf/W7CUqY8cB4n76cZlGN7djHuhM1o2bw
 4xWVkhs/GGcjVhtyXPF4aUs8IpMHnHWEiqzfaBZyq9Ig8xmZlzDupU5eO60KfIYuife1
 Y8LwkfNP4q995t2YlZU9wfR/Hr3asL3Sq6YkzPtOm4l/Yvxu1ydjGILWuh34yPs3eTsN
 LBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201488; x=1769806288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pcGs/IfEJClHzrWtfn1TlZv63+OZCnuZpsFKZ2KWBXo=;
 b=JneMyxh3LL1sH+IhskvJ6IxxqUjvC/sQJxgI7778JgptKXznpb15WZ0JR9Z0eboLTm
 zDuKZVdSfSA90+a3kvaTSlwomf0pXElD0xCAkfHfjbupTQaoGdTnk+xfpsnU7OY0aROn
 jHVhIsO73YqaH9OxLOT4AF4xEPF7iviWPUYp69JgbWyHusWIXplVlhsIx6Hpsrf0x+7P
 xgJB/QhIlc5D7dP8hj7jSQEV+kw4/nIIVglyI0dUiQzxbe8hTMOaFh8dzj/VvrJOzSDN
 RQrkvd/pJTi+2qq9GN8ebwTVtIT+E5YspsusC0RF/7KiuzEBxvfOZVgpxYlSjeSpNDc5
 YI+Q==
X-Gm-Message-State: AOJu0Yw8pUa4Azym7mD3oqCP7KkdZGB4ooIemAl7Ctcgme6yguNAxYXX
 SHl9Ibx4Cs+PAXy9bBpEId2UgNM48fsJQy9OpPfUs1lf1aGIXMs9nxohpX7sjgHSvj3HejWT8wy
 MmeJXWyvFIgiixHRA2J4uttpBV+5630g=
X-Gm-Gg: AZuq6aJvKC61uDbUpU6OSDIShsVnOlPD5by6KJOXctlTxsPE6G0H34dhclTOJZ7sPEN
 LkcUaE5QyOi8fKssNu2rysWzrNYXvjlyyE43HzLmLvlHdUVyMYOPy2kLMauhqbj6v9oT9KtEq7t
 COIBDSq/dqYXhtZnpSb4lQwDOcGPaCm/v80W8vVz2f8v5BpgLimTCKo5veStp11Vm4JdFfAEmJP
 0qUWb6Ra3DKARbVeb8Cb6B1Qqg6nrqaK3zSfWSof1Hugeb+A0zt39ImVg9oohMUsm5nwetZ
X-Received: by 2002:a05:7300:d50c:b0:2b6:ffc8:42ca with SMTP id
 5a478bee46e88-2b74e7d7df9mr210020eec.2.1769201488229; Fri, 23 Jan 2026
 12:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-10-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-10-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:51:15 -0500
X-Gm-Features: AZwV_QjaW7ZxLKRBE3kjGVKH3aNEv_NMNzyDp4bu84fy9D3U3DrfXQpzf2pGo8I
Message-ID: <CADnq5_M6Mi5SJi_AYKhdmwacxumeTUrRHMrKazQxEM4v=utS7w@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] drm/amdgpu: Add ioctl support for cwsr params
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Thu, Jan 22, 2026 at 5:52=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
> address for save/restore buffer, and size allocated. They are supported
> only for user compute queues.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>  include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7ad8297eb0d8..2765317f04df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -343,16 +343,21 @@ static int mes_userq_mqd_create(struct amdgpu_userm=
ode_queue *queue,
>
>                 if (amdgpu_cwsr_is_enabled(adev)) {
>                         cwsr_params.ctx_save_area_address =3D
> -                               userq_props->ctx_save_area_addr;
> -                       cwsr_params.cwsr_sz =3D userq_props->ctx_save_are=
a_size;
> -                       cwsr_params.ctl_stack_sz =3D userq_props->ctl_sta=
ck_size;
> -
> +                               compute_mqd->ctx_save_area_va;
> +                       cwsr_params.cwsr_sz =3D compute_mqd->ctx_save_are=
a_size;
> +                       cwsr_params.ctl_stack_sz =3D compute_mqd->ctl_sta=
ck_size;
>                         r =3D amdgpu_userq_input_cwsr_params_validate(
>                                 queue, &cwsr_params);
>                         if (r) {
>                                 kfree(compute_mqd);
>                                 goto free_mqd;
>                         }
> +                       userq_props->ctx_save_area_addr =3D
> +                               compute_mqd->ctx_save_area_va;
> +                       userq_props->ctx_save_area_size =3D
> +                               compute_mqd->ctx_save_area_size;
> +                       userq_props->ctl_stack_size =3D
> +                               compute_mqd->ctl_stack_size;
>                 }
>
>                 kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c178b8e0bd3f..b7a858365174 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -460,6 +460,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>          * to get the size.
>          */
>         __u64   eop_va;
> +       /**
> +        * @ctx_save_area_va: Virtual address of the GPU memory for save/=
restore buffer.
> +        * This must be from a separate GPU object, and use AMDGPU_INFO I=
OCTL
> +        * to get the size. This includes control stack, wave context and=
 debugger memory.
> +        */
> +       __u64 ctx_save_area_va;
> +       /**
> +        * @ctx_save_area_size:  Total size (in bytes) allocated for save=
/restore buffer.
> +        * Use AMDGPU_INFO IOCTL to get the size.
> +        */
> +       __u32 ctx_save_area_size;
> +       /**
> +        * @ctl_stack_size: Size (in bytes) of control stack region in th=
e save/restore buffer.
> +        * Use AMDGPU_INFO IOCTL to get the size.
> +        */
> +       __u32 ctl_stack_size;

Does it matter where the ctl_stack is within the save area?

Alex

>  };
>
>  /* userq signal/wait ioctl */
> --
> 2.49.0
>
