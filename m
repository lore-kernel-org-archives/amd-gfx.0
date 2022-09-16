Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3943AECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 18:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8F810E033;
	Fri, 16 Sep 2022 18:01:39 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A2C10E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 18:01:35 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1278624b7c4so53227577fac.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=zU26+7AuR5NuD1n3irMnYOV+6WAW5kM0KCEMFQYrJtE=;
 b=DOnDM8QObHO+Oh38qtGiU3nWTReNEt0I+rA1xYr+kHYiQUPF3SY7/LIiw4e3xO828u
 f1gq5AhrMOygnkltTTZLF9DIxypAGDV9JvYnyNrIrEptCj0kfDltllS/fcpwWDYI/8aN
 rODQ7NX+VFisPhjwpIGJok/FwcGY6SlCK3PLXtFYvLoCCXRRlqxwHJ/9rnQSKbEtL80b
 2j+JHGf4o1XNjSNxMm+ER1VbR0t2CtzbB7kjrvgrsNjtWIDpCIN4ZiNh6hh94kZdXbwA
 bQOberDiy+WlvIHehOKeVyamR9KHBR8LFcJB1ZDptpneb3rKrGGsLtVRphwbnOke6cBK
 fYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=zU26+7AuR5NuD1n3irMnYOV+6WAW5kM0KCEMFQYrJtE=;
 b=Jf2hEMqAxTq/BEpV6IJ0Zn8x7nBmSSzLZrQTUQXV2khdlgRBJF2DyU3zdkhePGjOu1
 eZczxfzkBp6+LxU005jCkPz26g/d/PXAdJN0ED27AG1VF7AjjAa2aYphZTAswC5lrAIn
 9/XHuexoLZl3gYyyI4nPFSfShWo3gXxqj5S+Uyqo7TIFlVukStJHa+Dp8N/z383oXL3+
 g9NHOZZUUeh/CgfjB+ohSDQp6ypl38evNQpaRuTP9Wc5q7/EseJxfFeVtJwSn4rf2eXi
 b5TW/tdQHDuE6QiHYFZDVGyJYAccHFBFYneVp+jZszXn6NgquHdL5OIipz5MFZht/RJM
 s0Og==
X-Gm-Message-State: ACgBeo1vOMZ74Uta05MsUWJeCjQawsqoEEhEtIWuiG9qcX+VD574h/c5
 Sx6Q4rJ8Ys7SG8/MnCxkDg+j0/ku3cax0pkk42u2onPK
X-Google-Smtp-Source: AA6agR51ESJr8Je5ro0zotAm3LJh+XNKXOEQZ1rlJZqFhW1NrOxPJZU7I8O+ilol5h+W9fzpqcqOL/YCZuJkGG0yfFQ=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr9782824oae.46.1663351295015; Fri, 16 Sep
 2022 11:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090845.3336-1-christian.koenig@amd.com>
 <20220916090845.3336-4-christian.koenig@amd.com>
In-Reply-To: <20220916090845.3336-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Sep 2022 14:01:23 -0400
Message-ID: <CADnq5_N=AGMh+pBp+YRw+bNm459ub9Nv5t5SYd_Pk3wPbMDdHw@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: fix user fence CS check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 16, 2022 at 5:09 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> An offset of zero is valid, check if the BO is present or not.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Since this is a bug fix, should we make the first patch in the series?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 5c37dde97ff2..265ed2118a80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -313,7 +313,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>
>         ring =3D to_amdgpu_ring(entity->rq->sched);
>         /* MM engine doesn't support user fences */
> -       if (p->job->uf_addr && ring->funcs->no_user_fence)
> +       if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
>                 return -EINVAL;
>
>         if (chunk_ib->ip_type =3D=3D AMDGPU_HW_IP_GFX &&
> --
> 2.25.1
>
