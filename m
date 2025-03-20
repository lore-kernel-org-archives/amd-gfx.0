Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED364C35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899CB10E2B5;
	Thu, 20 Mar 2025 13:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GeS51Dlu";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F4D10E2B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:00:14 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso183468a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742475614; x=1743080414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9xsCgPfJdxcdVi87fG+vSWY1bJWa/wDOq15t/oyrrA=;
 b=GeS51Dlur0lfN2OsTuSPzMXnAmfkmp0zU73m1edNYJKj1l6GQUlZzcVo/3W1nlPtu/
 gtUmRdvZAVj6WMGtSKWJKnPqpBtvLKhNObftN/9biyl/JLa+4fX595ZFA7W7MXbDWWWM
 N8hMEOF3VtBMV1SrC5e7xo4Fv6VUu1pMqWJBmdFdM1tD+Z6IxvkV8nGPwG2r+YHUr7k6
 pvZ7ndfXgYWmKksrWuNkg9Z2SaXPL04X+Oc17XcfRR5w8FIkJUXX4nTv4QZ28S4Q4w43
 B8GJl4fUsDHeFaq7sjDRbOAtJqRscYO5IerENHvNGu1EWg/076lGTEVDDPBGAa6hS2Uf
 6oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475614; x=1743080414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9xsCgPfJdxcdVi87fG+vSWY1bJWa/wDOq15t/oyrrA=;
 b=gndF8dY+5RKwBeBECa+BRIQIkbIS6RFupzmLpkKm58hM/utFW3i/Sw1FR1ucE5iYE6
 vwJjDa5nikd/SFN/ZycGsr4WUJtKOrGdUQGEoGSDSS5X+UHFgp/6WlP5OuagBo5M2EaC
 0rbL0EbV19bdbhHliUEQz4DKOscfupHSrwUonOo+kxph0/dZzW7ahn/csVempoYpfQFk
 PHehKvfhFVHkTm0qrRjpUn/rxtyJCxErwYHMgvNIZmq+qm7pm5/mgqH+O4u62CkU84mG
 FPS+CpLlTSb2Vj86Aq4QxMyMpXFSoxyF6CZZm+64el2qJ4DQGc2ho2X8wFLc+Bzm5Uny
 RkEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnpRAHirxy/K1EVcHeAb2NwT9Gq6fugpoX3x0gVmZtQDTdFqxBntW+nRfYPH/xa/reNrBuDy2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL5upAN6ArncN5Ol94AIxddUE5fO/wq59EQzea6rAwst4SZb2q
 iEL0/paArnatT91Y6VcBfTQ22JKRdIIMatdDssVG+X3iRFUBbnn8HCi+Cu536ZFcq9bco2707uy
 DzzMTgFGxyfCqXbj0gXxw0w/WDm8h8g==
X-Gm-Gg: ASbGncsFEwhXomUXBq/Y8758MMvaRVr3s8QGCgHmmjsBBHk1Rz5/1N6WvxNCw+ZWPZm
 6bhTEDJKV+h3L9KqVSLd6QYvqmEzzz0jVo5Bwn8K83gLRzSm8/tB8vLjPzdyOorxiWUFaWkhiwE
 FtQmZtHy+N88VPMK0PQkN9uyMcAfrFy4zpAWLy
X-Google-Smtp-Source: AGHT+IFZQKX7mM2VUw6AMcY/TeV8TMiRDuqj+nAHSRMMWOPlUQmdc8BCmAn9+9l/ElxUN93l3vDZKYixAGqgB49Wzi0=
X-Received: by 2002:a17:90b:3e84:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-301bfc8e80cmr3753707a91.5.1742475613717; Thu, 20 Mar 2025
 06:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <20250319190850.3899718-2-alexander.deucher@amd.com>
 <1ca6101f-e746-4909-885b-071a995b4bee@amd.com>
In-Reply-To: <1ca6101f-e746-4909-885b-071a995b4bee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 09:00:01 -0400
X-Gm-Features: AQ5f1JpOzBHkjKTLpJny13N0h2z8PS0KANSXIahPI0eiqXGoO1oVq-nrpnQCi-U
Message-ID: <CADnq5_NizsJs1YskMHsnosg0YYbjkjZp4bbQmOPDeQ-Z8X-Ouw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 20, 2025 at 7:15=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/20/2025 12:38 AM, Alex Deucher wrote:
> > Enable pipes on both MECs for MES.
> >
> > Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mes.c
> > index 10f14bf925778..ac9b1708e20d8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -130,8 +130,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >       }
> >
> >       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> > -             /* use only 1st MEC pipes */
> > -             if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> > +             if (i >=3D (adev->gfx.mec.num_pipe_per_mec * adev->gfx.me=
c.num_mec))
>
> Same comment as in patch 1.

This keeps the array access bounded.

Alex

>
> Thanks,
> Lijo
>
> >                       break;
> >               adev->mes.compute_hqd_mask[i] =3D 0xc;
> >       }
>
