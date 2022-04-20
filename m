Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83014C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 07:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EF310F0D5;
	Wed, 20 Apr 2022 07:47:57 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8644E10F102
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 07:47:55 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 u17-20020a05600c211100b0038eaf4cdaaeso3083953wml.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=t+jeiZFxdNWMWyggTB+eFq8AEBvCkLmkuZgw+ZA5yt8=;
 b=Er4Jluw3iZt8uuRwZMVYyVDueHGXg6NeWzHC/cjxmE2+LlnHNyJdmL83mU+w+BugO3
 uMAj+zDqpsIHCvVW8RfQc0oROw8BRh50eXiHg6GtCUErCJiU0PctLXPKuwvaZHptoKJa
 RhPHPa4cpn4A0YaRfd85V0QI+Ji/NpJg7FA3nMQI/1vZcChtZY+wgiThWgTC590AcYlW
 7/IdvRo0vSiYGH2g/dsYXmZMCe3jhDPkrXLTTvE8hGYRevqPa57pcsF6ZXeWGHnE7Rli
 4m5GhFDUA6i4DwmNv7bNZhRqRYOfwEZiJ2CjkIZZD95YfHSHOnRhkfU2tofF+4lw44BU
 4BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=t+jeiZFxdNWMWyggTB+eFq8AEBvCkLmkuZgw+ZA5yt8=;
 b=1t+RfzYGG7CaF7PK2a9Com3Ij6jtMEch9uZoj3IlY86L2r/zgInZh13+MZyfjZ0YI/
 bv6qFFBu7UlbiAjasm4XLq2UVKEGEbKJX5GYZbYA7JiWVoeuD2QpzGdZFAm3rJJqwpgp
 k317M1gmMmZobpMgpZfBnt58AMXc2ycj5aBMO/IRNiTxnangHa5el5YYtKmQLYovOnFM
 K43HSDLTuPSkW4R8qzjJ3aH2HMrlNt1qEGQyckVM/dQtig9mIolFq0mGaH3WUqk894QT
 TUxP/bQWaj7DXYEpBkLaB2kMiegsxOXHWI4RspfDf9RBgl60Y6/saJHck09Mqc45fnE2
 ZGbg==
X-Gm-Message-State: AOAM531dGWKckb3w9xIVxDJI7Qtihx0MVJxY1Ajul93j4YDNVUwgRdtF
 B0O8LD5PkKi3UKgYgklKqP8=
X-Google-Smtp-Source: ABdhPJz1HyeRbAJgxAhpOzqbDNsSrp3y7h4hJ9ibMumyRzI7kAHFPLAS7cDR12lW0c7HJE6DBfX5tw==
X-Received: by 2002:a05:600c:3d0f:b0:38e:bc5f:5515 with SMTP id
 bh15-20020a05600c3d0f00b0038ebc5f5515mr2319625wmb.128.1650440873896; 
 Wed, 20 Apr 2022 00:47:53 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 u5-20020adfed45000000b00207a480e6aasm14637927wro.116.2022.04.20.00.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 00:47:53 -0700 (PDT)
Message-ID: <84859d0f-961a-e743-2073-fb9e0143e850@gmail.com>
Date: Wed, 20 Apr 2022 09:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Execute IP's hw_fini when hw_init failed
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Alice Wong <shiwei.wong@amd.com>
References: <20220419193751.1856508-1-shiwei.wong@amd.com>
 <CADnq5_P=a8kn2R8PEy+A+8ZMx56iLoLD50k-h2C28mim-VAUqQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_P=a8kn2R8PEy+A+8ZMx56iLoLD50k-h2C28mim-VAUqQ@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.04.22 um 21:59 schrieb Alex Deucher:
> On Tue, Apr 19, 2022 at 3:38 PM Alice Wong <shiwei.wong@amd.com> wrote:
>> amdgpu_device_ip_hw_init_phase1 and amdgpu_device_ip_hw_init_phase2
>> call IP blocks' respective hw_fini when hw_init failed.
> I don't think we should call hw_fini() if hw_init() failed.  If there
> are things that are not properly cleaned up in hw_init() fail cases,
> those should be fixed in the relevant hw_init callbacks.

I agree. That doesn't looks like good design to me.

Each IP block should cleanup themselves when their hw_init fails.

Only the previously initialized blocks should be cleaned up by the 
common framework.

Regards,
Christian.

>
> Alex
>
>> BUG:SWDEV-332449
>> Signed-off-by: Alice Wong <shiwei.wong@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ec38517ab33f..3abe647bbd2a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2281,6 +2281,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>>                          if (r) {
>>                                  DRM_ERROR("hw_init of IP block <%s> failed %d\n",
>>                                            adev->ip_blocks[i].version->funcs->name, r);
>> +                               adev->ip_blocks[i].version->funcs->hw_fini(adev);
>>                                  return r;
>>                          }
>>                          adev->ip_blocks[i].status.hw = true;
>> @@ -2303,6 +2304,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
>>                  if (r) {
>>                          DRM_ERROR("hw_init of IP block <%s> failed %d\n",
>>                                    adev->ip_blocks[i].version->funcs->name, r);
>> +                       adev->ip_blocks[i].version->funcs->hw_fini(adev);
>>                          return r;
>>                  }
>>                  adev->ip_blocks[i].status.hw = true;
>> --
>> 2.25.1
>>

