Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D264C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 17:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B5910E308;
	Mon, 28 Nov 2022 17:11:38 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C291810E302
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Nov 2022 17:11:35 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id ud5so27541418ejc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Nov 2022 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7c3mbLaeL8Ndk29+TATBRvNMT6bYtbvmIUf1WltXaIc=;
 b=AyN6vbmcQXjIEHRtMENRgGjtAQDVr/H+JqKrbWtd9YaPenQ7n2rhR+BPHDBYAG1iPw
 s2hK9q2kOUvgkCS1Hq6j2IYMfiC0gA5IS9hVmt6fuaZ+0I1zL3oB5aCHc11HVsRFOrT9
 DvhVUXUyGEjro+FbawVnlmofKTH3FMAPf6ZEwBQ2qGvXRzrtZ5lD7Nc+hxLW6i5foET+
 KVuVfRyFIbgtOA67xDpFRWjEjqDmtsa7yiH+CJ5AU8MJwRmhwOtYawcCqnmrhxcd3jP8
 7F+bUTlkoP/yuE6OWAcGyjgI1D4Qj0MhS6JlNduURmFur7eq3Jc8dPTu/iYXzny/94qH
 VuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7c3mbLaeL8Ndk29+TATBRvNMT6bYtbvmIUf1WltXaIc=;
 b=NgkyjMKXX5uvoi2Q7nPt0ciXSJ4a0oMRQ1Ia9JQf5tyVsABFbtbynPvkvXzbP+kFV7
 /flaePvZVKIHcvClnkdoJCtSFVs6vTbPeHTrTYbqbzs8PMgVF/V89wAMshemV4L9bl+7
 sXTvxe6mPDDCfKltgsILGh4fwaC1KWdzimLBxWCYmrUH0wDOCHjnFjMoM/a042NFfwvU
 0OB+1FHGKCrlX5fDiIPlrJFSc0LkmNGq99aMETe+Lkte3l6upSdjk7pbXtWsDqeozaQQ
 gyykFNkQ8CsW6qWUZND29y70b2HeCKWM2arkeE7J3HcqrRvi342cwT8MDaJC+bToZT3Y
 IWvQ==
X-Gm-Message-State: ANoB5pnI/JTLVh4B9yWokxo4RmgvJ4pKBqxjuNSi2AJwwTjG0mJv8CXD
 XZddyXLrMIilOPfnEGe//Qc=
X-Google-Smtp-Source: AA0mqf6Yg2APOb51UHacPdSw4Q87dxWctLx/bhvb6YNakiCfrrbAIXUPmE6dmcwZZp/8bXePftYE8w==
X-Received: by 2002:a17:906:43d0:b0:78d:a01b:b474 with SMTP id
 j16-20020a17090643d000b0078da01bb474mr31505064ejn.8.1669655494109; 
 Mon, 28 Nov 2022 09:11:34 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:5a55:839f:fc2d:d0a6?
 ([2a02:908:1256:79a0:5a55:839f:fc2d:d0a6])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906329100b0078d4ee47c82sm3355190ejw.129.2022.11.28.09.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Nov 2022 09:11:33 -0800 (PST)
Message-ID: <1908a95c-82ff-f68d-9463-a5d92db43191@gmail.com>
Date: Mon, 28 Nov 2022 18:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: New method to check block continuous
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221127053926.119084-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221127053926.119084-1-xinhui.pan@amd.com>
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.11.22 um 06:39 schrieb xinhui pan:
> Blocks are not guarnteed to be in ascending order.

Well certainly a NAK. Blocks are required to be in ascending order to be 
contiguous.

Regards,
Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 21 ++++++++------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 27159f1d112e..17175d284869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -59,22 +59,17 @@ amdgpu_vram_mgr_first_block(struct list_head *list)
>   static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
>   {
>   	struct drm_buddy_block *block;
> -	u64 start, size;
> +	u64 start = LONG_MAX, end = 0, size = 0;
>   
> -	block = amdgpu_vram_mgr_first_block(head);
> -	if (!block)
> -		return false;
> +	list_for_each_entry(block, head, link) {
> +		u64 bstart = amdgpu_vram_mgr_block_start(block);
> +		u64 bsize = amdgpu_vram_mgr_block_size(block);
>   
> -	while (head != block->link.next) {
> -		start = amdgpu_vram_mgr_block_start(block);
> -		size = amdgpu_vram_mgr_block_size(block);
> -
> -		block = list_entry(block->link.next, struct drm_buddy_block, link);
> -		if (start + size != amdgpu_vram_mgr_block_start(block))
> -			return false;
> +		start = min(bstart, start);
> +		end = max(bstart + bsize, end);
> +		size += bsize;
>   	}
> -
> -	return true;
> +	return end == start + size;
>   }
>   
>   

