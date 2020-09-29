Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C494FC4741F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA73207F7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA73207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19215899B3;
	Tue, 29 Sep 2020 07:33:54 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEAA89C89
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:14:07 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 97E74AC4D;
 Tue, 29 Sep 2020 06:14:05 +0000 (UTC)
Date: Tue, 29 Sep 2020 08:14:04 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Regression in amdgpu driver / kernel v5.8.6
Message-ID: <20200929081404.4d8df525@endymion>
In-Reply-To: <CADnq5_OBSxK=Ds7X-e8xfHUDb0js7vtWbz-y7mabpFg0BhB5kw@mail.gmail.com>
References: <20200928111037.51ed4aeb@endymion>
 <CADnq5_OBSxK=Ds7X-e8xfHUDb0js7vtWbz-y7mabpFg0BhB5kw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Sep 2020 07:33:52 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Mon, 28 Sep 2020 17:44:28 -0400, Alex Deucher wrote:
> On Mon, Sep 28, 2020 at 9:23 AM Jean Delvare <jdelvare@suse.de> wrote:
> > I have recently experienced a regression in stable kernel series 5.8.
> > The problem is that my display will randomly turn to black after just a
> > few seconds of inactivity. I have to switch to text console then back
> > to X to recover.
> >
> > I bisected it down to:
> >
> > commit b86657e328b601a5b98f8c4c21d108d356dbceee
> > Author: Navid Emamdoost <navid.emamdoost@gmail.com>
> > Date:   Sun Jun 14 02:09:44 2020 -0500
> >
> >     drm/amdgpu: fix ref count leak in amdgpu_display_crtc_set_config
> >
> >     [ Upstream commit e008fa6fb41544b63973a529b704ef342f47cc65 ]
> >
> > Reverting this commit on top of 5.8.10 makes the problem go away. My
> > hardware setup:
> >
> > 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon RX 550 640SP / RX 560/560X] [1002:67ff] (rev ff)
> > 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP Audio [Radeon RX 550 640SP / RX 560/560X] [1002:aae0]
> >
> > This is a Sapphire Pulse Radeon RX550 card, with two Lenovo P27h-10
> > displays connected (one over DP, one over HDMI). I'm using option dc=0
> > otherwise the multi-screen setup doesn't work.
> >
> > Looking at the patch, and at the logic of function
> > amdgpu_display_crtc_set_config() in general, I suspect that the middle
> > chunk of the patch is incorrect. Calling pm_runtime_put_autosuspend()
> > if pm_runtime_get_sync() failed is, albeit surprising, correct due to
> > how that function is implemented. Calling it right after
> > "adev->have_disp_power_ref = true" however looks wrong. The comment
> > right before that line pretty much implies that we *want* to keep the
> > reference.
> >
> > So I think we want to apply a partial revert like the following:  
> 
> Nice analysis.  I've applied the patch.

Unfortunately, further testing shows that this partial revert is
insufficient to fully fix the problem. Only a complete revert works.
This worries me a little though, because my analysis seemed correct. If
the first chunk needs to be reverted too, it means that this code path
is taken on a regular basis in my case. I would expect
pm_runtime_get_sync() failures to be an error path that should normally
not be taken?

At this point I am wondering if maybe we had 2 opposite reference
counting bugs covering for each other, and fixing one revealed the
other. Or maybe the prime issue is that pm_runtime_get_sync() shouldn't
fail in the first place, and that's what we need to fix.

I'm not familiar enough with the amdgpu driver to efficiently continue
debugging this issue on my own, so I'll do what I can, but some
guidance would be welcome.

-- 
Jean Delvare
SUSE L3 Support
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
