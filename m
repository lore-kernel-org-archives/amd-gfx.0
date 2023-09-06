Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC9EB8FB3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18E410E655;
	Wed,  6 Sep 2023 13:26:39 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCC410E655
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 13:26:38 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a9a6a7a824so490962b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694006797; x=1694611597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ls6Dol8nzkYKJhhT+Ry7ewwxhpTglxexiwUyXxZFHnY=;
 b=nUvC5Jy3HUTk5DJ4AqysPh2Lk7Oau0SkMgnrjdt1r1kmfGpyFMJP+DZ+D039+Q4mI+
 eKoRfuFiTXF82syWghj41365qo3GaG4Xatq/NZD8iYdQJttV7VbdWdyn8UBfj7ITrleT
 kkN/uPFqzV646tNuIbrBoQ6m+EQVgEOn8WOW2HqV2+7W7Z6gZPKVVb5yxQOyV4cmqEy0
 9WQStpHEDNw74hjjmVqkWYUJooMziCaKivw8qpPkI45l/iNlT9gUTIfCNi2K32DQdgKR
 IUNPwuj2Fu9AYdFc42Ft4+KAiTnNkXFbxTP2kcsN4BjgxopxCirTaiFaEhO6FAsarpr+
 aaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694006797; x=1694611597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls6Dol8nzkYKJhhT+Ry7ewwxhpTglxexiwUyXxZFHnY=;
 b=TS6hCmytv4s4WNbDrIeD6pPUUubOE5qMGpgbjkn6fBQhB6gdmQF1F6HTKIcO4zjCyB
 tP69yuZcF+Yd6GMv0CXYGKbFgrxUFHf9iIDpf88GJqoArOXHYCquSKfM9F+eoPqMhgDI
 NKhJUDNDlgr53jR6JMkzs4N8NNHBtCga45Zer4a/n9+HWYamTs4WuZ3VsKMsOpQyEKym
 xKoGDA5o9b4CjwstWOdFUHufMxs9EKhuexv9uK6T1Wed2pHTwEC583VRRvHhViX22FKs
 2FBNPO5jeD8KP+LrLEOBw1CUv7Zm3xAchSP+E3mdUzIW2vfIRoRiO8jD4qiVwcEhkMkL
 VO0w==
X-Gm-Message-State: AOJu0YyRrTsQorEOeajdR8UbP8+6Dd5xof7meFd0sEgqAazivOmk+xO7
 jXT1bqsXWYrtNIHwOMbTi26NEDkE6CkmP89bBq8=
X-Google-Smtp-Source: AGHT+IEfNFEqyTtuPV4ZYZya4b1amPv2EZsqeDcmioxNdRroUaeeILMi7Wscefe2+AyH1ujzsaX2lOI5ijnPVtJ23ZY=
X-Received: by 2002:a05:6808:128e:b0:3a4:316f:7d06 with SMTP id
 a14-20020a056808128e00b003a4316f7d06mr9671178oiw.27.1694006797441; Wed, 06
 Sep 2023 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <dd425f64-868a-470f-b78c-8bf6a7b7daa9@moroto.mountain>
 <ZPhddADtKmOuVyDq@lang-desktop>
In-Reply-To: <ZPhddADtKmOuVyDq@lang-desktop>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Sep 2023 09:26:26 -0400
Message-ID: <CADnq5_N76Yr=6rPSkRBx5UBhAxR_RxBQorFsaEP22Px=tL+MHw@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: add selftest framework for UMSCH
To: Lang Yu <Lang.Yu@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 6, 2023 at 8:25=E2=80=AFAM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 09/06/ , Dan Carpenter wrote:
>
> Thanks for reporting this bug. Can you give a link to this bug report? Co=
mmit message requests it.
> ("Reported-by: should be immediately followed by Link: with a URL to the =
report")

For something reported on the mailing list you can just provide the
link the the mailing list archive:
Link: https://lists.freedesktop.org/archives/amd-gfx/2023-September/098254.=
html

Alex

>
> Regards,
> Lang
>
> > Hello Lang Yu,
> >
> > The patch 5d5eac7e8303: "drm/amdgpu: add selftest framework for
> > UMSCH" from Jun 21, 2023 (linux-next), leads to the following Smatch
> > static checker warning:
> >
> >       drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:338 setup_umsch_mm_t=
est()
> >       warn: unsigned error codes 'test->pasid'
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> >     319 static int setup_umsch_mm_test(struct amdgpu_device *adev,
> >     320                           struct umsch_mm_test *test)
> >     321 {
> >     322         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB0=
(0)];
> >     323         int r;
> >     324
> >     325         test->vm_cntx_cntl =3D hub->vm_cntx_cntl;
> >     326
> >     327         test->vm =3D kzalloc(sizeof(*test->vm), GFP_KERNEL);
> >     328         if (!test->vm) {
> >     329                 r =3D -ENOMEM;
> >     330                 return r;
> >     331         }
> >     332
> >     333         r =3D amdgpu_vm_init(adev, test->vm, -1);
> >     334         if (r)
> >     335                 goto error_free_vm;
> >     336
> >     337         test->pasid =3D amdgpu_pasid_alloc(16);
> > --> 338         if (test->pasid < 0) {
> >                     ^^^^^^^^^^^^^^^
> > Unsigned can't be less than zero.
> >
> >     339                 r =3D test->pasid;
> >     340                 goto error_fini_vm;
> >     341         }
> >     342
> >     343         r =3D amdgpu_bo_create_kernel(adev, sizeof(struct umsch=
_mm_test_ctx_data),
> >
> > regards,
> > dan carpenter
