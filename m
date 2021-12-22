Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC4DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAB610E204;
	Wed, 22 Dec 2021 14:12:02 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C9710E1EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 14:12:00 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 45-20020a9d0a30000000b0058f1a6df088so3012169otg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EOecxSTgL3AcnXK7kCXsCsGqnwNPmfFxPmtEbRjyw8Q=;
 b=FUofPaOmplE/lqwfeRQGJRyq3lSjuPOQ3xGFI4dJweZ+KwKybFB/F2iDobdmkDeNzW
 dncle8gEyYrSsH59MnQchDdDlTlcuqseXx+UWZjdINn1Zo122xW9pIkMv3db2Doc+rCD
 BCPczxoPIUF4x4vrPIEamFtaBLz3XHI1x/ASnqghAtz3m5bXeN25oWca9zdoV6u0fzLb
 CJyhDFaVjN2l+cCZVqpiBCcc4qq1nSXQp7frgOJZJ6khUsOJY0Vb/p3VKLx7WLQEH80b
 XnGe62mfkrPJzp3VL1tpnoOho/0MKv4PTwBnHQv1vWaub8bFgivEdGXyH+VnahYqMpMz
 D9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EOecxSTgL3AcnXK7kCXsCsGqnwNPmfFxPmtEbRjyw8Q=;
 b=qTatrajmStF1oKJaMDHosasjQiX6wNwsxev8H5NOXx+D6L55oS3ZX5J5RvlUMR4JnG
 ULVZLuXXoDS1gxBcJd9jkqkL+/NiVeOuYmVai7RVGf6cINolRP53S1W8uUQrpfrejtqF
 ewPJ8J0oaTLYxF2c7/965tWYdoZwOnQTsskb3jXGNdYsZy5vzSYqYARm18MZLgqMmypC
 vS6g6dqjjT4z6MblZrLewl83UJaM5ekICVlE3iisvJy+l7HX6+XQYMVkm1LmlyV/pXYU
 vJZ7+HdZSOYtny1JJH1r573OXSPW2VGIDeZXIhlCuMqm8J4qb7WfcSwmZXrK/wOLX3gz
 jKhg==
X-Gm-Message-State: AOAM532FLDN1zmd6F6CrIro7fXH3+jrrAgkfVs+2ZL3n7DFu3pFJVM56
 lM50ZeaueC8IFNEXiFVIVkDu6NqK43d4M1lDNys=
X-Google-Smtp-Source: ABdhPJyO5G+Iw4HxbhYMvye1sa4TeUUo2eRQjyv8lqP3d6BvEVGOxTmwMKMI8ASKUrWFl6acGEneQCayF5XNbvNJFmk=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr2218229otn.299.1640182319563; 
 Wed, 22 Dec 2021 06:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20211222055140.1215839-1-Victor.Zhao@amd.com>
 <b6edb4d8-b9b6-224f-d35f-5477fc1f7687@gmail.com>
 <PH0PR12MB5417224A3CDAAE1B030BAAE88F7D9@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417224A3CDAAE1B030BAAE88F7D9@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Dec 2021 09:11:48 -0500
Message-ID: <CADnq5_Mzbu-Qmz5Nr7RoPPr4EsbAY7z2+n6RhTgR3nRxfqPgig@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: add workaround for some arm hardware issue
To: "Deng, Emily" <Emily.Deng@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 22, 2021 at 3:18 AM Deng, Emily <Emily.Deng@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Currently, only ampere found this issue, but it is hard to detect ampere =
board, especially on arm passthrough environment.

Isn't this already handled in drm_arch_can_wc_memory()?

Alex

>
> Best wishes
> Emily Deng
>
>
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >Christian K=C3=B6nig
> >Sent: Wednesday, December 22, 2021 4:11 PM
> >To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> >Subject: Re: [PATCH] drm/ttm: add workaround for some arm hardware issue
> >
> >Am 22.12.21 um 06:51 schrieb Victor Zhao:
> >> Some Arm based platform has hardware issue which may generate
> >> incorrect addresses when receiving writes from the CPU with a
> >> discontiguous set of byte enables. This affects the writes with write
> >> combine property.
> >
> >Can you point out which arm platforms are that exactly?
> >
> >> Workaround by change PROT_NORMAL_NC to PROT_DEVICE_nGnRE on arm.
> >> As this is an issue with some specific arm based cpu, adding a ttm
> >> parameter to control.
> >
> >Something as fundamental as this should not be made controllable by an
> >module parameter.
> >
> >Write combining is very important for good performance and so we should
> >only disable it on boards where we know that this won't work correctly.
> >
> >Regards,
> >Christian.
> >
> >>
> >> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> >> ---
> >>   drivers/gpu/drm/ttm/ttm_module.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/ttm/ttm_module.c
> >> b/drivers/gpu/drm/ttm/ttm_module.c
> >> index e87f40674a4d..b27473cbbd52 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_module.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> >> @@ -41,6 +41,12 @@
> >>
> >>   #include "ttm_module.h"
> >>
> >> +static int enable_use_wc =3D 1;
> >> +
> >> +MODULE_PARM_DESC(enable_use_wc,
> >> +    "control write combine usage on arm platform due to hardware issu=
e
> >> +with write combine found on some specific arm cpu (1 =3D
> >> +enable(default), 0 =3D disable)"); module_param(enable_use_wc, int,
> >> +0644);
> >> +
> >>   /**
> >>    * ttm_prot_from_caching - Modify the page protection according to t=
he
> >>    * ttm cacing mode
> >> @@ -63,7 +69,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching
> >caching, pgprot_t tmp)
> >>   #endif
> >>   #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) ||=
 \
> >>      defined(__powerpc__) || defined(__mips__)
> >> -    if (caching =3D=3D ttm_write_combined)
> >> +    if (caching =3D=3D ttm_write_combined && enable_use_wc !=3D 0)
> >>              tmp =3D pgprot_writecombine(tmp);
> >>      else
> >>              tmp =3D pgprot_noncached(tmp);
>
