Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67585D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 17:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83D210E43E;
	Mon,  1 Dec 2025 17:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y4nc3OV+";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD5C10E43E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 17:55:15 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7b8ba3c8ca1so617374b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764611715; x=1765216515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jvI+449vLivDGb9kc0M43N4Mw/9LJ82K1JvJh/IiTk=;
 b=Y4nc3OV+rYmKBXPsN6yN5GWCGbenOt6GDg2W1lNPI0zWrvyCklWl6m5jghQGIOK1cd
 WEXGaJU7zCMwR7IhvBe5tFXZrX59a2Juh9x8RowUgaa816T/mZuoaeMvdMyEg3f85nqF
 KXAV2AkbrPxya7C8MhcEXSFzW49cwNKaqa2wqIw9rliFNVUlLNAeiPnT1apSNA7XFAxJ
 G6hB0+nfzvPr7ptNgVB1xfMfCpS+KAzJjWyImN7npzzLyCzJv3t5pUMqhjhJRgheIehq
 3kGgEsv1OPWjF1Dmuj25HXh/P7Pj6HmD1iOxYJtylto+Ea1DYXuHAyQ4DJx6uXY263fQ
 sIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611715; x=1765216515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jvI+449vLivDGb9kc0M43N4Mw/9LJ82K1JvJh/IiTk=;
 b=jV5dcmLondscfuPasAI/fGfDxbvBZDZh8C5SEV6Srz0yPG0anS43fqiDYYC06TcSs4
 MOS8i9dNpw4WQjjBr713ExCOWUw2RaSOGE3H8C4FEEh046js01gAanKUcAGqU4sl3OoB
 DXVv8EFwQFalRruHYr1hntUeuspe7e6lMzMpVpokTlPAYQfxvvXTGnyYq91Uho4eMc02
 oaM8zCacIaWD23Ah+krMQW7QWv1KLdPWKkHyswc12A6WeQ70J6OY/rY+0WXZCAKp0dwr
 gdOdGk6NGdSC14a4icKUvv7QyadTl7ccM2Xn/SQzjjf1HbXaPvGMm+gwRsegj/GRT+sY
 BGAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRkPb0JV2A64fTrAvmuJS/6QVhxZNED9SCJmToaMNjgITFky7otbDsSEm0Ob+KRhqOYJ37Lk2p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXYSgc9bu/C60cavLZB2vOUzn+adK0i3kcere/Rv4G4WffZHAz
 7lD/449ubYlqx3zuzxAAB5LMvm5rcWxELX2h/o6pu5bKoa+/j9LgGgaE6IiL69u5BQOEBKoMfKd
 fZLDaDn65IKSyFtylAiRqeJUkF2yioyQ=
X-Gm-Gg: ASbGncuhgG4NsuTN8ckHPAsKxKNhEoRlSHPjSKN5uOO18VQIyCsTZgIqSo6x+Fe69Fl
 Kv8gbMj04PEEqPo6LtE/n8MUBIwMrmexZ+G2LpWCqCsr4ULkzCZLEiZm6cIu+SAQVWVxruTmbXE
 ERRzSpg60pjm70eirEro72dRt4pHrEVKWLF83t9mT/G+A8C/83rQCKb5dJ3J2h/on86KH9z8ek0
 4CUiBw3aNvhM68y+cx3NY5hyQihFfu+6FadFc+wEasF0jz46NfO3cO9fEe+wW4zpLn9XHc=
X-Google-Smtp-Source: AGHT+IGqIo+9c99gGpNbLe6l6ruO8DNr1glo/3jbVKEzxsnzLuqlOMNs0RPfAUPD0FqpaH0RzqDY7iCXYLdGGD6nGKk=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr23473013c88.2.1764611715232; Mon, 01 Dec 2025
 09:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20251201140047.12403-1-natalie.vock@gmx.de>
 <63389a0e-d6ba-4028-9626-c606cf4b95fb@amd.com>
In-Reply-To: <63389a0e-d6ba-4028-9626-c606cf4b95fb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 12:55:03 -0500
X-Gm-Features: AWmQ_bm-Ad7WHAC1sLKfoIMaf_193awrK2kjUFivVvkw4EsLTc6z_MjtYBTHnbQ
Message-ID: <CADnq5_NKLBfdpC7KnQr9Cyoyb0tsH-=gj4D6X58+vQx=HZrz_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Forward VMID reservation errors
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

On Mon, Dec 1, 2025 at 9:04=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 12/1/25 15:00, Natalie Vock wrote:
> > Otherwise userspace may be fooled into believing it has a reserved VMID
> > when in reality it doesn't, ultimately leading to GPU hangs when SPM is
> > used.
> >
> > Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process =
isolation between graphics and compute")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 61820166efbf6..1479742556991 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2921,8 +2921,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >       switch (args->in.op) {
> >       case AMDGPU_VM_OP_RESERVE_VMID:
> >               /* We only have requirement to reserve vmid from gfxhub *=
/
> > -             amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> > -             break;
> > +             return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB=
(0));
> >       case AMDGPU_VM_OP_UNRESERVE_VMID:
> >               amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
> >               break;
>
