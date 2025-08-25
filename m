Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE61CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 16:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B4F10E273;
	Mon, 25 Aug 2025 16:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J/Wag+EN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A30810E273
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 16:39:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso25455975e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756139963; x=1756744763; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k8gtLdReXPA76WF549gEjGBhPvB4qsMuZg32uKZYBeM=;
 b=J/Wag+ENBCnYKcE0xUVmAdKfxgTBsIBjZv5EGS9pagkWNrXIT+MCQxZ1bp3Jx29wKM
 wkOBUbYertqpH76YsHFY+uPdLaqtxBWYe00B9DkVlAY6mQ3P9zHYrPBC9/ZAgIfSAl6a
 22CXzFSO66g2WA/QOYtBJcU1uFinYYCqV9vasQcSxsvVabaBKwlOc1xQhXBE0l//yatS
 /p9q5IF2POc11z8FS0pN+RAx6Dg6UymJAjTzCeXYvqANO6xjETQQ7JdL2rYR5M0r40+s
 94kGXl4l4a62pGjluNmh7tL+TxeimsSiBH/EwJq+5r10tN85kOD1kY/5o2+ppwfrxWzl
 JlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756139963; x=1756744763;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8gtLdReXPA76WF549gEjGBhPvB4qsMuZg32uKZYBeM=;
 b=i0nX7ZtbjRYbQ5/gGikln9wpDN2YUdvRS7iU1K8oHkTBbl6ougOZRZUEBAa6DQD62Y
 6m6OheH1kCeNBo8EaiZR6skuwwPTOAdBE/MzpvXGH4GsVz0lpeeNOQ5fMuaGNldUu/30
 nNTpL0rlFO6cS8jijKwa9ZN7JmZsaUJK03avmPjrHVZ4Mlh9/KlNIt/jZ4JJOV1mJZ4U
 MxwxiveicKip+GAbtpJE0WN/kMyuqZMD++7n1Wtb/uJsu9/gpD7YITQiTCD8fA+HeAV6
 rVjXl2lHbjkpz7/UmxY0Am2pcqnLyIjPxuNTIa4qYVfJEp5gd1wWScr3QpSb0p+1uAnA
 u5aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCX6olpqAseNk6ZB8NjcYEXdBmi+NcXx8eAfA/0d0r/9mOrJ27/wotbvi2pArFwhKT063NSJNP@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr4G6JVZJj5i/2Tz2r96zYeoNjbTegmFaY4mAHP1k+MRwWWm1a
 nbJOJYvfUVNoVRMFM1QmGU5SIp9bqXtG2z2Ls3LFHETFoB9HFw8ihxPm
X-Gm-Gg: ASbGncsMQiVyymPhEXgqILFhto8gaCr14xiuYLESZnvjs/rOeWLA9v2yK8tCoylX7oP
 +NS1/oGeCynyBS2TPGtjRIpdAv//g0NRj+UD3HD/ka6qjOCM8LvSiFST9Rfi1Om68N+vy7Is3vU
 MaLDApiAc0ceNFdbb65+bgE+oVkug/fnSg2gw0LRs4UAUYtgKLQ1+TNWxzCiaihEf8CmLgZFS1w
 QoeDkvsptr22q5o1LBor+02PaJPE9jdQjG+qvjjEd/P9vf6v5LUxaoNiWXgdZ9gfA9ybFfH/lAP
 k+/2PusmLlLEwyr+xplBs8vl48To+eYD/BBWpO2DAsjjMP9J//HgmgsfLzoGRdZJcXPJkOb/fXM
 rN7MkwVhMJPboFdwdRS0JbdXwiiW8Gz905MK3i9WVROfSr1AndTa8Qqv4mCa+fC4/VrTZ0sgu+6
 DPZvFt+cjG4bZNS6pFQWt8Kb9ZcH0uHrTsCTly5rpQv/Ag2uO53ZKIIzNr26YTnmAE6lKIAosX
X-Google-Smtp-Source: AGHT+IE6aiRfi0b+YNfoy8kEDa3odUTeWfLGp63/2CN2ebu6OvGAEQo2LCveNg8X79rzH7rPIf11+A==
X-Received: by 2002:a05:600c:4509:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-45b517d06d4mr128446055e9.24.1756139962556; 
 Mon, 25 Aug 2025 09:39:22 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:d571:f301:5baf:ea47?
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b598cc42asm60920635e9.1.2025.08.25.09.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 09:39:22 -0700 (PDT)
Message-ID: <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Date: Mon, 25 Aug 2025 18:39:20 +0200
In-Reply-To: <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
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

