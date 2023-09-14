Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF7CEDE986
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 06:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7095710E253;
	Thu, 14 Sep 2023 06:24:01 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63B910E253
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 06:23:59 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31fc91d5ca6so555413f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694672638; x=1695277438; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqy5cwN0LTnrFIBTaYrfFf1QTGbY5nnnR5m7Z0q4bls=;
 b=rn6bqI76CRmK8cZhem4Gh5k3RMG24uKUiB8BRjAOmyRTEnMsH7oJ6urMtB3+lftnd5
 rFD1ISRNC35NzucUJ1BS1DnDk/wFOGx2TFHKoWFHP4ysSZgVo7jFXkM6hZFoaKBZLIDV
 NGqPtbREHG81af7HA3Ib5awOtEVNC7yUwffDLK8Oqr1dPexshGXRdMpWtkhkw+ReC18s
 Vg5tl5BRzJfw0Lk9jksolXSFaW9TgdI0UYM3YXCAm5E7OPeEZnIVEQ3Ecd5Zu8pSCZqF
 xNtac9KgdDMbem85DSJfV1GhPU8W3xm+flN79RS2Kimeerrc/oaZyHuz/Ep6Yo83pq6z
 Gckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672638; x=1695277438;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqy5cwN0LTnrFIBTaYrfFf1QTGbY5nnnR5m7Z0q4bls=;
 b=lGuRnDMOFO7HleA46NjxOOJHjzVRica6i4nlcej7czCeVNod9jgQEm4YyPVH7Krtnu
 IU3xvS/svj865kQ2d0BPrPxDJzjMF20y1/feiW+8ftJMeLZuFEFMC3PlCrQOmZvq7nlA
 42UgOD3wto9l3iKEsh3wNUrq3QQ1yME+GncIdLaBwnHCdszaLCEQyISIpNESOK+3x80G
 kvnDJhhjWRwNm8LSk2XwZA3e+4iLxaVlEMI26kNtUBE930E7q11j7TrS8X70yEJPT0Yu
 GPcLUmjRrAPLCtiH4peOK7X6egz0cPrVi037Y9LR2CffRinc/w607cTzr3EEj2Qagny3
 eE7g==
X-Gm-Message-State: AOJu0YwvVK9jlzyct5+hjPiLEdWGazBxrQlTfdBKEswsPQkmiy1lDZYl
 ba5b8aNU0FBGhWkBJ1/5dWTNMLT3WlEkLw==
X-Google-Smtp-Source: AGHT+IFnEhxQBqQeF316TkvCo7T2ak3S+NO8c/a2/Mu81mM23+b0FzONOuiUfao1W1BlUBWdowXnhA==
X-Received: by 2002:a5d:4944:0:b0:315:ad00:e628 with SMTP id
 r4-20020a5d4944000000b00315ad00e628mr3587484wrs.47.1694672637465; 
 Wed, 13 Sep 2023 23:23:57 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a5d5008000000b0031f8be5b41bsm820550wrt.5.2023.09.13.23.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:23:54 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------IViCcbGdgLtGB10kUm80YvFX"
Message-ID: <2e2c730d-f8f2-cda7-74cb-91b493da8902@gmail.com>
Date: Thu, 14 Sep 2023 08:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJZ25vcmUgZmly?=
 =?UTF-8?Q?st_evction_failure_during_suspend?=
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230908033952.41872-1-xinhui.pan@amd.com>
 <9ee0c0b2-dbe8-7e47-cd64-d35b974861e3@gmail.com>
 <DM4PR12MB5165CCF46CDD5781D41920EE87F1A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <55b144a2-ce60-4f37-e5d8-a25c3b5e21ef@gmail.com>
 <DM4PR12MB516574733B83A0F3F8451A5887F0A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <303c2bbb-865c-d5da-1418-21dc803f61a3@gmail.com>
 <d9037d0e-e9fb-35f6-9e00-a2e1799bc2f6@amd.com>
 <59d9927d-5216-e2fa-22cd-205e4a35ebaa@amd.com>
 <DM4PR12MB516507AC620DD2812610C11287F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
 <DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Fan,
 Shikang" <Shikang.Fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------IViCcbGdgLtGB10kUm80YvFX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[putting Harry on BCC, sorry for the noise]

Yeah, that is clearly a bug in the KFD.

