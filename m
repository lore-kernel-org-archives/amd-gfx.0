Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F9CA5504
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 08:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD4210E479;
	Wed, 13 Sep 2023 08:07:21 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B3B10E479
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 08:07:18 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31fc91d5ca6so271557f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694592437; x=1695197237; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAPawsvgv7zabdZKXIoUQmVR7OP5TRBC1wYrQbcCaTE=;
 b=KBKPVqvOWGmjoaEBBkYMrVRDM3+gJu058JEKmcjaUx0udVe5hJoVq8hACyFHn/rjw1
 DsmzAsLPXlUDP/seapvVxTUj8R0Jrspc+7m6OQFXa4p1gUwtCylodsc9segKBgXf5g9B
 ytxtlyM8CbQaLssdyLdoqJIiLv7lcBxXaDhuEya6kNstqkaGADx/ujlm01DyrJGy5v9o
 E+b3INfz6TTGFd6x8WviwPe28r0fHC4GckXERCeJosMQCEoD6zPon/53saWk9+GdS9oI
 3Lypa6SV3L93XHTLSEmc5SIzhkiOR10qcEkC2fGsdzAYOFll11IcXjtTejyu6AZp/jTm
 D2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694592437; x=1695197237;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sAPawsvgv7zabdZKXIoUQmVR7OP5TRBC1wYrQbcCaTE=;
 b=Sar8XLsllr2qACuCYBaKksttNfQW4+YCDHMign+ILOlwVqY/Z49RpC73oh0tM9nTQY
 CDTZoLZgKswZXYtZlcG2Aktfbm8afZuIoyWvw7EuZ0ey3Uk13ESkMZFbslFij7ZD2mJv
 XMhM3XI+IT12ZUFHKuailqekQnx1AO/QxhdLTSwRRkR2tYmwT5SzOgcEgEJ4Shk3oZZJ
 YdNcoTPXdIfVgMKYc5qzDoE6uEyI473DjgzFFnIv7atsR2xFW1aIeKCg2FG3bZitCbpv
 Zfein0qePaLDFUqGaUrjmptGylrbLB0APg/y3dJiIhMLnA2veYMa/338zk6DzprjAuen
 206w==
X-Gm-Message-State: AOJu0YwkIqpW9YtCLIAdJr5IRdl9Suxsotsg/82baQpVFgl+gwuSt9Cg
 OFm2ywdtW8X6aAzAQo5w3uQ=
X-Google-Smtp-Source: AGHT+IHnNdETQqkgzpIgDem0XbHX7X6NoXK2uTaz4DCbT5RVdxgWv5CZMgefX4h39U4THw9g/O0UgQ==
X-Received: by 2002:adf:f710:0:b0:319:6fff:f2c1 with SMTP id
 r16-20020adff710000000b003196ffff2c1mr1467193wrp.38.1694592436784; 
 Wed, 13 Sep 2023 01:07:16 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a056000100500b003143867d2ebsm14813763wrx.63.2023.09.13.01.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 01:07:16 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------JB0Xrn8mDwoS2xstjdE0stiP"
Message-ID: <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
Date: Wed, 13 Sep 2023 10:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Fan, Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------JB0Xrn8mDwoS2xstjdE0stiP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[+Fleix]

Well that looks like quite a serious bug.

If I'm not completely mistaken the KFD work item tries to restore the 
process by moving BOs into memory even after the suspend freeze. 
Normally work items are frozen together with the user space processes 
unless explicitly marked as not freezable.

That this causes problem during the first eviction phase is just the tip 
of the iceberg here. If a BO is moved into invisible memory during this 
we wouldn't be able to get it out of that in the second phase because 
SDMA and hw is already turned off.

@Felix any idea how that can happen? Have you guys marked a work item / 
work queue as not freezable? Or maybe the display guys?

@Xinhui please investigate what work item that is and where that is 
coming from. Something like "if (adev->in_suspend) dump_stack();" in the 
right place should probably do it.

