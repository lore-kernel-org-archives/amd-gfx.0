Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5FC3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 14:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC97310E4F7;
	Tue, 20 May 2025 14:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQOUhcBq";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FE810E4D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 14:17:43 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-232219cc6d0so1719355ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747750663; x=1748355463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ct4i54MihRGvrC8Hc55tJWOJSOAHedNFPupJLUumef0=;
 b=fQOUhcBqilWltxDu60IKFjLu7SJUENhI+AMfK37ofK0hGe1f6BCuPWpr9p30rm0tyw
 +icKg8NfznMGiTqo7WAuS6tPoi/CT9kMCJtX1V2DaN0CPFI87TjwV8Nyc033Ls/udXbP
 8N/+EvsVQ7pN7uBLtjbbX5kzozoWjh9igSTnQK+8JfKTGoLFYiFmiWKABP8JobMAvYB7
 slQR/N7cdAZb8BxYVt7Hhm8gUrM9t/+OKgXiXaNeIIF5z9rEm/QKF2ZOH/5t9BUG0cIY
 rmlwiDq9FuxQS4V+yvY9n+aSSYy9+KWBMxWdFr8ZgQta/dfGBkxy0ChT7o2yWkRWaMNj
 OHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750663; x=1748355463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ct4i54MihRGvrC8Hc55tJWOJSOAHedNFPupJLUumef0=;
 b=n86HO42XDAoU2+uRH2tGwvE3/i4mmfNL1fmHfSL+SBxbT6wipzK/m0wUa4sOPh4jQm
 DiGOkjEcSlH7HDkY3yZaSyUAnngn269fVIrI3zRDl+Dan2xPNQ3BykAreCbsfa1zE1Kz
 zc38d9Kn2VcXF6YNNs3STQg/YmGFEJRcFalZFllR60V0fIgyE4ygdN+yprMTMGM4hLMN
 eRsrrCYf2sytln/a3eAjzLjm9vUjv5FZQr5jbvvYoIl5DJeCRK/T/V1tfUcs3mHEvM1v
 m2pidEzrRf1hba/TCoFG0YtvQLWeRbA+W4E40P+EOVLi8yvNGhipuHDRmvqJIkEelo4X
 7ARg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDnza2kbAvxDH1gHrVvaOY5fwyojiFD0/fABz0NY0AA9LwdGhejCOiZTsvqOD8RTpcPlbCwTt7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZfoIijbAlPv3uZOvPMi5Yw7vVLt/IrfvQDOSW8ISmdUpBZqfR
 xlxqFeG76tGdk06i7HeTCtx5BakLNn/mcYmNHN0Dxt1dRsy+RkSKtfGo6ijZt16cXLacuAEsMhd
 tE00j1u1tDoT8dGl/jqOpUY5pnBVXa4w=
X-Gm-Gg: ASbGnctJ3g0lz8/gVqk14TzgGH3eATifXgLrRWCO0jnTLv8sHQDRhVjmEg61rIXQMAr
 gaZm0H9G/SkfNL0lSi+zsQzPQ4i5d4wOchUicMDusKuu/UOlQPyMz7CexpxMLxai01VIbA5KbUz
 Wj6jgD/TOtXiZ8eFW3zrAoSkO2VfooKC7tkY03l1+/zqvp
X-Google-Smtp-Source: AGHT+IGISr1XHlZrGQeTvxhJcyDhYpa1oT9gYBopiu973bgCccmx+VpiLm/HggSfjg+82gmDlbT48yL1SMI8Fd6tihA=
X-Received: by 2002:a17:902:c951:b0:21f:356:758f with SMTP id
 d9443c01a7336-231d438823amr93024885ad.3.1747750662676; Tue, 20 May 2025
 07:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
 <20250519163713.11367-3-tvrtko.ursulin@igalia.com>
 <7263bff2-737d-47c2-8426-02a07177ef8f@amd.com>
In-Reply-To: <7263bff2-737d-47c2-8426-02a07177ef8f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 May 2025 10:17:30 -0400
X-Gm-Features: AX0GCFuZMinHjV0-LqLpUzRudeTK0xIkbzTCTGBQAFdSALW3Nc6sitxAQZnuI7U
Message-ID: <CADnq5_PRgPyjuYpLd8_9aBCS66v6NmgupY3p2w366+8MyCPQog@mail.gmail.com>
Subject: Re: [RFC 2/3] drm/amdgpu: Remove duplicated "context still alive"
 check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>
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

Applied patches 1 and 2.

Alex

On Tue, May 20, 2025 at 3:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/25 18:37, Tvrtko Ursulin wrote:
> > When amdgpu_ctx_mgr_fini() calls amdgpu_ctx_mgr_entity_fini() it contai=
ns
> > the exact same "context still alive" check as it will do next. Remove t=
he
> > duplicated copy.
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I think we could also completely remove this check from both places.
>
> IIRC it was only added because somebody suggested that CTX could potentia=
lly outlive the file descriptor.
>
> We fortunately abandoned that idea even before amdgpu went upstream.
>
> Either way this here is clearly superfluous, so feel free to add Reviewed=
-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Regards,
> Christian.
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index 4ff8552e872d..85567d0d9545 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -949,19 +949,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdg=
pu_ctx_mgr *mgr)
> >
> >  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
> >  {
> > -     struct amdgpu_ctx *ctx;
> > -     struct idr *idp;
> > -     uint32_t id;
> > -
> >       amdgpu_ctx_mgr_entity_fini(mgr);
> > -
> > -     idp =3D &mgr->ctx_handles;
> > -
> > -     idr_for_each_entry(idp, ctx, id) {
> > -             if (kref_put(&ctx->refcount, amdgpu_ctx_fini) !=3D 1)
> > -                     DRM_ERROR("ctx %p is still alive\n", ctx);
> > -     }
> > -
> >       idr_destroy(&mgr->ctx_handles);
> >       mutex_destroy(&mgr->lock);
> >  }
>
