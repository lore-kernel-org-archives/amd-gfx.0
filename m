Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562ADC77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7DC10E302;
	Wed,  3 May 2023 15:22:46 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEED410E2FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:20:18 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-50b8d2eed3dso7342317a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683127217; x=1685719217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nU8TQz/UfmJsSqUVR7CrvJogTlCBUwk/yrx/4Z08it4=;
 b=ETuaXl8GykeAj7hZ7M/LwbykGRjqjN20Y99Cksu0EThzzp6wSPnmq7Zc3+5LiQO5P5
 /0JFPls3oj5+hkLPtA+GIf5anJzYjuLL+OBomlehmcwyTh8lUeWf22l1rPvDQIgzLHvU
 ItWrMP7LS79A1yFgLRGg/FwzwUnlIijY2KT9OwOaqdAv7K3pTF8GR/lQoFhyybjsBdwo
 rNtpOjmMU4JBsNmEwXT0/9MDtaYAmk+ryw7urYENa2bJo5O6arliG41AXuyu0RgD7jjg
 oRwj6dKf0UnEwyvThCZnh6CquSlmY6p+2Q7VsIH7h9NQ5DiDovnkC3Pe8NRv9F16/qlF
 hGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683127217; x=1685719217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nU8TQz/UfmJsSqUVR7CrvJogTlCBUwk/yrx/4Z08it4=;
 b=PUaCiYXIUn9l8v07k8i+s2UfrMA+kSI0CILnsn3B14z1HJWmEWn42cTDv4HIVD2ta7
 lb86OaRXttwR0aG+wTSEEL6yf3olPOnwlzz1Qdjmt4rZdaW6m8ZF5xcP0jToG9G4rsWO
 p1MuncszjvXeWmW9/azAZk/PRalB61IZmLiGGRcZ9nh2yc18pSdoIR73/Zp6Tkgt+YMh
 /G2ctirvThtyqNAXSQXm4EUMHPTHLzIg8613tLtqYOn7cxVNAk6M8fr0da0aae94vyfq
 CWkD5Ty/5s1OU/51IDtvayZRRfN9s6Wr8Ha01kRAh8jGPNvoVuG9xxN7ZprXbL864Cj+
 rUXg==
X-Gm-Message-State: AC+VfDw9OLvgXNP40lwj3oCcr91m6pCWEzHEgaPoKRWOI4tz3oQ1lsAY
 VwBpNnNKyeI0595Zz5VApqc=
X-Google-Smtp-Source: ACHHUZ54/IQlS2rgfBKWvuQUyiLwnaesMZrmfuF5zNKoM2qw7GgrzgeUL+pb08oSz+Se+5dGqwZjOA==
X-Received: by 2002:a05:6402:47:b0:509:c10d:b53d with SMTP id
 f7-20020a056402004700b00509c10db53dmr11212497edu.23.1683127216769; 
 Wed, 03 May 2023 08:20:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:130a:3ed0:3dbc:854b?
 ([2a02:908:1256:79a0:130a:3ed0:3dbc:854b])
 by smtp.gmail.com with ESMTPSA id
 z22-20020aa7c656000000b004fc01b0aa55sm818162edr.4.2023.05.03.08.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 May 2023 08:20:16 -0700 (PDT)
Message-ID: <7a3221a9-242a-7a83-f380-c1d0bd8d8c9f@gmail.com>
Date: Wed, 3 May 2023 17:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/amdgpu: drop unused function
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230427183429.599578-1-alexander.deucher@amd.com>
 <20230427183429.599578-2-alexander.deucher@amd.com>
 <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one.

Can't say much about the first one. That was just the hack because some 
bit in the IP version was re-used on SRIOV, wasn't it?

Christian.

Am 03.05.23 um 17:02 schrieb Alex Deucher:
> Ping?
>
> On Thu, Apr 27, 2023 at 2:34 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> amdgpu_discovery_get_ip_version() has not been used since
>> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
>> so drop it.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
>>   2 files changed, 50 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 76ceca05452e..b58d94dc1924 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>          return 0;
>>   }
>>
>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>> -                                   int *major, int *minor, int *revision)
>> -{
>> -       struct binary_header *bhdr;
>> -       struct ip_discovery_header *ihdr;
>> -       struct die_header *dhdr;
>> -       struct ip *ip;
>> -       uint16_t die_offset;
>> -       uint16_t ip_offset;
>> -       uint16_t num_dies;
>> -       uint16_t num_ips;
>> -       int i, j;
>> -
>> -       if (!adev->mman.discovery_bin) {
>> -               DRM_ERROR("ip discovery uninitialized\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>> -       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>> -       num_dies = le16_to_cpu(ihdr->num_dies);
>> -
>> -       for (i = 0; i < num_dies; i++) {
>> -               die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>> -               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
>> -               num_ips = le16_to_cpu(dhdr->num_ips);
>> -               ip_offset = die_offset + sizeof(*dhdr);
>> -
>> -               for (j = 0; j < num_ips; j++) {
>> -                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
>> -
>> -                       if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
>> -                               if (major)
>> -                                       *major = ip->major;
>> -                               if (minor)
>> -                                       *minor = ip->minor;
>> -                               if (revision)
>> -                                       *revision = ip->revision;
>> -                               return 0;
>> -                       }
>> -                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>> -               }
>> -       }
>> -
>> -       return -EINVAL;
>> -}
>> -
>>   static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>>   {
>>          int vcn_harvest_count = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> index 8563dd4a7dc2..63ec6924b907 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> @@ -28,8 +28,6 @@
>>   #define DISCOVERY_TMR_OFFSET    (64 << 10)
>>
>>   void amdgpu_discovery_fini(struct amdgpu_device *adev);
>> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>> -                                    int *major, int *minor, int *revision);
>>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>>
>>   #endif /* __AMDGPU_DISCOVERY__ */
>> --
>> 2.40.0
>>

