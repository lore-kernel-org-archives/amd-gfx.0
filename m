Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2DDC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F24E94C14;
	Tue, 12 Jul 2022 15:06:06 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2FF94E67
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:06:05 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y8so10493624eda.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=xdSliU+JWusQCrAJspz4QDjJVHmmNWtIeR12ApOeC0E=;
 b=e0pKbEJtsDQwzFx3u7zBVPyVi95TjL4EyMbvGfLG/xPDT5JWWLElHRxrSxADPTFRT/
 e3MwQobdch3RBWIHq9YsFHDTflhOjLC3ogeWItUSIqx4nS5XMypLWPoH2o11A8jzUoqw
 eNJDKeZDfIygqh3WXmL96nn2BQ9rTuVUOO/+QbC6UbJcnzb3rkj3No204qSnpT1D1FYJ
 KuKN0nLozboV9kvHOALZiS5uHUb+ca/aBj9Yp6T/usWSc3OnZFdrF8xoAbED0FUQ8Gk/
 abbM3zK0ahRYasLh6jdmjA4V9QDb1oHxc6QL6sTC5acKT91XUXJ+AoJQQMfkNn6V8lut
 8qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xdSliU+JWusQCrAJspz4QDjJVHmmNWtIeR12ApOeC0E=;
 b=HJUKVXy+79hfZnqX4twGVbgEqu5Gun1U8jNOObxW3dHzN0zQWjZMcxZQ9feWbcoYTE
 fWy4Ad4LuHyFPFcrSqemNVtqdJx0WKEQd/U/TaBwkMp94u9XfQPQngcC6d6wjyGqM22N
 fdnUGi/zTDCAZ6e0d4FNVrwrux3vm6vHHnwZtpIm/DOvWaYjUv+pGZogT5aEqjovIAYa
 bv6DFm0ypB5ky/w8JCTn4MMr7E9eBrkURxm5BP0+u7BrxQrhpkL8t8+hzUGGOrONnAW5
 /QgJH638lt2PUTfS8BW7/YmBJNK/gYq3WJip60u8/3RqeXbleQkljHRnbaUn5SaXKRO5
 jylQ==
X-Gm-Message-State: AJIora8cUWM7H83ncMUCqoGgHaKdF1zal05ivY/jDS/xfXqZT14ByHMw
 +0EMHi5N7QZmLsNb8fHcbd9cAI0GKmA=
X-Google-Smtp-Source: AGRyM1uHv8NtLAedXQE6ht1mj1zVIqyMfD141IJM63wkCpfHphwqX5Db+2ZKT6Y2k2LNHjpNzrrXBA==
X-Received: by 2002:a05:6402:34c3:b0:43a:c323:274f with SMTP id
 w3-20020a05640234c300b0043ac323274fmr24086215edc.67.1657638363974; 
 Tue, 12 Jul 2022 08:06:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:cf35:dc88:25dd:1187?
 ([2a02:908:1256:79a0:cf35:dc88:25dd:1187])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a170906a29400b0072a881b21d8sm3885440ejz.119.2022.07.12.08.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 08:06:03 -0700 (PDT)
Message-ID: <212ed8c2-f59e-8f57-8535-b599233c1953@gmail.com>
Date: Tue, 12 Jul 2022 17:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: fix file permissions on some files
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712132455.2197338-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712132455.2197338-1-alexander.deucher@amd.com>
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

Am 12.07.22 um 15:24 schrieb Alex Deucher:
> Drop execute.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2085
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h   | 0
>   drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h  | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h    | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h   | 0
>   drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h  | 0
>   drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h | 0
>   6 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_offset.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_1_sh_mask.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_offset.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_3_sh_mask.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_offset.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_2_0_3_sh_mask.h
> old mode 100755
> new mode 100644

