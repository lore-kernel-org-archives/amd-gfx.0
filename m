Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86740CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 19:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F286410ECD6;
	Fri, 12 Sep 2025 19:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJwTomgd";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C89810ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 19:39:01 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-24cb6c57a16so2775425ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757705941; x=1758310741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QEMk3cXOihtUvDdnlEvnXSOqVkqHxyd9IdOgCtXsvc=;
 b=YJwTomgdCKza/mj+r5b2IjSXRCeo7EnbaeOww2b7AbI327Ra+9EL5IYDcVh2hwGLLb
 C6sKg58/Vw0FXD9Al1bwk4kO4LG+URXDFOSLtCrlupMrwPD7JhU2dGB1T7K7sTH4mXpk
 4K9YcxpDty9G5cZ5qou+EMPZx94Wfkch+fVxPwTZLs4tPTk/h0NT8R59Vc9DtClMbm3k
 9vPv1/Iu23DRBx6Braa2s56Si6TowcH/3cWvSmoEyIfqWn/MaBMQIe8pkaZ1gZ8dZl0t
 jF0oIFhUMwoicMBqPuB1NCKeVdUN81kP8S5FwL4yjYSaEdvii4C+fNkDYF7JPIJDNmZL
 4PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757705941; x=1758310741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QEMk3cXOihtUvDdnlEvnXSOqVkqHxyd9IdOgCtXsvc=;
 b=M7w5VKRkyX6dRPT/hffNvq7haNYae1GU9/D0usq6Aq1nIrIX4zVQMQof82BMHa84Sj
 Cl6HzlhchgpUOclBAdZ04bwtH10DQujW1NDRRaQSkn310ADfGvUdhDKVwfPLJTko/Nac
 fGHr5WLbkNxPdCT+GwsjLSGlUlW2fn9aGhydTmmRF76S72HPhoflOHHnbjtpJ0U8ez99
 CcJrgUjFg3iXS0Iq/qjXFt/TpFfItBn+pQjbgbe9Ro87m7ayjs/esBozL903UaKcUY0a
 ZE3PJjqI0QJyXfOQNqyxgPKU+OOX+FJiB23wSKK7l+V8tEgY+GV7cg1PVA7aFp5AgSNZ
 n3PA==
X-Gm-Message-State: AOJu0Yy5LeuC2Dd60jR9y40YwIXowNQREKkBGyg4DrNCPlD1AnvNggbT
 ZRhBydH081Y9ME8jbANszOX9/j2TU2oj6/csv1/5ZMsFXhMimPTaT2ryq3yIY6mkVTng5xYHpqg
 5Qs8hUzHq4oMkklz5Qj+v3UbF2fJap97JiQ==
X-Gm-Gg: ASbGnctDKYu8eWdP/EcA2wSCl6YzIL1DX90rHBsKyY3A2fO5GNqcEZ9YHt36ipSt1Yu
 /8xMOyZ5QxFrMvnbaUIoaQhv6dJNC2ndfCCMFS1G0Sr7aYyIF8UzZYgyiZm3CkIiTyz2A3fEdxF
 21kEV4srTXA1SkCPBMJyHXi+wbybaTeN4Sl78B5LLtNAxru/1Y/URVf+wrSQACQGpBxS1QgQH1N
 xCuqkN/H98jS83lmw==
X-Google-Smtp-Source: AGHT+IHL5T0EwD3WpEYDNMY6BN7bGJUcLMF3+Hgxtq28IUyAD6oSiBF+1yw4tIGyK/qZQaBig/5O/MYkTOc0dcGn6d4=
X-Received: by 2002:a17:903:120d:b0:24e:af92:70de with SMTP id
 d9443c01a7336-25d26764222mr24813895ad.7.1757705940943; Fri, 12 Sep 2025
 12:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
In-Reply-To: <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Sep 2025 15:38:49 -0400
X-Gm-Features: Ac12FXzSZW0ae-TEPXWbCIxeU7q9-sZC3K_D0gsgCuqH_JxbZg6KDVUEtGgu8tM
Message-ID: <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > SDMA 5.2.x has increased transfer limits.
> >
> > v2: fix harder, use shifts to make it more obvious
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index a8e39df29f343..bf227eadbe487 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -2065,11 +2065,11 @@ static void sdma_v5_2_emit_fill_buffer(struct a=
mdgpu_ib *ib,
> >  }
> >
> >  static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs =3D {
> > -       .copy_max_bytes =3D 0x400000,
> > +       .copy_max_bytes =3D 1 << 30,
> >         .copy_num_dw =3D 7,
> >         .emit_copy_buffer =3D sdma_v5_2_emit_copy_buffer,
> >
> > -       .fill_max_bytes =3D 0x400000,
> > +       .fill_max_bytes =3D 1 << 30,
>
> The hw docs and PAL differ here.  I've asked the hw designers to clarify.

The HW team verified that the hardware supports the extended range for
both copies and fills.

Alex

>
> Alex
>
> >         .fill_num_dw =3D 5,
> >         .emit_fill_buffer =3D sdma_v5_2_emit_fill_buffer,
> >  };
> > --
> > 2.51.0
> >
