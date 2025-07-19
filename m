Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D81BC83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7610E45D;
	Sun, 20 Jul 2025 15:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="xvSl7dDS";
	dkim=pass (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="X17Z+Wwz";
	dkim-atps=neutral
X-Greylist: delayed 452 seconds by postgrey-1.36 at gabe;
 Sat, 19 Jul 2025 02:19:47 UTC
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61210E1B1
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Jul 2025 02:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=OvceKsHJQn6ZB
 GnxlaaUlq8JOOFcy8MLLSiAWqGN3A4=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=hacktheplanet.fi; b=xvSl7dDSWiV0MHuVNVxdyKisTxvOnuZlj7
 fYu2QjtWibJ3RHd+u2yoffXrdj0xrJ5lNQl1SFdzqXjd5tR5sa4tBe2L5dS0txVBa0WrWq
 KErH7xqk6TiXBbyYo1ss/8qcE1x+fY67NDf8WqNFMe461dozrVxSVQUn5QM64vCBsUR0iV
 /9TIMBz7YNdBg0GaYUayKeT9UkiJP3Kt+rxbeRWXTYeAV0dvRZRf7BaiwPEsVlfU+FoQZl
 oOAEHD6oE4+82MBJY1X9tUkqA1U03fBobvZPdrpKLAMIXJzb0PWhYsU11uMxfgxohnvowd
 m2EP9jwF2CGEoJBAbD7XPw0s0NBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
 s=key1; t=1752891132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9/8IgHhr2c6ad7Ph8qx/BNrV4ml1db8j62Ybqxzcew=;
 b=X17Z+Wwz+3+TdQmu6SoBosMELKDbRWNoibmdBuEYDS5PbEU3U7cFFp9dk0/VeGx3TfVT/3
 uOlDF1HWGj6UmfP+BscPqn9VUm8diEGsTDdATqWc/NN+fWlB+nHp3apbtg0iuahiv98HsS
 jwVWL5w1NAssnvUOZrjldv7zpt5gOpGGlG04emwb5VVVMdPW62BApSni6F1uS1zxtTucR/
 mkHJB2ksnDiMGgftoztYYLBuG9b8t9E/pug7IeVwuCYJ2vMBPYrQ++/0LdjKuICPSVXnyh
 RXSXkiOsBqQzke5Y+vuX9STm2vVIE7y/awLDvFIxb538b1jObCfuky1TUnxbvw==
Date: Sat, 19 Jul 2025 11:12:08 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
Message-ID: <aHr--GxhKNj023fg@hacktheplanet.fi>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

On Fri, Jul 18 2025 20:14:08 -0500, Mario Limonciello wrote:
> OK, I think we need to do two things to figure out what's going on.
> 
> 1) Let's shift over to 6.16-rc6.  Once we've got a handle on the situation
> there we can iron out if there are other patches missing or this is also
> broken for you in 6.16.  If it's not working as expected there either we
> need it fixed there first anyway.

Same behavior on 6.16-rc6: brightness is set to 0 (max 399000),
minimally visible.

> 2) The starting brightness I don't expect to be "0".  We need to see what
> values were read out from the firmware. There is a debugging message we can
> catch if you boot with drm.debug=0x106.  Keep in mind you probably need to
> increase log_buf_len if your ring buffer is set too small too.
> 
> https://github.com/torvalds/linux/commit/4b61b8a390511a1864f26cc42bab72881e93468d
> 
> PS: I would rather you add logs into a gist, pastebin or a bug somewhere if
> you can.

[    3.210757] amdgpu 0000:03:00.0: [drm:amdgpu_dm_connector_late_register [amdgpu]] Backlight caps: min: 1000, max: 400000, ac 100, dc 32

full dmesg: https://termbin.com/o2q3

-- 
Lauri Tirkkonen | lotheac @ IRCnet