During the second eviction the hw should already be disabled, so we 
don't have any SDMA or similar to evict BOs any more and can only copy 
them with the CPU.

@Felix what workqueue do you guys use for the restore work? I've just 
double checked and on the system workqueues you explicitly need to 
specify that stuff is freezable. E.g. use system_freezable_wq instead of 
system_wq.

Alternatively as Xinhui mentioned it might be necessary to flush all 
restore work before the first eviction phase or we have the chance that 
BOs are moved back into VRAM again.

Regards,
Christian.

Am 14.09.23 um 03:54 schrieb Pan, Xinhui:
>
> [AMD Official Use Only - General]
>
>
> I just make one debug patch to show busy BO’s alloc-trace when the 
> eviction fails in suspend.
>
> And dmesg log attached.
>
> Looks like they are just kfd user Bos and locked by evict/restore work.
>
> So in kfd suspend callback, it really need to flush the evict/restore 
> work before HW fini as it do now.
>
> That is why the first very early eviction fails and the second 
> eviction succeed.
>
> Thanks
>
> xinhui
>
> *From:* Pan, Xinhui
> *Sent:* Thursday, September 14, 2023 8:02 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; 
> Wentland, Harry <Harry.Wentland@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
> <Shikang.Fan@amd.com>
> *Subject:* RE: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
> during suspend
>
> Chris,
>
> I can dump these busy BOs with their alloc/free stack later today.
>
> BTW, the two evictions and the kfd suspend are all called before 
> hw_fini. IOW, between phase 1 and phase 2. SDMA is turned only in 
> phase2. So current code works fine maybe.
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Wednesday, September 13, 2023 10:29 PM
> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; 
> amd-gfx@lists.freedesktop.org; Wentland, Harry <Harry.Wentland@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Fan, Shikang 
> <Shikang.Fan@amd.com>
> *Subject:* Re: 回复: [PATCH] drm/amdgpu: Ignore first evction failure 
> during suspend
>
> [+Harry]
>
> Am 13.09.23 um 15:54 schrieb Felix Kuehling:
>
>     On 2023-09-13 4:07, Christian König wrote:
>
>         [+Fleix]
>
>         Well that looks like quite a serious bug.
>
>         If I'm not completely mistaken the KFD work item tries to
>         restore the process by moving BOs into memory even after the
>         suspend freeze. Normally work items are frozen together with
>         the user space processes unless explicitly marked as not
>         freezable.
>
>         That this causes problem during the first eviction phase is
>         just the tip of the iceberg here. If a BO is moved into
>         invisible memory during this we wouldn't be able to get it out
>         of that in the second phase because SDMA and hw is already
>         turned off.
>
>         @Felix any idea how that can happen? Have you guys marked a
>         work item / work queue as not freezable?
>
>     We don't set anything to non-freezable in KFD.
>
>     Regards,
>       Felix
>
>         Or maybe the display guys?
>
>
> Do you guys in the display do any delayed update in a work item which 
> is marked as not-freezable?
>
> Otherwise I have absolutely no idea what's going on here.
>
> Thanks,
> Christian.
>
>
>         @Xinhui please investigate what work item that is and where
>         that is coming from. Something like "if (adev->in_suspend)
>         dump_stack();" in the right place should probably do it.
>
>         Thanks,
>         Christian.
>
>         Am 13.09.23 um 07:13 schrieb Pan, Xinhui:
>
>             [AMD Official Use Only - General]
>
>             I notice that only user space process are frozen on my
>             side.  kthread and workqueue  keeps running. Maybe some
>             kernel configs are not enabled.
>
>             I made one module which just prints something like i++
>             with mutex lock both in workqueue and kthread. I paste
>             some logs below.
>
>             [438619.696196] XH: 14 from workqueue
>
>             [438619.700193] XH: 15 from kthread
>
>             [438620.394335] PM: suspend entry (deep)
>
>             [438620.399619] Filesystems sync: 0.001 seconds
>
>             [438620.403887] PM: Preparing system for sleep (deep)
>
>             [438620.409299] Freezing user space processes
>
>             [438620.414862] Freezing user space processes completed
>             (elapsed 0.001 seconds)
>
>             [438620.421881] OOM killer disabled.
>
>             [438620.425197] Freezing remaining freezable tasks
>
>             [438620.430890] Freezing remaining freezable tasks
>             completed (elapsed 0.001 seconds)
>
>             [438620.438348] PM: Suspending system (deep)
>
>             .....
>
>             [438623.746038] PM: suspend of devices complete after
>             3303.137 msecs
>
>             [438623.752125] PM: start suspend of devices complete
>             after 3309.713 msecs
>
>             [438623.758722] PM: suspend debug: Waiting for 5 second(s).
>
>             [438623.792166] XH: 22 from kthread
>
>             [438623.824140] XH: 23 from workqueue
>
>             So BOs definitely can be in use during suspend.
>
>             Even if kthread or workqueue can be stopped with one
>             special kernel config. I think suspend can only stop the
>             workqueue with its callback finish.
>
>             otherwise something like below makes things crazy.
>
>             LOCK BO
>
>             do something
>
>             -> schedule or wait, anycode might sleep. Stopped by
>             suspend now? no, i think.
>
>             UNLOCK BO
>
>             I do tests  with  cmds below.
>
>             echo devices  > /sys/power/pm_test
>
>             echo 0  > /sys/power/pm_async
>
>             echo 1  > /sys/power/pm_print_times
>
>             echo 1 > /sys/power/pm_debug_messages
>
>             echo 1 > /sys/module/amdgpu/parameters/debug_evictions
>
>             ./kfd.sh --gtest_filter=KFDEvictTest.BasicTest
>
>             pm-suspend
>
>             thanks
>
>             xinhui
>
>             ------------------------------------------------------------------------
>
>             *发件人:*Christian König <ckoenig.leichtzumerken@gmail.com>
>             <mailto:ckoenig.leichtzumerken@gmail.com>
>             *发送时间:*2023年9月12日17:01
>             *收件人:*Pan, Xinhui <Xinhui.Pan@amd.com>
>             <mailto:Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>             <amd-gfx@lists.freedesktop.org>
>             <mailto:amd-gfx@lists.freedesktop.org>
>             *抄送:*Deucher, Alexander <Alexander.Deucher@amd.com>
>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>             <Christian.Koenig@amd.com>
>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>             *主题:*Re: [PATCH] drm/amdgpu: Ignore first evction failure
>             during suspend
>
>             When amdgpu_device_suspend() is called processes should be
>             frozen
>             already. In other words KFD queues etc... should already
>             be idle.
>
>             So when the eviction fails here we missed something
>             previously and that
>             in turn can cause tons amount of problems.
>
>             So ignoring those errors is most likely not a good idea at
>             all.
>
>             Regards,
>             Christian.
>
>             Am 12.09.23 um 02:21 schrieb Pan, Xinhui:
>             > [AMD Official Use Only - General]
>             >
>             > Oh yep, Pinned BO is moved to other LRU list, So
>             eviction fails because of other reason.
>             > I will change the comments in the patch.
>             > The problem is eviction fails as many reasons, say, BO
>             is locked.
>             > ASAIK, kfd will stop the queues and flush some
>             evict/restore work in its suspend callback. SO the first
>             eviction before kfd callback likely fails.
>             >
>             > -----Original Message-----
>             > From: Christian König <ckoenig.leichtzumerken@gmail.com>
>             <mailto:ckoenig.leichtzumerken@gmail.com>
>             > Sent: Friday, September 8, 2023 2:49 PM
>             > To: Pan, Xinhui <Xinhui.Pan@amd.com>
>             <mailto:Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>             > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>             <mailto:Alexander.Deucher@amd.com>; Koenig, Christian
>             <Christian.Koenig@amd.com>
>             <mailto:Christian.Koenig@amd.com>; Fan, Shikang
>             <Shikang.Fan@amd.com> <mailto:Shikang.Fan@amd.com>
>             > Subject: Re: [PATCH] drm/amdgpu: Ignore first evction
>             failure during suspend
>             >
>             > Am 08.09.23 um 05:39 schrieb xinhui pan:
>             >> Some BOs might be pinned. So the first eviction's
>             failure will abort
>             >> the suspend sequence. These pinned BOs will be unpined
>             afterwards
>             >> during suspend.
>             > That doesn't make much sense since pinned BOs don't
>             cause eviction failure here.
>             >
>             > What exactly is the error code you see?
>             >
>             > Christian.
>             >
>             >> Actaully it has evicted most BOs, so that should stil
>             work fine in
>             >> sriov full access mode.
>             >>
>             >> Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra
>             evict_resource call
>             >> during device_suspend.")
>             >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>             <mailto:xinhui.pan@amd.com>
>             >> ---
>             >> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>             >>    1 file changed, 5 insertions(+), 4 deletions(-)
>             >>
>             >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             >> index 5c0e2b766026..39af526cdbbe 100644
>             >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             >> @@ -4148,10 +4148,11 @@ int
>             amdgpu_device_suspend(struct drm_device
>             >> *dev, bool fbcon)
>             >>
>             >>        adev->in_suspend = true;
>             >>
>             >> -     /* Evict the majority of BOs before grabbing the
>             full access */
>             >> -     r = amdgpu_device_evict_resources(adev);
>             >> -     if (r)
>             >> -             return r;
>             >> +     /* Try to evict the majority of BOs before
>             grabbing the full access
>             >> +      * Ignore the ret val at first place as we will
>             unpin some BOs if any
>             >> +      * afterwards.
>             >> +      */
>             >> + (void)amdgpu_device_evict_resources(adev);
>             >>
>             >>        if (amdgpu_sriov_vf(adev)) {
>             >> amdgpu_virt_fini_data_exchange(adev);
>

--------------IViCcbGdgLtGB10kUm80YvFX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    [putting Harry on BCC, sorry for the noise]<br>
    <br>
    Yeah, that is clearly a bug in the KFD.<br>
    <br>
    During the second eviction the hw should already be disabled, so we
    don't have any SDMA or similar to evict BOs any more and can only
    copy them with the CPU.<br>
    <br>
    @Felix what workqueue do you guys use for the restore work? I've
    just double checked and on the system workqueues you explicitly need
    to specify that stuff is freezable. E.g. use system_freezable_wq
    instead of system_wq.<br>
    <br>
    Alternatively as Xinhui mentioned it might be necessary to flush all
    restore work before the first eviction phase or we have the chance
    that BOs are moved back into VRAM again.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 14.09.23 um 03:54 schrieb Pan,
      Xinhui:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM4PR12MB5165B9687FBB14DAEF11944187F7A@DM4PR12MB5165.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}@font-face
	{font-family:"\@Microsoft YaHei";}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">I just make one debug patch to show busy
            BO’s alloc-trace when the eviction fails in suspend.<o:p></o:p></p>
          <p class="MsoNormal">And dmesg log attached.<o:p></o:p></p>
          <p class="MsoNormal">Looks like they are just kfd user Bos and
            locked by evict/restore work.<o:p></o:p></p>
          <p class="MsoNormal">So in kfd suspend callback, it really
            need to flush the evict/restore work before HW fini as it do
            now.<o:p></o:p></p>
          <p class="MsoNormal">That is why the first very early eviction
            fails and the second eviction succeed.<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Thanks<o:p></o:p></p>
          <p class="MsoNormal">xinhui<o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Pan, Xinhui <br>
                <b>Sent:</b> Thursday, September 14, 2023 8:02 AM<br>
                <b>To:</b> Koenig, Christian
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Kuehling, Felix
                <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Wentland, Harry
                <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com">&lt;Harry.Wentland@amd.com&gt;</a><br>
                <b>Cc:</b> Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Fan, Shikang
                <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
                <b>Subject:</b> RE: <span
                  style="font-family:&quot;Microsoft
                  YaHei&quot;,sans-serif" lang="ZH-CN">
                  回复</span>: [PATCH] drm/amdgpu: Ignore first evction
                failure during suspend<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Chris,<o:p></o:p></p>
          <p class="MsoNormal">I can dump these busy BOs with their
            alloc/free stack later today.<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">BTW, the two evictions and the kfd
            suspend are all called before hw_fini. IOW, between phase 1
            and phase 2. SDMA is turned only in phase2. So current code
            works fine maybe.<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Koenig, Christian &lt;<a
                  href="mailto:Christian.Koenig@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;
                <br>
                <b>Sent:</b> Wednesday, September 13, 2023 10:29 PM<br>
                <b>To:</b> Kuehling, Felix &lt;<a
                  href="mailto:Felix.Kuehling@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Felix.Kuehling@amd.com</a>&gt;;
                Christian König &lt;<a
                  href="mailto:ckoenig.leichtzumerken@gmail.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;;
                Pan, Xinhui &lt;<a href="mailto:Xinhui.Pan@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Xinhui.Pan@amd.com</a>&gt;;
                <a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                Wentland, Harry &lt;<a
                  href="mailto:Harry.Wentland@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Harry.Wentland@amd.com</a>&gt;<br>
                <b>Cc:</b> Deucher, Alexander &lt;<a
                  href="mailto:Alexander.Deucher@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
                Fan, Shikang &lt;<a href="mailto:Shikang.Fan@amd.com"
                  moz-do-not-send="true" class="moz-txt-link-freetext">Shikang.Fan@amd.com</a>&gt;<br>
                <b>Subject:</b> Re: <span
                  style="font-family:&quot;Microsoft
                  YaHei&quot;,sans-serif" lang="ZH-CN">
                  回复</span>: [PATCH] drm/amdgpu: Ignore first evction
                failure during suspend<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt">[+Harry]<o:p></o:p></p>
          <div>
            <p class="MsoNormal">Am 13.09.23 um 15:54 schrieb Felix
              Kuehling:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <p class="MsoNormal">On 2023-09-13 4:07, Christian König
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">[+Fleix]<br>
                <br>
                Well that looks like quite a serious bug.<br>
                <br>
                If I'm not completely mistaken the KFD work item tries
                to restore the process by moving BOs into memory even
                after the suspend freeze. Normally work items are frozen
                together with the user space processes unless explicitly
                marked as not freezable.<br>
                <br>
                That this causes problem during the first eviction phase
                is just the tip of the iceberg here. If a BO is moved
                into invisible memory during this we wouldn't be able to
                get it out of that in the second phase because SDMA and
                hw is already turned off.<br>
                <br>
                @Felix any idea how that can happen? Have you guys
                marked a work item / work queue as not freezable?<o:p></o:p></p>
            </blockquote>
            <p>We don't set anything to non-freezable in KFD.<o:p></o:p></p>
            <p><o:p> </o:p></p>
            <p>Regards,<br>
                Felix<o:p></o:p></p>
            <p><o:p> </o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">Or maybe the display guys?<o:p></o:p></p>
            </blockquote>
          </blockquote>
          <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
            Do you guys in the display do any delayed update in a work
            item which is marked as not-freezable?<br>
            <br>
            Otherwise I have absolutely no idea what's going on here.<br>
            <br>
            Thanks,<br>
            Christian.<br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                @Xinhui please investigate what work item that is and
                where that is coming from. Something like "if
                (adev-&gt;in_suspend) dump_stack();" in the right place
                should probably do it.<br>
                <br>
                Thanks,<br>
                Christian.<o:p></o:p></p>
              <div>
                <p class="MsoNormal">Am 13.09.23 um 07:13 schrieb Pan,
                  Xinhui:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p style="margin:5.0pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - General]<o:p></o:p></span></p>
                <p class="MsoNormal"><o:p> </o:p></p>
                <div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                        notice that only user space process are frozen
                        on my side.  kthread and workqueue  keeps
                        running. Maybe some kernel configs are not
                        enabled.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                        made one module which just prints something like
                        i++ with mutex lock both in workqueue and
                        kthread. I paste some logs below.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.696196]
                        XH: 14 from workqueue
                        <o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438619.700193]
                          XH: 15 from kthread<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.394335]
                          PM: suspend entry (deep)<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.399619]
                          Filesystems sync: 0.001 seconds<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.403887]
                          PM: Preparing system for sleep (deep)<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.409299]
                          Freezing user space processes<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.414862]
                          Freezing user space processes completed
                          (elapsed 0.001 seconds)<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.421881]
                          OOM killer disabled.<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.425197]
                          Freezing remaining freezable tasks<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.430890]
                          Freezing remaining freezable tasks completed
                          (elapsed 0.001 seconds)<o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438620.438348]
                        PM: Suspending system (deep)<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">.....<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.746038]
                        PM: suspend of devices complete after 3303.137
                        msecs
                        <o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.752125]
                          PM: start suspend of devices complete after
                          3309.713 msecs<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.758722]
                          PM: suspend debug: Waiting for 5 second(s).<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.792166]
                          XH: 22 from kthread<o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">[438623.824140]
                        XH: 23 from workqueue<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">So
                        BOs definitely can be in use during suspend.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">Even
                        if kthread or workqueue can be stopped with one
                        special kernel config. I think suspend can only
                        stop the workqueue with its callback finish.
                        <o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">otherwise
                        something like below makes things crazy.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">LOCK
                        BO<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">do
                        something<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">   
                        -&gt; schedule or wait, anycode might sleep. 
                        Stopped by suspend now? no, i think.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">UNLOCK
                        BO<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">I
                        do tests  with  cmds below.<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                        devices  &gt; /sys/power/pm_test
                        <o:p></o:p></span></p>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                          0  &gt; /sys/power/pm_async<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                          1  &gt; /sys/power/pm_print_times<o:p></o:p></span></p>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                          1 &gt; /sys/power/pm_debug_messages<o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">echo
                        1 &gt;
                        /sys/module/amdgpu/parameters/debug_evictions<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">./kfd.sh
                        --gtest_filter=KFDEvictTest.BasicTest<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">pm-suspend<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">thanks<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">xinhui<o:p></o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div>
                    <p class="MsoNormal"><span
