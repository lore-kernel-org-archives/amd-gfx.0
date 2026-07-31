Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF33C54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 04:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0B610E0F6;
	Fri, 31 Jul 2026 04:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DW0XC/cH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04FA10E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 04:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E1F42ADA;
 Fri, 31 Jul 2026 04:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5681F000E9;
 Fri, 31 Jul 2026 04:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785473660;
 bh=gz9IeFPSoLgLBkMqwdQbz/x2Xq199GuCvUcOcn38T20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DW0XC/cHHatdpX53bCvejWdsEzoVaBGi4E07PZUFINZ2CAu+Oc0S/269e0/BuaWoW
 3/OZlxu0asNybkDArSeEX+7NdLjSjM8b9yDpUjpr6rRtdBe0GnXRLQSCaAc2Yal+PB
 rlrXmjvNteTpx5oLuJKlkcyGqQpkvLgwOOBTlc6DXfJhE64NmyAMXktoeSqHc3wTrK
 wqBkRLVTAA+rHKRZsyfdbr/0x8C2qHNvQM5KXzYkB1njbrmv76T3DOcsR+RrwapGeb
 8mL0yrXMio/Z1QNIINlmLKrpz9AZHkvbncFWGMxJFJlDe/hZhby0z7YTX8aedksU8T
 qxGINhKxMt3Gg==
Date: Fri, 31 Jul 2026 13:54:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: lizf@honeycomb.io
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Jon Nettleton <jon@solid-run.com>, 
 Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Message-ID: <20260731044456.GA257970@rocinante>
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
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

Hello,

> Assign the released BARs directly from the root bus windows when there
> is no upstream bridge. On failure, roll back through the existing
> restore path exactly as in the bridged case.
> 
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.

Thank you for also fixing this pci_bus_sem imbalance, appreciated.

With that,

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
