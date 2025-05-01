Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114AC369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 13:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8173B10E097;
	Thu,  1 May 2025 13:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XzM1xA2E";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B0010E097
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 13:32:50 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b1f2a3bf3c8so133154a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 May 2025 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746106370; x=1746711170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU40EBQuwFtfDEgs7TwZUPDJ1aCZrRH+cCgvSAmuomw=;
 b=XzM1xA2E8fmasmJR8To6cozL231MUefjR+B6jAC+u7erKl2aJnXYcPFflsBLRb6VHR
 sqeoOSaLhvcwwAAbXUYRX4BAYpVY06V9enh07Xq1vyVDCY0WRv1CmJVpa+lztuxGNOIU
 aZIMIP3aKp0f+nha/Ra7a02JsoKWT0USQKc35gXr4W2h6arr/4vDL5J51nig5UIsRSx9
 /Euc79mzlrO2gmBwaQwqHSnqiAvm8VmIOoin8is2U2I0tgUmzPSqxRPnRhc/fMdAWtgH
 ngAl4u4VtRhmrXC1leuu/jJ4uZBOQAYqwA77b63IC4RDVgXBdxtp1HWkz2v2nlDBqKeZ
 vHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106370; x=1746711170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU40EBQuwFtfDEgs7TwZUPDJ1aCZrRH+cCgvSAmuomw=;
 b=W0KkBRab8LE1hPE+UcZuu4qUDNnW4J+oHrvhfTCHILn8OTWXJGcSV3hy5+qTI4OQRr
 Ld57enYEdcob3+Rp+XeF6ZP8JuiT/WtTenIDRr+r7KK1/CVR5Fzm4HH75A1KxAyB76tN
 f0uAtucFjP5mK08ERJlxOkXtCTFZweOYmhxEWvzQ9wrStmQ5j2sJ4GPsf/56/wcqE42c
 U57XpwrF19yeo+xp7xERWiPvQ1v4cIxGm7y+e2ajtuozE5hwHvxqhBqsG/GTbfaQkgdL
 50YOMzWubHNv6KUeWcEGUQnSUVMULR9pu08z5dalgfij7vMEfuv6O+dmVmiAH96hsZve
 egTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBWt6EmyiMK6sZgmcRjZujKN1yri2OahxxZvSnDT4E+DhKXbGvQ4I5bge8yD950ETQEKk6BLzg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPtbJ8RwljwtO42p3y/WyLoyy39tebUdbJfTPmmbV8HkjcNcru
 a8XQqutS7bMkha5Hm87/bSHYbRP3b6bNWi8bjWZmv8KFr/yPq30ksCHCGm3s1ViY2C9iYz5aHLb
 fXN7/5C+SSSCIwgfNRKqN2vBHkZ0yIw==
X-Gm-Gg: ASbGnctoIxRr3qyXDv1dVVaOQyvuBnJxY3JNCE4F1cBxf+93eQj4IUjhAhhkT8Ztger
 mIel2dbjnX65E8sNDJ126lpGgOt2s/PU2j/akHgz/B8+6IWNYUs7I+OTj/j7sK8zRsgt5/xfRoz
 3PXTDyImhGgV2UDeLG/Ntc0/6E164dv8UD
X-Google-Smtp-Source: AGHT+IH68PtNdcIkzrdXnJPR1t5dtAhotylOvFgS2bbNESfhR7rbMU1CxwubEJop2fKHCoLe2YvfcE+x9OO9Jxcrsfg=
X-Received: by 2002:a17:90b:3e81:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-30a34a95b45mr3964733a91.6.1746106369586; Thu, 01 May 2025
 06:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
 <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
In-Reply-To: <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 May 2025 09:32:38 -0400
X-Gm-Features: ATxdqUHk3CBzIcRpWc4I0v-iM2r_I6QFEByMNce4QZVPdE9oUlXr4IBbqmhS6XI
Message-ID: <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
To: =?UTF-8?Q?Marcus_R=C3=BCckert?= <amd@nordisch.org>
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
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

On Wed, Apr 30, 2025 at 7:28=E2=80=AFPM Marcus R=C3=BCckert <amd@nordisch.o=
rg> wrote:
>
> On Wed, 2025-04-30 at 09:55 -0400, Alex Deucher wrote:
> > please make sure your kernel has these three patches:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D4408b59eeacfea777aae397177f49748cadde5ce
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dafcdf51d97cd58dd7a2e0aa8acbaea5108fa6826
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D366e77cd4923c3aa45341e15dcaf3377af9b042f
>
> I am kinda sure that's the patches Takashi backported into our 6.14.3.
> They are already part of 6.15.rc4 no?

Yes, I think so.

>
> > soft recover kills stuck shaders, so I'd suggest trying a newer
> > version of mesa and LLVM.  If that doesn't help, please file a ticket
> > here:
>
> Newer Mesa is building although I didnt see anything radv related.
>
> I am curious in https://gitlab.freedesktop.org/drm/amd/-/issues/4192
> there is a lot more details about the crash than what I see. with what
> kind of flags/environment variables do I have to run to get the same?
>

That issue is directly related to suspend and resume.  I.e., the
issues only happen after a suspend cycle.  Is that also what you are
seeing?

> An observation from my latest crash:
>
> ```
> May 01 01:05:59 steam[223306]: radv/amdgpu: The CS has been cancelled
> because the context is lost. This context is guilty of a soft recovery.
> May 01 01:06:05 steam[223306]: Game Recording - game stopped
> [gameid=3D2357570]
> May 01 01:06:05 steam[223306]: Removing process 352353 for gameID
> 2357570
> ```
>
> Is the game launched by steam inheriting that context or could it
> really be the steam process triggering it? As 223306 would be

The kernel driver stops accepting commands from a process if it caused
a hang unless the process recreates its context.  I'm not really sure
what's going on here based on the limited context, but I suspect the
game causes a GPU hang so the recording process stopped because of
that.

Alex

>
>
> ```
> ~/.local/share/Steam/ubuntu12_32/steam-runtime/usr/libexec/steam-
> runtime-tools-0/srt-logger --sh-syntax --rotate=3D8388608 --log-directory
> /home/darix/.local/share/Steam/logs --filename console-linux.txt --log-
> fd=3D7 --journal-fd=3D5 --parse-level-prefix
> ```
>
> It claims "game recording" but that is actually turned off and their
> LD_PRELOAD-s are blocked because of
> https://github.com/ValveSoftware/steam-for-linux/issues/11446
>
> --
> Always remember:
>   Never accept the world as it appears to be.
>     Dare to see it for what it could be.
>       The world can always use more heroes.
>
>
