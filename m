Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F6CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE25910E3D4;
	Thu, 29 Jun 2023 14:30:10 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F19910E3D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:30:08 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51d9865b8a2so834785a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688049006; x=1690641006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XbUhQdrc3odcegMaOTrCR2kPyNj+mQwdk7TP6yZdLz0=;
 b=m3BgPFh8Su9GlyZGWuJDYfYh2LkcUWGtr+YOyCTKIm5DPTtS8j5xdTcqrx+UQNIdd4
 cStoznNx9S2HzvNL7Hywgv8Yu1uWAXt9iU+qpIB/K6nEF0bshd7MvL8EnO3q+TNMsErf
 fzuBK1597VznnSzhS84r7IIkJwasXCNUCvK2QQ3qzrm5MvGdchr4o4pg+AhvWE+RYM/9
 29Z1e/lYA1TDfPMRHn4Lqa11wazrD8uRL7iUNdELCahVyb7N1zpCrlvi7Xo0Sn/WWrFb
 4FGex3+R7XDeUIPkbbX0uqmqWLWFVw4yFwF7RvJ+eMJCkJUzacHA8P+pUE/43zWP+9ho
 Dm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688049006; x=1690641006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbUhQdrc3odcegMaOTrCR2kPyNj+mQwdk7TP6yZdLz0=;
 b=Pj0yLZHSidJWzrVhds0loK/bxIK6amptFO1qLP/cEVh+EkgiLDdtlHN6kjW/937Ity
 Qg2h2nbseiE9nVOoRV6KcpyGaac+xK2a9vTid3XkLf+DDZh+fakScShvfDnrAKSpvllf
 E7X4ZgoyKNW6IVrxxotXGQSh8xR0Iqq/DAFMBpcrpwa0v8ukMJ7PF0hviQBUL7ruTgZ8
 /xM1dCWh+TUJJKFasUooTzjfwUgnbS9h050M9CL93E6vmRIjD/11RHKy2RbUZNTIw2q0
 CtTfnkTZI6kxj5tuvf9CjJu2uZHZ36nsocSemOtcFkA7ll7cTLMbRCLky/ZZozamWWrc
 w8rA==
X-Gm-Message-State: AC+VfDxv4bOz1JhQhjvi6KkquILfuPwxNUeRpWWbGF2Klhbar5qNKXMv
 uNArsNO4JmJjIreDf6a4k8pl8klVbVFbOA==
X-Google-Smtp-Source: ACHHUZ7ZAGwwIeiis/0/fk7rNloFit2rEEBP2zydprmRWYa+SyDlsTEAoKubHnz0JlAdDaQipMSZqA==
X-Received: by 2002:a17:907:25cc:b0:989:450:e57b with SMTP id
 ae12-20020a17090725cc00b009890450e57bmr23232762ejc.7.1688049006199; 
 Thu, 29 Jun 2023 07:30:06 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15af:8a00:54e3:8652:e343:aef4?
 ([2a00:e180:15af:8a00:54e3:8652:e343:aef4])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090617c400b0099297c99314sm1406534eje.113.2023.06.29.07.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 07:30:05 -0700 (PDT)
Message-ID: <0b386d4f-c280-9a51-6d88-bcbeec8e4173@gmail.com>
Date: Thu, 29 Jun 2023 16:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: return an error of query_video_caps is not set
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230629132228.2126129-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230629132228.2126129-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 29.06.23 um 15:22 schrieb Alex Deucher:
> Should only be an issue for bring up when the function
> pointer is not set, but check it anyway to be safe.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cca5a495611f3..85a0d5f419c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1102,6 +1102,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		struct drm_amdgpu_info_video_caps *caps;
>   		int r;
>   
> +		if (!adev->asic_funcs->query_video_codecs)
> +			return -EINVAL;
> +
>   		switch (info->video_cap.type) {
>   		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
>   			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);

