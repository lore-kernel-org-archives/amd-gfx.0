Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF316103B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DF316103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B89589AC6;
	Wed, 27 Oct 2021 07:12:30 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4CE89C13
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 07:12:29 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id z200so814475wmc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=1l6P5Y17XwDSPNxSe6PKPraEJvJlZt6HHLpcn8zVRcY=;
 b=k6BEM2BMYghMIDvggEEoRiS5woh0ZLWKZCpHCFMhShonJLo0YImyZndHh7ugIm3RUR
 MXrmtR2ikmTrEgHENH0tVyFqWCGFHz5kNi6lfBsWqLH/MunzoDS5gNZwdTEAaVw5Rxsz
 uRKbBQIAcwVtmtuQRuQG5xjDneIre/ShgjZGs8MXjes0lx09hhhSHokJ85ytjX5Kv03K
 AVe3aseCLxJpLo1rnl3O/pEl1VppRNprwovdobuPeaHJsHtrb+OlDAxXfyKDjY5sXa/B
 LCbsEjnZs2XL6Jdhu3dSzEhIkO+KAKnESQHjxCMmcEs6sUmihEz0a1mSEM88fJvPL0KM
 srjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1l6P5Y17XwDSPNxSe6PKPraEJvJlZt6HHLpcn8zVRcY=;
 b=WMpNvlhkUe/53vYZR2qhM1wSp6V5OwNQTAmbpGPcOjr1EChBJ9L7+6QFqOPgSG+58w
 iCqEV+JnHpvfj+7kgev6Ilxe1vZ/jZq6lGrJzX23cgZmq9fcEuYqU+exnYc8+oVZOgaB
 vmYCGE8C1Xr5wtuSrXs+tncwa6HmSSM5TXdgeow1kNt3qr6Pr0mcWA87Gw0blk8CIU6/
 rJlA00Xm6/pS43CKyg72kc5aymCAPDKW0Yji9Myb1icxCXaMH4z6GNK/sI5wupNJ5o75
 9Yhb/q+LT41OO+Gq2WF4xN5vH7dnLCUmAK9t1DDxLs58BX42VBdp5LvBn2PPXmCHkpWu
 feTA==
X-Gm-Message-State: AOAM532426TZ6IdP9+ht1+koWhgCNLIXTp6mjxq6Lpjs9jzkUWi10QNY
 fZPzJ8LSPhJu+dlu/SD12gysFBB3GsQ=
X-Google-Smtp-Source: ABdhPJzxIbi1miIphkWvUA+52Zo5bTT8EO+4lQIXOwnucDRAQ2HamQQwKOUY8eeHuZ5KnmVqWgE6HA==
X-Received: by 2002:a7b:c937:: with SMTP id h23mr3794661wml.156.1635318747579; 
 Wed, 27 Oct 2021 00:12:27 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id k7sm237839wrn.16.2021.10.27.00.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 00:12:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu/discovery: add UVD/VCN IP instance info
 for soc15 parts
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211026144535.191727-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <75172428-0358-c3a2-2dfa-bfa271ffba92@gmail.com>
Date: Wed, 27 Oct 2021 09:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026144535.191727-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.21 um 16:45 schrieb Alex Deucher:
> Add secondary instance version info for vega20, arcturure, and
> aldebaran.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 208a784475bd..44b0821b6ca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1018,6 +1018,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 2);
>   		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 0);
>   		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 2, 0);
> +		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(7, 2, 0);
>   		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 1, 0);
>   		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
>   		break;
> @@ -1039,6 +1040,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 3);
>   		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 1);
>   		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 5, 0);
> +		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
>   		break;
>   	case CHIP_ALDEBARAN:
>   		aldebaran_reg_base_init(adev);
> @@ -1058,6 +1060,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(13, 0, 2);
>   		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 2);
>   		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 6, 0);
> +		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 6, 0);
>   		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
>   		break;
>   	default:

