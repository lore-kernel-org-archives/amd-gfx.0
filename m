Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E4FC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 13:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B6960E99
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28B6960E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835A46E931;
	Fri, 27 Aug 2021 13:53:55 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038766E96D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 13:53:54 +0000 (UTC)
Date: Fri, 27 Aug 2021 13:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1630072432;
 bh=RvJl0BLYT2BKBSA6cwr1ECyv/r6pI/yt1f6yZSt3Rlk=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=NF7WcaBYJccnP2xGdNorcakDhTJjjWrkJaujnMZatoAi7b35KouHOtVlhlcU6cR4O
 J/NhDgEFRp6S2Gza2XFTXHms4Sf+5TnpzG5VbjyPFYAD4DYBOmxMpSxjcPhG/rMVBE
 itMq36Jr/sHuvbRyxobKd7UE360ViHhfJh0JIhW2Ec1h84qHjnaDYaUUp3crQkHYoV
 liAvkbk6f5kGByE8PXUa7HL6y+7e/D688jtZJlS54FxbjcPvzGzDeP5hFTxwEqO6mL
 IMeAUXUbWb/xLJNyeRSfNvqukqgh/1QOnD4siqUHd/4fnTFFcbDI7bIf7lRuLM+J1L
 N6cDvlWa8Tipg==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Sean Paul <seanpaul@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Message-ID: <v7wPXeGl1gSs2otq7y-EJar0E_NLb4b6YxLZvzleaUPOy5jFuCOpuVFqTRWdGVJ7CP561cBXhfYy-TlQgIlX5vhxtqE64mBtt_cvtIyytXw=@emersion.fr>
In-Reply-To: <7a1d1909-cead-16ef-7b22-b2adc0cf3ee2@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
 <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
 <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
 <7a1d1909-cead-16ef-7b22-b2adc0cf3ee2@amd.com>
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

On Tuesday, August 24th, 2021 at 18:48, Harry Wentland <harry.wentland@amd.=
com> wrote:

> To elaborate on this a bit more, each HW plane's scanout engine
> has the ability to scan out a cursor, in addition to the plane's
> framebuffer. This cursor is drawn onto the plane at the scanout
> phase. Any further scaling, color processing, or other operation
> on the pipe will equally apply to the cursor as to the framebuffer
> itself.
>
> Our driver will look at the cursor position and place the cursor
> with the topmost HW plane at that position.

Ah. I may have missed something in my previous email then. With the
scenario I've described:

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

Is it possible to draw the cursor only on the overlay pipe (not on the prim=
ary
pipe), even though the overlay pipe doesn't cover the whole CRTC?

Or will the overlay pipe crop the cursor image?

> If I understood Simon right the primary plane (bottom-most,
> game plane) might not cover the entire screen, which is fine.

Yes.

> Is the Steam overlay always the size of the crtc, or does it
> match the size of the game plane, or is it unrelated to either?

The overlay may not cover the whole CRTC. The usual case is some kind of
notification bubble showing in a corner. See the drawing above.

> >>>>> Basically, we cannot draw the cursor at the same size and position =
on
> >>>>> two separated pipes since it uses extra bandwidth and DML only run
> >>>>> with one cursor.
> >>>>
> >>>> I don't understand this limitation. Why would it be necessary to dra=
w the
> >>>> cursor on two separate pipes? Isn't it only necessary to draw it onc=
e on
> >>>> the overlay pipe, and not draw it on the primary pipe?
> >>>
> >>> I will try to provide some background. Harry and Nick, feel free to
> >>> correct me or add extra information.
> >>>
> >>> In the amdgpu driver and from the DRM perspective, we expose cursors =
as
> >>> a plane, but we don't have a real plane dedicated to cursors from the
> >>> hardware perspective. We have part of our HUPB handling cursors (see
> >>> commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
> >>> overview), which requires a different way to deal with the cursor pla=
ne
> >>> since they are not planes in the hardware.
> >>
> >> What are DCHUBBUB and MMHUBBUB responsible for? Is one handling the pr=
imary
> >> plane and the other handling the overlay plane? Or something else enti=
rely?
>
> MMHUBBUB > DCHUBBUB > HUBP (for each pipe)
>
> MMHUBBUB is irrelevant if DWB (display writeback) is not used. DWB is not
> enabled in the driver.
>
> DCHUBBUB is the overall scanout engine for all DC pipes and includes a
> HUBP per pipe.
>
> HUBP will have requestors for the primary framebuffer, DCC meta, dynamic
> metadata (for things like Dolby HDR, though it's not fully implemented),
> and cursor data.

I see. Thanks!
