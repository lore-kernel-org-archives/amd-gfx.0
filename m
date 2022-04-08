Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFA2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 10:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AB710F0DF;
	Fri,  8 Apr 2022 10:09:26 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8924E10F0DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 10:09:25 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id l7so10896539ejn.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=KEFJFj6H3H/bHJOHM4fwF8CsS6ANb2QTlapGiPIeq1M=;
 b=PiiMVaLj2SNTlmCBqaJ8w4zuJCFwR0e35RqkA28L8cVaB8v8I7n7L/6qHdNQgi7tCp
 F1KmM1rilgx07hakMRjUz2AbxG0oXKvUWpOeJKpLNp0oUSS0HWI5D1pLhNMdeEI4gjFp
 YTkSN/cfXXMKJaHHNvuqfy4x1SOcOF7+FV2APfnuyc23N8Uy6MOqO+MUPSo70pdZMYDJ
 l+NqiqxYLPX22wOw/9RAArOgxXZIoRHo5m+Yf+oQhms5WY7WUYmmvvKXEeYW5CFPJ+Ot
 3zV6Sa0YtpUn0JfoSFMUU+ykHPiL7u7Brr0jmaA87SVDCTKpn783hopikIhFc5Ii1DsM
 HRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=KEFJFj6H3H/bHJOHM4fwF8CsS6ANb2QTlapGiPIeq1M=;
 b=basOzTViqMGtoFl7dCivdAyiNbYHT8KS9D5/1bpLkPA92fNbKSYc43aDsb+ZEgp2e1
 Q5TV1huKAoJXxvKdBvRqroztXTutyld5mpP5l/fktwN4VYQ/emwo0323DgY8O/6HVH+g
 lxwQsNA1sgGyqdpPaytiA+uM4s3H7Gg8Xm17tbSdBqPsj/aw6Xsufy22n1fKMgHNYfFH
 mDLaFnMlrrFOLkPDasBPMGzQWDLRNU+C4RtBKIZhETLw23/eSsI70LSYJhJzL3U14ddw
 fVy35KpYcM2kqvssgPxTpXPKLWbHsvufT9T4KF7iQ7rZ2psBAQa/2PkO0H43LFzhPZ4I
 v+Sw==
X-Gm-Message-State: AOAM533Y11LwuVDorOETdWYDblnEZyQ3Wyum9NqArupx6traT0lz5/XT
 68RQBT2dpOvEB+LknBhyRh4=
X-Google-Smtp-Source: ABdhPJwV/mvTiC0jAPgk0Mp7/GTSBjwS1p6JTCKVK1Rpf7gp1w7Wspgo0MSAzdjYzN4q5FMGQ8Ka4w==
X-Received: by 2002:a17:906:d552:b0:6e8:4ee4:748 with SMTP id
 cr18-20020a170906d55200b006e84ee40748mr2366454ejc.58.1649412564114; 
 Fri, 08 Apr 2022 03:09:24 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:114:5e2d:4d2d:2c8b?
 ([2a02:908:1252:fb60:114:5e2d:4d2d:2c8b])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a50e08f000000b004134a121ed2sm10467193edl.82.2022.04.08.03.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Apr 2022 03:09:23 -0700 (PDT)
Message-ID: <6ea0c6e7-cb89-80a6-55ca-8ae5a5fc1a39@gmail.com>
Date: Fri, 8 Apr 2022 12:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: Use flexible array member
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408100710.211593-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220408100710.211593-1-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.04.22 um 12:07 schrieb Lijo Lazar:
> Use flexible array member in ip discovery struct as recommended[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   v2 : Use struct_size (Christian)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   drivers/gpu/drm/amd/include/discovery.h       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 5a182288391b..766006a075ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -430,7 +430,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
>                                   }
>                           }
>   next_ip:
> -			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +			ip_offset += struct_size(ip, base_address, ip->num_base_address);
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
> index a486769b66c6..b25026c3ec96 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -93,7 +93,7 @@ typedef struct ip
>   	uint8_t harvest : 4;      /* Harvest */
>   	uint8_t reserved : 4;     /* Placeholder field */
>   #endif
> -	uint32_t base_address[1]; /* variable number of Addresses */
> +	uint32_t base_address[]; /* variable number of Addresses */
>   } ip;
>   
>   typedef struct die_header

