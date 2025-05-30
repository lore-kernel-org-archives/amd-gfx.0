Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D86C5AE59
	for <amd-gfx@archiver.kernel.org>; Sat, 31 May 2025 16:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D810F10E2E8;
	Sat, 31 May 2025 16:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mr8JX08o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E390210E815
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748625797; x=1780161797;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LtRRKOvFNPh4KPAIWtI8ZscFptnvxHt2EGEbh94LZIs=;
 b=mr8JX08oSmjXCHPIcPY6ajO8EJoVrMnJm5ltgcYwGUDh+yEP+u42sVpO
 MVaL65Ptmr3ygYV3w5y5NIdxXvP0bBZzuZiNHEj/8HVgwG/CYCK/siYOu
 v2Hu0q3yUHg/zjS8Lj9T5bgvJ21Vb9/ZheZVMKRvmEO+vgD4CihcDpF5t
 5pDs7CsOI3QiyJ68jtuaRgp/IL7YGvuIjZPL8ZP4NTWRZNhyXRcThbuEy
 pQbjOcWF9m1g2h38ap6kPTQpjYbf3uf21MCEe1Rpz1TS2sc1mv3brNPa3
 smDtk8jHuQeLuTTTtG0g590TyGEjVszCB6aBJ4Wxlxv9xFQ551VhOqokb A==;
X-CSE-ConnectionGUID: JfkwO+KKRhaMxdVrmwyBsw==
X-CSE-MsgGUID: tmARxex9TaevymJle9Vl9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="53358154"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="53358154"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 10:23:16 -0700
X-CSE-ConnectionGUID: mLev60PqRjq57WMIW+1/gw==
X-CSE-MsgGUID: TXtpvKYOQcS9ic/fGl60qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="143961547"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 10:23:12 -0700
Date: Fri, 30 May 2025 20:23:08 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com,
 oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
 aravind.iddamsetty@linux.intel.com,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
Message-ID: <aDnpfKvLwRZsKxhH@black.fi.intel.com>
References: <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
X-Mailman-Approved-At: Sat, 31 May 2025 16:59:21 +0000
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

On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > > > > On 5/20/2025 12:22 PM, Denis Benato wrote:
> > > > > > > On 5/20/25 17:49, Mario Limonciello wrote:
> > > > > > > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > > > > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello wrote:
> > > > > > > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
> > > > > > > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
> > > > > > > > > > > > > > If error status is set on an AER capable device, most likely either the
> > > > > > > > > > > > > > device recovery is in progress or has already failed. Neither of the
> > > > > > > > > > > > > > cases are well suited for power state transition of the device, since
> > > > > > > > > > > > > > this can lead to unpredictable consequences like resume failure, or in
> > > > > > > > > > > > > > worst case the device is lost because of it. Leave the device in its
> > > > > > > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > > > > > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> > > > > > > > > > > > > >         Elaborate "why" (Bjorn)
> > > > > > > > > > > > > > v4: Rely on error status instead of device status
> > > > > > > > > > > > > >         Condense comment (Lukas)
> > > > > > > > > > > > > Since pci_aer_in_progress() is changed I've not included Rafael's tag with
> > > > > > > > > > > > > my understanding of this needing a revisit. If this was a mistake, please
> > > > > > > > > > > > > let me know.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > > > > > >
> > > > > > > > > > > > Hello,
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the test. It seems there's no hotplug event this time around
> > > > > > > > > > > and endpoint device is still intact without any PCI related failure.
> > > > > > > > > > >
> > > > > > > > > > > Also,
> > > > > > > > > > >
> > > > > > > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> > > > > > > > > > >
> > > > > > > > > > > Which means whatever you're facing is either not related to this patch,
> > > > > > > > > > > or at best exposed some nasty side-effect that's not handled correctly
> > > > > > > > > > > by the driver.
> > > > > > > > > > >
> > > > > > > > > > > I'd say amdgpu folks would be of better help for your case.
> > > > > > > > > > >
> > > > > > > > > > > Raag
> > > > > > > > > >
> > > > > > > > > > So according to the logs Denis shared with v4
> > > > > > > > > > (https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. This
> > > > > > > > > > stands for "Bus off Chip Off"
> > > > > > > > > >
> > > > > > > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
> > > > > > > > > >
> > > > > > > > > > If it's going to D3hot - that's not going to be BOCO, it should be going to
> > > > > > > > > > D3cold.
> > > > > > > > >
> > > > > > > > > Yes, because upstream port is in D0 for some reason (might be this patch
> > > > > > > > > but not sure) and so will be the root port.
> > > > > > > > >
> > > > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > > > > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > > > > > >
> > > > > > > > > and my best guess is the driver is not able to cope with the lack of D3cold.
> > > > > > > >
> > > > > > > > Yes; if the driver is configured to expect BOCO (D3cold) if it doesn't get it, chaos ensues.
> > > > > > > >
> > > > > > > > I guess let's double check the behavior with CONFIG_PCI_DEBUG to verify this patch is what is changing that upstream port behavior.
> > > > > > >
> > > > > > >
> > > > > > > This is the very same exact kernel, minus the patch in question:  https://pastebin.com/rwMYgG7C
> > > > > > >
> > > > > > >
> > > > > > > Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
> > > > > > >
> > > > > > > Removed the initial bootup sequence to be able to use pastebin.
> > > > > >
> > > > > > Thanks - this confirms that the problem is the root port not going to D3.
> > > > > > This new log shows:
> > > > > >
> > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> > > > > >
> > > > > > So I feel we should fixate on solving that.
> > > > >
> > > > > Which means what you're looking for is error flag being set somewhere in
> > > > > the hierarchy that is preventing suspend.
> > > >
> > > > Is the issue perhaps that this is now gated on both correctable and
> > > > uncorrectable errors?
> > > >
> > > > Perhaps should *correctable errors* be emitted with a warning and the
> > > > *uncorrectable errors* be fatal?
> > >
> > > That'd be more or less inline with hiding the issue, and it can also race
> > > with err_handler callback if driver has registered it.
> > >
> > > > > But regardless of it, my understanding is that root port suspend depends
> > > > > on a lot of factors (now errors flags being one of them with this patch)
> > > > > and endpoint driver can't possibly enforce or guarantee it - the best it
> > > > > can do is try.
> > > > >
> > > > > What's probably needed is D3cold failure handling on driver side, but I'm
> > > > > no PCI PM expert and perhaps Rafael can comment on it.
> > > > >
> > > > > Raag
> > > >
> > > > From the driver perspective it does have expectations that the parts outside
> > > > the driver did the right thing.  If the driver was expecting the root port
> > > > to be powered down at suspend and it wasn't there are hardware components
> > > > that didn't power cycle and that's what we're seeing here.
> > >
> > > Which means the expectation set by the driver is the opposite of the
> > > purpose of this patch, and it's going to fail if any kind of error is
> > > detected under root port during suspend.
> >
> > And IMV this driver's expectation is questionable at least.
> >
> > There is no promise whatsoever that the device will always be put into
> > D3cold during system suspend.
> 
> For instance, user space may disable D3cold for any PCI device via the
> d3cold_allowed attribute in sysfs.
> 
> If the driver cannot handle this, it needs to be fixed.

Thanks for confirming. So should we consider this patch to be valid
and worth moving forward?

Raag
