Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB58ECD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 21:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B74C10EED9;
	Wed,  6 May 2026 21:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4vHZWVt";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F9C10EED8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 21:57:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so876605e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2026 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778104644; x=1778709444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjssbzfPggi6kf6LfYiYMt7I95POHyeXwjlx4GALU6U=;
 b=f4vHZWVtWuUc8t/K5ocLlJRjsD3BRka5RRoTYeg3zVZhW1vPKwr5boAm8OGEmw74B5
 CT3tgphAReLZ3ji4paoK+Mq8kFbCTTKN5Y8pjZMp0nzwYFXaRJtvzXx+a6Q5pUu/EEEK
 yLzR8nHa9kSN9erYaVI7Qs5FFKSNMO82pcQWj7FgS8A+EbHmzM62maA67no5vCkskhKv
 YefpwtYQXUiJsV+rpMkEtZFGVszx+v6QlUdmqkCpRqJNgiOeo0Wjhlr+WNaLtQiOjt5u
 rkHP6EaBBd/Tcby6OnIl3rlMjsM2FFaIGXIqQs/1NPCWsBmHC0Gmt4YGw25z8IFbaMmt
 X9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778104644; x=1778709444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bjssbzfPggi6kf6LfYiYMt7I95POHyeXwjlx4GALU6U=;
 b=cQSkV9usIoNrKbFwXdhldrhuMPPk8A8OYd3d7Grd3tegKmJRlb/0vdgGvO+YkFfoe5
 Yy81DL96FftB0Gayfod4IFYdszoPQQEsscS4JfoliR8LAdPM7KkSssNkCyNdMN1tMNip
 qiNzR8sdVZo4BSt4sdnk2cv/74nmYoYvU9HLIqx54yzfavRehNM+QN6Rojifuka8aEhH
 oRU5ZyROWnXefxATrdWt93wjTVjdJTyIkzZE9v/YRpVNeUsz/pV3W5pxxx6SeuH1LXQZ
 2yLX+3Kty+v8k030tEE7KXTn+9HX34YvUdQdxgBjFjjbtOtoRQFJuuzDWzY2BY0n5HHu
 t06g==
X-Forwarded-Encrypted: i=1;
 AFNElJ969D8VZzr4+GZv/569HVVbRpa3ijDTFofyEgAdT+pJEgRbAGjs2/86a1LDR+8hbREGDrJWirFW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH3aLaFLq+zWQgyEF28qvOX5oh65bXMbBrXQu6UuTMCkkm71H3
 I20jFNlw9S2VcAOE43ok9yFU7f8CVB8f4x97e6Y6qhr8dufx3ix/xSfF
X-Gm-Gg: AeBDievi6xErGPRAoF7CUjyyTEyfaJZL4pkARfkZs8vz2XM5D7MazdVgh+wkPIrnI8T
 wtxmd+qZ1iMDX6QrkiWJZJs5yORA18RRHPxDwDZUWdGxBwGirC4U3NhbOwtH9zes5HtGilAgJ85
 g836s62qWXF11B16lh5PZVJxEjLg5m845/PhYlA/gLXD8HqrmXd4+KZ2edM7k0wKy/oXo+XmaTQ
 p+lrqrq+znxjaGNPFbhrlO+zP0aVOluiUh7q3YZsVS5GpaDzGgbMkAs1ybyBgBg+vttjQKLEfls
 E8u+sQDEOR4rIgGkbZAa240nGFiMHqIGb/bt+m2C1DBTQOM1SOJR63j+DoAKYwfK6rMAFVGLZ17
 ye3COnyXEWlUA2XaCp113Slep8Lp/lez5ICde0Yqdfs8Xkaef07GqP98tgnryEp7mCg474/uu7E
 VYWAtMtvRRhVHv8ysIzT/UjwasvRNTdq2pbg1rnNr+hHRiu8S9wLB78Til6r0hkKyWpPwc2I9Ht
 0lCEvkFEw==
X-Received: by 2002:a05:600c:c0c1:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48e51e1ee16mr65094475e9.10.1778104644015; 
 Wed, 06 May 2026 14:57:24 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530c5c89sm24587145e9.13.2026.05.06.14.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 14:57:23 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo.Pillai@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com, 
 sysdadmin@m1k.cloud
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
Date: Wed, 06 May 2026 23:57:22 +0200
Message-ID: <2253800.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <dc74c28b-e4e0-4617-b5af-317e29625782@amd.com>
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
 <dc74c28b-e4e0-4617-b5af-317e29625782@amd.com>
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

