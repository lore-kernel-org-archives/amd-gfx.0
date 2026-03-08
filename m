Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C877EEA8535
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 16:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FFC10E052;
	Sun,  8 Mar 2026 16:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RMDXHICc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE63810E052;
 Sun,  8 Mar 2026 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772987090; x=1804523090;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rTWIJZBcalYJMD/t0wxWOLNYJhY28C5F43rXAM+gZOo=;
 b=RMDXHICcdMrQzXkt7FCBqWH3FgkeM+pV5nE42oh4ZFiZ6wSv+lTebS3W
 cEDoT+Zx1aUzYUMcoCtU24hgmoLI49JVEbindScZD4QJJpBvB9Ily3Ux2
 ee+sqwLHR5+XKgdiX3/Tdf3MynFH5xZe+iVXdsVUW1sdx8Ijvq7ITWxZf
 46HAZKJqanVMgQkxzPokcnwxBw+BlXSDjC3ZHI0cWJCsZGn1Bqk7Df5HK
 IVbatZ+0UNnA1uTjjwJ5OZ5moSuV97xcf8GPVW3L+1/66IV2o+ps38nfu
 KJmuBfJEuUY4LN21GPCQHWgkgcg9hbKNW+j9F6FZnr3lhRzGvv44vHNbt g==;
X-CSE-ConnectionGUID: oekkO4olQo6c8GVK1ecFpQ==
X-CSE-MsgGUID: xLzKZQ3iRFOiFGN8aerCyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85499923"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; d="scan'208";a="85499923"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2026 09:24:50 -0700
X-CSE-ConnectionGUID: 946eHPfJQZyqreQ/mFLVhw==
X-CSE-MsgGUID: ORm1g5ejSMi8QdGGBSMLEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; d="scan'208";a="219645059"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 08 Mar 2026 09:24:46 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vzGvq-000000003FU-1oV2;
 Sun, 08 Mar 2026 16:24:42 +0000
Date: Mon, 9 Mar 2026 00:23:58 +0800
From: kernel test robot <lkp@intel.com>
To: Rafael Passos <rafael@rcpassos.me>, alexdeucher@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, BhuvanaChandra.Pinninti@amd.com,
 Harry.Wentland@amd.com, Martin.Leung@amd.com, Sunpeng.Li@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 daniel.wheeler@amd.com, davidbtadokoro@ime.usp.br,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rafael@rcpassos.me, ray.wu@amd.com, rcpassos@ime.usp.br,
 siqueira@igalia.com
Subject: Re: [PATCH] drm/amd/display: fix resuming from S3 sleep for Renoir
 iGPU
Message-ID: <202603090058.Jvh5jmdd-lkp@intel.com>
References: <20260308000515.890688-1-rafael@rcpassos.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308000515.890688-1-rafael@rcpassos.me>
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

Hi Rafael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.0-rc2 next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-Passos/drm-amd-display-fix-resuming-from-S3-sleep-for-Renoir-iGPU/20260308-080715
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260308000515.890688-1-rafael%40rcpassos.me
patch subject: [PATCH] drm/amd/display: fix resuming from S3 sleep for Renoir iGPU
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260309/202603090058.Jvh5jmdd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603090058.Jvh5jmdd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603090058.Jvh5jmdd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dccg/dcn21/dcn21_dccg.c:99:6: warning: no previous prototype for 'dccg21_init' [-Wmissing-prototypes]
      99 | void dccg21_init(struct dccg *dccg)
         |      ^~~~~~~~~~~


vim +/dccg21_init +99 drivers/gpu/drm/amd/amdgpu/../display/dc/dccg/dcn21/dcn21_dccg.c

    98	
  > 99	void dccg21_init(struct dccg *dccg)
   100	{
   101		struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
   102	
   103		/* Hardcoded register values for DCN21
   104		 * These are specific to 100Mhz refclk
   105		 * Different ASICs with different refclk may override this in their own init
   106		 */
   107		REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120464);
   108		REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x001186a0);
   109		REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
   110	
   111		if (REG(REFCLK_CNTL))
   112			REG_WRITE(REFCLK_CNTL, 0);
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
