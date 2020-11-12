Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84453C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EDC20759
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3S2MGrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EDC20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5559E89F71;
	Thu, 12 Nov 2020 19:51:35 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282D389F71
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:51:34 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p8so7309443wrx.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=skeJAT9YgqqkF88+za4F3oUareJfIo1mi13D1DOjkeA=;
 b=N3S2MGrOH5wyUpD4Wtsy4YbIqtbEtJnQx5Ki/eY2qBpQbg3MlJ5OKz9DDO4t0yWe6I
 gdaym54NeouqUqan+9E3PXfjHLnMpL0156z8yrZ0Q/2BM5EKpS0NcZrtw37HmUUq2qpQ
 sa9pJCjIUlplc9hC+SS7jlrnJWjmyDNEvEeueRDbSrGkwXG5ubqROH8XkeI5M4Oe7s8A
 hd74wiQ+lrMt88BOCsVtOWMRCN3B8ux8xuHsKqh1lAepssZrX65XSBCaC7NrbVEfSqf9
 IvCiqgnSXxJxN5FKbz1i5D5ml9LfLz54KOw3Q/H934FztmnACyQzM9leGa4kgMIZmXiY
 qjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=skeJAT9YgqqkF88+za4F3oUareJfIo1mi13D1DOjkeA=;
 b=epuFERpNy9kGB4R2FgaqdnkzkzXyQJC/Muv7PduzSe3IWpGqmJJ/XWH7mnKuLeyDdL
 MnMy9CZI6n/AQgqdIF5nITAo1Sf1Ld5awpq/awGDIznxxuUTaSoLREih+t4KfniqT2EJ
 AvQ6/TBD9J7rWivs65Kh8fkK30CIzfpDEgoVTDjqZCoIZdH5bPT3kEHFOQG23rEoSrxM
 3RN/+/hw8eEEnfrSyQ3tO/m8hYW0rKP+mbJddnpU+QaPX/Zhyd1wvAL8ckteyH+DJgUg
 3yn/e7+8nW9cKuo8td1sazWo6LFMUf+LtJ8qSvXmRU3NvTH96boaHEYI+TC+XICYNnYO
 wqaQ==
X-Gm-Message-State: AOAM532GD2/k6geTZ4++2HpCXBk6S5L3LL0K580wEvx6qia69sRWvPUc
 MMOcyl3cyV0uMGNtBW4NhKWeSKqkZY2pYKhJHf7nug6u
X-Google-Smtp-Source: ABdhPJw2SOqGOgnZ74rGTjQ3cjLxW26kmamiswMkaAB0Gr8jiR2sjEuv3mhhOkM5pDmo4iPn1QtU24fb8hAR4MOF8rs=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr1271104wru.397.1605210692885; 
 Thu, 12 Nov 2020 11:51:32 -0800 (PST)
MIME-Version: 1.0
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
 <1605164796-22215-4-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1605164796-22215-4-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 14:51:21 -0500
Message-ID: <CADnq5_P3NAVn2znhsgwfm=9PdUyfC+0+3EH0VPHXw-KeASMOiQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix reset support for s0i3 enablement
To: Prike Liang <Prike.Liang@amd.com>
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 12, 2020 at 2:06 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> update amdgpu device suspend sequence for gpu reset during s0i3 enable.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Maybe squash this one into patch 3?

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cf6a1b9..2f60b70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2650,7 +2650,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> -       if (!amdgpu_acpi_is_s0ix_supported()) {
> +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
>                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>         }
> @@ -3708,7 +3708,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>
>         amdgpu_fence_driver_suspend(adev);
>
> -       if (!amdgpu_acpi_is_s0ix_supported())
> +       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
>                 r = amdgpu_device_ip_suspend_phase2(adev);
>         else
>                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
