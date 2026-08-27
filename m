Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19487C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 22:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E16210F07A;
	Thu, 27 Aug 2026 22:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KY5K10js";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B3D10F07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787868880; x=1819404880;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0FJgbP6g3+qK4B5v4A9pqy/ZRTHo09o+plVMF583VTI=;
 b=KY5K10jsnP0AWPu5FfQFz7CzXN8vGzTa+3Pff4J6jdYxxeIwUfxKOZUN
 oGxEXWrGl7E3FMhq9wCH3MyLJuaO4abCRSXpkaCNeWlzEZjeMaRAFuf/f
 e0tcefQU5k1RaFMTV0HeoDTO42Bkm25ZaXeSh1IH1voULAVqc+4K2SqNw
 L9J01o42bshSsDJ7geoUQWIcdRESWTBrguSvNpl9i/gXoIeAMsUWWnMBd
 CWt+rpp4tTG2tZ9ekM7ZRt7JZCiW6HWomN+h219h2iS1DKH72Eb0KPZNS
 xoxXrBXK6JJhwbe3utc9p25UR+Wo76vrDPqYIC4QbhxZ3McGkpImzXAb0 Q==;
X-CSE-ConnectionGUID: 0xjHwjEARF6/722ryd7Mxw==
X-CSE-MsgGUID: 2BrXqeZpScqeFuQyVmCL/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75921820"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="75921820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 15:14:37 -0700
X-CSE-ConnectionGUID: xlG0FO5iSs6H/L9poYTi/w==
X-CSE-MsgGUID: VE1PNoxkRu2L/RYvGnyZwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="266687940"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 27 Aug 2026 15:14:35 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wziMi-00000000A5t-26AU;
 Thu, 27 Aug 2026 22:14:32 +0000
Date: Fri, 28 Aug 2026 06:13:39 +0800
From: kernel test robot <lkp@intel.com>
To: Geramy Loveless <gloveless@jqluv.com>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com,
 alexander.deucher@amd.com, ilpo.jarvinen@linux.intel.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 mario.limonciello@amd.com, nra3088@gmail.com, gloveless@jqluv.com
Subject: Re: How to correctly reserve prefetchable bridge windows for large,
 resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on
 upstreamable approach.
Message-ID: <202608280629.PrwiaBTD-lkp@intel.com>
References: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
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

Hi Geramy,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master next-20260826]
[cannot apply to drm-misc/drm-misc-next v7.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geramy-Loveless/How-to-correctly-reserve-prefetchable-bridge-windows-for-large-resizable-BARs-behind-PCIe-switches-8x-GPU-PEX890xx-seeki/20260826-132218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/a2292dfb-2ee5-4988-ac67-c75dd3e97a4c%40jqluv.com
patch subject: How to correctly reserve prefetchable bridge windows for large, resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on upstreamable approach.
config: i386-randconfig-015-20260827 (https://download.01.org/0day-ci/archive/20260828/202608280629.PrwiaBTD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260828/202608280629.PrwiaBTD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608280629.PrwiaBTD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/setup-res.o: in function `pci_align_resource':
>> drivers/pci/setup-res.c:289:(.text+0x92a): undefined reference to `__udivdi3'
>> ld: drivers/pci/setup-res.c:289:(.text+0x939): undefined reference to `__udivdi3'
   ld: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.o: in function `dchub_v2_get_sop_total_available_bandwidth_KBps':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h:71:(.text+0x61): undefined reference to `__udivdi3'
   ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h:79:(.text+0x9d): undefined reference to `__udivdi3'
   ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h:66:(.text+0xc0): undefined reference to `__udivdi3'
   ld: drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.o:drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h:76: more undefined references to `__udivdi3' follow


vim +289 drivers/pci/setup-res.c

   262	
   263	/*
   264	 * For mem bridge windows, try to relocate tail remainder space to space
   265	 * before res->start if there's enough free space there. This enables
   266	 * tighter packing for resources.
   267	 */
   268	resource_size_t pci_align_resource(struct pci_dev *dev,
   269					   const struct resource *res,
   270					   const struct resource *empty_res,
   271					   resource_size_t size,
   272					   resource_size_t align)
   273	{
   274		resource_size_t remainder, start_addr;
   275	
   276		if (!(res->flags & IORESOURCE_MEM))
   277			return res->start;
   278	
   279		if (IS_ALIGNED(size, align))
   280			return res->start;
   281	
   282		remainder = size - ALIGN_DOWN(size, align);
   283		/*
   284		 * A window holding several align-sized resources has one tail per
   285		 * resource, but only the lowest can tuck below the first aligned
   286		 * boundary; the rest sit above it. Relocate a single tail's worth.
   287		 */
   288		if (ALIGN_DOWN(size, align) > align)
 > 289			remainder /= ALIGN_DOWN(size, align) / align;
   290		/* Don't mess with size that doesn't align with window size granularity */
   291		if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flags)))
   292			return res->start;
   293		/* Try to place remainder that doesn't fill align before */
   294		if (res->start < remainder)
   295			return res->start;
   296		start_addr = res->start - remainder;
   297		if (empty_res->start > start_addr)
   298			return res->start;
   299	
   300		pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n",
   301			res, (unsigned long long)start_addr);
   302		return start_addr;
   303	}
   304	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
