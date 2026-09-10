Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ADCC88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FD610F542;
	Fri, 11 Sep 2026 08:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.b="CctjByDp";
	dkim-atps=neutral
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io
 [149.72.141.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0075110E2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
 h=from:subject:date:in-reply-to:references:mime-version:to:cc:
 content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
 s=s1; t=1789057423;
 bh=Ojl/NWsC9MSjDYgGDCuYdo4PQAJl7yOv7aALgpvhTkU=;
 b=CctjByDpfVpmnxgsUyiWguRtHQFglltrewxGSBTFmzx1pQDJTZZ4NMZ5bOva2GKcYVY7
 TNFulDf3GzGJNpZSCfjYZUcwzzcYmr3ahV8JfXCHxkk9jdOYyvKOPdrjoq3OazNtpyHlmv
 ns/FsTmTLLChVAuywYtb1G4Q4oj1nPb7194jTOwOwUCOt6aFolv43GCYMO21YsWUpYHzkJ
 g3kRUQ1FGVfOKUNC8T/DpBdSaLK9tBJjzgx1IAwixQVmg2k2NTaLF4gyv7psrpHsBtw0fk
 1GpyIlSnu91vSaGImW+BZD6sNdOCQouVSy0svPb8rhgvQRJEKj+1oyTPc1NXiDTg==
Received: by recvd-69664d99dd-bcjr2 with SMTP id
 recvd-69664d99dd-bcjr2-1-6AA2D98E-78
 2026-09-10 16:23:42.801218343 +0000 UTC m=+836507.408174706
Received: from daisy.dens.ffj.family (unknown) by geopod-ismtpd-6 (SG)
 with ESMTP id uocpkYPWStS876SvS2QkZQ
 Thu, 10 Sep 2026 16:23:42.691 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
Date: Thu, 10 Sep 2026 16:23:43 +0000 (UTC)
Message-ID: <20260910162342.9854-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <29c5916f-da42-58f0-d4c7-815bbaed711b@linux.intel.com>
References: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
 <29c5916f-da42-58f0-d4c7-815bbaed711b@linux.intel.com>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmednNviVbiXOC?=
 =?us-ascii?Q?oREWn0PvvJP53Uz8gPPC5zPjaNtjMPM+hLjOqwU?=
 =?us-ascii?Q?QawE=2F3B72uKOWIppfuG513fXq618S6PDhcLuM4o?=
 =?us-ascii?Q?nJbwgG=2FTeg2=2FM8hDiqcsuwCTOoE4w93lLByoDkz?=
 =?us-ascii?Q?husjCkOm7VGK0Bh6Sl1JqcoyTQJNTHP1a4t5Kaq?= =?us-ascii?Q?Jh8E?=
To: Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Liz Fong-Jones <lizf@honeycomb.io>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, Jon Nettleton
 <jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>, Jacob Martin
 <jacob.martin@canonical.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
 stable@vger.kernel.org
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 08:01:22 +0000
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

On Ilpo Järvinen wrote:
> Great, it worked (I was somewhat afraid there might have been some
> landmine for the case where there's no bridge).
>
> And yes, it's very important in general case to assign the resource in
> correct order because the assignment algorithm is greedy.

Thanks, Ilpo, for both reviews.

Yes, it works fine even without the bridge. This is what it looks
like when triggering the resize through sysfs, and through amdgpu's
probe-on-insmod, on the actual root-bus hardware (HoneyComb LX2K,
LX2160A, dGPU directly on the root bus, no upstream bridge).

Manual trigger via sysfs (shrink then grow back, forcing the release
+ reassign path both directions):

  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa4ffffffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 2 [mem 0xa500000000-0xa5001fffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: assigned
  ...
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa4ffffffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 2 [mem 0xa500000000-0xa5001fffff 64bit pref]: assigned

And the real-world path, amdgpu's own probe with the amdgpu.rebar=0
workaround removed:

  amdgpu 0004:01:00.0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
  amdgpu 0004:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
  amdgpu 0004:01:00.0:  4096M of VRAM memory ready

No "Fatal error during GPU init" (the original regression's failure
signature), full IP block init, driver comes up clean.
