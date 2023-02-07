Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D088C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D471D10E501;
	Tue,  7 Feb 2023 14:14:51 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1DB10E501
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:14:49 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id q8so11126346wmo.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnGee+hZY3uV1eZLltmyHzY6la1csu2b/Gz3453yxQs=;
 b=fIWRto0wSmo3wT5yjumHvvMW+RW+l7iqqsryjVqcsd32RpbfkTIGXT0pF1f5ygdMsE
 XnKIEveIS01EVqb90UmcDifNtavnjlxI2lpuEHM5Pv042Gd5yKuyv/WcXcOI8rgonOB9
 tECEq2gy/MLy5DrKD6qBXQgeQH1uP9s335WiCWHiyq+P/4ymoYLE9q3ieNp8CdbGv881
 zGBb0+B0OODEjOmt9Ggzr/OFZ/VjdpErHNjCVcVfGVT6B2YzEvvjuDBpALrBxko/7Q3L
 G6bYFzG5lt3hKxMEEGzkl9N+WmUutXJLwTlhGBeH2FMo5Z2EBPOCALDdaqUFBRMrxUeK
 BjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnGee+hZY3uV1eZLltmyHzY6la1csu2b/Gz3453yxQs=;
 b=5HlMsrg6I8OOXu2gVmy9WXxmeYZ2Dc/vvbnGCETE+L1PivRQRxD13wKUf/yQomL5Ty
 xGCn0V09HltNDUDG1Q2p5kf4W1wiCvYBJFbbpOBCgxee8+7IUiS94yYgVq4aF0yo0hxk
 HzTb3Gf3K9l5krLHvi+kL7pDPoONsYvqu9IXFVDntRLmPVxHdW24V7iXxKtTUJjPc62Q
 JGZ73SNE5Jsmucs5NG1yFlcx4df64Bebb2gwwZ8O+mRNITYNop1OEG4rGLl4FlPY/H2L
 JvFVGAEgr8ZzYo+MgFsTYk89C1pX+ZYC7lMG9VIVYp/fJG5+yOaDlZxeaY3CEEj58HFG
 STxQ==
X-Gm-Message-State: AO0yUKVwAsVzyhAdqrP2bQDRvTSqhf2AoIvDvS/Ka3K9GEMW0QAiComT
 sV8A5dYrrCKywL7RPxs8sQ58mUOSWWY=
X-Google-Smtp-Source: AK7set9yvRlqh+JM84LBZrWboTsz/j5nNT48xKbNLL36fuciCphlItLwaadIUNyaTlxSff6eTulFoQ==
X-Received: by 2002:a05:600c:4910:b0:3e0:c97:f1d0 with SMTP id
 f16-20020a05600c491000b003e00c97f1d0mr3415898wmp.20.1675779287840; 
 Tue, 07 Feb 2023 06:14:47 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b003e01493b136sm2774742wmo.43.2023.02.07.06.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Feb 2023 06:14:47 -0800 (PST)
Message-ID: <5f2fdd73-a8f8-7fe9-2c28-634bd0cade62@gmail.com>
Date: Tue, 7 Feb 2023 15:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix incorrect filenames in sysfs comments
Content-Language: en-US
To: "kent.russell@amd.com" <kent.russell@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230206172537.2320224-1-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230206172537.2320224-1-kent.russell@amd.com>
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

Am 06.02.23 um 18:25 schrieb kent.russell@amd.com:
> This looks like a standard copy/paste mistake. Replace the incorrect
> serial_number references with product_name and product_model
>
> Signed-off-by: kent.russell@amd.com <kent.russell@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a10b627c8357..5a97021bbb23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -162,7 +162,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
>    *
>    * The amdgpu driver provides a sysfs API for reporting the product name
>    * for the device
> - * The file serial_number is used for this and returns the product name
> + * The file product_name is used for this and returns the product name
>    * as returned from the FRU.
>    * NOTE: This is only available for certain server cards
>    */
> @@ -184,7 +184,7 @@ static DEVICE_ATTR(product_name, S_IRUGO,
>    *
>    * The amdgpu driver provides a sysfs API for reporting the part number
>    * for the device
> - * The file serial_number is used for this and returns the part number
> + * The file product_number is used for this and returns the part number
>    * as returned from the FRU.
>    * NOTE: This is only available for certain server cards
>    */

