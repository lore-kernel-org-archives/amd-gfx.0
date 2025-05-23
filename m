Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0D3C54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 03:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3387A10E1AD;
	Fri, 23 May 2025 03:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DIZH0aSK";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBE510E1AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 03:05:02 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3108652400cso456593a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747969502; x=1748574302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CinHGX2EMkKJ5ZLbIVRi9//99wmQ+6PLd/UwvIN6/Xk=;
 b=DIZH0aSKq8uRrf9K0AXeS6JRAufU/VZSCGYED+bB5lkC6ibOIQKYeR+PtLsnOewlub
 m7h8DN06ikPpiBoccOOJbm1XIzen8cey/ZYmdUMrm66accUtYHuxFXBfaE4oWzTUVEYh
 kPFAs4onmz7U+P7UaFgyr90qa7o24V4nG3W1KO892uBR5Swg6eZwCI0tqgpNX76DIbu4
 /Gsmcde4PWEVifo9Ei7OaDDtGFGUr5AHTQrTKzjgmcHxgSyS3hGOSIhmPGHpn9w58KP+
 YbwazSHAsKTVJya5V48RroXGA4YzGpLpCGc+wX4vqn14IKIFfcJbYFFEQFZF11b6R6HH
 m9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747969502; x=1748574302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CinHGX2EMkKJ5ZLbIVRi9//99wmQ+6PLd/UwvIN6/Xk=;
 b=lrLCWBf6FzpqTOtFPW6CuFfnH1re7UFwcTLW4iaeJjRZ+31psEi0zlhpZnI/A+q8gC
 nGLJHs2g5p9SwbpQqIKD9R4r5N5BwFId/UmreZzwNNU7uWZW3uW9LVieZmFJRlaeO7vI
 lRGgeP2fDC61kJOjKGAS3K5Pu/lAqSCh9AS5ykfo36Y0C/3v6DQGM8YHyp3TG+HIgruu
 cVbGKvwIB5BBauIJYsYKgYEfn3YLptu1RoR534WV/6GzphcTqJjiBR1NY9uEjGaN4btf
 rBIjTq/C47Ld7igYPfezJmLg+aM47Q7CaPM5YOt8SIcAzzkUZmI4DIB+FAQWAfIlql0x
 dkaA==
X-Gm-Message-State: AOJu0Yz1MREbeAOB8LJfItzM/ovibBmNlFGQwgDXO9v3DV/xTMrdy0J3
 pKvgkGSCzfqN2uDSGikbTc4u1E+XtEnvJmfmMBe5qUk8vqhz+NvGbgvi9B64kJ3MpI1Y+5kQXyL
 KkfNd6D8Y5Il0wUmgQbSy4ebuhDapf8I=
X-Gm-Gg: ASbGnct5uDgBWJXzbTXY9epBVe6BrB1WtNQyQIohbgevmVJ9VIkpFAP+zZDnwZE1aGa
 /L0U2FvNiLpQcqbpY/FgN3hDwsSKMQcK+T1uJXzoQ8PKgTLzbrog++7qxoNdC2HDu3+1DqtBK9r
 lY6FSt8A9HFuihYFIJIXzHxmIphojDXPA0Jg==
X-Google-Smtp-Source: AGHT+IHK4/w3oz+6tweFESbo1vY/grpM+zXm5phyqnccZ0SHLvCHNS43n+tjy+IZzPPzf72KDkxiycN/Ng3QISD6dhY=
X-Received: by 2002:a17:903:1aec:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-233f3667693mr4853195ad.6.1747969501948; Thu, 22 May 2025
 20:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 May 2025 23:04:50 -0400
X-Gm-Features: AX0GCFti_M0Fp4mU-1G_pkEbk7lqnTt0avYUz5rqpiAYJyDp6s-Oacp_hg5elPo
Message-ID: <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, May 22, 2025 at 5:57=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This set improves per queue reset support for GC10+.
> This uses vmid resets for GFX.  GFX resets all state
> associated with a vmid and then continues where it
> left off.  Since once the IB uses the vmid, only
> the IB is reset and execution continues after the IB.
> Tested on GC 10 and 11 chips with a game running and
> then running hang tests.  The game pauses when the
> hang happens, then continues after the queue reset.

After further investigation, this appears to work as expected, but
only by chance.  The ring is reset, but any pipelined content in the
ring after the job is lost.  We either need to limit the ring to one
job or patch in the subsequent packets after resetting.

Alex

>
> I tried this same approach and GC8 and 9, but it
> was not as reliable as soft recovery.  I also compared
> this to Christian's reset patches, but I was not
> able to make them work as reliably as this series.
>
> Alex Deucher (9):
>   Revert "drm/amd/amdgpu: add pipe1 hardware support"
>   drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
>   drm/amdgpu: set the exec flag on the IB fence
>   drm/amdgpu/gfx11: adjust ring reset sequences
>   drm/amdgpu/gfx11: drop soft recovery
>   drm/amdgpu/gfx12: adjust ring reset sequences
>   drm/amdgpu/gfx12: drop soft recovery
>   drm/amdgpu/gfx10: adjust ring reset sequences
>   drm/amdgpu/gfx10: drop soft recovery
>
> Christian K=C3=B6nig (1):
>   drm/amdgpu: rework queue reset scheduler interaction
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 41 ++++++++-----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 35 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 35 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/nvd.h        |  1 +
>  7 files changed, 50 insertions(+), 92 deletions(-)
>
> --
> 2.49.0
>
