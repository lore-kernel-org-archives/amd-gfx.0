Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C42C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 09:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B369D10E326;
	Mon, 13 Nov 2023 09:48:34 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2787810E326
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 09:48:33 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so33114075e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699868911; x=1700473711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joPowQTAQYfrqDNSE9P6qmIBOG79wFWDeEWW5jtQvQw=;
 b=LdJ9qwZI0Gpm19EBq3wx/8AAQoAHfcf1caQNEiKSkaehDnqSyT3KJ2UFfWEiSip0aY
 62MZK3N1SrhZJwzs3f8joIP+9Jl2PFTgoET5v0MO8ljQt+j50Iv5/qfc1AtuIK1Pq3yZ
 NSOPvIyR/xW8w9log1nmiV0OTbBH9ECAmq29Ml9JFJFQGZnVnfwi+TJ8rxmw+IX07Hxn
 s7z5tysHnTcs1D7SQuK6330KcnzW7LuulTMg3kFgXZJOwZrKq2lFvCGEnb4IvnCpkvZ5
 IuZ5o+K83zp3Ro+9ygTZfx4jxGURSUQbBrSORtZ8M+krWyFjBRyKWXxoCJUiaBvraLpR
 ZnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699868911; x=1700473711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=joPowQTAQYfrqDNSE9P6qmIBOG79wFWDeEWW5jtQvQw=;
 b=QF91nDf9lDJaWAFW+Aao6NgSzV8uMCleihxbJ5zKrHRDUxvqUGzVCmaYFvUknUcGd2
 HECHvipmM15ovivFF9qpkBY7ar5qcs7jIJiQikMdwxh5MgrAAKGAaY1SDWAyt7fdBn/E
 AOdtm3Pc2Mke91XWLlugJe1lNMuYIjlBgtgXqFUy8yB545HBgMrCQ2mZ2zt2DoJZ/ppk
 cZQWrY0c3q/vVWH+3mAu/LM13NjhsBExKACutkYltb7zVyCC+n7EgKchFWGdzeL96VH9
 8H4eA1OVO19fj7JCXKU/HEvQ3RtIbII/robQs+mC33s2GsbT5fqmIhsmmS1XdyEd4nZh
 2o+w==
X-Gm-Message-State: AOJu0YyQ6sxdH3uY8knMc5b/HjKuNV2xWixYWOAL0jHsTtwqY5OFtjig
 J0+xHVF5HKGQB7ANc05MBICizSla4+8=
X-Google-Smtp-Source: AGHT+IGKrGTQ7ieK85kHNfrzjNrFjDDsKmey0ZKnqghvBjlRZc+prkbcXPidVDFQd+B2MIMmzF78dg==
X-Received: by 2002:a05:600c:4708:b0:409:6edc:6e5c with SMTP id
 v8-20020a05600c470800b004096edc6e5cmr5635191wmo.0.1699868911238; 
 Mon, 13 Nov 2023 01:48:31 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d4b43000000b0032cc35c2ef7sm4993313wrs.29.2023.11.13.01.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 01:48:30 -0800 (PST)
Message-ID: <ad17d7fe-6ab7-4f09-bcdb-fdb34d9c7e7c@gmail.com>
Date: Mon, 13 Nov 2023 10:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Address member 'ring' not described in
 'amdgpu_ vce, uvd_entity_init()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
 <20231113053113.2057704-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231113053113.2057704-1-srinivasan.shanmugam@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.11.23 um 06:31 schrieb Srinivasan Shanmugam:
> Fixes the following:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:237: warning: Function parameter or member 'ring' not described in 'amdgpu_vce_entity_init'
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:405: warning: Function parameter or member 'ring' not described in 'amdgpu_uvd_entity_init'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> Updated ring variable description to "amdgpu_ring pointer to check" (Alex)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 65949cc7abb9..07d930339b07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -398,6 +398,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>    * amdgpu_uvd_entity_init - init entity
>    *
>    * @adev: amdgpu_device pointer
> + * @ring: amdgpu_ring pointer to check
>    *
>    * Initialize the entity used for handle management in the kernel driver.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 0954447f689d..59acf424a078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -230,6 +230,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>    * amdgpu_vce_entity_init - init entity
>    *
>    * @adev: amdgpu_device pointer
> + * @ring: amdgpu_ring pointer to check
>    *
>    * Initialize the entity used for handle management in the kernel driver.
>    */

