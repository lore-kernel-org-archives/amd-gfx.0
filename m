Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B386EE49A5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A321110E205;
	Mon, 21 Aug 2023 07:46:06 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5FC10E013
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Aug 2023 10:50:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5420A6222A;
 Sat, 19 Aug 2023 10:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AB7C433C8;
 Sat, 19 Aug 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1692442210;
 bh=UOf0VrNbj7jijgQLUEJOQOBTWQ8bE2tlLoIK1cWZfF4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kei/cEnCzd9vylrM81C/pPpoNImWO9ct/BfmNbABJtoIAiUdlMrA6QirCewN8nGsl
 E+/EyT5QuE5r/CU3d6rHBMKoRtj1M4beqjlpX4igDLY31/WCHuJE9cep162hACy+zA
 MkHvny2Q8i8kBUce3Avd2yXp9bzBiQ31Ho3RWg+I=
Date: Sat, 19 Aug 2023 12:50:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023081919-mockup-bootleg-bdb9@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
X-Mailman-Approved-At: Mon, 21 Aug 2023 07:46:03 +0000
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

On Fri, Aug 18, 2023 at 05:49:14PM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/18/2023 4:24 PM, Greg KH wrote:
> > On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
> > >   drivers/base/Makefile                         |   1 +
> > >   drivers/base/wbrf.c                           | 280 ++++++++++++++++++
> > 
> > Why is a wifi-specific thing going into drivers/base/?
> > 
> > confused,
> > 
> > greg k-h
> 
> The original problem statement was at a high level 'there can be
> interference between different devices operating at high frequencies'. The
> original patches introduced some ACPI library code that enabled a mitigated
> for this interference between mac80211 devices and amdgpu devices.
> 
> Andrew Lunn wanted to see something more generic, so the series has morphed
> into base code for things to advertise frequencies in use and other things
> to listen to frequencies in use and react.
> 
> The idea is supposed to be that if the platform knows that these mitigations
> are needed then the producers send the frequencies in use, consumers react
> to them.  The AMD implementation of getting this info from the platform
> plugs into the base code (patch 2).
> 
> If users don't want this behavior they can turn it off on kernel command
> line.
> 
> If the platform doesn't know mitigations are needed but user wants to turn
> them on anyway they can turn it on kernel command line.

That's all fine, I don't object to that at all.  But bus/device-specific
stuff should NOT be in drivers/base/ if at all possible (yes, we do have
some exceptions with hypervisor.c and memory and cpu stuff) but for a
frequency thing like this, why can't it live with the other
wifi/frequency code in drivers/net/wireless/?

In other words, what's the benefit to having me be the maintainer of
this, someone who knows nothing about this subsystem, other than you
passing off that work to me?  :)

thanks,

greg k-h
