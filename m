Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D99C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 05:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6A910EA91;
	Fri, 18 Mar 2022 05:43:14 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228F010EA91
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 05:43:13 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef49.dynamic.kabel-deutschland.de
 [95.90.239.73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6552A61E64846;
 Fri, 18 Mar 2022 06:43:11 +0100 (CET)
Message-ID: <40b3084a-11b8-0962-4b33-34b56d3a87a3@molgen.mpg.de>
Date: Fri, 18 Mar 2022 06:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 James Turner <linuxkernel.foss@dmarc-none.turner.link>
References: <87ee57c8fu.fsf@turner.link>
 <87a6ftk9qy.fsf@dmarc-none.turner.link> <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87ee4wprsx.fsf@turner.link> <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
 <87pmo8r6ob.fsf@turner.link>
 <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
 <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
 <87pmnnpmh5.fsf@dmarc-none.turner.link>
 <CADnq5_NG_dQCYwqHM0umjTMg5Uud6zC4=MiscH91Y9v7mW9bJA@mail.gmail.com>
 <092b825a-10ff-e197-18a1-d3e3a097b0e3@leemhuis.info>
 <877d96to55.fsf@dmarc-none.turner.link> <87lexdw8gd.fsf@turner.link>
 <d541b534-8b83-b566-56eb-ea8baa7c998e@leemhuis.info>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d541b534-8b83-b566-56eb-ea8baa7c998e@leemhuis.info>
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
Cc: Xinhui Pan <Xinhui.Pan@amd.com>, regressions@lists.linux.dev,
 kvm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Thorsten, dear James,


Am 17.03.22 um 13:54 schrieb Thorsten Leemhuis:
> On 13.03.22 19:33, James Turner wrote:
>>
>>> My understanding at this point is that the root problem is probably
>>> not in the Linux kernel but rather something else (e.g. the machine
>>> firmware or AMD Windows driver) and that the change in f9b7f3703ff9
>>> ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)") simply
>>> exposed the underlying problem.
> 
> FWIW: that in the end is irrelevant when it comes to the Linux kernel's
> 'no regressions' rule. For details see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/handling-regressions.rst
> 
> That being said: sometimes for the greater good it's better to not
> insist on that. And I guess that might be the case here.

But who decides that? Running stuff in a virtual machine is not that 
uncommon.

Should the commit be reverted, and re-added with a more elaborate commit 
message documenting the downsides?

Could the user be notified somehow? Can PCI passthrough and a loaded 
amdgpu driver be detected, so Linux warns about this?

Also, should this be documented in the code?

>> I'm not sure where to go from here. This issue isn't much of a concern
>> for me anymore, since blacklisting `amdgpu` works for my machine. At
>> this point, my understanding is that the root problem needs to be fixed
>> in AMD's Windows GPU driver or Dell's firmware, not the Linux kernel. If
>> any of the AMD developers on this thread would like to forward it to the
>> AMD Windows driver team, I'd be happy to work with AMD to fix the issue
>> properly.

(Thorsten, your mailer mangled the quote somehow – I reformatted it –, 
which is too bad, as this message is shown when clicking on the link 
*marked invalid* in the regzbot Web page [1]. (The link is a very nice 
feature.)

> In that case I'll drop it from the list of regressions, unless what I
> wrote above makes you change your mind.
> 
> #regzbot invalid: firmware issue exposed by kernel change, user seems to
> be happy with a workaround
> 
> Thx everyone who participated in handling this.

Should the regression issue be re-opened until the questions above are 
answered, and a more user friendly solution is found?


Kind regards,

Paul


[1]: https://linux-regtracking.leemhuis.info/regzbot/resolved/
