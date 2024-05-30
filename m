Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F081C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 15:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D14F10E8A6;
	Thu, 30 May 2024 15:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VYAbMUws";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CF810E8A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 15:24:14 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1f44b441b08so8548345ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717082653; x=1717687453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQpuxWnEyFqc8L43gX16C2Ub+H+9PSaKW0/L6Gn6xwQ=;
 b=VYAbMUwsiC6WYcG0bmjmGt/qeIHka3ZP5qWF1jX/AacYfVOUFHY6d2G9aB9rhcUox4
 U4quNEUYuSre/BT+vPh3yT7ovv8vOK887snvUib2hTIzZYc1F4O4hZefTGXqNAYLP/eO
 PCN+cS5iSeYj7UKBCmEsge0UZ/tOefbzFxZIwIAyH6kkoepwIs9Ij+JMeZrowrFNjdMX
 CP3QsxTjmYshHFyE55lhSZOktp6fbcrYmLVHi42W6iHVcN0vlOOggbzw7thmVGw1p14S
 UMOuc3VPN8WUzyPpAI1V3urZOlMCObMZa3N8ocoVpocFYpws1vEGkoAR4UIeHz1ye0Z+
 /dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717082653; x=1717687453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQpuxWnEyFqc8L43gX16C2Ub+H+9PSaKW0/L6Gn6xwQ=;
 b=I2evxKsoJ+89ci5wDG7HYnCKTEKDrVl7pqfhRKJ1YiQCZwTCPr4KvmxbpPVdmjBoi6
 CKtbzgCsjRmIOjfcgosppmmh4qf1zOCld2mlBKyX69CO4Y4mhtxhCG87kXtPMNIwNCZW
 ze4e1EqW+zAmLgAfjC4Zq7+ylbA0Uqxi13GksO1EsteBVmfRdxTEGLHNmg8APEJsVVLV
 l3whgMCF+w2zYj+R+XKlWEEz75Udwj/cgUYB0N0/SHaIZUenVRE0KC+U577J+n3q4ibJ
 XdoMy9w8uF1TjQ4kxBWZSjoXC1AnnYpgLgdVJ9MVsSuR9/G4Ub3NeyxE2ZqiFChZI2Kt
 z5Xg==
X-Gm-Message-State: AOJu0YzTixIFecefubwOvD3YpvZFMyKJb+Uc/tu+iURLxbnL6yCPfT8y
 caYg08G6JhJLBy5bAxE/4QOZCXgG5G7OEx92RMNOEgJ+CkEKuN0q+YVjkRzQBCRqx7Q8ClHEnbn
 Xrxy2bEeANDsLLxGrzQ3Jay9jGpFp/GZD
X-Google-Smtp-Source: AGHT+IF06k0FYramj9YtEIpOYzT2ZeB0cQahfooJXGwI6Aug2QqhbLS8ezNS/yyCpii+VqKyWNpfA1SZtju5gUTXFNc=
X-Received: by 2002:a17:903:2283:b0:1f2:f182:f617 with SMTP id
 d9443c01a7336-1f6193f890fmr26649025ad.10.1717082653365; Thu, 30 May 2024
 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240523071637.1114898-1-tasos@tasossah.com>
 <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
 <d064e35f-4990-485b-9426-a4f5ab9f3375@tasossah.com>
 <CADnq5_OX52-0Enb6E1qDhDZ-G-Sd3cgGF5hUouofgkq7VzK1_Q@mail.gmail.com>
 <20240530103111.GA930046@devnull.tasossah.com>
In-Reply-To: <20240530103111.GA930046@devnull.tasossah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 May 2024 11:24:00 -0400
Message-ID: <CADnq5_Owxw+HUFvV_u6j0DkJLb55khXpD04ghnncseANcjyY7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
To: Tasos Sahanidis <tasos@tasossah.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, May 30, 2024 at 6:31=E2=80=AFAM Tasos Sahanidis <tasos@tasossah.com=
> wrote:
>
> On Mon, May 27, 2024 at 10:47:39AM -0400, Alex Deucher wrote:
> > On Mon, May 27, 2024 at 5:42=E2=80=AFAM Tasos Sahanidis <tasos@tasossah=
.com> wrote:
> > >
> > > On 2024-05-23 17:52, Alex Deucher wrote:
> > > > On Thu, May 23, 2024 at 9:05=E2=80=AFAM Tasos Sahanidis <tasos@taso=
ssah.com> wrote:
> > > >>
> > > >> Dyanmically sized arrays used [1] instead of []. Replacing the for=
mer
> > > >> with the latter resolves multiple warnings observed on boot with a
> > > >> BONAIRE card.
> > > >>
> > > >> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> > > >> ---
> > > >>  drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++----------=
--
> > > >>  1 file changed, 12 insertions(+), 12 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/d=
rm/amd/include/pptable.h
> > > >> index 2e8e6c9875f6..d1dec880d2d6 100644
> > > >> --- a/drivers/gpu/drm/amd/include/pptable.h
> > > >> +++ b/drivers/gpu/drm/amd/include/pptable.h
> > > >> @@ -480,7 +480,7 @@ typedef struct _StateArray{
> > > >>      //how many states we have
> > > >>      UCHAR ucNumEntries;
> > > >>
> > > >> -    ATOM_PPLIB_STATE_V2 states[1];
> > > >> +    ATOM_PPLIB_STATE_V2 states[];
> > > >
> > > > Can you add __counted_by(ucNumEntries) to the end of the line? E.g.=
,
> > > >
> > > > ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
> > > >
> > > > Same comment for the other changes below.
> > > >
> > > > Alex
> > >
>
> Apologies for the delay. I realised my compiler actually didn't support
> the attribute, so I had to install clang 19 from git.
>
> After doing so, I saw this warning about ATOM_PPLIB_STATE_V2.
>
> drivers/gpu/drm/amd/amdgpu/../include/pptable.h:483:5: warning: 'counted_=
by' should not be applied to an array with element of unknown size because =
'ATOM_PPLIB_STATE_V2'
>  (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible arr=
ay member. This will be an error in a future compiler version [-Wbounds-saf=
ety-counted-by-elt-type-unknown-size]
>   483 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Thus I'll remove the __counted_by() from that one.

just leave it there commented out.  E.g.,

ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;

for reference so if the compiler ever gets updated to handle this, it
can be re-enabled.

>
> > >  }NonClockInfoArray;
> > >
> > >  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
> > >  {
> > >      USHORT usClockLow;
> > >      UCHAR  ucClockHigh;
> > >      USHORT usVoltage;
> > >
> > > All the other ones are UCHAR, so __counted_by can not be used on them=
.
> >
> > I'm not following.  Why not?
> >
> > Alex
>
> If I'm not mistaken, for a UCHAR flexible array such as clockInfo[],
> we would then need to multiply the count by the size, which results in:
>
> drivers/gpu/drm/amd/amdgpu/../include/pptable.h:494:36: error: 'counted_b=
y' argument must be a simple declaration reference
>   494 |     UCHAR clockInfo[] __counted_by(ucEntrySize * ucNumEntries);
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler_attributes.h:105:62: note: expanded from macro '=
__counted_by'
>   105 | # define __counted_by(member)           __attribute__((__counted_=
by__(member)))
>       |                                                                  =
     ^~~~~~

Ah, yes, we can skip those.

Alex