On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > > <siqueira@igalia.com> wrote:
> > >=20
> > >=20
> > > > +
> > > > +First of all, note that the GC can have multiple SEs,
> > > > depending on
> > > > the specific
> > > > +GPU/APU, and each SE has multiple Compute Units (CU). From the
> > > > diagram, you can
> > > > +see that CUs have a block named Schedulers. The reason the
> > > > name is
> > > > in plural is
> > > > +because this hardware block is a combination of different
> > > > micro-
> > > > schedules: CP,
> > > > +CPF, CPC, and CPG.
> > >=20
> > > CP is not really in the same category as CPF, CPC, CPG.=C2=A0 CP is
> > > the
> > > front end to the GC block and contains a number of micro
> > > controllers
> > > which run firmware which software interacts with.=C2=A0 CPF, CPG, and
> > > CPC
> > > are just hardware implementation details.
> >=20
> > Can you please suggest an edit that explains these better?
> >=20
> > I'm sorry to say, I thought I understood it but after reading your
> > reply now I feel I don't.
>=20
> I would say something like:
>=20
> The CP (Command Processor) is the front end to the GC hardware.=C2=A0 It
> provides microcontrollers which manage command queues which are used
> to feed jobs to the GFX and compute hardware.

Sounds good. What do you think, Siquiera?

>=20
> >=20
> > >=20
> > > > +
> > > > =C2=A0The component that acts as the front end between the CPU and
> > > > the
> > > > GPU is called
> > > > -the Command Processor (CP). This component is responsible for
> > > > providing greater
> > > > +CP (Command Processor). This component is responsible for
> > > > providing greater
> > > > =C2=A0flexibility to the GC since CP makes it possible to program
> > > > various aspects of
> > > > =C2=A0the GPU pipeline. CP also coordinates the communication
> > > > between
> > > > the CPU and GPU
> > > > =C2=A0via a mechanism named **Ring Buffers**, where the CPU appends
> > > > information to
> > > > -the buffer while the GPU removes operations. It is relevant to
> > > > highlight that a
> > > > -CPU can add a pointer to the Ring Buffer that points to
> > > > another
> > > > region of
> > > > -memory outside the Ring Buffer, and CP can handle it; this
> > > > mechanism is called
> > > > -**Indirect Buffer (IB)**. CP receives and parses the Command
> > > > Streams (CS), and
> > > > -writes the operations to the correct hardware blocks.
> > > > +the buffer while the GPU removes operations. Finally, CP is
> > > > also
> > > > responsible
> > > > +for handling Indirect Buffers (IB).
> > > > +
> > > > +After CP completes the first set of processing, which includes
> > > > separate command
> > > > +packets specific to GFX and Compute, other blocks step in. To
> > > > handle commands
> > > > +for the compute block, CPC (Command Processor Command) takes
> > > > over,
> > > > and for
> > > > +handling Graphics operations, the CPG (Command Processor
> > > > Graphics)
> > > > takes
> > > > +action. Another essential block to ensure the optimal
> > > > utilization
> > > > of CPC and
> > > > +CPG is the CPF (Command Processor Fetcher), which helps these
> > > > blocks to be
> > > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch
> > > > Parser),
> > > > ME
> > > > +(MicroEngine), and CE (Constant Engine) in the case of chips
> > > > that
> > > > support it.
> > > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > > hardware block that
> > > > +provides services to CPG and CPC.
> > >=20
> > > I'm not sure how much value this provides to the average
> > > developer.
> > > These are sort of implementation details of the hardware.=C2=A0 In
> > > general
> > > the driver doesn't really interact with the individual hardware
> > > blocks
> > > and they may not stay consistent over time.
> > >=20
> > > Alex
> >=20
> > Not sure what you mean by "the average developer", but I think this
> > is
> > very useful knowledge to anyone who wants to contribute to amdgpu,
> > specifically to the parts that have anything to do with GFX or
> > compute.
> >=20
> > If you're worried that it may not stay consistent over time, I
> > think
> > the glossary entries could be edited to mention which GPU
> > generation(s)
> > they apply to.
> >=20
> > As-is the code is full of 3-letter abbreviations that are never
> > expanded or explained anywhere, which represent various hardware
> > units
> > (or microcontrollers, or blocks, or whatever they may be). Without
> > knowing what these are and how they interact, it's difficult to
> > understand what the code is doing any why, or even why some parts
> > are
> > necessary.
> >=20
> > To make matters worse, the latest public documentation that tries
> > to
> > explain any of this is from 2012. So I think it's a good idea to
> > collect all of this information so that newcomers to the kernel
> > driver
> > such as myself have a chance.
>=20
> The driver/developers don't interact with CPF, CPC, CPG directly.
> They just happen to be arbitrary sub-blocks of the CP.=C2=A0 I'm concerne=
d
> that adding a lot of stuff about them will just lead to confusion.

I think they are worth a sentence or two each in the glossary.

When trying to diagnose problems (eg. GPU hangs), we often need to look
at various HW registers (eg. GRBM_STATUS), which refer to the above
sub-blocks. It is then hard to see what is going on without knowing
what these are. In turn, that makes it hard to come up with an
understanding that can explain what is happening on the HW.

>=20
> Documenting the micro controllers which run the firmwares makes sense
> as those are how the driver interacts with the CP block.
>=20
> CE/PFP/ME - Microcontrollers which run the firmware that provides the
> graphics command queues that the driver interacts with.
> MEC - Microcontrollers which run the firmware that provides the
> compute command queues that the driver interacts with.
> MES - Microcontrollers which run the firmware that provides the
> command queues that the driver uses to manage graphics and compute
> command queues.

I agree and I think most (all?) of these are already in the glossary.
If not, they should be definitely added.

Thanks & best regards,
Timur
