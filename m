Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C947C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 18:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBA910E21D;
	Tue,  4 Jan 2022 18:47:26 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FA210E21D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 18:47:25 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id m6so60751051oim.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jan 2022 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CIpGvlY5mphmLz0f169j4cL4nSkax1UaRwg6ED/UhnY=;
 b=P2EsGRREc0SFjZwK0u02EiLja65xw4ZdRnvAkREabQWgnuImudiPaS9Ykxz5OcLQfJ
 +bruixOAd+vVKEF2mAyOxouoFUc5xmDkhv1iHEseyJ6w/IA6PqEDGUj+WpnvYB/TqPOF
 CGXdXUcROo7WWDcdx5bPL61RuPpEf//yiSHZ0R4oPYaCwhobT6JRt4ahe6xrvNLZPUkz
 CMcS2t3dWqZ6iTHNhmTOjSpWLHY1A1VTGBpe2RMo9ibQfUOhf2YDIpCOaeJIexPdgVh7
 pQlXPDArMuUnxyXg/ZiPupQlr+BY55FTUSFjSejkl6xZLdGcekxKJPD5vxmMMyPkOccl
 62BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CIpGvlY5mphmLz0f169j4cL4nSkax1UaRwg6ED/UhnY=;
 b=59z3Q0GEqqaDdow4bINQviUM7xatOkqhPKWjIGaKwaU0Pf2RDtFSuXTNuGAt80IrTu
 Hv758gFB5Yr7bpmxQujyqxTG3Qn2rq8TfveUhnfYlov9XtQf0AztnZBNmehXN1R9kRQr
 N9/hBBmaN+YTGqEsAxxxHTMpmI+NQO5VUpT54eTUnuvUnxbl7a47Ru2i0P3PoOBeaK94
 sXhu4Vz8EV2EWd0LfvA+w5gU/OGuI2ls69JQAO6afcbWUCWErQRjNoAEVcc1axbHzv7K
 aROadBqyWV7i0FSHKm3HkdyW8TtKasFriEdMiHp0nVnHjkEb4sNa/CVKyEw8Iw8OBoyI
 Q66Q==
X-Gm-Message-State: AOAM53312DsOs6w7E97dOwH3OzHO9JjCg/tp2vq6h63b+RtI6zMcquOg
 LgjO73yJS21mAhUlWWnR8FyXCSJaOvRlr6k7xPU=
X-Google-Smtp-Source: ABdhPJye1qlSaNo81MeyNpgvjv3faSeQDVRiK2A1EdI0dwtkuB4buu+5Erzk52TsKAcWGre5uS6KW4mzDv2BzgKpoZU=
X-Received: by 2002:a05:6808:4c3:: with SMTP id
 a3mr39080670oie.123.1641322044867; 
 Tue, 04 Jan 2022 10:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20220103152311.1453-1-mario.limonciello@amd.com>
 <20220103152311.1453-2-mario.limonciello@amd.com>
 <BL1PR12MB5144856BFAA05B8100781100F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB515790C579D9A38B018AE43AE24A9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515790C579D9A38B018AE43AE24A9@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Jan 2022 13:47:14 -0500
Message-ID: <CADnq5_NwLxnA7p-1S2CLar5PKYptwdVJqde5VjYz=dhLywPrPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 4, 2022 at 12:26 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> Maybe it was used more widely previously?
>
> The only place that I found it in use was amdgpu_device_evict_resources.
>
>
>
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, January 4, 2022 11:24
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
>
>
>
> [AMD Official Use Only]
>
>
>
> I don't think this will work properly.  The in_s3 flag was mainly for runtime pm vs system suspend.  I'm not sure if in_s0ix is properly handled everywhere we check in_s3.
>

In that case, Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
>
> Alex
>
>
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Limonciello <mario.limonciello@amd.com>
> Sent: Monday, January 3, 2022 10:23 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
>
>
>
> This makes it clearer which codepaths are in use specifically in
> one state or the other.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index db2a9dfd5918..413fecc89e6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)
>
>          if (amdgpu_acpi_is_s0ix_active(adev))
>                  adev->in_s0ix = true;
> -       adev->in_s3 = true;
> +       else
> +               adev->in_s3 = true;
>          r = amdgpu_device_suspend(drm_dev, true);
> -       adev->in_s3 = false;
>          if (r)
>                  return r;
>          if (!adev->in_s0ix)
> @@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)
>          r = amdgpu_device_resume(drm_dev, true);
>          if (amdgpu_acpi_is_s0ix_active(adev))
>                  adev->in_s0ix = false;
> +       else
> +               adev->in_s3 = false;
>          return r;
>  }
>
> --
> 2.25.1
