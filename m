Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C3D74EE3
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 15:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04C010E193;
	Fri, 23 Jan 2026 15:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Izm4gGWc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D2110E193;
 Fri, 23 Jan 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769181430; x=1800717430;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mtX2wkzTv4QKP702ioxXJbNnRZiOdbyIrUyfJHJ7mGc=;
 b=Izm4gGWcYspwCXG/N5iZWjcI82N53T14k08vRSAElptBzNdkuDBNRWaT
 CxVItNnfzs6s1Ui3WEJM4vtAuxG1RwS7qnwbRGcAXTNwi32TVjqhhT1pL
 uJgGsUIDupPeB+cijVzAqzQICHm6GxW1mn6WixHFTo1/6EKmobENi/j8E
 fxXOGJL8Y26/1ijOW9Iyf6rrqQxlpykt/ocOR8bMBM6s3GXkP3B38i41S
 f7T5pD4BWWJW2Wv2ZbVwt/EDzTRTQFUdaWpp3amacNWUGIeRgAfGEPzc5
 jUiZdxl+vbKRF2NNgABaq8ZswF4scgZ/JNzCX6WRbEfsRdD2H3VvCwHP3 A==;
X-CSE-ConnectionGUID: dmPaSTiXRhSwRDKQ9GmEFg==
X-CSE-MsgGUID: opcwrldySq+bSQasg5bzTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="74286599"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="74286599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 07:17:10 -0800
X-CSE-ConnectionGUID: Ljx0nGDARAW2z1lxWL7Z3Q==
X-CSE-MsgGUID: bnfzDrQ/QxmubQOOosbjVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="212047944"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 23 Jan 2026 07:17:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vjIuD-00000000U70-22rZ;
 Fri, 23 Jan 2026 15:17:01 +0000
Date: Fri, 23 Jan 2026 23:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: Hamza Mahfooz <someguy@effective-light.com>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Hamza Mahfooz <someguy@effective-light.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ce Sun <cesun102@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: implement page_flip_timeout() support
Message-ID: <202601232335.sf6DrrBF-lkp@intel.com>
References: <20260123000537.2450496-2-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123000537.2450496-2-someguy@effective-light.com>
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

Hi Hamza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v6.19-rc6 next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hamza-Mahfooz/drm-amdgpu-implement-page_flip_timeout-support/20260123-085944
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260123000537.2450496-2-someguy%40effective-light.com
patch subject: [PATCH 2/2] drm/amdgpu: implement page_flip_timeout() support
config: i386-buildonly-randconfig-002-20260123 (https://download.01.org/0day-ci/archive/20260123/202601232335.sf6DrrBF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601232335.sf6DrrBF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601232335.sf6DrrBF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/jiffies.h:10,
                    from include/linux/ktime.h:25,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:43,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h:27,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:24:
   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c: In function 'amdgpu_reset_get_desc':
>> include/linux/string.h:83:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
      83 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy1'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:114:9: note: in expansion of macro 'CONCATENATE'
     114 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:347:17: note: in expansion of macro 'strscpy'
     347 |                 strscpy(buf, "display hang", len);
         |                 ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:348:9: note: here
     348 |         default:
         |         ^~~~~~~
--
   In file included from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/jiffies.h:10,
                    from include/linux/ktime.h:25,
                    from amdgpu_ctx.h:26,
                    from amdgpu.h:43,
                    from amdgpu_reset.h:27,
                    from amdgpu_reset.c:24:
   amdgpu_reset.c: In function 'amdgpu_reset_get_desc':
>> include/linux/string.h:83:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
      83 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy1'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:114:9: note: in expansion of macro 'CONCATENATE'
     114 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   amdgpu_reset.c:347:17: note: in expansion of macro 'strscpy'
     347 |                 strscpy(buf, "display hang", len);
         |                 ^~~~~~~
   amdgpu_reset.c:348:9: note: here
     348 |         default:
         |         ^~~~~~~


vim +83 include/linux/string.h

e6584c3964f2ff Kees Cook 2023-09-20  74  
e6584c3964f2ff Kees Cook 2023-09-20  75  /*
e6584c3964f2ff Kees Cook 2023-09-20  76   * The 2 argument style can only be used when dst is an array with a
e6584c3964f2ff Kees Cook 2023-09-20  77   * known size.
e6584c3964f2ff Kees Cook 2023-09-20  78   */
e6584c3964f2ff Kees Cook 2023-09-20  79  #define __strscpy0(dst, src, ...)	\
559048d156ff33 Kees Cook 2024-08-05  80  	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
559048d156ff33 Kees Cook 2024-08-05  81  				__must_be_cstr(dst) + __must_be_cstr(src))
559048d156ff33 Kees Cook 2024-08-05  82  #define __strscpy1(dst, src, size)	\
559048d156ff33 Kees Cook 2024-08-05 @83  	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
e6584c3964f2ff Kees Cook 2023-09-20  84  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
