Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD38CC02182
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 15:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C05689811;
	Mon, 20 Jan 2025 15:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbj6WNLA";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BAF10E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 15:37:45 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ef05d0ef18so981998a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737387405; x=1737992205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtAp6qBFZ2Pd1nT4DmW8ghWEmCUwze5l2jyOAjgiq/s=;
 b=dbj6WNLAv9yuSYvhTyuGrxYgm9Lm5vGkDNt7lYxdFwsLl8adpkwe5+0RnrqHc3yJG9
 0dXL4kJn/ThjgkBLnXuRc+qdttBcr4gGLNN94PP9XyhrE0j4/OBFz9AwYRSwe9zlCaKR
 zq/qpGXJT+79kKBWE0EwwKQ3+SZS28DN8zZjzdZiS4b8OTPRyZJvWOr9/5tRCz+8uK6a
 UmBU5lqLCUy/YlCNpI8TlpsupBiNn26ziaaW/vh5jNffseCPq4DFfnwIIxUDgKvzc7BU
 37KyCqOoHm37GGTAONDLe1uwjstSlVScWiEmMX1eVxyx1trsYbA73Avl0Rjt3UROJ7/k
 jMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737387405; x=1737992205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtAp6qBFZ2Pd1nT4DmW8ghWEmCUwze5l2jyOAjgiq/s=;
 b=wVP4CmL3r2B4iahaG7RhIoET5Ti20knjhKjyWwFB48TnAcp5v/UGfvrQpXofDkRJwj
 gUVjEA5gBGAyFI6gy64K8ilLgzzLHHbGgbH215otS/r0v5gc6+pNcbP72iCCYCPjzixB
 OScwOpel+Mul7J3BhcMGm8MC69+Lr6CzUz2P00NqBy1HMYk5MmdpkVquASNpf46fB+Vy
 s3saegFfqpsKz2aRdlOBbNxcXPZ9QmqsbHEqoUb3CbtIlds1NNf2Exv+I8ve0/xpDeVp
 Z5f904n+JkrEPjKB6fSpW2FBPRO8b0fPkAuOlzY+EID9iCZblfEBZbLMwA4qBNkW1Wb4
 Kqxg==
X-Gm-Message-State: AOJu0YxM1kBiNIzlac4JZgxyCHLz8KV6F2xjexvzATNOtyhvu8YSxhf5
 q5sTSlkm+OqfDxwGRwYy3aBZ8nu5m9r7ejVEA1sbN4LZHVaO9sLQ5KDlV8CzoiQhfqa9sI/fXJx
 DLrIX6luwRs/N0fTCrukYrcuqyyqo/A==
X-Gm-Gg: ASbGnct3ggnqwIDhNAepgKUaCBXgCa/SBYdHEBuN9MnhTr9D9Jmlu7Qn8lNG91an8Ei
 G3ME+zDmaHJ92oWZmSUnYdXCUCGmnoug4SBCA8Ef7xgNYx9AWdf8=
X-Google-Smtp-Source: AGHT+IFKd84lIj6p+t2/lHvJ0vYpMjMu2W8AwMb8bLPYgM6vRo13x2KpgKdXm99YcmQfZG/lUIVtVOoXHeWdd0dO0mw=
X-Received: by 2002:a17:90b:534c:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2f782b06b52mr7520225a91.0.1737387405512; Mon, 20 Jan 2025
 07:36:45 -0800 (PST)
MIME-Version: 1.0
References: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
 <CADnq5_PatAYdyKGVJpX5TrVJ451Ga9PJjCx85jna+CUxsaFAhA@mail.gmail.com>
 <8o8j5o9K-GIowaV5BW0uUds5QSczbsDlObPMAEUyGjPMV1G2tq-3sdYaQwbZHt_d4p-9sqBe5OnsUkkbS2gb6eZT1d5KiOXyTdz3vy75_V8=@protonmail.com>
 <EefQ4XqoUhDVKwtzYbP7Cwv1m6p8brSTBJzVQeojHh8X688L3QdBfGkakTuU0yf3lWfne5Bhcj90MXHhB9nblEqobkXeWvluAnwrplGkH2A=@protonmail.com>
