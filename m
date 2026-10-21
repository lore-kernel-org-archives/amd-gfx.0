Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD1606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ahB8ahlq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEF710E18A;
	Wed, 21 Oct 2026 14:13:05 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63C110E18A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 14:12:53 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7cc18f754f1so50096137.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792591972; cv=none;
 d=google.com; s=arc-20260327;
 b=K07JhaSHsGHPEribhk7Oy7hEj4mkH45KPdDrRmeXP2NVpgh8PG13ylkdzNUL5e/O0z
 YCLo3s7PoylPwsl7FJDGDOeU/McjDpGORo/BDc0O8KQwnDxLMg/xTfxa080AqRmYm6Pq
 BOVlPCtUXyAjC/F1HeCTM/PoHy+L8s5wHTMGjyf2wPo9NObJXzWCqt9hZr2qZhndUPo0
 RvRmVB0wvGoR/ZUxluVl40Z0eVegVw+rlX1LX9BZM1wUP4gZ9Q13b/0Y1pIMxAVFl2s5
 P4pfTRumhwv1Sn9J5gIGMmy9xuoroqLCzP+tBDb5AxT4h9VyajTdDKUBeZYGEEXSQTOf
 5XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 fh=tyfdCLta83ua1ysINSscE9cHezOPCOT49uhaubQykgE=;
 b=Me4bYxujanCJhyjxtqNtyYTm+EaWCc8lS89jPgpnaocqBSCdee3MpezIJdue5J1rOx
 hDN2MU0fhS57zpvppTDEcvSrKb+pxPTwcf2jJbsjm2b5uKKntQwm10DaZIeFWvpOOwMN
 acTqr+3rXTedT05M2tSMMC4uTuFQ5KndNJFygM0TP431k7cPVK+/Gd6c5OHPB7FsUzhW
 K3gd2fDLRSM5Td+I+sKknH7JBzuGou/+GKxG4qjhHlZKgMzr08VHGQYY7T2L7wCZfYs8
 3jGXHDiytnqPInz7aV2+pDBWwTPjfzjMqM+3EhiJh1ApT3e5D4N2Kvqpx3J+j9xz9k2E
 6+Sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792591972; x=1793196772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 b=ahB8ahlqKm3bvzYZoQk6GRSrXfbgVueojP+Bskbno6m6dBORs04JUc+sr7d5dimzSd
 J5b1r2GTusllwswjMW0wAwPeqfAvj+ztdYAJ+tkd644vuJ2OwpZa5BAoYFeky/X7AsD8
 lp3ClWj7TtkdO2EyTgysDKrW6CTYMABbhxsM4JTWw2UDXpcuaOqyEY84IQpM2ItBe2ta
 ev/T3T41bmxDKGQJeS3ucoJ6Td3odakGvxM5r7Nd5ejAZc65eO4PhTNrCAQwsxMGTXk+
 DWnb4FRySmd0ywdwdo52KSRcGUBxsXCPHHpnppDv+6cOao4/AQVqmI71VsjvIX4TyZ1c
 1LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792591972; x=1793196772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQoWmb/HxHac52NQWhLiq+3ibthAyPMRZsuipu+rdAs=;
 b=RfG29MHl7S9tO1zE6b/pJVj7qn4n8lqZU61iXngkavlHxfJIurAriUWpmT+izBnW5d
 PR/s49VH90Hm5+AtNFY6S5tOESjYfhIAMBbC01OhYgUqFyLwyZsD0PrBAaLEt8Ptxb1L
 UZHUg9xHDR7mpv07bwi9LDVUtX/j7beVMATqydrXK3WZQEJoE9ZisOf37KGGaPUcJ8Ap
 X+jD6Rv9ERag2n7N5sRa5D3ukJR8J3wtIx8PCcdEwqgor6YgCFJsFrMFv0lIWeZnh3W6
 VhjAU1Pogw5GJsV8W1CNC5mLuxrLEMWMnVhfsg8KniqJsbJCdBxYCafrEoopGXgaZOg6
 px4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8+QQk4ViMIuGxAz9AqfLL4WX87fE5lqTWJgTfqlNCzala5dzpI6//vAL4DYxwrZYTF5WphWtA@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbVjGri7bks2st3Ua3GRDQd86KwCZpS7ms1kZdZ31aw89HcD4s
 3kw16mL+z/Fvtq2brxnnCHY+i/oupKJJpOqJdsJu3XPo/RRq4uoXZls3S4kdRQp+nuPxKFJlhoo
 YtTwPvV6oGDVwzg8UVwgSIPilnL6Edho=
