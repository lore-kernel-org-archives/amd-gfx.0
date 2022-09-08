Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD075C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 17:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FFB10EB82;
	Thu,  8 Sep 2022 17:57:22 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD9A10EB82
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 17:57:18 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A7817B821DB;
 Thu,  8 Sep 2022 17:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3378EC433D6;
 Thu,  8 Sep 2022 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662659835;
 bh=uZfFIqsRWazbXAP45uG9K0OoUJg/6eu/HYgMykx8qIE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Z2HZFiYCfBwee2sqmgFthWoQK0iVgmnrd++jxaAV7ZsH85r04ECjdzKI/eP9hk5+5
 M+YgfpfT7H6K7kaF6spvjJSVFdxO8jdpUgS261azKSGNJIWVQ1wieOkGKs9zQMnyo2
 pFn4bz7LZcyZCi0ong90t2ERkTvSGKZzWtpoLbWFPa7LmGDYErwMGE7NhLu4/sb7Iy
 q1Kwfd27n4ojbwnTnB3oUihn6SNsHJtW4cJbcthdNMiOcjGW+kfKVoxbRYavCP9AtZ
 eRj2wMnzq0z92SOoNcjzq3Z+J3JDNL8k5rSiOWhYl6bU88kj7+diO/+VjsIR50OdxQ
 cECFsjjp6fslg==
Date: Thu, 8 Sep 2022 12:57:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported
Message-ID: <20220908175713.GA206965@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB461445ADFB5D36D863AA3C3C97409@BYAPR12MB4614.namprd12.prod.outlook.com>
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
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 "wielkiegie@gmail.com" <wielkiegie@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 08, 2022 at 04:42:38PM +0000, Lazar, Lijo wrote:
> I am not sure if ASPM settings can be generalized by PCIE core.
> Performance vs Power savings when ASPM is enabled will require some
> additional tuning and that will be device specific.

Can you elaborate on this?  In the universe of drivers, very few do
their own ASPM configuration, and it's usually to work around hardware
defects, e.g., L1 doesn't work on some e1000e devices, L0s doesn't
work on some iwlwifi devices, etc.

The core does know how to configure all the ASPM features defined in
the PCIe spec, e.g., L0s, L1, L1.1, L1.2, and LTR.

> In some of the other ASICs, this programming is done in VBIOS/SBIOS
> firmware. Having it in driver provides the advantage of additional
> tuning without forcing a VBIOS upgrade.

I think it's clearly the intent of the PCIe spec that ASPM
configuration be done by generic code.  Here are some things that
require a system-level view, not just an individual device view:

  - L0s, L1, and L1 Substates cannot be enabled unless both ends
    support it (PCIe r6.0, secs 5.4.1.4, 7.5.3.7, 5.5.4).

  - Devices advertise the "Acceptable Latency" they can accept for
    transitions from L0s or L1 to L0, and the actual latency depends
    on the "Exit Latencies" of all the devices in the path to the Root
    Port (sec 5.4.1.3.2).

  - LTR (required by L1.2) cannot be enabled unless it is already
    enabled in all upstream devices (sec 6.18).  This patch relies on
    "ltr_path", which works now but relies on the PCI core never
    reconfiguring the upstream path.

There might be amdgpu-specific features the driver needs to set up,
but if drivers fiddle with architected features like LTR behind the
PCI core's back, things are likely to break.

> From: Alex Deucher <alexdeucher@gmail.com>
> On Thu, Sep 8, 2022 at 12:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Do you know why the driver configures ASPM itself?  If the PCI core is
> > doing something wrong (and I'm sure it is, ASPM support is kind of a
> > mess), I'd much prefer to fix up the core where *all* drivers can
> > benefit from it.
> 
> This is the programming sequence we get from our hardware team and it
> is used on both windows and Linux.  As far as I understand it windows
> doesn't handle this in the core, it's up to the individual drivers to
> enable it.  I'm not familiar with how this should be enabled
> generically, but at least for our hardware, it seems to have some
> variation compared to what is done in the PCI core due to stability,
> etc. It seems to me that this may need asic specific implementations
> for a lot of hardware depending on the required programming sequences.
> E.g., various asics may need hardware workaround for bugs or platform
> issues, etc.  I can ask for more details from our hardware team.

If the PCI core has stability issues, I want to fix them.  This
hardware may have its own stability issues, and I would ideally like
to have drivers use interfaces like pci_disable_link_state() to avoid
broken things.  Maybe we need new interfaces for more subtle kinds of
breakage.

Bjorn