In-Reply-To: <EefQ4XqoUhDVKwtzYbP7Cwv1m6p8brSTBJzVQeojHh8X688L3QdBfGkakTuU0yf3lWfne5Bhcj90MXHhB9nblEqobkXeWvluAnwrplGkH2A=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jan 2025 10:36:33 -0500
X-Gm-Features: AbW1kvb5ELfl0LvACsqjpUPy7ER2vtgacYH4trqKi2kG_A_reGIOtrWNazJQH7M
Message-ID: <CADnq5_MoZ7W0pf2BFx7Rs2e+6YyJNO2KBCfjjnrkv-+hKNqduA@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: SyntheticBird <syntheticbirdxmr@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Sun, Jan 19, 2025 at 3:25=E2=80=AFPM SyntheticBird
<syntheticbirdxmr@protonmail.com> wrote:
>
>
> Hello,
>
> One person on the Gitlab issue have potentially bisected the commit causi=
ng the kernel freeze: https://gitlab.freedesktop.org/drm/amd/-/issues/3787#=
note_2741901
>
> https://gitlab.freedesktop.org/drm/kernel/-/commit/de848da12f752170c2ebe1=
14804a985314fd5a6a
>

Per the report, they have not finished the bisect yet.  It's generally
unlikely that a merge commit will be the problematic one.  Let's wait
until they finish the bisect.

Alex

> Also I apologize Alex I think I sent you an email without cc the mailing =
list.
>
> On Tuesday, January 14th, 2025 at 3:02 PM, SyntheticBird <syntheticbirdxm=
r@protonmail.com> wrote:
>
> >
> >
> >
> >
> >
> >
> >
> > On Tuesday, January 14th, 2025 at 2:44 PM, Alex Deucher alexdeucher@gma=
il.com wrote:
> >
> > > On Tue, Jan 14, 2025 at 9:05=E2=80=AFAM SyntheticBird
> > > syntheticbirdxmr@protonmail.com wrote:
> > >
> > > > Hello and happy new year to all members of this list.
> > > >
> > > > I know that mailing lists aren't meant for begging for support, but=
 after discussing this in another distribution channel, it seems to me like=
 it is the only way for me and other users to grab the attention of a maint=
ainer.
> > > >
> > > > Since 6.12.1, several users have reported a kernel freeze issue wit=
h AMDGPU, including a complete stack trace. It corresponds to the following=
 issues on GitLab:
> > > >
> > > > https://gitlab.freedesktop.org/drm/amd/-/issues/3787https://gitlab.=
freedesktop.org/drm/amd/-/issues/3866
> > > >
> > > > I also suspect this issue may have happened to one user on the Leve=
l1Tech forum: https://forum.level1techs.com/t/help-with-troubleshooting-fre=
ezing-with-linux-kernel-6-12-on-arch/221340/22
> > > >
> > > > Two months have passed since the first report of this bug, and no o=
ne in either of the two issues has ever reached out to us. I've checked the=
 mailing list archive, and it seems like no maintainer has ever discussed i=
t. We're simply left alone with only hope.
> > > >
> > > > I perfectly understand that maintainers are busy, and I do not blam=
e them, but we as users and owners of AMDGPU have no other choice but to tr=
y reaching out to you, to at least be sure that this issue hasn't been igno=
red in the depths of the GitLab issue list.
> > > >
> > > > This issue is impacting versions 6.12.1 to the latest 6.13 rc. Seve=
ral users are still stuck on either 6.6 LTS or 6.11.9-10. For users relying=
 on features that have been introduced between 6.6 and 6.12, they cannot do=
wngrade to 6.6 and also cannot upgrade to 6.12, leaving them without vulner=
abilities being patched on mainline and LTS.
> > >
> > > Per my comments on the bug report, did you also update mesa or GPU
> > > firmware? If so, can you narrow down if any of those other components
> > > had an impact? Alternatively, can you bisect the kernel? If you have
> > > known good and bad kernels, it would be really helpful if you could
> > > bisect to identify what commit caused the regression for you.
> > >
> > > Alex
> >
> >
> > Hi,
> >
> > Thanks Alex for reaching out. Also per my comment on the bug report, I =
can't right now but will be able to bisect during this week-end.
> > I do have two versions of the kernel one good (6.11.10) and one bad (6.=
12.1).
> > I checked and both mesa (24.3.3) and firmware (20241210) are up to date=
.
> >
> > I will update here whenever I find the commit.
