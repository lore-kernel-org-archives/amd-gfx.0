Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FDFC87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87F110E4D3;
	Fri,  8 Aug 2025 07:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="JfimnEA+";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD6F10E855
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 13:55:01 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4byTDx6p2cz9slL;
 Thu,  7 Aug 2025 15:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754574898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouBLgf7noV5w3kuj5/FOS8clIms1rxk7uOPU6abThO4=;
 b=JfimnEA+i7aqjRCczvm9aabhRfayHQDL8ard+Hrbarhd4DMAPl9QGyTWSVtBdisyNLfCeK
 Y7ToKMQW6FAAtmT+5jUSeafS2QBAXYGbzYg88lrGut0KC0pllbEY80n6abxjhmpyYEHp2r
 ss/y3Z5OPtLptc3+6ZfDrGBEDwdGCI6JV0IaMcLQpcDz4aUHT14S4OEzON95qiaV/0Kk9F
 P6wNRQ0xkBI5FvKZXBkkd91tUVvWCb+G903axuKFyrhrSBP+hb9+xVRWa5djToeWYVP4cq
 ZOBbw5HMNdRpZ5S7N+Y8XwcrWPFu3ZeB+qgnxzWhEsqhXIAg6Usf0/K85UaSqA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
Date: Thu, 7 Aug 2025 19:24:50 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com, 
 sean@poorly.run, amd-gfx@lists.freedesktop.org
Subject: Re: Is amdgpu open to converting logging to drm_* functions
Message-ID: <ztjev7equ5au6thelxxbm6yqw7rzyy6s54lkpf7dnuxoys4rpa@oqibara5ogx3>
References: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
 <CADnq5_O1PyEqtK-GGPgPzkMDeNmTCFFNDLd-+73NDqFtPVL2oA@mail.gmail.com>
 <9c56c638-a0d8-4f9e-b865-83ef6a124de3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c56c638-a0d8-4f9e-b865-83ef6a124de3@amd.com>
X-Rspamd-Queue-Id: 4byTDx6p2cz9slL
X-Mailman-Approved-At: Fri, 08 Aug 2025 07:32:07 +0000
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

On 07.08.2025 15:29, Christian König wrote:
> On 07.08.25 15:22, Alex Deucher wrote:
> > On Thu, Aug 7, 2025 at 9:13 AM Brahmajit Das <listout@listout.xyz> wrote:
> >>
> >> Hello Alex, Christian,
> >>
> >> I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
> >> TODO list on the kernel doc, and specifically this section[0]. Would
> >> amdgpu be open to this conversion. I saw that before starting it is
> >> recommended to talk with Sean and the relevant maintainer. Hence I'm
> >> emailing you folks.
> > 
> > It would be nice to get rid of the old DRM_INFO/ERROR/DEBUG macros and
> > replace them with the dev_ or drm_ replacements.
> 
> Good point.
> 
> For the background, the old DRM_INFO/ERROR/DEBUG macros only printed a message without noting from which device it came from.
> 
> That made sense when you only had a single VGA graphics card in the system, but those days are long gone and today when we have a system with multiple graphics device we sometimes wonder where a message came from.
> 
> On the other hand if you just seek for something todo Alex and I can potentially come up with some cleanup work or maybe you could write some test cases or whatever.
Yeah that would be great. I'm fine with either cleanup or writing test
cases.
Thanks a lot, both.
> 
> Christian.
> 
...snip...

-- 
Regards,
listout
