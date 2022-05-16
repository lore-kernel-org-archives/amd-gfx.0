Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527EBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 19:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CA310F0B2;
	Mon, 16 May 2022 19:27:50 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F1610EF95
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 19:27:49 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id er5so6125823edb.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=rQlnES+RD1UMqMUd/pgH0kkQi69407MR/QSP1EEeAjk=;
 b=dze3uLB05ZEd3cDA2ZCG46kJ1uOX3q1FIrVIQJKv4kYK/fiNB+sDWxDZriJ+O7oHsV
 il0vkqCe3v4j+Ov6TBppfnu7h+IMNk71Afo26PNYCZw/rUlRN1fJJ5AW5UslvwG91OLj
 LsNUmlKSc1ngGM8Shbj9sLyu9LfR77Fo5ZIpGXtseohAsyaAt5ddtOizI8HpKPeCRL6C
 U5IP3NGvsiczsvlYYNW754jvZvZNq9kJnhxbI6uvxyqtUDqyd9t7smAzn4cUWHD+wb9M
 f7LvgQ5ZgxZoTQz2HCeHPPPXwkVpTd22LAgPnYNdoRiPJlNOWSK0UXwbGXj/siuSoSaK
 eInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rQlnES+RD1UMqMUd/pgH0kkQi69407MR/QSP1EEeAjk=;
 b=L0WgF//pa5xaqS9FCe8Hw44JA3mnMyF/bpg/Xi60XKDxh3hmYyRkJmPR50gRy7MhC6
 VH/lQ/L/LsR6aQpZMoQlXfDumPqSAlNXe+uTsH/Np7K6CJIgd8Z/YtzypM6Wc1YfKJs2
 zPnI/6e0PFMBJn0dCcNRhrdGzKz4kiP84dAGe4haL7ljzwvwjxMkYXvejDtAg5T3o9c6
 VUHOD98YBEFyMENfSg/5VaHH0b1M7OiuXqtp5WF0MnC2WwS28FkzAV1AkkP/HzoSUfrM
 CAFG4c+/v3th2asXdXUL1ogVfGRNB83e8eiLxQ+c6WAsH74v3v2wSTIxopXPdI9z6KfZ
 dSiQ==
X-Gm-Message-State: AOAM5326hO6Hg1TTCaULQqezGkeKCDPY+sCjMtTJctF0YU0/h4GTnqp+
 cFiIwJ90hPqhOXdB0HGxd1c=
X-Google-Smtp-Source: ABdhPJzCN8zLgACsf+e6lXT6/4UzYOfxIzN4+/0mHoOXjzJypE9OOJOzXc2bG0SOaVcrV6HYfCWYmg==
X-Received: by 2002:a05:6402:176b:b0:42a:a828:5d79 with SMTP id
 da11-20020a056402176b00b0042aa8285d79mr10388398edb.272.1652729268091; 
 Mon, 16 May 2022 12:27:48 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:3b99:3984:fa82:8f16?
 ([2a02:908:1256:79a0:3b99:3984:fa82:8f16])
 by smtp.gmail.com with ESMTPSA id
 gz27-20020a170907a05b00b006f3ef214df8sm90945ejc.94.2022.05.16.12.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 12:27:47 -0700 (PDT)
Message-ID: <6a8593c3-c9c0-a122-6953-e4b93731fa1e@gmail.com>
Date: Mon, 16 May 2022 21:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
 <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
 <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
 <28edd55e-2e11-20b9-0ee9-3fd3f3a92409@gmail.com>
 <CADnq5_OZ4Nf24rKP19WL5oourZJuasz9J=2j5ivxF_HrBzGRKg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OZ4Nf24rKP19WL5oourZJuasz9J=2j5ivxF_HrBzGRKg@mail.gmail.com>
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
Cc: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.05.22 um 20:15 schrieb Alex Deucher:
> On Mon, May 16, 2022 at 2:10 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 16.05.22 um 19:49 schrieb Ernst Sjöstrand:
>>
>> Den mån 16 maj 2022 kl 17:13 skrev Alex Deucher <alexdeucher@gmail.com>:
>>> On Sun, May 15, 2022 at 11:46 AM Ernst Sjöstrand <ernstp@gmail.com> wrote:
>>>> smatch found this problem on amd-staging-drm-next:
>>>>
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
>>>>
>>>> This is caused by:
>>>> #define AMDGPU_MAX_VCN_INSTANCES 2
>>>> #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
>>>>
>>>> Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?
>>> We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
>>> would waste some memory in the places it is used at this point).
>>> VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
>>> can't change that without breaking the firmware structure.
>>>
>>> Alex
>>
>> It would be nice to get rid of this pattern and make sure it doesn't happen again when the VCN info table is raised to 5.
>> It's very similar to the HWIP_MAX_INSTANCE issue.
>>
>>
>> No, as Alex explained that distinction is intentional.
>>
>> The firmware definition is 4 for future extensions, that doesn't mean that this is currently used.
>>
>> There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to more than 2.
> Right.  The attached patch should protect against the scenario you are
> envisioning.

Acked-by: Christian König <christian.koenig@amd.com>

>
> Alex
>
>> Regards,
>> Christian.
>>
>>
>> //E
>>
>>

