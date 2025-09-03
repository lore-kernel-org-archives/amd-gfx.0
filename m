Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED1CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 18:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B76010E1B6;
	Wed,  3 Sep 2025 18:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tio3/17h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F2510E1B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 18:22:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EEAF76013F;
 Wed,  3 Sep 2025 18:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE71C4CEE7;
 Wed,  3 Sep 2025 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756923761;
 bh=vmkr/TGfSykba7t8LcI6L86lxMDOKgtapHVynyWhnLc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tio3/17hR+R1UEJUzXbSUkJPznc72tXz7I2TPdQl78/NAyJYsznYNjGiJUAluavoD
 PFAodjrmHl6wfdLk3rlPyMDdHOQp56+K5Bvg78eu+HXa9wYb3hMcZBSO0rMTIbEuDn
 2mfztuxA9DAVf8Z3rTNilzpIz8qSaWG7zfUv17/dCSZMZspwukT1hUU6jyG91uxfQh
 5BmIG/8k4gQWfaMzXOj3lrBGAoJ/KdeZKMWU+JrbvDAfmUJUQX4gA7ZVT7QLsOdlb6
 ggzmmNuWbWoXjv6FmqRYBYVNhgY5QQMdRESTqBoWah94/VcIraDfcKcGsNgzRTqR0U
 1KhWFV6t4ornQ==
Message-ID: <b033c364-476f-4cdd-8823-2a3bbddd9de4@kernel.org>
Date: Wed, 3 Sep 2025 13:22:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD HDMI/DP audio broken after suspend since commit
 50e0bae34fa6
To: =?UTF-8?Q?Przemys=C5=82aw_Kopa?= <prz.kopa@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <967d5380-1db1-4252-a3b5-cfa283cf960d@gmail.com>
 <637bdb82-ca3b-4e11-8c59-d8fc75e6837e@kernel.org>
 <6fd5d5e1-2f4a-4640-a88b-8fc66bf54f75@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6fd5d5e1-2f4a-4640-a88b-8fc66bf54f75@gmail.com>
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

On 9/3/25 7:21 AM, Przemysław Kopa wrote:
> On 9/3/25 05:35, Mario Limonciello wrote:
> 
>> Given it's not a 100% reproduce for you, how did you confirm this 
>> commit is causing the issue?  Some sort of sampling of X cycles at 
>> each bisect point?
> 
> Yes, I've tried a couple of times to trigger this issue on each 
> bisection point (by doing suspend -> resume cycle), and if I wasn't able 
> to trigger it, I've assumed it's good and moved on. I think I got the 
> right commit in the end, since now I have two kernels that are a single 
> commit apart (50e0bae34fa6), and I am able to trigger the issue when 
> running kernel with 50e0bae34fa6 applied, but am not able to trigger it 
> when running kernel without 50e0bae34fa6 (and I tried a lot ;).
> 
>> Could you capture a dmesg log where /sys/power/pm_debug_messages is 
>> set both from a good case and from a bad case so we can compare?
> 
> I'm attaching two dmesg dumps, running 6.17-rc4, fresh boot with a 
> single suspend -> resume cycle within each file.
> 
> 'dmesg_dp_audio_good.txt' - sound is fine after resume
> 'dmesg_dp_audio_bad.txt' - no sound after resume

I compared the two of them.
There are different problems you have with USB during recovery in the 
bad, but I don't think that's relevant.
The only thing different from a display perspective is a slight 
difference to the timing.

Can you repeat once more with /sys/power/pm_debug_messages and 
/sys/power/pm_print_times set for good and bad?  I want to make sure the 
device suspend order is identical.

Also; does playing audio leading up to the suspend cycle influence 
anything (both on good and bad kernel)?
