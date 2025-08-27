Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11748CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 16:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAA310E864;
	Wed, 27 Aug 2025 16:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EAMal2/0";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D426C10E864
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 16:56:18 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so35435e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756313777; x=1756918577; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9PPM3F1lO3JJ0JoQK7wkdfSc59Xzsqn9+qobVbwNX7o=;
 b=EAMal2/0VAlCSjYOD2yeyC7J/mIO6CrAbCYKhWj6yLH9TDRW4q31zOAY+ZYbGqulBL
 Gdwhacu16wikr0w2PqK/Nuei2dwvMfNO9lfMMIDgIzSth3Ig6i7I4aQ2bywCk5+wcBph
 QoOXPDrhWGggMdIK7QU6VJYBWstD6C+91dVKByaTJYIVHWeRuAgQO8tbP9M5Pmg4EkNj
 httMH+a4eNWL1qgaPyfuAmnOngtq9TJsSzxGrfX2b3x2+om0jfB3sOXEsTmzHqpelcld
 WrIW3gSTliaJcb5y3raM9elYaUXe1jwxomjKbN6fvDt2i+esG9DCkl6SDYCZ4qI+mlJl
 S6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756313777; x=1756918577;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9PPM3F1lO3JJ0JoQK7wkdfSc59Xzsqn9+qobVbwNX7o=;
 b=qMdp54Gmd2omeAe6n+pl6PJ2HBTlGAP0Tp5Aaiv/Z6usF4+PsFQe20l5G7rIlSEyGL
 jG33gV5TzcYUSjfa1G+p0wQp0WVd7DKdRZJZbGYDcLhwg78mU24PahTbC9VGwEsw568n
 ELPrSbqsV04+NmZ+PmYBtaoXduy7pI11Bx6R3mnBPvIFJHi+E5EAbYa4WQcJ2UUa43OI
 mbh+grERi8BCSpQa4WOnmydg9EkN58WIqXayQeeeXZRKH+DZzNdudRpSRglGIzS/vkE0
 SJN90kGyAWv9LKdB2yi8qSHtRG0OMrMCe+MZZ9qL5uBMB9UfTCyhm/uVtGLvDFx2q2Yy
 Fpwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBCC9D6sZ46lgK//M4uyIrVNWFyXYRs/pWU9LLjCLwTNGgqR9b3d1mmB8sfPJ0PP2lzhdPmLy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcUYcMvR620GmhEpw8YUkt840DF2u/pHpR6bcfb+Yw3+bs3OYD
 QoGbeRjDrZ3Pu8oKyaZrinQOv+3IWEXXsIHpZZ+BVY4UoUpoayUXuC9a
X-Gm-Gg: ASbGncu+2kfzyTM0AMdhZXulxAqmxvOaaUKEC83m5HTwae44fHop0oM1LWwtx7IpSan
 PZLM4CDKrbfrNQ7pPN1dyk+U5vM/erFybX1eOoQrnyNMvc4Q8v6IvOtK6NSW7cSe8r1NkRX+gPB
 q3Eoe0YNAXZgsk5Jy7mwlshuQjq/RLYAAr67Lg9kw97zAAZ/bZGtjL3ndkffpVsQmUxWM1iIiuL
 sDQAeg2Q4W9O45KZAxCsACnATA0dKbQpWfxQjykaxZ+zMv3HdWjnGbgriGy6spYBAGSmyZz4B7K
 ROGBB1mdflrK+8AYIJ//ejyGbU3w9tUNOOeM+NYQ2OKXDAP/vrI/W/kOcFTgpN5FTC530khY7it
 QnS5esenuwBRLEOdVCpwTNIcxpRE/1o39L/OoRXXO/ZSBiNr8bX4aiRwm+mKd4C0nj+6j84tNAX
 6DoD/U3iRJRwMoaTJUXFQWMQATREzN78PkfTXJ6fwBXAPJ2eyL6UrwUVVtyDFjTyc7oOMoOitjU
 OnJr+NqTss=
