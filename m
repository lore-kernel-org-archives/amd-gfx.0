Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B19FC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 07:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6696510E496;
	Wed,  2 Sep 2026 07:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pjuT5mRy";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628E610E496
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 07:32:27 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c2530cabcf4so103254266b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788334346; x=1788939146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntYqCiUGvFKb34I7pd2sH6Ev2OxM+HRkEJ74Nxn2uc0=;
 b=pjuT5mRyVblcfyDCGoefaQ6sAS33OQl8wyElTftywWSVwjAyBVIOijRug+mcFp0TvB
 sfRCIvRXxIt5GRekD1ZWtWnoY9kab/8z+e5cYWHIMVA55/aPiqX5XtUT4nq51sqBqwKl
 /aJKe3yHqphq4bWNh/zDLueoCD4ANTQoYJbJb2a0fvxwhIPEO/4/auoqbNFTtWFf6A46
 VGTxW13iEi8HjgwEFe7v+R0MktK+s6VDkfYwB5Iwghu+JoCi1M0QtryGGk3q0A8hlZLx
 dxk4cRibn7qgmdJaN688/EID9DuaeCgSnGsvDAMPWx+ADcvBlFZBjmniwYNv4JZcWuTQ
 vfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788334346; x=1788939146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntYqCiUGvFKb34I7pd2sH6Ev2OxM+HRkEJ74Nxn2uc0=;
 b=YBb4Yy2/hyKU3B9IV2uhWZp7PnWFQ60wnlrLuX/kyxLkQaA6QCtV46N6nQHGO+3ZE1
 lFp30ommyY6J2VpC9K3D3OFSyETf6fEbUZhXNSI0E8y+3k0fyIFB5tkxl7ZxONJ8z7pR
 uPpScpyZOq+lLtRaj43xsPIZVAGCQy7pXpEeXUEA407pDvb5lh5WOh6mwJIYyp/Tly++
 viqhAo0z2TESe3r+X27R7ODHNdlrm593nWkDGALf27iXcMNggmlqkS9+SL0no8uh/HdK
 qpCatlebZrlQOZBkfp7tbz9Ryvns/zIbBirtw6GP7mIfKSKdbQxWIzGFz4XrE/0ZFDky
 9OAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6o2EsGwuYdmEZrqP7npMf+eT14tKbA1XjwFO8fqTqpKeFVyfbl5iDKxd7dwcLqT6UJ/rkEhpP@lists.freedesktop.org
X-Gm-Message-State: AFuF++khr2oNXMifs6xX31qBxtxTsLfzUSkQZSvzO6gZYsEPsWPMhzrh
 k4362N+uff9YaBfQ1BTXRIfjyYTr/V6QfEotm18Yjl4YSNGWkni8TtBu
X-Gm-Gg: AYBFou1eQdJ3wTUrBd2f8kLt56qPRu4qOv+IV21Q58nYd6RXTX1OTvsWlQkpjOB5Ubp
 HG1nJ6whhTwsXKGNe08ptT7vySJNNS2uXm8D6F5n7v3c/oeagQbItNewYB3vb2UjgMB9DrP8u2l
 QnQPos9yYMJcmvByEyTAKq73nMhfrleMN7/4OkLHf7xmp3fEGxUj4uqeF/UzayMP+KMpO2eB60A
 BClPRvEUZofaC63mANhGMCodWbu5IpzO7seEsmn+9Ze77CMMAmH8G43etA9qT+cwVcI665KwU+j
 mPpcS55JKtTsauElS7chRwv0p5AGyKnWpbv9wBZJ7a/3ikWxu3Fnhz7X+Gmgx/UO0rSVw6TFQne
 emDHGFp1VthqRD8AXXpe0OjWa6BKv4ydcyPwACLAaGYWh3tChhZECH0CHdttYEGRThOwGYU4CTd
 X8s7O1XTpjBtWBQE++JPW62DuDd2T9HJJCdkOUQRwcq8rwbNHGj2kRwRn3oZO58PqIfJWvzP0Eo
 GwbaYZEIku9gMqkJeCa243JQkR/OmHihxFAkIwODXlXWmGM8LfF6AXse9Cr
X-Received: by 2002:a17:906:6a03:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25d5474dfdmr140879566b.12.1788334345387; 
 Wed, 02 Sep 2026 00:32:25 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d041d286sm78078466b.55.2026.09.02.00.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 00:32:24 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Wed,  2 Sep 2026 12:32:22 +0500
