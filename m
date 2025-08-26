Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBADCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 23:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8FF10E6D7;
	Tue, 26 Aug 2025 23:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qGl8kJ/M";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4124A10E6E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 23:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z2th3AMaLcAkOah8AWfVr0vcyDVENaNk6339RBek6eQ=; b=qGl8kJ/M882DlKAtaHnaJLPPcm
 43v87m9SmKs0p4Go9bKZqV15d0ePXShxQlz4/V2ZVnRj2JRzHsFd6zrOL8X5zNDvsbfs7VQFRuWMc
 LpfBO3vQ6jX3+p2fW24Y50+zkxYvReM7MHoAiwzTy4lxkIau5monVFDo2ItU56loAkjoY4ENvqo41
 C7yEEEReTd9BBkeOazYKngZH+eCHr2N/lKj2HdzsSL8XJUn0MZoWn9qfP//4mJdxZW9BpqYZ6Ls/w
 u4rresqlOPttUOuX6WmUuYS+84dfmYzPCCrpSo7YVgh8uIrdhqkcMnhoJHYdnqoNYbqVfZxH4HUJv
 FcL7AEGw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ur2hW-0029Hd-GP; Wed, 27 Aug 2025 01:03:38 +0200
Date: Tue, 26 Aug 2025 17:03:34 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
Message-ID: <xrvrobdarmbaa3mfavad7oactvzzkko4uusgcph7gxcjamt343@e6tufd75cvx4>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
 <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
 <CADnq5_NJHzS5_GsqL6HLe0XZ0hwVi7yJvWi7ZmRMPfMYM8i0Fw@mail.gmail.com>
 <e774ec6c0de87b8dee088303b252119ace3a1c52.camel@gmail.com>
 <CADnq5_NUv-sJ0forP7R2V3Gv5PMN-NGNF9UoOyh0QTfdwKp0Nw@mail.gmail.com>
 <aa05cac8b0d6cf1c328182f00c29238981e3c001.camel@gmail.com>
 <CADnq5_Pz-UJRaAdGXF0yc4mzLEvE-PKuKx7n_doQ0JLgvPO4jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pz-UJRaAdGXF0yc4mzLEvE-PKuKx7n_doQ0JLgvPO4jw@mail.gmail.com>
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

