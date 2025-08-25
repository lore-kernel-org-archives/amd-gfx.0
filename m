Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D755CCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 16:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD9A10E276;
	Mon, 25 Aug 2025 16:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9Z3o+qO";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7940910E276
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 16:31:30 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-246190697f4so4046205ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756139490; x=1756744290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gh0Ifrj8Pzk9I2rGHLqkt/PupTcKKcQkXbF8GXY+RUM=;
 b=b9Z3o+qOoGimwpFoybKeQ6Ime/oUljQZ6TFL+dbBCLpzwTBiu1Ov7gcO/d8LJyeNEn
 DhxPW3LdgAZfRePm/P4Jv53TIEHgyhW3j7lbIWfBDwv9o3kGjmKYJE3eEiaHC7wAp9/T
 gH7he3mlBFxP8ROKHFAX0cqCiOIaatW+SnsqZz/XUz8uHpeVSugbYt4KGJiVKhn24Vk4
 Y9OvzBOc6hfHqFfNARjvAmKBU3a7enA7nJDEuM2VPxn88BvymgRPNpliF1wrGyV7pm7W
 cszNDSNyJM/rT2ci9S3b89xjEZQTdDT8ENEOrYrFnVr82MsrxpJsEs4A687QXfPnnRB6
 Z59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756139490; x=1756744290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gh0Ifrj8Pzk9I2rGHLqkt/PupTcKKcQkXbF8GXY+RUM=;
 b=gV3T43ym/vOvz9o4EQQFoGV5LKQHTugu3XKFAQSqJ7w8Ii1EVg6icJBM/hUns6tA5d
 YS+NOggWxyQhdJZsPg+TriCOZrUVq+GyGm0U0yYxsbocFavS41OrRwRceUrKPRosJtGS
 8xnVUD42ByQh7exPQiyPB3N4kXoOxjT8bWeJOxe8dNyO0guGyk/iQngTfkRXu72a2UtV
 82l++Rh+A9zV+jyZvoO44iAhBNzEulN3jr+hGVO7R/w0auZw4TgL0yIvnqIxQk5U+o5C
 TENfABIRpUzSt+3EoyVH46dxal0jAGA+81dJWOUZ8pmQFVg7SAaBH4DHj894pIX2yOsA
 I3Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtbOqN8xdBYfste66t0DjpJrxM1D5mNzqjh6WL4fWbT1CnY14vdentwOZ0T5rVdIXTl1fPa1Mm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWHXV9o1BiBj46E4cyYSlLXjw2fsJ8feajqBEDSHuiO4pEtxdJ
 Md8LmGLQUXi7+peqdHbpClqBpT33GNqoZwigTfMroCa+Z478PKP3uIgz5EPpbydp8QbkmlDwRUC
 M0Ti0SHSpU2W5fsWzNdYCdgf+VKKcyMQ=
X-Gm-Gg: ASbGncuQvWLn9PzxlN6uNxJeNZtMx8w+23Agn2e0pwfOLsXm055XoNC6p0g9ByUUeq2
 aZjk91u9O1KNrR/56sGXATs3fmHIUceyGUr3PyWdu8GYyzyMi7znC3ZEHq33N9360wHo0uHTyUN
 Z7Re7KgOqPcZH7SWO203O/lVwQnndLDixXZwQzt7fhDM/Ii6rVgHtsVtMjzGvEwdXVl5pFjdq1F
 1mArbI=
X-Google-Smtp-Source: AGHT+IHd3j/kyDPJEAoQjxgxWR7i9DuCOyT4LdJ+nS+joISMXvj3PeHEu8XPFsjmfnhQH+HYTbEhlvgBUgBZSJR7syk=
X-Received: by 2002:a17:903:124c:b0:245:f85c:8c6f with SMTP id
 d9443c01a7336-2462ee8b1eemr85045175ad.3.1756139489835; Mon, 25 Aug 2025
 09:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
