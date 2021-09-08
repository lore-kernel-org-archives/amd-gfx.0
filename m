Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B62C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4DE60EE6
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 12:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF4DE60EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377998921B;
	Wed,  8 Sep 2021 12:44:03 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CDB8921B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 12:44:01 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 196-20020a1c04cd000000b002fa489ffe1fso1049568wme.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Sep 2021 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uDDoFQTKhzWpZfXJK9JEMK71rtNIX8qadTzOx/IRuWQ=;
 b=VdPXh2ste0UfGXy3eV0pfcAld70bKNKszuDFwCsNdw2poTNS7FggSowmRRwTnpYhbR
 5I7KeozjWkczKCZWxlj5VSBoZEwHYnTN70wYE3dC+A3zfv+hA7INOlmL1W6CtpiPzATi
 GBreZwiuS282hdQMydDX9lYkpiz+6g2ASInZelqC/7z/GapuALCLN5V3pwIv1euHhRND
 n0mszr5Y/e+aRU+3qXQdNjVyBBblzEMtwx279KWSaDpZ59vnibfbdB7fJxz2k3o0f/Io
 +/LlgqU2Kvr9b6WBPo2cmAhiQmanQSG+NJvFO6qA88TUxzLuEZBiQYErrC/9v7yB0Aju
 QNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uDDoFQTKhzWpZfXJK9JEMK71rtNIX8qadTzOx/IRuWQ=;
 b=THP38OCAtHNO5lZydTX/L81Jakdf2D5EYc5ElrbxG8CFA52KeOYZ56bO0fjoMINnac
 7UKWw5NfVzii1nEUq+jpDrFdZh4Qo0x5fBijOSZFocJyWWijpI1xAsrwPb4UCfD5iGbF
 tUG2DZKKwybdUTD7f98/vAc6EdnLlPPPfwP6jGM2aBiiPdwqdVqxEA+x/T2RrzcgJ1Id
 +biGN0OyGazV94UOCy94WEb7YcWVTHzHkmqVMEggvfwkHQxOPcqlGjcib4fBdP5zzBPA
 KEkvA4CUqjluBLVts96ltwyK1F/BLV7ExHSR3rCGIfu365z4RwFSiQ8B3Pe9oOnqnqp3
 2N3g==
X-Gm-Message-State: AOAM532s93otZbh9VMnHAFlthbS4o0XX04dsqsO+VRijzRUXmB6eWVjn
 UQ0SESIomJTlYlZNjPMG4Ruq0JBKdNs=
X-Google-Smtp-Source: ABdhPJw0EfKe97+snIIXdvUXmhC8IRpcsPb4KhpkJZlhH3N7wAB6Rge82zOavv8YW1h6PfPMX3/R3g==
X-Received: by 2002:a1c:9d8a:: with SMTP id g132mr3403486wme.17.1631105040220; 
 Wed, 08 Sep 2021 05:44:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e9d0:54fe:9083:60ce?
 ([2a02:908:1252:fb60:e9d0:54fe:9083:60ce])
 by smtp.gmail.com with ESMTPSA id j25sm2099096wrc.12.2021.09.08.05.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 05:43:59 -0700 (PDT)
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
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
Date: Wed, 8 Sep 2021 14:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
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

