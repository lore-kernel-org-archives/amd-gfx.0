Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8900FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 08:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADFB10F12E;
	Mon, 23 May 2022 08:56:50 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C1D10F12E;
 Mon, 23 May 2022 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653296209; x=1684832209;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=tJ5MN5nQ3c/CHCiaveSdbleqMRLnZth1whViX2v00y0=;
 b=Zr0DMyQ6PhslGeySyYlfTootpRlfHSf38JvUMLeXoPBhm1sxA0AEwYA/
 k6nvXjx8Q8hHZLUa5z93bm9Sb9ivQBV/Wxpj9fnhPPXFCpU/bwc6WjBfh
 CFDrne4pOiApPsrhJV6gDKIGZBz+EAN1FHUCeaI/menscZP81dfXzUtZt
 6sVMtPoN2SoOdGHduDPfJ2m1rMZEPiDSuJjkRrAq1Y91gYrnhXOPKt10w
 Vc7pYZ1tdn+G9YpmNXxKk3YKqbJ5FAhcLHgH/iOsNg3mkz5rxKa+WV1rR
 nA6nPB5hLQRnjqm6U5enWaxPgQWAWtWiKeOJ2D90Nqttcpbi2/yUhmezb w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="253030252"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="253030252"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 01:56:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; d="scan'208";a="744636255"
Received: from ksadlows-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.135.186])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2022 01:56:46 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [CI 0/3] Expose max and current bpc via debugfs
In-Reply-To: <20220519095149.3560034-1-bhanuprakash.modem@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220519095149.3560034-1-bhanuprakash.modem@intel.com>
Date: Mon, 23 May 2022 11:56:43 +0300
Message-ID: <87o7zobp9w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 19 May 2022, Bhanuprakash Modem <bhanuprakash.modem@intel.com> wrote:
> This series will expose the Connector's max supported bpc via connector
> debugfs and Crtc's current bpc via crtc debugfs. Also move the existing
> vendor specific "output_bpc" logic to drm.

Pushed the series to drm-misc-next, thanks for that patches, reviews and
acks.

BR,
Jani.

>
> Bhanuprakash Modem (3):
>   drm/debug: Expose connector's max supported bpc via debugfs
>   drm/i915/display/debug: Expose crtc current bpc via debugfs
>   drm/amd/display: Move connector debugfs to drm
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 --
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 38 +++++++------------
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.h |  2 -
>  drivers/gpu/drm/drm_debugfs.c                 | 21 ++++++++++
>  .../drm/i915/display/intel_display_debugfs.c  | 28 ++++++++++++++
>  5 files changed, 62 insertions(+), 31 deletions(-)
>
> --
> 2.35.1
>

-- 
Jani Nikula, Intel Open Source Graphics Center
