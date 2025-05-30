Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB374C5B543
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 21:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A86910E884;
	Fri, 30 May 2025 21:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1TwlJRn";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B846510E884
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 21:34:30 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-234c26f8a25so3868635ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748640870; x=1749245670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayiP/Tal322shPWaCWGGZ6nSXSDecv/3E9sLut67lqI=;
 b=A1TwlJRnDZWfVd3wRbqUTLohQa0w2MgBkha/iSo+xPk7A8EGmnyXdh/I/r4ERqMhdj
 HWXxCRWtqQ5H698j4vGox1GZVD/UBsqFnIcPSF2eBcP4aDbogqYHypiEiRuYvMqMcbai
 YeiLpZIsSQWAIksUFxo9L9UEwqdDI+pTIxp3hKkbu4impzlhGAEp8POI5INMAp3ECP9N
 PZUiTkNLounkksXly45nBdciYu5hGitVi5+TGMl45cpIAlTRw3CHJPs5iwutMaYcDWA7
 dibAweMAscI1z21akW9gLEZNj6m/EAanEKBoQrUlPUE5SWj2g2Scu1SZpQsuwE37VhKr
 b3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640870; x=1749245670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayiP/Tal322shPWaCWGGZ6nSXSDecv/3E9sLut67lqI=;
 b=uP67zA2R4DoGcWI5nrVmlo5EZfWp9H3xRj94S+vJ/VW4EjZAfpFG0Y3n+kc+gzmCa7
 KlOD4SCVBeB9EUElkTrY9aEIZaRL4Bgqh5Cb2nOcBvmBxu4tBgddTK7TlAX6ZkdYxqd5
 hIpzefdnwKLrd0NVxhQSJSj6lDCgcQTdENaDyn8TkhAY5hNto8DW4/13DXOTLuPlXYcJ
 cBJ1y42upN5htD/9LNLda6WCeLzr8GTa9rbLzZNIlyXovu547Mp4uE42A9rQFhBnBlgZ
 smr9LvcDvtQKWI06wSmI6LDuahlT0Z4NGI/UhpgH6a5FfoNJzPgDniFMZhIGn1y0og+W
 OBQA==
X-Gm-Message-State: AOJu0YzRdPJmHwlsuL1299dgp2LwpMTJqyXMgky0K1LG66qaALv0jhm+
 VViL1ZlEcq9+U8lIPrbxea7C2Dr40Gq9/pNsPA+IUIMzHLUhrKE8bdp32L//kJGLlsnmjWEl4Cp
 3SJnpInb3hW5GQwqtN3TgtsIz1CP/uOEsng==
X-Gm-Gg: ASbGnctk1cO3/w7YuoJ0cY1IWBsA+YWUMlnMtCslJkSxRv5ajqjdDwFWplMqSt9qD9f
 JUBsLfliFeJtcBKIGSUy145y3pj8kr/7S+loFnPacKetltBbavW0K87kIaHzW39wUe1BY4AQTKv
 Y5JoCSUlbjWsG6uo7wzwM7Mh7hitQgRV+M8jbRnd4Nd6g01WzafBY8EVw=
X-Google-Smtp-Source: AGHT+IF1aALP9QviwMzNP1p4OoqIBV6JscBkSE1yYGHEav8RB6vA6TvOtjcizX5uaLoTXcxyQi92ZshxDjUUNwlGYwk=
X-Received: by 2002:a17:902:e5ca:b0:235:be0:db45 with SMTP id
 d9443c01a7336-235354f6a04mr22678755ad.5.1748640870282; Fri, 30 May 2025
 14:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-2-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:34:18 -0400
X-Gm-Features: AX0GCFuPieP-WrXVuDgqsbE2C8iI2iQdjWPe9M7rj-YYZLMiTnTEaXTVl74cchQ
Message-ID: <CADnq5_NadVhtnAx32FR_v_wY6uaVS8fFRo4V_8ccdPbbOz9thw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Fri, May 30, 2025 at 3:55=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Before destroy the userq buffer object requires validating
> the userq unmap status.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f67969312c39..8eea0e1e1b6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -319,6 +319,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +       if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> +               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap th=
e queue for destroying.\n");
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               /*TODO: before return may need to a reset*/
> +               return r;

If we return early here, we'll leak memory.  Presumably if the unmap
failed, the queue is hung, so it shouldn't cause any problems.

Alex

> +       }
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
>
> --
> 2.34.1
>
