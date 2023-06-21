Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B4EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 07:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FB610E62B;
	Fri, 23 Jun 2023 07:29:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AEE10E337;
 Wed, 21 Jun 2023 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=6WA3GXEESmxypvEyfFrL5uv4yC5/yc2PeWiHyP0/kFg=; b=jAR7VSWfsOiZvPQRWvfZ2NZjiN
 u8ceeRk9ZsuwLMn8AlYC16evp29iYpzUudOF2rR7oo3CoOh8zWOqvZG3DjtQNIYhFAW1zHzuRA64i
 gX6Kh0SKw1KNU3J/dr5DyzRnlVR4WWysO8U1/IS/P5ISI66I9bNN7tjCYnXCBsRK926o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qC148-00HAOG-F0; Wed, 21 Jun 2023 18:52:20 +0200
Date: Wed, 21 Jun 2023 18:52:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
X-Mailman-Approved-At: Fri, 23 Jun 2023 07:28:58 +0000
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
Cc: jingyuwang_vip@163.com, bellosilicio@gmail.com, rafael@kernel.org,
 trix@redhat.com, lijo.lazar@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mdaenzer@redhat.com, airlied@gmail.com,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, lenb@kernel.org, andrealmeid@igalia.com, daniel@ffwll.ch,
 arnd@arndb.de, maarten.lankhorst@linux.intel.com, hdegoede@redhat.com,
 jsg@jsg.id.au, Evan Quan <evan.quan@amd.com>, jim.cromie@gmail.com,
 netdev@vger.kernel.org, Xinhui.Pan@amd.com, linux-wireless@vger.kernel.org,
 edumazet@google.com, christian.koenig@amd.com, tzimmermann@suse.de,
 alexander.deucher@amd.com, Johannes Berg <johannes@sipsolutions.net>,
 davem@davemloft.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 21, 2023 at 11:15:00AM -0500, Limonciello, Mario wrote:
> 
> On 6/21/2023 10:39 AM, Johannes Berg wrote:
> > On Wed, 2023-06-21 at 17:36 +0200, Andrew Lunn wrote:
> > > On Wed, Jun 21, 2023 at 01:45:56PM +0800, Evan Quan wrote:
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > Due to electrical and mechanical constraints in certain platform designs
> > > > there may be likely interference of relatively high-powered harmonics of
> > > > the (G-)DDR memory clocks with local radio module frequency bands used
> > > > by Wifi 6/6e/7.
> > > > 
> > > > To mitigate this, AMD has introduced an ACPI based mechanism that
> > > > devices can use to notify active use of particular frequencies so
> > > > that devices can make relative internal adjustments as necessary
> > > > to avoid this resonance.
> > > Do only ACPI based systems have:
> > > 
> > >     interference of relatively high-powered harmonics of the (G-)DDR
> > >     memory clocks with local radio module frequency bands used by
> > >     Wifi 6/6e/7."
> > > 
> > > Could Device Tree based systems not experience this problem?
> > They could, of course, but they'd need some other driver to change
> > _something_ in the system? I don't even know what this is doing
> > precisely under the hood in the ACPI BIOS, perhaps it adjusts the DDR
> > memory clock frequency in response to WiFi using a frequency that will
> > cause interference with harmonics.
> 
> The way that WBRF has been architected, it's intended to be able
> to scale to any type of device pair that has harmonic issues.

So you set out to make something generic...

> In the first use (Wifi 6e + specific AMD dGPUs) that matches this
> series BIOS has the following purposes:
> 
> 1) The existence of _DSM indicates that the system may not have
> adequate shielding and should be using these mitigations.
> 
> 2) Notification mechanism of frequency use.
> 
> For the first problematic devices we *could* have done notifications
> entirely in native Linux kernel code with notifier chains.
> However that still means you need a hint from the platform that the
> functionality is needed like a _DSD bit.
> 
> It's also done this way so that AML could do some of the notifications
> directly to applicable devices in the future without needing "consumer"
> driver participation.

And then tie is very closely to ACPI.

Now, you are AMD, i get that ACPI is what you have. But i think as
kernel Maintainers, we need to consider that ACPI is not the only
thing used. Do we want the APIs to be agnostic? I think APIs used by
drivers should be agnostic.

      Andrew
