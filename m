Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E654D10F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212A010E63F;
	Wed, 26 Nov 2025 14:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="ZvGyNiiF";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE83010E57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 09:15:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 6D0AA43D4;
 Wed, 26 Nov 2025 11:15:34 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id lrc-HyRVdNl4; Wed, 26 Nov 2025 11:15:33 +0200 (EET)
Received: from [192.168.1.2] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id 4A89B7E6;
 Wed, 26 Nov 2025 11:15:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1764148533;
 bh=c48bHYbN31e2y+g+MajksJw54APeT7Q9xRVvLOeuFVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZvGyNiiF8L9QuO2/eVobHxZWaRGVkQciDDFg/7UDXAows0PBhW7MP4aUl+mfqOm7+
 Jz2Hse5XSBDQCLj+oiY6LLPt15C4yhr3zc65koX/lTrvEEzo9svgcCt2aSpaTp2JGo
 tfh/mFtoDFRGVQ5cX7p43R4T8ps8+XrF7cWDXOu5VR8ZHMN83RbU9njXTS3i6VsTGk
 Ck0uMwR7viHfNYsbvrtSXsO4vEdPbJ9200WS3VHo1wk3C27o5UA/4x6tCl4PAkOxCn
 ay0YDxuZKyHCTR7OyCEkKpjBOYtszIzc09mBz7DOW7zlKzn8kfQW8suPRMSEHExF/s
 4lr92cajmziOg==
Content-Type: multipart/mixed; boundary="------------HnZjBtZsKVaor2IYccyi8Gou"
Message-ID: <3c673963-72f3-4054-be21-a5709154bf9d@oscada.org>
Date: Wed, 26 Nov 2025 11:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: Salvatore Bonaccorso <carnil@debian.org>, 1118349-done@bugs.debian.org
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
 <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
 <aSa1ECXKTkjM7_uv@eldamar.lan>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <aSa1ECXKTkjM7_uv@eldamar.lan>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:30:52 +0000
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
--------------HnZjBtZsKVaor2IYccyi8Gou
Content-Type: multipart/alternative;
 boundary="------------vz9g5CEUdckOBEo3hSGHSvyI"

--------------vz9g5CEUdckOBEo3hSGHSvyI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

26.11.25 10:06, Salvatore Bonaccorso:
> On Sat, Nov 22, 2025 at 07:40:33PM +0200, Roman Savochenko wrote:
>> Hi, Uwe Kleine-König
>>
>> 22.11.25 19:22, Uwe Kleine-König:
>>> On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
>>>> 21.11.25 10:35, Uwe Kleine-König:
>>>>> On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
>>>>>> 20.11.25 10:38, Uwe Kleine-König:
>>>>>>> On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
>>>>>>>> 19.11.25 19:05, Uwe Kleine-König:
>>>>>>>>> On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
>>>>>>>>>> 12.11.25 17:03, Christian König:
>>>>>>>>>>> On 11/12/25 15:28, Roman Savochenko wrote:
>>>>>>>>>>>> 12.11.25 13:14, Uwe Kleine-König:
>>>>>> OK, and what do you want from me?
>>>>> Quoting an earlier mail in that thread:
>>>>>
>>>>> 	Can you try which Debian kernel was the last one working fine
>>>>> 	respective the first being broken in this regard? You can find
>>>>> 	all kernels onhttps://snapshot.debian.org/. Please ask if it's
>>>>> 	unclear how to do that.
>>>> I have told that as the kernel in Debian 11.
>>> Is that the last working or the first broken?
>>>
>>> The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
>>> the last in buster-security which would be 5.10.244-1? Or do you mean
>>> the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
>>> think)?
>>>
>>> The kernels before and after that are depending on what you meant above
>>> 5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
>>> 5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?
>>>
>>> The gist to take away here is: Don't specify kernel versions as "the one
>>> in Debian 11" or "kernel 5" but use the proper kernel (package) version.
>>> Everything else is too fuzzy for me to work with.
>> And what that about when I have said that precisely???
>>
>>> Kernel 5 what? E.g. which concrete version number? (output of uname -a).
>> user@debian:~$ cat /proc/version
>>
>> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
>> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
>> #1 SMP Debian 5.10.223-1 (2024-08-10)
>>
>>>>> Parts of the misunderstanding here might also be a language barrier. So
>>>>> maybe try to get some help in the kernel community that speaks your
>>>>> native tongue.
>>>> So, English isn't native one for you? :)
>>> Right, and I doubt it's yours either. Or you would be the first native
>>> English speaker in my career that I fail to understand when
>>> communicating about Linux topics. (The only other explanations for that
>>> I can come up with are a) you suffer from dyslexia; or b) you write
>>> glibberish on purpose to annoy.)
>>>
>>> PSA: This is my last mail to you for this bug until you come up with a
>>> statement like:
>>>
>>> 	I tested Debian kernel image package version a.b.c-d and its
>>> 	broken with the following symptoms: [....]. The kernel image
>>> 	that occurs in the list on
>>> 	https://snapshot.debian.org/package/linux/ directly after that
>>> 	(i.e. version e.f.g-h) doesn't show these symptoms.
>> As if I need your messages with your dyslexia... :)
> I'm closing this bug along. If you can provide the above version
> please respond to this message with the required information and a
> control message to reopen the bugreport.
Are you read the post in the middle or only the end with the trash from Uwe?

