Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C2BC83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 08:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4533610E249;
	Mon, 28 Aug 2023 08:44:45 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0620910E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 08:44:42 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso383074266b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693212281; x=1693817081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfvrTzn6q9r/XaRnYWWj1h2+2D7BkmfUF72CjRuhvUo=;
 b=PT2eFGSZo887AbK3vZ4Qyx+9uBAgq+xcavMqxXRsURwwhWmUHZYsaWtVPsCVdvlNlR
 1h44vFim8qRKs4QWfmmsYFTxfmMkSb+wfSk4UOhgueqy9Yfs910UKVWSJp3bgiVGTjg6
 fuJ6dEom7+LigxH4r5L3s3TLsmjSUgtlSHDD5JjhDO/AkW8oBiGCCCeR+1zIi7MbNer3
 9UOroxuhCNfCIhkFwHuu0cuC/vs79u6/LV70vb/PLNbPV4ineJYTG3r1ZwA0jF+N9fNh
 tgX91y6fG1HMrOzRlynxc/ioDgPKhAfjBrgvDtD/1f/U4FTgiihoET4fUpwnKMlbHIsD
 fitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693212281; x=1693817081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfvrTzn6q9r/XaRnYWWj1h2+2D7BkmfUF72CjRuhvUo=;
 b=DMPO3Hm6WvjP2Z9+NJ0WW4TcdB/MsiLDxH8d7X4bYMQ2PzgX+so3FPVb/Dc22KF5ED
 Pl24tbO/RgYsTbGYdEZntckKD1jqViQ4skJBtl/Ab259RWZm9L3cdXUFQizmO5KZP5ue
 cEnjxhsv/5Xc3/7hVanLxCmRFHmOC01wwrTSXz85MxS/Am8EF1DB7sNnNDflN9slbHO5
 SSeX5XmouIspXWgq4/dcLTMgxLUYqSCjtmca+a/2XAFFfMnEBwKy6+U/rHpz7hv7zGI9
 8ujvLflHic58tFb9X0JUYaA25oRVTZ0LQ+4rriAjuC2YMEz6IOY2sLAg5sKomXYbVPho
 DqlA==
X-Gm-Message-State: AOJu0YyA/bv1wZ2zAVEy2jaZNY1Jp+cVc1XlljhFeT2m9Po5T4Aj2UL/
 HdjtvFTgsCmlB8iSZ/Ip5ak=
X-Google-Smtp-Source: AGHT+IFAVmLmgs87pZwD1JP9Eb2Ak6FG00HDo9G+mGnPC9fCYeKhGXVCnvWsAPCeKuUn/msCokrAAg==
X-Received: by 2002:a17:907:2be0:b0:9a5:a247:5bbc with SMTP id
 gv32-20020a1709072be000b009a5a2475bbcmr2674980ejc.28.1693212281190; 
 Mon, 28 Aug 2023 01:44:41 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.98.175])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a17090640c100b0099bcf9c2ec6sm4350538ejk.75.2023.08.28.01.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 01:44:40 -0700 (PDT)
Message-ID: <630f2e2a-4e68-8eec-9657-b7cbd62ec3b7@gmail.com>
Date: Mon, 28 Aug 2023 10:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: remove unused parameter in
 amdgpu_vmid_grab_idle
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230817070042.3135567-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230817070042.3135567-1-yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.08.23 um 09:00 schrieb Yifan Zhang:
> amdgpu_vm is not used in amdgpu_vmid_grab_idle.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Sorry for the delay, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index ff1ea99292fb..ddd0891da116 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -188,7 +188,6 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>   /**
>    * amdgpu_vmid_grab_idle - grab idle VMID
>    *
> - * @vm: vm to allocate id for
>    * @ring: ring we want to submit job to
>    * @idle: resulting idle VMID
>    * @fence: fence to wait for if no id could be grabbed
> @@ -196,8 +195,7 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>    * Try to find an idle VMID, if none is idle add a fence to wait to the sync
>    * object. Returns -ENOMEM when we are out of memory.
>    */
> -static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
> -				 struct amdgpu_ring *ring,
> +static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
>   				 struct amdgpu_vmid **idle,
>   				 struct dma_fence **fence)
>   {
> @@ -405,7 +403,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	int r = 0;
>   
>   	mutex_lock(&id_mgr->lock);
> -	r = amdgpu_vmid_grab_idle(vm, ring, &idle, fence);
> +	r = amdgpu_vmid_grab_idle(ring, &idle, fence);
>   	if (r || !idle)
>   		goto error;
>   

