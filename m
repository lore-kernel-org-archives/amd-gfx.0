Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003A8C001DB
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Aug 2023 19:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DFD10E0F5;
	Sun, 13 Aug 2023 19:10:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3437210E0F5;
 Sun, 13 Aug 2023 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691953845; x=1723489845;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=xg4mFYd0bSzUJ6T2rDTewtz03S+l8kY6TLXsMswBTio=;
 b=iStDqsiF+rlOScZnyv2RgwtGpvHnrGhZZRYddK2eQm3coqrpFbCJXzz+
 JbxOgQimkJgcrNe2hbFAglRmZhhaeyTORCiBqMMVp43I07SLqKu9z3kxz
 9YoCUAnOjsd95BsE1m3teOb9xZ+v69gKPh+R7Sx+TC8pFJc5ZdLCipWTO
 pvPE06gLK66kzMkU5mOb9dM73jGKMPjs/iXWIq0mEx9c/YGMmYEriJURn
 498P91DrpnHSQYIrDNFqms7J/6x44eJ1F5IdLwZORJoLgOLfNzBFeu4x9
 BRWuzkF+ToQZ9EexvjPDK1j79o2aSDDkhM25XOs/eJUcPJmL9zDUoDV1R g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438249040"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="438249040"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 12:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="733216691"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="733216691"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 13 Aug 2023 12:10:40 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qVGU4-0009C4-22;
 Sun, 13 Aug 2023 19:10:40 +0000
Date: Mon, 14 Aug 2023 03:10:33 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3 4/5] drm/amdgpu: Move coredump code to amdgpu_reset
 file
Message-ID: <202308140200.o4DoWaAQ-lkp@intel.com>
References: <20230810192330.198326-5-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810192330.198326-5-andrealmeid@igalia.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>, kernel-dev@igalia.com,
 oe-kbuild-all@lists.linux.dev, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/drm-amdgpu-Create-a-module-param-to-disable-soft-recovery/20230811-032440
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230810192330.198326-5-andrealmeid%40igalia.com
patch subject: [RESEND v3 4/5] drm/amdgpu: Move coredump code to amdgpu_reset file
config: alpha-randconfig-r062-20230814 (https://download.01.org/0day-ci/archive/20230814/202308140200.o4DoWaAQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308140200.o4DoWaAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308140200.o4DoWaAQ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:228:12-19: WARNING: kzalloc should be used for 
    
>> 	 coredump  , instead of kmalloc/memset

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
