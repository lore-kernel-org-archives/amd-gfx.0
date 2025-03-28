Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3329C36013
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 10:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9417E10E9CB;
	Fri, 28 Mar 2025 10:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OOplqAm5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6963910E0F5;
 Fri, 28 Mar 2025 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743157682; x=1774693682;
 h=message-id:date:mime-version:subject:cc:references:from:
 to:in-reply-to:content-transfer-encoding;
 bh=iK5DbF6ZP26z9nzakAbeS0c023kRx6KDUFmUXimrPVI=;
 b=OOplqAm55sFwu5mb8CzQweJX5EW3KkXaKW9R+XqRCtBGXr2GiY8nRR4a
 w7L6b/nMs4mDheGKAZRWO6fE/VqHNVbW4D+bHOxmpOBD/D66eJT6DTlKm
 bfmNNQZjcAYecPWthSD0U4dFSmM0LSWc9zZgjXJHOzfshRVPWLwa5nr8r
 6vmaC1zcCsKgIWIzqwknvHoGVzrjIyOiK8kN/lSG7HQ2R80L1Zjg598L9
 2e2KlWKlbLLibdDCII3OTyOJHTuJs433JkcZW8QyGVVXbSNmbxHshMaQq
 2byg3FoSFk0BQbHE/VdGlnj8vpr02TQcBAEislUZYMhWLnFQ8Arb5RI+5 Q==;
X-CSE-ConnectionGUID: uOv58qc6QGyuMmQa2/OpOA==
X-CSE-MsgGUID: U4mGFiEYR+WVkBrDwSsFgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48298090"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="48298090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 03:28:02 -0700
X-CSE-ConnectionGUID: jMerTHXxS26YYXubYNs80w==
X-CSE-MsgGUID: crVKthn0SpurjSoZQUzVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="156345778"
Received: from aiddamse-mobl3.gar.corp.intel.com (HELO [10.247.186.10])
 ([10.247.186.10])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 03:27:59 -0700
Message-ID: <fd1e4ddf-f123-4e72-beb8-1308bf7c32ab@linux.intel.com>
Date: Fri, 28 Mar 2025 15:57:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Generate CPER records for RAS and commit to CPER
 ring
Cc: amd-gfx@lists.freedesktop.org, "airlied@gmail.com" <airlied@gmail.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 ckoenig.leichtzumerken@gmail.com,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 simona@ffwll.ch
References: <cover.1739519672.git.xiang.liu@amd.com>
Content-Language: en-US
From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
To: Hawking.Zhang@amd.com, tao.zhou1@amd.com, Xiang Liu <xiang.liu@amd.com>
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

Based on the discussions around using Netlink for RAS purposes, as
summarized in this blog post [1] by Dave Airlie. I had proposed a series
regarding RAS infrastructure in DRM [2].

I came across your work, which appears to address related areas and I'm
particularly interested in understanding how it aligns with or could be
adapted to the ongoing discussions around leveraging Netlink for RAS.

Could you share your perspective on the potential integration of your
efforts with Netlink? Do you foresee any challenges or opportunities in
aligning with the approach discussed in the above-mentioned blog post
and series?

Looking forward to your insights and any additional thoughts you may
have on this topic.


[1]
https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html

[2]
https://lore.kernel.org/all/20231020155835.1295524-1-aravind.iddamsetty@linux.intel.com/


Thanks,
Aravind.
On 14-02-2025 13:37, Xiang Liu wrote:
> This patch series generate RAS CPER records for UE/DE/CE/BP threshold exceed
> event. SMU_TYPE_CE banks are combined into 1 CPER entry, they could be CEs or
> DEs or both. UEs and BPs are encoded into separate CPER entries.
> 
> RAS CPER records for CEs will be generated only after CEs count been queried.
> 
> All records are committed to a pure software ring with a limit size, new records
> will flush older records when overflow happened. User can access the records by
> reading debugfs node, which is read-only.
> 
> Hawking Zhang (5):
>   drm/amd/include: Add amd cper header
>   drm/amdgpu: Introduce funcs for populating CPER
>   drm/amdgpu: Include ACA error type in aca bank
>   drm/amdgpu: Introduce funcs for generating cper record
>   drm/amdgpu: Generate cper records
> 
> Tao Zhou (4):
>   drm/amdgpu: add RAS CPER ring buffer
>   drm/amdgpu: read CPER ring via debugfs
>   drm/amdgpu: add data write function for CPER ring
>   drm/amdgpu: add mutex lock for cper ring
> 
> Xiang Liu (3):
>   drm/amdgpu: Get timestamp from system time
>   drm/amdgpu: Commit CPER entry
>   drm/amdgpu: Generate bad page threshold cper records
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    |  46 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 559 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h   | 104 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  91 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   2 +
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |   2 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |   2 +
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |   2 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |   2 +
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c     |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |   2 +
>  drivers/gpu/drm/amd/include/amd_cper.h     | 269 ++++++++++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c        |   3 +
>  19 files changed, 1075 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
>  create mode 100644 drivers/gpu/drm/amd/include/amd_cper.h
> 

