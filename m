Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B0C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 13:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4464B10E5D9;
	Tue, 14 May 2024 13:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NrRmMaHZ";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA6910E5D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 13:57:33 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so4519225a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715695053; x=1716299853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4DvYaEfQNJjxmGuNzTkWl98qUMWV8+sVwgq2e+YgjY=;
 b=NrRmMaHZSRdC76znlRz+HXvYZx1oGlT9SgnPj85jshTAIvudXpH+3BMRteQ9yKovKm
 dpvUVatLbSLyLPShWiK8ont7Zs/6MxYSrsEOkmK+ro3msnTYxfJUuLPLYQL4fsRGtyD+
 ceEF+x906m+0a0Ke6wJzjt8av1QEABrs/bnH+kNYsCUx/4gV1eiv9yE6xiPi2jJuQxJX
 VDIu6JBe/QqUZa4TQFEFdGmTm/WqNbwSZNZ4BsdvwJb+SD3Kr2CbY5FvHu5KFneZn4Ww
 qwxYXHATFbFDmVCd0CQH+o0By+88oD9OimCQX13QO5HrOK19jmAOhwoi0Jew2TP6rWff
 yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715695053; x=1716299853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4DvYaEfQNJjxmGuNzTkWl98qUMWV8+sVwgq2e+YgjY=;
 b=D06W0CeiWBUHD9asv26xfC5OpQ9XHcJ/guAhokIur6muW4XAwx8PdFlVaAFpRws55u
 K3llx5wGJAgWzSSbiwL4dC7KDXSWsm6/R1Orun7khv+so4fa2Gc1mV33nFj3ujNAvb0a
 ckv7qg2deiBftKobju2rxigQBq1VpPcpfsECJu8nSrMshppj5GsyaJHWbz1tfvOsNQLa
 I3NxNJoXk7LjN1nJ2pD+reiT5ZMH/3hzIPHCRfR8OT/25uBvq9IIvVeU7D4GCwVn4qAu
 O8BAP0DjBejylo6HtHabAKyVG197JiqScsviZjBHP04mqPFmM9aPJt9EZXlO1ri1B2+x
 mDVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYInW2cs+sOIhTW9QReOLGYN0kP6XKnPqxOZz0rOrM1qunZci6JSM1BCoqaCu43FFdBmvF0yun+LAsEW8JjqFq3TyopKAkQEPto3u1Dg==
X-Gm-Message-State: AOJu0YzB+TQGRMy1uLPFDb4M09MxKv8ZILGQ1YDbpFGXXlVogtgH2byT
 fc3HXynCJI89+E+fn3GsccNFr+peJzqgTMgoxLHo0VKWVsHJ3YVVQVyDfMnxATNskZXqbR0aLeE
 WSlqZM8wODkhj8Yqwn46oiWgwJBXaUg==
X-Google-Smtp-Source: AGHT+IGcsAqYmWtwzwkEaP5LzJ6QtLjAeJw+Zn4b95vQRVImY5LoJUtANClr5ZbZoimY3yJJ4J3vAXzhSYY5NOuomQM=
X-Received: by 2002:a17:90b:1086:b0:2b4:3a1e:2400 with SMTP id
 98e67ed59e1d1-2b6cc7584c3mr9787431a91.18.1715695052982; Tue, 14 May 2024
 06:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240514070638.199124-1-friedrich.vock@gmx.de>
 <42cc0287-09da-4d71-91e9-685287fb56ca@amd.com>
In-Reply-To: <42cc0287-09da-4d71-91e9-685287fb56ca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 May 2024 09:57:21 -0400
Message-ID: <CADnq5_MiCj7t8dN3WK5RN87GixH4BbqcJ2z3NhD7OgXeSHH8HQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check if NBIO funcs are NULL in
 amdgpu_device_baco_exit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org, 
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

Applied.  Thanks!

On Tue, May 14, 2024 at 3:27=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 14.05.24 um 09:06 schrieb Friedrich Vock:
> > The special case for VM passthrough doesn't check adev->nbio.funcs
> > before dereferencing it. If GPUs that don't have an NBIO block are
> > passed through, this leads to a NULL pointer dereference on startup.
> >
> > Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> >
> > Fixes: 1bece222eab ("drm/amdgpu: Clear doorbell interrupt status for Si=
enna Cichlid")
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 861ccff78af95..83c4533ee75c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6165,7 +6165,7 @@ int amdgpu_device_baco_exit(struct drm_device *de=
v)
> >           adev->nbio.funcs->enable_doorbell_interrupt)
> >               adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
> >
> > -     if (amdgpu_passthrough(adev) &&
> > +     if (amdgpu_passthrough(adev) && adev->nbio.funcs &&
> >           adev->nbio.funcs->clear_doorbell_interrupt)
> >               adev->nbio.funcs->clear_doorbell_interrupt(adev);
> >
> > --
> > 2.45.0
> >
>
