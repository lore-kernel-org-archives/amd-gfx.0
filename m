Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 17:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09C961929
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 17:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C09C961929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7DF6E153;
	Wed, 17 Nov 2021 17:52:35 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD93C6E153;
 Wed, 17 Nov 2021 17:52:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="294831154"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; d="scan'208";a="294831154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2021 09:52:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; d="scan'208";a="586736930"
Received: from ianock-mobl1.ger.corp.intel.com (HELO [10.252.8.140])
 ([10.252.8.140])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2021 09:52:31 -0800
Message-ID: <2091645b-d4f9-a6f4-834c-87d9a5d81423@intel.com>
Date: Wed, 17 Nov 2021 17:52:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/6] drm: move the buddy allocator from i915 into
 common drm
Content-Language: en-GB
To: Arunpravin <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20211116201807.147486-1-Arunpravin.PaneerSelvam@amd.com>
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20211116201807.147486-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: alexander.deucher@amd.com, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 christian.koenig@amd.com, daniel@ffwll.ch
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16/11/2021 20:18, Arunpravin wrote:
> Move the base i915 buddy allocator code into drm
> - Move i915_buddy.h to include/drm
> - Move i915_buddy.c to drm root folder
> - Rename "i915" string with "drm" string wherever applicable
> - Rename "I915" string with "DRM" string wherever applicable
> - Fix header file dependencies
> - Fix alignment issues
> - add Makefile support for drm buddy
> - export functions and write kerneldoc description
> - Remove i915 selftest config check condition as buddy selftest
>    will be moved to drm selftest folder
> 
> cleanup i915 buddy references in i915 driver module
> and replace with drm buddy
> 
> v2:
>    - include header file in alphabetical order (Thomas)
>    - merged changes listed in the body section into a single patch
>      to keep the build intact (Christian, Jani)
> 
> Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>

Any ideas for what to do with the existing selftests? Currently this 
series doesn't build yet for i915 due to this, and prevents throwing the 
series at CI.
