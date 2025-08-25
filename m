Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4233C8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D78510E576;
	Mon, 25 Aug 2025 21:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NVrfvnZb";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055B410E576
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:18:08 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45b618b7d33so11003975e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756156686; x=1756761486; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KAGMrMvYMwQogCn6a9qOf/zVh1Ow6tgZBcyHNZXHdi0=;
 b=NVrfvnZbl8owqtJUkgr7Sn8baRYAZc6KgdjRCND7wpc4bEVGPHBrTsNe3RS/cx48Vn
 4fJxx83A/qqqDLniGSAxOsxkKLzP6WAJHe1Bg1+ttGielGdnLaU7bf2kb4u66V/vi3+d
 3NvGjCvfO5SMoCcYdlXOlUHeoJinRH3JNRh7/rDNPtDIzK3QVRto0r+uKXWK18tZ0iDT
 Ruf1Qri9K8AsLha1yfg76xwZQlSazJJuo0XVnz+1/hoLzEJC3Z4yYZayFpFZ4W7Oi+xB
 kY+qiu7z2OoZhtWmb7r/pzcPX4I0tmxImG8HMMWaU9RSzId4qE8p1V2IIjpoXMBCto37
 6QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756156686; x=1756761486;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KAGMrMvYMwQogCn6a9qOf/zVh1Ow6tgZBcyHNZXHdi0=;
 b=bzOGZbZlIvMQfn8IuF/AIjQ8hCHNXXk60UoqFkCWAtBDtXrQa7JdxgzJMn4SWyUqqM
 Dxl4AkrNtxKwv0wKYHNfoNlTxu/bpYH8/ZUyQ9bBCQjaMaQfjmtsZ5CHKxeG+/kHFWAd
 aR89yqUSe/BAHuoojJ7oNucSKA8+K0HQ7jEX4kMYgw52C0qrcYJv4+MCm0cs3NWmVAJV
 dRYKLRlanCC+aNJrq+JIaz72FAQdNDdyU52XjDFLCdENY6kg1n7niyxftyIHpjd+y6Sw
 QztiAza8+GIuK8A14aduX9bk+u3ZeM6fI1TFs87tKQEjJ/7nFCSghxUNGC/FZqHI3Eqg
 18Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdORRs6KCpB0m244U+6Jsa3Epcf3MDxj/ITkiQTSHkn+xVKtehi8c7UAp77EPKauHcSy4XUju2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4XZrKKukETRxTK768H35IECTJSEf6keBS78LhgJp+aFLdycob
 YPzHDEErph1zuVQ6XduyCrBPo+kFXX9c1ccIhAi5P1mR9JvKW1Z4vVei
X-Gm-Gg: ASbGncuAVuvjHxt+3PA+2wbP+lTOucVRmE+Jyd4h7seOqz2vwJcKqPJi9wl4JoAs8yL
 YoqPIjH1abD/uyqbXli8WPsjBtnoJx6gUQ1TzeTiRU9Aexw+rPgGAcki3LoUrK96JFkLH6AjdX/
 8uFILz0Z5pfpa1MoIp3b/51pTBftsos6+JAj+tdgLDX+z8QaKmPSpTcr3Uv9N96m89/Qd4meoc/
 VjFfrGYgoTtGxeu0M9gLJ5sHRgzDlK+Z2EUyM29q6o15BhNSsLdonlEdxb/zFyWI2E0gWwIztUt
 c8i3olT9cn5/6Ydi4molELdtnqG0G/hZlix4G9Y8tMDAEVcsLX08gGXdcM8xeOZztU2oMbszDt9
 rYqtOhfxcNl4Vp+6ZXtbpJMGgMNFVztmunMWDAJCCECyBO09QzCbI7Cc3I6ZRAfpyaL5dw3dDa2
 Y5ygB6AOZMmxrtw/YW86SKS1IFYyNSLq1C0LbPwKi6Vtr2VO4si5frq1YaPJePWQ==
