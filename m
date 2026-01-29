Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C5D49C80
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA5010E095;
	Fri, 30 Jan 2026 09:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="JI41o1Rh";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B172C10E8D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 21:39:25 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 5579E323FBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 21:39:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1769722763; bh=oeT4OXAKbmTmw8AfSsNTLuktbgtWUx6BI381wCz0y9M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JI41o1RhqTvR4NScj1WLaUTn+0B68+Z7gSsYqXe4iMShdmqKsGGx+CrtB/lUHpkTN
 xLlLuhh6dSmLBN2O/rpVg8/vXFj435Fe4uKDOiDRnY6OTQ7X5A67u1phk5zB0bwTPq
 46sZ5JREvEa1N6vxTNF5BMG9j/PxYkQODcN5NLG8Z985f0E33WNyaXuJEYUYeFflDX
 pbV5MY6fQu5jRaRNEu2AO5H08t7YY+llOyFn+Y/Sdx9IgnRwgO8JSMa1q5LeNwh6rB
 aIpCh4ZpYixd7k/o8aPu4fi39gsGrr6vnGYjOdUhhyhOCdNEUy+oz/nyIsgiKPSH+r
 qpd8PRokK9yCQ==
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-64931bbf70cso1323451d50.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 13:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXnAX40IoPS2e3BE/FFqMKe6egrI0FPjhgDvPxwE8+QWCZXjG+GR8T9NAHfdHu15n182BfMc3/8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcWaFgTo3J+RqVJ8lzYshIUyJuU7jthg14xJ9STsTtV73Ji0+n
 yMpeBLfluvj42H87m/sS1+0ttzF+B36euFY7mHqiyAmLkfwHfX2sLdelG6aeJmTDW7uXw5NP1fa
 UTw4M8yC8AHg2EYHSndPhN0JeMXnKE9Q=
X-Received: by 2002:a05:690c:83:b0:794:9ad7:9304 with SMTP id
 00721157ae682-7949e06f50emr21573657b3.52.1769722761696; Thu, 29 Jan 2026
 13:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <fd3f2b16-41e7-4a9b-999d-e137e5abb7df@amd.com>
 <79ed136a-cedd-4e97-adb8-bc3f4f2b8bb4@mailbox.org>
 <601b38b5-1890-48f9-adf9-54fb85650852@amd.com>
In-Reply-To: <601b38b5-1890-48f9-adf9-54fb85650852@amd.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Thu, 29 Jan 2026 22:39:10 +0100
X-Gmail-Original-Message-ID: <CAFZQkGxFhbVAf-S98r_27NKtezdUiNtaA=cd7ATsVcX5iRManw@mail.gmail.com>
X-Gm-Features: AZwV_QjKsGVd3n43LhfAZr51kwQR2v9TA457PTh8DU8QLEOe_Ml8CuKivtZT_Ls
Message-ID: <CAFZQkGxFhbVAf-S98r_27NKtezdUiNtaA=cd7ATsVcX5iRManw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Hamza Mahfooz <someguy@effective-light.com>, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

> Then second even if the kernel can do it I'm not sure if it should do it.
>
> I mean userspace asked for a quick page flip and not some expensive CRTC/=
PLL reprogramming. Stuff like that usually takes some time and by then the =
frame which should be displayed by the page flip might already be stale and=
 it would be better to tell userspace that we couldn't display it on time a=
nd wait for a new frame to be generated.

I would personally prefer a new "pageflip failed" event, which the
compositor can react to appropriately.
For compositors not opting into that new API, the kernel automatically
fixing things would be nice though. Even pretending the pageflip
completed and then failing the next one with EINVAL would be enough to
trigger a modeset in the case of KWin.

> And third, there must be a root cause of the page flip not completing.
>
> My educated guess is that we have some atomic property change or even tur=
ning the CRTC off in parallel with the page flip. I mean HW rarely turns of=
f its reoccurring vblank interrupt on its own.
>
> Returning an error to userspace might actually help identify the root cau=
se.

There are two things I know that trigger pageflip timeouts frequently.

On dedicated GPUs, most of them seem to happen when a game causes a GPU res=
et.
In some cases, it seemed like the pageflip did complete, but the
kernel never sent the pageflip event to userspace. It also rejected
new atomic commits of the compositor with EBUSY - but a new instance
of the compositor could still do atomic commits just fine.
In other cases, triggering another GPU reset was necessary to recover,
and in yet other cases it was just broken beyond repair.
Presumably, all of them are caused by bugs in the GPU reset sequence.
As another piece of information on that, KWin only does atomic commits
once the fences of the involved buffers are signaled, and it does not
use OUT_FENCE_FD. So fence signaling should not be relevant, at least
not on the KMS uAPI level.

On APUs, the vast majority are caused by PSR. I know many AMD laptop
users that run with "amdgpu.dcdebugmask=3D0x10" to disable PSR as a
workaround, and have never seen a pageflip timeout since setting that
option. I have even seen a freeze *without* a pageflip timeout in
testing PSR again on my laptop recently, so PSR seems to have even
bigger issues.
Pageflip timeout or not, manually triggering a GPU reset seems to be a
reliable way to recover from it.
IMO that one is bad and widespread enough that PSR should be disabled
by default on the relevant AMD hardware until it no longer causes such
problems.

On the topic of whether or not this is just a thing the driver has to
fix, this isn't as exclusive to amdgpu as it might seem. i915 has some
pageflip timeout issues with apparently still unknown causes
(https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14604), and
the proprietary Nvidia driver had one some time ago that IIRC was
caused by firmware bugs.

Obviously, drivers still need to be fixed, but the bug is bad enough
for the end user that a fallback would be very helpful. If userspace
gets notified about it, we can still direct users to the relevant bug
trackers to get the underlying bugs hopefully fixed either way.

- Xaver
