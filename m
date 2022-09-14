Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8BEECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 09:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543EB10E8C2;
	Wed, 14 Sep 2022 09:04:00 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2631210E8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 09:03:57 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id go34so33170386ejc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=2xFQv0dOdJKb95Wd52ZeBzrP/3JRmzYEfTP9dP/98H4=;
 b=RLBIWqZnYnI3EjGAWujHA3PWk6TX04RgKH4IZiRrqrWoyEd1MT4hyALqpZgWuxSJkB
 6xUSzA6vHNR8C6GDK1YylTSzAzYTHHNvbjX8x/je8Pn71yKcIrV2yqa986db/irSkf1G
 IE2pmhpzSyr4ZUJYIjIOfraAdaHiX87A/5eFC9QdMCqLSPbLiV4I6wibbftpoPtK/z/s
 gmdD6o/ema0uRR0VlSA0kR7K0hmioE69hK7F5o5U3f+hE+GbxUa8FIbiBEdlkTTC+RJ6
 e+EPmlD3uFNWwMqpHboeCofe78a5FJIKoJyT6z2rE6y5CTTjAlS4oT5WrkSU8dUng4Te
 5Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=2xFQv0dOdJKb95Wd52ZeBzrP/3JRmzYEfTP9dP/98H4=;
 b=mI9a2gZBgK2L3Qx3rSr6c9OHfi0818gvf+f0/7uxLIUPPFZd+NQ3Ceag2GT8AnAwXg
 bkr4Y9AyqpiiB4JFcqo0wbMX0x0TmbhulWOSvxkXzTpCn3yCipWarN+sJVvNQqzP6WAC
 lXPY9FKVKUu49qFoOywOlc6zdn6Jj0hzA0I+TqO2dN8Uj0emOppx9uaDqcxpzfadu4Ax
 owrgQNOUpOKhgydQZY70cPhBQK9QEsIvcCXB8dd4zOguI5iJcul0iu/kvZyaPbAGnIjL
 hSw5JGtPznEBvRLFoY/SL8EoRYmIsoGAkC0bZXra+ynFmF7r6NqV69ICksbh+gpqDy+2
 RlmQ==
X-Gm-Message-State: ACgBeo05OzRIi7tM7AUAx0vAyW4muCztpP1jAbkltnTF/ON8gvBsqEV/
 JwIWVfQRcLa1kewH5+5mZO8RY+q675Y=
X-Google-Smtp-Source: AA6agR5tOiQNQ/Vm7mTy5vmSrBVaYccu0A48CR07xMvtQNpHjOVB9mw/UrXPlA9nHeiFY3BQIqzNCQ==
X-Received: by 2002:a17:907:6ea0:b0:77e:c2e5:a35b with SMTP id
 sh32-20020a1709076ea000b0077ec2e5a35bmr8047131ejc.566.1663146235575; 
 Wed, 14 Sep 2022 02:03:55 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:158e:603b:8394:aba3?
 ([2a02:908:1256:79a0:158e:603b:8394:aba3])
 by smtp.gmail.com with ESMTPSA id
 v17-20020aa7d9d1000000b0044f21c69608sm9443663eds.10.2022.09.14.02.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Sep 2022 02:03:55 -0700 (PDT)
Message-ID: <0fdecd48-46ec-c69e-79d5-a2e0db3d5a37@gmail.com>
Date: Wed, 14 Sep 2022 11:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/amdgpu: make sure to init common IP before gmc
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 helgaas@kernel.org
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
 <20220913144832.2784012-4-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220913144832.2784012-4-alexander.deucher@amd.com>
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
Cc: regressions@lists.linux.dev, airlied@linux.ie, linux-pci@vger.kernel.org,
 m.seyfarth@gmail.com, tseewald@gmail.com, kai.heng.feng@canonical.com,
 daniel@ffwll.ch, sr@denx.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.09.22 um 16:48 schrieb Alex Deucher:
> Move common IP init before GMC init so that HDP gets
> remapped before GMC init which uses it.

At some point we should improve this so that we have the common and GMC 
stuff in the hardware init as first thing without those hacks.

But anyway Acked-by for now since this is higher level design work.

Regards,
Christian.

>
> This fixes the Unsupported Request error reported through
> AER during driver load. The error happens as a write happens
> to the remap offset before real remapping is done.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
>
> The error was unnoticed before and got visible because of the commit
> referenced below. This doesn't fix anything in the commit below, rather
> fixes the issue in amdgpu exposed by the commit. The reference is only
> to associate this commit with below one so that both go together.
>
> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 899564ea8b4b..4da85ce9e3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2375,8 +2375,16 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   		}
>   		adev->ip_blocks[i].status.sw = true;
>   
> -		/* need to do gmc hw init early so we can allocate gpu mem */
> -		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
> +			/* need to do common hw init early so everything is set up for gmc */
> +			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> +			if (r) {
> +				DRM_ERROR("hw_init %d failed %d\n", i, r);
> +				goto init_failed;
> +			}
> +			adev->ip_blocks[i].status.hw = true;
> +		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +			/* need to do gmc hw init early so we can allocate gpu mem */
>   			/* Try to reserve bad pages early */
>   			if (amdgpu_sriov_vf(adev))
>   				amdgpu_virt_exchange_data(adev);
> @@ -3062,8 +3070,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	static enum amd_ip_block_type ip_order[] = {
> -		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_COMMON,
> +		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_PSP,
>   		AMD_IP_BLOCK_TYPE_IH,
>   	};

