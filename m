Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B88DC38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 19:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135DA10E16C;
	Tue, 25 Oct 2022 19:55:37 +0000 (UTC)
X-Greylist: delayed 82910 seconds by postgrey-1.36 at gabe;
 Tue, 25 Oct 2022 19:32:49 UTC
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6DA890EA;
 Tue, 25 Oct 2022 19:32:49 +0000 (UTC)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
 id 6C71B4245C; Tue, 25 Oct 2022 20:32:48 +0100 (BST)
Date: Tue, 25 Oct 2022 20:32:48 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Message-ID: <20221025193248.GA21457@srcf.ucam.org>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-3-hdegoede@redhat.com>
 <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 25 Oct 2022 19:55:31 +0000
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
Cc: Pan@freedesktop.org, Karol Herbst <kherbst@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
 David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>, Jani Nikula <jani.nikula@intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Mark Gross <markgross@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Xinhui <Xinhui.Pan@amd.com>,
 Lukas Wunner <lukas@wunner.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 25, 2022 at 08:50:54PM +0200, Hans de Goede wrote:

> That is a valid point, but keep in mind that this is only used on ACPI
> platforms and then only on devices with a builtin LCD panel and then
> only by GPU drivers which actually call acpi_video_get_backlight_type(),
> so e.g. not by all the ARM specific display drivers.
> 
> So I believe that Chromebooks quite likely are the only devices with
> this issue.

My laptop is, uh, weird, but it falls into this category.
 
> > I think for this to work correctly you need to have 
> > the infrastructure be aware of whether or not a vendor interface exists, 
> > which means having to handle cleanup if a vendor-specific module gets 
> > loaded later.
> 
> Getting rid of the whole ping-ponging of which backlight drivers
> get loaded during boot was actually one of the goals of the rework
> which landed in 6.1 this actually allowed us to remove some quirks
> because some hw/firmware did not like us changing our mind and
> switching backlight interfaces after first poking another one.
> So we definitely don't want to go back to the ping-pong thing.

Defaulting to native but then having a vendor driver be able to disable 
native drivers seems easiest? It shouldn't be a regression over the 
previous state of affairs since both drivers were being loaded already.
