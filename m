Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D6E784B0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F05B10E280;
	Mon,  2 Oct 2023 10:32:41 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD44B10E280
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:32:39 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4066692ad35so16652035e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242758; x=1696847558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FQIRgkgfRHRtGmLCdkMMekjRicrmnPMi/Ke3bZ9XeOU=;
 b=D5ZFeJ0YD54UV0XyuuGANr8Dfv6KBvDFjqdhT7Yq82SdCSEnZtDsg6QweU5bisgnO9
 uq5lCxWpz6Fojfl1mTDMMqJQpAHzuzChtmEv7noS3RvtRAR0P94TOt7aXL6myaOnGzup
 A6zmluunCXe52K0fQzSgxqOVnN6lLwuZZ4zeeZdxvplupgWTXZ+DvVhhCOvp+eRMMguN
 q2BV575WsNMkLyPtI1GQ5E5dMn9mzNcvPRFjBBMTTlr74kT44BHs6OuGWSaMjH6K9jpJ
 0JDSVCVC1UKr7fq6YJm5X5KKcEm58LfUYAW6Qa+gDhHHtiIIEi6V+UuFrRWHXi5Vk8BR
 PRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242758; x=1696847558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQIRgkgfRHRtGmLCdkMMekjRicrmnPMi/Ke3bZ9XeOU=;
 b=KZ9Z3ax8DIwOCjLUViOeEYZrBtaEP4XtKks85KMd77tT3R8KWkE841b2s4+T5vnS/D
 iEMcZQJGEsmsQCqmRWKMZ5gCe94/hcjwCJBr1EilDdP+WZCWark2Z3hgXssYAw+iJLPM
 2XIRwaxLdi1K4ln8vMlDIHlPs3auWQz95WfoXkyLVJbcCg3eB+W42cYLSci2ofMaCWdg
 FAHG1ORkvJNj2nhupn3T0NFLrMH752q9Hl/X5U1IwKgepdiaDk2lauI90iJkzgsH2pXO
 2YgWkvjiJPWGY0bsU+5XMYhG+7QdD/K8r7xbEgxpcqe04dXMawAiPWYRtki1+WgwohLO
 JKCQ==
X-Gm-Message-State: AOJu0Yzc5c3RR9ZXuimKvqyEWBshpM3DnHhI2/V3xdyjr9Xr7h+y1iFk
 ufUu0DDznMcB8OAKhq73IQE=
X-Google-Smtp-Source: AGHT+IE4EP/SgYbssQOp04XB9MWphdpn0RKcXVJDxVfxVQr0FgtLJRsNf0HeYNSjhKEy7QPkP0YYsg==
X-Received: by 2002:a1c:720c:0:b0:3fe:5501:d293 with SMTP id
 n12-20020a1c720c000000b003fe5501d293mr9136918wmc.30.1696242758164; 
 Mon, 02 Oct 2023 03:32:38 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a7bcc88000000b003fbe4cecc3bsm6921759wma.16.2023.10.02.03.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:32:37 -0700 (PDT)
Message-ID: <1d2ad4d8-49ff-17cd-ab2a-befcaf356dd9@gmail.com>
Date: Mon, 2 Oct 2023 12:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: amdgpu_drm.h: fix comment typos
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20231002010835.14798-1-rdunlap@infradead.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231002010835.14798-1-rdunlap@infradead.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.10.23 um 03:08 schrieb Randy Dunlap:
> Correct typos of "occurred".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -249,9 +249,9 @@ union drm_amdgpu_bo_list {
>   /* unknown cause */
>   #define AMDGPU_CTX_UNKNOWN_RESET	3
>   
> -/* indicate gpu reset occured after ctx created */
> +/* indicate gpu reset occurred after ctx created */
>   #define AMDGPU_CTX_QUERY2_FLAGS_RESET    (1<<0)
> -/* indicate vram lost occured after ctx created */
> +/* indicate vram lost occurred after ctx created */
>   #define AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST (1<<1)
>   /* indicate some job from this context once cause gpu hang */
>   #define AMDGPU_CTX_QUERY2_FLAGS_GUILTY   (1<<2)

