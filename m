Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B20C7115F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 13:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E6810E81D;
	Wed, 18 Jun 2025 13:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="BsDBl2wa";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A374E10E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=s1TllaebLl69Wuu0DRbgLYCPEkmUTMe8KoqDQ/cRnt0=; b=BsDBl2wav1qiwav6zgVQ7Adh/V
 cFgmuEqRPzPIeVHH2vzuV4To4qgZLekYbjFighL6M3OaA+c8oFO5+cwPoGVTmWTOe5ynVvzPBPMon
 ZgXzKPQWMGJfCXZWhnZoQjNlckndhQoL83GxvkvJuh6ovmvkc7+Wt3zSdi12RppuSBH0CatxwWHlK
 RMuyBPv6A7IqfhxMZ9URDqtVHHasDtduxNWifCyEbW1J7+UzGdEEaNQnTxdimcI/qsWiLTmiXzEzj
 DG5igiK7HndwmfLTy8KJ0mU1YqEmjkUTk2nhMOLCvBCrQQuSSxwjKGFW+WUklLn8l/JxO17QIIlnx
 uGjtYFjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1uRp3q-000000040IO-49Uj; Wed, 18 Jun 2025 09:26:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 32A5E307D9B; Wed, 18 Jun 2025 11:26:25 +0200 (CEST)
Date: Wed, 18 Jun 2025 11:26:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mario Limonciello <superm1@kernel.org>, bhe@redhat.com
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu vs kexec
Message-ID: <20250618092625.GE1613633@noisy.programming.kicks-ass.net>
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
X-Mailman-Approved-At: Wed, 18 Jun 2025 13:03:09 +0000
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

On Wed, Jun 18, 2025 at 11:12:32AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 18, 2025 at 10:51:23AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
> > 
> > > How about if we reset before the kexec?  There is a symbol for drivers to
> > > use to know they're about to go through kexec to do $THINGS.
> > > 
> > > Something like this:
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 0fc0eeedc6461..2b1216b14d618 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -34,6 +34,7 @@
> > > 
> > >  #include <linux/cc_platform.h>
> > >  #include <linux/dynamic_debug.h>
> > > +#include <linux/kexec.h>
> > >  #include <linux/module.h>
> > >  #include <linux/mmu_notifier.h>
> > >  #include <linux/pm_runtime.h>
> > > @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> > >                 adev->mp1_state = PP_MP1_STATE_UNLOAD;
> > >         amdgpu_device_ip_suspend(adev);
> > >         adev->mp1_state = PP_MP1_STATE_NONE;
> > > +
> > > +       if (kexec_in_progress)
> > > +               amdgpu_asic_reset(adev);
> > >  }
> > > 
> > >  static int amdgpu_pmops_prepare(struct device *dev)
> > 
> > I will throw this in the dev kernel... I'll let you know.
> 
> First hurdle appears to be that this symbol is not exported. I fixed
> that, but perhaps the kexec folks don't like drivers to use this?

Bah, so first kexec after a fresh reboot into a kernel carrying this has
the thing failing.

