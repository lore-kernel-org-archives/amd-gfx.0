Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29854C36012
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 08:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E140B10E876;
	Thu, 27 Mar 2025 08:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="HEJ4K2CL";
	dkim-atps=neutral
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Wed, 26 Mar 2025 18:21:51 UTC
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41BA10E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 18:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1743012403; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b9qk4pOWuoeai/12gbvWk9Q+W+mUnGbG4u5Gi5Ow751gvpP9r0GZ46V9pg4xUNi44UcjVnXnosfkiKUOiq7nWA1Dp8xChrVe/SFzxl/RPzgAZBYVuLQcrrVC71p8WfwObcitqIMiNFm9o0G0Pm1RrG50mgdJkay7E/1EmdEqMf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1743012403;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=wNN8ZDKlosjM0kkd7llS0ApBit3KrjMNA3LnbxAh9xs=; 
 b=Afi0GuXklvIbHZjAAxt5RZcD2OW/Z/egAzwLPc9gLnpJ9AXUYIP3NKPMFhZ9Z8Zv44OCD2RRS0eonw+EyNuChHttj2ZWTNSq4RUmr256UcuzUqhbjMiC5YgHNFTtpTYcROuhkWrb4wnqdkec8Hd3ZVZliHHxAHUu2SA4g2aS+qo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743012403; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:MIME-Version:Message-Id:Reply-To:Cc;
 bh=wNN8ZDKlosjM0kkd7llS0ApBit3KrjMNA3LnbxAh9xs=;
 b=HEJ4K2CL/YzKv2aWTd1VGvvy1V9LKJgzbmZzkTbN1djxev0Y+jV4r5DPmH3yBpwB
 TfGg7M2GmHUSCQaLiATHxy5ShdgfCBzMw8xx8vyZSly74t96GZTcvdq9GNioGiWSBKo
 wwalWQ8R9S9WfKu4e/GbKFlHoFAlGLMLqY/ZmjRI=
Received: by mx.zohomail.com with SMTPS id 1743012401570621.2737768186627;
 Wed, 26 Mar 2025 11:06:41 -0700 (PDT)
Message-ID: <ecc9c7205a99086f0787e7b75985a0898e5e21e3.camel@collabora.com>
Subject: 2025 X.Org Foundation Membership deadline for voting in the
 upcoming election
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 26 Mar 2025 14:06:40 -0400
Content-Type: multipart/alternative; boundary="=-p//5JAAIr+acp60IhPeR"
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41app1) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 27 Mar 2025 08:19:46 +0000
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

--=-p//5JAAIr+acp60IhPeR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Now that the freedesktop server migration is almost done, it's time to
turn our attention on the 2025 X.Org Foundation elections, which are
rapidly approaching! We will be forwarding the election schedule and
nominating process to the membership shortly.

Please note that only current members can vote in the upcoming
election, and that the deadline for new memberships or renewals to vote
in the upcoming election is 23 April 2025 at 23:59 UTC.

If you are interested in joining the X.Org Foundation or in renewing
your membership, please visit the membership system site
at:=C2=A0https://members.x.org/

Mark Filion, on behalf of the X.Org elections committee

--=-p//5JAAIr+acp60IhPeR
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
 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px;=
 text-decoration: none;">Hello,</div><div style=3D"caret-color: rgb(0, 0, 0=
); color: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; font-va=
riant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-st=
roke-width: 0px; text-decoration: none;"><br></div><div style=3D"caret-colo=
r: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style: n=
ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal;=
 text-align: start; text-indent: 0px; text-transform: none; white-space: no=
rmal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -=
webkit-text-stroke-width: 0px; text-decoration: none;">Now that the freedes=
ktop server migration is almost done, it's time to turn our attention on th=
e 2025 X.Org Foundation elections, which are rapidly approaching! We will b=
e forwarding the election schedule and nominating process to the membership=
 shortly.</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0)=
; font-family: Cantarell; font-style: normal; font-variant-caps: normal; fo=
nt-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tap=
-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-=
decoration: none;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color=
: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; font-variant-ca=
ps: normal; font-weight: 400; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-wid=
th: 0px; text-decoration: none;">Please note that only current members can =
vote in the upcoming election, and that the deadline for new memberships or=
 renewals to vote in the upcoming election is 23 April 2025 at 23:59 UTC.</=
div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-fami=
ly: Cantarell; font-style: normal; font-variant-caps: normal; font-weight: =
400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-=
color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration:=
 none;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0,=
 0); font-family: Cantarell; font-style: normal; font-variant-caps: normal;=
 font-weight: 400; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; te=
xt-decoration: none;">If you are interested in joining the X.Org Foundation=
 or in renewing your membership, please visit the membership system site at=
:<span class=3D"Apple-converted-space">&nbsp;</span><a href=3D"https://memb=
ers.x.org/" style=3D"color: rgb(238, 238, 236);">https://members.x.org/</a>=
</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-fa=
mily: Cantarell; font-style: normal; font-variant-caps: normal; font-weight=
: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-tap-highligh=
t-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoratio=
n: none;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: norma=
l; font-weight: 400; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; =
text-decoration: none;">Mark Filion, on behalf of the X.Org elections commi=
ttee</div><div><span></span></div></body></html>

--=-p//5JAAIr+acp60IhPeR--
