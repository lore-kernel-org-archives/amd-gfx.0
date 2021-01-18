Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A789C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 07:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFA122242
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 07:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFA122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845766E11E;
	Mon, 18 Jan 2021 07:54:01 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260386E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 07:54:00 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id h16so16449208edt.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Jan 2021 23:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yEv/m82M2NGWcBKTA3flOxbh1pKsoO8TuMsr60nRV/Q=;
 b=ev7wjm9fHvYPz8B+sTMkdhHmRPk7DDcTTpkkZA4KAlN0z/rQhV6waADiiNRlAmeG8O
 lNEWhEy19yStj/liHHBe3P8D+crmG0I3dafoBXF2yNBZKQGW263POHOVbKk268cdIBpw
 akmOI0oEk/Xh5vywnEEUk7q2jGo7cyhIy1KhZoKCbLRUynoxmOCnNyNavepM5XuN6gMb
 pBx0ejHFXwnun5mdi77RtB9mD4jerLizeGVLho1wwdoZhajlclqbUKS+2qKvNtmltZWT
 XLe8L64JNIrXLPkRbMmnYax+sw3EyZRJ4XJHw4m1QhAmoMZchpe0+C2mpWL49hzLoelY
 Afig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yEv/m82M2NGWcBKTA3flOxbh1pKsoO8TuMsr60nRV/Q=;
 b=sOXW2/qE6Ip2j9cLca5Nr008TDQwM4dV7hI1F3cOpkya1I0nwZQYMA7sDG53CLbS02
 /4FNdZjdZlsnI4ta/JaxxiEupi+fB0titKj/X5CL9BZE8oxA6xLN7fPdTQ+c+V1W+B0U
 8pYtoZcxv6C86mTXmXw7xFwYWCrVdr+mcp0HNKKSgUibqZawgJ4eUlaKMUhwLBKGSTad
 UeWJlgpuRfxFlZL+tPU8saUMXZINHvtwrpT2xUErS6k0NTeBIuwjSEOigxBF3c8WP2IT
 ko3nHE66WnsRBwjdEOmNLydrcQ+SzUbyyUsbLy5L5STMfXgdWCiodv/lBsAx+QUGaG0H
 uyCg==
X-Gm-Message-State: AOAM532+mlj/Hk9d81eIt2rx/i8jKuADxGJHHC/CgEN5X1u/VjgE+ilW
 g/ec3Kv+uMyyJRWG08+kyCEn6cMzl3c=
X-Google-Smtp-Source: ABdhPJwk/y5pwSMwSfCZAgCuu834he2SNnX+RnvsS2uy2Z6B+a0sgATDJ7lDOMcta5yQNvpMI+0w5A==
X-Received: by 2002:a05:6402:1383:: with SMTP id
 b3mr17684325edv.100.1610956438430; 
 Sun, 17 Jan 2021 23:53:58 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id ce7sm683756ejb.100.2021.01.17.23.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Jan 2021 23:53:58 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
Date: Mon, 18 Jan 2021 08:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115182423.32368-1-Felix.Kuehling@amd.com>
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

Am 15.01.21 um 19:24 schrieb Felix Kuehling:
> ROCm user mode depends on userptr support. Without it, KFD is basically
> useless.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index e8fb10c41f16..2800b2bb2522 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -8,5 +8,6 @@ config HSA_AMD
>   	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
>   	imply AMD_IOMMU_V2 if X86_64
>   	select MMU_NOTIFIER
> +	select DRM_AMDGPU_USERPTR

I think we should rather make that a depends on. Otherwise we select a 
visible config option.

Christian.

>   	help
>   	  Enable this if you want to use HSA features on AMD GPU devices.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
