Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05754E784AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5038510E197;
	Mon,  2 Oct 2023 10:22:33 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBA210E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:22:30 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405497850dbso143517055e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242149; x=1696846949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+uo4BTlZEgMaW1IOY+RRs2ugbthQZA7HUoQBQhiNk2Y=;
 b=TUbXUxsFKhTsjKJ0JiC1zlHJIkUsGXkjv9KbkXQGShOPmuS1OZmoShnqtBhQj2+zoX
 pCmRFsBFi7oxZHGOuFueMQWd/gjSbXuYY7+YFp9sYR5fLZ9OT0vPJyp/VnnvKvDgHWux
 02f3l8CCPBcy2qPI5BFefUKhODtb8RW4li7u9xEZWOKqyPAU3iogiZWvZgzbs96TGsUX
 UCS0mUWL9+JZ1jpWsgrQ3zhFyKamOqYBsxCKDZ62qMk2oEKycapfBeSxQAxomMEu0TRP
 ci6wZHrbZdOEBZgnWjK6s+Flovwz+4YICvbR8vQ5orfuGFLyHNiqUGMfDOxOwdLE9Z8V
 tF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242149; x=1696846949;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+uo4BTlZEgMaW1IOY+RRs2ugbthQZA7HUoQBQhiNk2Y=;
 b=oadsPSDN+u9jvGQGRPfc50JgB+Iomh3l3GTj7RwM2axFddOmtyCeiFDrN992BG67rY
 ea/MG0IpV0maTTuVTHne5DdeOLtWerF1NZ+S6iEPxb/o6SIDWBhdBZgSVnLaELASykju
 FedjbqrAn4DRdx/YKmXxogx0TsnQEZwxe659kUrG4kmXSRszxdS/4Jq3RidxsNQlW29C
 YP4/EPLuc8xB77aU7/pzJnT+HC9NU2uYt+pu10cvvNUSLaxrkRi2CkZhuk7mJfDwc0xt
 fDaJ89FmZp9MKAAaUpA7dR+5OUhCWxZ6DZC+LGHjRPF1/fhEZsXwUTCbMr9u7oeT1b5i
 9Ulw==
X-Gm-Message-State: AOJu0Yx4HHUF1PYG0HpOPTyyiWAjyQ5oya+Zm+8HnlWc/VaVQ2NLH+lA
 hmUvTEOQLIfYWm+K8Nmihbk=
X-Google-Smtp-Source: AGHT+IEWSS4yOUJsu6VFP7lFXM3/LHqdn5Yim7759mjIKuaxd2Qy42hz5K+L0X38GStEx4BVbWcgtQ==
X-Received: by 2002:a7b:c8d1:0:b0:405:3b92:2fed with SMTP id
 f17-20020a7bc8d1000000b004053b922fedmr9137934wml.26.1696242148482; 
 Mon, 02 Oct 2023 03:22:28 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c204300b0040648217f4fsm6890443wmg.39.2023.10.02.03.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:22:27 -0700 (PDT)
Message-ID: <39bc8190-47d4-81ae-64a9-a25b3ee5ae00@gmail.com>
Date: Mon, 2 Oct 2023 12:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/4] Add GPU page fault query interface
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230928200608.2857534-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230928200608.2857534-1-alexander.deucher@amd.com>
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

Am 28.09.23 um 22:06 schrieb Alex Deucher:
> This patch set adds support for an application to query GPU
> page faults.  It's useful for debugging and there are
> vulkan extensions that could make use of this.  Preliminary
> user space code which uses this can be found here:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298
>
> Note, that I made a small change to the vmhub definition to
> decouple it from how the kernel tracks vmhubs so that we have
> a consistent user view even if we decide to add more vmhubs
> like we recently did for gfx 9.4.3.
>
> I've also pushed the changed to:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl
>
> Open question, currently we just expose the raw GPU fault status
> register value for each GPU so UMDs need GPU specific knowlege to decode
> it, although it's largely the same across generations.  One option would be to
> translate to a generic GPU independent fault status.  Opinions?

Lot of work for not much gain. I think we should stick with this for now.

Reviewed-by: Christian König <christian.koenig@amd.com>

>
> v2:
> - Fix spelling typos noted by Guchun
> v3:
> - Add locking in IOCTL query
> - Only update cache if fault status is valid
> v4:
> - Rebase and resend
>
> Alex Deucher (4):
>    drm/amdgpu: add cached GPU fault structure to vm struct
>    drm/amdgpu: cache gpuvm fault information for gmc7+
>    drm/amdgpu: add new INFO ioctl query for the last GPU page fault
>    drm/amdgpu: refine fault cache updates
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 50 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++--
>   include/uapi/drm/amdgpu_drm.h           | 16 ++++++++
>   10 files changed, 135 insertions(+), 8 deletions(-)
>

