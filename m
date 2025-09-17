Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36DBCAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7490E10E843;
	Wed, 17 Sep 2025 14:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGYClrW3";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF04F10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:06:25 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2630354dd1aso8663235ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758117985; x=1758722785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wn0GnZkbYMfZoOSZDmNfkPmvXaZxOZ6vk7mlctbrROg=;
 b=KGYClrW3Hw1O8KkLsUh0SMNj7RXOmYG3XROr/Bo4X/DmWIhkvCUTLpwNgVwdpuQtfa
 MUQeHh/BV1qhjjeeghkMXyYtl4lTGmp67XhB3gDpkQmV8lNz1uxz5J/BI+JHlA55hiws
 hV8RcMCTeSQG/WJEv4ukmUit9bG+RMvUYMnnVAzd/M8kz+8su9Ox4hAQpBMyB3bWIdVs
 k1/aBFKNBx4k31DoZeX0QS1kII2YusrN2SlMy2QiWWgaDJKAgN2njFb5NrHTD6mAOmPr
 2fMMaKT4ZcxhkiEqV3Wob7vKxvFIOWhfMa4ZSNA8Vj0b/FX5CrbnggQbAP1HDFv1keqz
 DDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117985; x=1758722785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wn0GnZkbYMfZoOSZDmNfkPmvXaZxOZ6vk7mlctbrROg=;
 b=i2tSIdmmYpuw3mKkl01teTWXAe51BOrm60pbYLMBV8RGNsngdzaI9PQ3rPVUu50DCv
 qyUTfb2ziaXLFvnoW+20bDKC7siG4Tb94tTUPx/vP4sUv/ioidQesAPU609ekSG6e8wv
 cVta5oKXIvsYaV/Hn40i+VIl+7BF/4Ff+mg71jjTAlCHUjPp80wsFS14P6X81EdnOfZ/
 FO6Uf0ciR3QPlQS2s/Ob2oF5UzyxNlWlawElOMFKeMx4rr0pb7JftITlzna5itFTAg9/
 QhAmUCnmbYaSrI6jxkzMbrbyoYv6HwbfA7cTMdlgMzGrnJoljzrmoPzPhTPDQs1t3dGF
 Lmcw==
X-Gm-Message-State: AOJu0YyEn9yOuBhCeMXHktwIyNPVCnnWt6laerAKcgju/PR6vKdELZ/f
 YB4HsE5lMne4Zq9oK8dUO9Ul7vdCh6+TDvBmU3ck7ZlHWWqNeIrvBTsUUQjtDOdaq4RjttMcL/J
 CQHykLFswDU1sEc3DNi8qulfkAqbClfY=
X-Gm-Gg: ASbGncuZvZtdCsCh7eD2D0P8ykDEfIR66cYZJNorGSbu7ScPGsaBIqQsAjIht6W+FEQ
 bVlI7tTI+Ka7Z/j2VR7SlxtoIzbOxUSxGNJqfmE5kXrQeveYm4tZTN+KDJQCGL5n1obJLYDDlQp
 WxnCtBfh4we8oAgGMXXf0KuVkUlwFKhjrS4Az7J0pCu0mxVJZpsZfTH4xncBvznt2Sza3vb3UrM
 y8jMbHk
X-Google-Smtp-Source: AGHT+IGCkgMZgbnlXz3e9UWITwPBQAQnTK15ScEq0DojElHp5IVlSOKlrTHzYrXf8p7Ozifoyv3Emsn6hLRLZ7o/ZFk=
X-Received: by 2002:a17:902:f54d:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-268137ffd29mr18964805ad.6.1758117985004; Wed, 17 Sep 2025
 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-7-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-7-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 10:06:13 -0400
X-Gm-Features: AS18NWD9Be-0a2Xv5NOQUwPyOVc-bTHQnbEtEmff6klcQimo4nDHyO-FSNkIfqI
Message-ID: <CADnq5_OF484zYC2hxS_YNa-fKeO36VwWjYc--p0iW1s6JpacfA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] drm/amdgpu: keeping waiting userq fence infinitely
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

On Fri, Sep 12, 2025 at 1:55=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Keeping waiting the userq fence infinitely untill
> hang detection, and then suspend the hang queue and
> set the fence error.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index cdcab71248d6..957b26ca2eb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -193,7 +193,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -201,11 +201,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>         int ret;
>
>         if (f && !dma_fence_is_signaled(f)) {
> -               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               ret =3D dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIME=
OUT);
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;

Just calling out that we should fix this up once the userq reset
handling lands so we call detect and reset here.

Alex

> +                       return -ETIME;
> +               }
>         }
> +
> +       return ret;
>  }
>
>  static void
> --
> 2.34.1
>
