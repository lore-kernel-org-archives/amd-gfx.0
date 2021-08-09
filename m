Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A440EC4320A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 13:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6094A60EC0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 13:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6094A60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C096689BE8;
	Mon,  9 Aug 2021 13:59:24 +0000 (UTC)
X-Greylist: delayed 544 seconds by postgrey-1.36 at gabe;
 Mon, 09 Aug 2021 13:30:03 UTC
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A2E89B66
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 13:30:03 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 7BAC33F108
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 13:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1628515257;
 bh=NTTyZ1PzVqD5m0nUKgVjDtwNsGqCsp3AlVoZbwU4cKo=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=T9o0+Ggbng4H17LFYN3Pgmf1BhDsEFO8vlOPg7RyIbf5inTbc+6EMhtNAs3aPdkwX
 UYUra4IG6K/MC97m6+hN/CNI0BZevOqQMmJ6oXwrlHLOu6YzbIKMHAvqaMRrxCnH4P
 NIVs1xrvqJKY/XW1uV8gCzb/bLYboXpG2lNzEVHU/Kwpo5wxVRt/6sO1MBNnAtH4I4
 MLVXQNYZzbqJdccxjZTSvNoolppiFJi/Se5ZSiQIMVY+fEW4loISJyZgJ9LC6kNsoc
 ZHyO4UOUHxGNOkGPSsgo/NB+Ql9m/iwuG1bB/I7Pggji/I3AkC3M+m0AESHzW9Ib81
 DqOz+U/CX+t8g==
Received: by mail-oi1-f200.google.com with SMTP id
 c6-20020aca35060000b029025c5504f461so7154306oia.22
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NTTyZ1PzVqD5m0nUKgVjDtwNsGqCsp3AlVoZbwU4cKo=;
 b=BA7QVpGPggU22OkAg/q+ulX8fkbIPMiRI5Jywr7YaMJPcf1YI4aYLSpK6FMzK427R8
 bRBDtkp6LkyOGapYZlPensNFqvO2bTVHW/sNV8LZbT0FJIek2Pi5zrKmP8QvlNwkjmV0
 BnSgXpLszxgewTIi7BjmLY356ngFdyXIKgfl2Qdc57zAx30mHvcZdXluW+c+aAtuJ4TB
 mACSb6ofc+QqqcoTtsSr9SwM5sG4Cny5Wjjn+4gHwml4n8XWPAUjnLODw2iUQ0Jiloxr
 dCLxM2aQS9RKebTBLMSICmH6OIvMdw488ex6RbB/XtfKEn9ofTt5T7+Jpi+JXE49ao1V
 LnDg==
X-Gm-Message-State: AOAM532AF8037xMqg7D/9Bv82ZJu5So1R5vTARoWGcf7lV8wJsWB01+z
 aRWNM8Ni1egu79JTZxlfcxGaDW5yaMEP+8xMFLouqREBREufZyInTkMqiXy3kvJav6Zhh2iSLHf
 is1X6fAsrfeARNWN6iHlQXOn3Vzy2dF9RCXhW/XPax3ITgoW9daDw85NYoEg=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr17165492otq.3.1628515256282;
 Mon, 09 Aug 2021 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNi2dzgu7+97WSnjOJsr5O79tHnSKIsbPVmGjoEOMDeGR46gMbRXfrJICwnh/q2QPQLkxDlVm+kBQMktJ+ygE=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr17165481otq.3.1628515256059;
 Mon, 09 Aug 2021 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
In-Reply-To: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Mon, 9 Aug 2021 21:20:45 +0800
Message-ID: <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
Subject: Fwd: Req: about Polaris with RKL platform
To: amd-gfx@lists.freedesktop.org
Cc: Anthony Wong <anthony.wong@canonical.com>,
 Mario Limonciello <superm1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 09 Aug 2021 13:59:23 +0000
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

Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
AMD provided a parameter.
#modprobe amdgpu ppfeaturemask=0xfff7bffb

 I thought it's better to check and assign values in amd gpu.
Have a trouble determining the type of pch(RKL or else),
search in amd drm driver and can't find any about this.
Would someone please guide me? if there's an existing function.

here's a proposal, check RKL PCH in amd driver,
the pch definitions must be splitted off from intel_pch.h in i915
folder to include/drm/intel_pch_definition.h

> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>
>         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
>         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> +       data->pcie_dpm_key_disabled = is_rkl_pch() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
>         /* need to set voltage control types before EVV patching */
>         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
>         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
