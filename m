Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5FCC5517A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5104720E65
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNySan2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C091D6E593;
	Fri, 23 Oct 2020 19:03:00 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABB26E593;
 Fri, 23 Oct 2020 19:03:00 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id k18so3043331wmj.5;
 Fri, 23 Oct 2020 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lOB0JzHjbA9wQ5NG9BGjyGSWpxAlxpb+jyv90TmNGmA=;
 b=mNySan2I0jTCmPSKxF10PPz3YaNEMZPIjR6UuFiFlr4d83tPvQyAzrHwDDGwpnznFl
 X3PWCkQScWhaxcr8U/hvO+k5yNeTD/fRrbyCDG/5xoZlrRScwoQfjRGVCHcPr3zkpHYX
 EVIJSiN9s5mLhwQE//jCLwxO6/R34O7azXq2csdt+WnT/ItPoKsGbaq8a9gWfbdhGbF3
 WayMvL3jXbQeXUz3J0BPhTFlunoMXJVkPSWgYMXnCcNRJmaTbc0VlF5KMMm3M95mU+g9
 6c3VUI4DpQIpDTfTlJrnS9BNJdP05g31Kb5WO8HwKUK2lHILEEpzUjUqjqJuD1YKk+0g
 nc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lOB0JzHjbA9wQ5NG9BGjyGSWpxAlxpb+jyv90TmNGmA=;
 b=EZUQA3uYfrrWwrJf833TNRlbnKQ6emuP1IrkJd+3bkIVKlfm+x3MCVlEvk4DJdYIG6
 Eu0uTfeR+FFqwcfiOKjUTAXJMUojf/k8bpoZAPRw97V/j8t7NJjKMk1PE1pF1/vDpWOt
 oujZ2T6hYy8+DsYHkqTVhWJtJGAJ6AS5T11GncU60thUZ5IYV/XsEVcDAHncfh9dW1rl
 F6SNw39iDyTOle+4kCSD5nhpsYtf2v8MhpWWC2k6LgZokyoJ0BND1s3BdyIf3RaVIEf0
 zPdyGCVjbecBRFhPFNJwGChkzuB8xYg6Pezt84uiqQ+njGRuCMYDeLRG5G+jKA4nbVHo
 ylxA==
X-Gm-Message-State: AOAM533TMhLeV9XnK+txUgJLVZybUJyVUY9NLESrRQSZ62glh9hptdpT
 dkdIM/BAax7bR2OBcferIPe8mFnGmAcr5YZAIrM=
X-Google-Smtp-Source: ABdhPJyBs9rLm8WQ/JdNSYi4YpeykUC3qTYLy1NXVB+RxZLjYHvbVJpKhrpymA1DrvebkV7cRe6NsL6PANeL342Hh38=
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr3037167wmh.73.1603479778669; 
 Fri, 23 Oct 2020 12:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <31341a0175f0aa4ec160d10b27a91703bdd9a036.1603469755.git.mchehab+huawei@kernel.org>
In-Reply-To: <31341a0175f0aa4ec160d10b27a91703bdd9a036.1603469755.git.mchehab+huawei@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Oct 2020 15:02:47 -0400
Message-ID: <CADnq5_MjP1_YPFYYuaO+z9KTpMd+Gk6mtB74P1LjbFrOUt70pg@mail.gmail.com>
Subject: Re: [PATCH v3 02/56] drm: amdgpu_dm: fix a typo
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alexander Monakov <amonakov@ispras.ru>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Roman Li <roman.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Oct 23, 2020 at 12:33 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
>         dm_comressor_info -> dm_compressor_info
>
> The kernel-doc markup is right, but the struct itself
> and their references contain a typo.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bb1bc7f5d149..48ec0535d92f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -583,7 +583,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
>  {
>         struct drm_device *dev = connector->dev;
>         struct amdgpu_device *adev = drm_to_adev(dev);
> -       struct dm_comressor_info *compressor = &adev->dm.compressor;
> +       struct dm_compressor_info *compressor = &adev->dm.compressor;
>         struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
>         struct drm_display_mode *mode;
>         unsigned long max_size = 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 34f6369bf51f..a8a0e8cb1a11 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -86,7 +86,7 @@ struct irq_list_head {
>   * @bo_ptr: Pointer to the buffer object
>   * @gpu_addr: MMIO gpu addr
>   */
> -struct dm_comressor_info {
> +struct dm_compressor_info {
>         void *cpu_addr;
>         struct amdgpu_bo *bo_ptr;
>         uint64_t gpu_addr;
> @@ -148,7 +148,7 @@ struct amdgpu_dm_backlight_caps {
>   * @soc_bounding_box: SOC bounding box values provided by gpu_info FW
>   * @cached_state: Caches device atomic state for suspend/resume
>   * @cached_dc_state: Cached state of content streams
> - * @compressor: Frame buffer compression buffer. See &struct dm_comressor_info
> + * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
>   * @force_timing_sync: set via debugfs. When set, indicates that all connected
>   *                    displays will be forced to synchronize.
>   */
> @@ -324,7 +324,7 @@ struct amdgpu_display_manager {
>         struct drm_atomic_state *cached_state;
>         struct dc_state *cached_dc_state;
>
> -       struct dm_comressor_info compressor;
> +       struct dm_compressor_info compressor;
>
>         const struct firmware *fw_dmcu;
>         uint32_t dmcu_fw_version;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