X-Google-Smtp-Source: AGHT+IGGJOQUbYSvWijvYbRGganVP0FbY+nRR/PTguSWTQraHTz3fRQM6ABUNr/TYoQTSILBGIivaw==
X-Received: by 2002:a05:600c:1c92:b0:459:db69:56bd with SMTP id
 5b1f17b1804b1-45b65ea4bacmr67161445e9.20.1756313777046; 
 Wed, 27 Aug 2025 09:56:17 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:d571:f301:5baf:ea47?
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c8f88sm42053695e9.3.2025.08.27.09.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:56:16 -0700 (PDT)
Message-ID: <b2db1683a92779d75e3ceb4ba7d4a013442d0d4d.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Date: Wed, 27 Aug 2025 18:56:15 +0200
In-Reply-To: <xrvrobdarmbaa3mfavad7oactvzzkko4uusgcph7gxcjamt343@e6tufd75cvx4>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
 <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
 <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
 <aa05cac8b0d6cf1c328182f00c29238981e3c001.camel@gmail.com>
 <CADnq5_Pz-UJRaAdGXF0yc4mzLEvE-PKuKx7n_doQ0JLgvPO4jw@mail.gmail.com>
 <xrvrobdarmbaa3mfavad7oactvzzkko4uusgcph7gxcjamt343@e6tufd75cvx4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-08-26 at 17:03 -0600, Rodrigo Siqueira wrote:
