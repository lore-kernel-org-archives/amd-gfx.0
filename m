Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B50CD6E62
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E202D112EDD;
	Mon,  1 Jun 2026 07:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="dran2DTi";
	dkim-atps=neutral
X-Greylist: delayed 381 seconds by postgrey-1.36 at gabe;
 Sun, 31 May 2026 00:04:56 UTC
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881E110E380
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 00:04:56 +0000 (UTC)
Received: from Stacjonarny (62-133-147-124.dynamicip.ostnet.pl
 [62.133.147.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by www.poczta.fm (INTERIA.PL) with ESMTPSA;
 Sun, 31 May 2026 01:58:31 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: <amd-gfx@lists.freedesktop.org>
Cc: <regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
Subject: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 01:58:32 +0200
Message-ID: <00de01dcf090$38cd2e80$aa678b80$@poczta.fm>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_00DF_01DCF0A0.FC570FF0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdzwkAzOD3/BrJybT02U1KdQhmm1LA==
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1780185512; bh=Hy3wcDEGkMNxIk7hULP+9CScokmO5OsQMjUY0EiYFPA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=dran2DTiLdOWo7/ex3ZRZaGGnEZWvDNzqsGhrJNZHLQvtdXoz6eG0XZ8Cvt0qiMcT
 55uxExAKMr2NMXagsXap7UW/FRIDcGdwCZP8BCqInb8uO8P6ZslwjSprd9UvFjLpUV
 1hmL7sQBdoVmuUgf04d/mUmlPTXXITdz9E5D5zXQ=
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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

------=_NextPart_000_00DF_01DCF0A0.FC570FF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 and
7.0.10 or 7.1rc


------=_NextPart_000_00DF_01DCF0A0.FC570FF0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
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
span.Stylwiadomocie-mail17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DPL link=3D"#0563C1" vlink=3D"#954F72" =
style=3D'word-wrap:break-word'><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-GB>Hi, I have 5x fps drop on amdgpu =
Radeon 260X 1GB between kernel 7.0.9 and 7.0.10 or =
7.1rc<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_00DF_01DCF0A0.FC570FF0--

