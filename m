Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA1BC35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A5310E15B;
	Mon, 18 Dec 2023 18:25:01 +0000 (UTC)
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF4E10E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:24:59 +0000 (UTC)
Received: from tux.applied-asynchrony.com (p5ddd7509.dip0.t-ipconnect.de
 [93.221.117.9])
 by mail.itouring.de (Postfix) with ESMTPSA id 0ABA2129AA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 13:39:49 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
 by tux.applied-asynchrony.com (Postfix) with ESMTP id BA997F01600
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 13:39:48 +0100 (CET)
Subject: Re: Regression in 6.6: trying to set DPMS mode kills radeon (r600)
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To: amd-gfx@lists.freedesktop.org
References: <c31dc9e8-b969-c736-709c-382c032f4979@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <a67cb2d1-f02b-9998-01c5-e0e18729da82@applied-asynchrony.com>
Date: Mon, 18 Dec 2023 13:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <c31dc9e8-b969-c736-709c-382c032f4979@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 2023-12-16 18:36, Holger Hoffstätte wrote:

<snip>
> The affected machine is an older SandyBridge dektop with a fanless
> r600 Redwood GPU, using the radeon driver. "Recently" - some time
> after the last few 6.6.x stable updates - it started to die with GPU
> lockups. I first blamed this on standby/resume - because why not? - but
> this turned out to be wrong; the real culprit is DPMS.
> 
> I use xfce-power-manager as "screensaver" to turn off the display after
> inacitvity. This can be configured in two ways: "suspend" and "poweroff".
> I've been using "poweroff" since forever without problems, until now.
> 
> The symptom is that everything works fine until the screensaver kicks in
> and tries to turn the monitor off, which sends the radeon driver and the GPU
> into a complete tailspin.

<snip>

> Eventually the screensaver tries to switch off the monitor via DPMS "poweroff" method and
> this greatly upsets the GPU:
> 
> Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: ring 0 stalled for more than 10140msec
> Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: GPU lockup (current fence id 0x0000000000000002 last fence id 0x0000000000000003 on ring 0)

In the meantime I have confirmed that all this is still more complicated:
even using the "suspend" method only works after boot, not after a system suspend
cycle. Yes, weird but reproducible.

I have tried to chase down the problematic release, and as suspected this
started to happen with 6.6.5; 6.6.4 is fine.

Based on this information I found the offending commits and reverted them
in order from 6.6.7, which fixes everything for me:

b0399e22ada0 "drm/amd/display: Remove power sequencing check"
45f98fccb1f6 "drm/amd/display: Refactor edp power control"

Suggestions on how to proceed would be appreciated. I can report this
to  -stable and request reverts, but wanted to check with the list first.

Thanks,
Holger