style="font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                  </div>
                  <div class="MsoNormal" style="text-align:center"
                    align="center">
                    <hr width="98%" size="1" align="center">
                  </div>
                  <div id="divRplyFwdMsg">
                    <p class="MsoNormal"><b><span
                          style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black"
                          lang="ZH-CN">发件人</span><span
                          style="color:black">:</span></b><span
                        style="color:black"> Christian König
                        <a
                          href="mailto:ckoenig.leichtzumerken@gmail.com"
                          moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                      </span><b><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black"
                          lang="ZH-CN">发送时间</span><span
                          style="color:black">:</span></b><span
                        style="color:black"> 2023</span><span
                        style="font-family:&quot;Microsoft
                        YaHei&quot;,sans-serif;color:black" lang="ZH-CN">年</span><span
                        style="color:black">9</span><span
                        style="font-family:&quot;Microsoft
                        YaHei&quot;,sans-serif;color:black" lang="ZH-CN">月</span><span
                        style="color:black">12</span><span
                        style="font-family:&quot;Microsoft
                        YaHei&quot;,sans-serif;color:black" lang="ZH-CN">日</span><span
                        style="color:black"> 17:01<br>
                      </span><b><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black"
                          lang="ZH-CN">收件人</span><span
                          style="color:black">:</span></b><span
                        style="color:black"> Pan, Xinhui
                        <a href="mailto:Xinhui.Pan@amd.com"
                          moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org"
                          moz-do-not-send="true"
                          class="moz-txt-link-freetext">
                          amd-gfx@lists.freedesktop.org</a> <a
                          href="mailto:amd-gfx@lists.freedesktop.org"
                          moz-do-not-send="true">
                          &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                      </span><b><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black"
                          lang="ZH-CN">抄送</span><span
                          style="color:black">:</span></b><span
                        style="color:black"> Deucher, Alexander
                        <a href="mailto:Alexander.Deucher@amd.com"
                          moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                        Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com"
                          moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                        Fan, Shikang
                        <a href="mailto:Shikang.Fan@amd.com"
                          moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                      </span><b><span style="font-family:&quot;Microsoft
                          YaHei&quot;,sans-serif;color:black"
                          lang="ZH-CN">主题</span><span
                          style="color:black">:</span></b><span
                        style="color:black"> Re: [PATCH] drm/amdgpu:
                        Ignore first evction failure during suspend</span>
                      <o:p></o:p></p>
                    <div>
                      <p class="MsoNormal"> <o:p></o:p></p>
                    </div>
                  </div>
                  <div>
                    <div>
                      <p class="MsoNormal" style="margin-bottom:12.0pt">When
                        amdgpu_device_suspend() is called processes
                        should be frozen
                        <br>
                        already. In other words KFD queues etc... should
                        already be idle.<br>
                        <br>
                        So when the eviction fails here we missed
                        something previously and that <br>
                        in turn can cause tons amount of problems.<br>
                        <br>
                        So ignoring those errors is most likely not a
                        good idea at all.<br>
                        <br>
                        Regards,<br>
                        Christian.<br>
                        <br>
                        Am 12.09.23 um 02:21 schrieb Pan, Xinhui:<br>
                        &gt; [AMD Official Use Only - General]<br>
                        &gt;<br>
                        &gt; Oh yep, Pinned BO is moved to other LRU
                        list, So eviction fails because of other reason.<br>
                        &gt; I will change the comments in the patch.<br>
                        &gt; The problem is eviction fails as many
                        reasons, say, BO is locked.<br>
                        &gt; ASAIK, kfd will stop the queues and flush
                        some evict/restore work in its suspend callback.
                        SO the first eviction before kfd callback likely
                        fails.<br>
                        &gt;<br>
                        &gt; -----Original Message-----<br>
                        &gt; From: Christian König <a
                          href="mailto:ckoenig.leichtzumerken@gmail.com"
                          moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                        &gt; Sent: Friday, September 8, 2023 2:49 PM<br>
                        &gt; To: Pan, Xinhui <a
                          href="mailto:Xinhui.Pan@amd.com"
                          moz-do-not-send="true">&lt;Xinhui.Pan@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org"
                          moz-do-not-send="true"
                          class="moz-txt-link-freetext">
                          amd-gfx@lists.freedesktop.org</a><br>
                        &gt; Cc: Deucher, Alexander <a
                          href="mailto:Alexander.Deucher@amd.com"
                          moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                        Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com"
                          moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                        Fan, Shikang
                        <a href="mailto:Shikang.Fan@amd.com"
                          moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
                        &gt; Subject: Re: [PATCH] drm/amdgpu: Ignore
                        first evction failure during suspend<br>
                        &gt;<br>
                        &gt; Am 08.09.23 um 05:39 schrieb xinhui pan:<br>
                        &gt;&gt; Some BOs might be pinned. So the first
                        eviction's failure will abort<br>
                        &gt;&gt; the suspend sequence. These pinned BOs
                        will be unpined afterwards<br>
                        &gt;&gt; during suspend.<br>
                        &gt; That doesn't make much sense since pinned
                        BOs don't cause eviction failure here.<br>
                        &gt;<br>
                        &gt; What exactly is the error code you see?<br>
                        &gt;<br>
                        &gt; Christian.<br>
                        &gt;<br>
                        &gt;&gt; Actaully it has evicted most BOs, so
                        that should stil work fine in<br>
                        &gt;&gt; sriov full access mode.<br>
                        &gt;&gt;<br>
                        &gt;&gt; Fixes: 47ea20762bb7 ("drm/amdgpu: Add
                        an extra evict_resource call<br>
                        &gt;&gt; during device_suspend.")<br>
                        &gt;&gt; Signed-off-by: xinhui pan <a
                          href="mailto:xinhui.pan@amd.com"
                          moz-do-not-send="true">&lt;xinhui.pan@amd.com&gt;</a><br>
                        &gt;&gt; ---<br>
                        &gt;&gt;   
                        drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9
                        +++++----<br>
                        &gt;&gt;    1 file changed, 5 insertions(+), 4
                        deletions(-)<br>
                        &gt;&gt;<br>
                        &gt;&gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                        &gt;&gt;
                        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
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
                        &gt;&gt; -     /* Evict the majority of BOs
                        before grabbing the full access */<br>
                        &gt;&gt; -     r =
                        amdgpu_device_evict_resources(adev);<br>
                        &gt;&gt; -     if (r)<br>
                        &gt;&gt; -             return r;<br>
                        &gt;&gt; +     /* Try to evict the majority of
                        BOs before grabbing the full access<br>
                        &gt;&gt; +      * Ignore the ret val at first
                        place as we will unpin some BOs if any<br>
                        &gt;&gt; +      * afterwards.<br>
                        &gt;&gt; +      */<br>
                        &gt;&gt; +    
                        (void)amdgpu_device_evict_resources(adev);<br>
                        &gt;&gt;<br>
                        &gt;&gt;        if (amdgpu_sriov_vf(adev)) {<br>
                        &gt;&gt;               
                        amdgpu_virt_fini_data_exchange(adev);<o:p></o:p></p>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p class="MsoNormal"><o:p> </o:p></p>
            </blockquote>
          </blockquote>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------IViCcbGdgLtGB10kUm80YvFX--
