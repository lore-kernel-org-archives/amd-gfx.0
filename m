Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D86C64ED8
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 16:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA0F10E433;
	Mon, 27 Feb 2023 16:17:44 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB46610E433
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 16:17:42 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id d30so28050935eda.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kreKGaO20Vm6TD4f4+G6KkSg++QHCJ84nmsBlJaDZMg=;
 b=oMZE+8GeguME4j26D0UOCWJ0wdCkYBOKYZzNyKnUsSF8kwLntv1rk2KAHntnylt+Oo
 +HpnulxjswWsnY8dphqpkgGAENLUQfVvcXPqisvo6fCjv3h28GrYnga86cG8ruObtaTS
 Kv1YYahlTZ5suHLW+by+9pS9uIDQR4lWBp1sbOCn/5HflriithFGw/I6nWMiY3h+t7Z1
 zwVpPvi1Zdz+glZ5sKDAQVtWpMsN51RPRtJ3/IZGq83DIPNQwHAcHgznaOjiifAjQwwT
 iMQbPG27oey69Z3+pxMq2gn7CpzbOYJTLwEmZaajsLEuDmjNRGy3kvXRAlB6cKkl5WVO
 B/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kreKGaO20Vm6TD4f4+G6KkSg++QHCJ84nmsBlJaDZMg=;
 b=f3fJkktSb/aYF7SZbNv8iYXE2wPFNNWm9dGFtEGengX0/lgWdsdCgxRC9DCZtfqnDR
 lxl0Fyd8jzBeDMnfcaC50RU0qiFIMmit+zvmZW6dETkYt1sWn4rtBPqfiN3GSnoDIB7v
 lhZrz5+g2oh/0YK/3Obv/mRxHN2Wj9W0o29N+etzg7k8EDvifrY8XOvnHaIrMLaGDocv
 lHdXxuk+FC6q4NS5A5ThDbZ7JcEUT+S4zF1O1vlwLYjlzuWU66P/QXlZ4g/VfFccHhNI
 eQVuiuXcV7/8MyVXcCewQsEo6MmDxVP0AdTq1gmPRULMwHdukvaStBHALu6D0fbIY9TN
 T9DQ==
X-Gm-Message-State: AO0yUKVxRpQn3kV+/PM+xtNEsEGkfo+3EaIPtPBsQ8UbOaG4O6gP1VLF
 5MCc6wvUBY2e1fwseJb0s3Q=
X-Google-Smtp-Source: AK7set+PVlp9sCIvaEmzaAn1ZQSgJtjxQMepfuSWWzgVSUHhQrO6UsqeyaCMgcoB8wwn9bVyHG3piA==
X-Received: by 2002:a17:907:7255:b0:880:3129:d84a with SMTP id
 ds21-20020a170907725500b008803129d84amr43160504ejc.60.1677514661052; 
 Mon, 27 Feb 2023 08:17:41 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:e953:cfe1:c731:6288?
 ([2a02:908:1256:79a0:e953:cfe1:c731:6288])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a1709065fd300b008ca8b62cda6sm3435339ejv.177.2023.02.27.08.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 08:17:40 -0800 (PST)
Message-ID: <6efb6a14-9538-eba1-0f54-78a5301e3782@gmail.com>
Date: Mon, 27 Feb 2023 17:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: fix return value check in kfd
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230227145201.2323-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230227145201.2323-1-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.02.23 um 15:52 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch fixes a return value check in kfd doorbell handling.
> This function should return 0(error) only when the ida_simple_get
> returns < 0(error), return > 0 is a success case.
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cbef2e147da5..38c9e1ca6691 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -280,7 +280,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   	if (!pdd->doorbell_index) {
>   		int r = kfd_alloc_process_doorbells(pdd->dev,
>   						    &pdd->doorbell_index);
> -		if (r)
> +		if (r < 0)
>   			return 0;
>   	}
>   

