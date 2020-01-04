Return-Path: <SRS0=l1g4=2Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684EC32767
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 22:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D656222C4
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 22:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbU/Hhr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D656222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2AD6E075;
	Sat,  4 Jan 2020 22:45:57 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE07F6E072
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2020 22:45:56 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id c16so36684294qko.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Jan 2020 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=xyQbjSULW2koVBcQzASaF4Q6gwQHtTsR2WutDkVFG4k=;
 b=bbU/Hhr3ZOeqnt8ok4R/kItOtvkEVg19+C5imQIjfxU2FYW7CE2ZHik8m9mfypv37i
 vYzEgcu4LLoSPUCS14/4ptVkTLwJX19M1INaouQyR79jy1sVlIiutZiY7BV5uhKAXXmy
 wYgI+cLlQWqs0tC2QcPAM+rxw/fBSSjk1BebFJp+/KCQr14VaWpLvnVeZRoGNqYgoPu+
 EK1W/fDSjvVx19J8sEnduzlpEVcouLl7582ozOxvfwO9SCZFBj+VsPCbP9PRAuWWkaIr
 BE4nnViLQJ9hD6+wapPYveuBhAEwGEOlvRt5ViSMY/k46uG2YBWt9SWj5nMrcM/WFpxz
 PkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=xyQbjSULW2koVBcQzASaF4Q6gwQHtTsR2WutDkVFG4k=;
 b=OjQUhnPJGgDD6ZQ8EygUoejJnCz1tH7NMrUM6g0ZSZaBHTOKCjiiGmw5zxTVaVI2IA
 E6QszbuVh2uDPVBmj+5oZstcnQtF1C8fs/g+sBCyXDd5+FSkrD6t8ewgq7sFGmNCPj83
 szeiOmu1Y0g0oYhMFQKO+WR1fjIQyAH+sXLfgNEz0acg0wDFmfhfppOhw85ui2YQQAMY
 lRJGy2wOtv+XKwhhgBpiuWBSWPfKWNiKTrCrmDfOcteaDM9nTRo9jAso38TNfSlZMaIR
 mEBHk6CYI9SdtagOmH63YQ8u6db88GF45qwej4r0ffSG9skjq6su86eYrlZ7GCLUV6LM
 Jk/w==
X-Gm-Message-State: APjAAAVmbu8yvGUIt5as5hVDkUf7jJE4awrGtIodn4P79nDg1vgR/CQy
 rwkfaO3ZTQyP5qehoBJEMDWsG4+b
X-Google-Smtp-Source: APXvYqxczvRUYtwEL1+29NBMdWax4IRBhyIz+XswkmOeuQtNq4KcC16xbr/jU2ySCKja36Os9yC2sA==
X-Received: by 2002:a37:de16:: with SMTP id h22mr76933676qkj.400.1578177955334; 
 Sat, 04 Jan 2020 14:45:55 -0800 (PST)
Received: from [10.0.0.132] ([38.74.25.253])
 by smtp.gmail.com with ESMTPSA id o10sm20369571qtp.38.2020.01.04.14.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 14:45:54 -0800 (PST)
Subject: Re: [RFC 0/7] UVD support for SI in amdgpu
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Matthew Taylor <mat@sharrow.me.uk>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com>
 <5f0ba91c-3234-9d27-cda9-af22ac781436@gmail.com>
 <MWHPR12MB13584BB86FC975D3A32F3A96F75C0@MWHPR12MB1358.namprd12.prod.outlook.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Message-ID: <c65c3ddd-49af-61a8-eaef-f5e682c4caf6@gmail.com>
Date: Sat, 4 Jan 2020 17:45:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB13584BB86FC975D3A32F3A96F75C0@MWHPR12MB1358.namprd12.prod.outlook.com>
Content-Language: en-US
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
Content-Type: multipart/mixed; boundary="===============1598296361=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1598296361==
Content-Type: multipart/alternative;
 boundary="------------CFB288A45F69EA3DE32BCCB4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CFB288A45F69EA3DE32BCCB4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,


As you may remember, I was working on porting VCE 1.0 to amdgpu around 
the time Piotr Redlewski sent the UVD patches. I would prefer to go the 
way proposed by Alex Deucher than to see SI support being dropped. I've 
been using the amdgpu on a 280X ever since it was possible. While there 
were some quirks in the beginning, it is plenty usable and performant 
ever since.


Also, using amdgpu comes with some benefits unavailable with the radeon 
driver on a gaming perspective.


Now, if my work on porting VCE 1.0 has stalled, it's because I'm now a 
father and I had only so little time to work on it. The code I was 
working on is still dormant (some of it was sent on my github repo) and 
I'm pretty sure I was almost done with it.


