Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDDAE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2024 10:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217F710E658;
	Tue, 31 Dec 2024 10:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=croquette.de header.i=olivier@croquette.de header.b="My7SLQSK";
	dkim-atps=neutral
X-Greylist: delayed 455 seconds by postgrey-1.36 at gabe;
 Tue, 31 Dec 2024 10:49:38 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AFC10E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=croquette.de;
 s=s1-ionos; t=1735642177; x=1736246977; i=olivier@croquette.de;
 bh=8NVss+ANlLi9XXAh9sJGPoWh499CX12mS3SsNlEKuqU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:Content-Type:
 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
 message-id:mime-version:reply-to:subject:to;
 b=My7SLQSK/LW8iD0BMPxY7Z29XkAR+zxL8H7Mdtkpe603zjlil/2we4N2eyDknhvu
 JCSpe2unlSAOHrkYQzdEPEGMDO3y0Ydn8k54S7Kpe5dCVp66BisnV4ll6FaX83K+4
 3lTgW6r8VAfbHNmvuRj4GzkJh+7XOk1LP5s7fYd20ZANW7OIJlT/a14RI7STEmizS
 awbF/tImuSvsQIGeLyhU4GHJ+NqO7zvcqcD3btMuOhPDgO54VAalzs/kUCWoK4tUU
 aLrQyh5OjeJMCrX+irOXhQFEYW6VSGGiBQnYF2KS4tFU3hmwRrtrry7tSHg7WD8FH
 incwUfFGVoJm+h1MyA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.200.73] ([82.135.79.74]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1Mgw7n-1u0GsZ31i9-00pUAJ for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec
 2024 11:36:58 +0100
Message-ID: <0995edc69c3d45730e06576b51a923cf12bca7f9.camel@croquette.de>
Subject: After suspend, screen/display never turns on
From: Olivier Croquette <olivier@croquette.de>
To: amd-gfx@lists.freedesktop.org
Date: Tue, 31 Dec 2024 11:36:58 +0100
Content-Type: multipart/alternative; boundary="=-LKOlnvdQmG8HIYgxECg2"
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:VwwoNTSbtvcfNmoynxp5J6uwOarFZOErUXL/sv2DVwju5xaoWfa
 329REyiBJA9xzAGdf9+KQA9dPC3u8OBAVgBHYpjVGzqbnHmB7ee9gS5O7P5UWFWA62UaUA3
 M5OOjJY558/jXuucUPY9wVpmgnXUhT1kURr4yBL6wP+DIW/S1Xx/dNy6g4K7o7mr8Rvl4St
 +siaeWBo0vNtTdCJw4zhg==
UI-OutboundReport: notjunk:1;M01:P0:QEjqMUebgRA=;PXPO/UiGqROGybf1rE3EamxTECL
 Isx+KXzbawgg0UUM7n2OCUpeePomrsHIN4PHIkv7ovfZEaOjPmkJHRwf0Czr7SRXZlj8Px2X7
 cNZHZ/GnxbnxZSSx6yIWv4riOjxbxPtWoxhFOC35OsfUKx49aLRlT/S5ATS2AUTGs5GFhdotq
 88QN6sIwZGOmg4NqxFT7uGexVpwBnqu1YROXGPXxa95xYASLTDKrON+2yeRX49u6HcUwKLZmZ
 ZHPPWpa9d45oXbxRQt2hhqFTwwd9HjSIdpodXE5QB0VRbRjDJzTbEPd1Ndy4fGrZXHuE2vXst
 T422Q5VI1UlBEV/UbhlOrGDMMt5hxEFAr3RsmD9cPSB6XNC+x/xO0486lhQh2AyLt6D38YqLU
 2WpN6k/q3LoQK65cLFY9oLoOyOKAY+bLvyNb2cms3zkiMZTRd8SfxiTGfVsPWtlsBpGaPirog
 iv8aSZ9pNIaEp3N1vbpDpN9t/C4cddHM/ByyBsMRYR279U0Rkl049ndy39DSWQioUx8fYZtn9
 BQY++1D8WdyCkXRdJxUNJ468SHXDw4aqTgHlzhkh9Zy5Yo+Rf+Vidcqv7nBoaMyRYIR9upfLc
 3Ti30+nJOXupOs7L0b7WRGEonNuJQpbQlKf/DExDr7ZMRWv0T76vDn+ccAhfaTUPUPV2WPAcD
 koXSWLCUqLVPA98O3NXnqukurwgJXoXpf6zEmG+IfBynxlSSyn2RVIvHoV1T64QjLlr25AMyF
 WZNp3q0fITiUdnJdnvROBW0kAoHI26FwrCZbg6zVgC8/bnk9nebVR7zQZ1S/13ht1+00XEM1u
 PexohP1V/SVRZvpN4bLf36MB7f55bjKJ2BPei6ZuHMFHmxFjpn59HYQptaetdymVj/JFdgL9j
 Pj/SMXBd+WUMh0wp/1ZagHwUuLBkXloM44J4UoOakprqImnVB9qZ1Avp0wayiJ9rPgwpAZMAr
 +j+ziaOiOzuyYQQOolC+ykQiU0CiAeWqeoeA7TrCWsNwey04YgjRQjMS8T7utAlKNxi06I7Rt
 SRLP5vBsWVQ/IfQla0=
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

--=-LKOlnvdQmG8HIYgxECg2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

A regression happened last summer and makes standby useless on impacted
systems. This is a major issue for desktops and laptops.
The only workaround so far is to stick to older kernel versions, which
becomes more and more an issue with time.

There is a bug report, but unfortunately no progress since four
months:=C2=A0https://gitlab.freedesktop.org/drm/amd/-/issues/3580
I am hoping with this message on the mailing list to increase awareness to =
speed up the fix... Is there anything else we, the impacted users, can do?
Cheers
Olivier


--=-LKOlnvdQmG8HIYgxECg2
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
</style></head><body><div>Hello everyone,</div><div><br></div><div>A regres=
sion happened last summer and makes standby useless on impacted systems. Th=
is is a major issue for desktops and laptops.</div><div>The only workaround=
 so far is to stick to older kernel versions, which becomes more and more a=
n issue with time.</div><div><br></div><div>There is a bug report, but unfo=
rtunately no progress since four months:&nbsp;<a href=3D"https://gitlab.fre=
edesktop.org/drm/amd/-/issues/3580">https://gitlab.freedesktop.org/drm/amd/=
-/issues/3580</a></div>I am hoping with this message on the mailing list to=
 increase awareness to speed up the fix... Is there anything else we, the i=
mpacted users, can do?<div><span></span></div><div><br></div><div>Cheers</d=
iv><div>Olivier</div><div><br></div></body></html>

--=-LKOlnvdQmG8HIYgxECg2--
