Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9774EC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5584D6187E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5584D6187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97B889D43;
	Mon, 22 Mar 2021 16:03:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EB36E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616422107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVgT8cREJNNCZgsvwdo4IVCZkhVlPEV4H/HRfF+vQHs=;
 b=CHZliN66hPXgCQNWamKXsT2D0mInGwS8uG4hgCmsTfQi5FLDKkc6QSeA1HeoyfwVbZsGef
 lty5iL/GSY3FJOovgyCFuyKJi3E9xoKDQ+Pchl8Z0C0wm3gw3MyXZ9g6umWnZ1RG9mNorM
 7MhIcuURK9RTjjX61xkl+oWWx/zWMik=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-OD3rBaAWOH2YdQmYfqDW3A-1; Mon, 22 Mar 2021 10:08:26 -0400
X-MC-Unique: OD3rBaAWOH2YdQmYfqDW3A-1
Received: by mail-qt1-f200.google.com with SMTP id m8so29740990qtp.14
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FVgT8cREJNNCZgsvwdo4IVCZkhVlPEV4H/HRfF+vQHs=;
 b=d5GVSFt4f2Tv3yCqI8aR1l4C2VdL2SADb2JP6M4CPCEZ7caRKt6HHHEW/5cQFRV1TD
 JgR2v4KK6B/BRCFvNfDYrhfwJyI7ic4ftTtGRnpQQByYED0U0yGu8CU9SdLEBrJLjPw7
 iGqNFtpg6nXkjWeQC3jryUkO+eBby+qHtFBu4yUo1Ow6+van4J+8TwxXbwe9NeR0j/+c
 9McyNh/Lrtd2L7ee+NGZd4px6bU7M26QhfBe2Yk4CZH3n59RN86c2c94fWTSFQt2By0o
 BgBZNGybeEMeL3mSeaVXWHMH70RQie5c2Y4evjJu6VcszhMXybHhqUSpdt9pjNTMXgsd
 lHjQ==
X-Gm-Message-State: AOAM5303EbEceulBYqbmOL4Xd+O+0g/9cNqOVqfuky8/v5HssQio6gZs
 /k9wsw4LSa1NJL/M1vgU1NSNpP3/735X67TlVEVz3SF1U+rjCFo+hskENbPD4REQIl1t87Pbm7A
 12mnINY6k4WECNWGhjcZpPbOMYg==
X-Received: by 2002:a37:a74e:: with SMTP id q75mr170974qke.165.1616422105593; 
 Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrUVuJJE09nrcOBM4NdtiV05nyirk+Tg8pFgeTN9VypOp5y986vzL315hHiWdFn7UBNMA7CQ==
X-Received: by 2002:a37:a74e:: with SMTP id q75mr170943qke.165.1616422105378; 
 Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id z8sm9014413qtn.12.2021.03.22.07.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: avoid incorrect %hu format string
To: Arnd Bergmann <arnd@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20210322115458.3961825-1-arnd@kernel.org>
From: Tom Rix <trix@redhat.com>
Message-ID: <eefe9a55-4212-4d51-6add-9eb9ead0b5ed@redhat.com>
Date: Mon, 22 Mar 2021 07:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322115458.3961825-1-arnd@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Mon, 22 Mar 2021 16:03:17 +0000
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 dri-devel@lists.freedesktop.org, xinhui pan <xinhui.pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux@googlegroups.com, Chen Li <chenli@uniontech.com>,
 Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/22/21 4:54 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the %hu format string does not match the type
> of the variables here:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:263:7: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                   version_major, version_minor);
>                                   ^~~~~~~~~~~~~
> include/drm/drm_print.h:498:19: note: expanded from macro 'DRM_ERROR'
>         __drm_err(fmt, ##__VA_ARGS__)
>                   ~~~    ^~~~~~~~~~~
>
> Change it to a regular %u, the same way a previous patch did for
> another instance of the same warning.

It would be good to explicitly call out the change.

ex/ do you mean mine ?

0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")

This was for a different reason.

imo, you do not need to include what another patch did.

so you could also just remove this bit from the commit log.


The change itself looks good.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Fixes: 0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index e2ed4689118a..c6dbc0801604 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -259,7 +259,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  		if ((adev->asic_type == CHIP_POLARIS10 ||
>  		     adev->asic_type == CHIP_POLARIS11) &&
>  		    (adev->uvd.fw_version < FW_1_66_16))
> -			DRM_ERROR("POLARIS10/11 UVD firmware version %hu.%hu is too old.\n",
> +			DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
>  				  version_major, version_minor);
>  	} else {
>  		unsigned int enc_major, enc_minor, dec_minor;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
