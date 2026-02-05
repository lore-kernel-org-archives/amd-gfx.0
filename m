Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99200ECD99F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 20:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2719810E070;
	Thu,  5 Feb 2026 20:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihtp1nn1";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4603010E070
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 20:36:07 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b703e04984so171493eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 12:36:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770323766; cv=none;
 d=google.com; s=arc-20240605;
 b=eQ2fedT99heZiRXCfVJZALlYJsNXUFQxpz23wm1sGg7izsYO+jrGFhjOv++GBp0TQx
 buNGkBSuV/H0tQhl4YQlaHEWl8y1psddQj8k2DYGXgcNLZuJJIff7GSULfz8tI2Mm8vJ
 yDcIuvihjGDJKkeBqxro0G0hkhFY7+H7e2zBXtu0HJCOJ6ssP725HE+DQA8yt7useiBe
 nnEEsGWFO+mZzj9xzh76T1hvP6wARpQrAgn2VfFVi0q4Ez8jVZZq0NksnJYbZ5k/hT/Q
 +1xITqsEMcydgjQVkZdQuvEMzITCl/DMp07TR0g6KkOL+djHRW9y1Vf5xjZsGJq4XpaX
 Ycxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8sg36/JtdND6msAPPdYlPI96hFkd7iJTiHGCCYDl3uU=;
 fh=c13yTtaxm8HwB1skC8emj8192xdGyKow4kP6BkcSpxc=;
 b=DwGhYWlZjroFscuXkK041jgWVJGTZFHJsr5Az+37BQTlKzy3UExssQBfPJ1o9QDC0U
 C6qj3j0gFSO9QFiPsBxEm+S0Vt/FrdFilFBd/wtwIH1kq395r/oylTwyTsSe+GxfPPxT
 Hqbm5L/MssxmtPZIIzSqY7PPMWzLNSqmKxUoAH/aqSuumwGmcnBLy93xA3wMkbvVM8s0
 UvegedsN4OzZ1R5THkxTZxU8rw9hUSBgIUHlXVrdWvfD/X5jjeDoqEmnV9hbSPOAP0V0
 c4qknxQO6lby1lT53nTyxSPVmPzR0OsZhNCCs47gszbSDJgIlYblhptJ6M8R6kicu1VM
 15wA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770323766; x=1770928566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sg36/JtdND6msAPPdYlPI96hFkd7iJTiHGCCYDl3uU=;
 b=ihtp1nn1avg7zWXPt+PqKoXTHq4mr9TxRJUXfaHkW0Pj5HZAwTY+RAdDfp23XPtlsg
 ISmtxwm0hKle96YsHhcqx7bHDmm/QXgh33Lqt0PbxZXc1Ww3oI8pohd1XeaK7XnfbL3p
 pAzfa6DX0HbBk+58IuNlfMLvnqRFLzUJw4ySIpc0F/ja/unwCCpnqFD/QerbULr/QkXr
 rbsr3dc6K/ADxZfMqVQnhiS374vRACJyCAAmu4L87xW2fuifCzq8NLbXlhsyQACQZIcL
 IJP4PyczR3DiuALIgjvwx4aktx9sp8HX8K5zV7ybvyXUSPWrSirCYehfCEIBW3u3JU7U
 tO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770323766; x=1770928566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8sg36/JtdND6msAPPdYlPI96hFkd7iJTiHGCCYDl3uU=;
 b=Am2N9W4/KtX2AbVLU4i05Vrq7gxEk8rnD1wS8s13tNbceMr6dB46ZD8ODK6DouQ/3A
 6F7P2dR3fPF8ehSqSs87gRSdfWZjUmHoFbG/itLtcDq5INlqDKDL3JXZFqnpFHqURoy+
 wlc+K6vWInpiquWhhBRoGUKj+Cuxe/JOFswklIVp1YnwM14P/TZiLoMuV/lsqyw4rXeJ
 GR8cOBIOep6KDTKXIOJTs28pyImPeHwQM395mo0dIRTxIO+fWz5C2P3UChzQaudZFICc
 F2UupZhHDd3maeHT/kXXU4supgUy9YnNN7/Wtdx+1tynKwvDrefgeQHQr0hBfQ/iAkEo
 5y/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIli0uxSdoGEqRFTZdo5hPJIYfmcfyBf0rPCmnsaUc89iHELENOqVyVZlH83KDd7jCg5UqgcA6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCLTF5b/5vuDU5EBKjfK3ybB5jPtR5uRPXypZ8yDi8UBkvgVjR
 bw50G1OhORqpzgzd9lTVkJCFgQASgIPsnsj9XO+QhfCkv5Er2CCyQxcftRp8q1HnxmMMkZ44A66
 bZYQc6YJr6pKvjJd1SEGGVJ9lbrzsalk=
