Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08A2C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401966143E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 14:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401966143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ABD6E218;
	Wed, 28 Apr 2021 14:12:31 +0000 (UTC)
X-Greylist: delayed 418 seconds by postgrey-1.36 at gabe;
 Wed, 28 Apr 2021 13:15:36 UTC
Received: from st43p00im-ztdg10061801.me.com (st43p00im-ztdg10061801.me.com
 [17.58.63.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B041A6EB31
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1619615316; bh=T6gHWb5E/U5Jt2Pqwqqp6GPCRLwgzlUqQuBzSWdLmyk=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
 b=rjF2nnBgf2LEfLPLKjWZaJyY7xkVddmKxR8jDwSs9aTnwVFHm8manKHPFMVeqAaEy
 Z5glgyJxl6OtZmqBgB5dGE/MLNCIm7FWkAVlMfxVsUiTnyk2KJKpOAEUjIYoGyJMui
 89auzCdvmDgiMXA3BRxadQo96+k9U5sYb3omgKi9MNVYRYZN3KgoYxcSCdlXkD0k/U
 y19835j1ylDoBs4D0nKlgV5RCYlM4pEGlVYBT6Eem/qbfeu38IWHUK4zFYFdo4nZ7n
 IcBXxK/INbqaRglyncgZ5nS9A0OFe6p9/A6Jzr+jleotehrFmXS/SW9N2ClmWJghjd
 UzrIO1iKYGKEg==
Received: from smtpclient.apple (unknown [186.220.198.33])
 by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 03AAD8C0630
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 13:08:35 +0000 (UTC)
From: Rodrigo Luglio <rodrigo.luglio@me.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: VEGA 20 (Aka Vega12) 
Message-Id: <0CFB0C48-3A23-4BDB-AD15-DEC9E348EC58@me.com>
Date: Wed, 28 Apr 2021 10:08:33 -0300
To: amd-gfx@lists.freedesktop.org
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-04-28=5F05:2021-04-28=5F01,2021-04-28=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2104280087
X-Mailman-Approved-At: Wed, 28 Apr 2021 14:12:29 +0000
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
Content-Type: multipart/mixed; boundary="===============0954335601=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============0954335601==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A9F5BB86-A81E-4B52-BDFA-72CC1184D23A"


--Apple-Mail=_A9F5BB86-A81E-4B52-BDFA-72CC1184D23A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I have a macbook pro with vega 20 which uses the amdgpu firmware vega12 =
and when i boot any distro the graphics glitch and the computer freezes. =
If i install amdgpu pro on ubuntu it works flawlessly. Would you guys =
help me debug this and fix for upstream?=20


Please, let me know which kind of logs and information I can attach in =
order to start debugging this issue. I=E2=80=99ll be more than happy to =
be part of it!

Brief summary of the problem:

I have a macbook pro with vega 20 which uses the amdgpu firmware vega12 =
and when i boot any distro the graphics glitch and the computer freezes. =
If i install amdgpu pro on ubuntu it works flawlessly. Would you guys =
help me debug this and fix for upstream?

Please, let me know which kind of logs and information I can attach in =
order to start debugging this issue. I=E2=80=99ll be more than happy to =
be part of it!

 =
<applewebdata://3F0BA0F3-7A8E-4F27-A0F8-0803CCC90DAD#hardware-description>=
Hardware description:

CPU: 2,4 GHz 8-Core Intel Core i9
GPU: Radeon Pro Vega 20 4 GB Radeon Pro Vega 20:
Chipset Model: Radeon Pro Vega 20 Type: GPU Bus: PCIe PCIe Lane Width: =
x8 VRAM (Total): 4 GB Vendor: AMD (0x1002) Device ID: 0x69af Revision =
ID: 0x00c0 ROM Revision: 113-D2060I-087 VBIOS Version: =
113-D20601MA0T-016 Option ROM Version: 113-D20601MA0T-016 EFI Driver =
Version: 01.01.087 Automatic Graphics Switching: Supported gMux Version: =
5.0.0

System Memory: 32 GB 2400 MHz DDR4

Display(s): Color LCD: Display Type: Built-In Retina LCD Resolution: =
2880 x 1800 Retina Framebuffer Depth: 30-Bit Color (ARGB2101010) Main =
Display: Yes Mirror: Off Online: Yes Automatically Adjust Brightness: =
Yes Connection Type: Internal

Type of Diplay Connection: Internal

 =
<applewebdata://3F0BA0F3-7A8E-4F27-A0F8-0803CCC90DAD#system-information>Sy=
stem information:

Distro name and Version: Any distro
Kernel version: Any kernel up to 5.12
Custom kernel:
AMD package version: No package
 =
<applewebdata://3F0BA0F3-7A8E-4F27-A0F8-0803CCC90DAD#how-to-reproduce-the-=
issue>How to reproduce the issue:

Boot into any distro and the screen glitch and the computer freezes =
Sometimes it takes like 5 or 6 seconds before it glitch and freeze.

 =
<applewebdata://3F0BA0F3-7A8E-4F27-A0F8-0803CCC90DAD#attached-files>Attach=
ed files:

Please, let me know how can I get useful logs, sometimes I`m able to =
open another tty and run some commands.=

--Apple-Mail=_A9F5BB86-A81E-4B52-BDFA-72CC1184D23A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">I =
have a macbook pro with vega 20 which uses the amdgpu firmware vega12 =
and when i boot any distro the graphics glitch and the computer freezes. =
If i install amdgpu pro on ubuntu it works flawlessly. Would you guys =
help me debug this and fix for upstream?&nbsp;<div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D"">Please, let me know =
which kind of logs and information I can attach in order to start =
debugging this issue. I=E2=80=99ll be more than happy to be part of =
it!</div><div class=3D""><br class=3D""></div><div class=3D""><h2 =
data-sourcepos=3D"1:1-1:32" dir=3D"auto" class=3D"">Brief summary of the =
problem:</h2><p data-sourcepos=3D"2:2-2:257" dir=3D"auto" class=3D"">I =
have a macbook pro with vega 20 which uses the amdgpu firmware vega12 =
and when i boot any distro the graphics glitch and the computer freezes. =
If i install amdgpu pro on ubuntu it works flawlessly. Would you guys =
help me debug this and fix for upstream?</p><p =
data-sourcepos=3D"5:1-5:151" dir=3D"auto" class=3D"">Please, let me know =
which kind of logs and information I can attach in order to start =
debugging this issue. I=E2=80=99ll be more than happy to be part of =
it!</p><h2 data-sourcepos=3D"7:1-7:24" dir=3D"auto" class=3D""><a =
id=3D"user-content-hardware-description" class=3D"anchor" =
href=3D"#hardware-description" aria-hidden=3D"true"></a>Hardware =
description:</h2><ul data-sourcepos=3D"8:2-11:0" dir=3D"auto" =
class=3D""><li data-sourcepos=3D"8:2-8:36" class=3D"">CPU: 2,4 GHz =
8-Core Intel Core i9</li><li data-sourcepos=3D"9:2-11:0" class=3D"">GPU: =
Radeon Pro Vega 20 4 GB Radeon Pro Vega 20:</li></ul><p =
data-sourcepos=3D"12:3-25:21" dir=3D"auto" class=3D"">Chipset Model: =
Radeon Pro Vega 20 Type: GPU Bus: PCIe PCIe Lane Width: x8 VRAM (Total): =
4 GB Vendor: AMD (0x1002) Device ID: 0x69af Revision ID: 0x00c0 ROM =
Revision: 113-D2060I-087 VBIOS Version: 113-D20601MA0T-016 Option ROM =
Version: 113-D20601MA0T-016 EFI Driver Version: 01.01.087 Automatic =
Graphics Switching: Supported gMux Version: 5.0.0</p><ul =
data-sourcepos=3D"27:2-40:0" dir=3D"auto" class=3D""><li =
data-sourcepos=3D"27:2-27:37" class=3D""><p data-sourcepos=3D"27:4-27:37" =
class=3D"">System Memory: 32 GB 2400 MHz DDR4</p></li><li =
data-sourcepos=3D"28:2-38:0" class=3D""><p data-sourcepos=3D"28:4-37:27" =
class=3D"">Display(s): Color LCD: Display Type: Built-In Retina LCD =
Resolution: 2880 x 1800 Retina Framebuffer Depth: 30-Bit Color =
(ARGB2101010) Main Display: Yes Mirror: Off Online: Yes Automatically =
Adjust Brightness: Yes Connection Type: Internal</p></li><li =
data-sourcepos=3D"39:2-40:0" class=3D""><p data-sourcepos=3D"39:4-39:38" =
class=3D"">Type of Diplay Connection: Internal</p></li></ul><h2 =
data-sourcepos=3D"41:1-41:22" dir=3D"auto" class=3D""><a =
id=3D"user-content-system-information" class=3D"anchor" =
href=3D"#system-information" aria-hidden=3D"true"></a>System =
information:</h2><ul data-sourcepos=3D"42:2-46:0" dir=3D"auto" =
class=3D""><li data-sourcepos=3D"42:2-42:38" class=3D"">Distro name and =
Version: Any distro</li><li data-sourcepos=3D"43:2-43:40" =
class=3D"">Kernel version: Any kernel up to 5.12</li><li =
data-sourcepos=3D"44:2-44:18" class=3D"">Custom kernel:</li><li =
data-sourcepos=3D"45:2-46:0" class=3D"">AMD package version: No =
package</li></ul><h2 data-sourcepos=3D"47:1-47:30" dir=3D"auto" =
class=3D""><a id=3D"user-content-how-to-reproduce-the-issue" =
class=3D"anchor" href=3D"#how-to-reproduce-the-issue" =
aria-hidden=3D"true"></a>How to reproduce the issue:</h2><p =
data-sourcepos=3D"48:1-49:67" dir=3D"auto" class=3D"">Boot into any =
distro and the screen glitch and the computer freezes Sometimes it takes =
like 5 or 6 seconds before it glitch and freeze.</p><h2 =
data-sourcepos=3D"52:1-52:18" dir=3D"auto" class=3D""><a =
id=3D"user-content-attached-files" class=3D"anchor" =
href=3D"#attached-files" aria-hidden=3D"true"></a>Attached files:</h2><p =
data-sourcepos=3D"53:1-53:108" dir=3D"auto" class=3D"">Please, let me =
know how can I get useful logs, sometimes I`m able to open another tty =
and run some commands.</p></div></body></html>=

--Apple-Mail=_A9F5BB86-A81E-4B52-BDFA-72CC1184D23A--

--===============0954335601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0954335601==--
