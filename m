Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8E3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F7810E180;
	Mon, 25 Apr 2022 07:33:11 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114E810F046
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 09:02:47 +0000 (UTC)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1niY8i-0006jt-AS; Sun, 24 Apr 2022 11:02:44 +0200
Message-ID: <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
Date: Sun, 24 Apr 2022 11:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>
References: <YmQi7ajZpZ4W7BJL@itl-email> <YmQkCXZEqp6TKrhJ@itl-email>
 <YmTqYkGEqiz1o2o6@kroah.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YmTqYkGEqiz1o2o6@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1650790967;
 9a8d4353; 
X-HE-SMSGID: 1niY8i-0006jt-AS
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CCing the amdgpu maintainers

On 24.04.22 08:12, Greg KH wrote:
> On Sat, Apr 23, 2022 at 12:06:33PM -0400, Demi Marie Obenour wrote:
>> Two Qubes OS users reported that their AMD GPU systems did not work on
>> 5.17.4, while 5.16.18 worked fine.  Details can be found on
>> https://github.com/QubesOS/qubes-issues/issues/7462.  The initial report
>> listed the GPU as “Advanced Micro Devices, Inc. [AMD/ATI] Renoir
>> [1002:1636} (rev d3) (prog-if 00 [VGA controller])” and the CPU as
>> “AMD Ryzen 5 PRO 4650U with Radeon Graphics”.
>>
>> #regzbot introduced: v5.16.18..v5.17.4
> 
> That's a big range, can you use 'git bisect' to track it down?

FWIW, in another mail in this thread and
https://github.com/QubesOS/qubes-issues/issues/7462#issuecomment-1107681126
it was clarified that the problem was introduced between 5.17.3 and
5.17.4, where a few amdgpu changes were applied. Maybe they are the reason.

Anyway: Yes, as Gregkh said, a bisection really would help. But maybe
the amdgfx developers might already have an idea what might be wrong
here? The QubesOS ticket linked above has some more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
