Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE985C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 16:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5083A10E461;
	Mon, 16 Jan 2023 16:33:37 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57BF10E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 16:33:35 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id mp20so22748806ejc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RRoP+2ICIwwa5FET1EGmHDcck5l4hLgt1zXzwKlK5Jk=;
 b=cqWaZsX5As68H81C/Q5uHRUb7CkoPZAMm16j3ysrYi6xqdaPRVJgRU6YP4PyJUc7Ji
 5a4Ot4xAh8bY4JM5jtZoeEbpakzr0lFZT+YiJmU73ieDpnTczcG5zUSvSdGOpAIs+H2v
 uTgjFcIF+h07VyaGtFPKS8IJ98lr3JG79nA7zwJlhLJcjXv8MGiRnIN7+IIz2aTZDlFY
 EIOalQ7ic5x9O+ClFZ16Hi1BEIo9c81+ssuFuGXOdVltFwNTSsW94QbU/Mjhz4SN+abU
 tP7vXlGt/F6uSgEPNv31WcnNnBU3HyYqD4DDlOvr93dG6cGWy3bu63HJQRxr/pJsr/zB
 s2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RRoP+2ICIwwa5FET1EGmHDcck5l4hLgt1zXzwKlK5Jk=;
 b=QEkUKK3Jc9E72C3rkGWdYn8BcMLbA8lbZ0blS+24JbYXFhhyFvvGoKDUn9MAGFjXHX
 ZB2/qTkRpoZw9bHFnR+tRgRvvmEVZ68LB3dITQLExqFXDG6yq14oYq5xdsvyCvLgxZTL
 qshUdo7iLcz8JFQX+1f34rThjb5rdl9xd1eBk1PCfr9jUCWHk9R8esCarbONOC3hXPQF
 UeyWibsYBGbnLR6pTcTuwrCfikWGzenfS2/nyWi38iY9Bdc8S9SVsJP9deBiTNcZYgH2
 AabkcQ3uhPaY8ip7tpAHJQJ5JfVZvv2/EISmdbwVClPaU+93+RB30fG1GhGCT+g8sqVY
 E1pA==
X-Gm-Message-State: AFqh2kpYe8wmf6mHr6kXCFowO/WGdA2HAJu0x5itoWYHuunewMpPpx+E
 6uvyOIIChtPnUlBbdx6XhgA=
X-Google-Smtp-Source: AMrXdXvQubhHnrQVllMfbvKQsmnBV7SNlPbHJtV6psM4lTHoM6ZiVCO1Y5rh3C2SEua29Qk+hUyMuA==
X-Received: by 2002:a17:907:9714:b0:86f:57d3:e3a7 with SMTP id
 jg20-20020a170907971400b0086f57d3e3a7mr7528022ejc.48.1673886814207; 
 Mon, 16 Jan 2023 08:33:34 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:34e5:390c:7f47:8796?
 ([2a02:908:1256:79a0:34e5:390c:7f47:8796])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a1709063ec900b007c0d6b34d54sm11948224ejj.129.2023.01.16.08.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jan 2023 08:33:33 -0800 (PST)
Message-ID: <df5be9fe-1488-7570-fb3f-db6c102fcae9@gmail.com>
Date: Mon, 16 Jan 2023 17:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Use the sched from entity for amdgpu_cs trace
Content-Language: en-US
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230116161629.6450-1-leo.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230116161629.6450-1-leo.liu@amd.com>
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

Am 16.01.23 um 17:16 schrieb Leo Liu:
> The problem is that base sched hasn't been assigned yet at this moment, causing something like "ring=0"
> all the time from trace.
>           mpv:cs0-3473    [002] .....   129.047431: amdgpu_cs: bo_list=ffff92ffb3070400, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [002] .....   129.089125: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [002] .....   129.130987: amdgpu_cs: bo_list=ffff92ff84831c00, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [002] .....   129.172478: amdgpu_cs: bo_list=ffff92ffa4b84c00, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.214000: amdgpu_cs: bo_list=ffff92ffb405b400, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.255763: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.297316: amdgpu_cs: bo_list=ffff92ffa4b84c00, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.338978: amdgpu_cs: bo_list=ffff92ff84831c00, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.380685: amdgpu_cs: bo_list=ffff92ffba4b7000, ring=0, dw=48, fences=0
>           mpv:cs0-3473    [003] .....   129.421993: amdgpu_cs: bo_list=ffff92ffdb4c3400, ring=0, dw=48, fences=0
>
> Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
> Signed-off-by: Leo Liu <leo.liu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5e6ddc7e101c..6cd6ea765d37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -153,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
>   
>   	    TP_fast_assign(
>   			   __entry->bo_list = p->bo_list;
> -			   __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
> +			   __entry->ring = to_amdgpu_ring(job->base.entity->rq->sched)->idx;
>   			   __entry->dw = ib->length_dw;
>   			   __entry->fences = amdgpu_fence_count_emitted(
> -				to_amdgpu_ring(job->base.sched));
> +				to_amdgpu_ring(job->base.entity->rq->sched));
>   			   ),
>   	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
>   		      __entry->bo_list, __entry->ring, __entry->dw,

