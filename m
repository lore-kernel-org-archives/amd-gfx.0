Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92770CDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 17:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F4710E049;
	Mon, 16 Oct 2023 17:58:08 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9344010E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 17:58:05 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40776b1ff73so25973235e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697479084; x=1698083884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpFFxE7qCKFFU9/GXZtWmbqj6cWnxVoYPNDZ4uE5Mzs=;
 b=YIkrpvB/jKlc+1CfL/lYpIR+Es7eOgKoCy9xZOo6Pzbi74PKlrJCQNpYJ23Y8WOobV
 7NQ5JPHgF5s1pUdXc9TY8fa4BClsBYc0h43MwD91wk8pdZ9rNG9AZWTxCq2A8hVxmPUp
 EWMG2sd6+xA+9jma9y+B+KthvIqV+IcA1JkZQrl4v3ZCTCA0g2Qut0hXswMsqq7/vpsc
 5NRWmL8wRLqYsaQZ8ecIYrWrsChmhBplJCOgtTpFApK6CGI2AuOI9IhKjZoTNNE4izPu
 ekXuJwt5i3X/gn3J05ms5NrVTh1qghpI2shlDJPM6VoS8xwEzWWmOFlbtm/oBJm1scqI
 2VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697479084; x=1698083884;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DpFFxE7qCKFFU9/GXZtWmbqj6cWnxVoYPNDZ4uE5Mzs=;
 b=gVW3sNSFUXhJdw2zg7qoRpnniXGBUwBcznifOuxQzWOZ886svB8B4ncvoHFZCBmbMc
 HlzVyKXubH/S2oTvdUK2TbEon2dHQWPGjbxS7aFPcIdx7CVsNbN6pHXPb6N5bEgyUoMj
 Y4YjlP3aD59Q7oIMGk/vVQr6jfnyv2oWPjfZXjdQPsnPIt8PWoaDTf8/WRkgaLWQ0i2R
 OrEe0bwWgNjEOB42avxxPkibYF+uTkOylVxUG3KI/tAq+ITgTi3QSMbCkpnMKIyIum/h
 mt06O4i9sNJXdVUA6enYgxflI6Babh/gpQCPo3tlDc7lrYwaBNDaLGX8VQlFrUeDthUF
 vrxA==
X-Gm-Message-State: AOJu0Yzf2243ko5Zxb2cR50GKLQyyozcGMvxXCSsqlEps9zqG6qn28rm
 QwicJ+yNojORA5s14ZlrYJc=
X-Google-Smtp-Source: AGHT+IFbcF/6pcteIUpZcpRmGFuGAjOFKvLwzCJ9ruArGpRriNd0FGryLOcuI/sfFHSovuK0Iyxanw==
X-Received: by 2002:a05:600c:164a:b0:402:ea83:45cf with SMTP id
 o10-20020a05600c164a00b00402ea8345cfmr30000501wmn.2.1697479083833; 
 Mon, 16 Oct 2023 10:58:03 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c204f00b004063cd8105csm7633423wmg.22.2023.10.16.10.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 10:58:02 -0700 (PDT)
Message-ID: <e339101d-736f-45f1-989c-0ff6732dce61@gmail.com>
Date: Mon, 16 Oct 2023 19:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P1
Content-Language: en-US
To: Bokun Zhang <bokun.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016165255.2760-1-bokun.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231016165255.2760-1-bokun.zhang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.10.23 um 18:52 schrieb Bokun Zhang:
> - Update SRIOV header with RB decouple flag
>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 104a5ad8397d..51a14f6d93bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {
>   		uint32_t host_load_ucodes  : 1;
>   		uint32_t host_flr_vramlost : 1;
>   		uint32_t mm_bw_management  : 1;
> -		uint32_t pp_one_vf_mode	   : 1;
> +		uint32_t pp_one_vf_mode    : 1;
>   		uint32_t reg_indirect_acc  : 1;
>   		uint32_t av1_support       : 1;
> -		uint32_t reserved	   : 25;
> +		uint32_t vcn_rb_decouple   : 1;
> +		uint32_t reserved          : 24;

Are you guys using bitfields for SRIOV guest<->host communication?

Christian.

>   	} flags;
>   	uint32_t all;
>   };

