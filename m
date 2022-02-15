Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A05C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD4710E533;
	Tue, 15 Feb 2022 14:25:54 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D774710E533
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:25:53 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id z22so6852131edd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=pGVGzMlwPhVr4BgZaa5m9S62hNmUR0uTU86fKDbRntI=;
 b=PbRHo4Oocq0RI+BHaPLCmGnfK7PfBpXoQU20JVIoIpJv3AvOycP35dzuiHRGges4TN
 XdvY5MyAPF6KtEn8kSb63qsAoPuSrcNO1dyUnRk44jHgdEGtRWKEMkIInt4nlPvieWBG
 w24xz4us1wSjicGh5KrKcAC1iscN63vrALWhOxXNV+EjjsiLQUA1Eub5GLtMG+HK1f+u
 dFIRFghIGdOXCMSBm44cIEtkX/I/UKc5/FEpMSKPQnx+szBGrB1fwlpUZGAdVdwun/FX
 31JQN/mCjNsR94+G+5TZs2mXt0rdK1rmqUOTu6AtPL+DCtJK3/A51V47/t+9KUFx6HdX
 aTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pGVGzMlwPhVr4BgZaa5m9S62hNmUR0uTU86fKDbRntI=;
 b=1milBC0F1VGSjOhGx0g6kaKiE1WnlXiJDurYWdTyCuxzoM/p2+WnQe1Vt2J7kBZ6rB
 /2hXUKu1NLRXL0Z5zSp8FlDjQBiAPRhA1t4C4KdC2APrQ1FM/iWOA24LM0n+brkFJQAP
 6YNYQ7DII9t7k61V5lunmTFXK+Jum8h361mU2yKwZ3ckfk+b9o6aQFhXQomvk+LT+ia4
 ywcSh691DtzZh0sbVTzOxq3SLQZaHFjyZdg5srstxMFCS9Uwls/ujVjLmiUBRJjTu86v
 Hofqsn52riV0RLUY7ON29k8rzHgzw7CSDpxqxSkvt63Cn9dqtNDG6d0voN906R/XIA3f
 ch9g==
X-Gm-Message-State: AOAM530Bw3Wdn7mMpEtaAoQHGiUJLp8xZULZcW/Y35sop7baAsd2gQFR
 Kb0g7KCWXxpU2uXsBg+AyJg=
X-Google-Smtp-Source: ABdhPJwwGjdDgyq3shAmakOW8wKnWERY7ihlR1Wxs3jyxjp89tgNzhiNJGRqk+uD6idx69hUzoT97A==
X-Received: by 2002:aa7:d790:: with SMTP id s16mr4153634edq.53.1644935152287; 
 Tue, 15 Feb 2022 06:25:52 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:1771:accb:e45c:a51b?
 ([2a02:908:1252:fb60:1771:accb:e45c:a51b])
 by smtp.gmail.com with ESMTPSA id g2sm882196edb.12.2022.02.15.06.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 06:25:51 -0800 (PST)
Message-ID: <a0bd54e0-142c-a8e9-964f-25560e35177c@gmail.com>
Date: Tue, 15 Feb 2022 15:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220214232154.6421-1-luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.22 um 00:21 schrieb Luben Tuikov:
> Add the "harvest" field to the IP attributes in
> the IP discovery sysfs visualization, as this
> field is present in the binary data.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index c8dbdb78988ce0..0496d369504641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -393,6 +393,7 @@ struct ip_hw_instance {
>   	int hw_id;
>   	u8  num_instance;
>   	u8  major, minor, revision;
> +	u8  harvest;

Should we maybe use bool here instead?

Apart from that looks good to me.

Regards,
Christian.

>   
>   	int num_base_addresses;
>   	u32 base_addr[];
> @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>   	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
>   }
>   
> +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
> +}
> +
>   static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>   {
>   	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
> @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>   	__ATTR_RO(major),
>   	__ATTR_RO(minor),
>   	__ATTR_RO(revision),
> +	__ATTR_RO(harvest),
>   	__ATTR_RO(num_base_addresses),
>   	__ATTR_RO(base_addr),
>   };
> @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>   			ip_hw_instance->major = ip->major;
>   			ip_hw_instance->minor = ip->minor;
>   			ip_hw_instance->revision = ip->revision;
> +			ip_hw_instance->harvest = ip->harvest;
>   			ip_hw_instance->num_base_addresses = ip->num_base_address;
>   
>   			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>
> base-commit: d8604f1d237a145db48bae4ea60b85a5875df307

