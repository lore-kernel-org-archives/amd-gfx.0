Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF4BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF646108E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAF646108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332C66EB3E;
	Thu, 21 Oct 2021 10:01:10 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0A56EB3E;
 Thu, 21 Oct 2021 10:01:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="216158394"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="216158394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 03:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="495058903"
Received: from ssuryana-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.45.34])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 03:00:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Khaled Almahallawy <khaled.almahallawy@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc: Khaled Almahallawy <khaled.almahallawy@intel.com>
Subject: Re: [RFC PATCH 0/4] drm/dp: Use DP2.0 DPCD 248h updated
 register/field names for DP PHY CTS
In-Reply-To: <20211021050713.836498-1-khaled.almahallawy@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211021050713.836498-1-khaled.almahallawy@intel.com>
Date: Thu, 21 Oct 2021 13:00:39 +0300
Message-ID: <8735ouofy0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 20 Oct 2021, Khaled Almahallawy <khaled.almahallawy@intel.com> wrot=
e:
> This series updates DPCD 248h register name and PHY test patterns names t=
o follow DP 2.0 Specs.
> Also updates the DP PHY CTS codes of the affected drivers (i915, amd, msm)
> No functional changes expected.
>=20=20
> Reference: =E2=80=9CDPCD 248h/10Bh/10Ch/10Dh/10Eh Name/Description Consis=
tency=E2=80=9D
> https://groups.vesa.org/wg/AllMem/documentComment/2738

You can't do renames like this piece by piece. Every commit must build.

Incidentally, this is one of the reasons we often don't bother with
renames to follow spec changes, but rather stick to the original names.

However, in this case you could switch all drivers to the different test
pattern macros piece by piece, as they're already there.


BR,
Jani.


>
> Khaled Almahallawy (4):
>   drm/dp: Rename DPCD 248h according to DP 2.0 specs
>   drm/i915/dp: Use DP 2.0 LINK_QUAL_PATTERN_* Phy test pattern
>     definitions
>   drm/amd/dc: Use DPCD 248h DP 2.0 new name
>   drm/msm/dp: Use DPCD 248h DP 2.0 new names/definitions
>
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c |  2 +-
>  drivers/gpu/drm/drm_dp_helper.c                  |  6 +++---
>  drivers/gpu/drm/i915/display/intel_dp.c          | 12 ++++++------
>  drivers/gpu/drm/msm/dp/dp_catalog.c              | 12 ++++++------
>  drivers/gpu/drm/msm/dp/dp_ctrl.c                 | 12 ++++++------
>  drivers/gpu/drm/msm/dp/dp_link.c                 | 16 ++++++++--------
>  include/drm/drm_dp_helper.h                      | 13 +++----------
>  7 files changed, 33 insertions(+), 40 deletions(-)

--=20
Jani Nikula, Intel Open Source Graphics Center