> On 08/26, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 5:18=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >=20
> > > On Mon, 2025-08-25 at 13:06 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 25, 2025 at 12:39=E2=80=AFPM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >=20
> > > > > On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> > > > > > On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f
> > > > > > <timur.kristof@gmail.com> wrote:
> > > > > > >=20
> > > > > > > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > > > > > > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > > > > > > > <siqueira@igalia.com> wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +First of all, note that the GC can have multiple
> > > > > > > > > SEs,
> > > > > > > > > depending on
> > > > > > > > > the specific
> > > > > > > > > +GPU/APU, and each SE has multiple Compute Units
> > > > > > > > > (CU). From
> > > > > > > > > the
> > > > > > > > > diagram, you can
> > > > > > > > > +see that CUs have a block named Schedulers. The
> > > > > > > > > reason the
> > > > > > > > > name is
> > > > > > > > > in plural is
> > > > > > > > > +because this hardware block is a combination of
> > > > > > > > > different
> > > > > > > > > micro-
> > > > > > > > > schedules: CP,
> > > > > > > > > +CPF, CPC, and CPG.
> > > > > > > >=20
> > > > > > > > CP is not really in the same category as CPF, CPC,
> > > > > > > > CPG.=C2=A0 CP
> > > > > > > > is
> > > > > > > > the
> > > > > > > > front end to the GC block and contains a number of
> > > > > > > > micro
> > > > > > > > controllers
> > > > > > > > which run firmware which software interacts with.=C2=A0 CPF=
,
> > > > > > > > CPG,
> > > > > > > > and
> > > > > > > > CPC
> > > > > > > > are just hardware implementation details.
> > > > > > >=20
> > > > > > > Can you please suggest an edit that explains these
> > > > > > > better?
> > > > > > >=20
> > > > > > > I'm sorry to say, I thought I understood it but after
> > > > > > > reading
> > > > > > > your
> > > > > > > reply now I feel I don't.
> > > > > >=20
> > > > > > I would say something like:
> > > > > >=20
> > > > > > The CP (Command Processor) is the front end to the GC
> > > > > > hardware.
> > > > > > It
> > > > > > provides microcontrollers which manage command queues which
> > > > > > are
> > > > > > used
> > > > > > to feed jobs to the GFX and compute hardware.
> > > > >=20
> > > > > Sounds good. What do you think, Siquiera?
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > +
> > > > > > > > > =C2=A0The component that acts as the front end between th=
e
> > > > > > > > > CPU
> > > > > > > > > and
> > > > > > > > > the
> > > > > > > > > GPU is called
> > > > > > > > > -the Command Processor (CP). This component is
> > > > > > > > > responsible
> > > > > > > > > for
> > > > > > > > > providing greater
> > > > > > > > > +CP (Command Processor). This component is
> > > > > > > > > responsible for
> > > > > > > > > providing greater
> > > > > > > > > =C2=A0flexibility to the GC since CP makes it possible to
> > > > > > > > > program
> > > > > > > > > various aspects of
> > > > > > > > > =C2=A0the GPU pipeline. CP also coordinates the
> > > > > > > > > communication
> > > > > > > > > between
> > > > > > > > > the CPU and GPU
> > > > > > > > > =C2=A0via a mechanism named **Ring Buffers**, where the
> > > > > > > > > CPU
> > > > > > > > > appends
> > > > > > > > > information to
> > > > > > > > > -the buffer while the GPU removes operations. It is
> > > > > > > > > relevant to
> > > > > > > > > highlight that a
> > > > > > > > > -CPU can add a pointer to the Ring Buffer that points
> > > > > > > > > to
> > > > > > > > > another
> > > > > > > > > region of
> > > > > > > > > -memory outside the Ring Buffer, and CP can handle
> > > > > > > > > it; this
> > > > > > > > > mechanism is called
> > > > > > > > > -**Indirect Buffer (IB)**. CP receives and parses the
> > > > > > > > > Command
> > > > > > > > > Streams (CS), and
> > > > > > > > > -writes the operations to the correct hardware
> > > > > > > > > blocks.
> > > > > > > > > +the buffer while the GPU removes operations.
> > > > > > > > > Finally, CP
> > > > > > > > > is
> > > > > > > > > also
> > > > > > > > > responsible
> > > > > > > > > +for handling Indirect Buffers (IB).
> > > > > > > > > +
> > > > > > > > > +After CP completes the first set of processing,
> > > > > > > > > which
> > > > > > > > > includes
> > > > > > > > > separate command
> > > > > > > > > +packets specific to GFX and Compute, other blocks
> > > > > > > > > step in.
> > > > > > > > > To
> > > > > > > > > handle commands
> > > > > > > > > +for the compute block, CPC (Command Processor
> > > > > > > > > Command)
> > > > > > > > > takes
> > > > > > > > > over,
> > > > > > > > > and for
> > > > > > > > > +handling Graphics operations, the CPG (Command
> > > > > > > > > Processor
> > > > > > > > > Graphics)
> > > > > > > > > takes
> > > > > > > > > +action. Another essential block to ensure the
> > > > > > > > > optimal
> > > > > > > > > utilization
> > > > > > > > > of CPC and
> > > > > > > > > +CPG is the CPF (Command Processor Fetcher), which
> > > > > > > > > helps
> > > > > > > > > these
> > > > > > > > > blocks to be
> > > > > > > > > +constantly fed. Note that CPG contains the PFP (Pre-
> > > > > > > > > Fetch
> > > > > > > > > Parser),
> > > > > > > > > ME
> > > > > > > > > +(MicroEngine), and CE (Constant Engine) in the case
> > > > > > > > > of
> > > > > > > > > chips
> > > > > > > > > that
> > > > > > > > > support it.
> > > > > > > > > +CPC contains MEC (MicroEngine Compute), and CPF is
> > > > > > > > > another
> > > > > > > > > hardware block that
> > > > > > > > > +provides services to CPG and CPC.
> > > > > > > >=20
> > > > > > > > I'm not sure how much value this provides to the
> > > > > > > > average
> > > > > > > > developer.
> > > > > > > > These are sort of implementation details of the
> > > > > > > > hardware.=C2=A0 In
> > > > > > > > general
> > > > > > > > the driver doesn't really interact with the individual
> > > > > > > > hardware
> > > > > > > > blocks
> > > > > > > > and they may not stay consistent over time.
> > > > > > > >=20
> > > > > > > > Alex
> > > > > > >=20
> > > > > > > Not sure what you mean by "the average developer", but I
> > > > > > > think
> > > > > > > this
> > > > > > > is
> > > > > > > very useful knowledge to anyone who wants to contribute
> > > > > > > to
> > > > > > > amdgpu,
> > > > > > > specifically to the parts that have anything to do with
> > > > > > > GFX or
> > > > > > > compute.
> > > > > > >=20
> > > > > > > If you're worried that it may not stay consistent over
> > > > > > > time, I
> > > > > > > think
> > > > > > > the glossary entries could be edited to mention which GPU
> > > > > > > generation(s)
> > > > > > > they apply to.
> > > > > > >=20
> > > > > > > As-is the code is full of 3-letter abbreviations that are
> > > > > > > never
> > > > > > > expanded or explained anywhere, which represent various
> > > > > > > hardware
> > > > > > > units
> > > > > > > (or microcontrollers, or blocks, or whatever they may
> > > > > > > be).
> > > > > > > Without
> > > > > > > knowing what these are and how they interact, it's
> > > > > > > difficult to
> > > > > > > understand what the code is doing any why, or even why
> > > > > > > some
> > > > > > > parts
> > > > > > > are
> > > > > > > necessary.
> > > > > > >=20
> > > > > > > To make matters worse, the latest public documentation
> > > > > > > that
> > > > > > > tries
> > > > > > > to
> > > > > > > explain any of this is from 2012. So I think it's a good
> > > > > > > idea
> > > > > > > to
> > > > > > > collect all of this information so that newcomers to the
> > > > > > > kernel
> > > > > > > driver
> > > > > > > such as myself have a chance.
> > > > > >=20
> > > > > > The driver/developers don't interact with CPF, CPC, CPG
> > > > > > directly.
> > > > > > They just happen to be arbitrary sub-blocks of the CP.=C2=A0 I'=
m
> > > > > > concerned
> > > > > > that adding a lot of stuff about them will just lead to
> > > > > > confusion.
> > > > >=20
> > > > > I think they are worth a sentence or two each in the
> > > > > glossary.
> > > > >=20
> > > > > When trying to diagnose problems (eg. GPU hangs), we often
> > > > > need to
> > > > > look
> > > > > at various HW registers (eg. GRBM_STATUS), which refer to the
> > > > > above
> > > > > sub-blocks. It is then hard to see what is going on without
> > > > > knowing
> > > > > what these are. In turn, that makes it hard to come up with
> > > > > an
> > > > > understanding that can explain what is happening on the HW.
> > > > >=20
> > > >=20
> > > > I think that's fine.=C2=A0 I just don't want to put too much
> > > > emphasis on
> > > > them since they are more of an implementation detail within the
> > > > CP.
> > > > They aren't quite the same as the other blocks that make up the
> > > > GC
> > > > pipeline from a driver or debugging standpoint.
> > >=20
> > > I see your point.
> > >=20
> > > If you want to deemphasize these, how would you feel about
> > > mentioning
> > > them under the CP instead of giving them their own glossary
> > > entry?
> > >=20
> >=20
> > Sure.=C2=A0 I think that is fine.=C2=A0 How about something like:
> >=20
> > For reference, internally the CP consists of several sub-blocks
> > (CPC -
> > CP compute, CPG - CP graphics, and CPF - CP fetcher).=C2=A0 Some of
> > these
> > acronyms appear in register names, but this is more of an
> > implementation detail and not something that directly impacts
> > driver
> > programming or debugging directly.
>=20
>=20
> Hi Alex, Timur,
>=20
> I attempted to incorporate all the points from the discussion into
> the
> version of the text below. The main points are:
>=20
> 1. Added a link to the CU image.
> 1. Removed the reference to CP from the micro-schedules part.
> 3. Rewrite the last paragraph just to mention components like CPG,
> CPC,
> etc.
>=20
> Let me know what you think.
>=20
> New version:
>=20
> .. kernel-figure:: cu.svg
> =3D=3D=3D> https://people.igalia.com/siqueira/kernel-doc-imgs/cu.svg
>=20

