Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA8C6FD1F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAD710E4BC;
	Mon, 13 Mar 2023 08:18:34 +0000 (UTC)
Received: from mifar.in (mifar.in [161.35.211.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E638110E153
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Mar 2023 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mifar.in;
 i=@mifar.in; q=dns/txt; s=mail; t=1678651235; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to : from; bh=6rcm1rd8qWCLlqcRhGRvxpek0mI1vpJnM7X7pkAgO8U=;
 b=m/0V7t12HgB34KxNf7e83TBF10/q83CNP4ZYr5AoNyz0RyVgaipLAJ/e+tgwBkKDC7guo
 9JLT4fMebOZc2WQ8RY9IITanL1nutNG+Nj4sQKB6OIv5ClucsnQQHrlaYwAosJq0P6qABLc
 L9nBkDPBqLcnqhsQKHWXmEXEHuOIgYrLDd90tIYpea1ok0MnpmXXDhyOjA6D/YdcrV5ZsxH
 D9GaCXPuOWqUhzIZp16sGznul6WDgz+jAysMKm4+XUwmKm2CgYxx5n2Y9CJQMhiBCXWGl/T
 IjUIELPPKlVGXyPDhFb3T12xkteSaKB4uve83IVukoELVJz6Li7aFH4j3OOA==
Received: from mifar.in (dsl-hkibng21-50dc5b-130.dhcp.inet.fi [80.220.91.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ED448 client-signature ED448)
 (Client CN "mutt.mifar.in", Issuer "ca.mifar.in" (verified OK))
 by mifar.in (Postfix) with ESMTPS id 74C693F25D
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Mar 2023 20:00:35 +0000 (UTC)
Date: Sun, 12 Mar 2023 22:00:33 +0200
From: Sami Farin <linuxamdgpu@mifar.in>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [amdgpu] [RX550] 6.1.15+ kernel system freeze when display
 turned off
Message-ID: <20230312200033.swfa7o33adjrlcyx@m.mifar.in>
Mail-Followup-To: Sami Farin <linuxamdgpu@mifar.in>,
 amd-gfx@lists.freedesktop.org
References: <20230312192654.lvam63yarnaaezir@m.mifar.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230312192654.lvam63yarnaaezir@m.mifar.in>
X-Mailman-Approved-At: Mon, 13 Mar 2023 08:18:21 +0000
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

On Sun, Mar 12, 2023 at 21:26:56 +0200, Sami Farin wrote:
>6.1.14 worked OK for 11 days, then I got the idea of updating this stable

Well now 6.1.14 crashed also, but not when suspending display.
I used Wayland normally for one hour.
Would you say GPU is getting old and cranky and I should buy a new one?

-- 

