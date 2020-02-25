Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8484C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA2021744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjV4VMi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA2021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F816EBA7;
	Tue, 25 Feb 2020 20:35:36 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBCD6EBA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 20:35:35 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so628882wmi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 12:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SoSRx4x8kVvcuhJTJtwqA+3RWF111GaBWrToxbP8AJ4=;
 b=DjV4VMi0i2cOx0hxOSC6dA15LVjh8FoBXJ7skiK+sYYE0RAjCY3i4gjm358uOs3i0x
 o7W/K0cI4iWI4q1w2RC9lC0/DpIAFMlwiIV9Tc+UjxrgwXgczCAYHz60YXTy6cpLnvMn
 eyjaBmbYoRom7fITSr0vnFG7HGktCvC029ubDHnnX+dWci8c3aGfPS8dRq6V0rS7aRZh
 rX5Zu/atnz9U5w5JSHM/Kql3ZIUU1gcWdgSTWTb4zgz+1agWucH/AHJmQGWyDNdCGbjx
 SlJ/3zvpc9CDmLCtBEUfvEiwxgHOimx8fd+xzCsy5JMYhmB5PR4eQJQ5LwcX5UE96tUI
 4EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoSRx4x8kVvcuhJTJtwqA+3RWF111GaBWrToxbP8AJ4=;
 b=K/DSkQdVt8wbrG+xlTBAIWk6m8FQwbp78fmtBEajSxjnQYiYKab0ys0bLpnyikfiDn
 +sD4VETc/zzwfEF1l++u/vFx4fgeE0prny5NRJ/Zhc7jpbAlTJOmOEc3xYQkDIBkGAsH
 lrrVy3aPzlbmdCYHykVdQlKPUUMYA5DBNruCLoq1tqfLKDKbBzTL4y6DQM2v9sFfzaPA
 Hq/QwPLAYV6LGAyzTg0wp8ZrUlOgRJyFd3E8ySHCLns1QJF6t5g7rYp9vs2l8bPB/yFr
 hZiBDYnFynZFoP14qCocytiSYQbQJoG8uxVxb9HUT1fyV8MbZljCMWYZokeU7FLkIKyc
 vYyg==
X-Gm-Message-State: APjAAAWU/9glz9VYOF21fkomiAi2DL0DtkO2ASi6II6F6gV2ThV63QFN
 wOkgh1HRXkJMvgoNyDNuhkkT9uW9BApGbLHEvTOMrQ==
X-Google-Smtp-Source: APXvYqxU+4SsUxLkw8r4zNinLxI99cqJe5XnADvAlHrQzlFh7kZKTRMY9yTfL7RwVMjmtqJrArel9gf5WeP0wPDht7Q=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr956057wmb.73.1582662934569;
 Tue, 25 Feb 2020 12:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20200225201945.27720-1-kent.russell@amd.com>
In-Reply-To: <20200225201945.27720-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 15:35:23 -0500
Message-ID: <CADnq5_PJOfFxcE1dX55TcJ5S8MBKxGNKVyFO-WPbT2MOVPXW-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix check for DPM when returning max clock
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

On Tue, Feb 25, 2020 at 3:20 PM Kent Russell <kent.russell@amd.com> wrote:
>
> pp_funcs may not exist, while dpm may be enabled. This change ensures
> that KFD topology will report the same as pp_dpm_sclk, as the conditions
> for reporting them will be the same.
>
> Otherwise, we may see the issue where KFD reports "100MHz" in topology
> as the max speed, while DPM is working correctly.
>
> Change-Id: I967988e936de5371c22bf92895bda22324d9631b
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e1c2c182898f..7e8276651865 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -402,7 +402,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
>
>         if (amdgpu_sriov_vf(adev))
>                 mem_info->mem_clk_max = adev->clock.default_mclk / 100;
> -       else if (adev->powerplay.pp_funcs) {
> +       else if (adev->pm.dpm_enabled) {
>                 if (amdgpu_emu_mode == 1)
>                         mem_info->mem_clk_max = 0;
>                 else
> @@ -427,7 +427,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
>         /* the sclk is in quantas of 10kHz */
>         if (amdgpu_sriov_vf(adev))
>                 return adev->clock.default_sclk / 100;
> -       else if (adev->powerplay.pp_funcs)
> +       else if (adev->pm.dpm_enabled)
>                 return amdgpu_dpm_get_sclk(adev, false) / 100;
>         else
>                 return 100;
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
