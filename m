Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F0DC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377152176D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYA0vi8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377152176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065746EA1C;
	Tue, 18 Feb 2020 14:19:19 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226AF6EA1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:19:17 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n10so22205503wrm.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=YyUco8kXM1avZwWQNIEVp0EwDeqodFpYu/3bQR+eEWQ=;
 b=qYA0vi8F8upDBHMrDAKdeyBGWDyUei4V5H0Fn+1JPQbJagGwiUBPqgKHGz1/Gbab1t
 4gR8D0hti3m4b2iRVgIrtij8cnO9FBQBQUtGZzr2CuQXkAsa5fYB6GF9ZZBqZ5sFe1NG
 qs49kRWEVsOFWafFnOf+7VhPqF2rk0b2qye2Z178U2LnX4ugZWqvJoQPXxHu4nkVLVIE
 PBWLcaTDb8qTxlY6S2zcaoQrnOp4mY20bzALPptNRBWQf/UoLGaKfpIoZUG/zyqZmJCY
 /O64Oln16xH9iEj+twvVmRN1vvsyhrdzFnqS8hOtETiYM2mZo0zeG9tG2BcBwbLgDL1M
 QBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=YyUco8kXM1avZwWQNIEVp0EwDeqodFpYu/3bQR+eEWQ=;
 b=TmVxsN3vPUp+sqPU4qp5DyXsUfkObYO/LRXMNvKve6cu7CfqInm7sACpN9NBArUH3Q
 WhE7EBEYc4FgQP2zjq0z3o2LtUJJ8kbELr1WJG9FJTKDsbnBPUwVLQYLS/A2ia/SAFMv
 S5LQW3cbP3erzsyYxaXoJh81/pX+nZ2BqUlZrRrVq4YxbRqtxuYNEjjScPGhm/mrkDnT
 uwqOaWo1xTfVpdA1gbQZEDaytvj2fWiTaRcWK1yIh1v93aaLfcvvDbemWanJimo9hyUr
 TZK/yLCX2RMK8AKTYQjXJJdxXpYbIYlfuwOU+zrVZYFMIR2ma0k3WJoTEhbsT8ByElOO
 27tA==
X-Gm-Message-State: APjAAAUZIe/UhPO/5OmweHEEAhNqhL+ZJZEdOiY5cKB/bZkR8uU6kULL
 HUWs5PzFC56ZUeD6eer/gWE8g3NH
X-Google-Smtp-Source: APXvYqyNgQtn1XQeMOzK61T8zouu/i6KyjbeqjBkah6p2nfV4TbYfJ0CtFtp8PUdekTwsOG8oaHW/g==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr31146835wrw.276.1582035555504; 
 Tue, 18 Feb 2020 06:19:15 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x132sm3458991wmg.0.2020.02.18.06.19.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 06:19:15 -0800 (PST)
Subject: Re: writing custom driver for VGA emulation ?
To: "Bridgman, John" <John.Bridgman@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Yusuf_Alt=c4=b1parmak?= <yusufalti1997@gmail.com>
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
Date: Tue, 18 Feb 2020 15:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0018653986=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0018653986==
Content-Type: multipart/alternative;
 boundary="------------A982B8D9187B0A9BD35A0337"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A982B8D9187B0A9BD35A0337
Content-Type: text/plain; charset=iso-8859-3; format=flowed
Content-Transfer-Encoding: 8bit

The problem Yusuf runs into is that his platform has multiple PCIe root 
hubs, but only 512MB of MMIO address space. That is not enough to fit 
all the BARs of an E9171 into.

But without the BARs neither the VGA emulation nor amdgpu not anything 
else will work correctly.

And we already checked, 256MB is unfortunately the minimum you can 
resize the VRAM BAR on the E9171 to.

What could maybe work is to trick the upstream bridge of the VGA device 
into not routing all the addresses to the BARs and actually use only a 
smaller portion of visible VRAM. But that would be highly experimental 
and requires a rather big hack into the PCI(e) subsystem in the Linux 
kernel.

Regards,
Christian.

