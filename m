Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B626C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 14:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFEF610E8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 14:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBFEF610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669208954A;
	Tue, 24 Aug 2021 14:00:02 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29998954A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 14:00:00 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4Gv9jB5L2gz4wy6r
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:59:58 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="IbSggPSa"
Date: Tue, 24 Aug 2021 13:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1629813592;
 bh=oA5IktXvvwLhI0jZAa33YOm3iC/IPHc4IC2LKIUrCxo=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=IbSggPSay/xx3Wcd75x2OsaWmpShkSo1JqBtPlmpqcKDGsyEcvrszpuZrkYjbueHU
 QKiI9XEl6EDeUKOZGiXpIGxncKkCsPCmFfevLI0PZshRoHtYdjOfTVsnrP4DVa7H4P
 LemMo9KHQCzxHrNg8mCXn0n5zlLMp9H8KWz7rN/MSOgXbsV7dt6B1fkHCkcA0A/JmK
 b4CPI2Gy0p3M8zd7RuUIi/akPjFoEqe2yy67vKZ2MZ5KXtUvaXgibFIRQ2MPSVs554
 2I/BMQgdtWfnjSRS3tUUy0r5acqcnulS4pNEY5hRCGUR3UmWl8sJ5BYibMHjZlhTCo
 r2J7s+W6iFpew==
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Message-ID: <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
In-Reply-To: <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo!

Thanks a lot for your reply! Comments below, please bear with me: I'm
a bit familiar with the cursor issues, but my knowledge of AMD hw is
still severely lacking.

On Wednesday, August 18th, 2021 at 15:18, Rodrigo Siqueira <Rodrigo.Siqueir=
a@amd.com> wrote:

> On 08/18, Simon Ser wrote:
> > Hm. This patch causes a regression for me. I was using primary + overla=
y
> > not covering the whole primary plane + cursor before. This patch breaks=
 it.
>
> Which branch are you using? Recently, I reverted part of that patch,
> see:
>
>   Revert "drm/amd/display: Fix overlay validation by considering cursors"

Right. This revert actually makes things worse. Prior to the revert the
overlay could be enabled without the cursor. With the revert the overlay
cannot be enabled at all, even if the cursor is disabled.

> > This patch makes the overlay plane very useless for me, because the pri=
mary
> > plane is always under the overlay plane.
>
> I'm curious about your use case with overlay planes. Could you help me
> to understand it better? If possible, describe:
>
> 1. Context and scenario
> 2. Compositor
> 3. Kernel version
> 4. If you know which IGT test describe your test?
>
> I'm investigating overlay issues in our driver, and a userspace
> perspective might help me.

I'm working on gamescope [1], Valve's gaming compositor. Our use-cases incl=
ude
displaying (from bottom to top) a game in the background, a notification po=
pup
over it in the overlay plane, and a cursor in the cursor plane. All of the
planes might be rotated. The game's buffer might be scaled and might not co=
ver
the whole CRTC.

libliftoff [2] is used to provide vendor-agnostic KMS plane offload. In oth=
er
words, I'd prefer to avoid relying too much on hardware specific details, e=
.g.
I'd prefer to avoid hole-punching via a underlay (it might work on AMD hw, =
but
will fail on many other drivers).

I'm usually using the latest kernel (at the time of writing, v5.13.10), but=
 I
often test with drm-tip or agd5f's amd-staging-drm-next, especially when
working on amdgpu patches.

My primary hardware of interest is RDNA 2 based (the upcoming Steam Deck), =
but
of course it's better if gamescope can run on a wide range of hardware.

I don't know if there's an IGT covering my use-case.

[1]: https://github.com/Plagman/gamescope
[2]: https://github.com/emersion/libliftoff

> > > Basically, we cannot draw the cursor at the same size and position on
> > > two separated pipes since it uses extra bandwidth and DML only run
> > > with one cursor.
> >
> > I don't understand this limitation. Why would it be necessary to draw t=
he
> > cursor on two separate pipes? Isn't it only necessary to draw it once o=
n
> > the overlay pipe, and not draw it on the primary pipe?
>
> I will try to provide some background. Harry and Nick, feel free to
> correct me or add extra information.
>
> In the amdgpu driver and from the DRM perspective, we expose cursors as
> a plane, but we don't have a real plane dedicated to cursors from the
> hardware perspective. We have part of our HUPB handling cursors (see
> commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
> overview), which requires a different way to deal with the cursor plane
> since they are not planes in the hardware.

What are DCHUBBUB and MMHUBBUB responsible for? Is one handling the primary
plane and the other handling the overlay plane? Or something else entirely?

> As a result, we have some
> limitations, such as not support multiple cursors with overlay; to
> support this, we need to deal with these aspects:

Hm, but I don't want to draw multiple cursors. I want to draw a single
cursor. If all planes are enabled, can't we paint the cursor only on the
overlay plane and not paint the cursor on the primary plane?

Or maybe it's impossible to draw the cursor on the overlay plane outside
of the overlay plane bounds?

I'm also confused by the commit message in "drm/amd/display: Fix two cursor
duplication when using overlay", because an overlay which doesn't cover the
whole CRTC used to work perfectly fine, even with the cursor plane enabled.

> 1. We need to make multiple cursor match in the same position and size.
> Again, keep in mind that cursors are handled in the HUBP, which is the
> first part of our pipe, and it is not a plane.
>
> 2. Fwiu, our Display Mode Library (DML), has gaps with multiple cursor
> support, which can lead to bandwidth problems such as underflow. Part of
> these limitations came from DCN1.0; the new ASIC probably can support
> multiple cursors without issues.
>
> Additionally, we fully support a strategy named underlay, which inverts
> the logic around the overlay. The idea is to put the DE in the overlay
> plane covering the entire screen and the other fb in the primary plane
> behind the overlay (DE); this can be useful for playback video
> scenarios.

Yeah, as I said above this requires knowing a lot about the target hardware=
,
which is a bit unfortunate. This requires hole-punching and significantly
changes the composition logic.
