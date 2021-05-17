Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBDBC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0194661004
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0194661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A966EA68;
	Mon, 17 May 2021 19:43:03 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E293B6EA68
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 19:43:02 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id h16so8293470edr.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hkAPE20iTaOwc9pErohM8yZy/98oIfu5aMS4byydHN8=;
 b=Uo0F/GcZ+QV+L1FxK94Zm5Q8bgUKazUPH2AmLXAKgB/wqgFrKr+4gLkZVLhxq+4/BA
 WtmV08gkOsWLTTTLQ3D6DqYnmnoc7PcTycyfcEA7fF65uVpp6vGJh+eNMY0jfkTamWnk
 hGpj+YTIZ1D95ZwqHbOsrFeDv3LG4u/zPh+8sqnFenGhF44GTyEXKEUKFXh6vk2Yr6xt
 JpzoQ70Gd1RcUVvJ/rGs9loOInXowP+2u6pANy2QjM1KAji9Bs3J4gr6TmFszmd9muzi
 4ElXdcUnlyyu+qDcaqzW8P1CSMRpz5LBNdDFnx7ynaOxrlh2xq9tjGFL47sIRQVnGXJz
 fvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hkAPE20iTaOwc9pErohM8yZy/98oIfu5aMS4byydHN8=;
 b=DQpn+Hm4MF/n3ZoJ0z9q6FVV6qYeMcbeUFBKZn6AssPjPwofnDRLo5Rs6y4MrYBUNr
 l3MPEN7sYqbzm29ILWuVmg9rkxoYYa9dLgi2ImKTHni+jJwd2Br5YDWE6U1D1A+aEXlS
 WyEUNLDDAVvp5NaYrpyWngDMGk1aFk+vOSxXpfXLTiKbOdaIYcfR8oCqMzwUEfDUhwDz
 /WbnWtdh2Bgl5qhLqKCa+0a4WrSTo97dEdu6wk7iIv01xQAtOj094l/xanOi4gpWdkh7
 jqFMDlqFTc27GF3o3R3m0hsYsMx2mScY739slDGue4rRVHCUf95t81xrh0F/KN8vEIJU
 JLXA==
X-Gm-Message-State: AOAM532QOPVCpE2ADwqP5gsf8B7bAAHvmSLx0JMT0A6oePCWKV+ezrdE
 X7LyxDFEtrw1GstpQuOnv6uveZJlGeI=
X-Google-Smtp-Source: ABdhPJzjgG43iZsf/PVBCMVvJJKOWS6qLifF81VP9SMaBdVXpVK1jvrGcr1HlXkjMRgr9FuD9YJDqw==
X-Received: by 2002:a50:fd17:: with SMTP id i23mr2142492eds.54.1621280581651; 
 Mon, 17 May 2021 12:43:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd86:58d9:7c79:a095?
 ([2a02:908:1252:fb60:bd86:58d9:7c79:a095])
 by smtp.gmail.com with ESMTPSA id i19sm266291eds.65.2021.05.17.12.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 12:43:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4e8c5fd1-2a2a-c40a-29a2-a19c8c75d3d7@gmail.com>
Date: Mon, 17 May 2021 21:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.21 um 16:57 schrieb James Zhu:
> During vcn suspends, stop ring continue to receive new requests,
> and try to wait for all vcn jobs to finish gracefully.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2016459..7e9f5cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -275,9 +275,27 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   	void *ptr;
> +	int retry_max = 6;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		ring = &adev->vcn.inst[i].ring_dec;
> +		ring->sched.ready = false;
> +
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			ring = &adev->vcn.inst[i].ring_enc[j];
> +			ring->sched.ready = false;
> +		}
> +	}
> +
> +	while (retry_max--) {
> +		if (cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> +			dev_warn(adev->dev, "Waiting for left VCN job(s) to finish gracefully ...");
> +			mdelay(5);
> +		}
> +	}

Ok that just makes no sense at all.

A cancel_delayed_work_sync() call is final, you never need to call it 
more than once.

Christian.

>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
