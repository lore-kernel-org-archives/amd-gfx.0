Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C6EC38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 14:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CFE10E27F;
	Wed, 26 Oct 2022 14:38:26 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E96010E27F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 14:38:24 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-13b23e29e36so19543115fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S+8fX6A79f9sD8/3/GDvwe2Xy7TKGF4sInhMCEK7GO4=;
 b=XThFjJk8ISaXmS8GWS+s7iT+YqOhd+zSq0GAEw7hlOGudNTNZhkDmA49uTGcECbw2y
 93WMVC0zVb5j6vgEz05J5N3jWRZE7No2mS4amMiczRCm3Zo0Px7OFrWeKt4vQ5Gm1blj
 lbETLfADkPKaKfygU+BurYZwrN/xhUNw2pA448G+2RYLK4k7TV4ySvMl+Ph8dLz5i1IZ
 OOa0aA9sY6z/JBwh8pcCxKqDUwbHYyOLWAawSfP+q4SML7VbP5yBlvNDOJ0IU5yO2ze8
 JrRm3BqOrOW714EAwvyjSCL3QYQ+1EzAJ27jND9727KvMPtxuumL8DeujWX/BCyMu6Ar
 WUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+8fX6A79f9sD8/3/GDvwe2Xy7TKGF4sInhMCEK7GO4=;
 b=qbJYLo+gnFdL8xX1ObuGZe6KyecdPtDqWDkba+T7f/XehzC5lDAwub20B9nmuCRwyS
 D+OoiCotbW3BXa3xsZz9dgDKKYNmzc/1jA6E0WSnxRd0TAlbiOPVpFmTD4Y0Ra6YDMDt
 OiMfdgUZj1owoP3G34nW1bgWwV44hcm1bcb6DnY0aApJLDk3h2KFOOENfX6mvNi7g8ei
 uBHf091P/u2Zmu31s+fkB6jbnel2lfajOTalNZPd7XjbuA/eBAyHjCHlvB967s2neQ4+
 lmQXVbx5Z4JKVoM2yCpvEqunM3FmgPwBwUH+BeXxbtG9NPaE7aI42hyhv4XNz1DthA+e
 miCQ==
X-Gm-Message-State: ACrzQf1reY2u9bWY+laJVyTO9PyUM8X4slbKa9tQx03dNH4hSsUSwUNF
 RCXuaV/dQWCPugz7wRkA+WT6GJo/CUUdImxELjA=
X-Google-Smtp-Source: AMsMyM53m1CKqw009iWjpb/xcwrmJ/CktxYvS4+fma2hXg2ZWSDUnmeomzu+8MvdTN2sCp2zJQXRhTfys+dPlIsMlIQ=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr2450654oao.96.1666795103148; Wed, 26
 Oct 2022 07:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221014041456.139813-1-Asher.Song@amd.com>
 <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
 <DM4PR12MB513603C468CE9BA8DC933D118B309@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CANiD2e-jjJyycgmBUDirBD+pGjf+Etifbvj5aBa0Q8Zd=KFxOg@mail.gmail.com>
In-Reply-To: <CANiD2e-jjJyycgmBUDirBD+pGjf+Etifbvj5aBa0Q8Zd=KFxOg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Oct 2022 10:38:11 -0400
Message-ID: <CADnq5_PNhqNTnwkVTdhGXmJ=UNWwQQjuftA-zgdBXejPk4LKqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
To: Yury Zhuravlev <stalkerg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Meng, Xiaohu" <Xiaohu.Meng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Song,
 Asher" <Asher.Song@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 26, 2022 at 5:07 AM Yury Zhuravlev <stalkerg@gmail.com> wrote:
>
> Hello Asher,
>
> Thanks for the information, is it open-source tests? Can I reproduce it?
>
> Also, it seems like Radeon Instinct MI25 was released before Radeon RX Vega, is it possible that they have different PowerPlay subsystems?

Same silicon, same powerplay implementation.

Alex

> On my Vega56, all these registers from vega20 are working very well.
> Seems like we should split implementation somehow.
>
> Regards,
>
> On Wed, Oct 26, 2022 at 3:51 PM Song, Asher <Asher.Song@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>> +@Meng, Xiaohu
>>
>>
>>
>> Hi Zhuravlev,
>>
>>
>>
>> The information of test card is as following:
>>
>> Lspci name: [AMD/ATI] Vega 10 [Radeon Instinct MI25 MxGPU] (rev 05)
>>
>> Firmware: ATOM BIOS: 113-D0531800-C04
>>
>>
>>
>> When run test scripts compute-rocm-*/utils/run_rsmitst.sh, the below test cases fail.
>>
>> [  FAILED  ] 4 tests, listed below:
>>
>> [  FAILED  ] rsmitstReadOnly.TestOverdriveRead
>>
>> [  FAILED  ] rsmitstReadWrite.FanReadWrite
>>
>> [  FAILED  ] rsmitstReadWrite.TestOverdriveReadWrite
>>
>> [  FAILED  ] rsmitstReadWrite.TestPowerCapReadWrite
>>
>>
>>
>> Best Regards,
>>
>> Asher
>>
>> From: Yury Zhuravlev <stalkerg@gmail.com>
>> Sent: Wednesday, October 26, 2022 9:31 AM
>> To: Song, Asher <Asher.Song@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for vega10 properly"
>>
>>
>>
>> Hello,
>> Can you write here your card name and firmware version? Without this patch, my fan sensors are broken, and it's sensitive to my pc case with water cooling.
>> My card is:  Sapphire Pulse Radeon RX Vega 56  vd6546 SA
>> lspci name: [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
>> Firmware: ATOM BIOS: 113-376XL-UO2
>> This patch is 100% working correct on my machine, and I tested it last 2 months.
>>
>> Regards,
>>
>>
>>
>> On Fri, Oct 14, 2022 at 1:15 PM Asher Song <Asher.Song@amd.com> wrote:
>>
>> This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.
>>
>> Unfortunately, that commit causes fan monitors can't be read and written
>> properly.
>>
>> Signed-off-by: Asher Song <Asher.Song@amd.com>
>> ---
>>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
>> index 190af79f3236..dad3e3741a4e 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
>> @@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
>>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>>                 uint32_t *speed)
>>  {
>> -       struct amdgpu_device *adev = hwmgr->adev;
>> -       uint32_t duty100, duty;
>> -       uint64_t tmp64;
>> +       uint32_t current_rpm;
>> +       uint32_t percent = 0;
>>
>> -       duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
>> -                               CG_FDO_CTRL1, FMAX_DUTY100);
>> -       duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
>> -                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
>> +       if (hwmgr->thermal_controller.fanInfo.bNoFan)
>> +               return 0;
>>
>> -       if (!duty100)
>> -               return -EINVAL;
>> +       if (vega10_get_current_rpm(hwmgr, &current_rpm))
>> +               return -1;
>> +
>> +       if (hwmgr->thermal_controller.
>> +                       advanceFanControlParameters.usMaxFanRPM != 0)
>> +               percent = current_rpm * 255 /
>> +                       hwmgr->thermal_controller.
>> +                       advanceFanControlParameters.usMaxFanRPM;
>>
>> -       tmp64 = (uint64_t)duty * 255;
>> -       do_div(tmp64, duty100);
>> -       *speed = MIN((uint32_t)tmp64, 255);
>> +       *speed = MIN(percent, 255);
>>
>>         return 0;
>>  }
>> --
>> 2.25.1
