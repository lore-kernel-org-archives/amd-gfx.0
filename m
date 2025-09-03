Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F84CA1007
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 03:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B49810E85F;
	Wed,  3 Sep 2025 03:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TlooqVyC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9963D10E85F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 03:35:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 40EF444114;
 Wed,  3 Sep 2025 03:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB532C4CEF0;
 Wed,  3 Sep 2025 03:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756870518;
 bh=cmlGEjUGTEq6ALjoMdFUamvKYhvI8KGzbkusPQoFNTk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TlooqVyCNK37g2YNqOOJlB1KmQy5DO/YxoSPIFIsF2dsRLvgMCvu/9D8OQr8qrOQn
 u15XcSiVzELowhUxyUqbfH9eQMc8PuWDENsXaifrLt01CU+9JRWznXaE6dNVgixMm7
 yVA4brjirQjqt+XgDenU7PrADvxQJfby8y8s2C5rARkmIdf5j4WlmiqoTfQi5qhidT
 0ibV9Nc9LdY00//vabtvwtvjN6SFTGG8XEJdHnhKl023/KmMMo3HeYmwdzwpJsN0zi
 A0tGyZHoEBg8Kp9pHdSjnB6pDBLU97OrpA4ecqx3m9Gh91n/S8D7rHp9LM0Felgi9g
 f0/5UM4opC7GQ==
Message-ID: <637bdb82-ca3b-4e11-8c59-d8fc75e6837e@kernel.org>
Date: Tue, 2 Sep 2025 22:35:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD HDMI/DP audio broken after suspend since commit
 50e0bae34fa6
To: =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/31/2025 5:12 AM, Przemysław Kopa wrote:
> Hello,
> 
> I'm running Radeon RX 9060 XT and since upgrading to the kernel 6.15 I'm
> facing an issue with audio via DisplayPort. After waking from S3 suspend
> (sometimes, but not always) audio doesn't work - pavucontrol shows that
> the output is disconnected and I don't get sound from my display. If I
> manually reselect the Digital/HDMI output in pavucontrol after resume,
> sound starts working again. Besides my main screen, GPU is also
> connected (via HDMI) to a TV set - I've found out that this issue occurs
> more often if the TV is on (not displaying output from GPU) when I put
> my PC to sleep and I turn the TV off before resuming PC.
> 
> The issue persists on the current mainline kernel (6.17-rc3).
> 
> I've bisected it and this is the commit that introduced the issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=50e0bae34fa6b8b18e13473ddf0bcdab6ab68310
> 
> I've also found a similar report on the alsa mailing list:
> https://lore.kernel.org/alsa-devel/1855350181c58300-webhooks-bot@alsa-project.org/
> 
> I'm running Arch Linux with pipewire and wireplumber. The following is
> an excerpt from the WirePlumber log after bad resume:
> 
> D spa.alsa [alsa-util.c:1996:pa_alsa_get_hdmi_eld]: ELD info empty (for device=7)
> I spa.alsa [alsa-acp-device.c:893:card_props_changed]: card properties changed
> D spa.alsa [acp.c:760:report_jack_state]: Jack 'HDMI/DP,pcm=7 Jack' is now unplugged
> I spa.alsa [alsa-acp-device.c:975:card_port_available]: card port hdmi-output-1 available yes -> no
> I spa.alsa [acp.c:702:profile_set_available]: Profile output:hdmi-stereo-extra1 available yes -> no
> I spa.alsa [alsa-acp-device.c:941:card_profile_available]: card profile output:hdmi-stereo-extra1 available yes -> no
> 
> Please let me know what additional information I might provide to
> pinpoint this issue.
> 
> Thanks,
> Przemysław Kopa
> 

Given it's not a 100% reproduce for you, how did you confirm this commit 
is causing the issue?  Some sort of sampling of X cycles at each bisect 
point?

Could you capture a dmesg log where /sys/power/pm_debug_messages is set 
both from a good case and from a bad case so we can compare?

The peculiar thing is this commit only changes the timing of some of the 
suspend sequence, and as part of the suspend sequence the GPU is reset 
anyway.  So during the resume sequence it shouldn't have mattered what 
happened the last time on suspend entry.

Thanks,
