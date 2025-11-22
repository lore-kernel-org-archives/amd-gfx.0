Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253B3CFD31D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B6810E1DF;
	Mon, 24 Nov 2025 08:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="UchUYN6+";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43A210E052
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 17:40:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 9ABDF43E4;
 Sat, 22 Nov 2025 19:40:34 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BmC1WQySLl9r; Sat, 22 Nov 2025 19:40:33 +0200 (EET)
Received: from [192.168.1.2] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id 3F41243D2;
 Sat, 22 Nov 2025 19:40:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1763833233;
 bh=lXIbgD65/29T1bpd19I4aGUSVq6SR85koHnCbjF5NX8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UchUYN6+rLYJ38llPOXPGoQaMdou6eW8IC4VaqLSqvNrZw4qAL5z5Um/dxlQ8AI2w
 caPS0/sYZLym+wcMQTqpc9+vXYjwlQbluCcns1z+niufTrAd5QJ1JutUel8CcVG1eZ
 0UPARfO8/H6pHGrYzxhWQ6i/G1tvMlLbL/feKXT8csU/gqS4jdWeXeXNOu9Q3H+URi
 LH3IliNv9JAhrp7uObYSq4P20VyhrmByRA/FxES6VR4CFOck1hYh/6FQaL51ki5VcO
 IdbhFjTwbDnNEhv2LW0KkMUNF7a+2zUW4ssw/bM34kWCwnrHswLIpjbk6eHNKpg3UC
 2BOSh9Org9kPw==
Content-Type: multipart/mixed; boundary="------------gZ0KBTT0Xd4kjM108bV7CKlD"
Message-ID: <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
Date: Sat, 22 Nov 2025 19:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: 1118349@bugs.debian.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
 <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
Content-Language: uk-UA
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
X-Mailman-Approved-At: Mon, 24 Nov 2025 08:12:45 +0000
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
--------------gZ0KBTT0Xd4kjM108bV7CKlD
Content-Type: multipart/alternative;
 boundary="------------UQLz9p9Ej39mRMVLStLTNDNG"

--------------UQLz9p9Ej39mRMVLStLTNDNG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Uwe Kleine-König

22.11.25 19:22, Uwe Kleine-König:
> On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
>> 21.11.25 10:35, Uwe Kleine-König:
>>> On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
>>>> 20.11.25 10:38, Uwe Kleine-König:
>>>>> On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
>>>>>> 19.11.25 19:05, Uwe Kleine-König:
>>>>>>> On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
>>>>>>>> 12.11.25 17:03, Christian König:
>>>>>>>>> On 11/12/25 15:28, Roman Savochenko wrote:
>>>>>>>>>> 12.11.25 13:14, Uwe Kleine-König:
>>>> OK, and what do you want from me?
>>> Quoting an earlier mail in that thread:
>>>
>>> 	Can you try which Debian kernel was the last one working fine
>>> 	respective the first being broken in this regard? You can find
>>> 	all kernels onhttps://snapshot.debian.org/. Please ask if it's
>>> 	unclear how to do that.
>> I have told that as the kernel in Debian 11.
> Is that the last working or the first broken?
>
> The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
> the last in buster-security which would be 5.10.244-1? Or do you mean
> the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
> think)?
>
> The kernels before and after that are depending on what you meant above
> 5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
> 5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?
>
> The gist to take away here is: Don't specify kernel versions as "the one
> in Debian 11" or "kernel 5" but use the proper kernel (package) version.
> Everything else is too fuzzy for me to work with.

And what that about when I have said that precisely???

> Kernel 5 what? E.g. which concrete version number? (output of uname -a).
user@debian:~$ cat /proc/version

Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10 
(Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 
2.35.2) #1 SMP Debian 5.10.223-1 (2024-08-10)

>>>> Must I say you the exact commit or what,
>>>> or you are waiting I must recompile all kernels with 294457 commits?
>>>>
>>>> I say you in what way the problem related through the stable kernels in
>>>> Debian releases and that is exactly assigned to the major versions of the
>>>> Linux kernel, even for broken v5.19 which can include backports from 6!
>>> Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
>>> several years of development each and thus are not helpful to locate the
>>> change that broke your setup. Unless it is really 5.19 that was good and
>>> 6.0 that is bad which limits the amount of changes from:
>> I keep talking that only for understanding the problem depth and not for
>> fixing that in 4 kernels!
>>
>> That is, there can be simpler to apply that workaround.
>>
>>> . This is still a lot and we might ask you to do more tests to further
>>> limit the set of candidate commits that are broken on your end.
>> OK, ask.
> That depends on the answers for the questions I already asked and that
> are still not answered in a way that I can ask the followup questions.

Reread the stream then!

>>>>> Can you please confirm that 5.19.x (e.g. a kernel package from
>>>>> https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
>>>>> 6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
>>>>> doesn't? (Or a similar statement with other consecutive mainline
>>>>> versions.)
>>>> 5.19.0 has this problem in view of hanging.
>>> You lost me here. What is "problem in view of hanging"? Are we talking
>>> about more than one problem? Or different variants of the same problem?
>> We talk about different variants, and the hanging I saw also on one 6 kernel
>> just after installing Debian 13 and that is why #1118349 I opened about the
>> hanging but not rebooting in the initial report #879992.
> Here is our language problem again. I fail to parse that sentence.

Reread the first message then:

