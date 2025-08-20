Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA2CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 14:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7925310E77A;
	Wed, 20 Aug 2025 14:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BYBDZ3f4";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D97110E77A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:59:17 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so27965e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755701956; x=1756306756; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o7KH7OX9QUxmxAY8HZsfKaxCpqJBed+Zh5eDqIMrH0s=;
 b=BYBDZ3f47+mRfxSvfqqi0d4sLxlpIHWXYMDwqfag7TtWB+I0pzXIH24gf3dHWwVscb
 HKpYhyxgxE4OQP46R3Rrvh32woUMWU0cPPEmFL4sQ0jVaPyS62fWqoFs1ilLYvXbvmUh
 Otq/cEt9U03GFMa71YRETU5A7sA1A4aL4TfSrEllDbBQQ7fKIoVbR2v9RDgIG72T7EAr
 bEKy8I6gdZGVhun6vYR12x9hCqXrt6qTdg2zBJvCweLAiL6Ef5LHwF1odPeI0nNL2hKw
 YlwTryC8u06qTBSaOSAtp/XX/qdd09dC8ljX7qWWm8/p99US6ZIStzqKsMhZ+MUv16qD
 QWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755701956; x=1756306756;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7KH7OX9QUxmxAY8HZsfKaxCpqJBed+Zh5eDqIMrH0s=;
 b=BR/Ekhcdjh0SWDUc3dwHUHftsVNWsFcBvSSyeMBc0S6Vsa7OFRkybn2NbfMzYh2p9O
 8gOIYH3Hv3oCdRrNrejfdoY/rm03P2HxZ79xNNblzceiyjyMRDkq+RK2ASEGPG23Ev1c
 PA0yidbErDHJ0B3yWv0j5z7vp04LYOIBPNoeo4TnoNFLtCVjG6uNqHf7x3waw8AHQ6wJ
 qw+Q6xFRYx13g4FND9iEOCCWUVf2WZBDx92G8bBaouqssZGsjlQ9Cyxrj2/8g6EJEYR7
 g+69dg3dKnmaqlI+VL1VGX1ek8LCyFii+2kU6XAq7ntptdsGHhjFyrG1XqV5JSlqQ16B
 LlBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXAZKxqYXpV+k6aDtlIuDO4e6s1HeFrxumiv2vaOCwG3RrjiCa6JhvXTypU5y8w1hJYvRN2da@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhpNlTqMvzqiJSHIc59JOR0gv522GF64Cv94qO/BBPz7hT8bMD
 OHx6om1fZP6xKolBYEmSWpjIOEcLB2LbQgSe18YUENAlaYaRCrGIpCcb
X-Gm-Gg: ASbGnctwG5SgNRF+qe8nfjdxX/R+g8akps8K8J4R24nTrS3R9bNsluX47YrMVp/5WPq
 KNe3lKkDzqztCw0a5akRoiH9cId2cX/+8YdRLfhDXB9yo03XRP+9ExsOoa7MglngqnqmiA49A7N
 k3LkSQjYPg/oVN2Pt9XEUTowuH+6WBfZBNzFL4mJJLmeFh+6r90vMOlLnYa01aawAYnKAvRXzOl
 husWYbxatU+NV596DxijVAlDlznbZ6dYaTeZyZnUst4gym50SKnFVelyggLnt8DS8XPhaLQCr6A
 hCv/8VofS7yCfF+paQXui29xlJgWQxV8cqiPBEV9kL3F1tbdGyHpxc0MwDedhVwGNJPjLbcVLMw
 kg6eiXdtEm1hMVdiWOFDHPhQ53Xg7Z/M5fXsKuLdSaik6d/8Z3m6E+k/hFUJslTCtStYQgPmS5Z
 4x+d+W1Z+sec4SQFeRPmQj1KhTcgCeAtTjNzgjV9NUOVZHQbdJllzba0JRTD1c6cbHV2w=
