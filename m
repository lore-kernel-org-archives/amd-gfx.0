Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D85C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 09:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A2C61131
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 09:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1A2C61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664A16E167;
	Wed,  8 Sep 2021 09:38:17 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117AD6E165
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 09:38:16 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id s24so1212019wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Sep 2021 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=V9QNwXG+jV216OvKqkcOKUGJ5tYepQiKTBuc2Epn7l8=;
 b=pAdeVLj+vJqpZynvRA5KNm0wiqisknp9cZVq5S+ff2LvUVEgGUASs+BuuyHjslzQ6D
 OwhXBuPKx9ieR/Q5LLJttVzfDAKoC2ZC4a5nycDVckVk53B2/2L9gdzDi4pIfrFEhbC/
 Thu9mipn/vGYNMza+/FnfUY0PCugTRIUYs6gCXJLuqj9qwpMajdPW5GVvf/LgdANAwf6
 JVfRLNDNryW+aCoNEGS+5DdEru6+4GEEy8KDCCmBuPVZj/hpvD99g7wIu6k0Eg69ZED1
 N1KWuSkQksZ4A5PyI5ArJUbVRpuxfD6fl4ue5A7vSq7dMN8WKC7Q2bxm4VBZ+hik+gs2
 Xx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=V9QNwXG+jV216OvKqkcOKUGJ5tYepQiKTBuc2Epn7l8=;
 b=qeowKN3YX8jOaZRrEogJWvMSaFG9/08rfqkhxP8rBO67ZJbr6GnarUrXlXRvCTmzp3
 nXZWvHSiNLihl2iXMFJwvMYbev8rctlDT9oC+c6Q1iNBVQnvtNXWm+EyQFBGWZnz68KZ
 E9fJ/jg2n1zH2KBX7pwieRAILwn8NSLt7B/vdeUAyv5tgu20IJ2qehiCMmnUOiRTcJzN
 N0H+nCzFR0veWMs8lT2S0DH+HBFE4Yx2KKroxNde4ZQHEP1UCgOxIbmslrTHpsZ+c6ZH
 GU0R+JVZIYMCt433Xsc9qpr7/RcaGge5Im6Owge1V9U3HxOkApwHTMMFvtfIe3A/L8qm
 FwzQ==
X-Gm-Message-State: AOAM530Lg4MMcOc6xjtlsbeWJNSkPpLXzjbB05MALg/ip1Eyt2xVLC9w
 i83sHxDm5UdI3t9G9t43dqY=
X-Google-Smtp-Source: ABdhPJzaAWjlHQS0stZ4TOfZ0iWuj2R9FHegUqNyKUFyrYRTm5OGCNKr+kiyXE8tJ2LBHdaGJ7LhNw==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr2566757wma.121.1631093894641; 
 Wed, 08 Sep 2021 02:38:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e9d0:54fe:9083:60ce?
 ([2a02:908:1252:fb60:e9d0:54fe:9083:60ce])
 by smtp.gmail.com with ESMTPSA id y15sm1869436wmi.18.2021.09.08.02.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 02:38:14 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 darren.powell@amd.com
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
Date: Wed, 8 Sep 2021 11:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
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

Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>
>
> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>> [AMD Official Use Only]
>>
>>
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>>
>>>
>>>
>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>> warnings
>>>>>
>>>>>
>>>>>
>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>>> address. Make them happy!
>>>>>>>
>>>>>>> Warning Log:
>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>> [  492.654805] Call Trace:
>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>> 492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>
>>>>>> Mhm, that at least partially doesn't looks like the right 
>>>>>> approach to me.
>>>>>>
>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>> version specific backend in the first place?
>>>>>>
>>>>>
>>>>> This is a callback meant for printing ASIC specific information to
>>>>> sysfs node. The buffer passed in sysfs read is passed as it is to 
>>>>> the callback API.
>>>>>
>>>>>> That stuff needs to be implemented for each hardware generation and
>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>>
>>>>>
>>>>> Looks like the warning happened because of this usage.
>>>>>
>>>>>                   size = amdgpu_dpm_print_clock_levels(adev, 
>>>>> OD_SCLK, buf);
>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>> OD_MCLK,
>>>>> buf+size);
>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>> OD_VDDC_CURVE, buf+size);
>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>> OD_RANGE,
>>>>> buf+size);
>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>> OD_CCLK,
>>>>> buf+size);
>>>>>
>>>>>
>>>> [Yu, Lang]
>>>> Yes. So it is fine we just fix the caller 
>>>> amdgpu_get_pp_od_clk_voltage like
>>> following:
>>>>
>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>         struct device_attribute *attr,
>>>>         char *buf)
>>>> {
>>>>     struct drm_device *ddev = dev_get_drvdata(dev);
>>>>     struct amdgpu_device *adev = drm_to_adev(ddev);
>>>>     ssize_t size, offset;
>>>>     int ret, i;
>>>>     char temp_buf[512];
>>>>     char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>
>>>>     if (amdgpu_in_reset(adev))
>>>>         return -EPERM;
>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>>         return -EPERM;
>>>>
>>>>     ret = pm_runtime_get_sync(ddev->dev);
>>>>     if (ret < 0) {
>>>>         pm_runtime_put_autosuspend(ddev->dev);
>>>>         return ret;
>>>>     }
>>>>
>>>>     offset = 0;
>>>>
>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>         for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>             size = amdgpu_dpm_print_clock_levels(adev,
>>> clock_type[i], buf);
>>>>             if (offset + size > PAGE_SIZE)
>>>>                 break;
>>>>             memcpy(temp_buf + offset, buf, size);
>>>>             offset += size;
>>>>         }
>>>>         memcpy(buf, temp_buf, offset);
>>>>         size = offset;
>>>>     } else {
>>>>         size = sysfs_emit(buf, "\n");
>>>>     }
>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>>
>>>>     return size;
>>>> }
>>>>
>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe 
>>> another arg to
>>> pass offset along with buf?
>>>
>> [Yu, Lang]
>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>
> Though it's not a problem based on codeflow, static analysis tools 
> might complain.
>
>> Or we just rollback to sprintf/snprintf.
>>
>
> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took the 
> effort to convert these, he may have some other ideas.

This is not what I meant. See from the design point of view the 
print_clock_levels() callback is the bad idea to begin with.

What we should have instead is a callback which returns the clock as a 
value which is then printed in the amdgpu_get_pp_od_clk_voltage() function.

This avoids passing around the buffer and remaining size everywhere and 
also guarantees that the sysfs have unified printing over all hardware 
generations.

Regards,
Christian.

