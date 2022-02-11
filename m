Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED21CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C9110E9F0;
	Fri, 11 Feb 2022 07:55:38 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDE210E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:55:37 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id p24so21082034ejo.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=t05JN19CQySN4CSnPe7Zkt9c6NBmkvyKMVwouOZGi+4=;
 b=aGk93J05MTd1EgwPD6XWYYf1C9IwwueH0H7pTiMJSI9cRjoQ3r2jFVn65qE5ZyrBe9
 pQBfjabDitB6BlOO75FBBu7E3DqJGJJ6g1ayQgunn3YABBcHogcOhjAhHKWd7UJnu48X
 NU0lq/rMpb5mkG66zhmDn3Pwh02mCyEqs7V7jgyn1Nlmwd4zSkiOYF/ljkx8kUI/Bj2y
 hPbejkEsuqZQQmeTaNESrnfmjMnPxNWxkHf8CZmC4U/MLM7luGvVgzxfQjFYrUzxZied
 fFno8fNS9q37MNMZt70Sf3fVfUcZMm9h7V6jiLCtAD3bekzAaY2oFpkFN+weN0gX3KH4
 DYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=t05JN19CQySN4CSnPe7Zkt9c6NBmkvyKMVwouOZGi+4=;
 b=fKK6DLUJVUSwknO/ZdLBxop6DGGifHqO2Gst/E4O+5jcmzQosKZiMcIqVDzLZeBqgu
 cYfKrgF/dFuQAhQI4TXaSFQ+nkYtCXUJJ68BOvAVxFWnszW7x76jvwbCwgZEanG25MfZ
 YKArmNZZ4fjbqaTaHIv3iIzsvZkwxpEeAb0N3UhA8XvwYRV7x7t5O4aUM1w855Yh7EXP
 deFybhA7c9AEm/7r+f2s34MyUOMYHpnubEHUppi/PNFtielQzvAqDVTVIM8TlijsfMsj
 qCHonvncm4J/cwWTy6cr0lK5VEW2ZXe/0G918fw6cg6Vf1rLxp8qWaJWpa+sv4gR6xb6
 0Sqg==
X-Gm-Message-State: AOAM53188Ij0STKOqCeFuyZ8V0bQdnObG2iG8P1O9C4VThhnsyTeIqw+
 NrfBm/HC/D7ikaCXfywTQ2Y=
X-Google-Smtp-Source: ABdhPJyqqmdpLlOTh7y8kN81k0tlIX21OASNGJfT9Ke7ZrM/z4EKF5Pi7uGKHNQvq3i8G2lXZYWpzQ==
X-Received: by 2002:a17:907:2d0e:: with SMTP id
 gs14mr338737ejc.225.1644566136021; 
 Thu, 10 Feb 2022 23:55:36 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id o9sm4706927ejn.16.2022.02.10.23.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 23:55:35 -0800 (PST)
Message-ID: <7471a49f-0de6-82d4-06bd-774fef4fabce@gmail.com>
Date: Fri, 11 Feb 2022 08:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/12] drm/amd/pm: drop unused structure members
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211075209.894833-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nice cleanup.

Can't say much about the rest, but this patch and patch #2 are 
Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

Am 11.02.22 um 08:51 schrieb Evan Quan:
> Drop those members which get never used.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Iec70ad1dfe2059be26843f378588e6c894e9cae8
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fbef3ab8d487..fb32846a2d0e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -373,8 +373,6 @@ struct smu_dpm_context {
>   };
>   
>   struct smu_power_gate {
> -	bool uvd_gated;
> -	bool vce_gated;
>   	atomic_t vcn_gated;
>   	atomic_t jpeg_gated;
>   };

