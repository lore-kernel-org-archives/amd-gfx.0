Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAACC55ABA
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E1E10E266;
	Thu,  6 Aug 2026 04:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eU2U0F9G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB6210E266
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 04:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785990582; x=1817526582;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7CW8Mojz4tTHJtxhvNY+//zqS7ohbSQ0PPY1CWQ9nuM=;
 b=eU2U0F9GJYZY8d8wEFlkC/8UqNst6f/8uJ8NO2A2cj2awtdv0lW5Fii2
 y/aITJaTQ1emYWn0ZYg7is+S3gl6J+voBu2Cbsa2T20zv0iaAIk10KSW+
 4aRaU52SrH10+ynVrmKLOklQ46AMD0p8i5p49O9qwzFZ8ZhmNZNrsumPO
 Mf4sxxmHb/aKcd5ZDK9KrPIPJD3eETRWnxw4fL6WEpN4xyY0LLGEnIFHy
 Im5Lj5EX5nU/EZmhjtfWo7NFKIY9vaheKeCEW1Y1Uc6LG9+RVKbcQjxo5
 3KwnNle2+q629LXL0ZQUQMsd615emfJNlz/OhcTm4pfNWjd5OrPb1OZlM Q==;
X-CSE-ConnectionGUID: kjrbgnoYT7mNAj8LOHsYOQ==
X-CSE-MsgGUID: VhFkLAKISROZpu6177k9YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="85700027"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="85700027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 21:29:42 -0700
X-CSE-ConnectionGUID: mLQTR0OkQ/2wCOMWalBDJQ==
X-CSE-MsgGUID: rBVBeQQARBiEmx1VFZ4j5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="257693647"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2026 21:29:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrpjc-00000000E8v-0vnM;
 Thu, 06 Aug 2026 04:29:36 +0000
Date: Thu, 6 Aug 2026 12:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Bert Karwatzki <spasswolf@web.de>,
 linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, "# = v7 . 1" <stable@vger.kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Message-ID: <202608061233.eufnR5Qm-lkp@intel.com>
References: <20260801071724.12998-1-spasswolf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>
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

Hi Bert,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260804]
[cannot apply to drm-misc/drm-misc-next linus/master v7.2-rc6 v7.2-rc5 v7.2-rc4 v7.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bert-Karwatzki/drm-amd-display-fix-usage-of-DC_FPU_-BEGIN-END-with-PREEMPT_RT/20260805-170330
base:   next-20260804
patch link:    https://lore.kernel.org/r/20260801071724.12998-1-spasswolf%40web.de
patch subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260806/202608061233.eufnR5Qm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061233.eufnR5Qm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061233.eufnR5Qm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c: In function 'dc_create_plane_state':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:89:9: error: implicit declaration of function 'DC_RUN_WITH_PREEMPTION_ENABLED' [-Wimplicit-function-declaration]
      89 |         DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/DC_RUN_WITH_PREEMPTION_ENABLED +89 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c

    82	
    83	/*******************************************************************************
    84	 * Public functions
    85	 ******************************************************************************/
    86	struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
    87	{
    88		struct dc_plane_state *plane_state;
  > 89		DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
    90	
    91		if (NULL == plane_state)
    92			return NULL;
    93	
    94		kref_init(&plane_state->refcount);
    95		dc_plane_construct(dc->ctx, plane_state);
    96	
    97		return plane_state;
    98	}
    99	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
