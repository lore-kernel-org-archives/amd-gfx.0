Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD37C38142
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 14:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1E110E4A4;
	Mon, 23 Jan 2023 14:14:14 +0000 (UTC)
Received: from c3po.tilda.center (c3po.tilda.center [108.61.164.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC4310E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 14:14:12 +0000 (UTC)
Received: from [192.168.111.186] (meka.rs [109.93.255.137])
 by c3po.tilda.center (Postfix) with ESMTPSA id 4122D3501C;
 Mon, 23 Jan 2023 15:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tilda.center;
 s=c3po; t=1674483209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSglieW65IuypdPrBP9zmRg+aUKZWPn3hthfVBFnY/0=;
 b=mcQcDUzol1+lzloHzEA7c9dmfBf+dSX/AXHo02j6AvtJTA5HHCsvc86am01kLIwvPtDJH8
 gBUnLs3fzUu3HE2iY4NIoua9DZstUB7kkz7zzbmqQBSix0lLjO0IRdEEjqP+6Wn04WedCv
 9HKpTHqZ7Z4/d3zsPTjh9igf5v6qhbk=
Message-ID: <1f394961-4991-e684-c0f6-0c3142ef825e@tilda.center>
Date: Mon, 23 Jan 2023 15:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Minimal kernel version for 7900XT
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
 <CADnq5_N8AH+Ay8V1oqX4FptDKM6Uz=6a22JOr47Jw98VeJqRBA@mail.gmail.com>
From: =?UTF-8?Q?Goran_Meki=c4=87?= <meka@tilda.center>
In-Reply-To: <CADnq5_N8AH+Ay8V1oqX4FptDKM6Uz=6a22JOr47Jw98VeJqRBA@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/23/23 15:09, Alex Deucher wrote:
> On Mon, Jan 23, 2023 at 5:11 AM Goran Mekić <meka@tilda.center> wrote:
>>
>> Hello,
>>
>> I'm trying to figure out what's the minimal kernel version that supports
>> the 7900XT. I found that the driver supports SLES 15:
>> https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-series/amd-radeon-rx-7900-series/amd-radeon-rx-7900xt
>>
>> I also found that SLES 15 SP 4 runs on 5.14:
>> https://www.suse.com/support/kb/doc/?id=000019587#SLE15SP4
> 
> Kernel 6.0 or newer.
> 
>>
>> The problem I have is that I can't find PCI ID (for my card it's 744c)
>> in the list:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L1654
>>
>> Can you help me understand how this card works with Linux without PCI ID
>> anywhere mentioned in the code, please? Thank you!
> 
> 
> The driver binds to all 0x1002 vendor ID display class devices.  Once
> loaded, the driver parses a data table on the device to enumerate all
> of the engines on the GPU.  If they are all supported, the driver
> loads.
> 
> Alex
Thank you for the details!

Regards,
meka
