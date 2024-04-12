Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D5CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 13:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8698D10E02A;
	Fri, 12 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkRS3tEa";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC5710F62E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 13:13:34 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2a4b457769eso582058a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712927613; x=1713532413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+jnULmOiSMU60l4WsaAxYhJr3ioK+HVd93uslILH1A=;
 b=QkRS3tEavpe57z47Svl1lurAXuGURbi9DSqNQ38CW4P4NzVeTLZVX0HdW4odP72UeA
 KsmZoD9oiUfuuKUnau4pI7BCzWdyYJov14+e01NL8+rhFgfD5vi1fpu1gwUSQuJI/HFI
 1aJfHpOZ3zUuDvu8VoftE2bDF7ZfNpSPHUZUir/NVPUbv0EJzLmOnO322B5BNC0i0kG7
 kBFPTQY270LLu6ImvSG3IfM7jG36IhvxGrLT/SGf/i5NfSigKx87lujms7g2nDqgPwEt
 cZl/xhnufyWtK86fiATkTzioh7JgSxjQTmoVVfr+iz2y5yNyHxYvPZU256LsbUiE/p28
 3dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712927613; x=1713532413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+jnULmOiSMU60l4WsaAxYhJr3ioK+HVd93uslILH1A=;
 b=kEKu6/xKR/fsmvYt214hliQpFnFDb1PvEzEQkWFjUIaQZBCfkUXhKxticVphodOAtl
 cCYvEPRiJPEu5TJz+u2B07Y4sIiNGoEzL4JfjPt9IY4pT1A3D8cw/I8UgAtLkP+jxrWi
 0KleB9C0yx2we46c9jjPhCzjGFHLLHCFX8DOzaeKjm7v4X8q7n6tEm2xQ88/Pw3Ht3RK
 lvEQK/lNLZVVl3dRPtnfoMjRQRLsj/KkYhBLVEB2S2/XI5g5ri/POC80hpIxMD3HVEsk
 FPmOFLcndKERXMcse/sbS0gA0IJBOhN4HRbHLnyw6Ci91yVnkJbVGTmV9XPTeP8zrA2F
 GC0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw2Ct+0bEFJHmI2EChEb0195bD64uq57Gf6SPVmmLbzvR4nqxEqi6nw2VmvqgL+h9P/2BeJPi93KJyqhmrKjGII6ehg+HJuRqkmBLJwA==
X-Gm-Message-State: AOJu0YwWQyOYb3QOjdRXDGKxuLHDkpu1WfTuQtGNoVsUs+Zz3lHAumST
 eOnONnyiGwZTLLA+0uvWSE8SgLr+qanLDyR3iCp8m4TqlUWE14cN1Moss69BrWiy8S4X0MFF2tH
 Om3iNxXbKRi4Z9f7C5TH4kS7mUVo=
X-Google-Smtp-Source: AGHT+IFAK8zD6niawQG7zboQRuGS73+d4PGhU2KgVYQWnTQ5ucXjmWJ8+rn3MxTjJS1tE6+cM1yZBo8oYh5bbx6Oqs0=
X-Received: by 2002:a17:90a:e57:b0:2a5:badb:2f6b with SMTP id
 p23-20020a17090a0e5700b002a5badb2f6bmr2875866pja.26.1712927613338; Fri, 12
 Apr 2024 06:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240408173748.6598-1-alexander.deucher@amd.com>
 <202404090848.2C6802635@keescook>
In-Reply-To: <202404090848.2C6802635@keescook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 09:13:21 -0400
Message-ID: <CADnq5_N4Us_ObCi+-xUgL4d3F8tecJAwhg+Uiw0vom4UFRzSQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: silence UBSAN warning (v2)
To: Kees Cook <keescook@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Apr 10, 2024 at 3:37=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Apr 08, 2024 at 01:37:48PM -0400, Alex Deucher wrote:
> > Convert a variable sized array from [1] to [].
> >
> > v2: fix up a few more.
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> (v1)
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/radeon/pptable.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/=
pptable.h
> > index 94947229888ba..3493b1f979fed 100644
> > --- a/drivers/gpu/drm/radeon/pptable.h
> > +++ b/drivers/gpu/drm/radeon/pptable.h
> > @@ -432,7 +432,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
> >        /**
> >        * Driver will read the first ucNumDPMLevels in this array
> >        */
> > -      UCHAR clockInfoIndex[1];
> > +      UCHAR clockInfoIndex[];
> >  } ATOM_PPLIB_STATE_V2;
>
> The comment slightly above this hunk says:
>
>       //number of valid dpm levels in this state; Driver uses it to calcu=
late the whole
>       //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels =
- 1) * sizeof(UCHAR)
>
> This is wrong now, as ATOM_PPLIB_STATE_V2 isn't over-sized now. It
> should be:
>
>       //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels)=
 * sizeof(UCHAR)
>
> or better yet, struct_size(ATOM_PPLIB_STATE_V2, clockInfoIndex, ucNumDPML=
evels)
>

Will update that.

> I couldn't easily find any "sizeof" uses against these structs, but are
> you sure there aren't size changes associated with this adjustment?
>

I also didn't see any.

> Also, if the comment is accurate, then clockInfoIndex can also gain a
> __counted_by annotation:
>
>         UCHAR clockInfoIndex[] __counted_by(ucNumDPMLevels);
>
> The use of __counted_by() seems like it could apply to the other changes
> as well?

Yes, will fix that up too.

>
> >
> >  typedef struct _StateArray{
>
> This has a fake flex-array as well, but it's a flex array of flex
> arrays. :(
>
> typedef struct _StateArray{
>     //how many states we have
>     UCHAR ucNumEntries;
>
>     ATOM_PPLIB_STATE_V2 states[1];
> }StateArray;
>
> I suspect get_state_entry_v2() may trip the runtime checking too, though
> it's using a bunch of casted pointer math instead of direct array
> accesses, so maybe it's avoid the instrumentation for now?

Yes, I think so.  I don't think it was UBSAN, but IIRC, some compiler
versions complained about it at the time or something like that.  I
don't remember exactly what.  Too long ago.

Alex

>
> > @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
> >      //sizeof(ATOM_PPLIB_CLOCK_INFO)
> >      UCHAR ucEntrySize;
> >
> > -    UCHAR clockInfo[1];
> > +    UCHAR clockInfo[];
> >  }ClockInfoArray;
> >
> >  typedef struct _NonClockInfoArray{
> > @@ -460,7 +460,7 @@ typedef struct _NonClockInfoArray{
> >      //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
> >      UCHAR ucEntrySize;
> >
> > -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
> > +    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
> >  }NonClockInfoArray;
> >
> >  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
>
> -Kees
>
> --
> Kees Cook
