Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAD6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 06:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D2E10FC27;
	Thu, 14 Apr 2022 06:24:55 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A548C10FBA4;
 Thu, 14 Apr 2022 06:24:53 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id t25so5048806edt.9;
 Wed, 13 Apr 2022 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=p/NPkCOAH3unLhMBFHm3OP1bFIXJxVGLed+i2DDTQWg=;
 b=WBRomlPFpRbRhLOL59ejAbCco1Br1tL2HXxi4eRl0RVEEl7v8+ZEeqxl6fyN3IMoit
 mnezTmrpFjdjvkXmuya56tfVdzpvD9SgDv5RDQxH9/Z9qqdqJBCcPkwwVCkSEKeLRK5F
 9ntCyOPTmtotn6gJiZMOHjRMso5x4C8DNEsCQW4yjVhLB4mDhztLe281ZWAYWlhzPyMD
 PntJ+lWRevWHxmZSluhQjWddgvHLj9j2JY1/jY2JZVOg6azStTajKACa/XEWt8a51L3B
 exkUPmsRV75ESk6oQLQvdOuA9qppLantRFzODhxTgtoZwK9t5eARDB0/sOXf0aLqUz8f
 5ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=p/NPkCOAH3unLhMBFHm3OP1bFIXJxVGLed+i2DDTQWg=;
 b=N9z+YQzH8iu1CJDFm3QnXM9vL2AcXQLCGnonFteVkPIxLENbpV1qiO5PYDMwBgm4mE
 eVF1FtI+6l58HGk0ve1E6aRAN9TdQeFQCZmnJ433Y8XzCbiNod0ocstZ2oxxDV9VLcLl
 bH7TS/UdRaMU/BgDbt7lwvUNb/kk+wz7VAP6oeNGMY9k6ILVE+1DZlkfvs/JNgMPXD5Y
 Im0IJMNKW/wsGZrEvBKja8hg/RDdY6K9TChiPDqfEj4K25K/SdyKnguOMAMAdWTv/hE8
 Ui7n+p/HvueT2uprM1YxxcXsV7xwlP18CxSH0Q5IYNAmIGWch7tX/sN2HfKLZqGbhtaf
 jzkQ==
X-Gm-Message-State: AOAM532kXcwd69+SuWsVbr/4l1Ip7uSmekSSsijuIjk2a15pgEOg12GU
 LZM7LUEsjR+fGPcJ0cFfDsmgc6lb72Q=
X-Google-Smtp-Source: ABdhPJwIxe6ZKHjY6JKmGU/fZIyqgw27A8iONcX8lypRsTnqm4UXensR7LsQ5yx7+CMUjQTRNhWZew==
X-Received: by 2002:a05:6402:26cf:b0:41e:41b7:3e7e with SMTP id
 x15-20020a05640226cf00b0041e41b73e7emr1363626edd.0.1649917492174; 
 Wed, 13 Apr 2022 23:24:52 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:3d68:590f:61e0:5f10?
 ([2a02:908:1252:fb60:3d68:590f:61e0:5f10])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a50be8b000000b0041cdd4a7bf6sm566536edk.58.2022.04.13.23.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 23:24:51 -0700 (PDT)
Message-ID: <f425b789-5081-fa70-555f-7553d7cc5bd5@gmail.com>
Date: Thu, 14 Apr 2022 08:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/radeon: Add build directory to include path
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
References: <20220413161450.1854370-1-michel@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220413161450.1854370-1-michel@daenzer.net>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.22 um 18:14 schrieb Michel Dänzer:
> From: Michel Dänzer <mdaenzer@redhat.com>
>
> Fixes compile errors with out-of-tree builds, e.g.
>
> ../drivers/gpu/drm/radeon/r420.c:38:10: fatal error: r420_reg_safe.h: No such file or directory
>     38 | #include "r420_reg_safe.h"
>        |          ^~~~~~~~~~~~~~~~~


Well stuff like that usually points to a broken build environment.

Christian.

>
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> ---
>   drivers/gpu/drm/radeon/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> index 11c97edde54d..37caf5236048 100644
> --- a/drivers/gpu/drm/radeon/Makefile
> +++ b/drivers/gpu/drm/radeon/Makefile
> @@ -3,6 +3,8 @@
>   # Makefile for the drm device driver.  This driver provides support for the
>   # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>   
> +ccflags-y += -I$(src)
> +
>   hostprogs := mkregtable
>   targets := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
>   

