Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C10C83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DCA20757
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzwi4PIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DCA20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B668F6EAB7;
	Wed, 29 Apr 2020 17:39:42 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807FF6EAB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 17:39:41 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id s10so3611904wrr.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4OvVeyPd5cDKY/mnpBkKCuvAdSIVpKQB/+8ZPEEg65Q=;
 b=pzwi4PIjHj+5AKWbqzCyumPP0uvrAFSwWB7QCRC5RmiMCWKIiUTIeuUdPlcvBoSHLa
 G+1gjoELr6kMQLhInBYOPSsDwy2VdGrYLBbj+At5/PqletrW4pq7+gHrjSccdE8Ie2HV
 FUb+xWj6aPNfmQSt1f3TqKiZjcZ6IS3Zswf6jOxYgjrNfUXn1zrQAe7/qmjAH5gTcfU+
 KI4QZAPGOOosFo2g/94W4KLeswlSP0MhDeYLufEYACQeVouOupRwQIDRWlQX4i9Z3QCf
 /9Y+lH69EGS1q7rcc/XxYuxbe8Agf+HifK83IwSpHfpTm/UwTSGqBXzfNly4Y7f2Pov4
 nKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4OvVeyPd5cDKY/mnpBkKCuvAdSIVpKQB/+8ZPEEg65Q=;
 b=fasXU54AnjCW17vsyEbw9ZvT4T/x9AiTaccqX2xmSdOzmvMRoqNmqy5dsbBjWzEarw
 jnYARoaL6xX7FqmzqRz40TGu22rdGE38kk4nCVEtOBFvpRHFGON4ulAzH+Mq9PsrqjL5
 97bDnFJ0X7c0rrs3ipGIH3EolotGSlyA6uNe97EMnaTwJmz2feU+TBVXX+rEjx6yMyo+
 onkcvbKR2fEdKGQmOg37w7oufi9izDx3YbkORbP/PX62SCXXfTI9F+5O1m1H+9oxESd6
 c+o8YJNC2XhQhImkZVqFgNZIbZalkm6cK0NsqyCTfhPrD+f/rGuMEXV0/A43thq/lKd6
 ILHg==
X-Gm-Message-State: AGi0PuaSE1cjsG+UUrR8uVSvgPaQJFG4ew3MInMcEzOwEeBqqczYt9qk
 dHAVt05gEwXRI1LWt6H6gw3WqAjpey0wIqjXsMc=
X-Google-Smtp-Source: APiQypKh6mNQyzhWImiGtqb9PsNJi/RIPs9/KUHbYUOba4w6YG7p5FsPn7FQdxH31Bbdo31kAkSxD21UnoqqCFp1av4=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr42056192wrq.374.1588181980061; 
 Wed, 29 Apr 2020 10:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200427164735.27409-1-kent.russell@amd.com>
 <20200427164735.27409-2-kent.russell@amd.com>
In-Reply-To: <20200427164735.27409-2-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2020 13:39:29 -0400
Message-ID: <CADnq5_Naii9wE7YH7G6geNWgnFC_AgdicaTex6irc+eGwnczMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
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

On Mon, Apr 27, 2020 at 12:47 PM Kent Russell <kent.russell@amd.com> wrote:
>
> Add support for unique_id for Arcturus, since we only have the ppsmc
> definitions for that added at the moment
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I66f8e9ff41521d6c13ff673587d6061c1f3f4b7a
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index e98d92ec1eac..f55f9b371bf2 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -293,6 +293,7 @@ static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER
>  static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
> +       uint32_t top32, bottom32;
>
>         SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> @@ -315,6 +316,15 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
>                 return -ENOMEM;
>         smu_table->metrics_time = 0;
>
> +       if (smu->adev->asic_type == CHIP_ARCTURUS) {
> +               /* Get the SN to turn into a Unique ID */
> +               smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
> +                                &top32);
> +               smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
> +                                &bottom32);
> +
> +               smu->adev->unique_id = ((uint64_t)bottom32 << 32) | top32;

I presume the top/bottom order is still backwards for consistency?
With that addressed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       }
>         return 0;
>  }
>
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
