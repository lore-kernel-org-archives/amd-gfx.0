Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C869EC33CAE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966912084D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966912084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459576E096;
	Mon, 13 Jan 2020 17:07:30 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17266E096;
 Mon, 13 Jan 2020 17:07:28 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jan 2020 09:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; d="scan'208";a="273078751"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by FMSMGA003.fm.intel.com with SMTP; 13 Jan 2020 09:07:22 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Mon, 13 Jan 2020 19:07:22 +0200
Date: Mon, 13 Jan 2020 19:07:22 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: mikita.lipski@amd.com
Subject: Re: [PATCH] drm/amdgpu/display: Use u64 divide macro for round up
 division
Message-ID: <20200113170722.GS13686@intel.com>
References: <20200113132042.25717-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200113132042.25717-1-mikita.lipski@amd.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alexander.Deucher@amd.com, rdunlap@infradead.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 13, 2020 at 08:20:42AM -0500, mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> =

> [why]
> Fix compilation warnings on i386 architecture:
> undefined reference to `__udivdi3'
> [how]
> Switch DIV_ROUND_UP to DIV64_U64_ROUND_UP
> =

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 52fb207393ef..96b391e4b3e7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -534,7 +534,7 @@ static int kbps_to_peak_pbn(int kbps)
>  =

>  	peak_kbps *=3D 1006;
>  	peak_kbps =3D div_u64(peak_kbps, 1000);
> -	return (int) DIV_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
> +	return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));

DIV_ROUND_UP_ULL() would seem to suffice for this divisor.

>  }
>  =

>  static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_p=
arams *params,
> -- =

> 2.17.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
