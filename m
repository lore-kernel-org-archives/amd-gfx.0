Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6523BC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 08:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF0E10E1E1;
	Mon, 27 Nov 2023 08:39:46 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866F810E02C
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Nov 2023 14:40:24 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1r7GJ4-0001v2-7I; Sun, 26 Nov 2023 15:40:22 +0100
Message-ID: <a1d74498-9c71-4e46-9db3-58baac89dc36@leemhuis.info>
Date: Sun, 26 Nov 2023 15:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Lee, Alvin" <Alvin.Lee2@amd.com>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
 <99ef9596-d4f8-49e2-acbe-ed7486310f84@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <99ef9596-d4f8-49e2-acbe-ed7486310f84@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1701009624;
 1af263c4; 
X-HE-SMSGID: 1r7GJ4-0001v2-7I
X-Mailman-Approved-At: Mon, 27 Nov 2023 08:39:45 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16.11.23 11:46, Christian König wrote:
> Am 15.11.23 um 21:08 schrieb Mikhail Gavrilov:
>> On Wed, Nov 15, 2023 at 11:39 PM Lee, Alvin <Alvin.Lee2@amd.com> wrote:
>>> This change has a DMCUB dependency - are you able to update your
>>> DMCUB version as well?
>>>
>> I can confirm this issue was gone after updating firmware.
>>
>> ❯ dmesg | grep DMUB
>> [   11.496679] [drm] Loading DMUB firmware via PSP: version=0x07002300
>> [   12.000314] [drm] DMUB hardware initialized: version=0x07002300
> 
> Mhm, that's a quite ugly problem.
> 
> The driver is supposed to work with older firmware as well or at least
> issue a warning and provide a reasonable fallback.
> 
> How are we going to handle this?

What happened to this regression? This thread looks stalled and from a
quick search on lore and the amdgpu issue tracker it seems the issue
wasn't discussed anywhere else during the last 10 days, but I might have
missed something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
