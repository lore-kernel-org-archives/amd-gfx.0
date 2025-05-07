Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA8EC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A312610E909;
	Thu,  8 May 2025 13:02:13 +0000 (UTC)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C2B10E7DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 13:10:55 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id C412525BEF;
 Wed,  7 May 2025 15:10:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_f4BkDSiUgk; Wed,  7 May 2025 15:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1746623453; bh=WfOna0qgipSseGCor8cmqiZDQkKFDIjCxDAj9rUOqxo=;
 h=Date:From:To:Cc:Subject;
 b=A3TMBgoCVyygCkWMdgP9DTqPuj45j7FovrgekqUkC8DBsuFcbE1QVG+k0aXPZBdmg
 kFaR/2Aa9+N3B4dH6sAxmGukQRn66bTh2iZsG3/qOJiIPLWyuVR5VKWX6MtAU0u5Ct
 DmtXwj2ZO6TWIOLJzsVDM+w2zTPNTWPpN37MXZYnigiXTdLxTswHMuC/NPCfJgfTs2
 gcFcqYVDBbGN7adqsYrPZdC7r1tE7bQx9ia+zHFIn249ytoxmNMFv0ZAj1sCLmGnTs
 YGbPVmigk4gJKQx+s+z125YMLG9N37f4uC/uX9EPlIX8tvD7XLCoPXyTVSFaOiFkbt
 bEYq5ur37jUbQ==
MIME-Version: 1.0
Date: Wed, 07 May 2025 15:10:53 +0200
From: machion@disroot.org
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Unplayable framerates in game but specific kernel versions work,
 maybe amdgpu problem
Message-ID: <c415d9e0b08bcba068b01700225bf560@disroot.org>
X-Sender: machion@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