On 08/26, Alex Deucher wrote:
> On Mon, Aug 25, 2025 at 5:18 PM Timur Kristóf <timur.kristof@gmail.com> wrote:
> >
> > On Mon, 2025-08-25 at 13:06 -0400, Alex Deucher wrote:
> > > On Mon, Aug 25, 2025 at 12:39 PM Timur Kristóf
> > > <timur.kristof@gmail.com> wrote:
> > > >
> > > > On Mon, 2025-08-25 at 12:31 -0400, Alex Deucher wrote:
> > > > > On Mon, Aug 25, 2025 at 12:19 PM Timur Kristóf
> > > > > <timur.kristof@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> > > > > > > On Sun, Aug 24, 2025 at 7:43 PM Rodrigo Siqueira
> > > > > > > <siqueira@igalia.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +First of all, note that the GC can have multiple SEs,
> > > > > > > > depending on
> > > > > > > > the specific
> > > > > > > > +GPU/APU, and each SE has multiple Compute Units (CU). From
> > > > > > > > the
> > > > > > > > diagram, you can
> > > > > > > > +see that CUs have a block named Schedulers. The reason the
> > > > > > > > name is
> > > > > > > > in plural is
> > > > > > > > +because this hardware block is a combination of different
> > > > > > > > micro-
> > > > > > > > schedules: CP,
> > > > > > > > +CPF, CPC, and CPG.
> > > > > > >
> > > > > > > CP is not really in the same category as CPF, CPC, CPG.  CP
> > > > > > > is
> > > > > > > the
> > > > > > > front end to the GC block and contains a number of micro
> > > > > > > controllers
> > > > > > > which run firmware which software interacts with.  CPF, CPG,
> > > > > > > and
> > > > > > > CPC
> > > > > > > are just hardware implementation details.
> > > > > >
> > > > > > Can you please suggest an edit that explains these better?
> > > > > >
> > > > > > I'm sorry to say, I thought I understood it but after reading
> > > > > > your
> > > > > > reply now I feel I don't.
> > > > >
> > > > > I would say something like:
> > > > >
> > > > > The CP (Command Processor) is the front end to the GC hardware.
> > > > > It
> > > > > provides microcontrollers which manage command queues which are
> > > > > used
> > > > > to feed jobs to the GFX and compute hardware.
> > > >
> > > > Sounds good. What do you think, Siquiera?
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > >  The component that acts as the front end between the CPU
> > > > > > > > and
> > > > > > > > the
> > > > > > > > GPU is called
> > > > > > > > -the Command Processor (CP). This component is responsible
> > > > > > > > for
> > > > > > > > providing greater
> > > > > > > > +CP (Command Processor). This component is responsible for
> > > > > > > > providing greater
> > > > > > > >  flexibility to the GC since CP makes it possible to
> > > > > > > > program
> > > > > > > > various aspects of
> > > > > > > >  the GPU pipeline. CP also coordinates the communication
> > > > > > > > between
> > > > > > > > the CPU and GPU
> > > > > > > >  via a mechanism named **Ring Buffers**, where the CPU
> > > > > > > > appends
> > > > > > > > information to
> > > > > > > > -the buffer while the GPU removes operations. It is
> > > > > > > > relevant to
> > > > > > > > highlight that a
> > > > > > > > -CPU can add a pointer to the Ring Buffer that points to
> > > > > > > > another
> > > > > > > > region of
> > > > > > > > -memory outside the Ring Buffer, and CP can handle it; this
> > > > > > > > mechanism is called
> > > > > > > > -**Indirect Buffer (IB)**. CP receives and parses the
> > > > > > > > Command
> > > > > > > > Streams (CS), and
> > > > > > > > -writes the operations to the correct hardware blocks.
> > > > > > > > +the buffer while the GPU removes operations. Finally, CP
> > > > > > > > is
> > > > > > > > also
> > > > > > > > responsible
> > > > > > > > +for handling Indirect Buffers (IB).
> > > > > > > > +
> > > > > > > > +After CP completes the first set of processing, which
> > > > > > > > includes
> > > > > > > > separate command
> > > > > > > > +packets specific to GFX and Compute, other blocks step in.
> > > > > > > > To
> > > > > > > > handle commands
> > > > > > > > +for the compute block, CPC (Command Processor Command)
> > > > > > > > takes
> > > > > > > > over,
> > > > > > > > and for
> > > > > > > > +handling Graphics operations, the CPG (Command Processor
> > > > > > > > Graphics)
> > > > > > > > takes
> > > > > > > > +action. Another essential block to ensure the optimal
> > > > > > > > utilization
> > > > > > > > of CPC and
> > > > > > > > +CPG is the CPF (Command Processor Fetcher), which helps
> > > > > > > > these
> > > > > > > > blocks to be
> > > > > > > > +constantly fed. Note that CPG contains the PFP (Pre-Fetch
> > > > > > > > Parser),
> > > > > > > > ME
> > > > > > > > +(MicroEngine), and CE (Constant Engine) in the case of
> > > > > > > > chips
> > > > > > > > that
> > > > > > > > support it.
> > > > > > > > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > > > > > > > hardware block that
> > > > > > > > +provides services to CPG and CPC.
> > > > > > >
> > > > > > > I'm not sure how much value this provides to the average
> > > > > > > developer.
> > > > > > > These are sort of implementation details of the hardware.  In
> > > > > > > general
> > > > > > > the driver doesn't really interact with the individual
> > > > > > > hardware
> > > > > > > blocks
> > > > > > > and they may not stay consistent over time.
> > > > > > >
> > > > > > > Alex
> > > > > >
> > > > > > Not sure what you mean by "the average developer", but I think
> > > > > > this
> > > > > > is
> > > > > > very useful knowledge to anyone who wants to contribute to
> > > > > > amdgpu,
> > > > > > specifically to the parts that have anything to do with GFX or
> > > > > > compute.
> > > > > >
> > > > > > If you're worried that it may not stay consistent over time, I
> > > > > > think
> > > > > > the glossary entries could be edited to mention which GPU
> > > > > > generation(s)
> > > > > > they apply to.
> > > > > >
> > > > > > As-is the code is full of 3-letter abbreviations that are never
> > > > > > expanded or explained anywhere, which represent various
> > > > > > hardware
> > > > > > units
> > > > > > (or microcontrollers, or blocks, or whatever they may be).
> > > > > > Without
> > > > > > knowing what these are and how they interact, it's difficult to
> > > > > > understand what the code is doing any why, or even why some
> > > > > > parts
> > > > > > are
> > > > > > necessary.
> > > > > >
> > > > > > To make matters worse, the latest public documentation that
> > > > > > tries
> > > > > > to
> > > > > > explain any of this is from 2012. So I think it's a good idea
> > > > > > to
> > > > > > collect all of this information so that newcomers to the kernel
> > > > > > driver
> > > > > > such as myself have a chance.
> > > > >
> > > > > The driver/developers don't interact with CPF, CPC, CPG directly.
> > > > > They just happen to be arbitrary sub-blocks of the CP.  I'm
> > > > > concerned
> > > > > that adding a lot of stuff about them will just lead to
> > > > > confusion.
> > > >
> > > > I think they are worth a sentence or two each in the glossary.
> > > >
> > > > When trying to diagnose problems (eg. GPU hangs), we often need to
> > > > look
> > > > at various HW registers (eg. GRBM_STATUS), which refer to the above
> > > > sub-blocks. It is then hard to see what is going on without knowing
> > > > what these are. In turn, that makes it hard to come up with an
> > > > understanding that can explain what is happening on the HW.
> > > >
> > >
> > > I think that's fine.  I just don't want to put too much emphasis on
> > > them since they are more of an implementation detail within the CP.
> > > They aren't quite the same as the other blocks that make up the GC
> > > pipeline from a driver or debugging standpoint.
> >
> > I see your point.
> >
> > If you want to deemphasize these, how would you feel about mentioning
> > them under the CP instead of giving them their own glossary entry?
> >
> 
> Sure.  I think that is fine.  How about something like:
> 
> For reference, internally the CP consists of several sub-blocks (CPC -
> CP compute, CPG - CP graphics, and CPF - CP fetcher).  Some of these
> acronyms appear in register names, but this is more of an
> implementation detail and not something that directly impacts driver
> programming or debugging directly.


