Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843BCCD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 22:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014FA10EEDD;
	Wed,  6 May 2026 22:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rMRe/5rL";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE65210EEDD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 22:03:06 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so170286f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2026 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778104985; x=1778709785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pp3EGtMWh4es5zgnmIQKBzlo4VRMQnZNGpWv2pjf1KI=;
 b=rMRe/5rLTwB2wo9Et4DMlK1M7Cl3r3U4MOy3Kg+a1M6s1WqL/IEjmlIGbwGVspw0oQ
 AZKQofW5Eaj75UQwBiKJ9lKlS+Qswwh55C/o2et5jk9F820cwLrt6bKAvaKoFjIi5f8e
 p+VSqqlkaLLSDmxVkSdtagRISBDDvJhPiFLyrFL8DuDaKI4Q8WHyyMzvHq9RqHuPdpw1
 o+5oKm3xBDmA3A0inV2s0sPrmIgAb8PpAIMOEDuxtS8S5PzAVGqRwgbhueDyacwKj/zH
 CUSr1FZ0N8Go3IZI76GgX1opfXgRYaUeVNjcnig5G+nV1VyKcjtlx7shRnpu+ZJ+U6Am
 Wj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778104985; x=1778709785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pp3EGtMWh4es5zgnmIQKBzlo4VRMQnZNGpWv2pjf1KI=;
 b=JLkjngh6KvJQb5XUDIixgdWngQbwDpFHIb2rtUTdXxvw/lCVVBuYSevJSR0hvzz7a9
 /KLI2d+/GMteJXqOw3OVeqslu7pUnEEkXIwEpCfCFqzZj3hQerEPbfMvw2Z+7gPQNnP4
 Twu7kXnqsSFzJpJxNkPSBhEmUzTzRgdmOUMDAhIfSv21rrLemI/b8fJECQhDtF2DV388
 kG20YGcn1LDbwzFb5bdExtUKZYRiMwSCxB3lapnXb+kVrUoXkq87UnjWGlMlX2D6wJKN
 Y85Je5y0l622x7dXSm6HpbiTDkzYZ2awjWwB++ymqIU8f0wib48ZpQM4pMXp3CCwyBNp
 73iQ==
X-Gm-Message-State: AOJu0YwfdX2z+ZoejywoJpa7BcxgAq2e+laa34NC8xfbiOafcFnABXsA
 PQAPw43ertZH0MNYjRPwXW1ElrBlEw9Rj8ppsiNwSDpaojSzYhA4+Rbds0/Ulw==
X-Gm-Gg: AeBDietTTNA6iBSZx3S11KPi+/Bgu6GQ+snka27MOuvFBUNSOEZsG/NpIxjwGAMgzNI
 QD6SyVa3kEATcABAja3UziIuxTNaMmlMSjY1aWNNF/usKNH1L1pVMy6cuypCf2jC24YMpvnsWrg
 sLwZ86nPVgySJ0CzTFLpZ5XMzbwY9VXW5jHhNfjOmWpMkaUuc+GlFkSHwxIunU4GKDGdh+eRXSs
 GBTXuR6u67YCErQviIjlVyZw+E3zOMSw8rFpXyYiv7ppUOcFjcWoK0rbfRH38V8gt6fGi/mrGYO
 LtS7Iw/m42xTBnNAzWvn7Us8GKQRn7Z+dKT1y74svuHJmVuLDKGvmmJpwRt0cGIQ3KLKIkmGsms
 BVprk3QIuqXLkHJjgwSEQ48t74hpltdImVNvZHhP8UaNZYmegnE+PcQlxLrAt46zDVQT4ZLvjqo
 3QErDs3Go/kKP1VRpnKDrhIRxS3gOc9E4DIepRLG09SITkqwI6GgUDhAxWKA4Zq38RLcVXP/EkL
 /ZxkFd9v6NfErXYtbA9
X-Received: by 2002:a05:6000:2507:b0:43f:e7c4:a36e with SMTP id
 ffacd0b85a97d-4515b525d56mr8844493f8f.16.1778104985158; 
 Wed, 06 May 2026 15:03:05 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm10698350f8f.8.2026.05.06.15.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 15:03:04 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com,
 mario.limonciello@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
Date: Thu, 07 May 2026 00:03:03 +0200
Message-ID: <2381512.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <2349271.vFx2qVVIhK@timur-hyperion>
 <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
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

