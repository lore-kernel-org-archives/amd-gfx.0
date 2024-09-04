Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C75DCE7A8E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 18:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B90710E933;
	Thu,  5 Sep 2024 18:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b36XrRSY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FE710E6BF;
 Wed,  4 Sep 2024 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725438141; x=1756974141;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=V1FmEQxa7lsgaFs6dxtMyqS9h9XeuCAQr3fIQa40Vko=;
 b=b36XrRSYtOnEijRdVtqhc84dQsSheiz40xFfTEpRe8B9gFuhpCae817X
 tvhlNPXWuxxEnhUdplmM2xrUI5BIiLERL5B9pDl/6wH+zkO9Bd7nLGo4F
 LADt/mI6xGubd6r+Q+9We9RQvL7/cmMIyvT8X2K+7FaJWA5ucKKsXCnJi
 sBfT4sod4EWZcod6wO/PDyQfGFHmptxGsp3yphSX88RQ36eNbBGmLMwgr
 fudF1vc79dwbVET+H3ns9SrIPfvYYAwuAtaFeUi1rLvvxQEQM9g26/PCm
 SeYujQbU8ZIVTsbfUjLXgXTm9C47vVDT3o6difvDk9PY1alpnv53Mb4Ry w==;
X-CSE-ConnectionGUID: eXs+tstXTwmE38enQU8q1Q==
X-CSE-MsgGUID: o7gBiST0T9qfJqTnn5FD0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34743457"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; d="scan'208";a="34743457"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 01:22:21 -0700
X-CSE-ConnectionGUID: fhxr+nYxRoODf5yvaTE17Q==
X-CSE-MsgGUID: rm5Y8ZLpSGWehoeNaPv1rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; d="scan'208";a="69353257"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.18])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 01:22:16 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>, Hamza
 Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable -Wformat-truncation
In-Reply-To: <20240903200953.292717-1-hamza.mahfooz@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240903200953.292717-1-hamza.mahfooz@amd.com>
Date: Wed, 04 Sep 2024 11:21:59 +0300
Message-ID: <875xrbu8uw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 05 Sep 2024 18:49:02 +0000
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

On Tue, 03 Sep 2024, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
> It is enabled by W=1 and amdgpu has a clean build with it enabled. So,
> to make sure we block future instances of it from showing up on
> our driver, enable it by default for the module.

Would prefer enabling it by default across the subsystem [1].

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1716479340.git.jani.nikula@intel.com

>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 34943b866687..64adadb56fd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,6 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>  
>  # Locally disable W=1 warnings enabled in drm subsystem Makefile
>  subdir-ccflags-y += -Wno-override-init
> +subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
>  subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
>  
>  amdgpu-y := amdgpu_drv.o

-- 
Jani Nikula, Intel
