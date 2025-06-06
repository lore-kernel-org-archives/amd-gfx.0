Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBECC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 16:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093D410E083;
	Fri,  6 Jun 2025 16:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kakuG6f7";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B3810E083
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 16:56:08 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-313336f8438so236263a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749228968; x=1749833768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWQTBqnXQChd6izF/vZkPKMVlxicsgk2xBPUKKAiTyY=;
 b=kakuG6f7PXDjv93TtU9JYErGzt2xPpCWUAeMScm5Uqq526H9yORUJQZfkcJsHv+i0N
 tReo8NPouOD0WBtnfTKjbHUXLNr+LeoC5CNHS4lPvCFR9LHWMOkElG+mMvnijoBy8h5r
 RC4OOMnXGa9XGVLLSn+TjMXzUxC5yTb9ssjqFT16ecagyXlppb+Ygyl1F5sMqhAjUIvW
 HObXwBdZEu91JCIZZMwF0vuMiF4cj7CFe1bYrxrklmrBildcwtZtt8TKq7EPA3OBSzBa
 gmf43xd1T66cC0z3nH8Bl+A0czoEw8bA2n5S+X5gDnAU4N5Fu0PMItRnWiAZwMSLEfzk
 wSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228968; x=1749833768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWQTBqnXQChd6izF/vZkPKMVlxicsgk2xBPUKKAiTyY=;
 b=JIoaMAoUVy8g1E818ICOfTlSGdXdEHyPynbpLuI2EtpWnTAKaEm4JyPTG+T0G39tUW
 OrIqeqsikTg6uAt+yT+4iQDfMcTZunlpCrF8BZ+I7qTRc0VUo0ZCUcxzck5FNfO93dSZ
 HtHEpVMQs2Q4D78S26GwBxzE0GKhbVaOVpbanZpqHuGb3JeY8ew4VXaJE46HS9x8xQct
 Uj2Dp3X9qqHqaJ1wTHclYK6Z3atb6sAjiCc6jQWXjoxFsLyKPpPsSQn0f4b8pJi87zbX
 Z9SazVyeNPAgTMsg2JVR/NboPTDdDTpM/56sYqKsaYv4M2UgZO3LApmGKdw5zDJi6IVS
 0Seg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt44mR18chGGqEtJwjVUn3HQ8ImTkd/kTm6pj+r7mpy7RfWzCMW7iSlvbJnF0fj999P/GPdMCh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2OIvelkMq+0omaPTD6kVR5hrDld+M8WDIAcxOo05rKB/Nvdbc
 YczpE6C1p8HPwhVLa4fuE7OikZBYN/RKA5PMyqOqsdsRroqQerYeJ8/Sntry5dcjn2jIpe0xlA+
 e4FDLLgt0aEw6il+B/LocaR3ygGCLk4kiUQ==
X-Gm-Gg: ASbGncvkgTwH6t0O98j8drhPeztLvr3NF57cEGKWfPgJZklxcfghxL5DXjkTphldaQD
 7nN74IZ2GqFyTJzZ9UAa6STP+fU1qaz+hl/1q4OZL8zR26gMVDsCd96B182ivEHUvKsf9hdlSZe
 Z5R+vzGZ6FYtEOvArbOI1bQgKxFnBzPXtQhKYCMhsxRSgAqDnwcnDA/ME=
X-Google-Smtp-Source: AGHT+IGoMIYGIMxgAzBfBkVhQeyHLjGQRBEyO0IJ/kP5ZufzzUQxxL27eQPXxx2gFuSQaW4YIz0DzRlhNnBNj2FmlZE=
X-Received: by 2002:a17:90b:3a82:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-3134e3e72eemr1556597a91.4.1749228967613; Fri, 06 Jun 2025
 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250603091154.3472646-1-Emily.Deng@amd.com>
 <becc0fd4-cb6f-49b5-8197-a755d3c5a359@amd.com>
In-Reply-To: <becc0fd4-cb6f-49b5-8197-a755d3c5a359@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Jun 2025 12:55:55 -0400
X-Gm-Features: AX0GCFu4Z3y7EDIfgfuaF-7UiUNABqMZVn11qVbGthVSkEl9TWXHGNbuSeWa5rM
Message-ID: <CADnq5_O5-1GT=xoOQCdnkg4k9v27g3sOOonf5ghqR5hiLEtnyA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/ttm: Should to return the evict error
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Jun 4, 2025 at 5:06=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 6/3/25 11:11, Emily Deng wrote:
> > For the evict fail case, the evict error should be returned.
> >
> > v2: Consider ENOENT case.
> >
> > v3: Abort directly when the eviction failed for some reason (except for=
 -ENOENT)
> >  and not wait for the move to finish
> >
> > Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Did you push this to drm-misc?

Alex

>
> > ---
> >  drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/t=
tm_resource.c
> > index 7e5a60c55813..bb84528276cd 100644
> > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> > @@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_devic=
e *bdev,
> >               cond_resched();
> >       } while (!ret);
> >
> > +     if (ret && ret !=3D -ENOENT)
> > +             return ret;
> > +
> >       spin_lock(&man->move_lock);
> >       fence =3D dma_fence_get(man->move);
> >       spin_unlock(&man->move_lock);
>
