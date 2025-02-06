Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7BC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5583B10E2F9;
	Thu,  6 Feb 2025 14:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCeM4Tfu";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC54410E2F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:25:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 728645C60EC;
 Thu,  6 Feb 2025 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94514C4CEE9;
 Thu,  6 Feb 2025 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738851911;
 bh=HHBfVi2GdIGQPY0hZz4QhK7RiaH5r3ta9uBksAz9mHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LCeM4Tfubjdl3gKvf6KZRLuW4wwZ4CxeRA8Pl5r2qHouZsgWuGsavDog/lwBhHeOZ
 /OpsLoqzFIywgl1nGZ4j2TO/0DwmgcapdDwIzYrB5xqaOvNPGX5pMXGL/odX+zB1mr
 xmsS5qm6VBGtW2ZyO3QMdgF+n4yroKzKLXNYx8TtRFq0m2J4XuQb5IFpnY8yMWinDY
 ah+857q3T5zeHam1BPG/ApjlzO1pTnkQL1DVyG7vQbm9nYEfijD6vesne5K1a2Ae0Q
 BOQ/OCMo3WaUiQzTvstV/31cZxIG9MiuV9NoQLtNRxPxpsWqGNcwVTSAaJZq1R6B4p
 tc6eNpo7eZyyw==
Date: Thu, 6 Feb 2025 15:25:07 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
Message-ID: <Z6TGQ2Bjy6fqAHXw@cassiopeiae>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
 <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
 <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
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

On Thu, Feb 06, 2025 at 02:46:40PM +0100, Christian König wrote:
> Am 06.02.25 um 14:35 schrieb Philipp Stanner:
> > On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
> > > The helper copies code from the existing
> > > amdgpu_job_stop_all_jobs_on_sched
> > > with the purpose of reducing the amount of driver code which directly
> > > touch scheduler internals.
> > > 
> > > If or when amdgpu manages to change the approach for handling the
> > > permanently wedged state this helper can be removed.
> > Have you checked how many other drivers might need such a helper?
> > 
> > I have a bit mixed feelings about this, because, AFAICT, in the past
> > helpers have been added for just 1 driver, such as
> > drm_sched_wqueue_ready(), and then they have stayed for almost a
> > decade.
> > 
> > AFAIU this is just code move, and only really "decouples" amdgpu in the
> > sense of having an official scheduler function that does what amdgpu
> > used to do.
> > 
> > So my tendency here would be to continue "allowing" amdgpu to touch the
> > scheduler internals until amdgpu fixes this "permanently wedged
> > state". And if that's too difficult, couldn't the helper reside in a
> > amdgpu/sched_helpers.c or similar?
> > 
> > I think that's better than adding 1 helper for just 1 driver and then
> > supposedly removing it again in the future.
> 
> Yeah, agree to that general approach.
> 
> What amdgpu does here is kind of nasty and looks unnecessary, but changing
> it means we need time from Hawkings and his people involved on RAS for
> amdgpu.
> 
> When we move the code to the scheduler we make it official scheduler
> interface to others to replicate and that is exactly what we should try to
> avoid.

It'd be even worse. It would mean that we create an example for drivers to be
"rewarded" with a free driver specific API by abusing the general API.

Clearly (also) a NACK from my end.
