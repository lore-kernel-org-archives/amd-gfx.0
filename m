Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E797C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 17:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3176720661
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 17:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3176720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rixotstudio.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1DC6FA04;
	Thu, 30 Jan 2020 17:39:46 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81266E8A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 17:18:24 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id a5so4648895wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 09:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dXEuf4XxwH7j2CVNpIc2fKLMMdKwu+lrY8XTb7TSyf8=;
 b=L1DXMlHkCPOFQ0nLQRFAZxbx9pJ/Fpjcs4ogPB5KDqcuJUmcb/wJjBI8vsb3KHYKUU
 F4xi9QzAukz0rg7BgPyxlQqCy12ykX3BjVM4umRtpEPSF2FYSXyBI2nfmq78M+tmwiRb
 O9aBFQVX56+uSuRh5nh/wH1HtlSEXWGlFO6YXpPQtvVQjbtPlWwn30N3akavv4QwYHu7
 oDmAFlEvdOyJ0tUm4I/hcLIgfW1G1XJ9mBs9HElbZFp5aDehiNFC6ztfyaf8D1BotsQ9
 lN/9n0N0BZhnKniuKlMzhVPEKBJ+NQMEwkbUHgCCNz9Wef5DZkLbOyOtHzyO428QJ2vC
 owqg==
X-Gm-Message-State: APjAAAWPceJxabTI5DuIHr7KZR8lVcuhNziFHWZmHOO2a5bSIVvupkjq
 jD3w1BpcDV5FBSJuv0yatafYC6vz6wD4nC6AJZMAoeErZvou0w==
X-Google-Smtp-Source: APXvYqy1veN2gkwvZKv9/eoj0Kjj4LxhL/SbG6KMpmUfTaOEB++1z2lW9fo8fU9+0JumtqW6HaVED4eGi7MCoVTnxro=
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr6485069wma.159.1580404700625; 
 Thu, 30 Jan 2020 09:18:20 -0800 (PST)
MIME-Version: 1.0
From: Jacob Hrbek <kreyren@rixotstudio.cz>
Date: Thu, 30 Jan 2020 18:17:48 +0100
Message-ID: <CAPA_gs6evUkUbPipQ4=BTH9R9ZWDZimZpTYbOBus+i=AZZDnyw@mail.gmail.com>
Subject: Suspecting corrupted VBIOS after update of AMDGPU on AMD7870
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Thu, 30 Jan 2020 17:39:45 +0000
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
Content-Type: multipart/mixed; boundary="===============1678581516=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1678581516==
Content-Type: multipart/alternative; boundary="000000000000c85fef059d5ea42b"

--000000000000c85fef059d5ea42b
Content-Type: text/plain; charset="UTF-8"

*Hello,*

I believe that system update that included amdgpu on debian testing (but i
am on LFS) corrupted my VBIOS on AMD7870 (+- 4 hours after the update the
GPU using AMDGPU/Radeon drivers resulted in no output).

i'm sending this email to inform about possible bug with my findings on
https://gist.github.com/Kreyren/3e55e9a754e58956e1690e38b1888de7 and i
would appreciate any help in excluding VBIOS corruption from the
diagnostics.

*Thanks,*
- Jacob Hrbek

--000000000000c85fef059d5ea42b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;font-size:large;color:rgb(0,0,0)"><b>Hello,</b><br><br></div><div=
 class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:l=
arge;color:rgb(0,0,0)">I believe that system update that included amdgpu on=
 debian testing (but i am on LFS) corrupted my VBIOS on AMD7870 (+- 4 hours=
 after the update the GPU using AMDGPU/Radeon drivers resulted in no output=
).<br><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sa=
ns-serif;font-size:large;color:rgb(0,0,0)">i&#39;m sending this email to in=
form about possible bug with my findings on <a href=3D"https://gist.github.=
com/Kreyren/3e55e9a754e58956e1690e38b1888de7">https://gist.github.com/Kreyr=
en/3e55e9a754e58956e1690e38b1888de7</a> and i would appreciate any help in =
excluding VBIOS corruption from the diagnostics.<br><br></div><div class=3D=
"gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:large;colo=
r:rgb(0,0,0)"><b>Thanks,</b><br></div><div class=3D"gmail_default" style=3D=
"font-family:tahoma,sans-serif;font-size:large;color:rgb(0,0,0)">- Jacob Hr=
bek<br></div></div>

--000000000000c85fef059d5ea42b--

--===============1678581516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1678581516==--
