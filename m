Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE1C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575BC10E808;
	Thu,  5 Jun 2025 13:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MUpfduGY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE8210E054
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 11:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749123894; x=1780659894;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NzPkbUkN3Txeqet1Im5YkbvnKI7AuzMxCQo+dJH86v4=;
 b=MUpfduGYAw1x0JIDF4qBYE6IVhrt+R485QcyczgCWzjOo2DCrfGKpnqi
 t5/nYQaJJTpHhi4wjtpYdyWckQPrX5Uv7tuEpTPp1JUNZXTypJI1s3pFk
 IDAVDI0q1BMuNeKXOWOg/gaL27bNHAVSLjyfRj/q+ek00z/sz2S+4Jcx+
 rmzKZrW665m1pGde4lzafH4PGcvwqi1gxpl+rq4Z/d0VcwYgBykYX806M
 bcWblCPVxOihwAvg39SFPIz6PeTVIWR3eyKXRn8G4ZOhHnIbnK0oHAnSf
 IOz/Q00KlB0pG+KoL7/IeKM7fDHaMb6b4my9LNMsoaYp2KeunpN6qtKEN w==;
X-CSE-ConnectionGUID: vtuiXBbmRYy9v31JimRlPw==
X-CSE-MsgGUID: wlQn0wBaSWWqZdTES8wjzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51236306"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51236306"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 04:44:54 -0700
X-CSE-ConnectionGUID: i+dOHlE1SJqrKaX++mLgSQ==
X-CSE-MsgGUID: rOi131nVRQSOXbJb9D8/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145364817"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 04:44:51 -0700
Date: Thu, 5 Jun 2025 14:44:47 +0300
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
Message-ID: <aEGDL0IF10QX3Abr@black.fi.intel.com>
References: <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
 <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
 <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com>
 <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
 <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
X-Mailman-Approved-At: Thu, 05 Jun 2025 13:00:18 +0000
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

On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 5:43 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, May 30, 2025 at 7:23 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, May 21, 2025 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > On Wed, May 21, 2025 at 10:54 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> >
> > ...
> >
> > > > > > > > From the driver perspective it does have expectations that the parts outside
> > > > > > > > the driver did the right thing.  If the driver was expecting the root port
> > > > > > > > to be powered down at suspend and it wasn't there are hardware components
> > > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > > >
> > > > > > > Which means the expectation set by the driver is the opposite of the
> > > > > > > purpose of this patch, and it's going to fail if any kind of error is
> > > > > > > detected under root port during suspend.
> > > > > >
> > > > > > And IMV this driver's expectation is questionable at least.
> > > > > >
> > > > > > There is no promise whatsoever that the device will always be put into
> > > > > > D3cold during system suspend.
> > > > >
> > > > > For instance, user space may disable D3cold for any PCI device via the
> > > > > d3cold_allowed attribute in sysfs.
> > > > >
> > > > > If the driver cannot handle this, it needs to be fixed.
> > > >
> > > > Thanks for confirming. So should we consider this patch to be valid
> > > > and worth moving forward?
> > >
> > > It doesn't do anything that would be invalid in principle IMV.
> > >
> > > You need to consider one more thing, though: It may be necessary to
> > > power-cycle the device in order to kick it out of the erroneous state
> > > and the patch effectively blocks this if I'm not mistaken.
> > >
> > > But admittedly I'm not sure if this really matters.
> >
> > Wouldn't something like bus reset (SBR) be more predictable?
> 
> Maybe.
> 
> The device state is most likely inconsistent in that case, so it depends.

My limited understanding is that if SBR doesn't help, at that point all
bets are off including PMCSR configuration and probably a cold boot is
needed.

Please correct me if I've misunderstood.

Raag
