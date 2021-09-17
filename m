Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F45C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 06:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4863360F4A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 06:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4863360F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5276EB91;
	Fri, 17 Sep 2021 06:23:20 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7256EB91
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 06:23:20 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id u15so13305052wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=6K+Tl6Cxq1QpoXEqOucAzGTb9UI11TsjH8EyOam4RgQ=;
 b=bgms0OiN0Kf76BDTnqD8EvVlX9e0WGZ4dVSKXDTUk3y+BWTGhD+EjT71vUgmXglEX1
 bRJIH7l8DhvNAVMi0EdX8yVsIw0qd1qCj7V4kgIff0yH3L9wTxuP1VRObkkzb6AeS+Nw
 O8sHan3xD6isPFKetSwjXxzu6+tmjALjFPG8h5nxt+AhUC04q9HHkQlHEV29XAxceqJU
 MaxTTSG08OjQxGHflr9GSdh7mzvXdX2a1fZptD7oHVb27iCA3SnZF96oO8tRthRHQ/Na
 xLS4miNqblY4SksxiabVZwUtubnnl87evjT/qcUbuX0GZYzelIxuoxqrJIK67dTDfqCn
 d4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6K+Tl6Cxq1QpoXEqOucAzGTb9UI11TsjH8EyOam4RgQ=;
 b=jhJw1/yvT0yBjxW5eowPphExdX6PAZ5wubfKg3ZFdqIKKkOPNnPNF4KCCETdcfmDlq
 KrEy6f/MaJWXiAU0x334NQkXbDrxPuTeliXsieqU9FHLTZxdMi6AYkwvEUOO8ajkrl5m
 mG4ud/jXI67cqFAKnjtBe+ii9ATZ2Qo7oOLWORvacmkeiOjo589V8LLg+nR7zPWllinj
 y9hTamKN2sog5vRDJ4GM4IyntjSIaqGewegjWlTp/l6GBY5Jq2xH8bLRFVNiw8GjS4Gl
 buXMgDQeyGvxwD8V5xBCnEbByV21wA//irHCjgPvTJwIxNYkXL5pW0SGhGnntldZXyS1
 VOXA==
X-Gm-Message-State: AOAM53145Tl2cUhawEyfUORxKaNFXGm/0hFzUDdlycJNbUJ5bSMHXCo5
 9ATBZCTJJqFrlK/FqwVsTRHkmuf7U+aEQyk2
X-Google-Smtp-Source: ABdhPJzP40gxM1+Tdyt5m2mMwrCd792momAR4vlLgVzo1tXkBj2lEl3wd6+qJbSAPjwbtNXKaJEMHQ==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr10121932wrn.47.1631859798768; 
 Thu, 16 Sep 2021 23:23:18 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j20sm5747878wrb.5.2021.09.16.23.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 23:23:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: mask out invalid PTE address bit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210917005037.18526-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c0b48786-f12d-cc83-63fb-24d321d4241c@gmail.com>
Date: Fri, 17 Sep 2021 08:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917005037.18526-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 17.09.21 um 02:50 schrieb Philip Yang:
> Before adding the PTE flags, explicitly mask out invalid address bits.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Well NAK, we intentionally have a WARN_ON later on to catch errors like 
that.

Are some of the flags set in the address here?

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a1ddf74bbdba..b40c15c9fc81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1445,6 +1445,8 @@ static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
>   				   uint64_t flags)
>   
>   {
> +	addr &= 0x0000FFFFFFFFF000UL;
> +
>   	if (level != AMDGPU_VM_PTB) {
>   		flags |= AMDGPU_PDE_PTE;
>   		amdgpu_gmc_get_vm_pde(params->adev, level, &addr, &flags);

