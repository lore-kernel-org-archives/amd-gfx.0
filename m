Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D72C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 17:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BF28F258;
	Fri, 12 Aug 2022 17:37:11 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636488F258;
 Fri, 12 Aug 2022 17:37:02 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id s18so561768uac.10;
 Fri, 12 Aug 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:reply-to:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=dizPcrD7xaXzAQLAnOvA/lJAJfB2ho1YY43Lw3GIZ2w=;
 b=Lq3WwTdrt3jfthJq/u97yFXe4RHqde540SLRAxlnszttUC7h5f60tyX14x0KSDc5LX
 4r0zkBPbxqJXcnnsJ4ZCBXJvdBw9RVCuhLMIdoAY7UqsTDGaqJdqWVXVgSn7RzkaLGAp
 jObndePyxg+TK2DFK/BdCyLVIaFg/UuyX2a+WKIuaMi3ZQJ0aF00PCaQMTSc6n32iPTc
 AxpmSQeswsUV1kS3nnQt+sp1rLUHCLv9b5AJQSsrudXvlk13uhOz2VVfAQO/x5OiM8x4
 7mD/gT7dsrRvKAjl+zD0iZdCCXAHLWRxIKe+92BWgZe+69WQWAKkllth9/Y9qRuIX+iy
 Kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:reply-to:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=dizPcrD7xaXzAQLAnOvA/lJAJfB2ho1YY43Lw3GIZ2w=;
 b=LkE9iRHupJvez34s/wPLeIx3JrEHPbKORhhjchFONfP94LeMkP2Fi+KucwVafN20hV
 wJeoxcaRzb7dnYb8v4R2vs+q+FDgUNLgCoBFoulyW7gfucHmmOXIwN0cNxV1GGASjU21
 DL+2E7gjy0sh4ExWMFGBh3jA9DOy5CUxGStOb6cX3HNGgtZxQkvCrVGJp0+C4lyFIB+A
 cIBlJJJGzVvgjPh9Vv5foglawZ8VkG7fqLDDv8FfAUvnTCxLT0x3iczDDVLqeHx2/WLh
 pYitXq1ba/MIqilJhI8UyGoY9uujtTJedPSJCfWUW0URj54mvT5Rq2/zVcYTafLm37Vd
 1osg==
X-Gm-Message-State: ACgBeo0wYMFlB4KPz8nMAxQyt5VhXiogDU3h840hkaRg4AqOpyV1FCMk
 zE7XIL9tXH1Jl0cgdChcUdY=
X-Google-Smtp-Source: AA6agR7Tv5COQ1lJT43XUNgNFNdFg+u4AY4yoTnhGQw7c+iaZmZPk2lYqyVssMVzUx77zM9XWUwdUg==
X-Received: by 2002:ab0:6602:0:b0:38d:539:d611 with SMTP id
 r2-20020ab06602000000b0038d0539d611mr2406701uam.103.1660325821392; 
 Fri, 12 Aug 2022 10:37:01 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1003? ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 g19-20020ab05993000000b00383fbaaa7d2sm121055uad.22.2022.08.12.10.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Aug 2022 10:37:01 -0700 (PDT)
Message-ID: <e95a5040-6cd2-3b74-1b65-50bc7c6b6ddb@gmail.com>
Date: Fri, 12 Aug 2022 14:36:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amd/display: remove unreachable code
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
References: <20220812031911.62729-1-jiapeng.chong@linux.alibaba.com>
From: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <20220812031911.62729-1-jiapeng.chong@linux.alibaba.com>
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
Reply-To: 20220812031911.62729-1-jiapeng.chong@linux.alibaba.com
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 12/08/2022 00:19, Jiapeng Chong wrote:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1658 dml32_TruncToValidBPP() warn: ignoring unreachable code.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1894
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 05fc14a47fba..0758e1da55a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -1654,10 +1654,6 @@ double dml32_TruncToValidBPP(
>   		else
>   			return DesiredBPP;
>   	}
> -
> -	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
> -
> -	return BPP_INVALID;
>   } // TruncToValidBPP
>   
>   double dml32_RequiredDTBCLK(

Seems correct.

Reviewed-by: Tales Aparecida <tales.aparecida@gmail.com>

I feel like RequiredSlots is not actually used anywhere in the code, 
just passed around dml32_TruncToValidBPP() and 
dml32_CalculateOutputLink(). I've looked for any mentions of it in the 
mailing list, but could not find anything that implied it's part of 
ground working. I wonder if it's something outside the Linux tree for 
other platforms or related to HW gospel.
