Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF91C3ABC6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3F310E90B;
	Thu,  8 May 2025 13:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HRVJaBT7";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE18510E7B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 12:50:13 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 49559208CA;
 Wed,  7 May 2025 14:50:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcT8QIsd7Ghg; Wed,  7 May 2025 14:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1746622206; bh=9FeA32VSrqmk2zOBZg09X/oAHL+N5QhGNIXl9GfqGkQ=;
 h=Date:From:To:Cc:Subject;
 b=HRVJaBT7624Sab+G1z/RgvtKlGEAc//5hsddWY1Dh+M2O73vIGEM2dDs16EYHt2NN
 UNisdVqr61O/7rkiKXO41xydCt4jaLfFI1gVrWWJwYbVc9xwJorh4wbE7wyljIP9Mx
 J1+k+G7NPSC+4V8A0PC/65HUCYcfSowfLha7mNWxpHX6OUS8R8AtHxkKQSw6qfX8NZ
 vMBKXHmfEIEAfQzse1xOaT2GQWkKa4tphAykaOAwlBGfgSiSHtvvj+HOXDJkpJG7i+
 +1Dk4T1bvtyq1aBGNKg59XMNbo0/jK0oxTNw4jMxcygyKy9MchBDFOEk4ZAwQLrVFw
 252noh/Fla+nQ==
MIME-Version: 1.0
Date: Wed, 07 May 2025 14:50:06 +0200
From: machion@disroot.org
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
Message-ID: <d825f9252143e836c2a76dd1d3096d35@disroot.org>
X-Sender: machion@disroot.org
Content-Type: multipart/alternative;
 boundary="=_a4d2eec8a3643a52107162169bbd61ce"
X-Mailman-Approved-At: Thu, 08 May 2025 13:02:11 +0000
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

--=_a4d2eec8a3643a52107162169bbd61ce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hello kernel/driver developers,

I hope, with my information it's possible to find a bug/problem in the 
kernel. Otherwise I am sorry, that I disturbed you.
I only use LTS kernels, but I can narrow it down to a hand full of them, 
where it works.

The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD 7790/8GB 
RAM
I already asked the Manjaro community, but with no luck.

The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021), 
uses vulkan

---

I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15, 
6.1 and 6.6 and and the game was always unplayable, because the frames 
where around 1fps (performance of PC is not the problem).
I asked the mesa and cinnamon team for help in the past, but also with 
no luck.
It never worked, till on 2025-03-29 when I installed 6.12.19 for the 
first time and it worked!

But it only worked with 6.12.19, 6.12.20 and 6.12.21
When I updated to 6.12.25, it was back to unplayable.

For testing I installed 6.14.4 with the same result. It doesn't work.

I also compared file /proc/config.gz of both kernels (6.12.21 <> 
6.14.4), but can't seem to see drastic changes to the graphical part.

I presume it has something to do with amdgpu.

If you need more information, I would be happy to help.

Kind regards,
Marion
--=_a4d2eec8a3643a52107162169bbd61ce
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<p>Hello kernel/driver developers, </p>
<p>I hope, with my information it's possible to find a bug/problem in the k=
ernel. Otherwise I am sorry, that I disturbed you. <br />I only use LTS ker=
nels, but I can narrow it down to a hand full of them, where it works. </p>
<p>The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD 7790/8GB =
RAM <br />I already asked the Manjaro community, but with no luck. </p>
<p>The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021), us=
es vulkan&nbsp;</p>
<p>---</p>
<p>I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15, 6=
=2E1 and 6.6 and and the game was always unplayable, because the frames whe=
re around 1fps (performance of PC is not the problem).&nbsp; <br />I asked =
the mesa and cinnamon team for help in the past, but also with no luck. <br=
 />It never worked, till on 2025-03-29 when I installed 6.12.19 for the fir=
st time and it worked! </p>
<p>But it only worked with 6.12.19, 6.12.20 and 6.12.21<br />When I updated=
 to 6.12.25, it was back to unplayable.&nbsp;</p>
<p>For testing I installed 6.14.4 with the same result. It doesn&rsquo;t wo=
rk.</p>
<p>I also compared file /proc/config.gz of both kernels (6.12.21 &lt;&gt; 6=
=2E14.4), but can&rsquo;t seem to see drastic changes to the graphical part=
=2E </p>
<p>I presume it has something to do with amdgpu. </p>
<p>If you need more information, I would be happy to help. </p>
<p>Kind regards,&nbsp;<br />Marion </p>

</body></html>

--=_a4d2eec8a3643a52107162169bbd61ce--