Thanks,
Christian.

Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>
> [AMD Official Use Only - General]
>
>
> I notice that only user space process are frozen on my side. kthread 
> and workqueue  keeps running. Maybe some kernel configs are not enabled.
> I made one module which just prints something like i++ with mutex lock 
> both in workqueue and kthread. I paste some logs below.
> [438619.696196] XH: 14 from workqueue
> [438619.700193] XH: 15 from kthread
> [438620.394335] PM: suspend entry (deep)
> [438620.399619] Filesystems sync: 0.001 seconds
> [438620.403887] PM: Preparing system for sleep (deep)
> [438620.409299] Freezing user space processes
> [438620.414862] Freezing user space processes completed (elapsed 0.001 
> seconds)
> [438620.421881] OOM killer disabled.
> [438620.425197] Freezing remaining freezable tasks
> [438620.430890] Freezing remaining freezable tasks completed (elapsed 
> 0.001 seconds)
> [438620.438348] PM: Suspending system (deep)
> .....
> [438623.746038] PM: suspend of devices complete after 3303.137 msecs
> [438623.752125] PM: start suspend of devices complete after 3309.713 msecs
> [438623.758722] PM: suspend debug: Waiting for 5 second(s).
> [438623.792166] XH: 22 from kthread
> [438623.824140] XH: 23 from workqueue
>
>
> So BOs definitely can be in use during suspend.
> Even if kthread or workqueue can be stopped with one special kernel 
> config. I think suspend can only stop the workqueue with its callback 
> finish.
> otherwise something like below makes things crazy.
> LOCK BO
> do something
>     -> schedule or wait, anycode might sleep.  Stopped by suspend now? 
> no, i think.
> UNLOCK BO
>
> I do tests  with  cmds below.
> echo devices  > /sys/power/pm_test
> echo 0  > /sys/power/pm_async
> echo 1  > /sys/power/pm_print_times
> echo 1 > /sys/power/pm_debug_messages
> echo 1 > /sys/module/amdgpu/parameters/debug_evictions
> ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
> pm-suspend
>
> thanks
> xinhui
>
>
> ------------------------------------------------------------------------
> *发件人:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *发送时间:* 2023年9月12日 17:01
> *收件人:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *抄送:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
> *主题:* Re: [PATCH] drm/amdgpu: Ignore first evction failure during 
> suspend
> When amdgpu_device_suspend() is called processes should be frozen
> already. In other words KFD queues etc... should already be idle.
>
> So when the eviction fails here we missed something previously and that
> in turn can cause tons amount of problems.
>
> So ignoring those errors is most likely not a good idea at all.
>
> Regards,
> Christian.
>
> Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
> > [AMD Official Use Only - General]
> >
> > Oh yep, Pinned BO is moved to other LRU list, So eviction fails 
> because of other reason.
> > I will change the comments in the patch.
> > The problem is eviction fails as many reasons, say, BO is locked.
> > ASAIK, kfd will stop the queues and flush some evict/restore work in 
> its suspend callback. SO the first eviction before kfd callback likely 
> fails.
> >
> > -----Original Message-----
> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
> > Sent: Friday, September 8, 2023 2:49 PM
> > To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Fan, Shikang <Shikang.Fan@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction failure during 
> suspend
> >
> > Am 08.09.23 um 05:39 schrieb xinhui pan:
> >> Some BOs might be pinned. So the first eviction's failure will abort
> >> the suspend sequence. These pinned BOs will be unpined afterwards
> >> during suspend.
> > That doesn't make much sense since pinned BOs don't cause eviction 
> failure here.
> >
> > What exactly is the error code you see?
> >
> > Christian.
> >
> >> Actaully it has evicted most BOs, so that should stil work fine in
> >> sriov full access mode.
> >>
> >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call
> >> during device_suspend.")
> >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> >> ---
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
> >>    1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index 5c0e2b766026..39af526cdbbe 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device
> >> *dev, bool fbcon)
> >>
> >>        adev->in_suspend = true;
> >>
> >> -     /* Evict the majority of BOs before grabbing the full access */
> >> -     r = amdgpu_device_evict_resources(adev);
> >> -     if (r)
> >> -             return r;
> >> +     /* Try to evict the majority of BOs before grabbing the full 
> access
> >> +      * Ignore the ret val at first place as we will unpin some 
> BOs if any
> >> +      * afterwards.
> >> +      */
> >> + (void)amdgpu_device_evict_resources(adev);
> >>
> >>        if (amdgpu_sriov_vf(adev)) {
> >> amdgpu_virt_fini_data_exchange(adev);
>

--------------JB0Xrn8mDwoS2xstjdE0stiP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    [+Fleix]<br>
    <br>
    Well that looks like quite a serious bug.<br>
    <br>
    If I'm not completely mistaken the KFD work item tries to restore
    the process by moving BOs into memory even after the suspend freeze.
    Normally work items are frozen together with the user space
    processes unless explicitly marked as not freezable.<br>
    <br>
    That this causes problem during the first eviction phase is just the
    tip of the iceberg here. If a BO is moved into invisible memory
    during this we wouldn't be able to get it out of that in the second
    phase because SDMA and hw is already turned off.<br>
    <br>
    @Felix any idea how that can happen? Have you guys marked a work
    item / work queue as not freezable? Or maybe the display guys?<br>
    <br>
    @Xinhui please investigate what work item that is and where that is
    coming from. Something like "if (adev-&gt;in_suspend) dump_stack();"
    in the right place should probably do it.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.09.23 um 07:13 schrieb Pan,
      Xinhui:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          I notice that only user space process are frozen on my side. 
          kthread and workqueue  keeps running. Maybe some kernel
          configs are not enabled.</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          I made one module which just prints something like i++ with
          mutex lock both in workqueue and kthread. I paste some logs
          below.</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted0">
          [438619.696196] XH: 14 from workqueue
          <div class="ContentPasted0">[438619.700193] XH: 15 from
            kthread</div>
          <div class="ContentPasted0">[438620.394335] PM: suspend entry
            (deep)</div>
          <div class="ContentPasted0">[438620.399619] Filesystems sync:
            0.001 seconds</div>
          <div class="ContentPasted0">[438620.403887] PM: Preparing
            system for sleep (deep)</div>
          <div class="ContentPasted0">[438620.409299] Freezing user
            space processes</div>
          <div class="ContentPasted0">[438620.414862] Freezing user
            space processes completed (elapsed 0.001 seconds)</div>
          <div class="ContentPasted0">[438620.421881] OOM killer
            disabled.</div>
          <div class="ContentPasted0">[438620.425197] Freezing remaining
            freezable tasks</div>
          <div class="ContentPasted0">[438620.430890] Freezing remaining
            freezable tasks completed (elapsed 0.001 seconds)</div>
          [438620.438348] PM: Suspending system (deep)<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          .....</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          [438623.746038] PM: suspend of devices complete after 3303.137
          msecs
          <div class="ContentPasted1">[438623.752125] PM: start suspend
            of devices complete after 3309.713 msecs</div>
          <div class="ContentPasted1">[438623.758722] PM: suspend debug:
            Waiting for 5 second(s).</div>
          <div class="ContentPasted1">[438623.792166] XH: 22 from
            kthread</div>
          [438623.824140] XH: 23 from workqueue</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          So BOs definitely can be in use during suspend.</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          Even if kthread or workqueue can be stopped with one special
          kernel config. I think suspend can only stop the workqueue
          with its callback finish.
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          otherwise something like below makes things crazy.</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          LOCK BO</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          do something<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
              -&gt; schedule or wait, anycode might sleep.  Stopped by
          suspend now? no, i think.<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted1">
          UNLOCK BO<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          I do tests  with  cmds below.<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          echo devices  &gt; /sys/power/pm_test
          <div class="ContentPasted2">echo 0  &gt; /sys/power/pm_async</div>
          <div class="ContentPasted2">echo 1  &gt;
            /sys/power/pm_print_times</div>
          <div class="ContentPasted2">echo 1 &gt;
            /sys/power/pm_debug_messages</div>
          echo 1 &gt; /sys/module/amdgpu/parameters/debug_evictions</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2 ContentPasted3">
          ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2 ContentPasted3">
          pm-suspend<br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          thanks</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          xinhui</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          <br>
        </div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont,
          Aptos_MSFontService, Calibri, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof
          ContentPasted2">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size: 11pt;
            color: rgb(0, 0, 0);" face="Calibri, sans-serif"><b>发件人:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>发送时间:</b> 2023年9月12日 17:01<br>
            <b>收件人:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>抄送:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Fan, Shikang
            <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
            <b>主题:</b> Re: [PATCH] drm/amdgpu: Ignore first evction
            failure during suspend</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText">When amdgpu_device_suspend() is
                called processes should be frozen
                <br>
                already. In other words KFD queues etc... should already
                be idle.<br>
                <br>
                So when the eviction fails here we missed something
                previously and that <br>
                in turn can cause tons amount of problems.<br>
                <br>
                So ignoring those errors is most likely not a good idea
                at all.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                &gt; [AMD Official Use Only - General]<br>
                &gt;<br>
                &gt; Oh yep, Pinned BO is moved to other LRU list, So
                eviction fails because of other reason.<br>
                &gt; I will change the comments in the patch.<br>
                &gt; The problem is eviction fails as many reasons, say,
                BO is locked.<br>
                &gt; ASAIK, kfd will stop the queues and flush some
                evict/restore work in its suspend callback. SO the first
                eviction before kfd callback likely fails.<br>
                &gt;<br>
                &gt; -----Original Message-----<br>
                &gt; From: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                &gt; Sent: Friday, September 8, 2023 2:49 PM<br>
                &gt; To: Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; Cc: Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Fan, Shikang
                <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
                &gt; Subject: Re: [PATCH] drm/amdgpu: Ignore first
                evction failure during suspend<br>
                &gt;<br>
                &gt; Am 08.09.23 um 05:39 schrieb xinhui pan:<br>
                &gt;&gt; Some BOs might be pinned. So the first
                eviction's failure will abort<br>
                &gt;&gt; the suspend sequence. These pinned BOs will be
                unpined afterwards<br>
                &gt;&gt; during suspend.<br>
                &gt; That doesn't make much sense since pinned BOs don't
                cause eviction failure here.<br>
                &gt;<br>
                &gt; What exactly is the error code you see?<br>
                &gt;<br>
                &gt; Christian.<br>
                &gt;<br>
                &gt;&gt; Actaully it has evicted most BOs, so that
                should stil work fine in<br>
                &gt;&gt; sriov full access mode.<br>
                &gt;&gt;<br>
                &gt;&gt; Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra
                evict_resource call<br>
                &gt;&gt; during device_suspend.")<br>
                &gt;&gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt;&gt; ---<br>
                &gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                9 +++++----<br>
                &gt;&gt;    1 file changed, 5 insertions(+), 4
                deletions(-)<br>
                &gt;&gt;<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt;&gt; index 5c0e2b766026..39af526cdbbe 100644<br>
                &gt;&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt;&gt; +++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt;&gt; @@ -4148,10 +4148,11 @@ int
                amdgpu_device_suspend(struct drm_device<br>
                &gt;&gt; *dev, bool fbcon)<br>
                &gt;&gt;<br>
                &gt;&gt;        adev-&gt;in_suspend = true;<br>
                &gt;&gt;<br>
                &gt;&gt; -     /* Evict the majority of BOs before
                grabbing the full access */<br>
                &gt;&gt; -     r = amdgpu_device_evict_resources(adev);<br>
                &gt;&gt; -     if (r)<br>
                &gt;&gt; -             return r;<br>
                &gt;&gt; +     /* Try to evict the majority of BOs
                before grabbing the full access<br>
                &gt;&gt; +      * Ignore the ret val at first place as
                we will unpin some BOs if any<br>
                &gt;&gt; +      * afterwards.<br>
                &gt;&gt; +      */<br>
                &gt;&gt; +    
                (void)amdgpu_device_evict_resources(adev);<br>
                &gt;&gt;<br>
                &gt;&gt;        if (amdgpu_sriov_vf(adev)) {<br>
                &gt;&gt;               
                amdgpu_virt_fini_data_exchange(adev);<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------JB0Xrn8mDwoS2xstjdE0stiP--
