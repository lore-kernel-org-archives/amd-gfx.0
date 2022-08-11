Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5045BC19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 07:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E8FA79CC;
	Thu, 11 Aug 2022 07:30:33 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2F7A68E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 07:19:36 +0000 (UTC)
Received: by mail-vs1-xe29.google.com with SMTP id o123so17472791vsc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=c/MVcLOcSgyFUkgmMizWq4d9JL417TeooBL0/ACfehA=;
 b=K3ZJ5qqxKtBjIeSYucSMO1XSSK/N/mOAH4IqlHnldaN6iqkwMdbibZC3lA+srSxtmt
 qqzluMn5uWgaedLgSZYBYmvP6UhW1Nv5WbnyqBt6b3xCvp8hI8OFHRaDgv7jmo6TlgA2
 r3EFq9bDDz1biLnIM7oiC4ixLHgy7+limLEuJZx6NKH5a5Qb48hbHqnnOgMdfKT9lc+X
 AmOFkYJXyp6YmhRObfyLQkQDghE8NmvLrNXkFwwZC/khKGkk2UDXTbjQQQI/O1Szr5Zu
 YJKS6BOsHpuA9+huhNhTJlw9EampS1OEDLmFgVKtXFo51kqrJRboy04sbwm+A/Zh3PQ1
 ZyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=c/MVcLOcSgyFUkgmMizWq4d9JL417TeooBL0/ACfehA=;
 b=p9MPetAA7HrzbT7tay/pRp+Sg1Z8RQRbjHsK7PMUdQmceuTjnIk7pPKVR1zpnHVQxT
 qfX3zKYuZoeDrM7nogUcB8LypmRA6nwP6XbFJLxG9MKGzwKi41po0qnT2HFfzgovobTE
 mqrIQCGdUtXYLbm/r7/3sVoizSpfYWAuLVxpcQ93muPuTpvvF7ydWUPqL//qT/qaDxon
 Thx7fLO7W/ecJ7DL8eVH3k7b1RvAj2u2TDaUTPbsGALZRvy2rX8GJiyzIVQts2EWQAYZ
 LSqCVqycceC8BCl1CzaNLDpV7tUxqj3bzYcLcWfsrSAQMEapIPB7qE1BowM/9lP6vuJT
 jKlg==
X-Gm-Message-State: ACgBeo14tRrdnFmrcWKSTaw8itMz0qCxVUjU4KgMdHbnBzTtkXEFYEQb
 Hu9vqit3u0KE7EqB/2NRTFtSADX2tH6Rd/0rjE3R7w==
X-Google-Smtp-Source: AA6agR6FwRdcbC2k/EXHBRwNRFbz0Cke6MeOnjFJtHxTq9ExOZFibOHUXVmAxFae9zSCUKXgQOBdY9GA1cXF8tLoj8A=
X-Received: by 2002:a67:c198:0:b0:383:b020:f7c4 with SMTP id
 h24-20020a67c198000000b00383b020f7c4mr13878512vsj.71.1660202375046; Thu, 11
 Aug 2022 00:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-2-tales.aparecida@gmail.com>
 <CAGS_qxryOVG_ZvV1+i_egPZO8Ngq4EoFRK=Q_J9S8urj3kPyxA@mail.gmail.com>
In-Reply-To: <CAGS_qxryOVG_ZvV1+i_egPZO8Ngq4EoFRK=Q_J9S8urj3kPyxA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Aug 2022 15:19:23 +0800
Message-ID: <CABVgOSm0Sakf8wnwCt8xB09+U3rzgxYPToOWkJK4ssfc-AkX2A@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amd/display: Introduce KUnit tests for fixed31_32
 library
To: Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 11 Aug 2022 07:30:06 +0000
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
Cc: siqueirajordao@riseup.net, David Airlie <airlied@linux.ie>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Jonathan Corbet <corbet@lwn.net>, magalilemes00@gmail.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 KUnit Development <kunit-dev@googlegroups.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Trevor Woerner <twoerner@gmail.com>,
 Tales Aparecida <tales.aparecida@gmail.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 11:05 AM 'Daniel Latypov' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Wed, Aug 10, 2022 at 5:40 PM Tales Aparecida
> <tales.aparecida@gmail.com> wrote:
> >
> > The fixed31_32 library performs a lot of the mathematical operations
> > involving fixed-point arithmetic and the conversion of integers to
> > fixed-point representation.
> >
> > This unit tests intend to assure the proper functioning of the basic
> > mathematical operations of fixed-point arithmetic, such as
> > multiplication, conversion from fractional to fixed-point number,
> > and more. Use kunit_tool to run:
> >
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
> >         --kunitconfig=drivers/gpu/drm/amd/display/tests/
>
> Nice, thanks for including a kunitconfig, that'll help a lot.
>
> Just as an FYI: if you're working on top of torvalds/master, I think
> you would no longer need --arch=x86_64.
> Before, CONFIG_PCI=y was tricky to enable on UML, but commit
> 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> landed for 6.0.
>
> I.e. I can run this command on torvalds/master w/ no other patches applied:
>
> $ ./tools/testing/kunit/kunit.py config --kunitconfig=/dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_PCI=y
> CONFIG_DRM=y
> CONFIG_DRM_AMDGPU=y
> CONFIG_DRM_AMD_DC=y
> EOF
>
> I haven't tried to apply this series locally yet to double-check, but
> I'm pretty sure that means these tests should work as well.
> Running under UML would hopefully have faster compile times and be
> less resource heavy than a QEMU VM (but I've not measured to verify
> that).
>


There are still a few issues which prevent these tests from working on
UML I haven't had a chance to go through all of them yet, but I'll
drop a couple of quick responses to some of the individual patches.

The first thing to note is that amdgpu doesn't actually build on UML
at all without:
https://patchwork.kernel.org/project/linux-rdma/patch/20220218075727.2737623-3-davidgow@google.com/

IIRC, no-one liked spreading !defined(CONFIG_UML) everwhere. Replacing
it with IS_ENABLED(CONFIG_X86) also works, as X86_64 is defined on
UML, but X86 isn't.

The other issues are basically just other missing #ifdef checks or
dependencies. Plus there's a warning on my system even under x86_64
for integer overflow in the MIN_I64 definition.

Cheers,
-- David
