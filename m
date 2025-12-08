Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3910D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 13:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9C510E033;
	Tue,  9 Dec 2025 13:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="LmAg4eCC";
	dkim-atps=neutral
X-Greylist: delayed 1224 seconds by postgrey-1.36 at gabe;
 Mon, 08 Dec 2025 14:46:46 UTC
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E1410E139
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=RsK+IJCNumVJ5861ZIVsf9EH4J2y+xty7CYVakdSvMc=; t=1765205206;
 x=1765637206; b=LmAg4eCCFKfaglNcWg6cqGKWH6li/S1z8iVt3gqxi0ncgw8U4mli6D3pD1h1e
 HJhabT9ZbUhkTXNpdXofQcdiKmsGN/mPmq2mybTokEdisBSjF04Pf22+0Kh9ibjyW3nVtlBZ5PKo1
 IKCb0HPh/EL3SKP5TbKvGwgdMwmDjDj6LTIkaX8NUDhg2KGiEQ4t4/K0efh3RtIHh/i5F3zq7CyNx
 gb3ykpQS+8oDcsKTDGlznp7YL24yQR4LlFwCLfJ6Qg+9oR/iQRGInsBx/QbLumK6xZRAN7+CBMHdv
 vKlrNtBazkSSJQFGbml73t7RdSpom1jKDaYu2Flol9P2vfzCxg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 id 1vScBw-004T4W-2a; Mon, 08 Dec 2025 15:26:20 +0100
Message-ID: <f08fc7da-0d2d-4d7d-a1dc-8ed90493dac8@leemhuis.info>
Date: Mon, 8 Dec 2025 15:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Display signal loss (blink) on input at >100Hz since
 v6.1 with AMD Graphics Card
To: Yash Anand <yashanands112@gmail.com>
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
References: <CAKpMnw3=GYLxggX1cJMG99XbfxNg4vC5Qb+-VNzEhgFAxEoYRA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAKpMnw3=GYLxggX1cJMG99XbfxNg4vC5Qb+-VNzEhgFAxEoYRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1765205206;
 519f31cd; 
X-HE-SMSGID: 1vScBw-004T4W-2a
X-Mailman-Approved-At: Tue, 09 Dec 2025 13:14:36 +0000
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

Hi!

On 11/27/25 08:43, Yash Anand wrote:
> Hi, I'm Yash. I would like to report a regression I'm facing with my AMD
> graphics card (RX 6500XT) and its driver amdgpu. This is happening to me
> in ALL the kernel versions above 6.1, i.e, linux 6.1 is the last kernel
> tested by me in which I'm not facing this issue.

Thx for the report.

The problem is quite old and maybe nobody will take a closer look,
unless you find the change that broke things using a bisection – and
even then there is no guarantee that it will be fixed due to how long it
exists already.

Developers of the driver in question also expect bugs to be reported to
https://gitlab.freedesktop.org/drm/amd/-/issues , which might be why
nobody replied here yet.

So it's likely best if you report the problem there and ask for advice
first before investing time in a bisection.

Ciao, Thorsten


> The Issue:- Whenever the refresh rate is set above 100hz (the max
> refresh rate my monitor supports is 120hz), the screen /flickers/, or /
> blinks,/ i.e, it turns off for around 2s and turns back on whenever I
> click on things like- new tab button in firefox, type things in the
> terminal, press the super key, change the theme from appearance, etc. 
> 
> The system is responsive, but the display /flickers/ or /blinks /while
> doing normal tasks in my system. This doesn't happen at 100hz, or lower,
> like 60hz etc.
> 
> System Specifications:
> GPU: Powercolor AMD Radeon RX 6500XT 8gb
> CPU: Intel i3-9100f
> Monitor: Acer EK240Y G0 23.8 Inch IPS Full HD. I am using it at 1080p at
> 120hz. Connected through HDMI
> Distro: Manjaro with XFCE. Also tested with fedora, linux mint, and some
> more.
> 
> Last Working Kernel Version by my testing: Linux 6.1.153-1 LTS
> First Bad Kernel Version by my testing: Linux 6.6.107-1 LTS
> Also facing issues on the latest Linux 6.17.1-0
> 
> Please let me know if you need any specific logs and also the command to
> fetch it (I'm a beginner in terminal and its commands)
> 
> Thanks, 
> 
> Yash.
> #regzbot ^introduced: v6.1..v6.6
> 
> 

