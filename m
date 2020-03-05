Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE1C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B784208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbwbepkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B784208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006C16E313;
	Thu,  5 Mar 2020 13:37:57 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52E46E326
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:37:55 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id v4so7055790wrs.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oRuM43+Uc1eMMfyNAnshDCiX0aPX01pOP1umN3pBmO8=;
 b=cbwbepkYoNwepD09Lg6LVNyjmfL+H7RNVLkuGZK2UzxslD/zUciqyUxfkR5SScxBr0
 Q2jymXy4SIwP63D0iL1WrOcXrUAqC+VLh834dU4x56xWDdk6ZNMwv/MSPD09FF7WVRQo
 zBv7RXZsabg6SdLKP/suXH9+KIaVZEPkiBlz4CWTh8Osf06ZgGhBqWw8zMlPAbzngijY
 Jnz58KudaF31hiw/4Pf8ChIdQWA1Szw1ygBWIi2CovHK7Y6o8L0Dyn7rMKLtb0sbtUkh
 xaWGI1pfySzKPzWxYL/X4DuaK34NTmeXIKk+d0SfLtO/kVRrr/YGd3p3DS6smly4o7zv
 lYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oRuM43+Uc1eMMfyNAnshDCiX0aPX01pOP1umN3pBmO8=;
 b=dXuD41ZS7TFR/Yr8D508FmMoXk1b57wibzpw//HlBNpLwA776hwE9KB6oykSvBCBbG
 LKMSysE+7Edk8CHZMhmtToAqzuBP89L7b3brOscSkoTb4m5B0KkvajTNVtKaJIgesPPa
 tZBBa9iUS/Piu8b9vHbVasrwMMiCnjTadFAJ/G8JVHRL76Xb3hAXt/vuudoDbVa3Bwpo
 orlikfAsXf7gacAH0X8ifqmRUch3VSEXK+8rC9dCunj9KPVNxVUx2G50jmLjY3E6Gml5
 pKHe2+muv6kFGEj9VQAMT20qxglNQHBl9eG59DwTiUEd9kEmCRbct57+B7qICBqeDO7d
 He+g==
X-Gm-Message-State: ANhLgQ10OcpUzHRS1vhQaMXnDC7zbwwlRBvbJQ4sG/TYmvorVlhKm56v
 6Ec6Hg0nVsr+Wvpuzh1DnAM70lbD
X-Google-Smtp-Source: ADFU+vu9nJ5QaABon+JVwUoTTSNO8/Fc2RwVYhQ4E7YFfnPWlqvyZKdgswNJvBjT396ue9On4ce1JA==
X-Received: by 2002:a5d:5690:: with SMTP id f16mr10505645wrv.266.1583415474235; 
 Thu, 05 Mar 2020 05:37:54 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k126sm8868040wme.4.2020.03.05.05.37.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 05:37:53 -0800 (PST)
Subject: Re: [enable VCN2.0 for NV12 SRIOV 2/6] drm/amdgpu: disable jpeg block
 for SRIOV
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-2-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <32d7916b-c783-4762-b1ad-5627011ba6b4@gmail.com>
Date: Thu, 5 Mar 2020 14:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583415187-16594-2-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A commit message explaining why we disable it and if it could be enabled 
again or if this is permanent would be nice to have.

Christian.

Am 05.03.20 um 14:33 schrieb Monk Liu:
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2d1bebd..033cbbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -516,7 +516,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>   		    !amdgpu_sriov_vf(adev))
>   			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> +		if (!amdgpu_sriov_vf(adev))
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>   		break;
>   	default:
>   		return -EINVAL;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
