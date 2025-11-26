Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F126D116F8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Nov 2025 09:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE80310E7B8;
	Thu, 27 Nov 2025 09:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="gmgjQAfZ";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA5F10E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 15:51:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 355E643E1;
 Wed, 26 Nov 2025 17:51:26 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MN4PWb2kOU7g; Wed, 26 Nov 2025 17:51:25 +0200 (EET)
Received: from [192.168.1.2] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id 4336343D4;
 Wed, 26 Nov 2025 17:51:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1764172285;
 bh=VcDdDjk84EF6q7OlfV2GkvDoiRLzNnh5Uc8HxjKEqZc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gmgjQAfZdTsW1FA9FdMLzgbs7cHUX4UZiFpO8KO7d1+88GybEY1aR2XIgBSS5293e
 8T4byzRldQ/wn6hBuMCfFT7mjeZV6p5+sLUr5uGGbShpnjLE9k6SplfwwzG41xRpb6
 Np526zYl0jo3KIoil8bF2w431M02Mo779wX1c9WKGHtkyM1AVZT6CtaM2e1XcAym40
 mWAtFshkQ4Oza+zfxpDGE99AxlOWlYY4MiGygxkWo8EBWq0k55OoQgcj0HDc+LcpnR
 KbL5h2pBcbC2UNIMXlqUWPgK1vjlMXJJEE65QBaVxgn00UW3Lfip3x1zs6uH7V0bkD
 i8iAkOtVhPKlQ==
Content-Type: multipart/mixed; boundary="------------UXRlbxjkVIw0EiLWw0XdWUOK"
Message-ID: <fbd785eb-0e14-4fa1-bf19-3daaae21f81b@oscada.org>
Date: Wed, 26 Nov 2025 17:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1118349@bugs.debian.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
 <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
 <aSa1ECXKTkjM7_uv@eldamar.lan>
 <3c673963-72f3-4054-be21-a5709154bf9d@oscada.org>
 <aSbP5WIKFt_07WMi@eldamar.lan>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <aSbP5WIKFt_07WMi@eldamar.lan>
X-Mailman-Approved-At: Thu, 27 Nov 2025 09:25:38 +0000
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
--------------UXRlbxjkVIw0EiLWw0XdWUOK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

26.11.25 12:01, Salvatore Bonaccorso:
> On Wed, Nov 26, 2025 at 11:15:32AM +0200, Roman Savochenko wrote:
>> 26.11.25 10:06, Salvatore Bonaccorso:
>>> On Sat, Nov 22, 2025 at 07:40:33PM +0200, Roman Savochenko wrote:
>>>> Hi, Uwe Kleine-König
>>>>
>>>> 22.11.25 19:22, Uwe Kleine-König:
>>>>> On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
>>>>>> 21.11.25 10:35, Uwe Kleine-König:
>>>>>>> On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
>>>>>>>> 20.11.25 10:38, Uwe Kleine-König:
>>>>>>>>> On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
>>>>>>>>>> 19.11.25 19:05, Uwe Kleine-König:
>>>>>>>>>>> On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
>>>>>>>>>>>> 12.11.25 17:03, Christian König:
>>>>>>>>>>>>> On 11/12/25 15:28, Roman Savochenko wrote:
>>>>>>>>>>>>>> 12.11.25 13:14, Uwe Kleine-König:
>>>>>>>> OK, and what do you want from me?
>>>>>>> Quoting an earlier mail in that thread:
>>>>>>>
>>>>>>> 	Can you try which Debian kernel was the last one working fine
>>>>>>> 	respective the first being broken in this regard? You can find
>>>>>>> 	all kernels onhttps://snapshot.debian.org/. Please ask if it's
>>>>>>> 	unclear how to do that.
>>>>>> I have told that as the kernel in Debian 11.
>>>>> Is that the last working or the first broken?
>>>>>
>>>>> The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
>>>>> the last in buster-security which would be 5.10.244-1? Or do you mean
>>>>> the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
>>>>> think)?
>>>>>
>>>>> The kernels before and after that are depending on what you meant above
>>>>> 5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
>>>>> 5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?
>>>>>
>>>>> The gist to take away here is: Don't specify kernel versions as "the one
>>>>> in Debian 11" or "kernel 5" but use the proper kernel (package) version.
>>>>> Everything else is too fuzzy for me to work with.
>>>> And what that about when I have said that precisely???
>>>>
>>>>> Kernel 5 what? E.g. which concrete version number? (output of uname -a).
>>>> user@debian:~$ cat /proc/version
>>>>
>>>> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
>>>> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
>>>> #1 SMP Debian 5.10.223-1 (2024-08-10)
>>>>
>>>>>>> Parts of the misunderstanding here might also be a language barrier. So
>>>>>>> maybe try to get some help in the kernel community that speaks your
>>>>>>> native tongue.
>>>>>> So, English isn't native one for you? :)
>>>>> Right, and I doubt it's yours either. Or you would be the first native
>>>>> English speaker in my career that I fail to understand when
>>>>> communicating about Linux topics. (The only other explanations for that
>>>>> I can come up with are a) you suffer from dyslexia; or b) you write
>>>>> glibberish on purpose to annoy.)
>>>>>
>>>>> PSA: This is my last mail to you for this bug until you come up with a
>>>>> statement like:
>>>>>
>>>>> 	I tested Debian kernel image package version a.b.c-d and its
>>>>> 	broken with the following symptoms: [....]. The kernel image
>>>>> 	that occurs in the list on
>>>>> 	https://snapshot.debian.org/package/linux/ directly after that
>>>>> 	(i.e. version e.f.g-h) doesn't show these symptoms.
>>>> As if I need your messages with your dyslexia... :)
>>> I'm closing this bug along. If you can provide the above version
>>> please respond to this message with the required information and a
>>> control message to reopen the bugreport.
>> Are you read the post in the middle or only the end with the trash from Uwe?
>>
>> Then read the part to which I have nothing to add!!!
>>
>>> Kernel 5 what? E.g. which concrete version number? (output of uname -a).
>> user@debian:~$ cat /proc/version
>>
>> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
>> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
>> #1 SMP Debian 5.10.223-1 (2024-08-10)
> Yes. And so you have then the last working 5.10.y version and knowing
> the next one released in Debian does not work. That means you can
> bisect now those two upstream stable series versions to identify which
> is the breaking commit with the described procedure to identify the
> breaking commit.

And you? :)

I very well know the bisecting approach, but I have no time, due to I 
have many other unresolved problems to spend this time on them.

> Once we have those biection results we might get a better idea with
> upstream's help on what do do.

Once I fix that, I won't need your participation in whether pushing the 
patch to the upstream or even starting myself builds, especially after 
definition my as a liar by closing the bug with such reasons.

Imagine for your, as an ordinal user will report this bug, when the 
installed system cannot even boot and he beginning Linux from Debian 
9,10,12,13!!! :)

And then imagine, as the ordinal user, who just tried Debian, will go to 
compile many kernels in the bisecting approach for detection the two 
controversy represents in different kernels. :)

And then imaging, as he'll prove the stack of the broken changes in 
mainstream! :)

And I have clashed with that MANY times for not throw myself immediately 
in the mess, when I can just apply the workaround and what I have 
expected from you!

And farewell, since I have no reason of further saying with you after 
the bug closing, since in Debian there "is no problem". :)

--------------UXRlbxjkVIw0EiLWw0XdWUOK
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

--------------UXRlbxjkVIw0EiLWw0XdWUOK--
