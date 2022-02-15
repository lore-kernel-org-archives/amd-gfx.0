Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC4C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 16:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408CB10E575;
	Tue, 15 Feb 2022 16:21:09 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD5410E575
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 16:21:08 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id h8so18842180ejy.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8zt9//6REOT1CPIgdNCVnYsPrknywzrZuUjDiQZQQHA=;
 b=YG5uW6yKT7Kk4EOjv+YRtafpZiOCESBskpa6MMAxZy9WdhTI4beUxNOVvgvby59m/9
 srg8s6sIlT6TT4CdwfsBo3WyRIqtNqfm8kNfZk+XZjprKc9EUh4RQAOTRXbQSazul5G1
 XMMXZ3R0EgPWThMOjbFjAK0A0v1k2XlDuWFYonkzPR7IzccPWzT84a0ossP3yQVllOU8
 3q8m4aiE8kACXsTx3QNvD/Gd3nPjY4RBWDyIEfcfMwESoG6oLEHbd6svxJLgv1KTH4j1
 m3xy5uEjlibX10Wc6YuUYGNrXRywc2k0bA2isj1tTg+FXlzisBnb9kHjrNHFc/b46DfX
 bAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8zt9//6REOT1CPIgdNCVnYsPrknywzrZuUjDiQZQQHA=;
 b=YzXscmusDLwgQbakrZt8HAwrmJDpIyjZrnXjwRoJkQ2nmgZIohjvaqgzVKKTjJd9/C
 iEhBOJL6/+AVkzsL7rQ448wrVFW2OParxG17UvdEttLFQblr+2xeE3h8CjSBiutuqnmG
 9GMqoX95GgDFoMltUugNyUKwUUJbCLwH1JhrDkpY5X8mUZX5oMOULA6X8ZUY/i0lQYP8
 oxLDiEy/XhYs0K1MdSHNKIJ1IBFz7IlMT2BHPvoJtkDvH3YIjtLBJJeNvlHcSBlmx+j1
 RjJnBRGOMkyeO2LfM8pj9VQtxDOrItZ7GUysy5yOjz+nPuTjszQFTQrkyx0x+WwiRziu
 aamg==
X-Gm-Message-State: AOAM531FfLSLV9dvXvDaqCUtzeUHUbly04fedegY9zR+ldPlsSrqFnVD
 v/sd++zexFScC1ju6APeHAE=
X-Google-Smtp-Source: ABdhPJzQNjYeqQ3MbezZjZa6LlzcR3Wxq4Lu4KQMKOVITmJaSkjD2nrEFyQ2N88az25ozc7wlIfU2w==
X-Received: by 2002:a17:906:9b87:: with SMTP id
 dd7mr3804530ejc.758.1644942066741; 
 Tue, 15 Feb 2022 08:21:06 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:94b0:e8d4:1f08:1c17?
 ([2a02:908:1252:fb60:94b0:e8d4:1f08:1c17])
 by smtp.gmail.com with ESMTPSA id q7sm78042edv.93.2022.02.15.08.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 08:21:06 -0800 (PST)
Message-ID: <ba9088ae-e7ca-ad44-e107-105ff5ec4e1c@gmail.com>
Date: Tue, 15 Feb 2022 17:21:05 +0100
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

Maybe add a comment regarding Guchun's concern. With that done feel free 
to add a Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

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

