Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7ABEE49A4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 13:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F41C10E359;
	Tue, 22 Aug 2023 13:09:56 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F8F10E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 07:11:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED2764D88;
 Tue, 22 Aug 2023 07:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C08C43140;
 Tue, 22 Aug 2023 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1692688268;
 bh=OSFmIc6DjVqzpF68MG32L32Nfk/PkwF+T/iEcUfE7zI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yFhT1h6G7GQs4G8xdXWO83os1xmaegpIyyVgziAzY/RjT4jaPabj1XFXBMGL/iE0W
 IHtR6aNZw4QOeK7FZqjtRLpC+fVw62vbtkU06cUtNIRZiBgB1yiGvLyyej+vglfWid
 24ydufv4IeSFNst1ft204xjSah4Qbu3Wjk6I543w=
Date: Tue, 22 Aug 2023 08:39:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023082247-synthesis-revenge-470d@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
 <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
X-Mailman-Approved-At: Tue, 22 Aug 2023 13:09:54 +0000
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
Cc: Andrew Lunn <andrew@lunn.ch>, pabeni@redhat.com, rafael@kernel.org,
 linux-wireless@vger.kernel.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org, alexander.deucher@amd.com,
 kuba@kernel.org, johannes@sipsolutions.net, Evan Quan <evan.quan@amd.com>,
 quic_jjohnson@quicinc.com, davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
> So I wonder if the right answer is to put it in drivers/net/wireless
> initially and if we come up with a need later for non wifi producers we can
> discuss moving it at that time.

Please do so.

thanks,

greg k-h
