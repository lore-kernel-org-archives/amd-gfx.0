Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E108ACCF2C1
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4A010E463;
	Sat, 17 Oct 2026 17:30:52 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Fri, 16 Oct 2026 22:17:42 UTC
Received: from omta36.uswest2.a.cloudfilter.net
 (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265B41129FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 22:17:42 +0000 (UTC)
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
 by cmsmtp with ESMTPS
 id HnVNx76oIusRSHq8IxgbV7; Fri, 16 Oct 2026 22:10:34 +0000
Received: from delta.websitewelcome.com ([192.185.83.61]) by cmsmtp with ESMTPS
 id Hq8HxJhSngKkdHq8IxMX7G; Fri, 16 Oct 2026 22:10:34 +0000
X-Authority-Analysis: v=2.4 cv=a9cw9VSF c=1 sm=1 tr=0 ts=6ad2a0da
 a=sy7HV6YSrPMGO6i17biZvg==:117 a=AaDvNZWQTOfaQVmSqZoT7Q==:17
 a=660iZSQnnn4A:10 a=DAwyPP_o2Byb1YXLmDAA:9 a=Q2vXz2r6VuNpkWJYl3UA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=9Z0VUmeasobPx05O_PEl:22
Received: from [193.5.233.205] (port=11947 helo=desktopmikael)
 by delta.websitewelcome.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <contact@mikaelpelle.com>) id 1xHq8H-000000031IC-0mrc;
 Fri, 16 Oct 2026 17:10:33 -0500
From: <contact@mikaelpelle.com>
To: <timur.kristof@gmail.com>
Cc: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
Date: Sat, 17 Oct 2026 00:10:32 +0200
Message-ID: <000801dd5dbb$2a3de5b0$7eb9b110$@mikaelpelle.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0009_01DD5DCB.EDC6B5B0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1dupVRUfZ8RrRuTBSSqMpq6EU8Ng==
Content-Language: en-gb
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.websitewelcome.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mikaelpelle.com
X-BWhitelist: no
X-Source-IP: 193.5.233.205
X-Source-L: No
X-Exim-ID: 1xHq8H-000000031IC-0mrc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (desktopmikael) [193.5.233.205]:11947
X-Source-Auth: contact@mikaelpelle.com
X-Email-Count: 2
X-Org: HG=hgreseller;ORG=hostgator;
X-Source-Cap: bXBlbGxlO21wZWxsZTtkZWx0YS53ZWJzaXRld2VsY29tZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGekUfUAi0eD+1aZiyFwN3VqIXdawJkgfJEZCzIAXfpYFYpSIRxaDldhM/DTz1Bo4yRwCvuBhkimDG4S9tv2VUPK+t9NGBwdG8LFTqcbSf65wS3rIBcc
 AmohtH7KUDdEcZsCAzdxrlp6wOLzQLiXVlxq+Q6K5lhLFo2EXKtAzSTo7wTSYBEDM0QATbLlUOTi+Cf9iFw/B3u4Tg8j2aSK74FJ7zwJlQFwUvkF0Zk1Yn52
X-Mailman-Approved-At: Sat, 17 Oct 2026 17:30:48 +0000
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

This is a multipart message in MIME format.

------=_NextPart_000_0009_01DD5DCB.EDC6B5B0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Timur,

=20

A quick follow-up from the same MacPro6,1 with dual FirePro D700s.

=20

I have now tested the fixes after they reached stock stable kernels:

=20

- Linux 6.18.57-1-lts:

  both GPUs correctly transition from 300/150 MHz idle to 850/1370 MHz =
under Vulkan compute load, then return to 300/150 MHz afterward.

=20

- Linux 7.2.10-arch1-1:

  same result; both D700s reach 850/1370 MHz correctly under load.

=20

For comparison, Linux 7.2.9, before these stable backports, still kept =
both GPUs at 300/150 MHz under the same type of compute workload.

=20

So I can confirm that the stable backports of:

=20

  drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC

  drm/amd/pm/si: Fix updating clock limits on AC/DC

=20

resolve the DPM issue on the dual FirePro D700 in the MacPro6,1.

=20

Thanks for the fixes.

=20

Best,

Mikael


------=_NextPart_000_0009_01DD5DCB.EDC6B5B0
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 15 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-GB =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hi Timur,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>A quick =
follow-up from the same MacPro6,1 with dual FirePro =
D700s.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I have now tested the fixes after they reached stock =
stable kernels:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>- Linux =
6.18.57-1-lts:<o:p></o:p></p><p class=3DMsoNormal>=C2=A0 both GPUs =
correctly transition from 300/150 MHz idle to 850/1370 MHz under Vulkan =
compute load, then return to 300/150 MHz afterward.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>- Linux =
7.2.10-arch1-1:<o:p></o:p></p><p class=3DMsoNormal>=C2=A0 same result; =
both D700s reach 850/1370 MHz correctly under load.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>For =
comparison, Linux 7.2.9, before these stable backports, still kept both =
GPUs at 300/150 MHz under the same type of compute =
workload.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>So I can confirm that the stable backports =
of:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>=C2=A0 drm/amd/pm/si: Check AMD_IS_MOBILITY flag for =
PPSMC_SYSTEMFLAG_GPIO_DC<o:p></o:p></p><p class=3DMsoNormal>=C2=A0 =
drm/amd/pm/si: Fix updating clock limits on AC/DC<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>resolve the =
DPM issue on the dual FirePro D700 in the MacPro6,1.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks for =
the fixes.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Best,<o:p></o:p></p><p =
class=3DMsoNormal>Mikael<o:p></o:p></p></div></body></html>
------=_NextPart_000_0009_01DD5DCB.EDC6B5B0--