On Wednesday, May 6, 2026 10:32:16=E2=80=AFPM Central European Summer Time =
Harry=20
Wentland wrote:
> On 2026-05-06 16:00, Leo Li wrote:
> > On 2026-05-04 16:54, Timur Krist=C3=B3f wrote:
> >> On Monday, May 4, 2026 8:36:49=E2=80=AFPM Central European Summer Time
> >>=20
> >> sunpeng.li@amd.com wrote:
> >>> From: Leo Li <sunpeng.li@amd.com>
> >>>=20
> >>> [Why]
> >>>=20
> >>> VStartup is an OTG event that fires when the pixel pipeline prepares =
for
> >>> pixel scanout of the next frame. It was previously used to deliver
> >>> vblank events for commits that do not trigger a fb address update, and
> >>> hence a pflip interrupt (hw cursor updates, for example).
> >>>=20
> >>> The issue with vstartup is that HW can mask the interrupt in cases wh=
ere
> >>> idle optimizations are enabled or when a HW lock is active. This could
> >>> the explain the range of flip_done timeouts frequently seen in the wi=
ld.
> >>=20
> >> Can you help me understand how that could happen with vstartup?
> >> Specifically, what is a "HW lock" and when is it active?
> >=20
> > Hi Timur,
> >=20
> > I should've prefaced this patch to say that this is a theoretical fix. I
> > haven't been able to reproduce the timeout issues myself, and this patch
> > came out of internal discussions with folks more familiar with the HW. I
> > don't think this will fix *all* cases of flip_done timeouts, but it may
> > address some of them.
> >=20
> > (But timeouts aside, we *should* transition to vline since it's more
> > reliable than vstartup.)
> >=20
> > To answer your questions: depending on the DCN generation, there can be=
 a
> > few things that affects vstartup firing:
> >=20
> > * DPG - DCN can Dynamically Power Gate parts of the display pipe when a
> >=20
> >   self-refresh capable eDP is connected. DPG is engaged when there's
> >   enough
> >   static frames (detected thru drm_vblank_off) Once gated, even though =
the
> >   OTG (output timing generator) is still enabled, vstartup is masked.
> >   vline is unaffected.
> >=20
> > * GSL - Driver can use the Global Sync Lock to block HW from latching o=
nto
> >=20
> >   double-buffered registers during programming, to prevent HW from
> >   latching onto a partially programmed state. This will mask vstartup,
> >   but vline is unaffected. See dcn20_pipe_control_lock()
> >=20
> > * MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can sto=
re
> > fb>=20
> >   data to allow for longer DRAM sleep. When scanning out from MALL,
> >   vstartup is masked, vline is unaffected.
> >>=20
> >> Many users have experienced flip_done timeouts while playing games.
> >> In that scenario, would any idle optimization be enabled or is there a
> >> "HW
> >> lock"?
> >=20
> > If the game stops submitting frames for ~15 refresh cycles, it's possib=
le
> > that PSR kicks in. Though I know there are plenty of reporters running =
on
> > external without PSR support. If it's DGPUs, it's very likely due to
> > MALL. A reporter I was debugging with said disabling MALL showed good
> > results[1]. If it's an APU with an external monitor, then that's less
> > clear.
> >=20
> > A lot of the reporters seem to be running Phoenix (DCN314), with a comm=
on
> > symptom of DMUB timing out[2]. If a self-refresh panel is involved, then
> > I'm curious if this vline2 patch would help. Hamza's recent patch[3] th=
at
> > enables various levels of reset may help to mitigate, but it doesn't fix
> > the root-cause. I'm planning a branch with this patch and [3], along wi=
th
> > debug dumps on flip_done timeouts for reporters to try.
> >=20
> > [1]https://lore.kernel.org/amd-gfx/e415c38b-4102-40e4-a195-0256caf34802=
@m1
> > k.cloud/ [2]https://gitlab.freedesktop.org/drm/amd/-/work_items/4831
> > [3]https://lore.kernel.org/lkml/20260505182105.420525-2-someguy@effecti=
ve-> > light.com/>=20
> >>> DCN hardware provides 3 generic OTG interrupts that can be programmed
> >>> to>> fire on a specific line. Vline 0 and 1 are currently reserved,
> >>> with vline2 available to use for event delivery. These interrupts
> >>> cannot be masked, as long as the OTG is active.
> >>>=20
> >>> [How]
> >>>=20
> >>> Switch to vline2 for vblank handling. Today, DC will program the
> >>> vline2 position to at vupdate -- the point at which HW latches to
> >>> double-buffered registers.
> >>>=20
> >>> Since all the vline interrupt types share the same interrupt src_id,
> >>> refactor the existing vline0 infrastructure to allow for all the vlin=
e0,
> >>> 1, and 2 types.
> >>>=20
> >>> Since this is intended to replace vstartup for DCN, use the same hand=
ler
> >>> logic, but be careful to leave DCE on vstartup.
> >>=20
> >> Why not also switch DCE?
> >> Does DCE not have the vline interrupts or does it not have the same is=
sue
> >> with the vstartup interrupt?
> >=20
> > I didn't want to touch DCE since I don't have information on how these
> > interrupts behave on them, and I didn't want to regress anything. Would
> > need to do some digging to find out.
>=20
> DCE's architecture is quite different in this regard. No VSTARTUP, VUPDATE
> signals and interrupts on DCE.
>=20

Hi Harry,

I'm pretty sure DCE has VUPDATE, starting from DCE 8, it is used for VRR.
You can verify this in irq_service_dce80.c

Not sure about VSTART, I'm a bit confused about that, but Leo above says th=
at=20
DCE uses that, but I can't find it.

Timur





