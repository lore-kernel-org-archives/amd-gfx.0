Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFCCE8D77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 18:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2422510EAD9;
	Fri, 14 Nov 2025 18:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hTdhkQKU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A16210E257;
 Fri, 14 Nov 2025 18:27:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE55560188;
 Fri, 14 Nov 2025 18:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B82C4CEF1;
 Fri, 14 Nov 2025 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763144860;
 bh=cYXp6vTHKD4+5HKyKDsS0LI6yssoViJnuOJ6XQWYNp4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=hTdhkQKUi+PzhqiZrzsNxYV1ZF5i4s0dFL6ShBnirq9JvKqzo9WAtxlC9K4xNqREZ
 jMGFeVLCfm1GpAMgDDxYAhrOiDpRjmb0u2p8xMH3jLfpdHiGDgrjkPSTtOccX39msM
 QM0WIB+6+G1UIPFetlm0KsaA/yfiESW8bp2goJmd2NZ5COFKDrpjYKw4uvMvLEOPiT
 mjfAYyUCSTgc6Fqf4hyEBUlOChgPM8dgsfooBUkuXLZTBnJT9yFRS0GEX9IsPhlSUA
 lguFbUfMC0HYHxc/aswttWcArBbW3HbO2hNr+04smAX5GEmhFnLZUl8dAI8bL4J4X1
 fUo+3KX2gZjNA==
Date: Fri, 14 Nov 2025 12:27:39 -0600
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
Message-ID: <20251114182739.GA2332823@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pl9lot9r.fsf@draig.linaro.org>
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

On Fri, Nov 14, 2025 at 09:30:56AM +0000, Alex Bennée wrote:
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
> >
> > This rework has been on my TODO list anyway but it wasn't the highest
> > prio item until pci_resize_resource() started to cause regressions due
> > to other resource assignment algorithm changes.
> 
> Thanks I'll have a look.
> 
> Where does this apply? At least v6.17 doesn't seem to have
> pbus_reassign_bridge_resources which 4/11 is trying to tweak.

This is based on v6.18-rc1 and is applied here:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=resource

I expect some conflicts with d30203739be7 ("drm/xe: Move rebar to be
done earlier"), which appeared in v6.18-rc2, and possibly with other
DRM changes planned for v6.19.

Bjorn
