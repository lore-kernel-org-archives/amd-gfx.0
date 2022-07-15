Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0F0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416EF11BAF7;
	Fri, 15 Jul 2022 08:41:25 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E1311BAF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:41:24 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id b11so7738810eju.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XNDEexTBkeVTgQd7TEtrge1vYkkTZF0GQnZ4Nzn4r2o=;
 b=ovHkPQZ/IKouk4SfwQkfashnDkIcM6QRvkgK0mhJ92Ja4skA3h51q1UGJJmJ3znf6K
 uufTLEvsHmg6fzGvfRn2aSTfE/uk4NFB2HtD03dCM+aCA6s3weZ6oAq6bpSTHtyOPPf0
 0Rmz6EWj2kQVn7RQ8nEboixNXIFLrD0xSyOmhGS1bMXfKPW0NjWmAAt8Cg1s8PyhEq8Q
 RajZcHjqBjCsbG1sUjO7gFWAFviDLEbO6AvscVzxuWkhsg5xV0NP4CAm9hlhDDTitM6I
 4sU5nYWSFhgXuPc5FxXIItdMqYOP3lC6qewQArYOZVGVTSbtBFyyvEQFdYV+0XxEnue3
 mVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XNDEexTBkeVTgQd7TEtrge1vYkkTZF0GQnZ4Nzn4r2o=;
 b=NoqUqJ2A7XZDnBAMeJRfsGiZM95WFpq37TEpUK7KuP04nU0WWdnFdqfLI5bCPcVJb1
 t9ij/ygopdn+LLwD1tZcmLSqhQlnw5tIafL0DzY6Bd6Vq7LL9HxK2pUUM/+rCh+NGR/w
 wcXK4CRKN3NkmFtFdtvZn+knk+t6ifL6jU8wMbb9i2HiYnPx4yb8E7XLLY00u79bt3Gh
 iAikjkxI8rSXw2orfQ0WAhzY/A4+eq04RzBVDg3qRkdZKbe+8AAGefXYJ2+P9LcGeXvU
 /fHnHsmpAOjNcLHwEBZiVMNm8QxDU7+pjXy7yBnX5aQeWijVJd3uIDGrl/9bAd99c3b4
 2U6A==
X-Gm-Message-State: AJIora+w35aXsnax0PekSq/dR3PlGkEFDePl4IxfTABXJ1MdQXS/+Mhd
 /OyAOOZZvcOFs/OleDRQdWo=
X-Google-Smtp-Source: AGRyM1seYZwhvBSxBNP8iRPR1AudQ154c4Nug0gpkWezOBcRfJmz9zaA4zZ94lK0KdRYQistTjwsPQ==
X-Received: by 2002:a17:906:5343:b0:722:ea54:fe67 with SMTP id
 j3-20020a170906534300b00722ea54fe67mr12718523ejo.181.1657874483304; 
 Fri, 15 Jul 2022 01:41:23 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8bc3:ed7a:c741:f27c?
 ([2a02:908:1256:79a0:8bc3:ed7a:c741:f27c])
 by smtp.gmail.com with ESMTPSA id
 eg52-20020a05640228b400b0043a6fde6e7bsm2363029edb.19.2022.07.15.01.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jul 2022 01:41:22 -0700 (PDT)
Message-ID: <e1c41136-18a6-7747-ce18-b6fb6e1797c2@gmail.com>
Date: Fri, 15 Jul 2022 10:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: align between libdrm and drm api
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220714212233.14571-1-ruijing.dong@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220714212233.14571-1-ruijing.dong@amd.com>
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.07.22 um 23:22 schrieb Ruijing Dong:
> define HW_IP_VCN_UNIFIED the same as HW_IP_VCN_ENC

Usually that should be the other way around, libdrm aligns to the kernel.

Why was that modification committed to libdrm first? There are usually 
plenty of warnings before we can do that.

Regards,
Christian.

>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 18d3246d636e..fe33db8441bc 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
>   #define AMDGPU_HW_IP_UVD_ENC      5
>   #define AMDGPU_HW_IP_VCN_DEC      6
>   #define AMDGPU_HW_IP_VCN_ENC      7
> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
>   #define AMDGPU_HW_IP_VCN_JPEG     8
>   #define AMDGPU_HW_IP_NUM          9
>   

