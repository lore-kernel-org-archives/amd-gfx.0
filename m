Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B670E7DEF1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 14:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0296310E4EC;
	Mon,  2 Feb 2026 14:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hq3RdXNS";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634AD10E4F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 14:51:34 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124713e4244so86788c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 06:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770043894; cv=none;
 d=google.com; s=arc-20240605;
 b=PCHVQTfugiqxe0Vrw3q6qX01L2iVR8r0cEDi1LnvHJ6UZ0Nx2m/TRnEMwHcvGYvMSw
 snxEU99MirzXm/wPG6N5l2HgiOHUdIjMnvi/nwaUZb6LRmeKr1UJmmn/JXsbT+kr4WV7
 epNjSC7yKG5u7MGNQ67CLc9vp59lYABp//VJWEqEGxHO0BhS6mz88JLqL7nJgt8m9Bit
 7gvBfxnjCO7TTzDOalS1nW9xi8ZLd6JgatjLjMEuE2qPOT/cFdrEVcsjLMzAV2OUeNV6
 q2/4Aa4Hkd4r29cWVxSujL46r2cdWmF5qZ+wmIJvlfOnHlBEgxgz9N514izdWh5rqCbg
 CsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eAtojXyqiPHPaom00sJMJGGJnGovuCBOKmtfRykM3lU=;
 fh=Oh0uRc45r3iUuUkpWRYtSJHD/bOY3SHUrTgQXopmZ5A=;
 b=cZdmfI/prd4WT/lvAeOwwmklzF4ddPhu2wC/DwTrhgKGBYM4O7AItz58yHDwUfxk8d
 tHZh7QKSDOgfYyv28vgj8BnjKrA8smoAfww+2JvKU099aqLBpjL4WZchXWp7qg5EJLk+
 ejPmq9kxn6nlWmXA3BSM+dEHpeoBMxJrSTXRhro6UIUvG4IqpMmNzp36HiJVOQ5zWqBA
 tzMFlRk2RZhcOU3/x7ayPEEr9B/5Ul4fxl15QfPlW4Ic+Kz8l01M4m4rh9SSQXdXyG3W
 io3OJ16J8bCbBzpSSC6urBcuVzCJ1x3V/i31ltr0iOKxkq6OGgm6qhjWrBnGsmi3JZVE
 j4Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770043894; x=1770648694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAtojXyqiPHPaom00sJMJGGJnGovuCBOKmtfRykM3lU=;
 b=hq3RdXNStvdfcCEJlHzu9GDPCDnYfcV1oHmU2JJydZslXo0PyA9ca+m/LyBeu7QVYv
 iT+zJigiAL6ljQA4xIEVpx3xCRhKhCR+aYYqQcLAF9MUWNezMx3/IBqz5HpjHbQbMNYQ
 W1wcYh1xYtyh2f97iOyjr4Wo9Tgem/T7zEM2z3Rrm1Z8nowKzZ1v1fa7dyTUOdAXjH4V
 ikFbF8KqpCjeuj5rROD+7mgk19wuvjL4eft4mLsnJZiS4H2sgjredcvpuOUQAK+8c7AJ
 qzIzmeew8aONhIVfggwvJb5s1UYrWP5M71noSuOg8cVvxV6lk5X+0LN9/xAzYWwKDBiV
 pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770043894; x=1770648694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eAtojXyqiPHPaom00sJMJGGJnGovuCBOKmtfRykM3lU=;
 b=Er4T6xCSAs+fop6bq9pZwgShLkFVHBhDCNNiW0JJhgG3zuUTqdO4BejLpz0L1t0keu
 rvzkfYBLKfqhdboxJZvgShyWyyeJnsWVA5cRjdVIJLS9iCGHIuaY/Frv9apv2TmDQWZq
 RRm9RI3X9DD05hH/+KhLXc9qtHDSxBahpc32R1mNuOXWHz3mlBaeXQC1fU8d4s0sXVsm
 M8wvXktovQjThZliznxv9hjvPwJkqMRyENdKWvkZyRwDNrLUiv4VKRiO0+bD2U5w3qZV
 yV0oQppu3xRTIUYXiHSSLYiA3WGPMYc8JygQFtohIA9UifT/2JHvYDtxtGgWuVareyAl
 sR1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpaKBTq1dME7aCtJ0+lWDuJxl6/k9Wc9a0wjsYRvC0BrIxf3DSEr9mw8/vfU8pRTRYaNMfNxsh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdXAroYPn/W/qnx7PjVBsbixoAgtbafzlyT4aHLzlLA8fth3Fu
 b8BXKP8srlWUDVto6RvGMyyfUUz0cnUvXxtOCYD0eOX+/POUmvbnl8RqL4fLCUMhPaJ3Of6rA3L
 Z+tClNuqCHbBEsaEy2mf/AffD9z2kCow=
X-Gm-Gg: AZuq6aKG/F/eLrZsNadRGfasV+RPTnkftksyywB7WDcUp0G29LlwKHclX4pZvIxp6jg
 I+R1je2xQ8ZAKRHQN2EkKiPZhgmUPlxKUNDQ9BD+4w5AD+iANyJE4EqLoy71rZrNsDZWeNrctZK
 GlXLNS4a+/1trL5HgS95yrM2Qzb8ycC2zgsBovMndO2xyJS5p5cgINVtqjnsRr46MhoDOx6+LcA
 CfkZBz+lMoMgrZt8+LlNYS76HklFch9MVYmj+DWFJQedeR6I23d+fAk5FopmvmUF7gAT5TF
X-Received: by 2002:a05:7022:98b:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-125c0fff10bmr3041234c88.6.1770043893521; Mon, 02 Feb 2026
 06:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20260129092532.921809-1-zilin@seu.edu.cn>
 <4bfe8f26-3ead-4d6f-a85b-da83ad45d57e@amd.com>
In-Reply-To: <4bfe8f26-3ead-4d6f-a85b-da83ad45d57e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 09:51:21 -0500
X-Gm-Features: AZwV_Qi4P_4OnZTKfh0lWk_Jqs4E6hVliJ1TLQzpcrAozEP1Ap4pVTKsEASA_bc
Message-ID: <CADnq5_MFq1h+PeGtMK=xgAHCBfa7MzYMhkTuh_YOXpEj4rgEpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_acpi_enumerate_xcc()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Zilin Guan <zilin@seu.edu.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, mario.limonciello@amd.com, 
 pratap.nirujogi@amd.com, alex.hung@amd.com, sakari.ailus@linux.intel.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 jianhao.xu@seu.edu.cn
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

Applied.  Thanks!

On Thu, Jan 29, 2026 at 5:15=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 29-Jan-26 2:55 PM, Zilin Guan wrote:
> > In amdgpu_acpi_enumerate_xcc(), if amdgpu_acpi_dev_init() returns -ENOM=
EM,
> > the function returns directly without releasing the allocated xcc_info,
> > resulting in a memory leak.
> >
> > Fix this by ensuring that xcc_info is properly freed in the error paths=
.
> >
> > Compile tested only. Issue found using a prototype static analysis tool
> > and code review.
> >
> > Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index d31460a9e958..7c9d8a6d0bfd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1135,8 +1135,10 @@ static int amdgpu_acpi_enumerate_xcc(void)
> >               if (!dev_info)
> >                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info,=
 sbdf);
> >
> > -             if (ret =3D=3D -ENOMEM)
> > +             if (ret =3D=3D -ENOMEM) {
> > +                     kfree(xcc_info);
> >                       return ret;
> > +             }
> >
> >               if (!dev_info) {
> >                       kfree(xcc_info);
>
