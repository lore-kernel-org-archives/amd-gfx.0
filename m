Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84826D25B44
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B35910E680;
	Wed, 28 Jan 2026 11:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hycfRv5Z";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D12A10E680
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 11:24:10 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so76090335e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 03:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769599449; x=1770204249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqxiDDJL8+kOG7viwOsgkBd749Kmuo+B5Ya1pZqhFsU=;
 b=hycfRv5ZnlzsYsR0F4kVY0ADzsA///Q8vXulKWPDjKC7j2eqTr17x5CMK8Jc+EbTR1
 LkO0kVYkyCsRdX4uo/xSTbBshc5nMJg+XwPMb1KKMahw+DQnjq/hN5TBPLXbgaHC0iYv
 duh67SRRZY7AJKHPYs9dMdEgZaySFvpchXWaEdjBX3UHNGThF0MAlW0f1JrCZPVQ+O3a
 hISTDRzFXF+VBR3ZK++oqXq0aezNBBgr3o9uRtzgA2CyXO+MsfCqM7TlpbdSP3SbPGVN
 lkuUGLIwK5ahLKJugixlKzkXBwpFd4nIXZMkEy5TpHzhW2pbgLEP4BZGXr/BPeFpNqML
 hCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769599449; x=1770204249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqxiDDJL8+kOG7viwOsgkBd749Kmuo+B5Ya1pZqhFsU=;
 b=ggNiYx5VKWx2Af4tXihtuRmVwwUGm1PkcCPA3D0H2idRrR2BkGpEizAke8wcDImicg
 cs+DrenqryeNJf29OcYyO0k5W+/8Ep8lexneVM2T3nB9neJkZDQkOM/hdVQ0cHjSoAvd
 0bU6u6Nof1W/OT0kxD9/3ABeBvChPdMXCSsjhd3TZihstWPWJsBrnsG2zVbjMbyxJ3f9
 x/7aziL32UMsKufC29AV8AcWEmS2MNtnHPsq8wDfJHK349x8brgbj69hyktzU4WDZJSe
 QbT9T8n/9jpNqp/ewQFuXpU0upTOTugFXjiNIQo/9wiqt/OhaV9Pnv73BuPNOjXn9IN8
 v6EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFcWY/GeYLPYECR0lC25OD84joFW15fXzjVgMnjHfpXbjYfAdO8Da15j1/sm6vjLLmBpLEa1Gw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzs/nRq4lLU356dxwN0kMWAnt1e9I+ytAICNUimvtSmU6GZCoJU
 QILKmutMzNQBDhv8VbADNEsdIr+6QlT9y08rngXDiRhoo2csV1rYiRKzMYOe1A==
X-Gm-Gg: AZuq6aISaHrucl9QLz4r1RlJVNIdkbke9EgMMfFm6u9f21AENHs9+PpLRPoSqVwDohA
 hDojk7IHVC9+vjgjNNkaYPc4a7eBQ1NTAzEmd6+V2hTy+vz8iblz2V4CemY8Zbi4WkUtdV9tJxd
 s/wG/Q1IiZe+cgJnYfTXkFRF1OxkxC63NVRMkDvycew2J1iV9SdrUjh9shPWwUIUeD6f17lzM9g
 VU5n0Ot6kkS3LAwZHzIdmn3zIg8ky1sG2KMi0yB5cNaCTyvBMEx/GHwMp3HwZP0lXVvQ5fCkTjq
 GsETVmCzyUymy+WcMUYpc4VLcxR9B6uQcthWKorzGq4ocyzLPIWzrqAu0ptLud0nw7l2UOmb22R
 TDx0EzYxdrvgSn0vVaNAZ/+zURco5H4zucR32ppdlbnNuz7QGTbYPBVT4a8J+mB0XMSxJIHa3wv
 TVYKUD3fWExd377R+EjzZ9lkiqBn0OKVHJE/W/E5g4Jdk4KC3nLnSuz1NtAalv6QTWnP+EGww9L
 NS1EWPPEDuHakCkpybC57oe0p0N
