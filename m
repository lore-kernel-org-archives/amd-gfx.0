Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D72FCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8C510EAF7;
	Thu,  9 Oct 2025 18:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RXz0C1sm";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2965910EAF5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:59:18 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2698d47e6e7so2240925ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036358; x=1760641158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdiaJ59de9vgiQs1tDQqeM5ZoqZlHOLJ6Gq8CKsszas=;
 b=RXz0C1smajDP/mWtyNNLT0ImWVm1QBhojYwerjhscrFhURjjcjH7Vpnu5aJ726PlaJ
 zWNQBPCIReMe90DIOqfBnqyCcbSV7NDNLNzSGpgd9MGfGF9iPz+4abOmSv9tZt3xcvLp
 fIbKbLLXlGYCCM1Wq09I7jLMpnBTGD1dqX9tuQePZlm/YhFzWqWteHEQ8XanF1oT/HZI
 hu1YQEcjppMcpH6gcNUfpCcuJDVAmqBJbxyXL4lkR2tnzS1U8BzOMm1V/xUhA6nHX2gL
 wtrqiRiBfZf7tVkGNGmA1MCpLA0g1tPgxt2GcOHjD0V4OOSVLQ6XKjqVcL4UYI8ErlN2
 T3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036358; x=1760641158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdiaJ59de9vgiQs1tDQqeM5ZoqZlHOLJ6Gq8CKsszas=;
 b=S9LF+QclU/iSFhKPe7AXClNoeQMNlY24rg2c2+dGRcNG9zed7NyduuKL8dRgN0fgWW
 xAgagXMEptGRfD6e55D9mdIM95N0i61/cmOIGZPsESfet19/tRBZBP+3klXmiKAKdqqF
 lVcK9V+LqNRYAvVu2YMpiuHaTxU6wW8HIf9vmV4fmbQt+lfCReUYgv+UduzXJ57I4krn
 94U80f0XCVDvK0BEEwkzb6YauPbSvRpXQ1GekwG0qaCa5qRkx6pi3a8XVlGym1q+/yON
 fj3GB36NciO4keaFPlZv+TAyP6Iue5MZ/f/wLku1up5oXNlzBMrmyXJj6E5u76Vdrh9l
 xKGw==
X-Gm-Message-State: AOJu0YwgM2ukC0nQEmkZjrTfSusj0XjCiNeUegQSEChcb/6uHsAgQxmB
 bzrMXbwtoEfe1gtUxAw0othrZ2npoIrwRiyN/ukDbVTCXdS+m5X4s/0v3PvMAFjRjbG8xqlVsnI
 I3kk5NVodIPt2xnBukn4rynrnTbaYWt8=
X-Gm-Gg: ASbGncuMMhpgo8TuR9alDAnPkUW0puT2k4sF84jes627BbZPALThXa1w2eiOGKG49Bk
 gXexYl2q9jC/QfGgsd2apZw/RkP2IRis8JkGCSdzX9d+pu96o9vLI4AbcFaRnqE7DX6W32rC3N1
 MMI0Jkb+Bqh2okC9IvfH8qjzYQ1nXwZtPAS/g8WtBgPvbr+IIvX+3GL+hD2C0kulVmrtSe00Xg7
 ZK8ZedSrA18/9nLs+gfXK/XX5FqvMhbF6QRfvTm+g==
X-Google-Smtp-Source: AGHT+IFmr/lblh5UxQcJV1ZGi6b5eweht3YWrb3osaHSocdpcsqPqllzrtHzeUHxi0LV99O753nfJFqwHP8lf8wXdYk=
X-Received: by 2002:a17:902:ea07:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-2902745664amr62601045ad.11.1760036357550; Thu, 09 Oct 2025
 11:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-7-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-7-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 14:59:06 -0400
X-Gm-Features: AS18NWBRR40qoFQ75LGlzqeTBH0UYFdPXUDLEUEQKAVZISPyP5G6mgQjTihY9Lg
Message-ID: <CADnq5_MoYMP_5hfESOg2-mZJYitn+_ZP5Hj0UK071NLs69WY5Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: update remove after reset flag for MES
 remove queue
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
> Remove queue after reset flag is required to remove a queue that has
> been successfully reset to clean up the MES' internal state.

Is there a minimum mes version which has this functionality?

Alex

>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
>  5 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 97c137c90f97..9c27a68cb82f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -239,6 +239,7 @@ struct mes_add_queue_input {
>  struct mes_remove_queue_input {
>         uint32_t        doorbell_offset;
>         uint64_t        gang_context_addr;
> +       bool            remove_queue_after_reset;
>  };
>
>  struct mes_map_legacy_queue_input {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index da575bb1377f..d2a34b4d1797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -378,6 +378,7 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_me=
s *mes,
>
>         mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset;
>         mes_remove_queue_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
> +       mes_remove_queue_pkt.remove_queue_after_reset =3D input->remove_q=
ueue_after_reset;
>
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_remove_queue_pkt, sizeof(mes_remove_queue_pk=
t),
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 79dd2261ad04..0d580d1b5794 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -365,6 +365,7 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_me=
s *mes,
>
>         mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset;
>         mes_remove_queue_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
> +       mes_remove_queue_pkt.remove_queue_after_reset =3D input->remove_q=
ueue_after_reset;
>
>         return mes_v12_0_submit_pkt_and_poll_completion(mes,
>                         AMDGPU_MES_SCHED_PIPE,
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index ab1cfc92dbeb..f9629d42ada2 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -345,7 +345,8 @@ union MESAPI__REMOVE_QUEUE {
>                         uint32_t unmap_kiq_utility_queue  : 1;
>                         uint32_t preempt_legacy_gfx_queue : 1;
>                         uint32_t unmap_legacy_queue       : 1;
> -                       uint32_t reserved                 : 28;
> +                       uint32_t remove_queue_after_reset : 1;
> +                       uint32_t reserved                 : 27;
>                 };
>                 struct MES_API_STATUS       api_status;
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index 69611c7e30e3..2f12cba4eb66 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -399,7 +399,8 @@ union MESAPI__REMOVE_QUEUE {
>                         uint32_t unmap_kiq_utility_queue  : 1;
>                         uint32_t preempt_legacy_gfx_queue : 1;
>                         uint32_t unmap_legacy_queue       : 1;
> -                       uint32_t reserved                 : 28;
> +                       uint32_t remove_queue_after_reset : 1;
> +                       uint32_t reserved                 : 27;
>                 };
>                 struct MES_API_STATUS           api_status;
>
> --
> 2.34.1
>
