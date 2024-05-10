Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89E9C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 23:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECB810E39F;
	Fri, 10 May 2024 23:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iGawqdN4";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACE410E118
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 23:01:55 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-6f489e64eb3so2130373b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715382115; x=1715986915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXrtYIwrQ+lj1a+pmOQtn8As+mydvcIFYiDOq16vvz0=;
 b=iGawqdN4IZsSeBpSMwDaz6RYkpI3MKEX3itSaCZzUjKukJo4OlY63SA0jwsmnVBRR2
 ceNXVdp1u5Pr33HpSkTb9Aal6ZeKbuHf/jSHEAewEZV4pDMsv2uPbVsqbPC5xevcXJaH
 mFmLQt99RAhkgg9hHvMIl0hmnTmP62tEf1qyc853dKrYd9hY5wNxTlMiaFcPX5PcnMTJ
 LrDFJSVd6k+18MX0pQITXYiDcQ/sZSpSAXw2lmwZeGT85JECkLm/tOb5jrmjb2YPQQik
 ALqKLWp0GiT5sv5LY2VMqCKpTiVGmcSKILqwNAEymj0uCrPwykuZHJiv22nyywsBms5e
 3Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715382115; x=1715986915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXrtYIwrQ+lj1a+pmOQtn8As+mydvcIFYiDOq16vvz0=;
 b=cDOsj385AL60adcc2rSqSfsBa2dZJO+zasRC2Z7ETxTsaWJUDuXzyy5BXf7P7yg+l6
 rWzeSz5NsGe1vpvUZF5oF0aWyRNJhirUs/t4ECfER0GSoR8P7/wPUZm4QQ74aYP7w/+c
 TdMmnXQRk7UmwHWMFe/9b6Jnn4Ya2t9ZFMnkUOz4KsbiCueOL8NIsUcwWRlrW+ZpsPHU
 A9uUQgyUWjVSOqaVpxsGMxlvItXeHj+yDBAmlIQuuGeOp/HqClafVHizzfA2gykkdkrc
 c14cxUiVxg3d0knIXeSd3Twrv/ioI+8CJj68eW7WZUdWSZ473ezqneKxz7FqpT85BbB7
 DZ/Q==
X-Gm-Message-State: AOJu0Yx9udZlUBOhq0JDN3nNQf8EZihkNrQKajHH3D02LhjK+fqxPLTL
 oLn3Q5y/uHBDOI9l6VZ6Nq4Qqx5UCzH/L4hVtnW5FZ5NJ+9n3rquqKTz5/pZsGSaRmWz3VZXfV/
 0RmZgIpweFM9k4Lb+fu84QchXtStlYQ==
X-Google-Smtp-Source: AGHT+IE0a8NeylLc3SKw/qboXgIgQLI9/vfrgjFm7AiRWmQoFW9jycJiRplLAtFbvRvd0RmAkRq0Akuw9lFmkIhodxA=
X-Received: by 2002:a05:6a21:2782:b0:1af:b80e:5406 with SMTP id
 adf61e73a8af0-1afde0d4d1amr3778540637.21.1715382114627; Fri, 10 May 2024
 16:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240502214225.8101-1-alexander.deucher@amd.com>
 <CADnq5_PRVEfvxR8iwTc2OVaEO+PN5Kzj6-8HmVSpjTjq5C0J7g@mail.gmail.com>
In-Reply-To: <CADnq5_PRVEfvxR8iwTc2OVaEO+PN5Kzj6-8HmVSpjTjq5C0J7g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 May 2024 19:01:43 -0400
Message-ID: <CADnq5_MsbQpPH5RmQmEMEq-pX75uMrw8-o15NgbPdfN++dEuRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to
 gfx ring pipe
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping again.  This series enables a high priority gfx queue on gfx11,
similar to gfx10.

Alex

On Tue, May 7, 2024 at 9:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Ping on this series?
>
> On Thu, May 2, 2024 at 6:02=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > Use correct ref/mask for differnent gfx ring pipe. Ported from
> > ZhenGuo's patch for gfx10.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index ad6431013c738..81a35d0f0a58e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -5293,7 +5293,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct =
amdgpu_ring *ring)
> >                 }
> >                 reg_mem_engine =3D 0;
> >         } else {
> > -               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> > +               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring-=
>pipe;
> >                 reg_mem_engine =3D 1; /* pfp */
> >         }
> >
> > --
> > 2.44.0
> >
