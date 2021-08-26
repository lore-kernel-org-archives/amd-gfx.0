Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46AEC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48EA60F5B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A48EA60F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1986E86E;
	Thu, 26 Aug 2021 16:35:36 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA07F6E871
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1629995732;
 bh=J+ZJWRI573poFOOmV/ZVp9J7NOcIwGjeHGIcvugtFUc=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=lYQD6Ar85k1wRBGtovxgP/yHpA1ocpTEkPN5wNOCo9tR0xZ4K8oKB492yy8FRP1kP
 UGVf8NXt3wUi/0C0sy+V89qt1PvI6BuMNq2x+bVyycA3BkhfVY5UlwV3IqLneGCQa1
 XesaXRfCWNF2G3zIg5YzyFjQnbjoac+o62Z6L+kA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.100] ([95.91.0.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1mZjGq30tA-00Ik86 for
 <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 18:35:32 +0200
To: amd-gfx@lists.freedesktop.org
From: Paul <pb.g@gmx.de>
Subject: Set video resolution and refresh rate at boot?
Message-ID: <36cacbd4-8240-9713-6cea-68209757ed0b@gmx.de>
Date: Thu, 26 Aug 2021 18:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------EF73617E45CEB5C3B74FC931"
Content-Language: en-US
X-Provags-ID: V03:K1:VkETwGgQ44NUrPxvz3DaTQwoTBrTMtc6qaDErGa1pNzKBGhBpLQ
 4ANkdBitH51aZYoI7BRMjoRqpmJNaYi2Z+T2ZtHd9y0wNZippcvbadh79ddpuYrHOtRUb89
 yH8wUDs55YTg4QPw615j67MZKZg6Hr13wWd7Xb0cJQ7QlIp3A9cnsG9B8laaUb5gkdI7XwV
 9EWRKG6oSKoKFi0SNajRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XKVXJ4ze688=:uAyAo+jxRXdqnpNfMLTp60
 CtAyyY7HlPKAI2xbK/1ZDFtzNXsyBH79DiydyOYUQIuUj4AtWFfDXJZIW94PgDfK9W6BA5CHq
 oYw0uzf8sc1wY8zbLelGAmuschmO3PWXF/Gm+xIU3wqzPEQfYawk8iGtQL58bM/h6pJCNexFp
 1Y7kHoTofw9z7kN+LOCW29qMeqc9GgmGyGiaRCfpzoXUatYPBLkKkxt/9HI9x3sd3DJK0cqiQ
 6yy1slxauOjoGluiUfUjk9QFdaeiyIWAMe7sfWvmSrgZdisUsqqQpogk6bNeu2LMtC+p9BMd0
 ufFKdoyeUGo7FVFiRAXOcvx6ImCHCEs0IFLEsU49CF5Utfx0pU9UZqwDSAD2IntOUjClREcPg
 Wz4LKTQlITY83m9gnLWCXFIQ4IjythsBK57cSrI7YYZzRanVPrsZFYNZ160GIjHt7Me6BX/xB
 Q/fvcFSeZ4ssooKmU3XwLZmlc/mpRwS0qVvBBkYYLo+itmSy9pL74hURxIAZneSILnYRe0xRy
 1HcNJpogq5dLztZfYxiXOoZEjY1PsfcwwuHGLeHTHimstDAGfat+FEzwHuoUULkSznW1wtX+s
 VjtOUtG+XshSy8jNsMBbBEldLH57jR6Ouu89BFfY0qyE2tROMHQre1OaavEfIGEShwqqP6YEP
 JT+QtnRBdGuLRCrg9o92fVMw64MG/8AnFkEeBdTL9k6D7tHohlN2dwD/69gPEDXGUU/DlsTtF
 rFP3yJDcJOopRCs/vc/FGFQh3c68IPcM1N9oJruUFWYEQp5iaBLjiwZ3v8gZKtw3qKHOrcta0
 aKEXj9CV5ylGbAyKEalZ+mrJdUdItP1l2xrNGAKfEpCanrga4C/o3Z6cQu5Aa4VJhBTb7opqx
 OPI5mMn7beqB4o3oNFAGKwB0mJ8T6DzAJsxh3+KYtyjjApDqu6aHc94m2x88hiS+u1ZE6ZA9s
 ODv0Y6GffAMAy/mW4xbKmsOwZmfD+GG9Kr4CY2gAmHCz7a+toI0FlcuHtYuiSKKXHWAW862Wz
 g6So1QHHd1Yi+5w/5IEFrPdJbWE0P+0UdtFOrmKd058Ti3eXf46bhXtBZXjAgiG/zeC+uT8cX
 sCndcpqC26vvhTHrpI8Gd1Y9MFqZaaxcPb6
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
--------------EF73617E45CEB5C3B74FC931
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi there

Out of curiosity I would like to ask if it is possible to set a kernel
command line parameter for my Radeon 6900XT
that sets a specific resolution and refresh rate of a specific connected
monitor.

Ideally this parameter is set to the monitors used desktop (X11,
Wayland) resolution/refreshrate.

I did this for years with my Intel IGP's. I appended:

video=3DHDMI-A-1:1920x1080@50

to the kernel command line. This worked beautifully and the result was
my monitor was preconfigured to a specific resolution and refresh
rate from the first lines of the kernel to the desktop (X11) and it did
not had to switch to anything else in between.

Another nice side effect is when in X11 one switches to the console, or
vice versa, via STRG+Fx, pretty much everyone has this annoying delay
because
the monitor has to switch between refresh rates again. With that
preconfigured settings at boot this gave a very satisfying feeling,
especially if one frequently
switches between console and X11 (or wayland maybe).

Is this kind of parameter implemented in the kernel/amdgpu driver?



--------------EF73617E45CEB5C3B74FC931
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi there<br>
    <br>
    Out of curiosity I would like to ask if it is possible to set a
    kernel command line parameter for my Radeon 6900XT<br>
    that sets a specific resolution and refresh rate of a specific
    connected monitor. <br>
    <br>
    Ideally this parameter is set to the monitors used desktop (X11,
    Wayland) resolution/refreshrate.<br>
    <br>
    I did this for years with my Intel IGP's. I appended:<br>
    <br>
    video=HDMI-A-1:1920x1080@50<br>
    <br>
    to the kernel command line. This worked beautifully and the result
    was my monitor was preconfigured to a specific resolution and
    refresh<br>
    rate from the first lines of the kernel to the desktop (X11) and it
    did not had to switch to anything else in between.<br>
    <br>
    Another nice side effect is when in X11 one switches to the console,
    or vice versa, via STRG+Fx, pretty much everyone has this <span
      class="Y2IQFc" lang="en">annoying delay because<br>
      the monitor has to switch between refresh rates again. With that
      preconfigured settings at boot this gave a very satisfying
      feeling, especially if one frequently<br>
      switches between console and X11 (or wayland maybe).<br>
      <br>
      Is this kind of parameter implemented in the kernel/amdgpu driver?<br>
      <br>
      <br>
    </span>
  </body>
</html>

--------------EF73617E45CEB5C3B74FC931--
