Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC166C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB9C10E508;
	Tue,  7 Feb 2023 13:32:39 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5971910E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 13:32:37 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id a2so13287393wrd.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 05:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N8XKzEE+OnQ74waAEBuW1Ct3BIzUWHfBgY4nCdW9d3k=;
 b=B3qUZLpsMyB3bRlgT3U0TaSAAZPWkh0m0fOFxqoAkv3q6FyFlwUeY2uMyRHhRffmDx
 ipY6TzGugoxazF+i/JMiCeh0p1S9TT94LVJkAm0c8WFkwilvyeDfVL/E56CcYbn6gN1Q
 Y2Pp6JQ308nrabLTZXND0VU96LMfAo9IZDvgzir6jgTAubn+xNNArcUHgFiSQP9GSXv4
 pK3n9nog3hau0bXtPU7H6wGzmHjhbXQFiR5FGscpHj/+Q9kEIHEoA/DtRApLRf5sNKjb
 mwRjPHz240+LwRWSFNM96SAsfGfuRRTw9BgUHJmzyOwSrQXZ8Kh+5tOkANITVZuCcM86
 JHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N8XKzEE+OnQ74waAEBuW1Ct3BIzUWHfBgY4nCdW9d3k=;
 b=BDBJyuUhTCerEKuEQAeCCYvvBFzkk0tG/Of5PT0lOegMlkkbvwBEeYKQM1Sz551DuQ
 CXa3OBabKkacUDnrPf8/pxPybVj5MC4wTgdCdBvv77+wqi/1F24Mm4Hc7btig7xztNQA
 F1CwdLHfAcpCwheqeJG7P3uVt64f0jk+3WU6PUcdNge1KnGWq2BJeQCmObvHEksgRFYF
 0s9BP54Xke8h8HJvq7RPKh19I4eQMip43d2Ru5V5kv4rRlIHMaf5UfB3O25vvHXVt7l3
 Llu8yG9uRxB/PiFi8OlFSQb4vlE30Ke5cxY32rg4ie9czZCie5PWkq4rxklP/PHj5NMq
 f/lw==
X-Gm-Message-State: AO0yUKUI4yO65oQt4CLjB0pNTWAhbWkWp3vKc9CkAWkYrZOWNhW/7eBS
 72xxLRQcG/wfxchkUtNswp0=
X-Google-Smtp-Source: AK7set80tGLdWORbDAJm24AShwUp3ytjJjMVv3bbNB0Cy7jqIwsmScrVuS/Qg4xhU0+vwxVm3ExKjw==
X-Received: by 2002:adf:de91:0:b0:2bf:9468:340 with SMTP id
 w17-20020adfde91000000b002bf94680340mr2464260wrl.19.1675776755800; 
 Tue, 07 Feb 2023 05:32:35 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 p12-20020a5d48cc000000b00241fab5a296sm11148752wrs.40.2023.02.07.05.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Feb 2023 05:32:35 -0800 (PST)
Message-ID: <4a7ddd44-9c20-ee9f-c373-a7cccb8490d0@gmail.com>
Date: Tue, 7 Feb 2023 14:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] drm/amd/display: disable S/G display on DCN 2.1.0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230131181326.3507396-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230131181326.3507396-1-alexander.deucher@amd.com>
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
Cc: yifan1.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If it's not already committed Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Sorry for the vacation delay, I'm still catching up on mails.

Christian.

Am 31.01.23 um 19:13 schrieb Alex Deucher:
> Causes flickering or white screens in some configurations.
> Disable it for now until we can fix the issue.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2352
> Cc: roman.li@amd.com
> Cc: yifan1.zhang@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3a40c6dec3d2..2e4040f1a357 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1534,7 +1534,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   			    (adev->apu_flags & AMD_APU_IS_PICASSO))
>   				init_data.flags.gpu_vm_support = true;
>   			break;
> -		case IP_VERSION(2, 1, 0):
>   		case IP_VERSION(3, 0, 1):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):

