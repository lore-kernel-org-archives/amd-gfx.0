Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB70C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219F920774
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyognYiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219F920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF97B6E4A7;
	Tue, 24 Mar 2020 15:33:44 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4006E3B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 15:33:43 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c81so3681218wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h+ZmBvB5YPBKJHAn07y97A+XZTnhRvog8Arxmsec/AU=;
 b=dyognYivrq0bBUbioJLb35m3M0LtqHcEIaNvzc6loF65fJM1WX/QylgLKUQODy1fuJ
 kJyXqjLtk9cKtfe6wLnZPPxaNo2J71Tv7xJlNEo6m33Z2/29aQ5lmRzP+XMI439jHodL
 IDS5o1xTFO1auekkHPPldAEurLS6QAR/qhoqdEUVSsUtXqPhf/+C685ar3kh0Tog88Ww
 N/0ocI6yXiEbpIgIgabMrjHTZLnF4ly4xDqAIA4/opBayOOzYhHoudx6MoFqR5da7jc/
 ITLGoIbd3K9I5Hn8LPtj7ySOnNEgbJAszzO1bOGqWn3h7CBxNCLfQM6oFvT89lty7Jx6
 3i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h+ZmBvB5YPBKJHAn07y97A+XZTnhRvog8Arxmsec/AU=;
 b=nMD/UovWaRh2bZOBpLnJ6mSkA86WXiGVe4ksfbkKDl2LPld2e9eKtXflki02jQZ/T4
 s+75d/6ove7UhH3ScbERa3nyhRE1KujipQQQlfNjSufEW/dX/ZfPHZPR61BlNsem/MLG
 0dRkNHHtkHkqK7Q4b6d8+uJ+AfpP9fVQc9WIk+lO5y2+Dtv3u1v0+i8Hxg6ZqRpktmqE
 3f1QVxp4zGPrm6TXhfLzKp5RwCiIbCsFlAWtWSsRvHPsVFReFjCVQTlwmM8+AulNQWeo
 M/F3ljh/0yYwzSq+Rn2sUZWOBSYLc/KzKybZWTn5FbxeQf9dI9rC2nLDk8hFPRbRcqSY
 oc9Q==
X-Gm-Message-State: ANhLgQ0Gr5WIz2AERFkr7NZZ2FRXGKjtEOzmfIRsdHobp/hpPii0BAA0
 ToZLJ9StAuebgPv3xs29OM6sIuaq/HrV1OKPeXr5zg==
X-Google-Smtp-Source: ADFU+vs5wufOe+VDK+9Am28pE+YRQ3MuqPoFCCclzBOeWBlio7gDsowqkHTM5c4ulu7BqEhzjRSumrhoJq7ArpFjZgs=
X-Received: by 2002:a1c:de82:: with SMTP id v124mr6168131wmg.70.1585064021447; 
 Tue, 24 Mar 2020 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200324114159.23131-1-kent.russell@amd.com>
In-Reply-To: <20200324114159.23131-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2020 11:33:30 -0400
Message-ID: <CADnq5_PChCqJs6p8QpZnrt2AcrqBqKYfZfQ+ULUb7Q=-qQQjoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Expose TA FW version in fw_version file
To: Kent Russell <kent.russell@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 24, 2020 at 7:42 AM Kent Russell <kent.russell@amd.com> wrote:
>
> Reporting the fw_version just returns 0, the actual version is kept as
> ta_*_ucode_version. This is the same as the feature reported in
> the amdgpu_firmware_info debugfs file.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 9ef312428231..65bb25e31d45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -403,8 +403,8 @@ FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
>  FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
>  FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos_fw_version);
>  FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_fw_version);
> -FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_fw_version);
> -FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_fw_version);
> +FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_ras_ucode_version);
> +FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_xgmi_ucode_version);
>  FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);
>  FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
>  FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