X-Gm-Gg: AYBFou0CyVA+pX6ygOTlHluBOvWqipXsisNPrH7D+jhZTfOQHcdzNpIxHyinJEcTtOD
 VtiJQWxvJ2wUqDrTLywMG50aUruNNNFMq+GV/W7w+UMM1xqU+X7GhmpL4tFyene3sE3k5jdVFWf
 YT4D7CEh+aR3mXaa9Vq2fTBLKUsPytDWAI78iWvuphrGfgV1uvQd/+xHNdtWn0Y2wBFLwH7VC1j
 gsGK7SoUBvGBMRH8D8KUT1cjqDtTS62zp3HsAvW8Ck2mv5jEHLYMkmRuqxCtqRhf5rxhewxkkTH
 NSGhjOCmlPY0irkz1RPOxH/9R3bd9E3yKSUadtW0lK3PToXcpfKqBt7ig0gCZYSwZNEZr8CvpXB
 ZgLFs+Erp0PtbiA70/ccKPYLyDEKnGSEziWN65iCgvAnDqBRTO0jvLXrjaiP4HT8gr62ITCIIQL
 mGCZYmpm6uNumRvN/9yg5TryQ=
X-Received: by 2002:a05:6102:4194:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cc926171f6mr628639137.2.1792591972231; Wed, 21 Oct 2026
 07:12:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021114122.94008-1-mptagliari@gmail.com>
 <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
In-Reply-To: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 10:12:39 -0400
X-Gm-Features: AclHuK-Mw9BGZVWGR9q1KrhBrhnJKuPSqN4NUM_n9lJDGuHjZIzRA7A2WIY6Swg
Message-ID: <CADnq5_N-9O7Ba_o-mbPQU98Fr=LnRoGeJG5TtguSeK9wRM2kwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:10=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> [Adding Timur on CC]
>
> On 10/21/26 13:41, Matheus Tagliari wrote:
> > Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
> > hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
> > RDP server, which encodes through VAAPI, and reproduced it with a
> > plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
> > 8870M (Cape Verde).
> >
> > The VCE1 code never enables the VCE trap interrupt and the SI (and
> > Trinity) interrupt handlers do not process it, unlike the CIK code and
> > amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.
>
> Oh, I do remember that I intentionally never enabled interrupts for VCE o=
n radeon. But I honestly absolutely doesn't remember why (that was ~12-13 y=
ears ago!).
>
> Timur hammered out most (all?) of the UVD/VCE bugs on SI, CIK and partial=
ly Polaris hardware as well for amdgpu and we are strongly considering just=
 dropping SI/CIK support for radeon.
>
> The fence handling on radeon should work completely without interrupts si=
nce those have been rather flaky on really old HW.
>
> So no idea why that actually crashes for you if the interrupt is not enab=
led, my educated guess is that enabling interrupts actually doesn't fix the=
 crash but makes it less likely because of timing change.
>
> Would it be possible to just switch over to amdgpu instead? Or is there a=
ny support still missing there?

VCE1 was also on some older APUs that are radeon only.

Alex

>
> Regards,
> Christian.
>
> >
> > Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
> > none after, and 34 fps instead of ~4 fps for the workaround that avoids
> > the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
> > client, now encodes on the VCE ring for several minutes (about 40
> > fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
> > clean kernel log.
> >
> > Two caveats:
> >
> >  - I have not worked out why the missing interrupt turns into ring
> >    lockups instead of only added latency.  What I know is that the
> >    hang needs the VCE ring to wait on a hardware semaphore (disabling
> >    only the waiting side, or both sides, of radeon_vce_semaphore_emit()
> >    avoids it) and that handling the interrupt makes it go away with
> >    the semaphores left enabled.  If someone knows why, I would be glad
> >    to improve the commit message.
> >  - The Trinity/Richland change is compile tested only.
> >
> > The series was developed and tested on Debian's 6.12.113 with the
> > radeon module built out of tree.  It applies cleanly on drm-next
> > (fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=3D1,
> > allmodconfig) both after patch 1 and with the whole series.
> >
> > Matheus Tagliari (2):
> >   drm/radeon: process the VCE interrupt on SI and Trinity
> >   drm/radeon/vce1: enable the VCE trap interrupt
> >
> >  drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
> >  drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
> >  drivers/gpu/drm/radeon/sid.h       |  2 ++
> >  drivers/gpu/drm/radeon/vce_v1_0.c  |  4 ++++
> >  4 files changed, 34 insertions(+)
> >
> >
> > base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
> > --
> > 2.47.3
> >
>
