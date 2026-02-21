Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD65E98E0D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6028410E294;
	Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwcCNsDU";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8B310E175
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 08:48:47 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-65a380b554bso5492049a12.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 00:48:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771663726; cv=none;
 d=google.com; s=arc-20240605;
 b=ZLgjWBvOttcUyL/F0AA1Wgkiu2TZANkoUTaQDLSowk7R7PNvo0dX1zw/HmqUDEYD7Z
 8Eq6uBsZYmsWWBJf6ONZisl79PyysuGF5HsgUOkIpjF2y+gYvxfN4t2penX1shEhxM9v
 LxPW408qs1RQYgwwtIMcc/wq86RaW8rgeiMJRJz0vC2RQ6319sxYrSXNvcFPaZ5K29/c
 hUp5lmmu9pY9i3zLxb6x3Ck/xXX59uPAQt6nx6fa1HfEZpskvfSLnPdwO0IIzl5lU8yn
 S55Ab/XexNQx3xFd5iBBkSynp0EyktVzNEA4L71ILIHCetlyf2mmwW0vuz/nllMwmx8r
 RcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
 fh=LuaMfLSRXGmhdQCVw5X28RFDVk+iilePXLoOmp1itjs=;
 b=hVBoEIH+EMTMqKBEAJDmNMRm/KSYXXLDmhsBCNrlk/tfkOEJzBSciSYHr+9TJUqPCh
 JyUGkD9dVZSsJ7an/Ox+/63Hciq+1kz+8B/8fZEBMlYnALUQnQX468SGWjK/iewKFSSZ
 uQKbztcFF8z4tFpqwZ8O0fKZnKPQfdD1CMlq4pqJcDz9gSnddpPfjWYJy5yY3SjNkMVZ
 pZvAxnHqmzd0H1gg24B4MgaGZ+qA2GFOJFCzbVqLxjUffiTarFc1uJzLFmK2BRKupxDB
 b/3C40lwWtu3603sWEHv1Ejr3vYzsWBcO9pP66dMolSyOoddBYZXuDG6B5ZEX5s7k6K7
 amzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771663726; x=1772268526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
 b=XwcCNsDUE3wy19+vabGPR4EJR4Y4D3qyivsgBUdE/1vAy63LpYlS9S+oeG1rQn6ILh
 4845kLRidfNHN2cxcAp2oe9R0g1B8Lbrc+GNreV2bLwTDbDu6Ar2ZL6zdPLB8YJLt1b9
 gEqbPf2AXajtQCa0UW2fXhsmin8R2IkF7053ZnsBrpnlxdEzcjp97E1VfJWtD1FuyrSY
 AU7jmxto16XNuoVYTT5Ls2i8x5xr/Smn7HzIXMylRuEV2cfcPb5yuHKyecIhxT2crKUk
 tB6ciyrHpKgkHtU6G7mSdF3Ink7HlfObKwgbQSuQHwR1a54gINsQ5MYH2fa0sWuHmCJF
 ZvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771663726; x=1772268526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
 b=sycpRmb75P3CUkpjulqqowa5pZhNXPxa42aru+R21QKJLtVxybrtUyV/+Jl4qFGPB1
 v6LkQdeUboJkg9fgNEQNB0EkQzMaYhmTZaldqVpiOXRBcUnRWSUriKf2+f9r32rHGpK1
 1L5j+5O1KbqL/JApiGD3NTis09pKfsTEBKOX3Gb0bfVzwZaLsc8F+Q5rAXtl17t2EqwT
 lUMcM9xaQfiL/EXP7ZViOp+nfntP0ngES3sqXX9i1v8OzKV2AAxQMqB9QwGoqdQip3Ey
 Y5HRYS0sxdf542QNzH5U8A0g6wM9gfnA0ki63FUtRLUO09urRmbp2GoTQNwXtBK4Pwgj
 wakw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuSCrlTNVfsc2sffKmbp3YV0gXokCJ0gjW9KOcpKClIYvfz8gpVx7CNpw+pAxmm7fCfl+OHjjm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE0pEgSIxiTCXV0JAmi2pZ8V+lGf/m8KL81YzJc+a1oHwbm/it
 prBG5tUTT0Y950BA0N/3pNBz3QxgBpUnOQet6grb52o8ewWlNgRhTMy1XMjCg2+x1/F9/SxCiR9
 hkVdKVZqhHLx7OGgkaHBPkhdw6TOm81U=
X-Gm-Gg: AZuq6aIJ57lKoO+9BitMT4yNgeh6597lhkGIF3vkMEug+OX43GIZN1SYDTBOS4GWnyY
 RiSEdCyNUFADz8sJ3CfYM8GRbpgr4cCpfTuO9TUwxmH+VGSAw4WJcEr7KC7PPwCVBt8+y/JeLKT
 Qf+enxkjMZ2Bgd2AM1D/S0ua3cdU8zziesFufMueHMIu4Z3t4Vu4w/EPqvTR8XZ3//N56GUT74+
 NZuvaPgtAN6WjI1ltDUrIoB54hHkP5lS89QUVKiSq9YNatYg3PRTaVjM/3f6JgtODszuXy+dWab
 wnLVSDfLctcFy2lPNZtpoAwAXrXT7BIkEBCL0ca9Dfpm5K4R9nsBEoqa/ohN204hMTzw6H0vz8w
 on6cN5A==
X-Received: by 2002:a17:907:3c91:b0:b87:b0ba:5d2d with SMTP id
 a640c23a62f3a-b9081c42436mr136091166b.57.1771663725994; Sat, 21 Feb 2026
 00:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh>
 <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
 <2026022126-chair-spout-641a@gregkh>
In-Reply-To: <2026022126-chair-spout-641a@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 21 Feb 2026 00:48:34 -0800
X-Gm-Features: AaiRm51RjwwZfhQIEJaLMLmlDT-qI7j28uWxDcE_9CBb9uX55P5V7cGqPAMw40E
Message-ID: <CAKxU2N9Fz7SCHUah3LbWSwyyO61v5iB0A0cPkMBBBZ+pF4gWwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland
 with high pixel clocks (v3)"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:06 +0000
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

On Fri, Feb 20, 2026 at 10:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Feb 20, 2026 at 09:52:29PM -0800, Rosen Penev wrote:
> > On Fri, Feb 20, 2026 at 9:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > > > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> > > >
> > > > This commit breaks stable kernels older than 6.18 that are booted w=
ith
> > > > radeon.si_support=3D0 amdgpu.si_support=3D1 amdgpu.dc=3D1
> > > >
> > > > In 6.17, threre are further commits that are needed to get the DC
> > > > codepath in amdgpu for Southern Islands GPUs working but they seem =
to be
> > > > too much of a hastle to backport cleanly. The simplest solution is =
to
> > > > revert this problematic commit
> > >
> > > Ok, this is better, but still, this only applies to 6.12.y, right?
> > The reverted commit (or rather the one from master) was backported to
> > at least 6.12 and 6.6. I didn't check what other kernels include it.
>
> I see it in the following kernel releases:
>         6.1.156 6.6.112 6.12.53 6.17.3 6.18
>
> All except 6.17.y is currently being supported.
Yes. I complained about 6.17 being broken at the time and luckily the
proper fixes got backported to 6.17. There's no issue there.

Those fixes are too involved to be cleanly backported to older
kernels, hence the revert being needed.

I'll mention 6.1 in v2.
>
> thanks,
>
> greg k-h