In-Reply-To: <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 12:31:17 -0400
X-Gm-Features: Ac12FXxRF-QMO_jk45nE0rqRfgUVWra6mb_47F0aUBXBaN_yGhLr8i97uud67wo
Message-ID: <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > <siqueira@igalia.com> wrote:
> >
> >
> > > +
> > > +First of all, note that the GC can have multiple SEs, depending on
> > > the specific
> > > +GPU/APU, and each SE has multiple Compute Units (CU). From the
> > > diagram, you can
> > > +see that CUs have a block named Schedulers. The reason the name is
> > > in plural is
> > > +because this hardware block is a combination of different micro-
> > > schedules: CP,
> > > +CPF, CPC, and CPG.
> >
> > CP is not really in the same category as CPF, CPC, CPG.  CP is the
> > front end to the GC block and contains a number of micro controllers
> > which run firmware which software interacts with.  CPF, CPG, and CPC
> > are just hardware implementation details.
>
> Can you please suggest an edit that explains these better?
>
> I'm sorry to say, I thought I understood it but after reading your
> reply now I feel I don't.

I would say something like:

The CP (Command Processor) is the front end to the GC hardware.  It
provides microcontrollers which manage command queues which are used
to feed jobs to the GFX and compute hardware.

>
> >
> > > +
> > >  The component that acts as the front end between the CPU and the
> > > GPU is called
> > > -the Command Processor (CP). This component is responsible for
> > > providing greater
> > > +CP (Command Processor). This component is responsible for
> > > providing greater
> > >  flexibility to the GC since CP makes it possible to program
> > > various aspects of
> > >  the GPU pipeline. CP also coordinates the communication between
> > > the CPU and GPU
> > >  via a mechanism named **Ring Buffers**, where the CPU appends
> > > information to
> > > -the buffer while the GPU removes operations. It is relevant to
> > > highlight that a
> > > -CPU can add a pointer to the Ring Buffer that points to another
> > > region of
> > > -memory outside the Ring Buffer, and CP can handle it; this
> > > mechanism is called
> > > -**Indirect Buffer (IB)**. CP receives and parses the Command
> > > Streams (CS), and
> > > -writes the operations to the correct hardware blocks.
> > > +the buffer while the GPU removes operations. Finally, CP is also
> > > responsible
> > > +for handling Indirect Buffers (IB).
> > > +
> > > +After CP completes the first set of processing, which includes
> > > separate command
> > > +packets specific to GFX and Compute, other blocks step in. To
> > > handle commands
> > > +for the compute block, CPC (Command Processor Command) takes over,
> > > and for
> > > +handling Graphics operations, the CPG (Command Processor Graphics)
> > > takes
> > > +action. Another essential block to ensure the optimal utilization
> > > of CPC and
> > > +CPG is the CPF (Command Processor Fetcher), which helps these
> > > blocks to be
> > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch Parser),
> > > ME
> > > +(MicroEngine), and CE (Constant Engine) in the case of chips that
> > > support it.
> > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > hardware block that
> > > +provides services to CPG and CPC.
> >
> > I'm not sure how much value this provides to the average developer.
> > These are sort of implementation details of the hardware.  In general
> > the driver doesn't really interact with the individual hardware
> > blocks
> > and they may not stay consistent over time.
> >
> > Alex
>
> Not sure what you mean by "the average developer", but I think this is
> very useful knowledge to anyone who wants to contribute to amdgpu,
> specifically to the parts that have anything to do with GFX or compute.
>
> If you're worried that it may not stay consistent over time, I think
> the glossary entries could be edited to mention which GPU generation(s)
> they apply to.
>
> As-is the code is full of 3-letter abbreviations that are never
> expanded or explained anywhere, which represent various hardware units
> (or microcontrollers, or blocks, or whatever they may be). Without
> knowing what these are and how they interact, it's difficult to
> understand what the code is doing any why, or even why some parts are
> necessary.
>
> To make matters worse, the latest public documentation that tries to
> explain any of this is from 2012. So I think it's a good idea to
> collect all of this information so that newcomers to the kernel driver
> such as myself have a chance.

The driver/developers don't interact with CPF, CPC, CPG directly.
They just happen to be arbitrary sub-blocks of the CP.  I'm concerned
that adding a lot of stuff about them will just lead to confusion.

Documenting the micro controllers which run the firmwares makes sense
as those are how the driver interacts with the CP block.

CE/PFP/ME - Microcontrollers which run the firmware that provides the
graphics command queues that the driver interacts with.
MEC - Microcontrollers which run the firmware that provides the
compute command queues that the driver interacts with.
MES - Microcontrollers which run the firmware that provides the
command queues that the driver uses to manage graphics and compute
command queues.

Alex
