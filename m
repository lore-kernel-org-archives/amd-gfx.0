Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA891C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 19:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723BD10EAAF;
	Fri, 13 Jan 2023 19:18:24 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E6510EAAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 19:18:22 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-15bb8ec196aso11544183fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9F+1F2QsaPLeFTp1uKRLd5yD4reGj/H8N6wrHIZojd8=;
 b=Ih/w5A0LjC2JouEtAR3BpNikzilXdyJAoTGuDxhuAIcOlKtB1Y3nXFXcpd88+4u568
 /Q5mK51niQOEqV7s7e58HB0RyGJlFlE/POniBeQEv8+ZUAYoDpQ91cwE9c0+FrNiE/LJ
 1oCi5Wrjbojd6ZMMVFm88wZFbSeNr7xwIJIEoarkNf4AOKXAnxE7LyCkH6AwrwzuPmdZ
 T/1ES7qufUrIDj48QOQLByo536usCxP97pZkwG4JCDHDRPOfKqwmKlXXu9SUeleu12Iu
 rz78z7qATlnDp1zFC8X1LCMt5+BEYNKG7jarLMEjfeMGNJua5E02T6/P/nrGM8pcs7xj
 6Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9F+1F2QsaPLeFTp1uKRLd5yD4reGj/H8N6wrHIZojd8=;
 b=j/muovMbLv+fDZnRRRFJ0dJPUx7LLmA1vw802aW28BWBTNyD8CfRxIu1MKrJZMDY+Z
 zRnX/07lhAPDqp8UX3eg4Ug+qtSzrBH7srVSPrjzBi9P/QxXSSj40ufyyuwlkOdrxVhE
 OgvwVTucWg7xpzQnga6AvbLpPXDqr/lycbHjXYFM2xT0mgb2TBX6eScsCI+8pzxDrw/p
 PlN8Yac31CvK0vMUb1TXRE82Kl1krOByzBxQFq7qq7TLM+qrW1UZHC1EvIEHI/8C6Kpw
 wS0JRaDj6/ve7qE33Jnk+M3r1bbssjJaUkrZSWLljPwq1c3wH4x2QLJcT7n/RIlgaU9g
 pDUA==
X-Gm-Message-State: AFqh2krPqfZue89l+d68AEGtHmDS2n82lmr/NAbXn5gCoSzKLce9Phq9
 gnr4RTE/mykRWJ0h6vthTYWKG3naUXGIj4aW5TGa19jF
X-Google-Smtp-Source: AMrXdXvBoXKqgmlGUjMRAABzwRNoAFEdUeG1m23fFTzDUaOBK+iDm4Mtfgkt5dWkHRuVRc+QeJxJ7VOseS1aNpp5Cso=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr7007733oaq.46.1673637502178; Fri, 13
 Jan 2023 11:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20230112162443.603552-1-alexander.deucher@amd.com>
 <20230112162443.603552-2-alexander.deucher@amd.com>
In-Reply-To: <20230112162443.603552-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 14:18:11 -0500
Message-ID: <CADnq5_OVDjZ=a2SE25LPuusCUukD6jiUYAm28wg_3V2-OeL7Xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can someone review this patch (2/2)?  1/2 is superseded by Jesse's
patch, but this one still makes sense.

Thanks

On Thu, Jan 12, 2023 at 11:25 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Power reporting is socket power.  On APUs this includes
> the CPU.  Update the documentation to clarify this.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 236657eece47..76b9ec64ca50 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3059,7 +3059,7 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * hwmon interfaces for GPU power:
>   *
> - * - power1_average: average power used by the GPU in microWatts
> + * - power1_average: average power used by the SoC in microWatts.  On APUs this includes the CPU.
>   *
>   * - power1_cap_min: minimum cap supported in microWatts
>   *
> --
> 2.39.0
>