Am 18.02.20 um 15:08 schrieb Bridgman, John:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Does the VBIOS come up with something like a splash screen, ie is 
> VBIOS able to initialize and drive the card ?
>
> If so then another option might be to use a VESA driver rather than VGA.
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Alex Deucher <alexdeucher@gmail.com>
> *Sent:* February 18, 2020 8:50 AM
> *To:* Yusuf Alt¹parmak <yusufalti1997@gmail.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: writing custom driver for VGA emulation ?
> On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt¹parmak
> <yusufalti1997@gmail.com> wrote:
> >
> > Hello AMD team;
> >
> > I have E 9171 GPU and want to use it on a embedded system which has 
> limited MMIO space on PCIe bus (MAX 512 MB).
> >
> > I received feedbacks that I can only use VGA emulation with this 
> memory space. I was unable to get 'amdgpu' driver working with Xorg 
> due to I had many errors(firmwares are not loading) in each step and 
> tired of solving them one by one.
> >
> > I want to write a simple custom driver for this GPU with kernel 
> version 4.19.
> > Is it possible to print some colors on screen with a custom driver 
> over PCIe communication ? or writing some words on screen as VGA ?
> >
> > If answer is yes, then which code pieces (on amdgpu driver folder) 
> or reference documentation should I use? I have Register Reference 
> Guide.pdf.
> >
> > I will be appreciated for your guidance.
>
> That is not going to do what you want on your platform.  The VGA
> emulation requires that you set up the card first to enable it, which
> in turn requires MMIO access and thus you are back to square one.
>
> Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A982B8D9187B0A9BD35A0337
Content-Type: text/html; charset=iso-8859-3
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=ISO-8859-3">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The problem Yusuf runs into is that his
      platform has multiple PCIe root hubs, but only 512MB of MMIO
      address space. That is not enough to fit all the BARs of an E9171
      into.<br>
      <br>
      But without the BARs neither the VGA emulation nor amdgpu not
      anything else will work correctly.<br>
      <br>
      And we already checked, 256MB is unfortunately the minimum you can
      resize the VRAM BAR on the E9171 to.<br>
      <br>
      What could maybe work is to trick the upstream bridge of the VGA
      device into not routing all the addresses to the BARs and actually
      use only a smaller portion of visible VRAM. But that would be
      highly experimental and requires a rather big hack into the PCI(e)
      subsystem in the Linux kernel.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.02.20 um 15:08 schrieb Bridgman, John:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-3">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div>Does the VBIOS come up with something like a splash screen,
          ie is VBIOS able to initialize and drive the card ?<br>
        </div>
        <div><br>
        </div>
        <div>If so then another option might be to use a VESA driver
          rather than VGA. <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            <br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
              behalf of Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a><br>
              <b>Sent:</b> February 18, 2020 8:50 AM<br>
              <b>To:</b> Yusuf Alt¹parmak
              <a class="moz-txt-link-rfc2396E" href="mailto:yusufalti1997@gmail.com">&lt;yusufalti1997@gmail.com&gt;</a><br>
              <b>Cc:</b> amd-gfx list
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: writing custom driver for VGA
              emulation ?</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt">
                <div class="PlainText">On Tue, Feb 18, 2020 at 2:56 AM
                  Yusuf Alt¹parmak<br>
                  <a class="moz-txt-link-rfc2396E" href="mailto:yusufalti1997@gmail.com">&lt;yusufalti1997@gmail.com&gt;</a> wrote:<br>
                  &gt;<br>
                  &gt; Hello AMD team;<br>
                  &gt;<br>
                  &gt; I have E 9171 GPU and want to use it on a
                  embedded system which has limited MMIO space on PCIe
                  bus (MAX 512 MB).<br>
                  &gt;<br>
                  &gt; I received feedbacks that I can only use VGA
                  emulation with this memory space. I was unable to get
                  'amdgpu' driver working with Xorg due to I had many
                  errors(firmwares are not loading) in each step and
                  tired of solving them one by one.<br>
                  &gt;<br>
                  &gt; I want to write a simple custom driver for this
                  GPU with kernel version 4.19.<br>
                  &gt; Is it possible to print some colors on screen
                  with a custom driver over PCIe communication ? or
                  writing some words on screen as VGA ?<br>
                  &gt;<br>
                  &gt; If answer is yes, then which code pieces (on
                  amdgpu driver folder) or reference documentation
                  should I use? I have Register Reference Guide.pdf.<br>
                  &gt;<br>
                  &gt; I will be appreciated for your guidance.<br>
                  <br>
                  That is not going to do what you want on your
                  platform.  The VGA<br>
                  emulation requires that you set up the card first to
                  enable it, which<br>
                  in turn requires MMIO access and thus you are back to
                  square one.<br>
                  <br>
                  Alex<br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserved=0"
                    moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserved=0</a><br>
                </div>
              </span></font></div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------A982B8D9187B0A9BD35A0337--

--===============0018653986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0018653986==--
