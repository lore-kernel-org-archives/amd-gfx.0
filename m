Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3109C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7C610E08E;
	Tue, 29 Apr 2025 19:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K7FdmXve";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AADE10E08E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:21:32 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-227e29b6c55so11914015ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745954492; x=1746559292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KND5+szgmH8L/jn2O7XjKTt3dzXSNrx+g6xusWKs1ow=;
 b=K7FdmXvea8zrOCSac3k6w57ZvjlaO57cJQ9UxBq6KUF0QbJeko+r1GjTJnNHUZG76A
 4cCjPdOLiw5tY5kN7+yWkG/BwvyQvcub0TUvAVWUeLZdTQoxTl2nKKJ2AJj4v4wzXcdG
 yR/e7kMyPRTH+uWtFBQz0pyCgGBXxynzwKl0WwhCqQfgDyWbJ3WKad3pG4LvYjeimhAs
 pgs+8YXfbJUnuZATU9t3RsGDhprdMkIv4O2/wrkAHU1hXCOkN5kBMNY31HYVyxshF+62
 cmUefxf8641t2mNrTquVkjep1o+dUio98f9CT+DzjEfbbjszu6STJy4IGhwkyffM8FxO
 RrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954492; x=1746559292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KND5+szgmH8L/jn2O7XjKTt3dzXSNrx+g6xusWKs1ow=;
 b=wKjxwlOV+6zwJv3ZvaIbPO9zA5bR3sKvKxI6diFpjzrxcuBBSBdbv3VI/NT/LCqYVw
 u/AzZ+A9dBrpMxsW9s4gBSarmJEqKe2w1i737UHP4QEqN3de+8EaCryiuLUveKpm+6Th
 9jqx3ffWGRxPJ4+Ftzq2DF3mS0xtdUWoxS9T8beNp70paGerVrd4JPo9O0P5b7ujc8Mn
 CGqasULoNcNFnj9jXwGFcwqBLkD5M5L8Wfugycyw6tU7TPQXrjqD2aRKjNTKT29S0Z4A
 rhn5OOQLs/G1fEhPPkbyW+qLab73NzlcuLAgxUtKcf5isXsWqQSUnAUkWPv+xm/roXTc
 txEw==
X-Gm-Message-State: AOJu0YzKYlJ4qAGwdkQeT2ZtENYp8owJAyMlDu/BgTfUp39JdP1AaclS
 hrV2V3AadrdvVXqhOAiuSesgxmHnuqRsYnCoZ4MLlZAJWT7Ruc1JrlStdYfSrfbZ1rDVVGUDkQv
 LXPt3AU+uZILNt8ij/c5YcnsqfNg=
X-Gm-Gg: ASbGncuV4egVAhXQM09yRmzkAy++XmBByxIB1NOHqHcEh7Sd9Q8yojjvAcEdnwEedGG
 YNvwaSXtUoWyYTYFk9NdM4hGcl7F7/0qki6oHi06WN9SV44v2ZzsYisn1qWnSy4poabQBGFKMSn
 tHwsqfYSRVLs2Vua53z1dVQg==
X-Google-Smtp-Source: AGHT+IGyzZaXAxmFCKwKhlrQjBt70BR7c6Kf3nq5RT4NbnSgyAh6oLW7T5nk9ikYiprzpgshUJ8bSXePwktSKW0wGLQ=
X-Received: by 2002:a17:902:f649:b0:21f:3e2d:7d43 with SMTP id
 d9443c01a7336-22df35a39e1mr2704375ad.13.1745954491823; Tue, 29 Apr 2025
 12:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250429190542.1896100-1-alexander.deucher@amd.com>
In-Reply-To: <20250429190542.1896100-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 15:21:20 -0400
X-Gm-Features: ATxdqUFr-8QT8fO4uraen_ssJbe214LD1X3jfbCXI68RO2CO-9xzeuWub3BpPRc
Message-ID: <CADnq5_NuLETsOC+Qp8A9n02Lnfj2WSgD-oaGJ6jjCx4yT66Bnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mes12: use AMDGPU_MES_SCHED_PIPE for
 legacy map/unmap queues
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Michael Chen <Michael.Chen@amd.com>, 
 Shaoyun Liu <Shaoyun.Liu@amd.com>
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

Will drop this patch legacy queues should go through KIQ.

On Tue, Apr 29, 2025 at 3:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We should use the MES_SCHED_PIPE for everything queue related.
>
> Cc: Michael Chen <Michael.Chen@amd.com>
> Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index f9f2fbc0a7166..83136fcbd50ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -498,7 +498,6 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_m=
es *mes,
>                                       struct mes_map_legacy_queue_input *=
input)
>  {
>         union MESAPI__ADD_QUEUE mes_add_queue_pkt;
> -       int pipe;
>
>         memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
>
> @@ -515,12 +514,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_=
mes *mes,
>                 convert_to_mes_queue_type(input->queue_type);
>         mes_add_queue_pkt.map_legacy_kq =3D 1;
>
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> -
> -       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_S=
CHED_PIPE,
>                         &mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
>                         offsetof(union MESAPI__ADD_QUEUE, api_status));
>  }
> @@ -529,7 +523,6 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu=
_mes *mes,
>                         struct mes_unmap_legacy_queue_input *input)
>  {
>         union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
> -       int pipe;
>
>         memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
>
> @@ -554,12 +547,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgp=
u_mes *mes,
>                         convert_to_mes_queue_type(input->queue_type);
>         }
>
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> -
> -       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_S=
CHED_PIPE,
>                         &mes_remove_queue_pkt, sizeof(mes_remove_queue_pk=
t),
>                         offsetof(union MESAPI__REMOVE_QUEUE, api_status))=
;
>  }
> --
> 2.49.0
>
