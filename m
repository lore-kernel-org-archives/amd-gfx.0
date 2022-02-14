Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EFBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 08:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBD210E190;
	Mon, 14 Feb 2022 08:59:47 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.36 at gabe;
 Mon, 14 Feb 2022 08:59:46 UTC
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4100410E190;
 Mon, 14 Feb 2022 08:59:46 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
 by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0240A100D942B;
 Mon, 14 Feb 2022 09:52:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id D49112D92C; Mon, 14 Feb 2022 09:52:02 +0100 (CET)
Date: Mon, 14 Feb 2022 09:52:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <20220214085202.GA21533@wunner.de>
References: <20220211193250.1904843-6-mario.limonciello@amd.com>
 <20220211214546.GA737137@bhelgaas> <YgoGAkjZgCob8Mdl@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgoGAkjZgCob8Mdl@lahna>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 14, 2022 at 09:34:26AM +0200, Mika Westerberg wrote:
> On Fri, Feb 11, 2022 at 03:45:46PM -0600, Bjorn Helgaas wrote:
> > My expectation is that "USB" (like "PCI" and "PCIe") tells me
> > something about how a device is electrically connected and how
> > software can operate it.  It doesn't really tell me anything about
> > whether those electrical connections are permanent, made through an
> > internal slot, or made through an external connector and cable.
> 
> It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
> DisplayPort). Tunnels are created by software (in Linux it is the
> Thunderbolt driver) and are dynamic in nature. The USB4 links go over
> USB Type-C cable which also is something user can plug/unplug freely.
> 
> I would say it is reasonable expectation that anything behind these
> ports can be assumed as "removable".

USB gadgets may be soldered to the mainboard.  Those cannot be
unplugged freely.  It is common practice to solder USB Ethernet
or USB FTDI serial ports and nothing's preventing a vendor to solder
USB4/Thunderbolt gadgets.
