Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC6C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6C110E0B7;
	Tue, 17 Jun 2025 15:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGf43VBO";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4628910E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:07:50 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-31306794b30so1013816a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750172870; x=1750777670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uk578x7JqZwg+v195CJrMO4f5VqvnGWC9ummQaOKZlg=;
 b=KGf43VBODeAVKNVdW8DrwBt3AiNPypS8Nl2KOqj8rfNhO7OI1YiaTTaeuFZaKgolva
 omLh/X4TAj9jDkjd4kQo9zjG/79hoPSRS0ZDVALOyUp31djOQ86F6yPNQ9ARJktU+NDk
 MsjM2iL3dzWqZcjI9Zif5TvUTVy7DiU9dVic8IfQ9lsvARL3dcxV+BJN1Nqe1mhy1LFL
 642USd2tOC5V5rohgB1Ou64F1Pkh7SoRpa0OtY82fpmpgcpyDdPQJgC0hgLfVU06Za5q
 gZrRsKAfkBI1iSyTjBUD0efdW5N7bLnZVAqweRGYYh8sX+YAisNRi1ZG0R8vEo6lpOPM
 3Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172870; x=1750777670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uk578x7JqZwg+v195CJrMO4f5VqvnGWC9ummQaOKZlg=;
 b=riIzXO4HcT5hPQ5RzNFaRxunk7+SKdDvCI8TYN0P+h/6K38eyz6MIRSQtsFMbf6BAM
 Wml0QkEmMUuMgPq+Fh0g01pO8r/0ky+OnnVell8JtA4T1kercIHVt8HrAwhseo07l6JU
 bKdmwsY72eZ+8LvM6UJ1Z1Pnd9PYEdSX+EvD5S3aL5SDNpC6AsfjM4ewFtLAkatF/zqE
 ioRtjZBhw0TNt0Hlv1g3NA4cQ4SI3RUsrvQyNWzrGO8nUfi787Mt1M6gea8nqhWNlcIk
 xuOL/eKnp0U0o73PRYcC7ZkRIY65sTyvR7IoqtthTJy742riP5uixL2Q5L/iLVcwDLXx
 AkEg==
X-Gm-Message-State: AOJu0YzEMkKFEQV0VBDTeydKGqIm3wzsljs0MwpMnog1429qpo9p5Hj+
 8RhEGTgukZFx0dO6xi0tKBBlhj5mLsoP6voujVmtWOYDo42Zl0IFmlWagMaCgXDsVlrI1/5lWxz
 CytJbQ7QdEhCQYOJH6Oe2ZNiteesBmmIBeA==
X-Gm-Gg: ASbGnctsZMkGbpfUaIwZ6EtIKbeRmUprHop2/sm+Jbws3HI18VfT4a1md25kQFiIi5Q
 lBIrAra5GX4xI/Z9Ci+UCPQxx5KjlJaVggwTnoHTwmcbXYq3JgBpRUWueNQH2arfXWnnO0Aq/OE
 3EUg0cMQvlCh082ESa+UwxJQsXf4KRjh1+gi/flpQAeLkycp/DdvMUjro=
X-Google-Smtp-Source: AGHT+IHug4tMdhEoEUBGqRIwP0kMwpc/Oa/wRcrcStOTt7NNnn0gOHt+sGxE6wufN5+2wuJc0YdHAVJZxh5mAlSmzF4=
X-Received: by 2002:a17:90b:268a:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31425ae4ce3mr2039509a91.3.1750172869676; Tue, 17 Jun 2025
 08:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-2-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:07:37 -0400
X-Gm-Features: AX0GCFvED_jHFcOknmLFLDydLWO2ItaFmczVVTe38dswTouWYHX72Qt-qhWREVU
Message-ID: <CADnq5_NwgY4QgEMpifQdd717FJWvo1RcvZ+RDBHF_aapeXsDLQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] drm/amdgpu: validate unmap status for destroying
 userq
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Tue, Jun 17, 2025 at 4:56=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Before destroying the userq buffer object, it requires validating
> the userq unmap status and ensuring the userq is unmapped from
> hardware.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f67969312c39..e3cebe532c7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +       /*TODO: It requires a reset for unmap error*/
> +       if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> +               drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a =
HW mapping userq\n");
> +               r =3D -ETIMEDOUT;
> +       }
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
>
> --
> 2.34.1
>
