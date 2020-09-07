Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B5C2BB84
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 11:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7662F218AC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 11:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="hOOMo7UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7662F218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0196E434;
	Mon,  7 Sep 2020 11:19:16 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8536E43D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 11:19:14 +0000 (UTC)
Received: by mail-io1-xd41.google.com with SMTP id b16so13604392ioj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iSMAJyQnojOCbl+pS+23apnKqQXokc1A+gnWCgPYgpA=;
 b=hOOMo7UPorEhWgucxr6dV14qHX60sHJDsrG1tYk38jMWYrSFEicZDHkN2vtomj51CD
 93fdOtyj4KUHDgBje5Rhl91Qw7MHH50Bg2boprc25uJ06C1D6SiC4yYa7Xeo9iDIBlZE
 Ew+/IIlC6Mjru8c8f8hRQkTF29CgeDnrIzYfvYVS1r4YgD+Vxkt09QeLOOphZKwLbu5V
 jgNBzAO3wg4qm0DvRAsoOQegTtEAb66dcjX87g9Jdxw1y4ZlpotC3fsDSW4QGam3YLFk
 1+yU6oSKNvhUjngBJEFZwhEHvA6j8nw4LUX2mbCEK2k9FeUudFDmtMnFaoqoQR/zWWzH
 3C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iSMAJyQnojOCbl+pS+23apnKqQXokc1A+gnWCgPYgpA=;
 b=ctU+tsSTR7L7q15uPhA0c6ab3lmPCgxWRZRKhaZKyWKQjT7/eppbUXWCPVzvoMvsg5
 0rddJM1Y686r07sNkj9LEjj/eRP5maQxSJbN6nV4o/SJhtQbdDPJyeS0mDXXdfwELZXn
 UOxEasXOAQNfph88cntE7sTEXHcyRm0T32+dQTitroI8YfRel5dEhgrFxeYTDuoT0d9h
 G36VptrsI5W5gW3iNbGzp4tnu9umzEgndzpwe/LoL6EaabgiKOz1z7rSF7hh+Hlle73y
 Dgnl3WO+w0RSte/DyM/heZaLkn9rvbBAmRMQeedo/98dP4G1IuDgaY+Mgi9sZk30KodV
 gjYA==
X-Gm-Message-State: AOAM53364VpBnPyV/L3JYf1rwjzHwFVq2PFv4oV3UtxqSx1CqyD3P8yB
 TXfbThUnNRffwoGdE0YREAb4y8pqMLWKfKTQkh+y9Q==
X-Google-Smtp-Source: ABdhPJzSO0+KuiAfUJkCrZwZcCAvTlxo/3ZH0rabTShxMso9g65XLtY8e03DD9JIhoWPPy31pCAoaE5b6rWciJPypA8=
X-Received: by 2002:a02:234c:: with SMTP id u73mr19212114jau.141.1599477554164; 
 Mon, 07 Sep 2020 04:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
 <20200904160709.123970-5-bas@basnieuwenhuizen.nl>
 <290218db-ffbe-0ae7-5a35-33e95d0581c8@amd.com>
In-Reply-To: <290218db-ffbe-0ae7-5a35-33e95d0581c8@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 7 Sep 2020 13:19:05 +0200
Message-ID: <CAP+8YyGyym25=SnbpT_h3dMDjUxNuJi2qGwdvejuTkaY_4HipA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] drm/fourcc: Add AMD DRM modifiers.
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Stone <daniel@fooishbar.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, fixed both locally.

On Mon, Sep 7, 2020 at 10:44 AM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Hi Bas,
>
> 2 small typos you may want to fix:
>
> On 04/09/2020 18:07, Bas Nieuwenhuizen wrote:
> > This adds modifiers for GFX9+ AMD GPUs.
> >
> > As the modifiers need a lot of parameters I split things out in
> > getters and setters.
> >   - Advantage: simplifies the code a lot
> >   - Disadvantage: Makes it harder to check that you're setting all
> >                   the required fields.
> >
> > The tiling modes seem to change every generatio, but the structure
>
> "generatio" -> "generation"
>
> > of what each tiling mode is good for stays really similar. As such
> > the core of the modifier is
> >  - the tiling mode
> >  - a version. Not explicitly a GPU generation, but splitting out
> >    a new set of tiling equations.
>
> [...]
> > + * with DCC & DCC_RETILE:
> > + *   - main surface in plane 0
> > + *   - displayable DCC surface in plane 1 (not RB-aligned & not pipe-aligned)
> > + *   - pipe-aligned DCC surface in plane 2 (RB-aligned & pipe-aligned)
> > + *
> > + * For multi-plane formats the above surfaces get merged into one plane for
> > + * each for format plane, based on the required alignment only.
>
> "for each for format plane" => "for each format plane"?
>
>
> Pierre-Eric
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
