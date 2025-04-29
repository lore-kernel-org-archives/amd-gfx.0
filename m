Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D393EC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 18:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E57210E047;
	Tue, 29 Apr 2025 18:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kbnK+Ler";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BFC10E047
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 18:38:46 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso505284a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745951926; x=1746556726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyaepFJysQVXp7dyZPIhNJEKFb4rXpb2HwpqGkYOH2U=;
 b=kbnK+Leremh9vZRQCARP+UeSRKPqxzbZqloHGbSL6EvUHhj2dwgmIyME29VI/n8zn1
 81arHLUC+G1LMLoAGvGnMJLhHoFC844UcmM3AVZZXbWYaLL6JqQ04GoiAFjg40ungUGY
 vTAlXtfAAUvxyIFNEDngQY+Xq6YrSkT+0cizgUoLQFlITJIwyUsFk0bTrzauipEalCab
 RzZg8cRdUODT2SDjCNB+GtC/QytqSrTZ3JrTdACpKY/EWt/2zxZ6lXCwTaRQOkoPkg76
 O6Pcd56rgkBw69ZXYkTRuDJ705kAQ655KS9B42EfiualpbJ5X9PRjXHS2vxZMZw4O6zO
 +vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745951926; x=1746556726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyaepFJysQVXp7dyZPIhNJEKFb4rXpb2HwpqGkYOH2U=;
 b=L12DeDNGyAqV5aah8oixj3Qk74XjX2gI+GvqZBFJNAfTLB5B49x8DnP6Bh3hN4o0Vo
 NXUMJh+0CPXxvWQCzbPwsE/Q0YN96cVHvfxVAnQ0r8YntirHvyG0ALdV0Kj9udtU5Nd3
 qEJAc+NyEXaHpJUi+BgBWJ2PASOSdBlGCfbAGnXaPGWbZE4DSxDc7/vf4Btu+jJGt5dY
 sDHrpbHhyFrGQRmnhx8WFilXdXoIP7Dxv8iqh88yKFpGHyjIgxWRj/4Sn2K+otbEhU/K
 SKH9A4ixvCZWFxlJFjpiFkjE5gvQs6UdDuV04jnjDVYF/SViOR3myWatWwix9PqzSoK2
 gC+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmHZ0JrG5S18H3TEAI7ClgqP3suxfW4h9rpEaQxT9PeeLx5Gw+OmVywIk8/vB6aQGN9y/GD5KB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4/qr43ptS9K8dP0GWKHzbbXCPGI4RTlEZFlcSsGKTCRUGUMqT
 0Zfw41e3DwXzO8XkNC7mrDOyI0lokyF/bgjnj/xi1GEc71TSYrCaZ5VTj80YfeVH8p5TGp6U/Ri
 t4xSmYoehP4ixjKGJZG/y4wJMukPpG34C
X-Gm-Gg: ASbGncsHH+Y5EIjuIkmn3bsqBj2/JOOaC/ToKP0Any1he/9iR9yEfjzezmylRvgXxPY
 ZTHMG5j6au7HZtYgVwftoa1Z5OVutN4UPg8d6g6Ns8ZfyeRT9kd9v3rZLTF7uu/npRTQmEKqEvG
 1balvL7QlbuBFKLyFNrLJBZw==
X-Google-Smtp-Source: AGHT+IGk3i6wvhID1XI39L4NKb8umZCxM9XPJZM0u4K3B9LMWeTAd6Uf1ab1iHxwze/fWE+MnsVF+D+Lb56wTwc3ZCY=
X-Received: by 2002:a17:90b:1d06:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a333537cbmr104652a91.3.1745951926247; Tue, 29 Apr 2025
 11:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
 <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 14:38:34 -0400
X-Gm-Features: ATxdqUFFKNupdCOvdSXQEsVhGeBZqRyEM1Ol4XwtuFR_HkYuDxjdYrc_wrTSZPE
Message-ID: <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
To: "Chen, Michael" <Michael.Chen@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
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

On Tue, Apr 29, 2025 at 2:23=E2=80=AFPM Chen, Michael <Michael.Chen@amd.com=
> wrote:
>
> [Public]
>
>
>
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex D=
eucher <alexander.deucher@amd.com>
> Sent: Monday, April 28, 2025 5:20 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.=
Khatri@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submi=
t
>
> Enable a primary and secondary queue that schedule together.
>
> v2: fix offset of api_status (Prike)
>
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index f9f2fbc0a7166..57d8b78210f9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                          offsetof(union MESAPI__RESET, api_status));
>  }
>
> +static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
> +                                    struct mes_set_gang_submit_input *in=
put)
> +{
> +       union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> +       int pipe;
> +
> +       memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
> +
> +       mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_gang_submit_pkt.header.opcode =3D MES_SCH_API_SET_GANG_SUBMIT=
;
> +       mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> +               input->primary_gang_context_addr;
> +       mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
> +               input->secondary_gang_context_addr;
> +
> +       if (mes->adev->enable_uni_mes)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
> +               pipe =3D AMDGPU_MES_SCHED_PIPE;
>
> I think this packet should be always submitted to AMDGPU_MES_SCHED_PIPE, =
same pipe
> as in mes_v12_0_add_hw_queue where the queue is created.
> This is because HWS on AMDGPU_MES_KIQ_PIPE does not have the queue inform=
ation.

Sounds like the reset queue function and the map and unmap legacy
queues should also be changed?

Alex

>
> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +                       &mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt)=
,
> +                       offsetof(union MESAPI__SET_GANG_SUBMIT, api_statu=
s));
> +}
> +
>  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>          .add_hw_queue =3D mes_v12_0_add_hw_queue,
>          .remove_hw_queue =3D mes_v12_0_remove_hw_queue,
> @@ -888,6 +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {
>          .resume_gang =3D mes_v12_0_resume_gang,
>          .misc_op =3D mes_v12_0_misc_op,
>          .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> +       .set_gang_submit =3D mes_v12_0_set_gang_submit,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.49.0
>
