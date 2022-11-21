Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465BFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA9110E31A;
	Mon, 21 Nov 2022 17:28:03 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0889A10E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:27:58 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 cn2-20020a056830658200b0066c74617e3dso7750873otb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=86A2YchUr5AUxDTLUpsCy8SnHipB0uzofzstxmnAY/Q=;
 b=EziBrS+xsNr/n1t9bZmp2s/J7ojuv3objdl29GpvyZ8H9nJJeI0lT5hYQf9paSJdHp
 TDopLWDCwWfHnz5o1T3LG1GzTSDd1uNlnQ6z8mjhx4+ViTF0aA+dpveUWTEK0v1A2NyC
 06h40jgl1xrbbJl6VRjQiRXpLQbEz9x57if9uAbPc385DXw9YKTIeofT4akfGuCCkra/
 CPB1ybt8ssmPaQPxD1xqY7rTZbt3SXZfubK77380DO6FeXPNaXkkW/jjIx/vj6yTRhkm
 F7lzGR4JzhFTBn0c5xPNW+ggpAk2i/C9LVWdY05vVn9MF34OSlKJujkWH99a2bdbuPfU
 zQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=86A2YchUr5AUxDTLUpsCy8SnHipB0uzofzstxmnAY/Q=;
 b=59J08XNCVu1fisfkkFwn86CN32yaNS9Psoswzut7dB3tMl85q9jhMooDgBvZ2taj9w
 owpBsjQEcV1OxSDcXgbEOI0R+Tuz28NW+PyxUDb0mKVmzgvt6Z7m1Itt04AkUrjoMHFU
 DgtJEQ1bC484MZyEmZBeN/YfwtcO1WtIIKprbHWIqgrymdRv8Kn4QMBBsmqcTBZS2AhC
 81BrxZhYKMWLg0vqHbPt268S+hEk+gVqZmpJMsf3c4H4ULK7PWt3Jol3/GZBYXFpayMz
 0Qacn1YQXDAmNUrRfWlivJaBWWNf33goV3sTP4dLEeMggEnpOGuM4JR+vkBRvkuflhDa
 YzMA==
X-Gm-Message-State: ANoB5pmIt1p4liQna0VwCLy7fFQ5ksK5ZpSrZWH+ZAGMHcQyVFMnW8Zq
 7yPqy7BTUmMArzDlJ87HYpPCtaZk2sqMdBN5kZo=
X-Google-Smtp-Source: AA0mqf4NCKZkCq5nlePEfAeAro0SDIFrNsJdEy8CZgw+vN44rLJO6gDgWyZjj393caqULQ6EAWHFzQo5uyQWKc6i1HM=
X-Received: by 2002:a05:6830:1b62:b0:66c:7982:2d45 with SMTP id
 d2-20020a0568301b6200b0066c79822d45mr1988569ote.123.1669051677314; Mon, 21
 Nov 2022 09:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20221121172242.57717-1-luben.tuikov@amd.com>
In-Reply-To: <20221121172242.57717-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Nov 2022 12:27:46 -0500
Message-ID: <CADnq5_Oa=sxEX8zSGW__AtVzHHOfZ63KkRhv0BuYjthSfM-USA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix minmax warning
To: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 21, 2022 at 12:23 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Fix minmax warning by using min_t() macro and
> explicitly specifying the assignment type.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 5a905002252d7d..53abd770924229 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1436,7 +1436,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>                         case 0x8:
>                                 high = smu->thermal_range.software_shutdown_temp +
>                                         smu->thermal_range.software_shutdown_temp_offset;
> -                               high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
> +                               high = min_t(typeof(high),
> +                                            SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> +                                            high);
>                                 dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
>                                                         high,
>                                                         smu->thermal_range.software_shutdown_temp_offset);
> @@ -1449,8 +1451,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>                                 WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>                                 break;
>                         case 0x9:
> -                               high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> -                                       smu->thermal_range.software_shutdown_temp);
> +                               high = min_t(typeof(high),
> +                                            SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> +                                            smu->thermal_range.software_shutdown_temp);
>                                 dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
>
>                                 data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
>
> base-commit: 51005ef41b7e91d1e24e2defec22bc4f1eeb7040
> --
> 2.38.1
>
