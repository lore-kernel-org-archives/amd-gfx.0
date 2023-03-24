Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C7C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 17:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE46910EC11;
	Fri, 24 Mar 2023 17:10:43 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAF410E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1679666702; x=1711202702;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=N3nImKI8eGuJ2BCUd714yeyqn0z1Xx7ywtWUfvVU6L4=;
 b=A19669wGhgFeaOFI+ry517zYeB4pwZq0GqLM5jv9t41Y5GPtJdjRSJOX
 RK5LajDRsjPNV4Qdk7FcPGo6tji6OTw4lgvPK5rlYi69IIQRum2vrzemH
 Mg9o82HtRTjIKazC9BxXsA6LEVUGTB2kXtoWyJUf29HIDYWIf6AecylFv
 RXahoiJ5vtcGRNH1x5XjYbUb4v6bw5xqt16FUkSBSBBO2oFf+DTEJMwY7
 FcAIYL61vGCta+Jgo0zvtVVI6mFFP5KOz/CNaNvcuj+PNsdEr+iGmJBc9
 1H3Dsi4xIVYTUDxFDY2D4TQFHUX5b9H5H2vFete5s1OC0Bya67GzcdgTY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426051923"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; d="scan'208";a="426051923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2023 07:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="856865022"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; d="scan'208";a="856865022"
Received: from rosenbaf-mobl.ger.corp.intel.com (HELO [10.252.63.223])
 ([10.252.63.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2023 07:04:58 -0700
Message-ID: <fecbddb2-e729-f9db-8426-a598348e26db@linux.intel.com>
Date: Fri, 24 Mar 2023 16:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 7c4a254d78f89546d0e74a40617ef24c6151c8d1
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Mar 2023 17:10:42 +0000
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
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, linux-wireless@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 23/03/2023 23:34, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 7c4a254d78f89546d0e74a40617ef24c6151c8d1  Add linux-next specific files for 20230323
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303231302.iY6qIfXA-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303232154.aXOXAWhg-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> gpio.c:(.init.text+0xec): undefined reference to `of_mm_gpiochip_add_data'
> include/linux/mmzone.h:1749:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 
> Unverified Error/Warning (likely false positive, please contact us if interested):

...

> sound/soc/sof/ipc4-pcm.c:391 sof_ipc4_pcm_dai_link_fixup_rate() error: uninitialized symbol 'be_rate'.
> sound/soc/sof/ipc4-topology.c:1132 ipc4_copier_set_capture_fmt() error: uninitialized symbol 'sample_valid_bits'.

These are false positives, the copier which is used in these functions
always have input and output side, the be_rate will be initialized:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/ipc4-pcm.c#n485
on the first iteration.

the sample_valid_bits will be initialized:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/ipc4-topology.c#n1310
on the first iteration.

-- 
-- 
Péter
