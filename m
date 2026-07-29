Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11129C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 14:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16EC10E05A;
	Wed, 29 Jul 2026 14:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3DrRA46";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6521B10E05A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:39:47 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so1019223a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785335986; cv=none;
 d=google.com; s=arc-20260327;
 b=KT8xxrwSOtFBaPV/1q97rH4v86L13T26cS63q+qCb5Gk+9Phx74hSqN3wit91NAOPu
 Z/vdRcgkr44xDX4GmETrNxKVmyWZAriSoaQNjq64JT4qqf0bMWYISZN48SUCv4lUUedM
 XHwQ5+8RDKu079wmkbb1pl0jYXwn8ZUPBW3OB3MhHv+QamXwM51gw2JAM0MWuqKwRt06
 MDUeXNL8BeMmg3FvVPAmt87HNr2pqMSHFvix03cjbjeMdUw3vRDufLFVytVR1HDggnO6
 h8L8jzWL0Xj6/u4Ls/qKYpfe5B93AozTsYzyYZFcJ/lyWMCyUAFMzOs16+o5N+vlelsy
 uXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
 fh=B1QcortvkpfiOTARoE/nunqhMFnUgfgQHNomV+3C2SE=;
 b=VTXpjTyncdLg8lM2YD9e058YjrChoBWFGBVzwbqddE9V463ZKneyOch6IFFhbSFnoi
 2I6QjZCeMmDEYU+yY1g8hQbP54I81WaOAt2zj0TRvsNHPosazJqFr9u89Yd+DOXO/MZk
 wkUDPuQOjUgyUB+aG0hesG1vRIWOhdcm88yuTC8vyTfU/uA+kPH1x4zyFdk7Ldw4KjFV
 mIupsqra9IqVRXZXqjVBfB0dnv4rlwFWxNuu7xdesj39ReqK4jtAxJyn28F+iqKrf9Xs
 +YASjklgc8ZrMcJYT//rYiOHej1NWtAYtb4Wk6+0RWZdcLAp01zbZWQAi1ftEOi1cMrn
 YXlg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785335986; x=1785940786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
 b=a3DrRA46T/S5YqIJbsoqaJVOQ3dVtaavrZqmqtRAOHIeYWHLdn6wGHOpJDWX/XJhFg
 zWDggq+slhMFdkeKiIJzRhjaPQV4zm+3TUUuUu1xkawuMzCHKsHH3Zab5hAhegxGMqbG
 6qq6jHv1qEoY7ZG4uO86ltjlAbkX2odG7mncswJJ/Wvd6Z6C1VaHP3mIO+DOeIIMde7l
 atE1sxsPgfFiNIk2OMTyK1ATRIzjhkdBWjuFmld78sYFACcjVpj5pXXrFF3VvORp2Wql
 B2FH32VvjDLHKw2QDljqWf9i2c/TnQoSiZj+ML5QypE4AA1ngNLcaUnfct47CtKyEAO8
 zeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335986; x=1785940786;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
 b=PEAl/JBVz5+yhMKZM9dQASlkR4hzPG/6NhSFH0UovzvipbwaKydFPUhIoYvRWOjp0C
 i1odNjKbTL8PFBDhzbAn3vo2REHE9GZrv4NG74v7glxk2kn+hDVdC3FpIc9BkblOfUem
 GlBc25m0lphp8xYQ2dm1zKrdzgwOMyHxPlOVT6lvSP0T9rEIWEfNhEpxyc0bqK6ZtI6Z
 KNMbJX4kIy6XKS5LUfE9vGho+7TXSbiTdbUB23s2pwp5gYP5KPRjmDgM3kZ/yU1LvaRU
 fAoTVab3e2znxI75nAbzJc/Tc8wS/w/wR1sB8oBZmotX14R4p5HssUwtdJb3YybnpPkc
 MiPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtEdZNtwFrjfWDsC2A2XK4JKO6BuxRPhwawnXTTT/EzJa8ETy6lHKXn458yme5gBeUFAAR082p@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx60fdxDDf5ivx3ipQBIsrKUzen2PpCYujk3ntvWCrX29x0t+6d
 Oh1HMjNZe3YZXPbvToBkv5MnmzRsLrj7u1XN943ZtVJTRSuTQXLxInY9hCerJtVQFia0NSc2owH
 1VevxHEfla3T/ZISV32LpQnvLp0Z826s=
