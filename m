Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB20C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952212076A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4LkxZMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952212076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCB36E86D;
	Wed, 25 Mar 2020 15:15:32 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F366E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:15:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d5so3635219wrn.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n15FCS0HRRxFN9wQZJQmPNX7gtnXBlw383PvFso0jwI=;
 b=o4LkxZMHBF/p8wsGAdjTXK8kCm0PBkuWcz3sEK7OtrL2IlFq+cb1/qZfVmuUTFJLTU
 9FGavTEFqGirBlrh1b0geiWfO8rnS+V9hbPcAJl5MV/chu10mb/HK2SBJyFEw8kRHgLt
 3qK3RWTKj/9u2bexOzh7fuM4uRuizYukRmBfziwu87JK4UL2S/kE/wZTOGpJfhIpJq3f
 0ni+dQDhkVd/XunVyaYYKMNGCg1foKj/UDA7Ss//R9WHEpcqBqEunSE9+XDWUHO9/JoE
 SuEKgQRigUndPfDNlMD1CckcxcCKhd9gBm1Tzk2UIGSEbkK0nyvwicolRbgmpJqGN6pp
 zqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n15FCS0HRRxFN9wQZJQmPNX7gtnXBlw383PvFso0jwI=;
 b=lJn6nfygOFJGtZvcjRu8CuyjbvATeG0AJ3mnPPtLFS6ybBz4ShvF9RnWia2ngweyvG
 sy6CohpyViXFHu1EP8UPNlw1YWGZP9LPPxA9IjsL/edMRfxG/G5zIOeut/9y2dPXJiaq
 JDu6u2nuQWTPH7fPdjA60ZnclcYrz1TY2VMEi6bky61HFWK7HxDQwxVsH4UZ5g6/gWWg
 KBdt2vJHQqxutq/1XRYHxJQHQTJh8NGpdl+Urh0qul777UCDPTDB4BMetPNHFGIvAgnJ
 AQLgmErv5dWCD8RZ7+n0jLAWe2OMlUgbMezncqUPKEksLTsqVKx0DG6kWYlxonARS6IL
 J5lQ==
X-Gm-Message-State: ANhLgQ0a0PbB30yA8NWpqHcUH7zbK01ceA6HZyDSQ223zBo3u7DTT+Ui
 KbUuG195EH1vZcLUtq3QUoXRdlTA4sxodTKIl7GR3pzZ
X-Google-Smtp-Source: ADFU+vsOZ5f0vQlt8zHy0EvYnXrjwAwFYTqqOOQonkcysBqfGJ/Dq4yrsUOvhMOkE9NTSBaWawWOrB0cB7QLOyqL9JI=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr3912509wrd.362.1585149330777; 
 Wed, 25 Mar 2020 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585146580-27143-5-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1585146580-27143-5-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 11:15:19 -0400
Message-ID: <CADnq5_OhO2mzeS-0m5FsyVykHxoKfKhmXOrct1f2RJaTCamNSA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Add a UAPI flag for user to call mem_sync
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: Ken.Qiao@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 25, 2020 at 10:30 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> This flag used to avoid calling mem_sync without need.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 3 +++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  4 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 8304d0c..d9ad841 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -238,6 +238,9 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>
>         if (p->uf_entry.tv.bo)
>                 p->job->uf_addr = uf_offset;
> +
> +       p->job->sync_mem = cs->in.sync_mem;
> +
>         kfree(chunk_array);
>
>         /* Use this opportunity to fill in task info for the vm */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bece01f..9168150 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -182,6 +182,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>                 dma_fence_put(tmp);
>         }
>
> +       if (job && job->sync_mem && ring->funcs->mem_sync)
> +               ring->funcs->mem_sync(ring);
> +
>         if (ring->funcs->insert_start)
>                 ring->funcs->insert_start(ring);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110d..7b08a04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -61,6 +61,9 @@ struct amdgpu_job {
>         /* user fence handling */
>         uint64_t                uf_addr;
>         uint64_t                uf_sequence;
> +
> +       /** UMD flag to flush and invalidate caches */
> +       bool                    sync_mem;
>  };
>
>  int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index cfbec27..f04998d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -566,6 +566,8 @@ struct drm_amdgpu_cs_in {
>         __u32           flags;
>         /** this points to __u64 * which point to cs chunks */
>         __u64           chunks;
> +       /** Tell KMD to flush and invalidate caches */
> +       bool            sync_mem;
>  };

I think it would be better to add this to drm_amdgpu_cs_chunk_ib.flags
or drm_amdgpu_cs_in.flags.

Alex

>
>  struct drm_amdgpu_cs_out {
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
