Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F8BCE8D79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 18:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5768910E25C;
	Fri, 14 Nov 2025 18:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NUj8JeRA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C8D10E25C;
 Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 54E3B4172C;
 Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14213C19425;
 Fri, 14 Nov 2025 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763145358;
 bh=oWD8GTV+Nt3ZDSChcU4v7mGij5MGJoOoxHwMCFXuXA8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=NUj8JeRAJvue2hVfQfL1xMquhbeBz8n0pg9EV+VKjv2aEJkcKPkdyJiHVQjZFgpLP
 qbGqUddaPYUzwwjZ5wNCpe9+o98YW5GodaXsW/JhBz+8SZfkDS7tpcqaVy9XEtSmgV
 jwiYPdmUgPuOR92HVdp9pYc/B/kW8cNSx5Sb+7OFU66kjWHNcEb37kZ2ybylyT6Xle
 QbchwTEsD0Flp9RCXEPuscrMweq2nJrqVYlJ3bfKBr+s3HPuFjyS9NZl3LOlzmcrBx
 Uj9FbktzRB+9LAdFIP4btjaFBfmbi5PB+YgKIKIooxYJxJozM8uUMEV/ha+VjF8D0I
 2vgnnISFAVVjA==
Date: Fri, 14 Nov 2025 12:35:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Simon Richter <Simon.Richter@hogyros.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
Message-ID: <20251114183556.GA2334513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyzsq0nr.fsf@draig.linaro.org>
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

On Fri, Nov 14, 2025 at 12:06:00PM +0000, Alex Bennée wrote:
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> 
> > Hi all,
> >
> > Thanks to issue reports from Simon Richter and Alex Bennée, I
> > discovered BAR resize rollback can corrupt the resource tree. As fixing
> > corruption requires avoiding overlapping resource assignments, the
> > correct fix can unfortunately results in worse user experience, what
> > appeared to be "working" previously might no longer do so. Thus, I had
> > to do a larger rework to pci_resize_resource() in order to properly
> > restore resource states as it was prior to BAR resize.
> <snip>
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> 
> Ahh I have applied to 6.18-rc5 with minor conflicts and can verify that
> on my AVA the AMD GPU shows up again and I can run inference jobs
> against it. So for that case:
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>

Thanks, Alex!  I added your Tested-by to this series, except for these
which I don't think are relevant for you:

  drm/xe: Remove driver side BAR release before resize
  drm/i915: Remove driver side BAR release before resize

