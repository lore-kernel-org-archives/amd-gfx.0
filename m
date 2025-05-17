Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCF3C54756
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 07:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FAA10E225;
	Mon, 19 May 2025 07:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="Fr3jup6I";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425DD10E242
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 May 2025 09:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1747475091; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bz/Y/h+/MAQKbIPhd/lTkMRTiGkq7OwvMme+xhoEHqugmn2JAkm6qzMUuMXv2JjaKk98PyiebJeHbueruINRscwpTUuqUmi1gHmqxuOdEkmV3ZF/FEyJLr82dFCMi/sIsV/PQYJ3D2k3X6qHyykejqAx1KYu9Sjd67BwxNheoWY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747475091;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=78fkDI4HR9qFxJ/YmLUo4iyrOLZ5IO4Y2c1ffGHhH10=; 
 b=B3T3cW06lclZegyhdc7qNK1wM8a08K8XQSGmoXX0j3Pz7elSAidF2QoZCvG06kSuahn+i9kqXcHanSxyZY/Hcyy1Ar+X1han+ULvstv+KZRmlxb3Ms56/TBO3l0wwlYf/p+jO69lQdOXcydfQwEvtZz2j5RyaSVtHyB1lKeZJvA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747475091; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:MIME-Version:Message-Id:Reply-To:Cc;
 bh=78fkDI4HR9qFxJ/YmLUo4iyrOLZ5IO4Y2c1ffGHhH10=;
 b=Fr3jup6ImwmKbZTWxC3It1f6B6i5qVhxpk5ZlPNDvjfIH9uV1aVyapmXL7GEbGlO
 mhgTgfZoOSgYDbdT6bk6BiyxcUXheKIA/IlEvOidK5qxCzVY+P6JxqruLevImm/vo0w
 3lwME6XWquof6akE3DRBGDAzsw0SwfpQozS685vs=
Received: by mx.zohomail.com with SMTPS id 1747475089479377.89698017949024;
 Sat, 17 May 2025 02:44:49 -0700 (PDT)
Message-ID: <57d630f3665a8251422ec7a650b9f0af3b4b3833.camel@collabora.com>
Subject: 2025 X.Org Foundation Election results
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Sat, 17 May 2025 11:44:47 +0200
Content-Type: multipart/alternative; boundary="=-PJNXq+wHnYpqyMFsfqAa"
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 19 May 2025 07:15:16 +0000
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

--=-PJNXq+wHnYpqyMFsfqAa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

The Board of Directors election concluded at 23:59 UTC on 14 May 2025.
For this election, we had 77 members who could cast a vote. 72 did, so
the turnout was 92.5%. This is the 3rd highest turnout in the last 10
elections, with only 2021 (93.8%) and 2016 (98.8%) being higher. It is
also a 147% increase from last year's turnout (62.9%). Thank you to
everyone who took the time to vote!

In the election of the Directors to the Board of the X.Org Foundation,
the results were that Lyude Paul, Andres Gomez, Arkadiusz Hiler and
Harry Wentland were elected for two year terms.

The old full board is: Erik Faye-Lund, Mark Filion, Neal Gompa,
Arkadiusz Hiler, Christopher Michael, Lyude Paul, and Simon Ser.

The new full board is: Erik Faye-Lund, Mark Filion, Andres Gomez, Neal
Gompa, Arkadiusz Hiler, Lyude Paul, Simon Ser, and Harry Wentland.

Mark Filion, on behalf of the X.Org elections committee

--=-PJNXq+wHnYpqyMFsfqAa
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0); font-family: &quot;Adwaita Sans&quot;; font-style: normal; font-var=
iant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-str=
oke-width: 0px; text-decoration: none;">Hello all,</div><div style=3D"caret=
-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: &quot;Adwaita Sans&=
quot;; font-style: normal; font-variant-caps: normal; font-weight: 400; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: r=
gba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none;">=
<br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); fon=
t-family: &quot;Adwaita Sans&quot;; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: =
0px; text-decoration: none;">The Board of Directors election concluded at 2=
3:59 UTC on 14 May 2025. For this election, we had 77 members who could cas=
t a vote. 72 did, so the turnout was 92.5%. This is the 3rd highest turnout=
 in the last 10 elections, with only 2021 (93.8%) and 2016 (98.8%) being hi=
gher. It is also a 147% increase from last year's turnout (62.9%). Thank yo=
u to everyone who took the time to vote!</div><div style=3D"caret-color: rg=
b(0, 0, 0); color: rgb(0, 0, 0); font-family: &quot;Adwaita Sans&quot;; fon=
t-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, =
0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none;"><br></div>=
<div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
&quot;Adwaita Sans&quot;; font-style: normal; font-variant-caps: normal; fo=
nt-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-=
decoration: none;">In the election of the Directors to the Board of the X.O=
rg Foundation, the results were that Lyude Paul, Andres Gomez, Arkadiusz Hi=
ler and Harry Wentland were elected for two year terms.</div><div style=3D"=
caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: &quot;Adwaita =
Sans&quot;; font-style: normal; font-variant-caps: normal; font-weight: 400=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-col=
or: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: no=
ne;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
; font-family: &quot;Adwaita Sans&quot;; font-style: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-wi=
dth: 0px; text-decoration: none;">The old full board is: Erik Faye-Lund, Ma=
rk Filion, Neal Gompa, Arkadiusz Hiler, Christopher Michael, Lyude Paul, an=
d Simon Ser.</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0,=
 0); font-family: &quot;Adwaita Sans&quot;; font-style: normal; font-varian=
t-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; word-spacing=
: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke=
-width: 0px; text-decoration: none;"><br></div><div style=3D"caret-color: r=
gb(0, 0, 0); color: rgb(0, 0, 0); font-family: &quot;Adwaita Sans&quot;; fo=
nt-style: normal; font-variant-caps: normal; font-weight: 400; letter-spaci=
ng: normal; text-align: start; text-indent: 0px; text-transform: none; whit=
e-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0,=
 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none;">The new f=
ull board is: Erik Faye-Lund, Mark Filion, Andres Gomez, Neal Gompa, Arkadi=
usz Hiler, Lyude Paul, Simon Ser, and Harry Wentland.</div><div style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: &quot;Adwaita Sa=
ns&quot;; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-color=
: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none=
;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
font-family: &quot;Adwaita Sans&quot;; font-style: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-widt=
h: 0px; text-decoration: none;">Mark Filion, on behalf of the X.Org electio=
ns committee</div><div><span></span></div></body></html>

--=-PJNXq+wHnYpqyMFsfqAa--
