Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDFCC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908A721D56
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMhxesc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908A721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EEB6EB6F;
	Wed, 19 Feb 2020 10:49:54 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3441A6EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 10:49:53 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c9so27664232wrw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=i9jyisxuQhMeDwpy89IzM5LOBSU8iAqn6ib+BJBbh4E=;
 b=oMhxesc6q8Mm20l2OnJSMFt1XWnJWvfFVfTXKMnDKEfZ6/oBOUB0g2Fcc7k075w86Y
 GHe03P+vng5l3ATDz19L5dPth6lLrpSj5vpLz0L5/3J4nY0ERfBYLdygIhRxVDAklX2+
 TGczzVA7E6ads6fLp5b/6XLBguf2Y1o+muifi7UOoYv9CdhHF4z9BLmr4v/ZgHy5PD0B
 kQP8VnUUrUp4RVTSdZ5/Br6JnvA8EIxrQYAr/wb8oQ2C9uLpq/Oq6MW9LuD5bxk//dia
 kgeGbYJwtnWj2hYm8I4TwIdcaMPHlnqHXRZfc7WU7OvKAmSYlZdl70apkg/DdAXv6JEP
 TjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=i9jyisxuQhMeDwpy89IzM5LOBSU8iAqn6ib+BJBbh4E=;
 b=FiK4aS5xjsO+f6VeGEghnbvn+zZoulGPBBp0qUqzAp5UDOoEIKIVidlmxn2+cDTXfg
 dPrB8hDnIRrY40d5ScBCZhOeq7lmFczlLYmklYGT9maXMuJDLUMnHvtTGfq3Mi9C1YTk
 4oRlkb4wFZMYn5S/mPkRDSpAk6hF1OFfH1PILesAP08nsj0iDe3KoUy5QgOpEJ4KKWsj
 b64okeT14cNxkCqyhbL+Ejr9MXxKN97CJhW65gPsTNmgJ9nruQNSZpaRdIIEMbo9JuIn
 WZ21PkhBYjWjUd1dWq7KwF6voLphv8se2yzPc7JH4/h2noq2hD/039/htCFcIZfPB1Jp
 NUfw==
X-Gm-Message-State: APjAAAVGEKZnxZF4N9gSk9Qs+cq7aBjl3IeXbCf8WlD2fkxSA6es1iVk
 C5EnWkZr90VwKZnzcD7zAE0VCD9e
X-Google-Smtp-Source: APXvYqxDK3WiWZ2yRrSw4kv9uLhGpXnUyqg6EO8fMw0aspi20LR1b5mnjWmHyjm7VuRubkCkyjtoWw==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr8632814wru.143.1582109391843; 
 Wed, 19 Feb 2020 02:49:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q14sm2391813wrj.81.2020.02.19.02.49.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 02:49:51 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
Date: Wed, 19 Feb 2020 11:49:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well of hand this patch looks like a clear NAK to me.

Returning without raising an error is certainly the wrong thing to do 
here because we just drop the necessary page table updates.

How does the entity->rq ends up as NULL in the first place?

Regards,
Christian.

Am 19.02.20 um 07:26 schrieb Zhang, Hawking:
> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: Dennis Li <Dennis.Li@amd.com>
> Sent: Wednesday, February 19, 2020 12:05
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Li, Dennis <Dennis.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
>
> check whether the queue of entity is null to avoid null pointer dereference.
>
> Change-Id: I08d56774012cf229ba2fe7a011c1359e8d1e2781
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 4cc7881f438c..67cca463ddcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -95,6 +95,9 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   	int r;
>   
>   	entity = p->direct ? &p->vm->direct : &p->vm->delayed;
> +	if (!entity->rq)
> +		return 0;
> +
>   	ring = container_of(entity->rq->sched, struct amdgpu_ring, sched);
>   
>   	WARN_ON(ib->length_dw == 0);
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