Please, don't drop SI support from amdgpu. If it was only for me, amdgpu 
would be the default driver over radeon and people missing the UVD and 
VCE features should be the ones overriding the default choice. But this 
may not work for the majority (I don't know) and I understand that 
radeon is still the default for GCN 1.0/1.1.


Cheers,

Alexandre Demers


On 2019-12-05 10:32, Deucher, Alexander wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> You could enable UVD support on amdgpu using the original firmware 
> from radeon, but you'd have to adjust the memory map on the GPU for SI 
> to match radeon.  So updated firmware is not a requirement per se, 
> it's just needed to keep the memory map the same as other GPUs.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Thursday, December 5, 2019 10:19 AM
> *To:* Matthew Taylor <mat@sharrow.me.uk>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [RFC 0/7] UVD support for SI in amdgpu
> Hi Matthew,
>
> Am 05.12.19 um 15:16 schrieb Matthew Taylor:
>> Hi,
>>
>> Back in November 2017, Piotr Redlewski, provided some patches for UVD 
>> support in the SI cards, the thread had the same subject as this 
>> message.
>>
>> The outcome of a conversation between himself and other developers on 
>> the list was to wait for something in updated firmware.  As this was 
>> over 2 years ago, I was wondering if the firmware has been updated 
>> sufficiently for Piotr's patches to be reconsidered or modified to 
>> deliver the UVD support for the SI cards?
>
> we discussed that internally quite lengthy and the firmware will 
> probably never be released.
>
> To be honest we actually considering dropping SI support completely 
> from amdgpu.
>
> Regards,
> Christian.
>
>>
>> Thanks for you help
>>
>> Kind Regards
>>
>> Matthew Taylor
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Calexander.deucher%40amd.com%7C14121ef4f0a049ddc3ea08d77996852f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637111559776723411&sdata=SpbvepoL17ImHwW7V5spbH46ze%2FNp7ll%2FqV86kE%2BBfU%3D&reserved=0>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------CFB288A45F69EA3DE32BCCB4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    <p>Hi there,</p>
    <p><br>
    </p>
    <p>As you may remember, I was working on porting VCE 1.0 to amdgpu
      around the time Piotr Redlewski sent the UVD patches. I would
      prefer to go the way proposed by Alex Deucher than to see SI
      support being dropped. I've been using the amdgpu on a 280X ever
      since it was possible. While there were some quirks in the
      beginning, it is plenty usable and performant ever since.<br>
    </p>
    <p><br>
    </p>
    <p> Also, using amdgpu comes with some benefits unavailable with the
      radeon driver on a gaming perspective.</p>
    <p><br>
    </p>
    <p>Now, if my work on porting VCE 1.0 has stalled, it's because I'm
      now a father and I had only so little time to work on it. The code
      I was working on is still dormant (some of it was sent on my
      github repo) and I'm pretty sure I was almost done with it.</p>
    <p><br>
    </p>
    <p>Please, don't drop SI support from amdgpu. If it was only for me,
      amdgpu would be the default driver over radeon and people missing
      the UVD and VCE features should be the ones overriding the default
      choice. But this may not work for the majority (I don't know) and
      I understand that radeon is still the default for GCN 1.0/1.1.<br>
    </p>
    <p><br>
    </p>
    <p>Cheers,</p>
    <p>Alexandre Demers<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2019-12-05 10:32, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR12MB13584BB86FC975D3A32F3A96F75C0@MWHPR12MB1358.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          You could enable UVD support on amdgpu using the original
          firmware from radeon, but you'd have to adjust the memory map
          on the GPU for SI to match radeon.  So updated firmware is not
          a requirement per se, it's just needed to keep the memory map
          the same as other GPUs.<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Thursday, December 5, 2019 10:19 AM<br>
            <b>To:</b> Matthew Taylor <a class="moz-txt-link-rfc2396E" href="mailto:mat@sharrow.me.uk">&lt;mat@sharrow.me.uk&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [RFC 0/7] UVD support for SI in amdgpu</font>
          <div> </div>
        </div>
        <div style="background-color:#FFFFFF">
          <div class="x_moz-cite-prefix">Hi Matthew,<br>
            <br>
            Am 05.12.19 um 15:16 schrieb Matthew Taylor:<br>
          </div>
          <blockquote type="cite">
            <div dir="ltr">Hi,
              <div><br>
              </div>
              <div>Back in November 2017, Piotr Redlewski, provided some
                patches for UVD support in the SI cards, the thread had
                the same subject as this message.  <br>
                <br>
                The outcome of a conversation between himself and other
                developers on the list was to wait for something in
                updated firmware.  As this was over 2 years ago, I was
                wondering if the firmware has been updated sufficiently
                for Piotr's patches to be reconsidered or modified to
                deliver the UVD support for the SI cards?</div>
            </div>
          </blockquote>
          <br>
          we discussed that internally quite lengthy and the firmware
          will probably never be released.<br>
          <br>
          To be honest we actually considering dropping SI support
          completely from amdgpu.<br>
          <br>
          Regards,<br>
          Christian. <br>
          <br>
          <blockquote type="cite">
            <div dir="ltr">
              <div><br>
              </div>
              <div>Thanks for you help</div>
              <div><br>
              </div>
              <div>Kind Regards</div>
              <div><br>
              </div>
              <div>Matthew Taylor</div>
            </div>
            <br>
            <fieldset class="x_mimeAttachmentHeader"></fieldset>
            <pre class="x_moz-quote-pre">_______________________________________________
amd-gfx mailing list
<a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="x_moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C14121ef4f0a049ddc3ea08d77996852f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637111559776723411&amp;sdata=SpbvepoL17ImHwW7V5spbH46ze%2FNp7ll%2FqV86kE%2BBfU%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="ix2l/Ei3jxaUf+VCZrqMzMZo1IeB5gh5yA9VEl3kmHv5l4PjNWqRSEOMMYeKS7zIkjea7nAUCerC+6T2EaY6nP/ZGQqHYuCXGHbM2aaaeOPYFcsZS0I+GCGncMv5+/eD6fzCAiOMyKmCtyO95P03R98vcWrfnED+HqNZjd3U0As=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
          </blockquote>
          <br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
  </body>
</html>

--------------CFB288A45F69EA3DE32BCCB4--

--===============1598296361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1598296361==--
