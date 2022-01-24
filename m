Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ABCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A7110E333;
	Mon, 24 Jan 2022 17:04:38 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183E010E333
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:04:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C19E1B8114A;
 Mon, 24 Jan 2022 17:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A9C340EA;
 Mon, 24 Jan 2022 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643043875;
 bh=insQqMWnYMCGenvJ/GiGEQqwN5YovpVzQGFYxKA9tQg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PQnJEytBbZhtef4QS9fYOrX+Ch7nDfVnbG/JevXc/AFMdYQHZSDqJKIGTkB44ufwF
 V+18bE2CqrzYJ5hpVKIoii/NkUIZVgtlYwpzC+kdYmDhO/owqtkSnVpYY3MCWncTdd
 zsWneK3qAoWa9TL8pJNluNkNXT53C83adwivI2Q1UVUGvgTwXLnvtSazcvdKC42x36
 SQeMO73zU+UoAO/1q0Lxp7bifAxhzWk0oG3USUAnvA1VvcWtY3cgdS1DuUTI2cn7Zd
 Di3bjkEISM7VrAR64kwxah+grsjKM6XDhV4ePKo6AbZVK75wfPm3/md4voEHGx9klT
 DXM0UH/8fD42g==
Date: Mon, 24 Jan 2022 09:04:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.17-rc1
Message-ID: <20220124090433.1951e2ea@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mips@vger.kernel.org,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 24 Jan 2022 08:55:40 +0100 (CET) Geert Uytterhoeven wrote:
> >  + /kisskb/src/drivers/net/ethernet/freescale/fec_mpc52xx.c: error: passing argument 2 of 'mpc52xx_fec_set_paddr' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 659:29  
> 
> powerpc-gcc5/ppc32_allmodconfig
> 
> >  + /kisskb/src/drivers/pinctrl/pinctrl-thunderbay.c: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 815:8, 815:29  
> 
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig

Let me take care of these in net.
