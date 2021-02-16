Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 19:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B2664E79
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 19:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2664E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79B16E97E;
	Tue, 16 Feb 2021 19:53:07 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BC16E983
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 19:53:06 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id v16so1684860ote.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UZp8ADXCpc0dXj7RsCg8M6HjeMcefwEksP0hVPDSKnM=;
 b=P2nrAaUh2Lly6HJ+TGoS40h96slMiKUgaoqSze1wOKkB4PueibsW0kXk7GLfNfTS9X
 rjdbtuAz0vyLTYTjKwTSGdxi31mskLLQpwa7cGgxaJL2ut2xf7o6BzQ4qptynzzPNV8E
 QbcOi19fo3xQ0dwJuffVq8dHvPyjiVeulCuzfIzX4gMd6qJoOCd/JHlPKlIwIRAaAVYJ
 Vpfg2PBIi346Fu87eeLpgjoQsEcExfLHKkmMlhmisAj6khaKCyGqA+zeU20dsp4vGh0a
 O8sGjEX+6UQNeNrRxL5JA1+vy4miEe9MXqQ9IKTBbnwRmYM7Aln6kSr65axDuKFlNPyu
 PbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UZp8ADXCpc0dXj7RsCg8M6HjeMcefwEksP0hVPDSKnM=;
 b=iPUScLRwyXCmUj5jIvEhhKCkcN+kjUjjh5NAEKaWxcejLJ4f6wAXRV9IXm51sUVIrR
 A/lVy05R+U7eiM1EI1B4+gFPEQ3GviJP10x+023YltmjoAhGi8lmEjvgoVGd8sVAIndy
 77Du6maJ8rfQStINRRCHKh8MovJGaYXH6pv09YjXn4Y2nKuYq/nA1AHZzBrDBQAvjAOE
 bugiSdZpVdRYTTnPfPEdQb4Iz86YxXSiVISCemtXbYZW7tcXJY5kxuM8AYT/pdLvVWwf
 bvfajtYRiowbGhljHdV3dVmngQOufSFf27Ng/HPB+fAtEpjLUahItMfaGvJupbYVAdE0
 YvwQ==
X-Gm-Message-State: AOAM530HtPsSyzcEw1S/QX9lKwBWxh+BURwktfxfYB7NbJbY1pL33vNX
 fGHvxJ3sQB60W+K6CCWD8GQuLAhFRLIDWrWY3Xc=
X-Google-Smtp-Source: ABdhPJxZxFIbZ1+2WCWsMnlrDu1asIs+eb4n1R0BaRDeLkqA8w6R3gE5/ygpp4HNaI5X2SOocpnS20JsQZtu+0PPoYk=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr15750189otj.311.1613505186195; 
 Tue, 16 Feb 2021 11:53:06 -0800 (PST)
MIME-Version: 1.0
References: <YCwefEWbsHeME7vQ@mwanda>
In-Reply-To: <YCwefEWbsHeME7vQ@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Feb 2021 14:52:55 -0500
Message-ID: <CADnq5_NUk+t46Phbfm6H5wFjaTxkrbM49Hd5py-NtTr+v76vgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix an error code in
 init_pmu_entry_by_type_and_add()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org,
 Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 16, 2021 at 2:35 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If the kmemdup() fails then this should return a negative error code
> but it currently returns success.
>
> Fixes: b4a7db71ea06 ("drm/amdgpu: add per device user friendly xgmi events for vega20")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c     | 4 +++-
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 19c0a3655228..82e9ecf84352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -519,8 +519,10 @@ static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
>         pmu_entry->pmu.attr_groups = kmemdup(attr_groups, sizeof(attr_groups),
>                                                                 GFP_KERNEL);
>
> -       if (!pmu_entry->pmu.attr_groups)
> +       if (!pmu_entry->pmu.attr_groups) {
> +               ret = -ENOMEM;
>                 goto err_attr_group;
> +       }
>
>         snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_entry->pmu_file_prefix,
>                                 adev_to_drm(pmu_entry->adev)->primary->index);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 72f35a2babcb..3786b1c85182 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -274,6 +274,7 @@ nouveau_backlight_init(struct drm_connector *connector)
>
>         if (!nouveau_get_backlight_name(backlight_name, bl)) {
>                 NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
> +               ret = -ENOMEM;
>                 goto fail_alloc;
>         }

This hunk looks unrelated?

Alex


>
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
