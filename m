Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE181C53200
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B36310E7E2;
	Fri, 20 Feb 2026 08:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fateQn91";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6995D10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 22:33:15 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-59e4993e00aso1720769e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 14:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771540393; cv=none;
 d=google.com; s=arc-20240605;
 b=D6UZ+f6dmOGTZpqhu7qKmsOCTWz1UZyEmBeP55KLwlmZv7F9w4fyQ/ONJNFJOM+wlq
 K1cylD9bhnQK9cpokYBOWgkByeCQRxCRFE8BuGVJBGSUC37Rcqg5edz5b22NVrASSc6B
 dGBV/4pBmix/zCl9d3LnMiy1l9ecrdillPygHQh0nuVLOOvm68OD6yj4KjrZuJdB6ONt
 aN4kkIYLyKXIZzoVhIcrN3VmbZa96OWJuVRd/1aExRqMlOXPq/pWKK7j6Ptx5fT+dNOh
 BvJkmYruHAkadRdy++cyKo3Hj6/VCpFizJvQ/IRSVJXUVZ5Vj/H2Mc2y/dzyQknroj5y
 ut9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0c86jRAYAOOniszwr225rxzBQAZQQwvb90WTwPNyTgs=;
 fh=FZOwDXhIVsOMx67BDW0hn+e94OrtwNlu+M1PgBIm6Lo=;
 b=h1TPvss8tZupchHVQHA4czmacVepdGuPnh4kohqAK56dgFUz2+c9KCOR87qUFgBSUQ
 wf0U9k9oW0l2p3gEdTC5/Rldfw5B/w5lA22I+9mzCXfdAh7lmPcpMDPWMln9HNdpe3mI
 K7igl5wIWWVb8XZ+6TfrYrYjvgM8FvOj8RTF71l9zqqV+GFqfOolkn+ZYvqZcKtf6j7+
 LzyOdEcA1JF+3+dCuld6qvV2px3uTJ+W+I79QIGFTUw+VaexeDRhjaTZvqAXa/SGftMS
 E1l5Iikv4uPpY5uBq2bZC32njI5C3knepdpHnOkJRAkxOVf1y6xou2uWT+yOI8BJEHIM
 dskA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771540393; x=1772145193; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0c86jRAYAOOniszwr225rxzBQAZQQwvb90WTwPNyTgs=;
 b=fateQn91chOHA1r0zB95seIPnmhGRABm8/XTI80X9C0c7yM4pt7Uf60yB78wW7ImDz
 H0Vz7RLz9zMY9BNPdf/hxjESw77C4Xqdxj55ES96YS0oQK7KZslAbfibCakODdpx1z/m
 RsE4nE3mTn0PWmZV56cH1jZWf14TG66ISiWgwXEC+h0ONTBj3fkTjrREbQAchi5pfCyE
 3pl1WOH1ZBpKgaS32PbKeDqI0mrb0/Ax8c500ewpRHpvuH4TYjKL9p/VXVAW2P129x2P
 07nWLtCXWzRCu7Ozv3SANbiP6HxhvNyhzj5794+IRuT6CU+nX0BVw3MmRILTp1ush5aD
 6qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771540393; x=1772145193;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0c86jRAYAOOniszwr225rxzBQAZQQwvb90WTwPNyTgs=;
 b=W/dLZPQnMhduxeB7pBd/P8gZUscbgMuaA6ht6+0lbudOA2ICO3RmziCVgtOhn58EM4
 RrpUQcklaUmt1muHnocFbi11fSgRIsLonOnOrEUd481Jk08AEOOALGdPiq2xN5+TEJfd
 gDxt+ARLRL592F0hM1V7lTv547oMEZjt1gkV9ioH2m1QMZhqf9B1b/zhDXBV/3qEAAtv
 GRQA3H88frNs4ilt2xFB7A2ykt/TW/kr273I6b9Qsy0PxPYDwJwpAPV5nDQH5gySrzZc
 YwpEBAistCCnaj0claeVXJTdGnSY9n1GglXrX6bCBgVgWuSKzKX2Do5RFPzWb97pPihs
 aKqQ==
