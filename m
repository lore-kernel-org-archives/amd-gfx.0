Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6D4C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 18:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FBF10E0EE;
	Mon,  1 May 2023 18:45:06 +0000 (UTC)
Received: from dijkstra.felixrichter.tech (dijkstra.felixrichter.tech
 [37.120.184.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA38E10E0EE;
 Mon,  1 May 2023 18:44:04 +0000 (UTC)
Received: from [10.130.10.1] (unknown [10.130.10.1])
 by dijkstra.felixrichter.tech (Postfix) with ESMTPSA id 65C861A0044;
 Mon,  1 May 2023 20:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=felixrichter.tech;
 s=20210926; t=1682966671;
 bh=9G+jmurZ01le62hdQTblpqATUMhLiFsLfmyU+lPgGeY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cAmnFJiLbhFQeNznDcVHsrNeYuFZxDO9Edwiha0yc1hP11a0B9CyEw3lMQvDo//Yi
 wSyRbGOSe2RtU3pAwUAskzdgE2qB76YigwHFMp8vwaAKa55VvLmQ5m0Si2oJhdT1WW
 +1atGg1ah9OO59f7Dqjc++aO2wX132aVu///6kEI=
Message-ID: <9525dac3-05d9-3943-c43a-e5b475e6088b@felixrichter.tech>
Date: Mon, 1 May 2023 20:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: PROBLEM: AMD Ryzen 9 7950X iGPU - Blinking Issue
To: Alex Deucher <alexdeucher@gmail.com>
References: <46a7eb80-5f09-4f6a-4fd3-9550dafd497c@felixrichter.tech>
 <CADnq5_Nuu7hAFR6A8SqaENA_CUV_F3J1qgCwE=Yn_1rY-n5GLg@mail.gmail.com>
Content-Language: en-US
From: Felix Richter <judge@felixrichter.tech>
In-Reply-To: <CADnq5_Nuu7hAFR6A8SqaENA_CUV_F3J1qgCwE=Yn_1rY-n5GLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 May 2023 18:45:03 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01.05.23 15:27, Alex Deucher wrote:
> On Mon, May 1, 2023 at 3:20 AM Felix Richter <judge@felixrichter.tech> wrote:
>> Hi,
>>
>> I am running into an issue with the integrated GPU of the Ryzen 9 7950X. It seems to be a regression from kernel version 6.1 to 6.2.
>> The bug materializes in from of my monitor blinking, meaning it turns full white shortly. This happens very often so that the system becomes unpleasant to use.
>>
>> I am running the Archlinux Kernel:
>> The Issue happens on the bleeding edge kernel: 6.2.13
>> Switching back to the LTS kernel resolves the issue: 6.1.26
>>
>> I have two monitors attached to the system. One 42 inch 4k Display and a 24 inch 1080p Display and am running sway as my desktop.
>>
>> Let me know if there is more information I could provide to help narrow down the issue.
> It's related to scatter/gather display.  As a workaround, you can
> disable scatter/gather display by setting amd.sg_display=0 on the
> kernel command line in grub.  It's fixed properly in:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/08da182175db4c7f80850354849d95f2670e8cd9
> Which should land in Linus' tree this week.
>
> Alex

Thank you for your quick response. Sadly I have to report that using the 
workaround kernel parameter did not resolve the issue for me. The 
monitor still
turns full white although less frequently. I'll be sure to look out for 
the update once it hits mainline ;)

Kind regards,
Felix
