Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E096DCCD190
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 18:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D22D10E67B;
	Tue, 14 Oct 2025 18:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OFPe393h";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2151010E23B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 18:49:59 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-339d7c401d8so936446a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760467799; x=1761072599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+DkOkdj3Uh8HHLIJAwnFtmkf3l57hQg/ofbLLeZIlE=;
 b=OFPe393hESOdSQshPRp1vAFdX8NkRaP2PnROTVAs+/2imGlcYqD5LqtdcsK/p0nPFJ
 PSOUE2lWbxnpO4+C5A+pmrXZoTEoVkDvXnk1yVHKLN54ghORqAoGKF0lrLKLUgYwW68O
 QwELD3aCn7NZt95NxdB7llIn8yL0kiJKIu1RDLBfUFMHm8flyxL4JqBLUDLljUPfTS7k
 4qdtWkD9o45QBvMB2CRO3X+4lgYyWOWRwJSGu7+46mwMnIvWSTWsjNNkrdnyLHJ/X2tD
 xg4H1SIPhEExwjZc3fS6y9xX0uWBTcyMOeffzjbMPsQ3nLtok1rWP+n+Ubfo47VUK18/
 6P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760467799; x=1761072599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+DkOkdj3Uh8HHLIJAwnFtmkf3l57hQg/ofbLLeZIlE=;
 b=tveeINOaGclNkKy3qk7IlDKaV79LnQU9SpH6ZtIuXvfd6sutgsMSjtrNe85ecLojdG
 ssJtRPEXgg9fF1ebzn7/y/cxYWoRXXZLX6K078MxO0OphFasYYWx3zx5U6og2Pja9zKQ
 /qYheeKKsYn6NIwk54g4+mnkSylio7ctt5gLvQQ6vM8HYZ7eQpgHiG4DFkYUxAKv83Rd
 wPYCxt12ZSKE3S8KIe1PgRMcii9rSFiLgwyWde6Q9StU6NaeW3EiCLW1VryT0lX8yRR+
 CPxP6VBVLCZwY/jWkrsdze/GBvTBAyRBeH/FuFwZF2Ajk8AViQu52sqDEJVC5JZnxEy7
 WQzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm7KbmFyB4UVaCAtxZeQj1x4Kdk3ZfV28ZaYRj0efBi+8DEzmlAdlWEFyqZVAXy62X1vCddzj5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGgl6LmUoOHVU8o1mO5YPLamG2zHXzjBF+divsvSoEuhRzWY+m
 O1k2ZEHj8J8zaAn/Q5StclSfhXdj5swHSpQz4xXax2rbjaVac9rUDYERPfVNK+BfJL1nXy3Xqou
 z4SWELQdOG8X6a3WrM0wMXzsYpaDXgrg=
X-Gm-Gg: ASbGncsukNuP2nxs5zk58qhPCGK6pFKgzAa8SBu2qumr+gvaIJy85j+mfYYLpBnyef+
 eVr/WJMnmCupKs3kHhsMDtR3j6u+Iu6tJena8biypWsHftl/CbjI6RE10yvoVfntZR3KpfaOP41
 kYQxrEMIuOrW/N7LJAZ4vhyAfuDcLGhKQiPn0UuKcApNG0rVhjnhAGrS7xGf2nvFcMWCnmvoaOf
 kMqNKWxPkDHjLF58msXu+Ujfg==
X-Google-Smtp-Source: AGHT+IElKGqXtFrE1diEqPYxD7tMp2gQjKM80aXPkMzrZUGFJnMBpW+tryMhY6HjYl+eiVILn+UjfG/4Y5YCyKeFxwM=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr120019825ad.6.1760467798521; Tue, 14 Oct 2025
 11:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
 <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
 <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
 <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
 <CAAxE2A6G2uB=S8FQ7-cEO0vYc+bppa=fjEG0BHyzHivEG8FCBA@mail.gmail.com>
In-Reply-To: <CAAxE2A6G2uB=S8FQ7-cEO0vYc+bppa=fjEG0BHyzHivEG8FCBA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2025 14:49:46 -0400
X-Gm-Features: AS18NWB_FUG76QdK9RP2-ferdm0jWiPCTb6_2Bv3QsS178T4VyPADnXkZGyMkPw
Message-ID: <CADnq5_Nmq7E7UaPV6o=i0vhy-WmfgE1EG+NDs=Fstyi1sRDT=Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
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

On Tue, Oct 14, 2025 at 2:10=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> On Tue, Oct 14, 2025, 12:37 Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Tue, Oct 14, 2025 at 11:11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@g=
mail.com> wrote:
>> >
>> > On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
>> >>
>> >> On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo=
@gmail.com> wrote:
>> >> >
>> >> > On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <alexdeucher@g=
mail.com> wrote:
>> >> >>
>> >> >> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang=
@amd.com> wrote:
>> >> >> >
>> >> >> > [Public]
>> >> >> >
>> >> >> > Regards,
>> >> >> >       Prike
>> >> >> >
>> >> >> > > -----Original Message-----
>> >> >> > > From: Alex Deucher <alexdeucher@gmail.com>
>> >> >> > > Sent: Monday, October 13, 2025 9:44 PM
>> >> >> > > To: Liang, Prike <Prike.Liang@amd.com>
>> >> >> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> >> >> > > gfx@lists.freedesktop.org
>> >> >> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alig=
nment to shadow
>> >> >> > > info
>> >> >> > >
>> >> >> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Li=
ang@amd.com> wrote:
>> >> >> > > >
>> >> >> > > > [Public]
>> >> >> > > >
>> >> >> > > > We may need to update the userspace EOP buffer request; othe=
rwise, the EOP
>> >> >> > > buffer validation may fail.
>> >> >> > >
>> >> >> > > Existing userspace should be ok.  It currently uses PAGE_SIZE =
which is larger than
>> >> >> > > 2048.
>> >> >> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GPU_P=
AGE_SIZE) which is sees larger than 2048, so the kernel validates the eop b=
uffer can be successful at this point.
>> >> >> >
>> >> >> > But the mesa may need to use the shadow_info->eop_size as well i=
n the future?
>> >> >>
>> >> >> Ideally mesa would query the kernel to get the proper minimum size=
.
>> >> >> Yogesh will be looking at this.
>> >> >>
>> >> >> Alex
>> >> >
>> >> >
>> >> > Does the EOP buffer store privileged information? What is its conte=
nt?
>> >>
>> >> It stores end of pipe events for the compute queue generated from
>> >> things like RELEASE_MEM or AQL packets.  They are specific to each
>> >> user queue.  In theory corrupting or messing with the data in the
>> >> buffer should only affect that queue.
>> >
>> >
>> > RELEASE_MEM has a hidden implicit VMID parameter. That's why it's impo=
rtant to know whether it's stored in the EOP buffer that can be overwritten=
 by userspace.
>>
>> My understanding is that that is only relevant for kernel queues where
>> the vmid comes from the IB for each job.  For user queues, the vmid is
>> determined by the HQD so that is unused in the user queue case.
>
>
> This is NAK'd until a proof is given that the EOP buffer can't be used to=
 change the VMID of EOP fence writes.

The EOP buffer allocation is already in use.  It's used for compute
user queues for both ROCm and KGD.  All this patch does is allow
userspace to query what the size requirements are.  If we find a
problem in the EOP handling in firmware we should fix it in firmware,
but the software side is already in use.

Alex
