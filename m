Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B494C3DA7F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02CB10E4E4;
	Tue, 30 Jul 2024 07:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JmrfFXmG";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E33F10E2D6;
 Tue, 30 Jul 2024 06:20:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1447F61B7C;
 Tue, 30 Jul 2024 06:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48211C4AF09;
 Tue, 30 Jul 2024 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1722320458;
 bh=ZEn+kLQh+MCk0r4OKoaJ3rs4HBr/OuaPYlVIDQjhFZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JmrfFXmGjMwrYowxZg80Od6UI+qnsVaIH7qtah4m2wZpfj/XrPE90VovwNrzrjkGm
 6kBkvs6sIpWmCQZyT/1TGWViL3CnjErkVHJ+lkwMCWMkf76N7yO44CoHI0baczNS7M
 7lwNzo/U3nQlmmOhhjBACJoJnQwK1OtJb0KEll/4=
Date: Tue, 30 Jul 2024 08:20:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "kevin@holm.dev" <kevin@holm.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] No image on 4k display port displays connected
 through usb-c dock in kernel 6.10
Message-ID: <2024073028-rectified-antler-a65b@gregkh>
References: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
 <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
 <fd8ece71459cd79f669efcfd25e4ce38b80d4164@holm.dev>
 <CO6PR12MB54896312D4BEAE30963FDC5EFCB02@CO6PR12MB5489.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR12MB54896312D4BEAE30963FDC5EFCB02@CO6PR12MB5489.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Tue, 30 Jul 2024 07:54:54 +0000
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

On Tue, Jul 30, 2024 at 05:56:42AM +0000, Lin, Wayne wrote:
> [Public]
> 
> Hi,
> Thanks for the report.
> 
> Patch fa57924c76d995 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
> is kind of correcting problems causing by commit:
> 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
> 
> Sorry if it misses fixes tag and would suggest to backport to fix it. Thanks!

Please submit a backported version to the stable@vger.kernel.org list
and we will be glad to consider it.

thanks,

greg k-h
