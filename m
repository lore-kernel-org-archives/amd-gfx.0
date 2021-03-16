Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C53C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5134F6508F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 14:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5134F6508F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=online.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158116E40B;
	Tue, 16 Mar 2021 14:55:25 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Tue, 16 Mar 2021 14:33:19 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E05489CD7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 14:33:19 +0000 (UTC)
Received: from oxbagw05.schlund.de ([172.19.245.15]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuUrM-1le7Gm0E2E-00rWnC for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar
 2021 15:28:14 +0100
Date: Tue, 16 Mar 2021 15:28:13 +0100 (CET)
From: Martin Babutzka <martin.babutzka@online.de>
To: amd-gfx@lists.freedesktop.org
Message-ID: <1298946407.166914.1615904893558@mailbusiness.ionos.de>
Subject: Is amd-staging-drm-next dead?
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev19
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:l1gJORNQKlXOyZOLLqljlJfqFcRtEsGYg0GaBXqOYjXGIVzMxJH
 I03CDddavLmT0XHf4UlQY7JJ0QfR287gqJ3nwQ5vDQOTeSBhX0j+TpVuUY+3zBBOZ/O1Bpv
 f5bXv0uVetjhRC/x96fHeTkho3huM/MvDfRBpl8lhtKiJLP0JYpsgnGYDBla0tBi+QfuBNP
 VeVm6Aj/pdyUWy30BxTYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IVYdX1WOk0c=:tJQQFSsiQfCrAnLAu+Gnvg
 d6JJ9fbmEHtLMYdUJd/pOivZDHkfQlUtfI9T7wd9dDwHwEshgflOjWQpZcY5SdcSOkRCjX9i9
 So6jA5mBzpWq5w++fiD9s+EZuo5wCQXdyJC9BKR81b3WMBqGndxeKQtoavh5EztpraPmgYvT3
 9pI0kJK3Lw+JZynvV+ES79/t9KF3sH+jPg7QEZAq/aZCIkSzJL0z7RYBy62OOlB8Uggyu/Q2T
 O65AxVKliyfR69BaD12bi7j9zfQhlFw87O7hXcjLqltLv/aTioSwZz/72R+Ii8kGJDsK+PyLg
 OgjPDIC+nNrWq7d/H1dDkCYTHwEj2gsEPLYzU8W64GJr/b+D5l31Rey0ZKlG5AIxcVE9e8aO0
 vgd9LQD4m2ZR8gayv98tu9e/OC+7tMmVI2BLYFRxZT1ItFGe9afsHibp5dIEIbDJdfmbqklc+
 ko6hVoeTTQ==
X-Mailman-Approved-At: Tue, 16 Mar 2021 14:55:23 +0000
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
Content-Type: multipart/mixed; boundary="===============1292018331=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1292018331==
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!doctype html>
<html>
 <head> 
  <meta charset="UTF-8"> 
 </head>
 <body>
  <div style="" class="default-style">
   <div>
    Dear AMD Developers,
   </div>
   <div>
    <br>
   </div>
   <div>
    I am building your amd-staging-drm-next kernels for more than 2 years now and patch this up with the official kernel patches and ubuntu's sauce patches: <a href="https://github.com/M-Bab/linux-kernel-amdgpu-binaries">https://github.com/M-Bab/linux-kernel-amdgpu-binaries</a>
    <br>
   </div>
   <div>
    <br>
   </div>
   <div class="default-style">
    Since quite a while (end of 2020) there have been no updates in <a href="https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next">https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next</a> . Is this repository abandoned? Is there any new way or repository from which the most recent AMD linux graphics drivers in the kernel source?
    <br>
   </div>
   <div class="default-style">
    <br>
   </div>
   <div class="default-style">
    I was asked multiple times to update the kernel but there is no chance without updates of the staging kernel.
    <br>
   </div>
   <div>
    <br>
   </div>
   <div>
    Looking forward to your response.
    <br>
   </div>
   <div>
    <br>
   </div>
   <div>
    Many regards,
    <br>Martin (M-bab)
   </div>
   <div>
    <br>
   </div>
  </div>
 </body>
</html>

--===============1292018331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1292018331==--
