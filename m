Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB49C5321E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 00:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAC510E002;
	Mon, 26 Aug 2024 00:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Burin7BC";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFC810E002
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 00:19:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 18036A4008E;
 Mon, 26 Aug 2024 00:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA4DC4FEEA;
 Mon, 26 Aug 2024 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724631570;
 bh=vzCGGJ+RQlJV4njwEvLDI1mTm/Xfs2qXZZgX3qm6ddk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Burin7BCzCvVTGgpnagNj9L/BKOeueTkDtyvHxSc5l2Efk3iuGYS8oKAlV0nTBVQ2
 /6FWzlVbi/GmtSF7MbdSm/8MQmcZlPtU8AqGFshH1VfcVTtPc9CltAWNA4f5DCMuKM
 c0rPzvLCnXCOO5Mt0h1fOTMLrCzP5+ok2rwFVpIMaKPyPsNaAqXGnPXs7iooDRj/Jl
 lYs44H9KzyXi3RN09v28usZgtzMMuwTl09BZME0r/KmglyPC5MbzQ2tXJRy26VsSFD
 iALcMHIQ3H7tASoQeGFLvIz7LxV+GOCwjA8i3ipojpUnAhyjcA0ZuuMS8SpaCMedmw
 Rdn47sg4pKY6w==
Message-ID: <26c4982a-c735-4a6e-829c-7d1a057aa4fe@kernel.org>
Date: Sun, 25 Aug 2024 19:19:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Luna Nova <ml-fd-amd-gfx-devel@nyx.nova.fail>,
 amd-gfx@lists.freedesktop.org
Cc: Luke Jones <luke@ljones.dev>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
 <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
 <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
 <9efbc3a1-c43b-4f8a-a334-6ff77e6de283@amd.com>
 <da2860c4-df08-49d8-b730-68691520f7ec@app.fastmail.com>
 <de5eeddc-df9f-4c0d-aa11-8ad077bd8adb@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <de5eeddc-df9f-4c0d-aa11-8ad077bd8adb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/25/24 15:40, Luna Nova wrote:
> Raised this as an issue a while back on the bug tracker and it got closed as WONTFIX. https://gitlab.freedesktop.org/drm/amd/-/issues/2229
> Been running a patched kernel with a similar patch locally ever since because even figuring out everything on the system that's accidentally waking the GPU was too time consuming.
> 
> I'd love if this gets accepted.
> I think fundamentally waking the device to ask how much power it is using thus increasing the power usage makes no sense - by trying to measure it we changed it, so if power can't be measured while off it only makes sense to return an error. Same applies for other sensors that currently wake the GPU - most of them are changing the property by waking it.
> 
> Because this behavior is odd and it's not obvious on single GPU systems that anything's going wrong app and lib devs are likely to keep making this "mistake" forever.
> 
> Luna

So FWIW I did file a v2 [1] that "undoes" the debugfs changes.

[1] 
https://lore.kernel.org/amd-gfx/20240823145527.150749-1-mario.limonciello@amd.com/

If there is too much push back to an error code another option we can do 
is return "0" for this case, which will make "sense" for some sysfs 
files specifically if in d3cold.  However for d3hot and some sysfs it 
isn't fully true.