On Wednesday, May 6, 2026 10:00:12=E2=80=AFPM Central European Summer Time =
Leo Li=20
wrote:
> On 2026-05-04 16:54, Timur Krist=C3=B3f wrote:
> > On Monday, May 4, 2026 8:36:49=E2=80=AFPM Central European Summer Time
> >=20
> > sunpeng.li@amd.com wrote:
> >> From: Leo Li <sunpeng.li@amd.com>
> >>=20
> >> [Why]
> >>=20
> >> VStartup is an OTG event that fires when the pixel pipeline prepares f=
or
> >> pixel scanout of the next frame. It was previously used to deliver
> >> vblank events for commits that do not trigger a fb address update, and
> >> hence a pflip interrupt (hw cursor updates, for example).
> >>=20
> >> The issue with vstartup is that HW can mask the interrupt in cases whe=
re
> >> idle optimizations are enabled or when a HW lock is active. This could
> >> the explain the range of flip_done timeouts frequently seen in the wil=
d.
> >=20
> > Can you help me understand how that could happen with vstartup?
> > Specifically, what is a "HW lock" and when is it active?
>=20
> Hi Timur,
>=20
> I should've prefaced this patch to say that this is a theoretical fix. I
> haven't been able to reproduce the timeout issues myself, and this patch
> came out of internal discussions with folks more familiar with the HW. I
> don't think this will fix *all* cases of flip_done timeouts, but it may
> address some of them.

I see.
Yeah, I've only very rarely seen that issue myself. Seems that the bug avoi=
ds=20
driver devs, but it's very popular among end users.

>=20
> (But timeouts aside, we *should* transition to vline since it's more
> reliable than vstartup.)

I agree.

>=20
> To answer your questions: depending on the DCN generation, there can be a
> few things that affects vstartup firing:
>=20
> * DPG - DCN can Dynamically Power Gate parts of the display pipe when a
>   self-refresh capable eDP is connected. DPG is engaged when there's enou=
gh
>   static frames (detected thru drm_vblank_off) Once gated, even though the
> OTG (output timing generator) is still enabled, vstartup is masked. vline
> is unaffected.
>=20
> * GSL - Driver can use the Global Sync Lock to block HW from latching onto
>   double-buffered registers during programming, to prevent HW from latchi=
ng
> onto a partially programmed state. This will mask vstartup, but vline is
> unaffected. See dcn20_pipe_control_lock()
>=20
> * MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can store=
 fb
> data to allow for longer DRAM sleep. When scanning out from MALL, vstartup
> is masked, vline is unaffected.

Thanks for the explanation.
Just one more question: does DCN always mask the VSTARTUP interrupt under=20
those conditions or is that configurable?

>=20
> > Many users have experienced flip_done timeouts while playing games.
> > In that scenario, would any idle optimization be enabled or is there a =
"HW
> > lock"?
>=20
> If the game stops submitting frames for ~15 refresh cycles, it's possible
> that PSR kicks in. Though I know there are plenty of reporters running on
> external without PSR support. If it's DGPUs, it's very likely due to MALL.
> A reporter I was debugging with said disabling MALL showed good results[1=
].
> If it's an APU with an external monitor, then that's less clear.
>=20
> A lot of the reporters seem to be running Phoenix (DCN314), with a common
> symptom of DMUB timing out[2]. If a self-refresh panel is involved, then =
I'm
> curious if this vline2 patch would help. Hamza's recent patch[3] that
> enables various levels of reset may help to mitigate, but it doesn't fix
> the root-cause. I'm planning a branch with this patch and [3], along with
> debug dumps on flip_done timeouts for reporters to try.
>=20

That's very nice to hear. I'm crossing my fingers that it works out.

> [1]https://lore.kernel.org/amd-gfx/e415c38b-4102-40e4-a195-0256caf34802@m=
1k.
> cloud/ [2]https://gitlab.freedesktop.org/drm/amd/-/work_items/4831
> [3]https://lore.kernel.org/lkml/20260505182105.420525-2-someguy@effective=
=2Dli
> ght.com/
> >> DCN hardware provides 3 generic OTG interrupts that can be programmed
> >> to>> fire on a specific line. Vline 0 and 1 are currently reserved, wi=
th
> >> vline2 available to use for event delivery. These interrupts cannot be
> >> masked, as long as the OTG is active.
> >>=20
> >> [How]
> >>=20
> >> Switch to vline2 for vblank handling. Today, DC will program the
> >> vline2 position to at vupdate -- the point at which HW latches to
> >> double-buffered registers.
> >>=20
> >> Since all the vline interrupt types share the same interrupt src_id,
> >> refactor the existing vline0 infrastructure to allow for all the vline=
0,
> >> 1, and 2 types.
> >>=20
> >> Since this is intended to replace vstartup for DCN, use the same handl=
er
> >> logic, but be careful to leave DCE on vstartup.
> >=20
> > Why not also switch DCE?
> > Does DCE not have the vline interrupts or does it not have the same iss=
ue
> > with the vstartup interrupt?
>=20
> I didn't want to touch DCE since I don't have information on how these
> interrupts behave on them, and I didn't want to regress anything. Would n=
eed
> to do some digging to find out.
>=20

Do we have any reports of these page flip timeouts on DCE?
Maybe it's better to leave DCE well enough alone if the issue doesn't exist=
=20
there. (I have never seen one, but that doesn't mean it doesn't exist.)

Best regards,
Timur





