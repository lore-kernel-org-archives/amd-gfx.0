Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB0AC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA4110E51F;
	Mon, 24 Apr 2023 15:01:50 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E4E10E51F;
 Mon, 24 Apr 2023 15:01:48 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-541eee15ef5so2762251eaf.1; 
 Mon, 24 Apr 2023 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682348507; x=1684940507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmLuhgTYqL7Xf1ZepLBDAcM7hZYQ8z1fOMJDQ+E6+Q0=;
 b=mYAIPmZK2HzigLPQnMKqFBzHiCRJzh7PWtt5JMNeP8zkDk0iStFDPcONj7vM6KhEyL
 HCyZZsMG2eE8JfrqiYm+J9IhyJWUR7aXjTnN4HZ810PynVIwAcAFrd6lhQOd9YiKku9E
 GB6WUNx7pr5xOZv5DRXezmkCvghwLh3A2aCQ8cM/rF/b8mWPyuASArcorF3r5Nb9jTmQ
 YS9bijCxrJ0HHv2FslnHzofstv7Oa7DbKr1fqrQ14huqZss3Es3iID0hjCuS+qjBonvK
 NkfPV7rH+J+RdlGt4GuFfPnK5JwHQSEPbsW72audoadCmG6thCBjQ03Zk+IwC9oKZhWL
 UzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682348507; x=1684940507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmLuhgTYqL7Xf1ZepLBDAcM7hZYQ8z1fOMJDQ+E6+Q0=;
 b=lt7cBVNq1kbuYs1UG16yZ+KcxxpLYHtA+5hKQkQxmFTMUjaDmBfQXdEdavNvEJSmnE
 k2DEKCCFrqZyE83ozhptB4e6O9rjU6adNK9+ZzTljrLoPYXyVi9o2Q7WwmO2pITAOOQq
 v2gDPOVsQdiEtO2aRpqhzzg55KZ30tBQUdc2DTpcAQyhCwC1q4pycee2xMXQXjEBcSjJ
 N+0qLwEJ+/1vAEZDoDYVEp0+lKQmP8HfJo+RT2OM783ojImKRR1z3EhRfBtjk2qnmYuq
 /xGWgrw4Jg0SeVINeXpmvv9P3ahsLw6aDK/QBpN8/5YWY/ihkTa/w/r3NomsfyRADF5G
 +jpw==
X-Gm-Message-State: AAQBX9d1JP1/lvGk1oVhBp8c0sTdVvfOqgk38f2N6t9/Rsv6tZRfQrun
 51zEf/F7CDEjgrh+TGieK/Hmn3hw/s7lOJHJo9E=
X-Google-Smtp-Source: AKy350bvySqFfk+PN5/1/SUO2+TYGz4oCIBT7UtP95XTbp0gi4oyh+p1bcsbgrNCQzfiJIm7L2v9LQ1nM5oR6v7S8qo=
X-Received: by 2002:a4a:a3c3:0:b0:547:7574:b89a with SMTP id
 t3-20020a4aa3c3000000b005477574b89amr3806308ool.1.1682348507067; Mon, 24 Apr
 2023 08:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055910.15683-1-sukrut.bellary@linux.com>
 <ecc972c1-cf7d-cd99-805b-38dbf04adc79@amd.com>
In-Reply-To: <ecc972c1-cf7d-cd99-805b-38dbf04adc79@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Apr 2023 11:01:35 -0400
Message-ID: <CADnq5_OmRnsKkCE2OVcp-6kYww92-DKybg0=hM1tO-GaUAGLEw@mail.gmail.com>
Subject: Re: [PATCH] drm:amd:amdgpu: Fix missing bo unlock in failure path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: linaro-mm-sig@lists.linaro.org, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Julia.Lawall@inria.fr, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 alexander.deucher@amd.com, linux-media@vger.kernel.org, airlied@gmail.com,
 sumit.semwal@linaro.org, Sukrut Bellary <sukrut.bellary@linux.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 3:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.04.23 um 07:59 schrieb Sukrut Bellary:
> > smatch warning - inconsistent handling of buffer object reserve
> > and unreserve.
> >
> > Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
>
> For now that patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.

Applied.  Thanks.

>
> But for the record mapping/unmapping the MQD like this is a very bad
> idea in the first place.
>
> We could need to shuffle memory around for that during resume and that
> is not something we really want to do.

We should probably just keep the MQDs mapped.  On suspend we need to
save out the MQD state so it can be restored on resume when the MQDs
are in vram.

Alex

>
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index 278416acf060..5de44d7e92de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4686,8 +4686,10 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_dev=
ice *adev)
> >               return r;
> >
> >       r =3D amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
> > -     if (unlikely(r !=3D 0))
> > +     if (unlikely(r !=3D 0)) {
> > +             amdgpu_bo_unreserve(ring->mqd_obj);
> >               return r;
> > +     }
> >
> >       gfx_v8_0_kiq_init_queue(ring);
> >       amdgpu_bo_kunmap(ring->mqd_obj);
>
