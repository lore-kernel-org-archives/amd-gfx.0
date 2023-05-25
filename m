Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123EFC7EE29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 18:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2F610E72B;
	Thu, 25 May 2023 18:02:00 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9F510E0BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 17:09:22 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6237c957c5aso5851996d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685034561; x=1687626561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfujOA2A6hf65ZBmor9A5NjncmlddgUps/gM/fGPmmw=;
 b=u5JVWmnm+syyUkpME6Rsqvob45yWWUQsGfJKmU/pXAKrwQZl+T9k8XmCLTHKpxsx33
 Ul9rgymUGpn8o2QPq77XwJNueYkRMeCjvwfT9RcbdDHHtD259aGr3k0ZMr1ZlfRpTJT7
 673/FJYWxi0dEX9d9pJtUF8Vad8lAGBgMvg0UsyRKO+e3L4Tlxnb5W9K0htP9LZwf5N+
 3ko7w0kQ2cw3iI2JEKhOR7KACW9rvsqgnwUALVFjCvJUj517CUfk6/TP9Wol2HM2jAxI
 uUpRJlPyEopXZ1qKYTHAs6kcK0LMLHaBTu7IxGOgKaTd4J+kgAxv7m0tNRBEO1NXq3M/
 f4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685034561; x=1687626561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfujOA2A6hf65ZBmor9A5NjncmlddgUps/gM/fGPmmw=;
 b=KSzlpqev9CKP+9c/4Sm5cmupCx+y+Gqk1bv76tn+fxD3f8pwy7WuoBlS3GDWRwIVqy
 7mir04EdXwB95EEVy4mu4Y08cfUC3rRxDVs3qiwqSto5q/1g5Wabt94JE2y1MEnIQGKX
 6P+woA9mld5AhnFXjd+k3qNwuTcokT6etdDi0blhK6kWF1GHD6bmcKQ50H1xfoPbhXdz
 UU1Wrv3cJkAIp6bLtwYccbemD7mfWA266sRjRh9LhKjekfVlTOI7BSoy/HwA3t1bwt1q
 IH4P/4Wa/T8fQIvsm1sivbDXvYEWULGM5Asmx8JwGTtqSyEQwe7iH2nEByOJqurDMkQX
 KL/w==
X-Gm-Message-State: AC+VfDxtslOVfsf19aeU6+4wJnlSjqWdJg7G6lqTbcjlIYAz2fsHzfJ/
 R9A/Rj/bNx/xNjxK7K5393QnA8n31pg8xAOIK73n4Q==
X-Google-Smtp-Source: ACHHUZ52CNu/Tjq79XCrD2JlDivOqzgbcFUCBV3XBgtDyaC3DaWMMVwQJMD2wHZ3Rqd1sfXTIh+ACcfD8lPZjGD6rOw=
X-Received: by 2002:a05:6214:5089:b0:621:564a:27a0 with SMTP id
 kk9-20020a056214508900b00621564a27a0mr1961807qvb.34.1685034561279; Thu, 25
 May 2023 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230519124438.365184-1-srinivasan.shanmugam@amd.com>
 <20230525152247.GA187374@dev-arch.thelio-3990X>
 <c25b9e4b-535e-801b-12c3-8d4415c321ff@amd.com>
 <20230525162911.GA552113@dev-arch.thelio-3990X>
 <CADnq5_Ndax1krkonfeBt4=iW5Kfh-nW+M_UhqVJV9gUQC2JEBw@mail.gmail.com>
In-Reply-To: <CADnq5_Ndax1krkonfeBt4=iW5Kfh-nW+M_UhqVJV9gUQC2JEBw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 25 May 2023 10:09:10 -0700
Message-ID: <CAKwvOdkb0QtVKTOZXNp6n74XwqTmoT4aHRaEfpvfNd5ja9aNJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Mark mmhub_v1_8_mmea_err_status_reg as
 __maybe_unused
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 May 2023 18:01:58 +0000
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
Cc: llvm@lists.linux.dev, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 9:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, May 25, 2023 at 12:29=E2=80=AFPM Nathan Chancellor <nathan@kernel=
.org> wrote:
> >
> > On Thu, May 25, 2023 at 12:26:56PM -0400, Luben Tuikov wrote:
> > > On 2023-05-25 11:22, Nathan Chancellor wrote:
> > > > On Fri, May 19, 2023 at 06:14:38PM +0530, Srinivasan Shanmugam wrot=
e:
> > > >> Silencing the compiler from below compilation error:
> > > >>
> > > >> drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'm=
mhub_v1_8_mmea_err_status_reg' is not needed and will not be emitted [-Werr=
or,-Wunneeded-internal-declaration]
> > > >> static const uint32_t mmhub_v1_8_mmea_err_status_reg[] =3D {
> > > >>                       ^
> > > >> 1 error generated.
> > > >>
> > > >> Mark the variable as __maybe_unused to make it clear to clang that=
 this
> > > >> is expected, so there is no more warning.
> > > >>
> > > >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > >> Cc: Lijo Lazar <lijo.lazar@amd.com>
> > > >> Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > >> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > > >
> > > > Traditionally, this attribute would go between the [] and =3D, but =
that is
> > > > a nit. Can someone please pick this up to unblock our builds on -ne=
xt?
> > > >
> > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > I'll pick this up, fix it, and submit to amd-staging-drm-next.
> >
> > Thanks a lot :)
> >
> > > Which -next are you referring to, Nathan?
> >
> > linux-next, this warning breaks the build when -Werror is enabled, such
> > as with allmodconfig:
> >
> > https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integrat=
ion2/builds/2QHtlCTz2JL0yXNpRB5hVmiP9lq/build.log
> >
>
> Srinivasan has already pushed it.  I'll push it out once CI has
> completed.  We are trying to figure out the best way to enable -WERROR
> in our CI system as it is almost always broken depending on what
> compiler you are using.  Also, I'm not sure fixing these is always
> better.  A lot of these warnings seem spurious and in a lot of cases
> the "fix" doesn't really improve the code, it just silences a warning.
> As one of my coworkers put it, there is a reason warnings are not
> errors.

https://www.theregister.com/2021/09/08/compromise_linux_kernel_compiler_war=
nings/

>
> Alex
>
>
> > Cheers,
> > Nathan
> >
> > > >> ---
> > > >>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu=
/drm/amd/amdgpu/mmhub_v1_8.c
> > > >> index 3648994724c2..cba087e529c0 100644
> > > >> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> > > >> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> > > >> @@ -701,6 +701,7 @@ static void mmhub_v1_8_reset_ras_error_count(s=
truct amdgpu_device *adev)
> > > >>            mmhub_v1_8_inst_reset_ras_error_count(adev, i);
> > > >>  }
> > > >>
> > > >> +__maybe_unused
> > > >>  static const uint32_t mmhub_v1_8_mmea_err_status_reg[] =3D {
> > > >>    regMMEA0_ERR_STATUS,
> > > >>    regMMEA1_ERR_STATUS,
> > > >> --
> > > >> 2.25.1
> > > >>
> > >
>


--=20
Thanks,
~Nick Desaulniers
