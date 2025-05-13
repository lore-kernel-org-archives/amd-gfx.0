Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6794C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404EB10E012;
	Tue, 13 May 2025 19:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PkPY5pL2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD11F10E012
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:45:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E7E8438A2;
 Tue, 13 May 2025 19:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A754FC4CEE4;
 Tue, 13 May 2025 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747165510;
 bh=m9PROLho9+GpxfHp1Yilj0rhBbOgkLCMH6RLWWDqqQU=;
 h=Date:From:To:Cc:Subject:From;
 b=PkPY5pL2cqq/9uWKgMH02QSDVG0wir6GfxHhwQbqZq9vdSLF0ozqAZfByn9uU88aQ
 3mgsQT9ALs1nLRF8N8BD4e0qXJ2KUviUbG8aNoTQ84gMQ+1410vnvkH4H76JA3iu5p
 L2ShPEGIkk9AagaGaPTUFoataB3//rndG5/J1o5YYUjJKCnQ1kSxcwbLw+Y1OkUjBK
 v7e2Ls6IlFrICjHtZCGJdTq5lf4Hv6nD2YiIKXfjAtqmbHnc+7G7zG7D9WO9FnpuWg
 AMLB7czEtbNqIfM5ONCw8e62VyayTzomZczmA0kACJBssioOHdp3t4mnkRxNymg1QQ
 MID06mosndBJA==
Date: Tue, 13 May 2025 14:45:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Yijun Shen <Yijun_Shen@dell.com>, David Perry <david.perry@amd.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, AceLan Kao <acelan.kao@canonical.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [Bug 220110] probably thunderbolt or pci leads to pci usage counter
 underflow
Message-ID: <20250513194506.GA1155899@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From Denis's report at https://bugzilla.kernel.org/show_bug.cgi?id=220110:

> I am having problems with my laptop that has a thunderbolt
> controller to which I connected an AMD 6750XT.
> 
> The topology of my system is described in this bug:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4014 yet I don't
> know if this is related or not.
> 
> I experienced PC attempting to enter s2idle while playing a YT
> video; PC has become totally unresponsive to input in any
> keyboard/mouse and power button after turning off screens attached
> to the AMD card (the built-in screen was off already).
> 
> From a look at the logs it appears one uncorrectible AER pci error
> triggered a pci root reset, and that comes with a bug where the
> usage counter assumes a wrong value; this in turn seems to cause all
> sorts of weird bugs.
> 
> That however is my interpretation of the attached log, that might be
> very wrong.
> 
> This is the first time I experience this bug in a year with this
> laptop and I don't know how easy it is to reproduce.
> 
> The kernel has been compiled from sources and it has
>
>   [PATCH v2] PCI: Explicitly put devices into D0 when initializing
>   [PATCH v4] PCI/PM: Put devices to low power state on shutdown
> 
> as I am helping testing things. I find unlikely any of those might
> cause these issues especially "PCI: Explicitly put devices into D0
> when initializing" that has been there for a few weeks now.
> 
> Thanks in advice to whoever will help me.