I think this is mixed up and doesn't look right to me.

First, WGP (workgroup processor) is only relevant on GFX10+ (that is,
Navi 10 or newer). CU (compute unit) is something that all GCN and RDNA
GPUs have. These are already well documented publicly, and I don't
think we need another diagram for them.

For reference, you can find a diagram of a GCN CU on page 5 here:
https://www.amd.com/content/dam/amd/en/documents/radeon-tech-docs/instructi=
on-set-architectures/vega-7nm-shader-instruction-set-architecture.pdf
And a diagram of an RDNA WGP on page 6 here:
https://www.amd.com/content/dam/amd/en/documents/radeon-tech-docs/instructi=
on-set-architectures/rdna4-instruction-set-architecture.pdf

The above diagrams do mention commands processors although not in
detail. As you can see, the command processors are not part of a CU.
Rather, they can generate work for the various CUs/WGPs.

As far as I understand, there is only one of each CP per queue (or per
pipe, I am somewhat mixed up myself about the differences between a
queue and a pipe). For example, each compute queue has its own MEC, and
any MEC can launch work on any CU.

Please correct me if I'm wrong about it.

Timur


> First of all, note that the GC can have multiple SEs, depending on
> the specific
> GPU/APU, and each SE has multiple Compute Units (CU). From the
> diagram, you can
> see that CUs have a block named Schedulers. The reason the name is in
> plural is
> because this hardware block is a combination of different micro-
> schedules: CPF,
> CPC, and CPG.
>=20
> The component that acts as the front end between the CPU and the GPU
> is called
> CP (Command Processor). This component is responsible for providing
> greater
> flexibility to the GC since CP makes it possible to program various
> aspects of
> the GPU pipeline. CP also coordinates the communication between the
> CPU and GPU
> via a mechanism named **Ring Buffers**, where the CPU appends
> information to
> the buffer while the GPU removes operations. Finally, CP is also
> responsible
> for handling Indirect Buffers (IB).
>=20
> After CP completes the first set of processing, which includes
> separate command
> packets specific to GFX and Compute, other blocks step in. For
> reference,
> internally the CP consists of several sub-blocks (CPC - CP compute,
> CPG - CP
> graphics, and CPF - CP fetcher).=C2=A0 Some of these acronyms appear in
> register
> names, but this is more of an implementation detail and not something
> that
> directly impacts driver programming or debugging directly.
>=20
> Thanks
>=20
> >=20
> > Alex
> >=20
> >=20
> > > >=20
> > > >=20
> > > > > >=20
> > > > > > Documenting the micro controllers which run the firmwares
> > > > > > makes
> > > > > > sense
> > > > > > as those are how the driver interacts with the CP block.
> > > > > >=20
> > > > > > CE/PFP/ME - Microcontrollers which run the firmware that
> > > > > > provides
> > > > > > the
> > > > > > graphics command queues that the driver interacts with.
> > > > > > MEC - Microcontrollers which run the firmware that provides
> > > > > > the
> > > > > > compute command queues that the driver interacts with.
> > > > > > MES - Microcontrollers which run the firmware that provides
> > > > > > the
> > > > > > command queues that the driver uses to manage graphics and
> > > > > > compute
> > > > > > command queues.
> > > > >=20
> > > > > I agree and I think most (all?) of these are already in the
> > > > > glossary.
> > > > > If not, they should be definitely added.
> > > > >=20
> > > > > Thanks & best regards,
> > > > > Timur
