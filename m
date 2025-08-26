Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AFFCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 13:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1345410E150;
	Tue, 26 Aug 2025 13:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kWE0f+IA";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8182710E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:21:19 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-24602f6d8b6so10109365ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756214479; x=1756819279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ethIJcXO/6V6yoZIPli+XEUvHcLTBHUhA9onanJZ2YU=;
 b=kWE0f+IAwpM/uDkuB7UfRypKQCt13TID6oOl5/A9jco/X1JcjkSfz35BbeWARoLXkz
 dwb4ZmlqTqqFeRs7CYoJupPe4KlzbzU6G3xmElPkxy+XyRDDfr96cOFXpyXtJVp6UAk0
 NlH1I/6BcVsY3egSHwU71zpZyiI+yiDGLMoFDoOZjV7sp/1cz1bJ3IlojPLB8fnxQUP8
 tYcs9CNG2Bx43vnvF0kNcdv7H8li9pPfJJbooQJhjOsUJkI5FkL7r7Z1MMmnvos8JdId
 rckuiYKJZEX+mGqYJGwdj6tmMwN+mcmV74jyg9vYQ1vJBrh07WyfnNB5SY6jw1d8wg63
 NnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756214479; x=1756819279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ethIJcXO/6V6yoZIPli+XEUvHcLTBHUhA9onanJZ2YU=;
 b=Pg1zvwcvyYH2HPpoaGieQrFgVkSRG4a/WFXGzn+JH6IJm7FBr+umIZIyZw97ncxO09
 nXDn/khd0NuG4CKYu9QoZ9ohC/F3oSZqte8P53hzQdVSaobIdVfJrjVpCcchg3oK5SsZ
 B91C/r+v2jgz1eZW9w0NDBIiYwQu9M9XT9T9YpZsU06lgAJ7iwwXVhhJLY3L/+V3Vx7N
 UJXHUxUyNkt5r4inNJN5Hv7eEtDIVs8lDyfKoKcr/3jw/uAoLoKZfFeUO4cjxIiB4qmC
 +djwT0NLIWQiM+cIUsrqkflMjMhMw6uqciFVBCuZpkV2O8uhofyaczujLkc/06m/SYop
 ULmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVEAVp9AojRrXvBnuBIbMqWUFlRq9jOs6t7SerJy1WvYS8BGXyDM9Y987FhSxq3jAo2CtM4U+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE1b/2BWyzLPMQwX+MTa/LMvKQeYeHNRNFpdTVHmF+EGkTu6jU
 h93zMcGSyaQUwLhqBe/97WUIYXUeGXq/oasrbxDBJU7baR+DJ5VQVq3scJXSXrvreXwK0ltt5Zu
 y3b7HdJIBA8BVkFZIYTBFgDA259oxqEsT3Q==
X-Gm-Gg: ASbGncsTXbu3+ZuMsZFvtVCKXS374YsRnELfRU/gVPK2pPqtwWiMrV5TqZnvyXzZ53I
 eT5XRD29TpyEFZGJVL4EUPCWZ5G0vzD+xf3pLlQ/kjzyyhaBnhqJbLJEPMku52bl+w1SY7q7uef
 xyiD42AS2eCTo93Q5QueVzHQISNzR7kzSL6RS6y06N8FKBj9eMFt5XS/bLTNndl5UeIKEzTh/qu
 1N1elKv+TZsoFZDkw==
X-Google-Smtp-Source: AGHT+IGAJ54/ncb+pAx1i8y1MndrLjRoe+4r9dOTjAOGHRvZjTxVZqGWKQ6jFSqTiMl+AYGgaJkxO7LYO+gIZpEuRdk=
X-Received: by 2002:a17:902:cf09:b0:240:729c:a022 with SMTP id
 d9443c01a7336-24630427edbmr114005035ad.11.1756214478808; Tue, 26 Aug 2025
 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
 <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
 <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
 <aa05cac8b0d6cf1c328182f00c29238981e3c001.camel@gmail.com>
