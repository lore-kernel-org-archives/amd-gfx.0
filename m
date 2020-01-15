Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F969C33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 03:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6965C206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 03:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6965C206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC7489EA9;
	Wed, 15 Jan 2020 03:45:23 +0000 (UTC)
Received: from mx0-9.i-mecca.net (mx0-11.i-mecca.net [76.74.184.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FF989EA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 03:45:21 +0000 (UTC)
Received: from mx0.ehosting.ca (localhost [127.0.0.1])
 by mx0.i-mecca.net (Postfix) with ESMTP id 1ED6E161874;
 Tue, 14 Jan 2020 19:45:21 -0800 (PST)
Received: from ns14.i-mecca.net (unknown [192.168.1.14])
 by mx0.i-mecca.net (Postfix) with ESMTP id 4D8E916143E;
 Tue, 14 Jan 2020 19:45:20 -0800 (PST)
X-MES: 1.0
Received: from [10.0.9.242] (unknown [184.69.65.194])
 by ns14.i-mecca.net (Postfix) with ESMTPSA id 0735014043E;
 Tue, 14 Jan 2020 19:45:19 -0800 (PST)
Subject: Re: [follow-up] AMD Sensir Fusion HUB status
To: Mihai <xanto@egaming.ro>
References: <53045edd-ac1b-d928-0e3e-e683f34be1ce@fedoraproject.org>
 <CAPib=sPG5rcX67Vk0Lhkv=nHcZeEsUn+MFaCsjDmEfBiybzEDQ@mail.gmail.com>
From: Luya Tshimbalanga <luya@fedoraproject.org>
Organization: Fedora Project
Message-ID: <f9ecd9b6-34e0-b47c-3df4-ecf203b0646e@fedoraproject.org>
Date: Tue, 14 Jan 2020 19:45:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPib=sPG5rcX67Vk0Lhkv=nHcZeEsUn+MFaCsjDmEfBiybzEDQ@mail.gmail.com>
Content-Language: en-CA
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2092177799=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2092177799==
Content-Type: multipart/alternative;
 boundary="------------EB02A634DFB17C3390529763"
Content-Language: en-CA

This is a multi-part message in MIME format.
--------------EB02A634DFB17C3390529763
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the update!

On 2020-01-11 1:16 a.m., Mihai wrote:
> Finally arrived: 
> https://patchwork.kernel.org/project/linux-iio/list/?submitter=175589
>
> On Fri, Dec 13, 2019, 5:25 PM Luya Tshimbalanga 
> <luya@fedoraproject.org <mailto:luya@fedoraproject.org>> wrote:
>
>     Any update about the Sensor Fusion HUB status? Thanks.
>
>     -- 
>     Luya Tshimbalanga
>     Fedora Design Team
>     Fedora Design Suite maintainer
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer


--------------EB02A634DFB17C3390529763
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Thanks for the update!<br>
    </p>
    <div class="moz-cite-prefix">On 2020-01-11 1:16 a.m., Mihai wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPib=sPG5rcX67Vk0Lhkv=nHcZeEsUn+MFaCsjDmEfBiybzEDQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Finally arrived: <a
href="https://patchwork.kernel.org/project/linux-iio/list/?submitter=175589"
          moz-do-not-send="true">https://patchwork.kernel.org/project/linux-iio/list/?submitter=175589</a></div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Dec 13, 2019, 5:25 PM
          Luya Tshimbalanga &lt;<a href="mailto:luya@fedoraproject.org"
            moz-do-not-send="true">luya@fedoraproject.org</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Any update
          about the Sensor Fusion HUB status? Thanks.<br>
          <br>
          -- <br>
          Luya Tshimbalanga<br>
          Fedora Design Team<br>
          Fedora Design Suite maintainer<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank"
            rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          <a
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            rel="noreferrer noreferrer" target="_blank"
            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        </blockquote>
      </div>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer</pre>
  </body>
</html>

--------------EB02A634DFB17C3390529763--

--===============2092177799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2092177799==--
