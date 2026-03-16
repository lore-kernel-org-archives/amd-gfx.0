Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9126F53D89
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504FA10E3D5;
	Mon, 16 Mar 2026 18:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AptlTA7O";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243FB10E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:43:56 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12711867ca1so272546c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 11:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773686635; cv=none;
 d=google.com; s=arc-20240605;
 b=jmx/PF72kXfewIgNCnjddmVUrXO5Xf+zKu/MkxJiwzFObnBCFY+MIZo0VRqvO/x5U7
 DEfSYRCjtA1gUg6eLLs8dinbKzARkvoWqRNWKZ1bbmXqGuKFAarUJz4ZE3pZaStL4vy+
 Ei4bv6m4IvfV0AYXFEIcxZtUbWE8wEnDEZH0xiVVKLEgqM7n6lB3njRdPK/RjUkalyor
 2+sUmKeONScU45TCS9/8eTlU2alALN5taZWJxed4reljc/bKZeMGhfeZgQVIPiGTvBlH
 6joI98Fd//xFJfGN07qgZ8xed78Skq3S18OkMjN420n8F2RVvjChyNJRFoAOaZEh59k7
 1L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1ZJuTb69rHIFFeqyVBQKuoJT6pOI46NxjIf7BaF80IE=;
 fh=CIPVKK/XXaV0vkdzT56NRKtgLySLvQR3vL4PFUhktmc=;
 b=Z+fqAYVJAhzIZP+pxcXY/ZeSBzhLzjB9rrr4M5yvmPmMcI9JBCDeVB75qR4wFtFwXc
 ASc5lQRsIp844luygc0fWmMbXC9c7o40Ned5uK31M0HHSFJhCwXHsmlBpPGF1kkdKOfj
 Y5GChUIAKdjc1/I5ggy4lpDoN7XBYoDyVS29Tq67DJy+bFNpjdMKCdGOEpP1mxvVNI+F
 0CXhRiewgKWwMbx2IECYrUIThaNWFu8lWIIDX7Zn6Ye90T5JhnrJvut7DapDcr1fYv+T
 M/PnSDrP0uNIyHiN7DP3HcQTi3k4z8bs5GMTrwiacCz9MzNqPsnNrMYMsXn063mSqPdi
 Aa0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773686635; x=1774291435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZJuTb69rHIFFeqyVBQKuoJT6pOI46NxjIf7BaF80IE=;
 b=AptlTA7OC7Rz0riO6qdVgUiU7oHhr401SqMxqLiwLIW0nEhcqMgHtI+lVY9vfpViVm
 dQz1c7tDdmdWRzSwYlEMohdJJlx2zydVDIf9lNPL4/ZwXhj9xKZBwhp1PaZhzEWFw/Yk
 J/B8adXXHqVr0TZAnPq5ovrRIihDRRT41iVwQIghJrIwZ2sRkIHB3qMhoLT+PC8A1LtR
 jNo8pqNEOnCNj8lZpdfWX8cDJPJvRGRC2xnnazSrVv2dx9+vEqb5w8ILJw4M3wJjRztg
 QdsaGCLqon35PWCNK+68oeYpxb2ULfTpD3Nej2UrIUN53mvcZEJu/KVDr8wFhgNQ1jDc
 PbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686635; x=1774291435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ZJuTb69rHIFFeqyVBQKuoJT6pOI46NxjIf7BaF80IE=;
 b=LFb6TmRFb+V4i1pmj+gcfaBu73YO2RwP/9tJZjW5b2wv5W3fXHxOEpMT+sRcnKyjF4
 G7Q5BVzTAhNjCVXWFrSw7z5JsY3KIHmPFHHY9LIsOKfjYbZeEmdd5UIRVYJ9QLHz/FGG
 NMn+xIuo4RqER/kjkvZeoYj3Vz4SZ+w2sAxNiNBr2cJiQsZcclubh4TyKv9/gtPS5+ke
 zRI/i0QVAlWV4FM5m7coL1dEl6lSxVSTxL3SZ6vrkYqfHnVdfsFyXqUwX1rOAEcR+50A
 0nd9Dn016CAYkMBI9JUcrLbaKBxWQTxianfbhHbN1FRM6yjw1AM0uc0/GOP6ro2n308/
 BWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYFVbFYoWJLa3NuA2lurxcEbQsnwqi0xxV1MSqA7E4V56czsWr7U3g3QKtRaxaySAVFpwi2VS9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7NIhH+v1TSHpl8SrB2uLGGCBz2h1Fy8xQzm27PJJ9+hKdt8UQ
 yI26PRxwStoyG/iyRkQ4C9OswTUTZCnfN+YK4MOMMZRAnJY7IuMhF/y/iV0V7PqF67JbJEsgXO2
 KLsdwcDRUZWKM+UVCZ9FHHV8+7brJsLfkJlOc
X-Gm-Gg: ATEYQzzvn13isIFxcOSlUIDMuG/LL4UD5D1mvTKQkZcTultLXaMfCCiLmV0Wx/8pzii
 N6k8rF6uad0QkY7VmJvjPqOzYGAZ5bLvM95cSHGG9WpquK1vV8dxRtPIlZ5ey9Rq43DlWLdMkkQ
 WPmSgIx72QGzQ6qJqaUzjBO0QcChjWqseE3kneQ3GYSxL/3yoVAIzlZdHPJkDe1lOYPly3vtbjO
 kSB6Cmt3YcOUWy5R+5ZJzveoRD/06wnTWWP5og2UE+50OVKPnpU+qCR+yID6cVZxiT+nhUj8DxC
 IOkQuxgbAK80pa+yzmENGl/1RSdHBDreEUtnfqxER3GveYPgYl3s0i+xZj4tmmQlm5xrTg==
X-Received: by 2002:a05:701b:2409:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-128f3c76c36mr2354488c88.0.1773686635168; Mon, 16 Mar 2026
 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
 <20260316181648.2005897-6-alexander.deucher@amd.com>
 <31a902f1-ae05-40ca-b2ba-c08dbb2bf827@amd.com>
In-Reply-To: <31a902f1-ae05-40ca-b2ba-c08dbb2bf827@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 14:43:43 -0400
X-Gm-Features: AaiRm50NW0_CZIfWeTA6wbXR9kDl9hhZhvazeg_VEWcu2fpqPQwl27zWgxTlUtA
Message-ID: <CADnq5_M8rZ7D7DN5N0phzL=jOG9ZWBD8Ei0H8+RzfR4ZCdeRJQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/cs: return -ETIME for guilty contexts
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Jesse Zhang <jesse.zhang@amd.com>
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

On Mon, Mar 16, 2026 at 2:34=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 3/16/26 19:16, Alex Deucher wrote:
> > Return -ETIME rather than -ECANCELED for guilty contexts.
> > Userspace only considers contexts to be guilty if they
> > return -ETIME.  Returning -ECANCELED means the context was
> > innocent.
> >
> > Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 53e2eec734b1a..06dfe01492616 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p,
> >
> >       if (atomic_read(&p->ctx->guilty)) {
> >               amdgpu_ctx_put(p->ctx);
> > -             return -ECANCELED;
> > +             return -ETIME;
>
> I think we should rather stop using p->ctx->guilty at all.
>
> This is just completely unnecessary churn. The per entity handling alread=
y correctly returns -ECANCELED or -ETIME depending on the fence error.
>

Which entity handling?  We still need something for amdgpu_ctx_query2().

Alex

> Regards,
> Christian.
>
> >       }
> >
> >       amdgpu_sync_create(&p->sync);
>
