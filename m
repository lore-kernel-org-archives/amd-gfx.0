Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D0C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 13:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8567160EE7
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 13:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8567160EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8A66E96E;
	Fri, 27 Aug 2021 13:47:23 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC436E931
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 13:47:22 +0000 (UTC)
Date: Fri, 27 Aug 2021 13:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1630072039;
 bh=2mpSyvRYN68a+AVrYi3b/7VbwUDdjjVaGKHjJkRpaKA=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=LMrrIPO2N0Klnu6OG0ZvHacfMN+Jo04BZspdZfFZ7fX9s0t6tm8BL0luhZq0em26J
 cG2TQQ0z+EVoejbfnmB7Epdi6xtIEBy87WhcwIlULJfVATnXNTT/Vhp2jJHxWJ9laR
 5uOtoarN0rDwzgudmy/pim9MERYKph7CY/oVzj7Z7NYY+YSIywwuK6Dg3lt5rJZ8Qv
 WKClU4Mam9x0YOHbcnS+DTeSv5x41mqQRCO/29nN6DHrcWKbjx7VMFdpEiUGH0azIE
 jcC05w6zU40T2TIvhgetzhSLFeu4j28PZXexEOE/4LQPETULLcsZpuGWKufzgVEvPw
 gJF5ue7qFZlQA==
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Sean Paul <seanpaul@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Louis Li <Ching-shih.Li@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Message-ID: <dyHqMa1Vv12hhoVMu0T4tJLDavAQh9ZyKNpwk9-GN8u_sdXYaQMLkxXXxrivyEeVOPbu7MDwj0QVMZowSxv70AHmYw3r_yWJbU4a5Bvt9U0=@emersion.fr>
In-Reply-To: <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
 <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
 <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
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

Hi Nicholas!

On Tuesday, August 24th, 2021 at 16:56, Kazlauskas, Nicholas <nicholas.kazl=
auskas@amd.com> wrote:

> It's easiest to under the hardware cursor as being constrained within
> the DRM plane specifications. Each DRM plane maps to 1 (or 2) hardware
> pipes and the cursor has to be drawn along with it. The cursor will
> inherit the scale, bounds, and color management associated with the
> underlying pipes.

Ah, I see. So the reason why we need to draw the cursor twice is to
accomodate for the case where it's visible on both the primary and
overlay planes, e.g.

=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82Primary                     =E2=94=82
=E2=94=82                            =E2=94=82
=E2=94=82                            =E2=94=82
=E2=94=82        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90           =E2=94=82
=E2=94=82        =E2=94=82Cursor =E2=94=82           =E2=94=82
=E2=94=82        =E2=94=82       =E2=94=82           =E2=94=82
=E2=94=82        =E2=94=82   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90  =E2=94=82
=E2=94=82        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98        =E2=94=82  =E2=94=82
=E2=94=82            =E2=94=82            =E2=94=82  =E2=94=82
=E2=94=82            =E2=94=82            =E2=94=82  =E2=94=82
=E2=94=82            =E2=94=82     Overlay=E2=94=82  =E2=94=82
=E2=94=82            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98  =E2=94=82
=E2=94=82                            =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

Is that right?

In the case where the cursor only intersects a single plane (either primary
or overlay) we need to draw it once only.

Since some KMS user-space (ChromeOS) uses the non-atomic cursor with the re=
st
of the atomic API, we need to always ensure that the cursor can be enabled =
at
any time, even if it's currently disabled.

> Correct me if I'm wrong, but I think your usecase [1] falls under the
> category where:
> 1. Primary plane covers entire screen
> 2. Overlay plane does not cover the entire screen
> 3. Overlay plane is scaled

(1) and (2) are correct, but (3) is not. My overlay plane isn't scaled, but=
 my
primary plane may be. That doesn't change the outcome: the unscaled cursor =
can
be painted onto the overlay pipe, but not onto the primary pipe.

> I don't remember if DRM has a requirement that the cursor plane must be
> topmost, but we can't enable [1] as long as it is.

KMS has a standard "zpos" property [1], which may be mutable. So we could i=
n
theory set an immutable "zpos" for the primary plane and overlay plane, and
allow user-space to change the "zpos" of the cursor plane to move it
in-between.

But for my use-case, I need the cursor plane to be painted on top of the
overlay, so it'd only be useful when the cursor doesn't intersect the overl=
ay.

[1]: https://drmdb.emersion.fr/properties/4008636142/zpos

> 1. You want to save power:
>
> You will burn additional power for the overlay pipe.
>
> But you will save power in use cases like video playback - where the
> decoder produces the framebuffer and we can avoid a shader composited
> copy with its associated GFX engine overhead and memory traffic.
>
> 2. You want more performance:
>
> You will burn additional power for the overlay pipe.
>
> On bandwidth constrained systems you can save significant memory
> bandwidth by avoiding the shader composition by allowing for direct
> scanout of game or other application buffers.
>
> Your usecase [1] falls under this category, but as an aside I discourage
> trying to design usecases where the compositor requires the overlay for
> functional purposes.

My use-case actually falls under both (1) and (2). We want to leave as much
bandwidth as possible for the game to use. We want to save power because we=
're
running on battery.

We don't _require_ KMS planes to run, we have a fallback composition path w=
hich
uses the compute queue. But we want to do as much as possible to use KMS pl=
anes.
