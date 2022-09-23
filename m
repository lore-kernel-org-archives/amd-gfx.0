Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBA0ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D044010EAAA;
	Fri, 23 Sep 2022 13:25:11 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D796910E325
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 05:28:18 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 f20-20020a9d7b54000000b006574e21f1b6so7629282oto.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=6YBiavs8EyW6TBouIq+iMjGF8mAeQEQaSZGm2AdiKPs=;
 b=CZxccXxMFhsSc3RTh1iIeLkvlDj9MAWPuoQfvYGRYmJrQrN6+7XGqFGXlZvL7KqgsA
 mc88ZyJrSuLEHmSmmObCKx6EXdXgRk3/ZpbPfaad1XEQ5+BhNjxm0+5eZ3I9uSxG8NUA
 vwnzO+8LsPkTJ7JFUTNuscq+EReBqindfPAo0UBkuKDCeECOh4CaVYhZfKXZR8xwwbkw
 8592xALmke2DxJaEYvc5931ZAu/7u8GBnIaLQK2mEvd2lqDsqpwUnhnwAzLEN36lEUtP
 IojjDOe69N12yESIegKv4T7bMe5TMT35nc6xngAab/+zb6iLzoHiWrWkIHaKzU3kP1gb
 17ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=6YBiavs8EyW6TBouIq+iMjGF8mAeQEQaSZGm2AdiKPs=;
 b=gzXbRpFGbAGETZpb2hYH5i3MjP9I39BhVFYRLTlBocQVg+NUb8RAszC7b4gKRBrdL1
 ZUCRFlqFKcRZeCdpfqBUlb8h+y2pWDcj1IIQXQORnhsPZqFq8JOfJgEK7XUAyU46r+QC
 V/ZrhU9777cuZ/SzbRGnf5FRleL4p7EJbY/azmXkoHIJpD2Bs9p6eb6MZSBW9tqGU6aL
 i/nwXonTtmC5XzsP3Y1o6IqxXyevaCQpZJGHw2HyidQMwss/oNvaz7SMXc22T0tbKZw4
 KejPq7aavAYOjFqOGMdu1MYlzPZ3PlA0aB9Oq97nSVSjdyF6oxLnxa5CbKX7doqV1VqV
 91og==
X-Gm-Message-State: ACrzQf3PLN9no0sW4hlYSUBJZzPw+11D4V4cDMrS8nsEoSsNyA66bgH6
 y2ozkKOcewFeMpA1rb6tWmHLkzpn9r2dboV1JrDWG0wu
X-Google-Smtp-Source: AMsMyM7TK2BfaekC1OT2NPuxh61w9OCVmiz/Cq/gHHtKvgIpA4EZhOzJlfZUmDmt1h8YFhU8Hyn3gBIr5lLXjaf6nso=
X-Received: by 2002:a9d:76d1:0:b0:655:e46e:3c07 with SMTP id
 p17-20020a9d76d1000000b00655e46e3c07mr3214241otl.194.1663910897762; Thu, 22
 Sep 2022 22:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922230452.3903316-1-ytht.net@gmail.com>
 <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
In-Reply-To: <7526e4ba-1022-d921-9138-257c369cc172@amd.com>
From: lepton <ytht.net@gmail.com>
Date: Thu, 22 Sep 2022 22:28:06 -0700
Message-ID: <CALqoU4y-3dWJ-gR8RxUFry9KpT+FMNDfb4WmvEoK5bc56ueUvw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Always align dumb buffer at PAGE_SIZE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 23 Sep 2022 13:25:06 +0000
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
Cc: marek.olsak@amd.com, amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 22, 2022 at 10:14 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.09.22 um 01:04 schrieb Lepton Wu:
> > Since size has been aligned to PAGE_SIZE already, just align it
> > to PAGE_SIZE so later the buffer can be used as a texture in mesa
> > after https://cgit.freedesktop.org/mesa/mesa/commit/?id=3Df7a4051b8
> > Otherwise, si_texture_create_object will fail at line
> > "buf->alignment < tex->surface.alignment"
>
> I don't think that those Mesa checks are a good idea in the first place.
>
> The alignment value is often specified as zero when it doesn't matter
> because the minimum alignment can never be less than the page size.
Are you suggesting to change those mesa checks? While that can be
done, I still think a kernel side "fix" is still
useful since it doesn't hurt while can fix issues for some versions of mesa=
.
>
> Christian.
>
> >
> > Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 8ef31d687ef3b..8dca0c920d3ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -928,7 +928,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_p=
riv,
> >       args->size =3D ALIGN(args->size, PAGE_SIZE);
> >       domain =3D amdgpu_bo_get_preferred_domain(adev,
> >                               amdgpu_display_supported_domains(adev, fl=
ags));
> > -     r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, flags=
,
> > +     r =3D amdgpu_gem_object_create(adev, args->size, PAGE_SIZE, domai=
n, flags,
> >                                    ttm_bo_type_device, NULL, &gobj);
> >       if (r)
> >               return -ENOMEM;
>
