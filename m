Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5447CCA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 17:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C5D10E26E;
	Mon, 25 Aug 2025 17:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWjSm0Mu";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC1810E26E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 17:06:38 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24498e93b8fso5722685ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756141598; x=1756746398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoOyaqYMMD+Pln4gfGwsz0XO1lThs9tV0FQug41vwFo=;
 b=HWjSm0MuSZdtcg6ICQRWCeKN5g/8MgkDbuav6p1rDeBhegOGogqJlvn0+uhAJPbXg+
 NH8ucHzO6m+MfGkmUmnb2iDuT4LwRkY5XkBx9PVAF761RA1bZjTFwGqXpjcPzotgZeg5
 axyRvMTOakMHrZsAPDpYU2W2c2wxibKM6TcPCF74100/DtkV+gYD7sCBBeOQ43Cdacx0
 n14Ygq3m8dK+Ybmmu+0u+zh2ob3a+z8SdtrL5yQLr3CRYt14T9m2OB6nP9YGV/FPmvPG
 +NEGdCSoxq1oahiX5lGGvCfCj9RxSVDx7ZVlj8mmlCkuPYOLG0VNOZ9phbVCxxAIed++
 8SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756141598; x=1756746398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoOyaqYMMD+Pln4gfGwsz0XO1lThs9tV0FQug41vwFo=;
 b=hZcmrUbXIhCp5OMlGzApN7LOq1SS02zNkvwRKpXCtlr/dNCXzwhiLwcCjm09d6f5qo
 2JeMu5yU8MiYzm6jnsFZjruIgVIqZNkt1lfcnJI16vsd12i+w9laZo2NADfYCFgmavAr
 IWZbeaOJ4GzPMIJ7CfbgEWekg5/letV3aDX73sQlbYuqklWYR1RQxdbaopJCQHNeGiWQ
 uvEyzhDUECGw/+aKX9LkNI6JQZW4DbOsQ3ikZ58AUvohMMadqfe/sLtKTmaDBu0HV8Md
 vOY1Kr6vxvyMyIdJ9Zx7un1Vq2S9+vH1HYj4VgGYuHUuH8kuk3H5s13AstiqFYcVxSmZ
 eBXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU88mWUfUjZlqMA74f2jLlqrSNZuvufbEiTjx2j9OBeLcCzSYnmj6Y1kEf6yXiRA+LRqyw23yM4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytJ6TH1d392dXe2xQHXSxusED9Uma19yPTRwB1BKHLX1JONw2Y
 sQIicbEsmWXP/aTpf2SzDdW7tkkXVBjM6ngrM0n6F1xpQEOuRu8sTm7nzPqY0qIPr4mousVG4iZ
 IZVpalL7lswhSW7QfPq6tesnpSarXh67Is+OK
X-Gm-Gg: ASbGncupjeqiPyOVvxFoeFAuTGxChjUWHpJo+RFic8TIz9XsJe8AQHfT+pWQ7X6IHGf
 JJVgcVK8ntCfv6ks3Cz+2AlFIGOF2feYQudtrnds/dW4WLxzQmp7XIYIsF8BZvfKxoZaRJNan0k
 MvufiWa0bMMZd4r5PLa4iy7HhVwD3qFRWPGQ+x2WfFfdqvIlN5xG6xeUlcgGvhlZX7/fo675vEs
 OyK5eo=
X-Google-Smtp-Source: AGHT+IHGaKRbqWufjqCLNbj48PZi7lh5uWI7ghQDcqeZuRuvroW7CSjtdWl7Bw7GJz7cNSz7+Pn3h4AjOYO7aX1PlEg=
X-Received: by 2002:a17:902:e5d1:b0:246:9df4:d10 with SMTP id
 d9443c01a7336-2469df4127fmr50634815ad.8.1756141597773; Mon, 25 Aug 2025
 10:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
 <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
In-Reply-To: <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 13:06:26 -0400
X-Gm-Features: Ac12FXz6JvutYfDEVwDJLC-hq243NeiyQkWnRcF8_YNgwpeXiwWGKX0O_kDKfpA
Message-ID: <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
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

