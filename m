Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E0C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF0260FD9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CF0260FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFAA6E5C1;
	Thu, 26 Aug 2021 10:13:02 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FBC6E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:13:01 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 d22-20020a1c1d16000000b002e7777970f0so6470461wmd.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=c8qSs6TDILxbShimwRABHakOnMzCbggbxC7nToVMXs8=;
 b=h5qWJVTuSCERJ/SyD4uYypsVVTKPOytJoal9+pwsHvWib8OV7UumcaWbFCO2QPQLfA
 GeUIOwHwdp0L+faJr5ykDWo8/6ncTWYzsPMI4k+Jnd7AQjcnvWbYJm7GBZ7w4Sf4xax6
 Zlv/nvsjSRdjQzA9TSBfF+r+AlEdwaYGVGtH4EJ28XsD22pEcnN9W92sojniqLgIoxAw
 hqzZoUY8EoRTFarvaVp5q+Qs1KyAHBzutwpX6QYoVLM4HwYTAAuARr8+WDTTYyyG46vA
 lB02u7GKgHvPbir4UgdQpIroPifUgNxd7oerUtFcg9LEZmkjhQ9d5qea0W6WLN5V/tTV
 OvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=c8qSs6TDILxbShimwRABHakOnMzCbggbxC7nToVMXs8=;
 b=oBI6K2BRSoSopEiGYVfaRYNXA/hGphA/4EhPoVem80IZXBvNFMmbthGS8+qUhnx6eg
 3kAN9b6QyB9IreUwM0K+I3WKWnE6XomCOHJdtSVUf7g+nhr2RBgz6Oowul7miUyGStch
 5CWag8wwd6E7YFWgsQQ68aMcqmnVYWW2UKRh0TX7Bf2nFXHwEgD0fj9dPR0zk3SWLW/t
 Blp/aqefYqMknLkvaZOj9hxBrMfnPBowDVEDR0Zc7V2roBgZj+01Dr67q6bLiTmN6ir+
 KicHjJLZ7nfH1I1fS6kjRgkOWLvJeZJU43ph/uqJEKbF+qhPIfr3lgv5mhOGu1gs38+j
 chgA==
X-Gm-Message-State: AOAM53135ZMKbHVRKaJ8OioDc+tbqrmPVifo0Ksbd9ZK8ik/fAPZleot
 FElXNC+aVA964L6cUVtpGsA=
X-Google-Smtp-Source: ABdhPJyBS/1K8gTnO9+IjFhYE9f8I13AclYQXINEUix2QnuyylzvzPTH4k2aJ/UH0zhfsaP+J7/0kw==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr2840300wmp.22.1629972780333; 
 Thu, 26 Aug 2021 03:13:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f034:47d2:6ee4:c70f?
 ([2a02:908:1252:fb60:f034:47d2:6ee4:c70f])
 by smtp.gmail.com with ESMTPSA id l1sm798911wrb.15.2021.08.26.03.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 03:12:59 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: correct comments in memory type managers
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20210826095937.1150894-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2b4091f2-7b63-70be-11f8-0a0eb5981ea4@gmail.com>
Date: Thu, 26 Aug 2021 12:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826095937.1150894-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 26.08.21 um 11:59 schrieb Yifan Zhang:
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

At least a one line commit message would be nice. Something like "The 
parameter was renamed."

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index ec96e0b26b11..c18f16b3be9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -118,7 +118,7 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
>    * @man: TTM memory type manager
>    * @tbo: TTM BO we need this range for
>    * @place: placement flags and restrictions
> - * @mem: the resulting mem object
> + * @res: the resulting mem object
>    *
>    * Dummy, allocate the node but no space for it yet.
>    */
> @@ -184,7 +184,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
>    * amdgpu_gtt_mgr_del - free ranges
>    *
>    * @man: TTM memory type manager
> - * @mem: TTM memory object
> + * @res: TTM memory object
>    *
>    * Free the allocated GTT again.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2fd77c36a1ff..7b2b0980ec41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -361,7 +361,7 @@ static void amdgpu_vram_mgr_virt_start(struct ttm_resource *mem,
>    * @man: TTM memory type manager
>    * @tbo: TTM BO we need this range for
>    * @place: placement flags and restrictions
> - * @mem: the resulting mem object
> + * @res: the resulting mem object
>    *
>    * Allocate VRAM for the given BO.
>    */
> @@ -487,7 +487,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>    * amdgpu_vram_mgr_del - free ranges
>    *
>    * @man: TTM memory type manager
> - * @mem: TTM memory object
> + * @res: TTM memory object
>    *
>    * Free the allocated VRAM again.
>    */
> @@ -522,7 +522,7 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>    * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
>    *
>    * @adev: amdgpu device pointer
> - * @mem: TTM memory object
> + * @res: TTM memory object
>    * @offset: byte offset from the base of VRAM BO
>    * @length: number of bytes to export in sg_table
>    * @dev: the other device

