Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F6FA373E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 13:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC95410E64E;
	Mon, 24 Oct 2022 13:17:23 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F0E10E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 11:28:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6A6AAB81120;
 Mon, 24 Oct 2022 11:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AEEC433D7;
 Mon, 24 Oct 2022 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1666610905;
 bh=QP5uiwyreZ3nbpw9j/imqXRU4ENvsxOn9lrU9ONBWas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a8pkIK6RPTfnWXqxA/j2B711IxDKV83BvK3kgWZPGYnNJLuU0SNyFgbyEImzzN7MB
 nlkRcE70aMhFTKblyf8d5lxBxWAcUmB4i1M8jgjv7YGa7l7L3FjFgT7Fwj/V3a/2Lf
 LgNMbozfKiRTf0WNQDGpBBY+jCU1H31zPEdJhFEM=
Date: Mon, 24 Oct 2022 13:28:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: amdgpu: update from 5.10.145 to 5.10.146...149 breaks boot
 on Ryzen based computers
Message-ID: <Y1Z21g4C8xx2PTtB@kroah.com>
References: <CAAfT2tdZN5s4WEG1q=VCOK7_1vgb6B8VuL+Jw3UqADMxerRMDA@mail.gmail.com>
 <CAHk-=wghzRGZtwCU+tDSRGD2HC_7dMT6rnU-urD91gz_AkyCTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghzRGZtwCU+tDSRGD2HC_7dMT6rnU-urD91gz_AkyCTg@mail.gmail.com>
X-Mailman-Approved-At: Mon, 24 Oct 2022 13:17:20 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Oct 23, 2022 at 10:23:53AM -0700, Linus Torvalds wrote:
> This was sent to me, but should have gone to other people.
> 
> It may already be fixed, but note how the report is about -stable
> kernels, including apparently the current 5.10 stable version (149(.
> 
>               Linus
> 
> ---------- Forwarded message ---------
> From: Kevin Torkelson <kevin.torkelson@gmail.com>
> Date: Thu, Oct 20, 2022 at 8:09 AM
> Subject: amdgpu: update from 5.10.145 to 5.10.146...149 breaks boot on
> Ryzen based computers
> To: <torvalds@linux-foundation.org>
> 
> 
> Linus,
> 
> --- Possibly Important ---
> I know several people who are crashing with Debian Bullseye (stable)
> with the most current kernel put out by the distribution. AMD put out
> a fix that seems like it might be related here:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2216

We have fixes queued up for this in the stable tree for 5.10 already,
thanks.

greg k-h
