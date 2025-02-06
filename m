Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6679BC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DC810E23A;
	Thu,  6 Feb 2025 15:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REDqsWX4";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FE810E23A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:39:42 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fa1c3ac70cso62771a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2025 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738856382; x=1739461182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xrZPh/jVN3mwmztWchqciaPiV5Q9xgw8r9fj4VFD4k=;
 b=REDqsWX4zAMzShfe2g8XmIn0UGuldsefCThgOtMoPG5O/i9UAZenxcDz9es+mrCAO8
 xDLt7xNJhAtcoTE6KjfVV9YrqecHNze+0zxhZFSa+rd23FF0wH2WqJ5FJVswI+kUaEbO
 dCa0uwiKHAleQdqGImVHTBqhd3AaIXjjDoXiuG5PogOdC5lLSHJEX7Gq4kLepQt/mC7w
 o04UMlgonAOsQOe4oSGd/r+aJqawJTBQcYQDxzbz7ClPXPKP5jiJBwbW8MkwlrnZa6zc
 x4yoqNbOv7vt8r5RmmuxFHAejxDxmStzxtuLWJyf6vRQToaeRniACDhkXjaOMoy/QGvf
 lpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856382; x=1739461182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xrZPh/jVN3mwmztWchqciaPiV5Q9xgw8r9fj4VFD4k=;
 b=M6LgDbJu7XNE7bOECJQCDSmzYNuZvRggJ0jvc8CMptr5dZn8wGyy3n0/XC5eg3Y6H0
 7SlamiqrOcj/U+63dsY3iiZ8qyEkwn8Ww3h87Nk4XSPW6xJBctgm3+0QGW+GZ+TV1rj+
 V+XGE+p4lhtYx0kDcsRYqU/r3JZxUZU8HGHcNIwFX7kXoB6bsbOYELCtW/W2zRGprN5s
 x2berKELYCQOLzStlnUKKnQj7ahxm/9GjTDoAgMeXOpV+SY5nZl5k6Vg4HUTxxnRQP/Z
 YmxWAEbDz5o3on6abLlN7b5SlcT5FMFT48NKaQnhvYzJVpB4IaFB5Kiln2pxrcCvUUag
 VgQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXor6Lg4Li+MuWgitG6895KalpPst3O+nAlJJg5zYvzyjdDVGOZzyOBnm4ZPwvcpjSwKpjhwHqW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVUxDHXNaLRI+OMcUgJpt3cRoFsfcCKAk9CYlEqoRiB2BtECCN
 ppB0p2lu5sO2yAWf+yieT2SQmkEbKEA1BN/YAHlM7ouz96sc70MjDZ4YNLJ0cR/6qzk5L3Jvjew
 ENpEYxvwulq/cCHRoweinu0AS6eg=
X-Gm-Gg: ASbGnctIYfEonkXWGQOIMTIBR6wm3gcRfbQd+FIIRsGaxHiSJek2u1dSLpeozih0hA9
 G7qU13ZyRycG3Rc19ZxbD9+sRFsx+McZyLD4UgVBBo1nJ6ec8udUXJPR8CzZ86bfN51jaMLUC
X-Google-Smtp-Source: AGHT+IGrduorTvs1PwXIPtHmYqG43quf11WKmGOZttGhoJ+LOi/oc8CBRNBUEo6GbI2bIRNeyuxOoNhqD1FphtyQ3Wo=
X-Received: by 2002:a17:90b:2883:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2f9e0867b55mr4521232a91.8.1738856382320; Thu, 06 Feb 2025
 07:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-5-alexander.deucher@amd.com>
 <afca7790-5a0d-44bc-9d4c-9c3eaea078d9@amd.com>
 <CADnq5_NkDg3VB1eNm7-VbwpcobPs_M=nnw0jycpXr7oxXD_3Xg@mail.gmail.com>
 <DS0PR12MB780477EC38379A673BBEECE297F62@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780477EC38379A673BBEECE297F62@DS0PR12MB7804.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2025 10:39:31 -0500
X-Gm-Features: AWEUYZlW9qmzHCYdhaJUiyKH4j7_dTsGPtfw9qkvWwd-K_DWvbvBvxYlId8Oy_Y
Message-ID: <CADnq5_P+sX_ktrHYOfVK3pbGJMENmEuv0_nJqEukT+=iARmcxw@mail.gmail.com>
Subject: Re: [PATCH 05/11] drm/amdgpu/sdma5.2: use
 amdgpu_gfx_off_ctrl_immediate()
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Thu, Feb 6, 2025 at 10:36=E2=80=AFAM Lazar, Lijo <Lijo.Lazar@amd.com> wr=
ote:
>
> [Public]
>
>
> Specifically, was talking of examples like delayed bo deletes (don't know=
 how they could be in real world). That is an example where buffer deletion=
 is queued up and buffer clearing jobs will start sequentially. With the ne=
w sequence, allow will be sent and could immediately be followed by a disal=
low. With the delayed ones that won't happen.
>
> Or is the gfxoff delay that long which removes considerable power saving?

It's 100ms, so it's pretty long.

Alex

>
> Thanks,
> Lijo
> ________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, February 6, 2025 8:55:13 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 05/11] drm/amdgpu/sdma5.2: use amdgpu_gfx_off_ctrl_im=
mediate()
>
> On Thu, Feb 6, 2025 at 10:17=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >
> >
> >
> > On 2/4/2025 3:13 AM, Alex Deucher wrote:
> > > In begin_use/end_use use amdgpu_gfx_off_ctrl_immediate()
> > > rather than amdgpu_gfx_off_ctrl() as we don't need the
> > > extra delay before we allow gfxoff again.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Won't this cause unnecessary GFX allows since sdma jobs could also be
> > used for clearing the buffers?
>
> The calls are already there, this just switches to gfxoff allow
> sooner, reducing the time where gfxoff is disallowed.  Should save a
> bit of power.
>
> Alex
>
> >
> > Thanks,
> > Lijo
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_2.c
> > > index b1818e87889a2..7f2e1962b5755 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -1882,7 +1882,7 @@ static void sdma_v5_2_ring_begin_use(struct amd=
gpu_ring *ring)
> > >        * doorbells when entering PG.  If you remove this, update
> > >        * sdma_v5_2_ring_set_wptr() as well!
> > >        */
> > > -     amdgpu_gfx_off_ctrl(adev, false);
> > > +     amdgpu_gfx_off_ctrl_immediate(adev, false);
> > >  }
> > >
> > >  static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> > > @@ -1893,7 +1893,7 @@ static void sdma_v5_2_ring_end_use(struct amdgp=
u_ring *ring)
> > >        * disallow GFXOFF in some cases leading to
> > >        * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
> > >        */
> > > -     amdgpu_gfx_off_ctrl(adev, true);
> > > +     amdgpu_gfx_off_ctrl_immediate(adev, true);
> > >  }
> > >
> > >  static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_bloc=
k, struct drm_printer *p)
> >
