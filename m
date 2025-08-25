Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA82CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 16:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F6A10E2D4;
	Mon, 25 Aug 2025 16:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KhNEf8SF";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D1F10E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 16:19:53 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3c79f0a606eso1119867f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756138792; x=1756743592; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wNmQTOi0u0Ui8GK0zYhS5iuUmD12/Cq4THCzPS+p7Rg=;
 b=KhNEf8SFso+he5vo0hdCXqFWeFKx9+4o9NQFYUFiQSbuCoptQ6AUdl3ZG61nQ+Gd5l
 +Y916/ZdFj5Nvw2IYsBpfARnVmaOlTOZU8a9+VAOY1BAWtyOkAQIODSCTNhpdcRMHcaO
 B06roMF/Osh8wt/TBv2gIWJdW4ZSOFlwBVV8/RzX1oKfZgZHhgeYBJhEj1NefDh4UxCh
 sV0lmSw/IRwpUHpDtl6WrQ/DFw+sjoRQGUnaTArRQnNqoIZEyda+OwO3XD+eiyxqF7z0
 MCjfTPDLBWlUO59I5kKgiDwaDU2eIv6M/9ODFa22qMQpEoiQTY2V92d5vkj99sq6nZRn
 M8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756138792; x=1756743592;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wNmQTOi0u0Ui8GK0zYhS5iuUmD12/Cq4THCzPS+p7Rg=;
 b=ke2xTPQPTgsFhIhBuFtnjr8rvX//e6xETSvBf9Rx+6gjQFLftAzJ55ayFUM88IExm0
 Vk5b7dLIkuGJzfiMo9p7KVcgjB3CJLxRg9S8gQvZ5nf9xu6YoAkPHce9JU+0IFMpWWcX
 8K14XcVz/IabQrmUfxtflPQytC3vtr9o95SRQ3DKzqvQ03kKKC7kGPQpbVStrF9i1uK6
 VpHzW72nEMp9Yf2q0wDcyT9iZIPtYn0JAcJuqp6xXT/C4sjoD3YNY1szkC5Bc6YCrzlT
 A7peIm04Wtq6Icr6aln5mijhfP4R/7n4UjrDK9NXLLBHZWEgI5EhGwynZ3EVeBR2uHqG
 hfyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb+jlglGeBTAvb+kPEX4sfuj2s/154vJNSUzXW2yhnJVvdQJhW7iVRT4yalp1zEZoPcjHGahn0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyaixlw0GPpnlZ1OyOG9Eua0w/JmHY8PEpAXuEDve5Bqvb6C6S0
 tsEfbfZ2aa84vBvFlCL2Le+Pdev/KVQLRRvE9ZdllqOJGfsNzfJT2OOB
X-Gm-Gg: ASbGncv7MQ856KUnytrFtZSEQLniYazmGhcq0k0oLxN1v4/jHRGUK2WHnBq6nqpPtzU
 mxYqXcrzlOyQtIbyJm872S2ms9OmRLVxBLNK1QjktRbVC3jU1gLc6W65LMZ2bmSD9tXQU9PUc2Z
 xidcY5JH3VURijQd6KM/mXUuznnKTNVGv8T58yfql93PUrSIcjFEzWZtT1lj1qQxgJ2RIZS/8yp
 846XpRxhQWg5u6t3j3a01GNPlSfU/V1EyjmCWpCCNL4AGhLgxiMFTRxr8WatQs7ntoNUA6T4A/a
 bpcex2ZWvgp02uDUOZDJgU6urBt+ebQwPwqwQxdnDOkVuMge3ukk2ylUHZ20eoJjzyZeBFKtV4x
 L4QLoHQV118Nc4halGRWrv+urluMIeoyJgcHh3l7/bufuv97ix6RTLYrx794h8LRg1GTjjmaGko
 CIHyC9oqPOerd8nmM7nS6XH67IQ2fd6DfscsLCsgHKoi2/xVmHIM6xFQUbwSw+xQ==
