Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C6EDF15A
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Feb 2026 14:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E988A10E023;
	Sat, 14 Feb 2026 14:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=taiker.tw header.i=@taiker.tw header.b="S74lepr+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYFskcuY";
	dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at gabe;
 Sat, 14 Feb 2026 06:31:39 UTC
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7ED210E07F
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Feb 2026 06:31:39 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 18F301D000C0;
 Sat, 14 Feb 2026 01:26:06 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
 by phl-compute-06.internal (MEProxy); Sat, 14 Feb 2026 01:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=taiker.tw; h=cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1771050365;
 x=1771136765; bh=AnKLOq2A1HgB3E3epreKfkT+aBknjm7zcITanDgQDeE=; b=
 S74lepr+kCn8fApO4UQezHhYyUFryU1tqbkjMph65jLm+lt1okaFw4wBewlb1tJn
 m21dM1p3aSPjP7Ta+qkQ0mAz5H7jgqCaxVe980NIChmewJE1VZIy+pq/5n2nKNAi
 hIQzfulK1yJFVefSd75XDvOmzlVRDkmWryhPrgFdFcS95sqohyl33PGlDnSxKCJh
 r9423Mi0MSBl3hV1EKSnCl9J7OAiFkv00Wp0sYcvdje0YMd7dWNNMgx59Xsy2kKp
 dv41TuHw2rjM6UsxrPB/Q0ESdv2AultFjEjfyP9jRiv6nLQAJeFk8arTu9VrSl93
 s9kIGCFHG84qJSvN9BQ+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1771050365; x=1771136765; bh=A
 nKLOq2A1HgB3E3epreKfkT+aBknjm7zcITanDgQDeE=; b=uYFskcuYxJRyFDu+p
 MjEWHyrCSp9c9+Gy+lz123fW1pYtu1jln2xrKwr9mgnFcbztSTO+vuP1F+lQelAu
 kz8W4F3x9FmWXtEoxxqZJkGBLd/1qoF7JqrCsOg8O8g3yIIDKI7BkhNU9bvV/GDv
 HpDAEvZihmxUEvAbAOAHrqpC7rYUdP7QgpPaJvTJo8gRdEhl6qBsG6ylkv1iH0MB
 bl6hKcFZ2RXMuadmkzFB4XQ+xvIkdVmn86uOdOHYtkQBUgHYVTzsTtGVBdH10MAx
 L9Ry57PYeyIFASiryb3NAur7VSLaorwU1oJZ5zsCzpxWUcLR+yW9AB85ESdFaC+D
 1X1+w==
X-ME-Sender: <xms:fRWQaehhLS6QphSclAZ0OylNTsw4tx8dXY4hSSqn0mZntNYesJ3DAA>
 <xme:fRWQaZ3zt7wRRVdrVAnFDNcwnjbNTyHqmSlOZtHSCxfItEC8A-4vdFNovOVxVLcGq
 c2SSN7HOdizuMX4djurb-74h6CsGAIDbtRKPuEB65wW32txA0_NfWTz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddtgeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
 ertddtnecuhfhrohhmpedfvehhihgvnhcuvedrhgdrfdcuoehiugholhgvrghtsehtrghi
 khgvrhdrthifqeenucggtffrrghtthgvrhhnpeehudeifeehkedvjeffuddtudeigeehgf
 euteeuueetuddvkeelgfeuieeuueeiueenucffohhmrghinhepfhhrvggvuggvshhkthho
 phdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehiugholhgvrghtsehtrghikhgvrhdrthifpdhnsggprhgtphhtthhopedvpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvg
 guvghskhhtohhprdhorhhgpdhrtghpthhtohepughonhhosggrnhesrhhishgvuhhprdhn
 vght
X-ME-Proxy: <xmx:fRWQaRMTtGxpFyx2l1nsSk81oEyrkSqxL4hsUiRiNRdmT3cTcwf2XQ>
 <xmx:fRWQaR56LUmFLgUty3CgVfmVI0lkMqLboWb3XzkP8zTfYSX5juJVNg>
 <xmx:fRWQaX1wgoVPyW1bAvd7uLekfUS7hpmj1LW1Vp0aFxxFstZDVM-V_g>
 <xmx:fRWQaaYebsAUIodAq7J2N44MohT5Mi5YGp7QhNmTbkPEMOkJvajPAA>
 <xmx:fRWQafZBHdq7fJE_yyn2uFbcOrVPNB1-i9dqYggTPzApvVZDmGlNQmws>
Feedback-ID: i43e14637:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E3FB218C0067; Sat, 14 Feb 2026 01:26:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AcFLrndxv6o-
Date: Sat, 14 Feb 2026 14:25:44 +0800
From: "Chien C.W." <idoleat@taiker.tw>
To: donoban <donoban@riseup.net>, amd-gfx@lists.freedesktop.org
Message-Id: <6b91f8a5-9455-4eb7-98ed-a0f5d64fe05c@app.fastmail.com>
In-Reply-To: <aYHIsX28jR1TNTAs@b1c030cc0be7>
References: <aYHIsX28jR1TNTAs@b1c030cc0be7>
Subject: Re: amdgpu GTT memory leak
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Feb 2026 14:56:27 +0000
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

On Tue, Feb 3, 2026, at 6:47 PM, donoban wrote:
> Hi,
>
> I have an AMD Radeon 780M Graphics running AlpineLinux on a Thinkpad 
> T14 G3 and I noticed a memory leak related to GTT and amdgpu. In few
> days is easy to reach gb's of GTT usage while any process reporting
> tool shows no extreme memory usage of any process.
>
> Looking at 'dmesg' I see many messages like:
>
> amdgpu: VM memory stats for proc alacritty(32519) task 
> alacritty:cs0(32514) is non-zero when fini
<thread name>:cs0 is a thread in mesa doing command submission. Did you
still observe same issue when using latest mesa?
Also, I think it's better to move issue triaging to freedesktop gitlab:
https://gitlab.freedesktop.org/drm/amd/-/issues
for more eye balls and better tracking.

>
> So I ended reaching this mail list. Could you help me to debug this and
> maybe found some fix or workaround?
>
> Regards!

Thanks,
idoleat