Am 08.09.21 um 12:22 schrieb Lazar, Lijo:
> On 9/8/2021 3:08 PM, Christian König wrote:
>> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>>> [AMD Official Use Only]
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at 
>>>>> warnings
>>>>>
>>>>>
>>>>>
>>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>>> warnings
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>>>>> address. Make them happy!
>>>>>>>>>
>>>>>>>>> Warning Log:
>>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>>>> [  492.654805] Call Trace:
>>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>>>> 492.658245] vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>>>
>>>>>>>> Mhm, that at least partially doesn't looks like the right 
>>>>>>>> approach to me.
>>>>>>>>
>>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>>>> version specific backend in the first place?
>>>>>>>>
>>>>>>>
>>>>>>> This is a callback meant for printing ASIC specific information to
>>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is 
>>>>>>> to the callback API.
>>>>>>>
>>>>>>>> That stuff needs to be implemented for each hardware generation 
>>>>>>>> and
>>>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>>>>
>>>>>>>
>>>>>>> Looks like the warning happened because of this usage.
>>>>>>>
>>>>>>>                   size = amdgpu_dpm_print_clock_levels(adev, 
>>>>>>> OD_SCLK, buf);
>>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>>>> OD_MCLK,
>>>>>>> buf+size);
>>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDC_CURVE, buf+size);
>>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>>> OD_RANGE,
>>>>>>> buf+size);
>>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>>>> OD_CCLK,
>>>>>>> buf+size);
>>>>>>>
>>>>>>>
>>>>>> [Yu, Lang]
>>>>>> Yes. So it is fine we just fix the caller 
>>>>>> amdgpu_get_pp_od_clk_voltage like
>>>>> following:
>>>>>>
>>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>>>         struct device_attribute *attr,
>>>>>>         char *buf)
>>>>>> {
>>>>>>     struct drm_device *ddev = dev_get_drvdata(dev);
>>>>>>     struct amdgpu_device *adev = drm_to_adev(ddev);
>>>>>>     ssize_t size, offset;
>>>>>>     int ret, i;
>>>>>>     char temp_buf[512];
>>>>>>     char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>>>
>>>>>>     if (amdgpu_in_reset(adev))
>>>>>>         return -EPERM;
>>>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>>>>         return -EPERM;
>>>>>>
>>>>>>     ret = pm_runtime_get_sync(ddev->dev);
>>>>>>     if (ret < 0) {
>>>>>>         pm_runtime_put_autosuspend(ddev->dev);
>>>>>>         return ret;
>>>>>>     }
>>>>>>
>>>>>>     offset = 0;
>>>>>>
>>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>>>         for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>>>             size = amdgpu_dpm_print_clock_levels(adev,
>>>>> clock_type[i], buf);
>>>>>>             if (offset + size > PAGE_SIZE)
>>>>>>                 break;
>>>>>>             memcpy(temp_buf + offset, buf, size);
>>>>>>             offset += size;
>>>>>>         }
>>>>>>         memcpy(buf, temp_buf, offset);
>>>>>>         size = offset;
>>>>>>     } else {
>>>>>>         size = sysfs_emit(buf, "\n");
>>>>>>     }
>>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>>>>
>>>>>>     return size;
>>>>>> }
>>>>>>
>>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe 
>>>>> another arg to
>>>>> pass offset along with buf?
>>>>>
>>>> [Yu, Lang]
>>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>>>
>>> Though it's not a problem based on codeflow, static analysis tools 
>>> might complain.
>>>
>>>> Or we just rollback to sprintf/snprintf.
>>>>
>>>
>>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took 
>>> the effort to convert these, he may have some other ideas.
>>
>> This is not what I meant. See from the design point of view the 
>> print_clock_levels() callback is the bad idea to begin with.
>>
>> What we should have instead is a callback which returns the clock as 
>> a value which is then printed in the amdgpu_get_pp_od_clk_voltage() 
>> function.
>>
>> This avoids passing around the buffer and remaining size everywhere 
>> and also guarantees that the sysfs have unified printing over all 
>> hardware generations.
>>
>
> The scenario is one node used for multiple parameters - OD_SCLK, 
> OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with 
> lots of nodes). On top of it, the parameters supported (for ex: CCLK 
> is not valid on dGPUs),  the number of levels supported etc. vary 
> across ASICs. There has to be multiple calls or the call needs to 
> return multiple values for a single parameter (for ex: up to 4, 8 or 
> 16 levels of GFXCLK depending on ASIC).

Well exactly that is questionable design for sysfs.

See the sysfs_emit() and sysfs_emit_at() functions are designed the way 
they are because you should have only one value per file, which is then 
printed at exactly one location.

Take a look at the documentation for sysfs for more details.

> I don't know the history of the callback, mostly it was considered 
> more efficient to print it directly rather than fetch and print. 
> Alex/Evan may know the details.

Yeah, somebody with a bit more background in power management needs to 
take a closer look at this here. Just keep me looped in.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>

