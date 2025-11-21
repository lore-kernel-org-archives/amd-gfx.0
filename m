Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE0CFC27C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 13:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A57210E874;
	Fri, 21 Nov 2025 13:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="cnTHhMG2";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A822910E800
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 09:11:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 231AB43DD;
 Fri, 21 Nov 2025 11:11:41 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gzm7WEAKkXw4; Fri, 21 Nov 2025 11:11:39 +0200 (EET)
Received: from [192.168.1.3] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id DA66143D2;
 Fri, 21 Nov 2025 11:11:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1763716299;
 bh=9eXi3rCfREO9mb0OTF0v7mD2kYgOTOEshhzRl+so1IU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cnTHhMG2W+WUlKSCBxQlTA4VoJQn8bm4peDTJc8SsX+jGS7tE5LU6IVhDF2Z0qaJh
 qdaOB9IlGvQu4DBUExe5YDFwOJoMBy9tjC+cw1o/j/x0ydX4i7KN59IJfYfCvHqjZ3
 5gxOqUXqm2kCApuTj/G1Jl9xHZ5uAmV0D/U3cF0eSqdFArPZjFlzK2/Azg+6QuudLL
 aIvGhVKEFsptz9McNNjrV6EmEPahyVX6uHErpwV/uqN8tcPI2wz2kbTWr2v5Cy8GA6
 rgXxyU2H1yvW//FEu5rWPmcAjVAaHYAYMbqPL5EgGZjPas8ymkR9Ua+2eD6g+Ahqtx
 DqSM3BbHW2mQQ==
Content-Type: multipart/mixed; boundary="------------3XeXJjGTD8CF2ny8z3oS0FCT"
Message-ID: <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
Date: Fri, 21 Nov 2025 11:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: 1118349@bugs.debian.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
X-Mailman-Approved-At: Fri, 21 Nov 2025 13:48:32 +0000
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

This is a multi-part message in MIME format.
--------------3XeXJjGTD8CF2ny8z3oS0FCT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Uwe Kleine-König

21.11.25 10:35, Uwe Kleine-König:
> On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
>> 20.11.25 10:38, Uwe Kleine-König:
>>> On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
>>>> 19.11.25 19:05, Uwe Kleine-König:
>>>>> On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
>>>>>> 12.11.25 17:03, Christian König:
>>>>>>> On 11/12/25 15:28, Roman Savochenko wrote:
>>>>>>>> 12.11.25 13:14, Uwe Kleine-König:
>>>>>>>>>> On my hardware that doesn't work and there is no specific.
>>>>>>>>>>
>>>>>>>>>> Now just I set "radeon.dpm=1", I got immediately restart with disabling USB,
>>>>>>>>>> so I have needed to restart for successful download with "radeon.dpm=0".
>>>>>>>>> Can you try a different monitor?
>>>>>>>> I have only one, connected through DVI, and there is no problem on Linux Kernel 5.
>>>>>>> Kernel 5 what? E.g. which concrete version number? (output of uname -a).
>>>>>> user@debian:~$ cat /proc/version
>>>>>>
>>>>>> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
>>>>>> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
>>>>>> #1 SMP Debian 5.10.223-1 (2024-08-10)
>>>>>>
>>>>>>>>> Can you try which Debian kernel was the last one working fine respective
>>>>>>>>> the first being broken in this regard? You can find all kernels on
>>>>>>>>> https://snapshot.debian.org/. Please ask if it's unclear how to do that.
>>>>>>>> I can try all kernels in Debian starting 7 and finishing 13, but I have traced that before and the problem reproduction started from Debian 9, terminated on Debian 11 and renewed on Debian 12.
>>>>> Not sure I follow. Does that mean that Debian 9, Debian 10, Debian 12
>>>>> and Debian 13 show the symptom and Debian 11 doesn't?
>>>> Yes, and in kernels that is 4, 6 show the symptom and 3, 5 don't.
>>> I think this statement isn't helpful unless you're saying that Linux
>>> 5.19 was good and 6.0 was bad. Kernel versions started with 5 between
>>> 2019-03-03 and 2022-07-31, not taking stable releases into account. And
>>> there are 294457 commits in that range
>>> (`git rev-list v5.0..v5.19 | wc -l`). So "kernel 5" and "kernel 6" is a
>>> bit too fuzzy to work with.
>> OK, and what do you want from me?
> Quoting an earlier mail in that thread:
>
> 	Can you try which Debian kernel was the last one working fine
> 	respective the first being broken in this regard? You can find
> 	all kernels on https://snapshot.debian.org/. Please ask if it's
> 	unclear how to do that.

