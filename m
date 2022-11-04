Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADC1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8356610E70B;
	Fri,  4 Nov 2022 09:27:16 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE0A10E70B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:27:14 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id q9so11855323ejd.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1BvCnSSQ3sNoorF9XujTo+l6cWq3mlNBqeSae10bbpY=;
 b=f0671J2vMj4CscZa8WRJCxrflk7JO5C9fLLyhqGpszdOHHNjOATGYF/pvOAuIMG9st
 bMPXbFlmqj9Jm+s0v5Cy8TumFHq23rSKzOC5AV/07P1hRl1U4Ze55ryI1MrG3XV4qsb+
 F9bT6AsUxDdhL0whDU3IAxcqas4RHtvJIl04Q3v3ynOpjW4wT+SQUuNQYyG20t9c8UAx
 eV+JA5AbQK6qUyQqGMdWAtbFn1FZF8SnP7mVA8S6lgF0nwz5vQAmI1q3bqgS9tS/kNie
 8uVg9dBqi4EOjiX/Ti39Jc0WV1JzRW1YZOxGS+nWlTu7VWCrg/KOLb+hcMdgfKe3BDlY
 zb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1BvCnSSQ3sNoorF9XujTo+l6cWq3mlNBqeSae10bbpY=;
 b=xY32gpYvKWpgYtVsIO6PGjMA4d+nMhGhLzEJf3g5oQ4duEQ2wYasjzyUYOx5Z9s3dA
 ulvBS4IBapY2OyEDPD4W4CqOW238DXyriy0fJfWU/3XgZTE+8zIFqqB3DC67TvrdNdMe
 jUPX7dPXQIqbHKFTzjC0PmX5K8fnNA05TfLyccM479u/qJGaqev9OdZ2MulJmqR0tT/y
 1v7/ePOmW+5fCQHnFgKVfsmjpVUIFrA9AKy9IW70lb1IRhSyJyjRcrlKWpTOlyw2PbTr
 zs95MJIlizKcyCsAxW1XtOupkuGbMG06UyhLfTtJjJPFI/UUgtopbYvlQI8XMYgL1zlF
 aSKw==
X-Gm-Message-State: ACrzQf3CEg2WgmNihazmkp3oYOkD4lAVyZmBQ1xkNNkDdc7G5yoAoViJ
 9Z+q71dCaZbcThF0shm3G40=
X-Google-Smtp-Source: AMsMyM7LRkqceXeDCTI4gGI7puNHsZh0gCewGmzpqlTWO6tHCrYt+16HvhRfOwvlMsRn9OO6fGpiZw==
X-Received: by 2002:a17:907:1ca7:b0:7ad:9227:5288 with SMTP id
 nb39-20020a1709071ca700b007ad92275288mr32494898ejc.62.1667554033042; 
 Fri, 04 Nov 2022 02:27:13 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8469:5663:826a:8164?
 ([2a02:908:1256:79a0:8469:5663:826a:8164])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170906714500b0073dd8e5a39fsm1548256ejj.156.2022.11.04.02.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Nov 2022 02:27:12 -0700 (PDT)
Message-ID: <808bdc16-eea4-40f9-e347-c4440accca29@gmail.com>
Date: Fri, 4 Nov 2022 10:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] drm/amdgpu: Unlock bo_list_mutex after error handling
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221103145905.20222-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221103145905.20222-1-Philip.Yang@amd.com>
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

Am 03.11.22 um 15:59 schrieb Philip Yang:
> Get below kernel WARNING backtrace when pressing ctrl-C to kill kfdtest
> application.
>
> If amdgpu_cs_parser_bos returns error after taking bo_list_mutex, as
> caller amdgpu_cs_ioctl will not unlock bo_list_mutex, this generates the
> kernel WARNING.
>
> Add unlock bo_list_mutex after amdgpu_cs_parser_bos error handling to
> cleanup bo_list userptr bo.
>
>   WARNING: kfdtest/2930 still has locks held!
>   1 lock held by kfdtest/2930:
>    (&list->bo_list_mutex){+.+.}-{3:3}, at: amdgpu_cs_ioctl+0xce5/0x1f10 [amdgpu]
>    stack backtrace:
>     dump_stack_lvl+0x44/0x57
>     get_signal+0x79f/0xd00
>     arch_do_signal_or_restart+0x36/0x7b0
>     exit_to_user_mode_prepare+0xfd/0x1b0
>     syscall_exit_to_user_mode+0x19/0x40
>     do_syscall_64+0x40/0x80
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Good catch, patch is Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1bbd39b3b0fc..d371000a5727 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -992,6 +992,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		kvfree(e->user_pages);
>   		e->user_pages = NULL;
>   	}
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	return r;
>   }
>   

