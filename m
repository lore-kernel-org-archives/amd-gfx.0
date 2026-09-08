Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE20C79FAA
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AC610EF62;
	Wed,  9 Sep 2026 06:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.b="Tp8/DpZr";
	dkim-atps=neutral
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io
 [149.72.141.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D694210E53B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
 h=from:subject:date:in-reply-to:references:mime-version:to:cc:
 content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
 s=s1; t=1788908617;
 bh=UvAuWdRNhxBj0zIQCudhRLv5rmtQK2pKzB9otIfWB+I=;
 b=Tp8/DpZrouDPj5p5W9hL6qnFC0t2gNV7V25Q/uWh5dsMHXp0BFTdIUm6z5//m4OWsycN
 wvmVA2WxjpYTd5wJu0koV8NidGH6xamxqxA6tf3kZa7ei+l2Wy9Y6RYIttJMaBM29Ff9Jq
 o9odSYAN4dtblVynT718T6vYx7xoPaH1s8mpmICadIHV7GQDEx9CZeCL9Rtmj3BuBS/W9T
 TDvPZrJWAstqiTmEw38Pi8jVa30AoDvPYgb5nNKtB+4Q6+5XWFOzOWTqq1JETxbXbiUsaX
 gDV+4dweWMWXIe/KdGChU0K+xs/qQPdnlonnkDya9Vk3PH1GGPfANFL+tBR8h79A==
Received: by recvd-75688db57b-dswf8 with SMTP id
 recvd-75688db57b-dswf8-1-6AA09449-12D
 2026-09-08 23:03:37.621995259 +0000 UTC m=+697365.363574854
Received: from daisy.dens.ffj.family (unknown) by geopod-ismtpd-102 (SG)
 with ESMTP id 8chTIw_2TIOU_JxuVrOLcw
 Tue, 08 Sep 2026 23:03:37.406 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 23:03:37 +0000 (UTC)
Message-ID: <20260908230335.62766-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
References: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeSz1FDEY+=2Fil?=
 =?us-ascii?Q?XfP63B3wHcxN57FkNN2flTO16G2tHBREDp1ByV9?=
 =?us-ascii?Q?6wkjKG3MiIiHMwHVO7E4PGFvnjAFPVfRfnhGynp?=
 =?us-ascii?Q?AJAGGbXCf9CVmgz24=2FPhFT6nlupJRnOhpBcvfuG?=
 =?us-ascii?Q?SEgEUlK6POoJDd5H=2F0CH1xxG9+5+Ojp3Zxgt+hn?= =?us-ascii?Q?LqAX?=
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, bjorn.helgaas@gmail.com, helgaas@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, jon@solid-run.com, 
 jon.nettleton@gmail.com, jacob.martin@canonical.com, stable@vger.kernel.org,
 kwilczynski@kernel.org, regressions@leemhuis.info, lizf@honeycomb.io
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

On Ilpo Järvinen wrote:
> Maybe this is what has to be done here, but I wonder if this could
> use pci_bus_assign_resources()?

Good suggestion, and it brings the else condition of this code into
alignment with your design goal that the core bookkeeping code should
be used as much as possible. Implemented in v5 (note to reviewers, I
am clearing reviewed-by as this is semantically different):

  https://patch.msgid.link/20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io

