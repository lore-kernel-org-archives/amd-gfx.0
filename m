Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FC0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 08:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86A510E1F1;
	Mon, 14 Feb 2022 08:43:52 +0000 (UTC)
X-Greylist: delayed 863 seconds by postgrey-1.36 at gabe;
 Sun, 13 Feb 2022 23:38:31 UTC
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC18A10E1E6
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Feb 2022 23:38:31 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 91720C5946
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Feb 2022 23:27:02 +0000 (UTC)
Received: (Authenticated sender: ash@heyquark.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 9A7ADFF802;
 Sun, 13 Feb 2022 23:26:51 +0000 (UTC)
Message-ID: <992dccb9-590a-c7b7-146f-d134fb399f7e@heyquark.com>
Date: Mon, 14 Feb 2022 10:26:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] Upstreaming Linux for Nintendo Wii U
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>
References: <0020d47c-0e23-822c-33f5-ccb7ea4c1072@heyquark.com>
 <87ee49sktb.fsf@mpe.ellerman.id.au>
 <41c696de-0e04-61e1-610c-73e9440c5c19@csgroup.eu>
From: Ash Logan <ash@heyquark.com>
In-Reply-To: <41c696de-0e04-61e1-610c-73e9440c5c19@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Feb 2022 08:43:42 +0000
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
Cc: "linkmauve@linkmauve.fr" <linkmauve@linkmauve.fr>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "j.ne@posteo.net" <j.ne@posteo.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christophe,

On 12/2/22 00:11, Christophe Leroy wrote:
> Hi Ash,
> 
> Le 11/02/2022 à 12:29, Michael Ellerman a écrit :
>> Ash Logan <ash@heyquark.com> writes:
>>> - Like the Wii before it, the Wii U has a small amount of RAM at address
>>> zero, a gap, then a large amount of RAM at a higher address. Instead of
>>> the "map everything and reserve the gap" approach of the Wii, we loop
>>> over each memblock and map only true RAM[9]. This seems to work, but as
>>> far as I can tell is unique amongst powerpc32 platforms, so it's worth
>>> pointing out. (Note: I've been told this doesn't work anymore after some
>>> KUAP changes[10], so this point might be moot; haven't investigated)
>>
>> We'd need more detail on that I guess. Currently all the 32-bit
>> platforms use the flat memory model, which assumes RAM is a single
>> contiguous block. Though that doesn't mean it all has to be used or
>> mapped, like the Wii does. To properly support your layout you should be
>> using sparsemem, but it's possible that's more trouble than it's worth,
>> I'm not sure. How far apart are the low and high blocks of RAM, and what
>> are their sizes?
> 
> Can you provide details on what's happening with KUAP changes ?
> 
> You are pointing to series https://lkml.org/lkml/2021/6/3/204
> 
> Does it work when CONFIG_PPC_KUAP is not selected or doesn't it work
> either ?
> 
> Are you able to bisect which commit of that series is the culprit ?

Emmanuel told me about this during their work on 5.13 which I wasn't 
involved in, and now can't remember any of the details, so I guess I 
don't actually have any more information.
I'm working on getting a baseline setup for 5.15 (just udbg and the 
like), so if there is an issue I should soon find out about it and will 
get back to you.

> Thanks
> Christophe

Thanks,
Ash