On Mon, Aug 25, 2025 at 12:39=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > > > <siqueira@igalia.com> wrote:
> > > >
> > > >
> > > > > +
> > > > > +First of all, note that the GC can have multiple SEs,
> > > > > depending on
> > > > > the specific
> > > > > +GPU/APU, and each SE has multiple Compute Units (CU). From the
> > > > > diagram, you can
> > > > > +see that CUs have a block named Schedulers. The reason the
> > > > > name is
> > > > > in plural is
> > > > > +because this hardware block is a combination of different
> > > > > micro-
> > > > > schedules: CP,
> > > > > +CPF, CPC, and CPG.
> > > >
> > > > CP is not really in the same category as CPF, CPC, CPG.  CP is
> > > > the
> > > > front end to the GC block and contains a number of micro
> > > > controllers
> > > > which run firmware which software interacts with.  CPF, CPG, and
> > > > CPC
> > > > are just hardware implementation details.
> > >
> > > Can you please suggest an edit that explains these better?
> > >
> > > I'm sorry to say, I thought I understood it but after reading your
> > > reply now I feel I don't.
> >
> > I would say something like:
> >
> > The CP (Command Processor) is the front end to the GC hardware.  It
> > provides microcontrollers which manage command queues which are used
> > to feed jobs to the GFX and compute hardware.
>
> Sounds good. What do you think, Siquiera?
>
> >
> > >
> > > >
> > > > > +
> > > > >  The component that acts as the front end between the CPU and
> > > > > the
> > > > > GPU is called
> > > > > -the Command Processor (CP). This component is responsible for
> > > > > providing greater
> > > > > +CP (Command Processor). This component is responsible for
> > > > > providing greater
> > > > >  flexibility to the GC since CP makes it possible to program
> > > > > various aspects of
> > > > >  the GPU pipeline. CP also coordinates the communication
> > > > > between
> > > > > the CPU and GPU
> > > > >  via a mechanism named **Ring Buffers**, where the CPU appends
> > > > > information to
> > > > > -the buffer while the GPU removes operations. It is relevant to
> > > > > highlight that a
> > > > > -CPU can add a pointer to the Ring Buffer that points to
> > > > > another
> > > > > region of
> > > > > -memory outside the Ring Buffer, and CP can handle it; this
> > > > > mechanism is called
> > > > > -**Indirect Buffer (IB)**. CP receives and parses the Command
> > > > > Streams (CS), and
> > > > > -writes the operations to the correct hardware blocks.
> > > > > +the buffer while the GPU removes operations. Finally, CP is
> > > > > also
> > > > > responsible
> > > > > +for handling Indirect Buffers (IB).
> > > > > +
> > > > > +After CP completes the first set of processing, which includes
> > > > > separate command
> > > > > +packets specific to GFX and Compute, other blocks step in. To
> > > > > handle commands
> > > > > +for the compute block, CPC (Command Processor Command) takes
> > > > > over,
> > > > > and for
> > > > > +handling Graphics operations, the CPG (Command Processor
> > > > > Graphics)
> > > > > takes
> > > > > +action. Another essential block to ensure the optimal
> > > > > utilization
> > > > > of CPC and
> > > > > +CPG is the CPF (Command Processor Fetcher), which helps these
> > > > > blocks to be
> > > > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch
> > > > > Parser),
> > > > > ME
> > > > > +(MicroEngine), and CE (Constant Engine) in the case of chips
> > > > > that
> > > > > support it.
> > > > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > > > hardware block that
> > > > > +provides services to CPG and CPC.
> > > >
> > > > I'm not sure how much value this provides to the average
> > > > developer.
> > > > These are sort of implementation details of the hardware.  In
> > > > general
> > > > the driver doesn't really interact with the individual hardware
> > > > blocks
> > > > and they may not stay consistent over time.
> > > >
> > > > Alex
> > >
> > > Not sure what you mean by "the average developer", but I think this
> > > is
> > > very useful knowledge to anyone who wants to contribute to amdgpu,
> > > specifically to the parts that have anything to do with GFX or
> > > compute.
> > >
> > > If you're worried that it may not stay consistent over time, I
> > > think
> > > the glossary entries could be edited to mention which GPU
> > > generation(s)
> > > they apply to.
> > >
> > > As-is the code is full of 3-letter abbreviations that are never
> > > expanded or explained anywhere, which represent various hardware
> > > units
> > > (or microcontrollers, or blocks, or whatever they may be). Without
> > > knowing what these are and how they interact, it's difficult to
> > > understand what the code is doing any why, or even why some parts
> > > are
> > > necessary.
> > >
> > > To make matters worse, the latest public documentation that tries
> > > to
> > > explain any of this is from 2012. So I think it's a good idea to
> > > collect all of this information so that newcomers to the kernel
> > > driver
> > > such as myself have a chance.
> >
> > The driver/developers don't interact with CPF, CPC, CPG directly.
> > They just happen to be arbitrary sub-blocks of the CP.  I'm concerned
> > that adding a lot of stuff about them will just lead to confusion.
>
> I think they are worth a sentence or two each in the glossary.
>
> When trying to diagnose problems (eg. GPU hangs), we often need to look
> at various HW registers (eg. GRBM_STATUS), which refer to the above
> sub-blocks. It is then hard to see what is going on without knowing
> what these are. In turn, that makes it hard to come up with an
> understanding that can explain what is happening on the HW.
>

I think that's fine.  I just don't want to put too much emphasis on
them since they are more of an implementation detail within the CP.
They aren't quite the same as the other blocks that make up the GC
pipeline from a driver or debugging standpoint.


> >
> > Documenting the micro controllers which run the firmwares makes sense
> > as those are how the driver interacts with the CP block.
> >
> > CE/PFP/ME - Microcontrollers which run the firmware that provides the
> > graphics command queues that the driver interacts with.
> > MEC - Microcontrollers which run the firmware that provides the
> > compute command queues that the driver interacts with.
> > MES - Microcontrollers which run the firmware that provides the
> > command queues that the driver uses to manage graphics and compute
> > command queues.
>
> I agree and I think most (all?) of these are already in the glossary.
> If not, they should be definitely added.
>
> Thanks & best regards,
> Timur