Then read the part to which I have nothing to add!!!

> Kernel 5 what? E.g. which concrete version number? (output of uname -a).

user@debian:~$ cat /proc/version

Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
#1 SMP Debian 5.10.223-1 (2024-08-10)

--------------vz9g5CEUdckOBEo3hSGHSvyI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">26.11.25 10:06, Salvatore Bonaccorso:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:aSa1ECXKTkjM7_uv@eldamar.lan">
      <pre wrap="" class="moz-quote-pre">On Sat, Nov 22, 2025 at 07:40:33PM +0200, Roman Savochenko wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi, Uwe Kleine-König

22.11.25 19:22, Uwe Kleine-König:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">21.11.25 10:35, Uwe Kleine-König:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">20.11.25 10:38, Uwe Kleine-König:
</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">19.11.25 19:05, Uwe Kleine-König:
</pre>
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">12.11.25 17:03, Christian König:
</pre>
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">On 11/12/25 15:28, Roman Savochenko wrote:
</pre>
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">12.11.25 13:14, Uwe Kleine-König:
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">OK, and what do you want from me?
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">Quoting an earlier mail in that thread:

	Can you try which Debian kernel was the last one working fine
	respective the first being broken in this regard? You can find
	all kernels onhttps://snapshot.debian.org/. Please ask if it's
	unclear how to do that.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">I have told that as the kernel in Debian 11.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Is that the last working or the first broken?

The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
the last in buster-security which would be 5.10.244-1? Or do you mean
the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
think)?

The kernels before and after that are depending on what you meant above
5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?

The gist to take away here is: Don't specify kernel versions as "the one
in Debian 11" or "kernel 5" but use the proper kernel (package) version.
Everything else is too fuzzy for me to work with.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
And what that about when I have said that precisely???

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Kernel 5 what? E.g. which concrete version number? (output of uname -a).
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">user@debian:~$ cat /proc/version

Linux version 5.10.0-32-amd64 (<a class="moz-txt-link-abbreviated" href="mailto:debian-kernel@lists.debian.org">debian-kernel@lists.debian.org</a>) (gcc-10
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
#1 SMP Debian 5.10.223-1 (2024-08-10)

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Parts of the misunderstanding here might also be a language barrier. So
maybe try to get some help in the kernel community that speaks your
native tongue.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">So, English isn't native one for you? :)
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Right, and I doubt it's yours either. Or you would be the first native
English speaker in my career that I fail to understand when
communicating about Linux topics. (The only other explanations for that
I can come up with are a) you suffer from dyslexia; or b) you write
glibberish on purpose to annoy.)

PSA: This is my last mail to you for this bug until you come up with a
statement like:

	I tested Debian kernel image package version a.b.c-d and its
	broken with the following symptoms: [....]. The kernel image
	that occurs in the list on
	<a class="moz-txt-link-freetext" href="https://snapshot.debian.org/package/linux/">https://snapshot.debian.org/package/linux/</a> directly after that
	(i.e. version e.f.g-h) doesn't show these symptoms.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
As if I need your messages with your dyslexia... :)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I'm closing this bug along. If you can provide the above version
please respond to this message with the required information and a
control message to reopen the bugreport.</pre>
    </blockquote>
    Are you read the post in the middle or only the end with the trash
    from <span style="white-space: pre-wrap">Uwe</span>?<br>
    <p>Then read the part to which I have nothing to add!!!</p>
    <blockquote type="cite">
      <pre wrap="" class="moz-quote-pre">Kernel 5 what? E.g. which concrete version number? (output of uname -a).
</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">user@debian:~$ cat /proc/version

Linux version 5.10.0-32-amd64 (<a class="moz-txt-link-abbreviated" href="mailto:debian-kernel@lists.debian.org">debian-kernel@lists.debian.org</a>) (gcc-10
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
#1 SMP Debian 5.10.223-1 (2024-08-10)
</pre>
  </body>
</html>

--------------vz9g5CEUdckOBEo3hSGHSvyI--

--------------HnZjBtZsKVaor2IYccyi8Gou
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

--------------HnZjBtZsKVaor2IYccyi8Gou--