X-Received: by 2002:a05:6000:26ce:b0:430:b100:f591 with SMTP id
 ffacd0b85a97d-435dd0649c9mr6800554f8f.28.1769591974093; 
 Wed, 28 Jan 2026 01:19:34 -0800 (PST)
Received: from timur-max.localnet
 (20014C4E24CAAB0049977272BDA969E7.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:ab00:4997:7272:bda9:69e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e490esm5431242f8f.9.2026.01.28.01.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 01:19:33 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Hamza Mahfooz <someguy@effective-light.com>, dri-devel@lists.freedesktop.org, 
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Wed, 28 Jan 2026 10:19:32 +0100
Message-ID: <5173841.OV4Wx5bFTl@timur-max>
In-Reply-To: <601b38b5-1890-48f9-adf9-54fb85650852@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <79ed136a-cedd-4e97-adb8-bc3f4f2b8bb4@mailbox.org>
 <601b38b5-1890-48f9-adf9-54fb85650852@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. janu=C3=A1r 26., h=C3=A9tf=C5=91 14:00:59 k=C3=B6z=C3=A9p-eur=C3=
=B3pai t=C3=A9li id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 1/26/26 11:27, Michel D=C3=A4nzer wrote:
> > On 1/26/26 11:14, Christian K=C3=B6nig wrote:
> >> On 1/23/26 15:44, Timur Krist=C3=B3f wrote:
> >>> On Friday, January 23, 2026 2:52:44=E2=80=AFPM Central European Stand=
ard Time
> >>>=20
> >>> Christian K=C3=B6nig wrote:
> >>>> So as far as I can see the whole approach doesn't make any sense at
> >>>> all.
> >>>=20
> >>> Actually this approach was proposed as a solution at XDC 2025 in Harr=
y's
> >>> presentation, "DRM calls driver callback to attempt recovery", see pa=
ge
> >>> 9 in this slide deck:
> >>>=20
> >>> https://indico.freedesktop.org/event/10/contributions/431/attachments/
> >>> 267/355/2025%20XDC%20Hackfest%20Update%20v1.2.pdf
> >>>=20
> >>> If you disagree with Harry, please make a counter-proposal.
> >>=20
> >> Well I must have missed that detail otherwise I would have objected.
> >>=20
> >> But looking at the slide Harry actually pointed out what immediately c=
ame
> >> to my mind as well, e.g. that the Compositor needs to issue a full
> >> modeset to re-program the CRTC.>=20
> > In principle, the kernel driver has all the information it needs to
> > reprogram the HW by itself. Not sure why the compositor would need to be
> > actively involved.
> Well first of all I'm not sure if we can reprogram the HW even if all
> information are available.
>=20
> Please keep in mind that we are in a dma_fence timeout handler here with =
the
> usual rat tail of consequences. So no allocation of memory or taking locks
> under which memory is allocated or are part of preparing the page flip
> etc... I'm not so deep in the atomic code, so Alex, Sima and probably you
> as well can answer that much better than I do, but of hand it sounds
> questionable.
>=20
> On the other hand we could of course postpone reprogramming the CRTC into=
 an
> async work item, but that might created more problems then it solves.
>=20
> Then second even if the kernel can do it I'm not sure if it should do it.
>=20
> I mean userspace asked for a quick page flip and not some expensive CRTC/=
PLL
> reprogramming. Stuff like that usually takes some time and by then the
> frame which should be displayed by the page flip might already be stale a=
nd
> it would be better to tell userspace that we couldn't display it on time
> and wait for a new frame to be generated.

I agree with Michel here. It's a kernel bug, it should be solved by the=20
kernel. I don't like the tendency of pushing userspace to handle kernel bug=
s,=20
especially if this is just needed for one vendor's buggy driver. (No offenc=
e.)

>=20
> And third, there must be a root cause of the page flip not completing.
>=20
> My educated guess is that we have some atomic property change or even
> turning the CRTC off in parallel with the page flip. I mean HW rarely tur=
ns
> off its reoccurring vblank interrupt on its own.

I think a page flip timeout can many root causes, so it's unlikely that a=20
single solution would solve all of it.

See:
https://gitlab.freedesktop.org/drm/amd/-/issues?
label_name[]=3Dpage%20flip%20timeout

Best regards,
Timur



