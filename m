Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480FCCCD1A7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 14:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C8F10E60A;
	Tue, 21 Oct 2025 14:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZXjUZ4qJ";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568C610E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 14:46:44 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-76e2ea21430so421997b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761058004; x=1761662804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UySUCjWUtuRcjmT3qJKt36CcLgaHbSSSJyk5knI5h8c=;
 b=ZXjUZ4qJjlWqj1GZs3YHMfqfwQjzKvi4QXqW/rTfT8Nnm5TIbHf9gvJkBWBim0idW2
 dt6a3Dtj+LgCVLhTWMXOwbH1oCvvEn6SuwKQXIch7JGh3NMO4JmCjQPOM6SMKDKE0Fm4
 x6H/GtIyHmfD4zwt18EqnCYjoUyixzKUcx0wSbCqYLu9I19H9imOupDWxGtEg2eHYtqB
 WMZ89Fd/SdR1rGVEQltpD5PipbDBAoDx9TZvx3SgdGSQ4vCRTu96kVRMQN+f03szzWyH
 2SAbQUbhg8TxlT8zQ8BZeo5oOhEFeshizRCuhgyaSQTjwBhI698SXkcqlkBlD4GnKYz6
 dvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761058004; x=1761662804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UySUCjWUtuRcjmT3qJKt36CcLgaHbSSSJyk5knI5h8c=;
 b=J283Lm+Jkn526+2SMj18+Vw7TJ+w/cLSArWmwJ9YiGOY2f4jC94eHsSsD08khWjW4u
 MrL1SdxyMv015wEU3W0n8Nm0JedA9czYDFgFT+rk+EvyoZpywft87k6rHqU0R8bcXEqj
 n/qLTqUvR+WqQkmoCqSsBYk27+UYC3aJrmLE/6dDiWP2aLK/T7PPTpIrWf2DbYNo56Ih
 gDDNnI+0avgy73jtw+3fSrUWr2hjseEamO0ZvDE9j7/XfBfVPIrKD9gwcsgGK7DDdwx1
 CQaWP07QwA2UYsQ2GZ/dBfTLynlUld5+A/OeiW4aNibVAzqMaJku9Hge+BJu6JtWqTm0
 hQbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/nStvMsLkJvBckb9cPRr9Fex3z1mMpedPUm0MQyrgDQ9zIxn9MnrvVpwssuI9Q1eQRD+3o1sn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5Bh4abpqvq2ct00IDOzXU/gwP/ksK7MBOhO9IyuIKtuz0YE54
 TXaP4sG4uWJs6MobNJYWDjIkYOOxlqBPeWX0nj0n55U7chKzeEbdM4x+KfG7LcuAiPVVJyaGJuC
 /3Ja4oALy3XV21C4DVbIcktQysE3SlvY=
X-Gm-Gg: ASbGncvsVBkvm+DL37ucugC33QXXG/T2NKEcoqGTpLNuVsuCGbPNbTtjzx0fh+Vtxln
 F28xed3Ajb4AfDHvdHQxFbo6DgEvGCFYmlREXvGvUDeBu5iOOi1XGfu0mivq3Caw61E62+T5YvU
 3CZ67qkLcFu7XJ3G5rbtF/VprjBxbJwdjxTyULfognHsFIR485QO5wZCudRlmt8dMP8gwZlZJLH
 9fObCjI3K7olLkaXgo+6NZNjl4NaaFHAgI5FzgxWuEMli76f86EYc+FhkTy
X-Google-Smtp-Source: AGHT+IGAgxImdWFg/6cW8G4c283/Vj5MfyibVRmuLMs+IFymeGLB2tbTjoT/jUc4wPw89NoB/0QuO91OP6ckLMVvmkY=
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-292d3fb7f47mr23005245ad.7.1761058003628; Tue, 21 Oct 2025
 07:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
 <26d69e19-a6dc-4506-b19a-7803323b5178@amd.com>
 <4neu3psu5mpeb2umbptkg2xo3aptojao6jqaxjq4pcfc6ruwsk@mlcszrb5upi5>