X-Google-Smtp-Source: AGHT+IH5Z7zbBJX5aLRRaOBMpaqOwtptrsvfOmliWLWS/Q3JAuC1TjZ6q42+xNB50lfqfMv5fDcDEA==
X-Received: by 2002:a5d:64e7:0:b0:3c9:4e1f:ef45 with SMTP id
 ffacd0b85a97d-3c94e1ff62fmr3143788f8f.17.1756138792024; 
 Mon, 25 Aug 2025 09:19:52 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:d571:f301:5baf:ea47?
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba390sm12744946f8f.12.2025.08.25.09.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 09:19:51 -0700 (PDT)
Message-ID: <440097d6c1ba4fb304227f54e01455b1733864b2.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Date: Mon, 25 Aug 2025 18:19:50 +0200
In-Reply-To: <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
 <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
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

On Mon, 2025-08-25 at 11:38 -0400, Alex Deucher wrote:
> On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira
> <siqueira@igalia.com> wrote:
>=20
>=20
> > +
> > +First of all, note that the GC can have multiple SEs, depending on
> > the specific
> > +GPU/APU, and each SE has multiple Compute Units (CU). From the
> > diagram, you can
> > +see that CUs have a block named Schedulers. The reason the name is
> > in plural is
> > +because this hardware block is a combination of different micro-
> > schedules: CP,
> > +CPF, CPC, and CPG.
>=20
> CP is not really in the same category as CPF, CPC, CPG.=C2=A0 CP is the
> front end to the GC block and contains a number of micro controllers
> which run firmware which software interacts with.=C2=A0 CPF, CPG, and CPC
> are just hardware implementation details.

Can you please suggest an edit that explains these better?

I'm sorry to say, I thought I understood it but after reading your
reply now I feel I don't.

>=20
> > +
> > =C2=A0The component that acts as the front end between the CPU and the
> > GPU is called
> > -the Command Processor (CP). This component is responsible for
> > providing greater
> > +CP (Command Processor). This component is responsible for
> > providing greater
> > =C2=A0flexibility to the GC since CP makes it possible to program
> > various aspects of
> > =C2=A0the GPU pipeline. CP also coordinates the communication between
> > the CPU and GPU
> > =C2=A0via a mechanism named **Ring Buffers**, where the CPU appends
> > information to
> > -the buffer while the GPU removes operations. It is relevant to
> > highlight that a
> > -CPU can add a pointer to the Ring Buffer that points to another
> > region of
> > -memory outside the Ring Buffer, and CP can handle it; this
> > mechanism is called
> > -**Indirect Buffer (IB)**. CP receives and parses the Command
> > Streams (CS), and
> > -writes the operations to the correct hardware blocks.
> > +the buffer while the GPU removes operations. Finally, CP is also
> > responsible
> > +for handling Indirect Buffers (IB).
> > +
> > +After CP completes the first set of processing, which includes
> > separate command
> > +packets specific to GFX and Compute, other blocks step in. To
> > handle commands
> > +for the compute block, CPC (Command Processor Command) takes over,
> > and for
> > +handling Graphics operations, the CPG (Command Processor Graphics)
> > takes
> > +action. Another essential block to ensure the optimal utilization
> > of CPC and
> > +CPG is the CPF (Command Processor Fetcher), which helps these
> > blocks to be
> > +constantly fed. Note that CPG contains the PFP (Pre-Fetch Parser),
> > ME
> > +(MicroEngine), and CE (Constant Engine) in the case of chips that
> > support it.
> > +CPC contains MEC (MicroEngine Compute), and CPF is another
> > hardware block that
> > +provides services to CPG and CPC.
>=20
> I'm not sure how much value this provides to the average developer.
> These are sort of implementation details of the hardware.=C2=A0 In genera=
l
> the driver doesn't really interact with the individual hardware
> blocks
> and they may not stay consistent over time.
>=20
> Alex

Not sure what you mean by "the average developer", but I think this is
very useful knowledge to anyone who wants to contribute to amdgpu,
specifically to the parts that have anything to do with GFX or compute.

If you're worried that it may not stay consistent over time, I think
the glossary entries could be edited to mention which GPU generation(s)
they apply to.

As-is the code is full of 3-letter abbreviations that are never
expanded or explained anywhere, which represent various hardware units
(or microcontrollers, or blocks, or whatever they may be). Without
knowing what these are and how they interact, it's difficult to
understand what the code is doing any why, or even why some parts are
necessary.

To make matters worse, the latest public documentation that tries to
explain any of this is from 2012. So I think it's a good idea to
collect all of this information so that newcomers to the kernel driver
such as myself have a chance.

Thanks & best regards,
Timur