Message-ID: <20260902073222.206801-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829010525.29935-1-mikhail.v.gavrilov@gmail.com>
References: <20260829010525.29935-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I have to correct my own report.

The 90x figure I gave for a637a140ab86 does not hold up.  Since sending it
I have measured five more sessions, and the rate turns out to be controlled
by something other than the kernel.  Please do not spend time on the commit
on the strength of that number.

What the artefact actually does is sit in one of two states, and the state
changes during a session.  All figures are events per 1000 eligible frames,
where an eligible frame is one the detector could have judged - the method
is unchanged from my first mail.

  60 Hz                       0.0000   0.0045   0.0252
  120 Hz, quiet state         0.0308   0.0372   0.0400
  120 Hz, excited state       0.5208   0.5739   0.7115   1.3027   1.9153

The three groups are about a decade apart from each other, and the kernel
does not sort them.  0.0308 is the run on the kernel with a637a140ab86
reverted; 0.0372 and 0.0400 are runs on unreverted kernels in the quiet
state.  Those three are the same measurement.  My original pair simply
caught one kernel quiet and the other excited.

Worse, every kernel comparison I made began with a reboot, and a reboot
resets the state.  So the bisect was measuring how soon after boot I
happened to load the machine.  I no longer consider the attribution to
a637a140ab86 supported, and I cannot say from my data whether this is a
7.3 regression at all.


The two transitions
-------------------

I can now move the artefact in both directions, but only as bundles of
variables - I have not separated what inside each bundle does the work.

Excited by: a long session of a heavy 3D game (Dying Light: The Beast).
Measured twice on the same kernel and refresh rate: 0.0372 -> 1.3027 (35x)
and 0.0400 -> 0.5208 (13x).  The effect outlasts the game by hours and
decays gradually.  That bundle contains sustained shader load, large VRAM
allocation and eviction, GTT traffic, clock and power-state churn, heating,
and fullscreen presentation.

Calmed by: about three hours spent at 60 Hz, after which returning to
120 Hz gave 1.9153 -> 0.0400 (48x), on an unreverted kernel.  That bundle
contains two modesets, three hours of elapsed time, half the pixel clock,
a different pixel encoding (this display uses YCbCr 4:2:0 at 120 Hz and
4:4:4 at 60 Hz), different watermarks, and an idle GPU.

Also calmed by: a reboot.

Which single variable in each bundle matters, I do not know.  A short
120 -> 60 -> 120 toggle would separate "a modeset" from "time at 60 Hz",
and a compute-only load would separate "GPU busy" from "memory pressure".
I am happy to run whichever of those would be most useful.


What did survive
----------------

The dependency on frame rate is unchanged and now rests on four
independent sessions: 120 Hz and 100 Hz show the artefact, 60 Hz is at
least an order of magnitude below the quiet 120 Hz state.  Forcing YCbCr
4:2:0 at 60 Hz, so that the encoding matches 120 Hz, gave 0 events in
1,290,588 eligible frames, so this is frame rate and not chroma
subsampling or link bandwidth.

Swapping the HDMI cable made no difference.

And one negative result that may be the most useful thing in this mail:
DTN snapshots taken seconds after real events in the excited state are
byte-identical to snapshots taken in the quiet state - 195 lines against
195, differing only in the scanout buffer address.  Watermarks, dcfclk,
dispclk, dppclk, fclk, HUBP and OTG underflow, vtotal and the DRR select
bits, DSC, RQ, DLG and TTU are all the same in both states, at a fifty-fold
difference in artefact rate.

So whatever holds this state is not in anything DTN exposes.  Is there
something in DMCUB, in the memory path, or in link state that could persist
across a game, decay over hours, be cleared by a reboot, and leave every
register in the DTN dump identical?  That is the question I am stuck on.

Thorsten: the regzbot entry points at a637a140ab86 on the strength of the
bisect above, which I no longer trust.  I do not know yet whether there is
a regression here at all, so I would rather not close it as invalid; please
handle it however is appropriate for an entry whose attribution has fallen
apart.

The GitLab issue has been updated with the same correction:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714

Sorry for the noise on the first pass.

-- 
Thanks,
Mikhail Gavrilov