X-Gm-Gg: AZuq6aLOyjbz1M0YSM8NJj969fKdN0ZoDNLeel48xt/oxadzaOHQvRT3Dvz+04Zc8iN
 vdT0DRqMm9VQqWdzw7tmc88o/KdDdb1SbFRvKb/rosss6xJJ1j4HjkGgsZSrGhmEEn+KbpF51ay
 4dvuTkO1yBCfn8rio/4ELjIcDfLtxZNSnwHHdqWdYG5fjyxxNz1yud7QL8QSuGbGddN9GPU7Ow+
 E1W/M8VFaDv7PEJE82E86Ge9RbdxzRM7dZrkvdqGkIqmSKq8JvN/C4xTSn8SSBwWh1RIBSU
X-Received: by 2002:a05:7022:b85:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-12703faaee3mr117614c88.4.1770323766367; Thu, 05 Feb 2026
 12:36:06 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
 <4c5c0981-fa21-4d8c-b5ed-45ebaf4d713f@gmx.de>
In-Reply-To: <4c5c0981-fa21-4d8c-b5ed-45ebaf4d713f@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 15:35:54 -0500
X-Gm-Features: AZwV_QiuA1ihJ1g6ZIdAxBVYPzrZAhYftlE5C901IGgEioUs1d7NiosUg3iKc2s
Message-ID: <CADnq5_O1tEQB6whcAc4C=u5QN4-V1KOCDAM3dKepgt+RYcsjig@mail.gmail.com>
Subject: Re: Accelerator/GPU top
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 David Francis <David.Francis@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Feb 5, 2026 at 2:25=E2=80=AFPM Natalie Vock <natalie.vock@gmx.de> w=
rote:
>
> On 2/5/26 19:58, Alex Deucher wrote:
> > Has anyone given any thought on how to support something like top for
> > accelerators or GPUs?
>
> top for accelerators/GPUs kind of exists already, see [1] or [2].
> Clearly, this problem has some kind of solution (looking through the
> code, it seems like they check every fd if it has a DRM fdinfo file
> associated (which is indeed not particularly efficient)).
>
> Maybe it's worth asking the authors of the respective tools for their
> opinions here?

These tools use the existing interfaces which are available, but
require admin privileges to display the per process data for all
processes using the accelerators.  That's the part I'm interested in
solving.  For example the drm client list is admin only in debugfs.
Could we add something in sysfs which anyone could read to get a list
of processes using the GPU?  Presumably this was done for
privacy/security reasons, but as accelerators become more general
purpose, I think it's reasonable for users to see how loaded they are
similar to the CPU.

Alex

>
> Natalie
>
> [1] https://github.com/Umio-Yasuno/amdgpu_top
> [2] https://github.com/Syllo/nvtop
> > We have fdinfo, but using fdinfo requires extra
> > privileges (CAP_SYS_PTRACE) and there is not a particularly efficient
> > way to even discover what processes are using the GPU.  There is the
> > clients list in debugfs, but that is also admin only.  Tools like ps
> > and top use /proc/<pid>/stat and statm.  Do you think there would be
> > an appetite for something like /proc/<pid>/drm/stat, statm, etc.?
> > This would duplicate much of what is in fdinfo, but would be available
> > to regular users.
> >
> > Thanks,
> >
> > Alex
>
