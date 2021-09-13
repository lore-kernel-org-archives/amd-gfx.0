Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3993C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13F060F26
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A13F060F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1923B6E220;
	Mon, 13 Sep 2021 19:16:40 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B016E220
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 19:16:38 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id b6so16300825wrh.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=mXwyROCmuWb9iS7m9F7lYdIusbt+guzD6obl3ISVSkk=;
 b=AdCYW06jDbzwy+zitDw+nf4IYqtxXS05bAsvmeBM3BCptwGrz1OC0d3Mqs8OP3bHyA
 SYhnDcWueEDStd7IO3+abEGoV45SZ+FIS+ywWNo1Rr8Zf1sOGiuefHqd+f7ckt29wkWg
 Z8gGRTNcZDkHz2aDjDGmAsk4gzCE6k5hCkj0L7k6Lz12kKs9NkokFK7XSlIPyCK412Pp
 stssfVRX3aT2x6GX/F8zcBgtAGmOd0pAVar5N0QMgCgE16djW96dA4GUtJg+Cd1SmoOJ
 D90tYusY1uve151iX6FhOda4C56rrDH7Pzbo7//RJOUd94xebyUKXmTMAw7QdKp474Ik
 IYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mXwyROCmuWb9iS7m9F7lYdIusbt+guzD6obl3ISVSkk=;
 b=z0SnEB6Ly2DOY68io3YJ8EQqbJIrkKsAesQRxStchtKWSx2jAS+rtSle+HGoy4JRWB
 v59+ejNKyJlvb/zSICk7Jt14nxEJAkUkHb0QnsW22x7jIOJcpo80o7ft3ybqyXlKqKpX
 zuPZ/ceJa6JbwXTAKK8bkM9bZ8be4qW96NNQ4YexZShkakL5NcJjcN6dfwy9kAak4lOA
 DOeDwcACC40UhRH7M0/vCaOzxnl04Z0C1WfkEktAo1ocNAgtG7uXNKokcUo1HzqJtjvJ
 3ql49LsTVxiFla8jGB0oW0YAL20CBpBoMH3efiNoG6kFtntAWYBED0Os+l99xvlByCuh
 hyuQ==
X-Gm-Message-State: AOAM5335NFZ7MhEM0IpI+jvpVylAq4ZfRgKL5soZcpPrh9i5XqJQE/H7
 tIDCdydHn8j0kKqLOLUjz2g=
X-Google-Smtp-Source: ABdhPJysqrmvkkRmLLI9gT0MuE7YP48cBQ5d+PyBMPrdWZnwvR/msBug1jz1F7yjaIR03AfCy2QetQ==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr14624539wrv.34.1631560597184; 
 Mon, 13 Sep 2021 12:16:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4754:a88:9347:73b3?
 ([2a02:908:1252:fb60:4754:a88:9347:73b3])
 by smtp.gmail.com with ESMTPSA id j20sm8422778wrb.5.2021.09.13.12.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 12:16:36 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Remove ununsed variable from
 amdgpu_ib_pool_init
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210913172751.2008689-1-Anson.Jacob@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d3c58706-93cf-47f4-c31c-762aaf8340c7@gmail.com>
Date: Mon, 13 Sep 2021 21:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913172751.2008689-1-Anson.Jacob@amd.com>
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

Am 13.09.21 um 19:27 schrieb Anson Jacob:
> Remove unused variable 'size'.
>
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>

Yeah, that's because of the recent change that we now use the same size 
for everything.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 9274f32c3661..bc1297dcdf97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -300,7 +300,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>    */
>   int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>   {
> -	unsigned size;
>   	int r, i;
>   
>   	if (adev->ib_pool_ready)

