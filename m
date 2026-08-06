Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC81C55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 03:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E4A10E167;
	Thu,  6 Aug 2026 03:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HuqqpGZo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA07E10E167
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 03:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785988101; x=1817524101;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=17CY3PUmUbDY4206LrobRGj6cHDNUS+fi01DdzhC8EE=;
 b=HuqqpGZoNauZ6X8UbT2nc9HMvDRxA0Y1a7M0wYGa1tWOIsBL5sW/sWot
 P5mGJaHf1VlJ7E9uv5mBPFxs3rSBTFvNl5fDZafDT3RiimJMMNtLUJXJI
 coxDOUns1ddlQIQjrc8Xhy8nRxX9BezG+5StIVComThYvaQLwU2MkH/Qu
 TtiiP5YdpBiF/v41isLsJO3uGa+XdtKGqm7MaoFzW0ltFD8PhJ+LLd8KQ
 N85n6sTxN6E21dnoLxPwUfAgeDCit0zoR4IdPWjXJvC0nzZ+v06LQrVXV
 EFUiDSkqwfpkJndbvl/zvEYuLaQgyvRoPmKxtUxXlCpaL6nx9b5lKcLHL Q==;
X-CSE-ConnectionGUID: 0NqP3vdhSH+kaKvZdD+tmw==
X-CSE-MsgGUID: Vg2jRK3LTLi0uY/cTjdNvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90391114"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="90391114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 20:48:20 -0700
X-CSE-ConnectionGUID: 3rUXs0JSR+2YNmvlS1AgAw==
X-CSE-MsgGUID: /GpNXoZ9SJ2duOVMTxtToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="286649429"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 20:48:16 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrp5a-00000000E3l-0KnC;
 Thu, 06 Aug 2026 03:48:14 +0000
Date: Thu, 6 Aug 2026 11:47:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 "# = v7 . 1" <stable@vger.kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Message-ID: <202608061154.QtrglsMo-lkp@intel.com>
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
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260806/202608061154.QtrglsMo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project bacfe2950f8218268fcc0a8765644ea0c15f0360)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061154.QtrglsMo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061154.QtrglsMo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:89:2: error: call to undeclared function 'DC_RUN_WITH_PREEMPTION_ENABLED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      89 |         DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
         |         ^
   1 error generated.


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