>  From Debian 12 (any Linux kernel 6) and now in Debian 13 it is obligatory
> reproducing not as restarting but freezing with black screen and on any kernel
> 6 version (also 6.16.3+deb13-amd64).
>> To help for other with same hardware, since I can fix that for myself if I
>> need.
> ??
??
>>> For now your problem report isn't in a form that I can act upon. So it's in your interest to provide the
>>> information that I ask for. If you don't want to do that, that's fine,
>>> and I won't have sleepless nights about it. The likely outcome is that
>>> the problem isn't addressed.
>> Whether I don't provide you all information beyond "get my hand in the
>> dirty"? :)
> ??
??
>>> Parts of the misunderstanding here might also be a language barrier. So
>>> maybe try to get some help in the kernel community that speaks your
>>> native tongue.
>> So, English isn't native one for you? :)
> Right, and I doubt it's yours either. Or you would be the first native
> English speaker in my career that I fail to understand when
> communicating about Linux topics. (The only other explanations for that
> I can come up with are a) you suffer from dyslexia; or b) you write
> glibberish on purpose to annoy.)
>
> PSA: This is my last mail to you for this bug until you come up with a
> statement like:
>
> 	I tested Debian kernel image package version a.b.c-d and its
> 	broken with the following symptoms: [....]. The kernel image
> 	that occurs in the list on
> 	https://snapshot.debian.org/package/linux/ directly after that
> 	(i.e. version e.f.g-h) doesn't show these symptoms.

As if I need your messages with your dyslexia... :)

--------------UQLz9p9Ej39mRMVLStLTNDNG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi, Uwe Kleine-König</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">22.11.25 19:22, Uwe Kleine-König:<br>
    </div>
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
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
	all kernels on <a class="moz-txt-link-freetext" href="https://snapshot.debian.org/">https://snapshot.debian.org/</a>. Please ask if it's
	unclear how to do that.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I have told that as the kernel in Debian 11.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Is that the last working or the first broken?

The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
the last in buster-security which would be 5.10.244-1? Or do you mean
the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
think)?

The kernels before and after that are depending on what you meant above
5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?

The gist to take away here is: Don't specify kernel versions as "the one
in Debian 11" or "kernel 5" but use the proper kernel (package) version.
Everything else is too fuzzy for me to work with.</pre>
    </blockquote>
    <p>And what that about when I have said that precisely???</p>
    <blockquote type="cite"
      cite="mid:931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com">
      <pre wrap="" class="moz-quote-pre">Kernel 5 what? E.g. which concrete version number? (output of uname -a).</pre>
    </blockquote>
    user@debian:~$ cat /proc/version<br>
    <p>Linux version 5.10.0-32-amd64 (<a
        class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:debian-kernel@lists.debian.org">debian-kernel@lists.debian.org</a>)
      (gcc-10 (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils
      for Debian) 2.35.2) #1 SMP Debian 5.10.223-1 (2024-08-10)</p>
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Must I say you the exact commit or what,
or you are waiting I must recompile all kernels with 294457 commits?

I say you in what way the problem related through the stable kernels in
Debian releases and that is exactly assigned to the major versions of the
Linux kernel, even for broken v5.19 which can include backports from 6!
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
several years of development each and thus are not helpful to locate the
change that broke your setup. Unless it is really 5.19 that was good and
6.0 that is bad which limits the amount of changes from:
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I keep talking that only for understanding the problem depth and not for
fixing that in 4 kernels!

That is, there can be simpler to apply that workaround.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">. This is still a lot and we might ask you to do more tests to further
limit the set of candidate commits that are broken on your end.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
OK, ask.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">That depends on the answers for the questions I already asked and that
are still not answered in a way that I can ask the followup questions.</pre>
    </blockquote>
    <p>Reread the stream then!</p>
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Can you please confirm that 5.19.x (e.g. a kernel package from
<a class="moz-txt-link-freetext" href="https://snapshot.debian.org/package/linux/5.19.11-1/">https://snapshot.debian.org/package/linux/5.19.11-1/</a>) works fine and
6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
doesn't? (Or a similar statement with other consecutive mainline
versions.)
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">5.19.0 has this problem in view of hanging.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">You lost me here. What is "problem in view of hanging"? Are we talking
about more than one problem? Or different variants of the same problem?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We talk about different variants, and the hanging I saw also on one 6 kernel
just after installing Debian 13 and that is why #1118349 I opened about the
hanging but not rebooting in the initial report #879992.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Here is our language problem again. I fail to parse that sentence.</pre>
    </blockquote>
    <p>Reread the first message then:</p>
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <pre wrap="" class="moz-quote-pre">From Debian 12 (any Linux kernel 6) and now in Debian 13 it is obligatory
reproducing not as restarting but freezing with black screen and on any kernel
6 version (also 6.16.3+deb13-amd64).</pre>
    </blockquote>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">To help for other with same hardware, since I can fix that for myself if I
need.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">??</pre>
    </blockquote>
    ??
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">For now your problem report isn't in a form that I can act upon. So it's in your interest to provide the
information that I ask for. If you don't want to do that, that's fine,
and I won't have sleepless nights about it. The likely outcome is that
the problem isn't addressed.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Whether I don't provide you all information beyond "get my hand in the
dirty"? :)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">??</pre>
    </blockquote>
    ??
    <blockquote type="cite"
cite="mid:ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Parts of the misunderstanding here might also be a language barrier. So
maybe try to get some help in the kernel community that speaks your
native tongue.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
So, English isn't native one for you? :)
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
	(i.e. version e.f.g-h) doesn't show these symptoms.</pre>
    </blockquote>
    <p>As if I need your messages with your <span
      style="white-space: pre-wrap">dyslexia... :)</span></p>
  </body>
</html>

--------------UQLz9p9Ej39mRMVLStLTNDNG--

--------------gZ0KBTT0Xd4kjM108bV7CKlD
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

--------------gZ0KBTT0Xd4kjM108bV7CKlD--
