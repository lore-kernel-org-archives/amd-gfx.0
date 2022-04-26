Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A79C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 13:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B939110E4A4;
	Tue, 26 Apr 2022 13:08:59 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8737E10EFEE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 13:08:58 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-e9027efe6aso11972472fac.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=czv81LDe+E62AgbMshDS21kdyN9Ob9LP6ABjXNzTmn8=;
 b=eA6+1pjzKyFOcYgwN8Z7a6Wbzdr9B7dPFS8Zb96OZKEdSEIxMUt3gC+/PPtLPCcG0V
 b5vX9dvjPz0o08ktx/mG50gdsxezw7cMEF7nLjiGQ5FOzAeGvFCZr6rPHYLRQlpyQQro
 PYRjxjfHRbN5n+DRPZpdA7Zy2ck4LoGIKF1vDCBzr38+D1ySuWVnUIVSlKeAD5DBb2MF
 HgJaogUWDk5eV4TTyernoJnpOX9F6M+2BBGUxysWDLDl9VBARu3UM8DWYx29vz4WW95y
 m6LYUnX5XSuDt1aYqEXHZgqI4pT1HJDSDcYfRWACMdWYZYkKHTK+xlvW5EHfoiqo2yqr
 ygUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=czv81LDe+E62AgbMshDS21kdyN9Ob9LP6ABjXNzTmn8=;
 b=EHewYYlQdzqxvl2ERoTrUPAt++R6o48GThd5DSmxknAs8fsNMbOHIyOhH5xKN8frRr
 pEyZEl/aWz5Mh2qsttg3iqJLEWI6e8bXQxNgGULHWticTyMUj9BFqqkaDBoB40eDFST7
 1RgFoTPf9wPBt3EH/88aAE/RXa2uhmAYoAaRcS0XiP5/HEpksMIGU/wOVWCkpi7SGGsM
 jS1/wQLfS1Jjhf+XeztyGz+P52ZjPLqc5WPL2cCq6Gxh74BOLP9gIchVmrpi5nQlubAs
 hLau07rtJ/Cxg1B/LuWmiL8sI1ShURpYvIq9XleVL5wTULbFacGgMRxdbICPJKmuluZw
 bXsA==
X-Gm-Message-State: AOAM533QgrgBo58mK/Di2VJ7treaCL6A//fBk6HtwB3O7tCNjnLp6c0j
 UYX5U1nGJBzsdaRfKqRVHL/etiVTHY8P1NG3pLY=
X-Google-Smtp-Source: ABdhPJw3eSd1/Bho1OeAK+lpifDl/htsYez9vmGbe5cMXBZswoqSbbnQ2mxcgFe+0CgSbA8zFT/djGg1pHBV1jqtflI=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr9624505oap.253.1650978537720; Tue, 26
 Apr 2022 06:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220426094720.436117-1-evan.quan@amd.com>
In-Reply-To: <20220426094720.436117-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Apr 2022 09:08:46 -0400
Message-ID: <CADnq5_OBQ2zpBzg9TeZdL23Z3xhRdtRiCh1mUMnG2fufvtec4w@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amd/pm: fix the compile warning
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 26, 2022 at 5:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Fix the compile warning below:
> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
> kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'
>
> Reported-by: kernel test robot <lkp@intel.com>
> CC: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: If4985252017023d6711b4d7eb1192a397baff813
> --
> v1->v2:
>   - drop dead code(Alex)
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 8b23cc9f098a..8fd0782a2b20 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1623,19 +1623,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
>
>  static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
>  {
> -       u8 i;
> -       struct amdgpu_clock_voltage_dependency_table *table =
> -               &adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
> -
> -       for (i = 0; i < table->count; i++) {
> -               if (table->entries[i].clk >= 0) /* XXX */
> -                       break;
> -       }
> -
> -       if (i >= table->count)
> -               i = table->count - 1;
> -
> -       return i;
> +       return 0;
>  }
>
>  static void kv_update_acp_boot_level(struct amdgpu_device *adev)
> --
> 2.29.0
>
