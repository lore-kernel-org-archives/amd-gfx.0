Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E5FC48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 14:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D678D10E2E3;
	Mon, 19 Feb 2024 14:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=riadoklan.sk.eu.org header.i=@riadoklan.sk.eu.org header.b="Whwhor+H";
	dkim-atps=neutral
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Mon, 19 Feb 2024 11:37:50 UTC
Received: from server.riadoklan.sk.eu.org (server.riadoklan.sk.eu.org
 [195.3.170.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D25A10E33C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riadoklan.sk.eu.org;
 s=default; t=1708342301;
 bh=MdlDS4gOONiGZrqzrfXKFG3rY+0FapLieYFOKs2EyE8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Whwhor+HccEYUB/1iZYtwni5MZKp+azwsGgjdH64VbeUrelc32kyX60eK7i32EqbV
 LwEYbsC4Xrd/gFIy5Ks3DqmXPOy3WqIqrUvJWSaHtlNxlqi72FX0/RIP3SP9qvDwjN
 xSbpKc+QrtXKJPcPQE/ysltcp9S+ZXG8ak2KQvI4=
Content-Type: multipart/alternative;
 boundary="------------OmrCV2dXlZSkw7RLXOA0ILdr"
Message-ID: <6f8ddf36-b34f-4861-9f33-7e5f28be4c00@riadoklan.sk.eu.org>
Date: Mon, 19 Feb 2024 12:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
From: Roman Benes <benes@riadoklan.sk.eu.org>
In-Reply-To: <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
X-Mailman-Approved-At: Mon, 19 Feb 2024 14:47:18 +0000
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
--------------OmrCV2dXlZSkw7RLXOA0ILdr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

patch by user @fililip was posted there, but not submitted:

/"I think I'd have to submit it to the linux kernel mailing list, which 
I am kinda scared of 😅. It could be better to submit that patch to Arch 
Linux maintainers; they could include it in their kernel builds."/

Implementation of this patch can be simplified by simply setting:

|smu->min_power_limit = amdgpu_ignore_min_pcap ? 0 : 
whatever_default_smuxx;|

and then leave rest of the code unchanged(except defining 
|amdgpu_ignore_min_pcap |variable of course). Nothing tricky nor need to 
revert anything should be needed I hope. Please add it to the general 
kernel as an option, it certainly should not be related to Archlinux only.

Roman


On 2/19/24 12:15, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 17.02.24 14:30, Greg KH wrote:
>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>> even for root. This is not of above apps issue but of the kernel, I read
>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>> kernel and my 115W(under power)cap work again as before.
>> Any chance you can use 'git bisect' to figure out the offending change?
> For the record and everyone that lands here: the cause is known now
> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
> value") [v6.7-rc1]) and the issue afaics tracked here:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>
> Other mentions:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>
> Haven't seen any statement from the amdgpu developers (now CCed) yet on
> this there (but might have missed something!). From what I can see I
> assume this will likely be somewhat tricky to handle, as a revert
> overall might be a bad idea here. We'll see I guess.
>
> Roman posted something that apparently was meant to go to the list, so
> let me put it here:
>
> """
> UPDATE: User fililip already posted patch, but it need to be merged,
> discussion is on gitlab link below.
>
> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>
>
>> it seems that commit was already found(see user's 'fililip' comment):
>>
>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>> Author: Ma Jun<Jun.Ma2@amd.com>
>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>
>>      drm/amd/pm: Support for getting power1_cap_min value
>>
>>      Support for getting power1_cap_min value on smu13 and smu11.
>>      For other Asics, we still use 0 as the default value.
>>
>>      Signed-off-by: Ma Jun<Jun.Ma2@amd.com>
>>      Reviewed-by: Kenneth Feng<kenneth.feng@amd.com>
>>      Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>
>> However, this is not good as it remove under-powering range too far. I
> was getting only about 7% less performance but 90W(!) less consumption
> when set to my 115W before. Also I wonder if we as a OS of options and
> freedom have to stick to such very high reference for min values without
> ability to override them through some sys ctrls. Commit was done by amd
> guy and I wonder if because of maybe this post that I made few months
> ago(business strategy?):
>>
> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>> This is not a dangerous OC upwards where I can understand desire to
> protect HW, it is downward, having min cap at 190W when card pull on
> 115W almost same speed is IMO crazy to deny. We don't talk about default
> or reference values here either, just a move to lower the range of
> options for whatever reason.
>> I don't know how much power you guys have over them, but please
> consider either reverting this change, or give us an option to set
> min_cap through say /sys (right now param is readonly, even for root).
>>
>> Thank you in advance for looking into this, with regards:  Romano
> """
>
> And while at it, let me add this issue to the tracking as well
>
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
>
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
>
> #regzbot introduced 1958946858a62b /
> #regzbot title drm: amdgpu: under-powering broke
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
--------------OmrCV2dXlZSkw7RLXOA0ILdr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello everyone,</p>
    <p>patch by user @fililip was posted there, but not submitted:</p>
    <p><i><font face="monospace">"I think I'd have to submit it to the
          linux kernel mailing list, which I am kinda scared of 😅.
          It could be better to submit that patch to Arch Linux
          maintainers; they could include it in their kernel builds."</font></i></p>
    <p>Implementation of this patch can be simplified by simply setting:</p>
    <p><code>smu-&gt;min_power_limit = amdgpu_ignore_min_pcap ? 0 :
        whatever_default_smuxx;</code></p>
    <p>and then leave rest of the code unchanged(except defining <code>amdgpu_ignore_min_pcap
      </code>variable of course). Nothing tricky nor need to revert
      anything should be needed I hope. Please add it to the general
      kernel as an option, it certainly should not be related to
      Archlinux only. <br>
    </p>
    <p>Roman<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/19/24 12:15, Linux regression
      tracking (Thorsten Leemhuis) wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info">
      <pre class="moz-quote-pre" wrap="">On 17.02.24 14:30, Greg KH wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
mesa, archlinux) and I cannot get power cap as low as before(to 115W),
neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
even for root. This is not of above apps issue but of the kernel, I read
similar issues from other bug reports of above apps. I downgraded to v6.6.10
kernel and my 115W(under power)cap work again as before.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Any chance you can use 'git bisect' to figure out the offending change?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For the record and everyone that lands here: the cause is known now
(it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
value") [v6.7-rc1]) and the issue afaics tracked here:

<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3183">https://gitlab.freedesktop.org/drm/amd/-/issues/3183</a>

Other mentions:
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3137">https://gitlab.freedesktop.org/drm/amd/-/issues/3137</a>
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2992">https://gitlab.freedesktop.org/drm/amd/-/issues/2992</a>

Haven't seen any statement from the amdgpu developers (now CCed) yet on
this there (but might have missed something!). From what I can see I
assume this will likely be somewhat tricky to handle, as a revert
overall might be a bad idea here. We'll see I guess.

Roman posted something that apparently was meant to go to the list, so
let me put it here:

"""
UPDATE: User fililip already posted patch, but it need to be merged,
discussion is on gitlab link below.

(PS: I hope I am replying correctly to "all" now? - using original addr.)


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">it seems that commit was already found(see user's 'fililip' comment):

<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3183">https://gitlab.freedesktop.org/drm/amd/-/issues/3183</a>
commit 1958946858a62b6b5392ed075aa219d199bcae39
Author: Ma Jun <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a>
Date:   Thu Oct 12 09:33:45 2023 +0800

    drm/amd/pm: Support for getting power1_cap_min value

    Support for getting power1_cap_min value on smu13 and smu11.
    For other Asics, we still use 0 as the default value.

    Signed-off-by: Ma Jun <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a>
    Reviewed-by: Kenneth Feng <a class="moz-txt-link-rfc2396E" href="mailto:kenneth.feng@amd.com">&lt;kenneth.feng@amd.com&gt;</a>
    Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

However, this is not good as it remove under-powering range too far. I
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">was getting only about 7% less performance but 90W(!) less consumption
when set to my 115W before. Also I wonder if we as a OS of options and
freedom have to stick to such very high reference for min values without
ability to override them through some sys ctrls. Commit was done by amd
guy and I wonder if because of maybe this post that I made few months
ago(business strategy?):
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/">https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/</a>
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This is not a dangerous OC upwards where I can understand desire to
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">protect HW, it is downward, having min cap at 190W when card pull on
115W almost same speed is IMO crazy to deny. We don't talk about default
or reference values here either, just a move to lower the range of
options for whatever reason.
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
I don't know how much power you guys have over them, but please
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">consider either reverting this change, or give us an option to set
min_cap through say /sys (right now param is readonly, even for root).
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Thank you in advance for looking into this, with regards:  Romano
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">"""

And while at it, let me add this issue to the tracking as well

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot introduced 1958946858a62b /
#regzbot title drm: amdgpu: under-powering broke

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
<a class="moz-txt-link-freetext" href="https://linux-regtracking.leemhuis.info/about/#tldr">https://linux-regtracking.leemhuis.info/about/#tldr</a>
That page also explains what to do if mails like this annoy you.
</pre>
    </blockquote>
  </body>
</html>

--------------OmrCV2dXlZSkw7RLXOA0ILdr--