In-Reply-To: <4neu3psu5mpeb2umbptkg2xo3aptojao6jqaxjq4pcfc6ruwsk@mlcszrb5upi5>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Oct 2025 10:46:32 -0400
X-Gm-Features: AS18NWBOjCxXWup_J-cCMVpLDbtbRMnq2pNOY5HnsGmzRuFgceGizrqls8SVdUQ
Message-ID: <CADnq5_MOOzhUjrPGTHr04rFyPnVJw7BiA7GvfqVzAwA321N8sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
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

On Tue, Oct 21, 2025 at 9:25=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 10/21, Lazar, Lijo wrote:
> >
> >
> > On 10/21/2025 1:08 AM, Rodrigo Siqueira wrote:
> > > When using UMR, a dashboard is available that displays the CPC, CPF,
> > > CPG, TCP, and UTCL utilization. This commit introduces the meanings o=
f
> > > those acronyms (and others) to the glossary to improve the comprehens=
ion
> > > of the UMR dashboard.
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 +++++++++++++++++=
+++
> > >   1 file changed, 21 insertions(+)
> > >
> > > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documenta=
tion/gpu/amdgpu/amdgpu-glossary.rst
> > > index 30812d9d53c6..eb72e6f6d4f1 100644
> > > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
> > >       CP
> > >         Command Processor
> > > +    CPC
> > > +      Command Processor Compute
> > > +
> > > +    CPF
> > > +      Command Processor Fetch
> > > +
> > > +    CPG
> > > +      Command Processor Graphics
> > > +
> > >       CPLIB
> > >         Content Protection Library
> > > @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
> > >       GMC
> > >         Graphic Memory Controller
> > > +    GPR
> > > +      General Purpose Register
> > > +
> > >       GPUVM
> > >         GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports=
 multiple
> > >         virtual address spaces that can be in flight at any given tim=
e.  These
> > > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
> > >         table for use by the kernel driver or into per process GPUVM =
page tables
> > >         for application usage.
> > > +    GWS
> > > +      Global Wave Syncs
> >
> > Sync (s is not there).
>
> I'll fix it in the V4.
>
> > > +
> > >       IH
> > >         Interrupt Handler
> > > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core a=
t
> > >       TC
> > >         Texture Cache
> > > +    TCP (AMDGPU)
> > > +      Texture Cache Processing
> >
> > Texture Cache per Pipe - terminology used for L1 cache in old architect=
ure.
>
> Alex, Lijo,
>
> How about the following modification for the V4:
>
> TCP (AMDGPU)
>   Texture Cache per Pipe. Even though the name "Texture" is part of this
>   acronym, the TCP represents the path to memory shaders; i.e., it is not
>   related to texture. The name is a leftover from older designs where
>   shader stages had different cache designs; it refers to the L1 cache in
>   older architectures.
>
> >
> > > +
> > >       TOC
> > >         Table of Contents
> > >       UMSCH
> > >         User Mode Scheduler
> > > +    UTCL
> > > +      Universal Texture Cache Line
> >
> > Unified Translation Cache - equivalent of TLB. Has multiple levels, hen=
ce L
> > may be dropped.
>
> How about the following modification for the V4:
>
> UTC (AMDGPU)
>   Unified Translation Cache. UTC is equivalent to TLB. You might see a
>   variation of this acronym with L at the end, i.e., UTCL followed by a
>   number; L means the cache level (e.g., UTCL1 and UTCL2).
>
> The reason that I kept the L explanation is that UTCL appears in some
> parts of the code and also in the UMR gui. Keeping this acronym here can
> facilitate code searches and also provide some extra background on the L
> part. Is it ok for you?

Looks good to me.  Thanks!

Alex

>
> Thanks Alex/Lijo.
>
> >
> > Thanks,
> > Lijo
> >
> > > +
> > >       UVD
> > >         Unified Video Decoder
> >
>
> --
> Rodrigo Siqueira
