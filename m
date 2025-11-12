Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D63BCD5BA0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435E210E60F;
	Thu, 13 Nov 2025 08:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="VP19IUCy";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC7810E16F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 14:28:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 775A343D4;
 Wed, 12 Nov 2025 16:28:20 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id XBiLqqjmGt02; Wed, 12 Nov 2025 16:28:19 +0200 (EET)
Received: from [192.168.1.2] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id CBE947E6;
 Wed, 12 Nov 2025 16:28:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1762957699;
 bh=v1Icn+9AzLxGn77KaD3Vdp4CLW+Dyr2lD7c43wflqsA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VP19IUCy/BoP52TI0MFi+P3yKXan+55qVOBE4bDOBCX9yxQgd2MQ5CVAiXtY2Gaco
 AqsrGPOISrk6FQRxyxKY86Whg+jmkOrAP8C4tzV13zHpEcOrKG5NlIkR6R86Gilu20
 UWkR3HNFRVicJCPUSFHycwuAvFWwbyMO0ZqKu7xllBkc7vltG6a+cbrtu0ddnkca4v
 c2zCWLbddivN2q3E336PD+sQXL6mm5VJ2lHvo/+G1xC2F+PJLUVnWYClBCeB8ogVdw
 XY47CiJ8IHfOJ2qrf/hMih7GzcX56Xb3i6jVcNculNi/+NV8S3IWglD0OygkiB7B4S
 TkrxmoGUKv/pg==
Content-Type: multipart/mixed; boundary="------------cZJWr5Z4oYPpcdixFpoFIAYM"
Message-ID: <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
Date: Wed, 12 Nov 2025 16:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1118349@bugs.debian.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:36:11 +0000
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
--------------cZJWr5Z4oYPpcdixFpoFIAYM
Content-Type: multipart/alternative;
 boundary="------------huMbFv1B3XO80Cty1eCrhA0k"

--------------huMbFv1B3XO80Cty1eCrhA0k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

12.11.25 13:14, Uwe Kleine-König:
>> On my hardware that doesn't work and there is no specific.
>>
>> Now just I set "radeon.dpm=1", I got immediately restart with disabling USB,
>> so I have needed to restart for successful download with "radeon.dpm=0".
> Can you try a different monitor?

I have only one, connected through DVI, and there is no problem on Linux 
Kernel 5.

> Can you try which Debian kernel was the last one working fine respective
> the first being broken in this regard? You can find all kernels on
> https://snapshot.debian.org/. Please ask if it's unclear how to do that.

I can try all kernels in Debian starting 7 and finishing 13, but I have 
traced that before and the problem reproduction started from Debian 9, 
terminated on Debian 11 and renewed on Debian 12.

Say which Debian version you need to try.

Regards, Roman

--------------huMbFv1B3XO80Cty1eCrhA0k
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">12.11.25 13:14, Uwe Kleine-König:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On my hardware that doesn't work and there is no specific.

Now just I set "radeon.dpm=1", I got immediately restart with disabling USB,
so I have needed to restart for successful download with "radeon.dpm=0".
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Can you try a different monitor?</pre>
    </blockquote>
    <p>I have only one, connected through DVI, and there is no problem
      on Linux Kernel 5.</p>
    <blockquote type="cite"
cite="mid:2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn">
      <pre wrap="" class="moz-quote-pre">Can you try which Debian kernel was the last one working fine respective
the first being broken in this regard? You can find all kernels on
<a class="moz-txt-link-freetext" href="https://snapshot.debian.org/">https://snapshot.debian.org/</a>. Please ask if it's unclear how to do that.</pre>
    </blockquote>
    <p>I can try all kernels in Debian starting 7 and finishing 13, but
      I have traced that before and the problem reproduction started
      from Debian 9, terminated on Debian 11 and renewed on Debian 12.</p>
    <p>Say which Debian version you need to try.</p>
    <p>Regards, Roman</p>
  </body>
</html>

--------------huMbFv1B3XO80Cty1eCrhA0k--

--------------cZJWr5Z4oYPpcdixFpoFIAYM
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

--------------cZJWr5Z4oYPpcdixFpoFIAYM--
