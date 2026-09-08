Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7EDC79FB8
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0BF10EF63;
	Wed,  9 Sep 2026 06:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.b="Cqox37/R";
	dkim-atps=neutral
X-Greylist: delayed 373 seconds by postgrey-1.36 at gabe;
 Tue, 08 Sep 2026 19:29:52 UTC
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io
 [149.72.141.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F2810E165
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
 h=from:subject:date:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
 s=s1; t=1788895457;
 bh=deZpy86mdL+0FuQa302UpRu/UqHamHeqdhK2hRsukYY=;
 b=Cqox37/RxfSoxCDREwmfIPUkJ0lcViR12E/3Dn2uFcp6tIy6IW8vUfelqSwsMqfWfdsY
 NMiioaWE2yR+3kHDyYiX2rk2pJgiggmxGV7aYxKchRKu/OS4xnF78kqJUqm5lDQ9egtBnu
 07+ZCJ7q0Nj7PN6ToCW52wkmeodeEvc8Zn0W3JH0MlnstODJTkLz10VFpqEfjH2G3oe0l9
 c/pzaW0b0RgZ9QWX9Ii3AQLMwQiO+eEtvZgTEyD4aMdxDCve2Ej/nUqwjEZpF7HERhLizV
 l1kOQTv++qtc2eu5QwAHMompuEkr1Yc9O2NN3HmlY0GAAd3fkHcml4zHwivx9P/A==
Received: by recvd-b9cff7684-gvzpt with SMTP id
 recvd-b9cff7684-gvzpt-1-6AA060E1-35
 2026-09-08 19:24:17.30759247 +0000 UTC m=+3630789.492945539
Received: from daisy.dens.ffj.family (unknown) by geopod-ismtpd-58 (SG)
 with ESMTP id gMk5nyFdTC6pjARQljyq8g
 Tue, 08 Sep 2026 19:24:17.127 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 19:24:17 +0000 (UTC)
Message-ID: <20260908192415.48843-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4db878f3-1c55-4ecb-93d8-a97a5e0c7a29@leemhuis.info>
References: <4db878f3-1c55-4ecb-93d8-a97a5e0c7a29@leemhuis.info>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeYtV+MVTZw+O?=
 =?us-ascii?Q?DXUD7zff+Q6gIw0rZAuCnUYZjLK8jUMlsBaIOkJ?=
 =?us-ascii?Q?ufBXuikqhX6NmCmaxaKjMqM8YQqVnbzriPvtcnn?=
 =?us-ascii?Q?uu0g2fkMD+x6qg+1wFPTrKwEHHjNv2wTGiblC6Z?=
 =?us-ascii?Q?hrOl6pPWtxFk9N8YsR7QI1aXRTzgMkrrUytI5nC?= =?us-ascii?Q?so1U?=
To: regressions@leemhuis.info
Cc: bhelgaas@google.com, bjorn.helgaas@gmail.com, helgaas@kernel.org,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, jon@solid-run.com, 
 jon.nettleton@gmail.com, jacob.martin@canonical.com, stable@vger.kernel.org,
 kwilczynski@kernel.org, lizf@honeycomb.io, linux-pci@vger.kernel.org
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:56:16 +0000
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

On 9/3/26, Thorsten Leemhuis wrote:
> Liz Fong-Jones: is this regression fix still needed with 7.3-rc1? I
> assume so. But if it is, I guess it would be good to state that; maybe
> reposting this might be even better, as I fear it might have fallen
> through the cracks.

Confirmed still present, and thanks for the nudge -- checked today
against both v7.3-rc2 (mainline) and v7.2.4 (stable):
pci_do_resource_release_and_resize() in drivers/pci/setup-bus.c still
has the original "if (!bus->self) goto out;" with no reassignment on
that path in both.

Reposted as v4, no functional changes from v3, just the resend plus
a rebase onto current mainline:

  https://patch.msgid.link/20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io

