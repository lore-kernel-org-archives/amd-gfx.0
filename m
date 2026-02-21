Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035E2E98E0B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8F210E285;
	Mon, 23 Feb 2026 08:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NWozmT46";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72BF10E05C
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 05:52:42 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8871718b00so441388866b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 21:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653161; cv=none;
 d=google.com; s=arc-20240605;
 b=GX598bsCWkCwEcih7gs+Np/WM1aXeFBI1VV3svhTNsfvSfroNCUYyQ06YimjLJ3oTW
 uxyrjBKyK4hTube5WvviA5hFdFrrhPcwXgOsVTPXdJnqa6/mTHWtSwRWIJTGUigcslmd
 tuNXlhqer50aNsQY87AA6FjYVSVKINe2PLRHF3ydQZlvnQh3DPPTmsB2kKvFe7IpHWDh
 jfS66FFrzGwVmZO+VPDXdreEVh2q6wtnEPSkBniTWlN5wsD0mqnnbjMkHwtb4yBPFVPX
 kvoPVrqy4CST5fge3XNFBO7z1ZmjvmDwdfSW2brgteQ8qW88OIXFKLl9KMx9JOS6Jb53
 Tm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
 fh=6vtChuLKUxUzZ9GSYMnANxnNuL/bofv+25WVmxdqPiE=;
 b=PK87F5fiwtk97+3U1qi4QNP6gbQ02rN2Ogt0YYONh9jlpMf1M7ncmM1sx+KiYsF8o7
 +mHxCHCw1+Q7cWBqN6qGAUORxJKjMI8MD3SS8E7i0rYgcyvHSbJ9qbxjQV4zuoP9+bOZ
 UoWz+N04KI7aHH45tSnXLivMdUZPdAR90qWVdPTO5XcYDt7QwookSv0GGkB9tQVJMHzw
 QvGJWe9EwcZR3TyanGqXeXwHRsAcBk9BdaSEMdCnCyflTZIm1CuAShlEno9wGIMSddxH
 hBy5h+0rUZ3nrqUkQ0s+OfBwrK5W6CX0SF62ph63qCjiR/IzIR3i0WX+qVC4B3FzfkHr
 I0MQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771653161; x=1772257961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
 b=NWozmT46MdIr1VGEtin8v8LERadDOBM9gJz9/yATPN4gUB3RAwxuwdz0EdyOpFLKax
 SxOWR0KHA9KAevVTj7cTIlpd5DQ7ESt3vpfMEPTServ/RxFky0He1FQyJcXGPkC2K8rH
 Dgelo7ncyWSgn6atFXPFfYiu+mIwgzNiNpZcKLSm+hw0eyeSjpxJuNsixSXKnHTsfqkP
 OdqqB7MDcZ7Y3b2L+0UovKBBesVNF/gwScFFPG53TR6TWaZ4lAcXAGmEDe+jyLpNbRr/
 knp7BzLY8bWqzjPgjaMo2Zc1zc7QBDlnVbtqrNxc98bMnpDFobyqy+K144EmT5biOTFk
 zDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771653161; x=1772257961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OOzh+KrsYoddiPyG6kL8Mz1PkVqo/f20UpIdm5py4zM=;
 b=lm7l907/JNo8s84bs5nDTM903FgQEPqy4hogjgdeiiIQCafzVMSdwrBQ2kQsfdy/o9
 gFUK02EBlomUUEv+aba71x9WUgFj5uDEIz3VCK/oYr6SoMhH0oXZgCv9dKtpD2wBfCO3
 7+MTjs8c+nSHCULcC3BxieaRoxf5Weg2v6nHePTdjSMJQsn8NyIslBdPGZC2XRMD6mDu
 kOCBwc+W6W46tTm2htfdjxFwlJkU9CVgS499lCLlxzB/UTB8e1+cYMevIaJozq9r5e84
 jyryHDW5Vj+md/Tz36UvsjE9xMXVFcvlNh5P6Kd5StZT9+PlmwmQ/o6R7jGXKTZWvLn5
 A2IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7CQens97d3gzvhblYewL5i/NI+pZwbP2c2LTcP2Ab8BG2bLJbQDZyqO99tF7k0y8zku63CX0D@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5jCboX0q0mUvtw2MB+NbmxW144Ie30vuWZOJxirRDmcjMmywG
 lYXgXqvOqcGmR4MVip0YoZUk/AJ+NXkMhm9XMorhlW9aDQbvTFTTtWc6zRCRlcSxbCXxIs42j10
 mG2QagHSENOC/YmPdVDbMZNq/cyYYM60=
X-Gm-Gg: AZuq6aL0Fg4cBybNsUi8gHzP1EaFVNAiFQpMoNzU97QxjbB+HfhObHtwTU4g2HYCQYe
 yNZqLgpEKLTyHFxnTYOGpiy9JxfHhOEW0SF1GsIS/c143fLT1ZMoQ4bGqevuxjFJI2a2GlE/DGs
 zBq3VjTi9jrk/Q5Z7Eqs+GaAJnez+noqkNTjzV1H0abM1ggwsXtC0i97JPvTr3+X5fWq/kXNTSl
 ym7FykNiWkmcoBlseliCmy4DRIx2jNBCldh2Jvf+qxawqY7Zgyp/Pr0XVbO+cfTxLQJvSt4gopZ
 pw0CVp3U2aORYuLVxvNayf7+pDGEY/JczVoGvR05Nizho1H0fObpABDr3axpEjewFglD+aDUPUq
 qloRiaQ==
X-Received: by 2002:a17:907:a43:b0:b90:a99:6ab5 with SMTP id
 a640c23a62f3a-b90819947dcmr118481066b.7.1771653160995; Fri, 20 Feb 2026
 21:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh>
In-Reply-To: <2026022148-unsorted-pushover-8262@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 21:52:29 -0800
X-Gm-Features: AaiRm51kvzm1-uW1evSUVzI8gGGopob0vMQaVVrKbOjRlGOELAe0rmEnSeUjXGI
Message-ID: <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
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
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:05 +0000
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

On Fri, Feb 20, 2026 at 9:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> >
> > This commit breaks stable kernels older than 6.18 that are booted with
> > radeon.si_support=3D0 amdgpu.si_support=3D1 amdgpu.dc=3D1
> >
> > In 6.17, threre are further commits that are needed to get the DC
> > codepath in amdgpu for Southern Islands GPUs working but they seem to b=
e
> > too much of a hastle to backport cleanly. The simplest solution is to
> > revert this problematic commit
>
> Ok, this is better, but still, this only applies to 6.12.y, right?
The reverted commit (or rather the one from master) was backported to
at least 6.12 and 6.6. I didn't check what other kernels include it.
>
> thanks,
>
> greg k-h