X-Google-Smtp-Source: AGHT+IEhsKgLapOYp8Fo7Dj1J3QiOp1+mjAuW+WDNUXFkcGjgDA5+TlgIlfL7Vt/1oqEdFrCod5WCQ==
X-Received: by 2002:a05:600c:3b85:b0:459:db88:c4ca with SMTP id
 5b1f17b1804b1-45b43e5da51mr60211465e9.3.1755701955727; 
 Wed, 20 Aug 2025 07:59:15 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d9:d00:e837:7025:20a0:bf2?
 (20014C4E24D90D00E837702520A00BF2.dsl.pool.telekom.hu.
 [2001:4c4e:24d9:d00:e837:7025:20a0:bf2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c42cf1sm38993105e9.12.2025.08.20.07.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:59:15 -0700 (PDT)
Message-ID: <498ab5568b1050cc629fb28101370430ec1c14f3.camel@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/gpu: Add new glossary entries from UMR
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Date: Wed, 20 Aug 2025 16:59:14 +0200
In-Reply-To: <CADnq5_M8nEKSVu_2w6P34GBxYHfNzjL_7Ff1GW_Sy6KT-7FmmQ@mail.gmail.com>
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-3-siqueira@igalia.com>
 <ddd650e7d6887103c6c91ff89d81411bdf4d0a8e.camel@gmail.com>
 <CADnq5_M8nEKSVu_2w6P34GBxYHfNzjL_7Ff1GW_Sy6KT-7FmmQ@mail.gmail.com>
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

On Tue, 2025-08-19 at 16:14 -0400, Alex Deucher wrote:
> On Tue, Aug 19, 2025 at 3:28=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Hi,
> >=20
> > On Sat, 2025-08-16 at 09:31 -0600, Rodrigo Siqueira wrote:
> > > When using UMR, a dashboard is available that displays the CPC,
> > > CPF,
> > > CPG, TCP, and UTCL utilization. This commit introduces the
> > > meanings
> > > of
> > > those acronyms (and others) to the glossary to improve the
> > > comprehension
> > > of the UMR dashboard.
> > >=20
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > > =C2=A0Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21
> > > ++++++++++++++++++++
> > > =C2=A01 file changed, 21 insertions(+)
> > >=20
> > > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > index 30812d9d53c6..eb72e6f6d4f1 100644
> > > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core
> > > at
> > > =C2=A0=C2=A0=C2=A0=C2=A0 CP
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 CPC
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Compute
> > > +
> > > +=C2=A0=C2=A0=C2=A0 CPF
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Fetch
> > > +
> > > +=C2=A0=C2=A0=C2=A0 CPG
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command Processor Graphics
> > > +
> >=20
> > I would apprectiate a few more details here to connect these to
> > other
> > glossary items. Here are a few questions:
> >=20
> > - Is CPC the same as MEC?
> > - Is CPF the same as PFP?
> > - Is CPG the same as ME?
>=20
> CPC, CPF, and CPG are hardware blocks, MEC/PFP/ME are
> microcontrollers.=C2=A0 CPG contains the PFP and ME (and CE on chips whic=
h
> support it).=C2=A0 CPC contains MEC.=C2=A0 CPF is another hardware block =
which
> provides services to CPG and CPC.

Thanks for the clarification.

Siquiera - could we add that also to the glossary?

Thanks,
Timur

>=20
>=20
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 CPLIB
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Content Protection Library
> > >=20
> > > @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core
> > > at
> > > =C2=A0=C2=A0=C2=A0=C2=A0 GMC
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Graphic Memory Controller
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 GPR
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 General Purpose Register
> > > +
> >=20
> > Does this refer to registers in shaders or registers in the various
> > IP
> > blocks? If this is about shaders, it would be useful to mention
> > that in
> > the context of shaders, a GPR is either SGPR or VGPR. (Those two
> > are
> > already in the glossary.)
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 GPUVM
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPU Virtual Memory.=C2=A0 This i=
s the GPU's MMU.=C2=A0 The GPU
> > > supports
> > > multiple
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtual address spaces that can =
be in flight at any given
> > > time.=C2=A0 These
> > > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core
> > > at
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 table for use by the kernel driv=
er or into per process
> > > GPUVM
> > > page tables
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for application usage.
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 GWS
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Global Wave Syncs
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0 IH
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt Handler
> > >=20
> > > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display
> > > Core
> > > at
> > > =C2=A0=C2=A0=C2=A0=C2=A0 TC
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Texture Cache
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 TCP (AMDGPU)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Texture Cache Processing
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0 TOC
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Table of Contents
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 UMSCH
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 User Mode Scheduler
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 UTCL
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Universal Texture Cache Line
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0 UVD
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Unified Video Decoder
> > >=20
