Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3865C7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 14:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5744810EA6F;
	Thu, 19 Jun 2025 14:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AKpRLnv5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3571110E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750290925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiaOuJ42vqNHhFgJMjJLM7wPYAnFg3s/hwNHhH+fcys=;
 b=AKpRLnv5WnX1N2CfGZbOT646ujfD3F51qwgE93sz/7Z7yMNFCsAm2q8MZov+Cb59wxZI1y
 zC8uRsSKS5Jk1PGqNyfYp6zPK54Q84ZdbwVufd5PKis3cIx/Amd/YT4bpNBWLp9F+khI6E
 7EhonD1v87GBP6OyUuWhW4NmPcDQt2M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-CAwjoseQN8-yz18sAk_5bg-1; Wed,
 18 Jun 2025 19:55:21 -0400
X-MC-Unique: CAwjoseQN8-yz18sAk_5bg-1
X-Mimecast-MFC-AGG-ID: CAwjoseQN8-yz18sAk_5bg_1750290919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 149AD1800343; Wed, 18 Jun 2025 23:55:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7666A180045B; Wed, 18 Jun 2025 23:55:16 +0000 (UTC)
Date: Thu, 19 Jun 2025 07:55:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu vs kexec
Message-ID: <aFNR4E/4CR1b/MsG@MiWiFi-R3L-srv>
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OmIXtv2PJt35d-A98EzxZTWbGPnt9zHIshBJQyYiD1o_1750290919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 19 Jun 2025 14:02:00 +0000
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

On 06/18/25 at 11:12am, Peter Zijlstra wrote:
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

I can't find the original mail of this thread, while we don't have a
known restriction about that afaik.

