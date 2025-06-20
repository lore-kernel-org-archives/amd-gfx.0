Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4551EC7115C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 13:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343F510EB63;
	Fri, 20 Jun 2025 13:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K+W5Q7w6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FAB10E21F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 12:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750421670; x=1781957670;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=akZkLO9HpvybIYtKa+1huJIJ17R706HAo3uzRMtFzvc=;
 b=K+W5Q7w6LR0mG5i5dwk+TnGOv64qb5FRZrLlaWeOrf9kC+PmvtkhmHOR
 lLk4wT/lxea748JiHwxRxJ6zEVs4vIMxYuTIrEUCrP8x6PLiKAAildxcF
 B3S4OWgbeuVFHjYo704GNhH4YfL9EB2LyA/GrnwNEInINgqupj8CxekH6
 BJLh0H5Ptd53XasRjhnI2koOWPI7USYPXy4lkiqInr4m2vY7o/7sUPIU+
 SMZHv8YT+kBpyG8A3XNRKf8FZYfd4XDjsXkmwij/k2s7ihNt5EOgvDhWi
 ZZsgUotQ+kNqiW7qJD648FSO7meC/hLV84hcD2THFPlXwldg/vdXYTnON A==;
X-CSE-ConnectionGUID: 3bhEz44zTZedoYARcDfybA==
X-CSE-MsgGUID: Fc+B10zdQ4u0UkmfJfr7mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52613105"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52613105"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 05:14:30 -0700
X-CSE-ConnectionGUID: 86AhDx93Q+CJrNlp9wdJzw==
X-CSE-MsgGUID: vVVico3cSyel5glwcJaBig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="150495286"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 05:14:26 -0700
Date: Fri, 20 Jun 2025 15:14:23 +0300
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
Message-ID: <aFVQn5N1srBuDkuP@black.fi.intel.com>
References: <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
 <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
 <aEGDL0IF10QX3Abr@black.fi.intel.com>
 <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
 <aEg2vzf6tn4j96LG@black.fi.intel.com>
 <CAJZ5v0iiPVWpWdAHJkzWCHGrUj5i5b8nN9G2_CAWUarc3Ryskg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iiPVWpWdAHJkzWCHGrUj5i5b8nN9G2_CAWUarc3Ryskg@mail.gmail.com>
X-Mailman-Approved-At: Fri, 20 Jun 2025 13:19:02 +0000
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

On Tue, Jun 10, 2025 at 03:53:10PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 10, 2025 at 3:44 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > On Thu, Jun 05, 2025 at 02:26:05PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jun 5, 2025 at 1:44 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jun 4, 2025 at 5:43 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Fri, May 30, 2025 at 7:23 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > > On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > > > > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > > > > From the driver perspective it does have expectations that the parts outside
> > > > > > > > > > > > the driver did the right thing.  If the driver was expecting the root port
> > > > > > > > > > > > to be powered down at suspend and it wasn't there are hardware components
> > > > > > > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > > > > > > >
> > > > > > > > > > > Which means the expectation set by the driver is the opposite of the
> > > > > > > > > > > purpose of this patch, and it's going to fail if any kind of error is
> > > > > > > > > > > detected under root port during suspend.
> > > > > > > > > >
> > > > > > > > > > And IMV this driver's expectation is questionable at least.
> > > > > > > > > >
> > > > > > > > > > There is no promise whatsoever that the device will always be put into
> > > > > > > > > > D3cold during system suspend.
> > > > > > > > >
> > > > > > > > > For instance, user space may disable D3cold for any PCI device via the
> > > > > > > > > d3cold_allowed attribute in sysfs.
> > > > > > > > >
> > > > > > > > > If the driver cannot handle this, it needs to be fixed.
> > > > > > > >
> > > > > > > > Thanks for confirming. So should we consider this patch to be valid
> > > > > > > > and worth moving forward?
> > > > > > >
> > > > > > > It doesn't do anything that would be invalid in principle IMV.
> > > > > > >
> > > > > > > You need to consider one more thing, though: It may be necessary to
> > > > > > > power-cycle the device in order to kick it out of the erroneous state
> > > > > > > and the patch effectively blocks this if I'm not mistaken.
> > > > > > >
> > > > > > > But admittedly I'm not sure if this really matters.
> > > > > >
> > > > > > Wouldn't something like bus reset (SBR) be more predictable?
> > > > >
> > > > > Maybe.
> > > > >
> > > > > The device state is most likely inconsistent in that case, so it depends.
> > > >
> > > > My limited understanding is that if SBR doesn't help, at that point all
> > > > bets are off including PMCSR configuration and probably a cold boot is
> > > > needed.
> > >
> > > I'm not talking about PMCSR, I'm talking about power removal (D3cold).
> > > This should be equivalent to a cold boot for the particular device
> > > except that cold boot would also reset the hierarchy above it.
> >
> > Sure. But for D3cold we rely on everything else under root port to also
> > be suspended, which we can't predict while in endpoint suspend path. And
> > with that we're back to "no guarantees" problem, which was the case either
> > way. The patch might just prevent any further damage than what's already
> > done.
> 
> Fair enough.

So anything I can do to move this forward?
Sorry I didn't include your tag since I changed the core logic.

Raag
