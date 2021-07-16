Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393ACC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 11:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16016128A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 11:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16016128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7778A89F63;
	Fri, 16 Jul 2021 11:40:10 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9670589F63;
 Fri, 16 Jul 2021 11:40:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190397773"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; d="scan'208";a="190397773"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2021 04:40:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; d="scan'208";a="496363853"
Received: from ooderhoh-mobl1.amr.corp.intel.com (HELO intel.com)
 ([10.212.81.13])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2021 04:40:03 -0700
Date: Fri, 16 Jul 2021 07:40:02 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: misc vgaarb cleanups
Message-ID: <YPFwEiztEUVFcdCh@intel.com>
References: <20210716061634.2446357-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210716061634.2446357-1-hch@lst.de>
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
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 16, 2021 at 08:16:27AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up a bunch of lose ends in the vgaarb code.
> 
> Diffstat:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   11 +-
>  drivers/gpu/drm/drm_irq.c                  |    4 
>  drivers/gpu/drm/i915/display/intel_vga.c   |    9 +-

The parts touching i915 looks clean to me

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  drivers/gpu/drm/nouveau/nouveau_vga.c      |    8 -
>  drivers/gpu/drm/radeon/radeon_device.c     |   11 +-
>  drivers/gpu/vga/vgaarb.c                   |   67 +++++-----------
>  drivers/vfio/pci/vfio_pci.c                |   11 +-
>  include/linux/vgaarb.h                     |  118 ++++++++++-------------------
>  8 files changed, 93 insertions(+), 146 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