In-Reply-To: <aa05cac8b0d6cf1c328182f00c29238981e3c001.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 09:21:06 -0400
X-Gm-Features: Ac12FXy1xD7pI8hk_j7HLUnbZ90OJRcOdC0zuknuxeEpfnztUzCyttx5vDW42Ww
Message-ID: <CADnq5_Pz-UJRaAdGXF0yc4mzLEvE-PKuKx7n_doQ0JLgvPO4jw@mail.gmail.com>
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

On Mon, Aug 25, 2025 at 5:18=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-25 at 13:06 -0400, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 12:39=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >
> > > > > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > > > > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > > > > > <siqueira@igalia.com> wrote:
> > > > > >
> > > > > >
> > > > > > > +
> > > > > > > +First of all, note that the GC can have multiple SEs,
> > > > > > > depending on
> > > > > > > the specific
> > > > > > > +GPU/APU, and each SE has multiple Compute Units (CU). From
> > > > > > > the
> > > > > > > diagram, you can
> > > > > > > +see that CUs have a block named Schedulers. The reason the
> > > > > > > name is
> > > > > > > in plural is
> > > > > > > +because this hardware block is a combination of different
> > > > > > > micro-
> > > > > > > schedules: CP,
> > > > > > > +CPF, CPC, and CPG.
> > > > > >
> > > > > > CP is not really in the same category as CPF, CPC, CPG.  CP
> > > > > > is
> > > > > > the
> > > > > > front end to the GC block and contains a number of micro
> > > > > > controllers
> > > > > > which run firmware which software interacts with.  CPF, CPG,
> > > > > > and
> > > > > > CPC
> > > > > > are just hardware implementation details.
> > > > >
> > > > > Can you please suggest an edit that explains these better?
> > > > >
> > > > > I'm sorry to say, I thought I understood it but after reading
> > > > > your
> > > > > reply now I feel I don't.
> > > >
> > > > I would say something like:
> > > >
> > > > The CP (Command Processor) is the front end to the GC hardware.
> > > > It
> > > > provides microcontrollers which manage command queues which are
> > > > used
> > > > to feed jobs to the GFX and compute hardware.
> > >
> > > Sounds good. What do you think, Siquiera?
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > >  The component that acts as the front end between the CPU
> > > > > > > and
> > > > > > > the
> > > > > > > GPU is called
> > > > > > > -the Command Processor (CP). This component is responsible
> > > > > > > for
> > > > > > > providing greater
> > > > > > > +CP (Command Processor). This component is responsible for
> > > > > > > providing greater
> > > > > > >  flexibility to the GC since CP makes it possible to
> > > > > > > program
> > > > > > > various aspects of
> > > > > > >  the GPU pipeline. CP also coordinates the communication
> > > > > > > between
> > > > > > > the CPU and GPU
> > > > > > >  via a mechanism named **Ring Buffers**, where the CPU
> > > > > > > appends
> > > > > > > information to
> > > > > > > -the buffer while the GPU removes operations. It is
> > > > > > > relevant to
> > > > > > > highlight that a
> > > > > > > -CPU can add a pointer to the Ring Buffer that points to
> > > > > > > another
> > > > > > > region of
> > > > > > > -memory outside the Ring Buffer, and CP can handle it; this
> > > > > > > mechanism is called
> > > > > > > -**Indirect Buffer (IB)**. CP receives and parses the
> > > > > > > Command
> > > > > > > Streams (CS), and
> > > > > > > -writes the operations to the correct hardware blocks.
> > > > > > > +the buffer while the GPU removes operations. Finally, CP
> > > > > > > is
> > > > > > > also
> > > > > > > responsible
> > > > > > > +for handling Indirect Buffers (IB).
> > > > > > > +
> > > > > > > +After CP completes the first set of processing, which
> > > > > > > includes
> > > > > > > separate command
> > > > > > > +packets specific to GFX and Compute, other blocks step in.
> > > > > > > To
> > > > > > > handle commands
> > > > > > > +for the compute block, CPC (Command Processor Command)
> > > > > > > takes
> > > > > > > over,
> > > > > > > and for
> > > > > > > +handling Graphics operations, the CPG (Command Processor
> > > > > > > Graphics)
> > > > > > > takes
> > > > > > > +action. Another essential block to ensure the optimal
> > > > > > > utilization
> > > > > > > of CPC and
> > > > > > > +CPG is the CPF (Command Processor Fetcher), which helps
> > > > > > > these
> > > > > > > blocks to be
> > > > > > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch
> > > > > > > Parser),
> > > > > > > ME
> > > > > > > +(MicroEngine), and CE (Constant Engine) in the case of
> > > > > > > chips
> > > > > > > that
> > > > > > > support it.
> > > > > > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > > > > > hardware block that
> > > > > > > +provides services to CPG and CPC.
> > > > > >
> > > > > > I'm not sure how much value this provides to the average
> > > > > > developer.
> > > > > > These are sort of implementation details of the hardware.  In
> > > > > > general
> > > > > > the driver doesn't really interact with the individual
> > > > > > hardware
> > > > > > blocks
> > > > > > and they may not stay consistent over time.
> > > > > >
> > > > > > Alex
> > > > >
> > > > > Not sure what you mean by "the average developer", but I think
> > > > > this
> > > > > is
> > > > > very useful knowledge to anyone who wants to contribute to
> > > > > amdgpu,
> > > > > specifically to the parts that have anything to do with GFX or
> > > > > compute.
> > > > >
> > > > > If you're worried that it may not stay consistent over time, I
> > > > > think
> > > > > the glossary entries could be edited to mention which GPU
> > > > > generation(s)
> > > > > they apply to.
> > > > >
> > > > > As-is the code is full of 3-letter abbreviations that are never
> > > > > expanded or explained anywhere, which represent various
> > > > > hardware
> > > > > units
> > > > > (or microcontrollers, or blocks, or whatever they may be).
> > > > > Without
> > > > > knowing what these are and how they interact, it's difficult to
> > > > > understand what the code is doing any why, or even why some
> > > > > parts
> > > > > are
> > > > > necessary.
> > > > >
> > > > > To make matters worse, the latest public documentation that
> > > > > tries
> > > > > to
> > > > > explain any of this is from 2012. So I think it's a good idea
> > > > > to
> > > > > collect all of this information so that newcomers to the kernel
> > > > > driver
> > > > > such as myself have a chance.
> > > >
> > > > The driver/developers don't interact with CPF, CPC, CPG directly.
> > > > They just happen to be arbitrary sub-blocks of the CP.  I'm
> > > > concerned
> > > > that adding a lot of stuff about them will just lead to
> > > > confusion.
> > >
> > > I think they are worth a sentence or two each in the glossary.
> > >
> > > When trying to diagnose problems (eg. GPU hangs), we often need to
> > > look
> > > at various HW registers (eg. GRBM_STATUS), which refer to the above
> > > sub-blocks. It is then hard to see what is going on without knowing
> > > what these are. In turn, that makes it hard to come up with an
> > > understanding that can explain what is happening on the HW.
> > >
> >
> > I think that's fine.  I just don't want to put too much emphasis on
> > them since they are more of an implementation detail within the CP.
> > They aren't quite the same as the other blocks that make up the GC
> > pipeline from a driver or debugging standpoint.
>
> I see your point.
>
> If you want to deemphasize these, how would you feel about mentioning
> them under the CP instead of giving them their own glossary entry?
>

Sure.  I think that is fine.  How about something like:

For reference, internally the CP consists of several sub-blocks (CPC -
CP compute, CPG - CP graphics, and CPF - CP fetcher).  Some of these
acronyms appear in register names, but this is more of an
implementation detail and not something that directly impacts driver
programming or debugging directly.

Alex


> >
> >
> > > >
> > > > Documenting the micro controllers which run the firmwares makes
> > > > sense
> > > > as those are how the driver interacts with the CP block.
> > > >
> > > > CE/PFP/ME - Microcontrollers which run the firmware that provides
> > > > the
> > > > graphics command queues that the driver interacts with.
> > > > MEC - Microcontrollers which run the firmware that provides the
> > > > compute command queues that the driver interacts with.
> > > > MES - Microcontrollers which run the firmware that provides the
> > > > command queues that the driver uses to manage graphics and
> > > > compute
> > > > command queues.
> > >
> > > I agree and I think most (all?) of these are already in the
> > > glossary.
> > > If not, they should be definitely added.
> > >
> > > Thanks & best regards,
> > > Timur