I have told that as the kernel in Debian 11.

>> Must I say you the exact commit or what,
>> or you are waiting I must recompile all kernels with 294457 commits?
>>
>> I say you in what way the problem related through the stable kernels in
>> Debian releases and that is exactly assigned to the major versions of the
>> Linux kernel, even for broken v5.19 which can include backports from 6!
> Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
> several years of development each and thus are not helpful to locate the
> change that broke your setup. Unless it is really 5.19 that was good and
> 6.0 that is bad which limits the amount of changes from:

I keep talking that only for understanding the problem depth and not for 
fixing that in 4 kernels!

That is, there can be simpler to apply that workaround.

> . This is still a lot and we might ask you to do more tests to further
> limit the set of candidate commits that are broken on your end.

OK, ask.

>>> Can you please confirm that 5.19.x (e.g. a kernel package from
>>> https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
>>> 6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
>>> doesn't? (Or a similar statement with other consecutive mainline
>>> versions.)
>> 5.19.0 has this problem in view of hanging.
> You lost me here. What is "problem in view of hanging"? Are we talking
> about more than one problem? Or different variants of the same problem?

We talk about different variants, and the hanging I saw also on one 6 
kernel just after installing Debian 13 and that is why #1118349 I opened 
about the hanging but not rebooting in the initial report #879992.

>>> Note that even that might not be enough to spot the problem and you
>>> might have to get your hands dirty then and compile development kernels
>>> and test them.
>> Note, my hands in that "dirty" are 22 years already and I hoped I will not
>> get their at least on Linux kernel again — http://oscada.org/wiki/Special:MyLanguage/Sub-projects/Automation_Linux_distributive
>> . :)
>>
>> And I have resolved the problem for myself by the option "radeon.dpm=0" in
>> all my Live Disks. If you want to tell that is my problem, throw it away and
>> reject the workaround!:)
> There might be a misconception about the roles involved here.
>
> In my eyes the situation is as follows: You have a problem.

I have resolved the problem for myself far ago.

> I (and possibly others) offer to help.

To help for other with same hardware, since I can fix that for myself if 
I need.

> For now your problem report isn't in a form that I can act upon. So it's in your interest to provide the
> information that I ask for. If you don't want to do that, that's fine,
> and I won't have sleepless nights about it. The likely outcome is that
> the problem isn't addressed.

Whether I don't provide you all information beyond "get my hand in the 
dirty"? :)

> Parts of the misunderstanding here might also be a language barrier. So
> maybe try to get some help in the kernel community that speaks your
> native tongue.

So, English isn't native one for you? :)

Regards, Roman

--------------3XeXJjGTD8CF2ny8z3oS0FCT
Content-Type: text/vcard; charset=UTF-8; name="roman.vcf"
Content-Disposition: attachment; filename="roman.vcf"
Content-Transfer-Encoding: base64

QkVHSU46VkNBUkQNClZFUlNJT046NC4wDQpFTUFJTDtQUkVGPTE6cm9tYW5Ab3NjYWRhLm9y
Zw0KRk46Um9tYW4gU2F2b2NoZW5rbw0KT1JHOk9wZW5TQ0FEQSBUZWFtOw0KVElUTEU6T3Bl
blNDQURBIGF1dGhvciBhbmQgbWFpbiBkZXZlbG9wZXINCk46U2F2b2NoZW5rbztSb21hbjs7
Ow0KQURSOjs7O0thbWphbnNrZTtTaWNoZXNsYXZza2E7NTE5Mzk7VWtyYWluZQ0KVEVMO1ZB
TFVFPVRFWFQ6KzM4MDY3OTg1OTgxNQ0KVVJMO1RZUEU9d29yaztWQUxVRT1VUkw6aHR0cDov
L29zY2FkYS5vcmcNClVJRDpiYzkyY2E2My03NWNhLTQ5OGItODAxYy01NGJlMmIzNDMyOGUN
CkVORDpWQ0FSRA0K

--------------3XeXJjGTD8CF2ny8z3oS0FCT--