X-Gm-Message-State: AOJu0Yy8KKQ+z8gYdpkA8J0JGx+x7tTWb1ANTH55QHCTEF5LliqChtLC
 d0HS2DJSnfzTzS9DY7sGiuA7allPXwKGmDEQBwUHvamUyh9zlOo8LsaGIuLJA1NsOWjepGFJ/6l
 TXYJ2umQvXa0Bpe4MTBtlPxUyqeSRQxB5VUBfkHoqlgc=
X-Gm-Gg: AZuq6aJ93/amRdZMN4eZjd/KmhF5o/6bNQv7aCNN4iAi5ClNCtwYOzDfrZ2bW7XH/Z0
 RTUHTygHiFWMy+P0I8b8j/DVaHY6x1kBEhqtvnkHnSP17kqLELipaTGEu1GpV4mj/fYAMdKNp5G
 DQS/DGpZkIoQ+x0lwF76yBprzkdBBtaazFeccylayT2obD7lOF9L7TMvGPLus+5elT6YyIn/h/3
 scp2+wqio+77NinIxhoI1cCn6e0MiwTWMMMFb+R91i408ytuEED9BC4qKuaz54CiXqsvLorz7/7
 MS1cfrml+Su475Xa2w==
X-Received: by 2002:a05:6512:23a4:b0:59d:f47c:100d with SMTP id
 2adb3069b0e04-59f83bbad74mr2430338e87.24.1771540393099; Thu, 19 Feb 2026
 14:33:13 -0800 (PST)
MIME-Version: 1.0
From: John The Cooling Fan <ivan8215145640@gmail.com>
Date: Fri, 20 Feb 2026 01:33:01 +0300
X-Gm-Features: AaiRm51jvRuCF3Uzbemg_3Ogc0GaotIPeGjtPgaNcd2hy_qmzlM99LaySlt9CPA
Message-ID: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
Subject: [REGRESSION] VRR not detected on a DisplayPort monitor using an AMD
 GPU
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, regressions@lists.linux.dev, 
 mwen@igalia.com, mario.limonciello@amd.com, alex.hung@amd.com, 
 daniel.wheeler@amd.com, rodrigo.siqueira@amd.com, alexander.deucher@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com, 
 huangalex409@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d620f9064b34e329"
X-Mailman-Approved-At: Fri, 20 Feb 2026 08:45:29 +0000
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

--000000000000d620f9064b34e329
Content-Type: text/plain; charset="UTF-8"

Noticed a regression with VRR after updating the kernel. My main
monitor's VRR stopped being recognized, I was no longer able to enable
it in my desktop environment settings and
/sys/kernel/debug/dri/0/DP-1/vrr_range showed a range of 0 to 0. I did
a bisect on the linux kernel git tree, and found that the commit
introducing this issue is 0159f88a99c9f5722dbe52ac42faf3446f371dea.

The monitor is connected via DisplayPort, no converters as far as I
know. The GPU in use is AMD Radeon RX 6700XT. There is another
monitor, connected over HDMI and it has VRR working in all the
versions I've tested. Attached the DisplayPort monitor's edid copied
from sysfs.

#regzbot introduced: 0159f88a99c9f5722dbe52ac42faf3446f371dea

--000000000000d620f9064b34e329
Content-Type: application/octet-stream; name="main-edid.bin"
Content-Disposition: attachment; filename="main-edid.bin"
Content-Transfer-Encoding: base64
Content-ID: <f_mlu0pn6z0>
X-Attachment-Id: f_mlu0pn6z0

AP///////wBNZxMnAAAAABkhAQS1PCF4Ol3QqFNHqyEFUFSvzwBxT4GAgQCBwKnAlQCzAAEBal4A
oKCgKVAwIDUAYVwhAAAaAAAA/QAwS9/fKAEKICAgICAgAAAA/wAwMDAwMDAwMDAwMDAKAAAA/ABE
RVhQIERRMjdOMgogAXcCAzTxSwECAwQEDhMAABAAIwmHB4MBAABlAwwAEABtGgAAAgEwSwAAAAAA
AGfYXcQBeMAAAjqAGHE4LUBYLEUAYVwhAAAaNnYAoKCgKVAwIDoAuoghAAAeg0iAGHE4LUBYLEUA
DyghAAB/AAAAAAAAAAAAAAAAAAAAAAAAAAAAGA==
--000000000000d620f9064b34e329--
