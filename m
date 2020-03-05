Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56137C3F2D7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB942146E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBQAIxAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB942146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC36E6E14B;
	Thu,  5 Mar 2020 05:23:37 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F746E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 05:23:36 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id v2so5374920wrp.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 21:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0zPwTf6bs+IBRhKSofu5HUxoyl22nMLMrIX0xK6c1bk=;
 b=vBQAIxAoU29e0c0JPLyGsepHNFgv87yyfMZdp3aWrapYKCKwPrWG7CTid/idjwX8cz
 yloUN87IWdgqLdWlrGk+ANb+os1TyN3qdswnnhDH33coq6aASN+aaAYdatr8wx8QXB5B
 2AmHSv4p24ehts8tuct/nS1oOja1TP5KVN7DdsMmMCyfDW7NGfeo9ZpcoXUSmxhE6OI3
 cPyc7RXxIkcZwOoJCFK3UZVc536V7m9qjF1k7Gl2mTEqGLt5T48B6OiG94M8sPN/cL/4
 xVE0iuMRuNqEBzEkMpBwVY4W5C1YbgXhn8xy7xTE1G1Bf5fH/i1MFQoJJcjFrCyOy/9D
 Nrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0zPwTf6bs+IBRhKSofu5HUxoyl22nMLMrIX0xK6c1bk=;
 b=O+mR3xO8GLECgvat/fglhmIZFfJ64fRNJ6D0999FIbCuptQ9K/eRF3ZagaEvHVi1ic
 lgeun/F2bNS6vBXUnDt7EA2ubNSi6EMV45UHJ3lt4ayYioP3HiPh/tQx50Jr7xiPUReW
 jEq1r9647SNfVp6BQC7C9AbeNew5dr2PdznEkPOdHjZMmA4bDJfRE0nB5WftZawbtjDj
 0rwjkN9OUVWnctE9uvf2fcvw9g/B3u2/WJIhyhebSJXYfuB/VF787kc/kVDNpVn/XHu7
 /x55VkZnST6EGxYWv+tjeTMQRo7DqFXQSQWk9z39Yhi5i5V988jJZiCEJVfT17RipxKG
 UmjA==
X-Gm-Message-State: ANhLgQ2vBX+aKUGT3SpXSkObXcO+ILLxWb+SJ5qg4UwgcThse17Nw1Ov
 SzWgaZGViLDxYiKbLleKaBsM0aL0rv3o14RIpFACBQ==
X-Google-Smtp-Source: ADFU+vs5Fuc4qQIkB2RM7X11v5D+Ev61/r83n0sNl/mX3jcEDTW4lwMGq7fd77WzUfStXw6Q8oMiF/x1t19hyYKJFQM=
X-Received: by 2002:adf:9282:: with SMTP id 2mr8361170wrn.124.1583385814814;
 Wed, 04 Mar 2020 21:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
 <20200225203224.1129396-2-alexander.deucher@amd.com>
In-Reply-To: <20200225203224.1129396-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2020 00:23:23 -0500
Message-ID: <CADnq5_MT3ixD+_UWSDJjFq4-M9Sx1g14SfeKdRtv_4sHqydpmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: Fix Pollock Variant Detection
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aly-Tawfik <altawfik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Feb 25, 2020 at 3:32 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> From: Aly-Tawfik <altawfik@amd.com>
>
> Problem Description:
> Currently we are checking internal fused rev id with pci rev id. However, fused
> internal rev id is the same on all raven2 parts (in which Dali and Pollock were
> based on too), thus Pollock detection fails
>
> Fix:
> use the pci rev to preform the detection for bandwidth calculations.
>
> Signed-off-by: Aly-Tawfik <altawfik@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c |  5 +++++
>  .../gpu/drm/amd/display/include/dal_asic_id.h    | 16 ++++++----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> index f0f07b160152..3960a8db94cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> @@ -712,6 +712,11 @@ unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev, uint32_
>                 case PRID_DALI_DF:
>                 case PRID_DALI_E3:
>                 case PRID_DALI_E4:
> +               case PRID_POLLOCK_94:
> +               case PRID_POLLOCK_95:
> +               case PRID_POLLOCK_E9:
> +               case PRID_POLLOCK_EA:
> +               case PRID_POLLOCK_EB:
>                         return 0;
>                 default:
>                         break;
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index ea7015f869c9..8a87d0ed90ae 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -134,11 +134,6 @@
>  #define PICASSO_A0 0x41
>  /* DCN1_01 */
>  #define RAVEN2_A0 0x81
> -#define RAVEN2_15D8_REV_94 0x94
> -#define RAVEN2_15D8_REV_95 0x95
> -#define RAVEN2_15D8_REV_E9 0xE9
> -#define RAVEN2_15D8_REV_EA 0xEA
> -#define RAVEN2_15D8_REV_EB 0xEB
>  #define RAVEN1_F0 0xF0
>  #define RAVEN_UNKNOWN 0xFF
>  #ifndef ASICREV_IS_RAVEN
> @@ -149,16 +144,17 @@
>  #define PRID_DALI_E3 0xE3
>  #define PRID_DALI_E4 0xE4
>
> +#define PRID_POLLOCK_94 0x94
> +#define PRID_POLLOCK_95 0x95
> +#define PRID_POLLOCK_E9 0xE9
> +#define PRID_POLLOCK_EA 0xEA
> +#define PRID_POLLOCK_EB 0xEB
> +
>  #define ASICREV_IS_PICASSO(eChipRev) ((eChipRev >= PICASSO_A0) && (eChipRev < RAVEN2_A0))
>  #ifndef ASICREV_IS_RAVEN2
>  #define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RENOIR_A0))
>  #endif
>  #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
> -#define ASICREV_IS_POLLOCK(eChipRev) (eChipRev == RAVEN2_15D8_REV_94 \
> -               || eChipRev == RAVEN2_15D8_REV_95 \
> -                       || eChipRev == RAVEN2_15D8_REV_E9 \
> -                               || eChipRev == RAVEN2_15D8_REV_EA \
> -                                       || eChipRev == RAVEN2_15D8_REV_EB)
>
>  #define FAMILY_RV 142 /* DCN 1*/
>
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