Hi Alex, Timur,

I attempted to incorporate all the points from the discussion into the
version of the text below. The main points are:

1. Added a link to the CU image.
1. Removed the reference to CP from the micro-schedules part.
3. Rewrite the last paragraph just to mention components like CPG, CPC,
etc.

Let me know what you think.

New version:

.. kernel-figure:: cu.svg
===> https://people.igalia.com/siqueira/kernel-doc-imgs/cu.svg

First of all, note that the GC can have multiple SEs, depending on the specific
GPU/APU, and each SE has multiple Compute Units (CU). From the diagram, you can
see that CUs have a block named Schedulers. The reason the name is in plural is
because this hardware block is a combination of different micro-schedules: CPF,
CPC, and CPG.

The component that acts as the front end between the CPU and the GPU is called
CP (Command Processor). This component is responsible for providing greater
flexibility to the GC since CP makes it possible to program various aspects of
the GPU pipeline. CP also coordinates the communication between the CPU and GPU
via a mechanism named **Ring Buffers**, where the CPU appends information to
the buffer while the GPU removes operations. Finally, CP is also responsible
for handling Indirect Buffers (IB).

After CP completes the first set of processing, which includes separate command
packets specific to GFX and Compute, other blocks step in. For reference,
internally the CP consists of several sub-blocks (CPC - CP compute, CPG - CP
graphics, and CPF - CP fetcher).  Some of these acronyms appear in register
names, but this is more of an implementation detail and not something that
directly impacts driver programming or debugging directly.

Thanks

> 
> Alex
> 
> 
> > >
> > >
> > > > >
> > > > > Documenting the micro controllers which run the firmwares makes
> > > > > sense
> > > > > as those are how the driver interacts with the CP block.
> > > > >
> > > > > CE/PFP/ME - Microcontrollers which run the firmware that provides
> > > > > the
> > > > > graphics command queues that the driver interacts with.
> > > > > MEC - Microcontrollers which run the firmware that provides the
> > > > > compute command queues that the driver interacts with.
> > > > > MES - Microcontrollers which run the firmware that provides the
> > > > > command queues that the driver uses to manage graphics and
> > > > > compute
> > > > > command queues.
> > > >
> > > > I agree and I think most (all?) of these are already in the
> > > > glossary.
> > > > If not, they should be definitely added.
> > > >
> > > > Thanks & best regards,
> > > > Timur

-- 
Rodrigo Siqueira