X-Gm-Gg: AR+sD12ygp2BHNTBrP1d6Bqj603YonXfCsOBns2LgV+gz4cE8DLIp1qGbPVVoUJqwaU
 9I9aTBaytzga/haswbBUPECLOUvrtyHXvPhXdWW7oNjwBQCCPt3ywGsPKNKdLDStUGcI0pK9ELE
 LOFZmjjfPIMM4BlSMqvSUHHC7jiQE3pxMzwNrad5HHzLZpBMi3GWwy/2BNqCoi5OKQkoEz0yjpt
 gE5mRrLzJ9rbtpo9yf/OufeqjymPkuovOscsfvS9Px1A65pRoHqJGMp3p5YjmZQnymvCgBcFl9Q
 IrVIYu+khKkJ/9ZB8JUgMYdG9xTHyjojicJyDp/H1Tt+mz0=
X-Received: by 2002:a05:6830:2696:b0:7e9:b673:cbef with SMTP id
 46e09a7af769-7efff25f6bdmr3854282a34.17.1785335986490; Wed, 29 Jul 2026
 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260727105059.75716-1-spasswolf@web.de>
 <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
 <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
In-Reply-To: <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 29 Jul 2026 19:39:34 +0500
X-Gm-Features: AUfX_mwXyEa-LkEfVk4HaieHl5UbmaG7Jg2hW7wYSg6MeyPwuqLhhMt1G3fmyMg
Message-ID: <CABXGCsONHe2ST-==Gso2748i7W_POPiUAF2MrrmTuqoQr7z3gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,
 END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 "# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Jul 29, 2026 at 5:36=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> I did try a different approach, using DC_RUN_WITH_PREEMPTION_ENABLED furt=
her
> upward in the calltrace (This would have the slight benefit of more code
> running with preemption enabled). This does not work because dml21_utils.=
c is compiled
> as a _LINUX_FPU_COMPILATION_UNIT, so DC_RUN_WITH_PREEMPTION_ENABLED does =
nothing.

Confirmed, and the chain is worth spelling out because it is not obvious
from the call site:

  Makefile:1127:      CC_FLAGS_FPU +=3D -D_LINUX_FPU_COMPILATION_UNIT
  dc/dml2_0/Makefile: applies $(CC_FLAGS_FPU) to every object under
                      dc/dml2_0/ ("Add FPU flags to all dml2 files by
                      default")

so both files you tried are built with -D_LINUX_FPU_COMPILATION_UNIT,
and in that branch of dc_fpu.h the macro is:

  #define DC_RUN_WITH_PREEMPTION_ENABLED(code) code

What I think is the real problem here: in the same branch DC_FP_START()
and DC_FP_END() are defined as BUILD_BUG(), so misusing those inside an
FPU compilation unit fails the build.  DC_RUN_WITH_PREEMPTION_ENABLED()
silently degrades to a plain call instead.  It compiles cleanly, looks
correct on review, and does nothing - which is exactly the trap you just
walked into.  Making it BUILD_BUG() as well would turn that into a
compile error.  I can send that as a separate patch if AMD agrees it is
the right direction.

This also explains the asymmetry with 183182235f6d: dc/resource/dcn32/
does not get the FPU flags, so the call-site wrap there expands to the
real thing, while the equivalent wrap in the dml21 path would have been
a no-op.  Another reason to guard the allocation in the callee, as your
patch does.

--=20
Thanks,
Mikhail