X-Google-Smtp-Source: AGHT+IEDQRc5n3wqRLNCxRd4oIGMG9/WmZKoCIn52gvlbjA9D+w52DdGjifHnLgHAOwakkoZ+xDR0w==
X-Received: by 2002:a05:600c:26c6:b0:459:e165:2661 with SMTP id
 5b1f17b1804b1-45b5185a644mr79851605e9.23.1756156686241; 
 Mon, 25 Aug 2025 14:18:06 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:d571:f301:5baf:ea47?
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66c9aea7sm281235e9.5.2025.08.25.14.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:18:05 -0700 (PDT)
Message-ID: <aa05cac8b0d6cf1c328182f00c29238981e3c001.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Date: Mon, 25 Aug 2025 23:18:03 +0200
In-Reply-To: <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
 <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
 <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
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

On Mon, 2025-08-25 at 13:06 -0400, Alex Deucher wrote:
> On Mon, Aug 25, 2025 at 12:39=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> > > On Mon, Aug 25, 2025 at 12:19=E2=80=AFPM Timur Krist=C3=B3f
> > > <timur.kristof@gmail.com> wrote:
> > > >=20
> > > > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > > > On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> > > > > <siqueira@igalia.com> wrote:
> > > > >=20
> > > > >=20
> > > > > > +
> > > > > > +First of all, note that the GC can have multiple SEs,
> > > > > > depending on
> > > > > > the specific
> > > > > > +GPU/APU, and each SE has multiple Compute Units (CU). From
> > > > > > the
> > > > > > diagram, you can
> > > > > > +see that CUs have a block named Schedulers. The reason the
> > > > > > name is
> > > > > > in plural is
> > > > > > +because this hardware block is a combination of different
> > > > > > micro-
> > > > > > schedules: CP,
> > > > > > +CPF, CPC, and CPG.
> > > > >=20
> > > > > CP is not really in the same category as CPF, CPC, CPG.=C2=A0 CP
> > > > > is
> > > > > the
> > > > > front end to the GC block and contains a number of micro
> > > > > controllers
> > > > > which run firmware which software interacts with.=C2=A0 CPF, CPG,
> > > > > and
> > > > > CPC
> > > > > are just hardware implementation details.
> > > >=20
> > > > Can you please suggest an edit that explains these better?
> > > >=20
> > > > I'm sorry to say, I thought I understood it but after reading
> > > > your
> > > > reply now I feel I don't.
> > >=20
> > > I would say something like:
> > >=20
> > > The CP (Command Processor) is the front end to the GC hardware.=C2=A0
> > > It
> > > provides microcontrollers which manage command queues which are
> > > used
> > > to feed jobs to the GFX and compute hardware.
> >=20
> > Sounds good. What do you think, Siquiera?
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > > +
> > > > > > =C2=A0The component that acts as the front end between the CPU
> > > > > > and
> > > > > > the
> > > > > > GPU is called
> > > > > > -the Command Processor (CP). This component is responsible
> > > > > > for
> > > > > > providing greater
> > > > > > +CP (Command Processor). This component is responsible for
> > > > > > providing greater
> > > > > > =C2=A0flexibility to the GC since CP makes it possible to
> > > > > > program
> > > > > > various aspects of
> > > > > > =C2=A0the GPU pipeline. CP also coordinates the communication
> > > > > > between
> > > > > > the CPU and GPU
> > > > > > =C2=A0via a mechanism named **Ring Buffers**, where the CPU
> > > > > > appends
> > > > > > information to
> > > > > > -the buffer while the GPU removes operations. It is
> > > > > > relevant to
> > > > > > highlight that a
> > > > > > -CPU can add a pointer to the Ring Buffer that points to
> > > > > > another
> > > > > > region of
> > > > > > -memory outside the Ring Buffer, and CP can handle it; this
> > > > > > mechanism is called
> > > > > > -**Indirect Buffer (IB)**. CP receives and parses the
> > > > > > Command
> > > > > > Streams (CS), and
> > > > > > -writes the operations to the correct hardware blocks.
> > > > > > +the buffer while the GPU removes operations. Finally, CP
> > > > > > is
> > > > > > also
> > > > > > responsible
> > > > > > +for handling Indirect Buffers (IB).
> > > > > > +
> > > > > > +After CP completes the first set of processing, which
> > > > > > includes
> > > > > > separate command
> > > > > > +packets specific to GFX and Compute, other blocks step in.
> > > > > > To
> > > > > > handle commands
> > > > > > +for the compute block, CPC (Command Processor Command)
> > > > > > takes
> > > > > > over,
> > > > > > and for
> > > > > > +handling Graphics operations, the CPG (Command Processor
> > > > > > Graphics)
> > > > > > takes
> > > > > > +action. Another essential block to ensure the optimal
> > > > > > utilization
> > > > > > of CPC and
> > > > > > +CPG is the CPF (Command Processor Fetcher), which helps
> > > > > > these
> > > > > > blocks to be
> > > > > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch
> > > > > > Parser),
> > > > > > ME
> > > > > > +(MicroEngine), and CE (Constant Engine) in the case of
> > > > > > chips
> > > > > > that
> > > > > > support it.
> > > > > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > > > > hardware block that
> > > > > > +provides services to CPG and CPC.
> > > > >=20
> > > > > I'm not sure how much value this provides to the average
> > > > > developer.
> > > > > These are sort of implementation details of the hardware.=C2=A0 I=
n
> > > > > general
> > > > > the driver doesn't really interact with the individual
> > > > > hardware
> > > > > blocks
> > > > > and they may not stay consistent over time.
> > > > >=20
> > > > > Alex
> > > >=20
> > > > Not sure what you mean by "the average developer", but I think
> > > > this
> > > > is
> > > > very useful knowledge to anyone who wants to contribute to
> > > > amdgpu,
> > > > specifically to the parts that have anything to do with GFX or
> > > > compute.
> > > >=20
> > > > If you're worried that it may not stay consistent over time, I
> > > > think
> > > > the glossary entries could be edited to mention which GPU
> > > > generation(s)
> > > > they apply to.
> > > >=20
> > > > As-is the code is full of 3-letter abbreviations that are never
> > > > expanded or explained anywhere, which represent various
> > > > hardware
> > > > units
> > > > (or microcontrollers, or blocks, or whatever they may be).
> > > > Without
> > > > knowing what these are and how they interact, it's difficult to
> > > > understand what the code is doing any why, or even why some
> > > > parts
> > > > are
> > > > necessary.
> > > >=20
> > > > To make matters worse, the latest public documentation that
> > > > tries
> > > > to
> > > > explain any of this is from 2012. So I think it's a good idea
> > > > to
> > > > collect all of this information so that newcomers to the kernel
> > > > driver
> > > > such as myself have a chance.
> > >=20
> > > The driver/developers don't interact with CPF, CPC, CPG directly.
> > > They just happen to be arbitrary sub-blocks of the CP.=C2=A0 I'm
> > > concerned
> > > that adding a lot of stuff about them will just lead to
> > > confusion.
> >=20
> > I think they are worth a sentence or two each in the glossary.
> >=20
> > When trying to diagnose problems (eg. GPU hangs), we often need to
> > look
> > at various HW registers (eg. GRBM_STATUS), which refer to the above
> > sub-blocks. It is then hard to see what is going on without knowing
> > what these are. In turn, that makes it hard to come up with an
> > understanding that can explain what is happening on the HW.
> >=20
>=20
> I think that's fine.=C2=A0 I just don't want to put too much emphasis on
> them since they are more of an implementation detail within the CP.
> They aren't quite the same as the other blocks that make up the GC
> pipeline from a driver or debugging standpoint.

I see your point.

If you want to deemphasize these, how would you feel about mentioning
them under the CP instead of giving them their own glossary entry?

>=20
>=20
> > >=20
> > > Documenting the micro controllers which run the firmwares makes
> > > sense
> > > as those are how the driver interacts with the CP block.
> > >=20
> > > CE/PFP/ME - Microcontrollers which run the firmware that provides
> > > the
> > > graphics command queues that the driver interacts with.
> > > MEC - Microcontrollers which run the firmware that provides the
> > > compute command queues that the driver interacts with.
> > > MES - Microcontrollers which run the firmware that provides the
> > > command queues that the driver uses to manage graphics and
> > > compute
> > > command queues.
> >=20
> > I agree and I think most (all?) of these are already in the
> > glossary.
> > If not, they should be definitely added.
> >=20
> > Thanks & best regards,
> > Timur
