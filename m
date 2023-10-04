Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D2E8FDD4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62A910E0D8;
	Wed,  4 Oct 2023 07:15:27 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9DE10E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:15:27 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso298556366b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696403725; x=1697008525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsR5fFWihodXxXkniNceEYcy+5KYrZSchnwP6Pn72vo=;
 b=SPY+hpD2Z3lhgF046zSX/gW4ao2gDZaiPpntJr0TBKPfD48sMvVR2A7W3R3rr2K5iq
 UfG/5SHmrnoNnhu/PhzoKEB0BMzBM/1pwTgjmwFJgjSb0CkJdUxBqIRplnqP0drvA00U
 5w0N5cks9a/YrTRz/+BMZKs4Zq6NjzcB/r1wWTJ8/V+jqWTdcTr7dTu9oqu3ZCWLqQnV
 p8d2SxENtdcvd+CylnnC9vM46Uo50D8zCxuBCPYXMiZYv9fzu85gZCs0IMBxQO+GpGPK
 y095V0GDzatHBo80nVXMz0fHTQVtEiQuAf0R2BD/BSrhQI2wpsTt0LivyLR+B3yO66IK
 +3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696403725; x=1697008525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dsR5fFWihodXxXkniNceEYcy+5KYrZSchnwP6Pn72vo=;
 b=jx6HhzAZhzOLEnvAOKI4CRuamLpzOahNE2y7vUyJNE8LqL5XR+kDQQQLe1zQ13aiTO
 KOprQTk8GUonfD0RHoQ9+Pi0ALneOwBcYLOjEKAc0gjbhMcjktZp+CKVJ1QnTAaCazUV
 BXXXUoFOys7pk1Ypr81YjkRb4vED1gbCOyOhAeshX6wvbYgDDnX7huTH4tzHKuTwD9rx
 SLU0oYfpRcSemOepk/E0pS3AzYhOBLl5Yfq1LE/bwdfCwRhwufVS1JhqOPlLWrfDL5Ke
 kx0/WfoK7KuTqr4oeZUoAJ7cO4EYrRlOV8YAJnReQiJmU0qD9FcpTvyFfutyn24dahUH
 oM7Q==
X-Gm-Message-State: AOJu0YyOT0GiTRSxTAwceUi8sv9W8R4fHbDvSIq0g1VHggcQ95QqMV0F
 pJDPI2WJ4uDvvGXZ8TmhM3M=
X-Google-Smtp-Source: AGHT+IFOe9JIisSajveh7HnNPtLpmc7MFiHj41xYYLw4ddnjiXBh3Iu3s9NfCQOgRjGh5jIMHZSUvQ==
X-Received: by 2002:a17:907:77d0:b0:9a5:81cf:57b5 with SMTP id
 kz16-20020a17090777d000b009a581cf57b5mr1044779ejc.2.1696403725262; 
 Wed, 04 Oct 2023 00:15:25 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.15])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a5d6a09000000b003232380ffd5sm3267167wru.106.2023.10.04.00.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 00:15:24 -0700 (PDT)
Message-ID: <7a3613ef-7328-40d6-fe2e-6ec62f553602@gmail.com>
Date: Wed, 4 Oct 2023 09:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Content-Language: en-US
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
 <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BN9PR12MB52574E3E72360B80498400D5FCC4A@BN9PR12MB5257.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BN9PR12MB52574E3E72360B80498400D5FCC4A@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, agree. Just keep it where it is actually used.

Regards,
Christian.

Am 03.10.23 um 18:56 schrieb Zhang, Hawking:
> [AMD Official Use Only - General]
>
> Alternatively, might just keep the PKG_TYPE definition in amdgpu_smuio.h
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, October 4, 2023 00:51
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
>
> [AMD Official Use Only - General]
>
> Ping on this series.
>
> Since there is no alternate header to put device property other than amdgpu.h, this can be moved also when appropriate split of header files are decided. Other than that any comments on this?
>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Friday, September 29, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
>
> Move definition of package type to amdgpu header and add new package types for CEM and OAM.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 73e825d20259..ac048a77e97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -302,6 +302,13 @@ struct amdgpu_hive_info;  struct amdgpu_reset_context;  struct amdgpu_reset_control;
>
> +enum amdgpu_pkg_type {
> +       AMDGPU_PKG_TYPE_APU = 2,
> +       AMDGPU_PKG_TYPE_CEM = 3,
> +       AMDGPU_PKG_TYPE_OAM = 4,
> +       AMDGPU_PKG_TYPE_UNKNOWN,
> +};
> +
>   enum amdgpu_cp_irq {
>          AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
>          AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 42ac6d1bf9ca..7088c5015675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
>
>   #define NUM_XCC(x) hweight16(x)
>
> -enum amdgpu_pkg_type {
> -       AMDGPU_PKG_TYPE_APU = 2,
> -       AMDGPU_PKG_TYPE_UNKNOWN,
> -};
> -
>   enum amdgpu_gfx_ras_mem_id_type {
>          AMDGPU_GFX_CP_MEM = 0,
>          AMDGPU_GFX_GCEA_MEM,
> --
> 2.25.1
>
>

