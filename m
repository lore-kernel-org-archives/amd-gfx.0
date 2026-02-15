Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE0E63F12
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Feb 2026 21:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468C810E09D;
	Sun, 15 Feb 2026 21:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="YkkqCQvJ";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A7A10E09D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Feb 2026 21:49:14 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c6541e35fc0so1684985a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Feb 2026 13:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771192154; cv=none;
 d=google.com; s=arc-20240605;
 b=T6cpE4uws2AY/0P9d5zPVU5HaExt5pWggUCGQTC0NAOBASFL2g/l7ZblGPVjIeXven
 4I63oc2cLbAOtQo/l/+mvW9UNGpQieflQeStWry7WWMocsvFz94hCQJ9jOsM3xQj+6Pr
 b92qvExZ+I+1Js1gGELgHwS/cB2syTXAmqTucyi9s3mfVJom7gCo8QmaU20zM/aJe+hj
 AuGme6/eb5XTvTwRby1WOqNYW1DMqMDAVu9NoNynC+6pijPUSoPMHs2jc9pA4H+NtnV0
 025aej+tDWNub5Ifh9WoJolM3cTSk1wgBAR4ouRySv462I7ipTU9RqadjaMcfks9+84P
 ueuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b34+x64vmv5NA7Iy00A0CQPvMGn1TdPL+7JrMAwEM0U=;
 fh=0d+3eJ6JzrsDX2ES3/d0aHIgfxYcTPkBThY2c300OOc=;
 b=YP0d8UAyzZKJuewuy57p2j21Ulo/3H0G1FNvkUSaHjESnYTFvsFgSDXwZX3mbUtZJc
 uU5tsWPZlBHJqlmDuuZFWajkAN8zgBoiXeocNI9Zm9iLY+OaEbZF6XLWPWOKhjWun0OZ
 Ife3aJv480GMousKuhBQy6VQKHKRYehT4bGi1rt2sbtFzugQzOHZe81yms1Pa+zgp5ZN
 7HyrpICG7hmuQuc4inDk5gxZZbhE2SAtrLVo5EPAK9VkVm0v8S0AWidYBHL+okzXfVsF
 q7wrOuXkEvIY//cs2o70v4q+3hpaDoT8rGwYPcXDkNdtjmrHqKPcOiMrFYulNvejNF8q
 qW2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1771192154; x=1771796954;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b34+x64vmv5NA7Iy00A0CQPvMGn1TdPL+7JrMAwEM0U=;
 b=YkkqCQvJaz9RvO4yPc0iAAQCQARpIyGtFxUhGtpzMbFgsB5X4uKdRyt82LoupChLlc
 oH13L9ntBmtRI//sIPnq+9V+hLu9r0Vg+jxxzHPf/4gUXMrRspAUrtpV4C4Q/bgVbEV2
 BfHTP29GSoBygN7iZMoW/qqwzB6QkiQhfFKJIT54w2hkCpdpKxfM5R4bn+hUAatqMAO/
 53mkilf8opXlB+mHgmVVzNAkhnBsdgv8Vv1SqNPAkHaBXBg7pD92saq1fgM2I3xK2Yq5
 gUvWpt9Nk5dLSPwNKxjteAR5MxKRjf8RPfoEgTB8SPjNpt4KVg6lACfnCyetEdNL+1Gd
 RawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771192154; x=1771796954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b34+x64vmv5NA7Iy00A0CQPvMGn1TdPL+7JrMAwEM0U=;
 b=Jl5d7kD5wrtnRsY1gesH3dAfLUMYX2VSp7nYgYOUCXjSEinNGSzJ8ngVAd3b/z0ybb
 sfV5Ma1ON6K4pSN/bEjPg+W+IxssEDF0bIfW8/HYr6IKU2vC0RNBsEWhBs20lzogQSF+
 KWL/MO0MLGyhXphyFTi8IzhI8KOoab/yvzNTuAHQuwNbgoZdrtFqj+zfk1Rz+sGVoB/q
 kcp56KVHv5aYyFTzGd5CN1PBWdzT7ruHEPwYhhqN9rnnII76ik1JaD39PrUaaC9VfW+N
 jQkUj7yLPNe6dCAoCbumqY1KCqZvpKXoNZNdFmA4Aar79KudgMqFVA8EgyQFsmZDeU6w
 nRjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtVUwet8htAvb5oWyefH8bdllQ7l8FKxPaBGYG4pEsv2+WKPjptN0tKw9bNliswkIRf7LpODLh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE+v0C8beDIkDDuW5WcnoRmBP+uaq/4QcJpIBAVORCvvJFd+AM
 WI90iDIV8xim71gxbg38iV0pxKW7ad5NYN1s5o1/xLIokfE1VnC+xO2GH03Fs6AiIOTElA4rAiG
 WkC0bIEbRm4PTf4nysbqisFP3irgKyh5ApHW3ZG86
X-Gm-Gg: AZuq6aI5SiiDgaMQybBLpVhcu3HcWwfK0wcveVtqLd6xu88Yg5N/zWxSsZylEjqe9lX
 mhjPqgr/4NbgEOsSJ6/Bqv9mEFtWHCd3uY7APY6l2jkSKfy2wG+IePi4zY5C4qpydGkiQH8QCDy
 OVFkmbZTy4k/aQWpzMJjgHmBUlhT+dYHCFCnfa6/Uacd9xWKi3TrTbXNtTHfpqxzUQKtUrfpeKo
 LD2Mic0BDhDyjNPlCYR3NrUBsBCfGij2p1+WVuFOtPZveRf0uoLvv31eze/95Y5XbrUTqAn6Lqk
 AKdUm/2okbJrifWw6Pfnvj0pibEWwd4y7ajOJ0Dn2g==
X-Received: by 2002:a17:90b:350e:b0:354:c600:1a1 with SMTP id
 98e67ed59e1d1-356aad3c9ddmr9047028a91.19.1771192154353; Sun, 15 Feb 2026
 13:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20250925130322.1633-1-christian.koenig@amd.com>
 <CAHbf0-E0DgnchE_7KqmBt9sewiN2nUPjRPBwMgR_xphQQ9JRGA@mail.gmail.com>
In-Reply-To: <CAHbf0-E0DgnchE_7KqmBt9sewiN2nUPjRPBwMgR_xphQQ9JRGA@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 15 Feb 2026 21:49:03 +0000
X-Gm-Features: AaiRm53acPM8RD-Deq0NcGIxw7TYXJ7PXtyrEkuIWghu9jJyYFoHjukxpba6Ak4
Message-ID: <CAHbf0-EajXV4Fwg-ZL3L4ZsvrTUBXULTptwa4Zz+veLqq1y_3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reduce queue timeout to 2 seconds
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000307e36064ae3cf4a"
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

--000000000000307e36064ae3cf4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Feb 2026 at 21:41, Mike Lothian <mike@fireburn.co.uk> wrote:

>
>
> On Thu, 25 Sept 2025 at 14:03, Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> There has been multiple complains that 10 seconds are usually to long.
>>
>> The original requirement for longer timeout came from compute tests on
>> AMDVLK, since that is no longer a topic reduce the timeout back to 2
>> seconds for all queues.
>>
>> While at it also remove any special handling for compute queues under
>> SRIOV or pass through.
>>
>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++----
>>  2 files changed, 48 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a77000c2e0bb..ceb3c616292c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4278,58 +4278,53 @@ static int
>> amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>         long timeout;
>>         int ret =3D 0;
>>
>> -       /*
>> -        * By default timeout for jobs is 10 sec
>> -        */
>> -       adev->compute_timeout =3D adev->gfx_timeout =3D
>> msecs_to_jiffies(10000);
>> -       adev->sdma_timeout =3D adev->video_timeout =3D adev->gfx_timeout=
;
>> +       /* By default timeout for all queues is 2 sec */
>> +       adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_timeo=
ut =3D
>> +               adev->video_timeout =3D msecs_to_jiffies(2000);
>>
>> -       if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>> -               while ((timeout_setting =3D strsep(&input, ",")) &&
>> -                               strnlen(timeout_setting,
>> AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>> -                       ret =3D kstrtol(timeout_setting, 0, &timeout);
>> -                       if (ret)
>> -                               return ret;
>> +       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>> +               return 0;
>>
>> -                       if (timeout =3D=3D 0) {
>> -                               index++;
>> -                               continue;
>> -                       } else if (timeout < 0) {
>> -                               timeout =3D MAX_SCHEDULE_TIMEOUT;
>> -                               dev_warn(adev->dev, "lockup timeout
>> disabled");
>> -                               add_taint(TAINT_SOFTLOCKUP,
>> LOCKDEP_STILL_OK);
>> -                       } else {
>> -                               timeout =3D msecs_to_jiffies(timeout);
>> -                       }
>> +       while ((timeout_setting =3D strsep(&input, ",")) &&
>> +              strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)=
)
>> {
>> +               ret =3D kstrtol(timeout_setting, 0, &timeout);
>> +               if (ret)
>> +                       return ret;
>>
>> -                       switch (index++) {
>> -                       case 0:
>> -                               adev->gfx_timeout =3D timeout;
>> -                               break;
>> -                       case 1:
>> -                               adev->compute_timeout =3D timeout;
>> -                               break;
>> -                       case 2:
>> -                               adev->sdma_timeout =3D timeout;
>> -                               break;
>> -                       case 3:
>> -                               adev->video_timeout =3D timeout;
>> -                               break;
>> -                       default:
>> -                               break;
>> -                       }
>> +               if (timeout =3D=3D 0) {
>> +                       index++;
>> +                       continue;
>> +               } else if (timeout < 0) {
>> +                       timeout =3D MAX_SCHEDULE_TIMEOUT;
>> +                       dev_warn(adev->dev, "lockup timeout disabled");
>> +                       add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
>> +               } else {
>> +                       timeout =3D msecs_to_jiffies(timeout);
>>                 }
>> -               /*
>> -                * There is only one value specified and
>> -                * it should apply to all non-compute jobs.
>> -                */
>> -               if (index =3D=3D 1) {
>> -                       adev->sdma_timeout =3D adev->video_timeout =3D
>> adev->gfx_timeout;
>> -                       if (amdgpu_sriov_vf(adev) ||
>> amdgpu_passthrough(adev))
>> -                               adev->compute_timeout =3D adev->gfx_time=
out;
>> +
>> +               switch (index++) {
>> +               case 0:
>> +                       adev->gfx_timeout =3D timeout;
>> +                       break;
>> +               case 1:
>> +                       adev->compute_timeout =3D timeout;
>> +                       break;
>> +               case 2:
>> +                       adev->sdma_timeout =3D timeout;
>> +                       break;
>> +               case 3:
>> +                       adev->video_timeout =3D timeout;
>> +                       break;
>> +               default:
>> +                       break;
>>                 }
>>         }
>>
>> +       /* When only one value specified apply it to all queues. */
>> +       if (index =3D=3D 1)
>> +               adev->gfx_timeout =3D adev->compute_timeout =3D
>> adev->sdma_timeout =3D
>> +                       adev->video_timeout =3D timeout;
>> +
>>         return ret;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index ece251cbe8c3..fe45dd1d979e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -353,22 +353,17 @@ module_param_named(svm_default_granularity,
>> amdgpu_svm_default_granularity, uint
>>   * DOC: lockup_timeout (string)
>>   * Set GPU scheduler timeout value in ms.
>>   *
>> - * The format can be [Non-Compute] or [GFX,Compute,SDMA,Video]. That is
>> there can be one or
>> - * multiple values specified. 0 and negative values are invalidated.
>> They will be adjusted
>> - * to the default timeout.
>> + * The format can be [single value] for setting all timeouts at once or
>> + * [GFX,Compute,SDMA,Video] to set individual timeouts.
>> + * Negative values mean infinity.
>>   *
>> - * - With one value specified, the setting will apply to all non-comput=
e
>> jobs.
>> - * - With multiple values specified, the first one will be for GFX.
>> - *   The second one is for Compute. The third and fourth ones are
>> - *   for SDMA and Video.
>> - *
>> - * By default(with no lockup_timeout settings), the timeout for all job=
s
>> is 10000.
>> + * By default(with no lockup_timeout settings), the timeout for all
>> queues is 2000.
>>   */
>>  MODULE_PARM_DESC(lockup_timeout,
>> -                "GPU lockup timeout in ms (default: 10000 for all jobs.=
 "
>> -                "0: keep default value. negative: infinity timeout),
>> format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
>> -                "for passthrough or sriov [all jobs] or
>> [GFX,Compute,SDMA,Video].");
>> -module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>> sizeof(amdgpu_lockup_timeout), 0444);
>> +                "GPU lockup timeout in ms (default: 2000 for all queues=
.
>> "
>> +                "0: keep default value. negative: infinity timeout),
>> format: [single value for all] or [GFX,Compute,SDMA,Video].");
>> +module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>> +                   sizeof(amdgpu_lockup_timeout), 0444);
>>
>>  /**
>>   * DOC: dpm (int)
>> --
>> 2.43.0
>>
>> Hi
>
> This patch is causing issues with running:
>
>   ~/GravityMark_1.89_linux $ DRI_PRIME=3D1 ./run_fullscreen_vk_rt.sh
>
> M:      0 us: ../data.zip: 313 files
> M:  15.19 ms: Temporal antialiasing
> M:  15.21 ms: Fullscreen mode
> M:  15.22 ms: Render Statistics
> M:  20.77 ms: Build Date: Jun 20 2025
> M:  20.80 ms: Build Info: version=3D20250429; linux; x64; release; vk=3D1=
;
> gl=3D45; gles=3D32; cu=3D1; fusion
> M:  20.81 ms: Build Version: 1.89
> M:  48.06 ms: Name: ASUSTeK COMPUTER INC. G513QY ROG Strix G513QY_G513QY
> M:  48.09 ms: System: 'Gentoo Linux'
> M:  48.10 ms: Kernel: Linux 6.19.0-rc7-drm+ x86_64
> M:  48.11 ms: Memory: 62.19 GB
> M:  48.13 ms: Uptime: 19.00 s
> M:  48.15 ms: CPU: AMD Ryzen 9 5900HX with Radeon Graphics
> M:  48.17 ms: GPU 0: [AMD/ATI] Navi 22 [Radeon RX 6700/6700 XT/6750 XT /
> 6800M/6850M XT] (rev c3)
> M:  48.18 ms: Device: VEN_1002&DEV_73DF&SUBSYS_16C21043
> M:  48.19 ms: Memory: 11.98 GB
> M:  48.21 ms: GPU 1: [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega
> Mobile Series] (rev c4)
> M:  48.22 ms: Device: VEN_1002&DEV_1638&SUBSYS_16C21043
> M:  48.23 ms: Memory: 512.00 MB
> M:  48.53 ms: Desktop: 2560x1440 1.0
> M:  48.55 ms: Screen 0: 2560x1440 0 0 eDP-1
> M:  48.57 ms: Set fullscreen mode on 0 screen
> M:  51.48 ms: Creating 2560x1440 Vulkan Window
> M: 147.88 ms: Render Size: 2560x1440
> M: 149.22 ms: Using Fetch Mode
> M: 233.88 ms: Device: AMD Radeon RX 6800M (RADV NAVI22)
> M: 233.95 ms: Vendor: AMD
> M: 233.96 ms: Version: 26.0.99
> M: 233.97 ms: DeviceID: 0x73df
> M: 234.35 ms: Group Memory: 64.00 KB
> M: 234.36 ms: Video Memory: 11.98 GB
> M: 234.37 ms: Max Uniform Size: 4.00 GB
> M: 234.38 ms: Max Storage Size: 4.00 GB
> M: 234.38 ms: Creating SceneManager
> M: 416.06 ms: Creating RenderManager
> M: 547.17 ms: Ray Tracing Mode
> M: 547.20 ms: Creating Scene
> M:   1.481 s: Creating 200,000 Asteroids
> M:   1.600 s: Updating Scene
> M:   1.751 s: GravityMark 1.89 Vulkan RT is Ready in 1.7 s
> M:   1.751 s: Starting 2560x1440 Vulkan RT Benchmark
> M:   1.751 s: Count: 1
> M:   1.752 s: Resizing 2560x1440 frame
> M:   1.753 s: Build buffer 44.74 MB
> radv/amdgpu: The CS has been cancelled because the context is lost. This
> context is guilty of a hard recovery.
> E:   4.151 s: VK::error(): device lost
> E:   4.152 s: VKContext::Frame::submit(): can't submit command buffer
> E:   4.152 s: VKContext::submit(): can't submit frame
> E:   4.152 s: VKWindow::present(): can't submit context
> E:   4.152 s: GravityMark::render(): can't present window
> E:   9.347 s: VK::error(): device lost
> E:   9.347 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.347 s: VKContext::finish(): can't wait frame
> E:   9.347 s: VK::error(): device lost
> E:   9.347 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.347 s: VKContext::finish(): can't wait frame
> E:   9.347 s: VK::error(): device lost
> E:   9.347 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.347 s: VKContext::finish(): can't wait frame
> E:   9.347 s: VKWindow::finish(): can't finish context
> M:   9.347 s: Clearing Scene
> E:   9.575 s: VK::error(): device lost
> E:   9.575 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.575 s: VKContext::finish(): can't wait frame
> M:   9.575 s: Restore fullscreen mode on 0 screen
> E:   9.583 s: VK::error(): device lost
> E:   9.583 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.583 s: VKContext::finish(): can't wait frame
> E:   9.583 s: VK::error(): device lost
> E:   9.583 s: VKContext::Frame::wait(): can't wait for fence
> E:   9.583 s: VKContext::finish(): can't wait frame
>
>
> It's only the full screen and RT that seem to have issues
>
> Dmesg:
>
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: [drm] PCIE GART of 512M
> enabled (table at 0x00000082FEB00000).
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> PSP is resuming...
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> reserve 0xa00000 from 0x82fd000000 for PSP TMR
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> RAS: optional ras ta ucode is not available
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> SECUREDISPLAY: optional securedisplay ta ucode is not available
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resuming...
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> smu driver if version =3D 0x0000000e, smu fw if version =3D 0x00000012, s=
mu fw
> program =3D 0, version =3D 0x00413f00 (65.63.0)
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU driver if version not matched
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> Setting new power limit is not supported!
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resumed successfully!
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> kiq ring mec 2 pipe 1 q 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> [drm] DMUB hardware initialized: version=3D0x02020021
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: [drm]
> Cannot find any crtc or sizes
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring gfx_0.1.0 uses VM inv eng 1 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.0.0 uses VM inv eng 4 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.1.0 uses VM inv eng 5 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.2.0 uses VM inv eng 6 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.3.0 uses VM inv eng 7 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.0.1 uses VM inv eng 8 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.1.1 uses VM inv eng 9 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.2.1 uses VM inv eng 10 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring comp_1.3.1 uses VM inv eng 11 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring kiq_0.2.1.0 uses VM inv eng 12 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring sdma0 uses VM inv eng 13 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring sdma1 uses VM inv eng 14 on hub 0
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring vcn_dec_0 uses VM inv eng 0 on hub 8
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring vcn_enc_0.0 uses VM inv eng 1 on hub 8
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring vcn_enc_0.1 uses VM inv eng 4 on hub 8
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring jpeg_dec uses VM inv eng 5 on hub 8
> Feb 15 21:16:13 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: [drm]
> Cannot find any crtc or sizes
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> Dumping IP State
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> Dumping IP State Completed
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> [drm] AMDGPU device coredump file has been created
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> [drm] Check your /sys/class/drm/card0/device/devcoredump/data
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> ring gfx_0.0.0 timeout, signaled seq=3D99, emitted seq=3D100
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
>  Process GravityMark.x64 pid 1794 thread GravityMark.x64 pid 1794
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> Starting gfx_0.0.0 ring reset
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: amdgpu:
> Ring gfx_0.0.0 reset succeeded
> Feb 15 21:16:17 axion.fireburn.co.uk kernel: amdgpu 0000:03:00.0: [drm]
> device wedged, but recovered through reset
>
> I got things working with this patch:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c7f44422939f..5a3f02a26192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4206,7 +4206,7 @@ static int
> amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>
>        /* By default timeout for all queues is 2 sec */
>        adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_timeout=
 =3D
> -               adev->video_timeout =3D msecs_to_jiffies(2000);
> +               adev->video_timeout =3D msecs_to_jiffies(5000);
>
>        if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>                return 0;
>
>
Also 3000 works too

--000000000000307e36064ae3cf4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 15 Feb =
2026 at 21:41, Mike Lothian &lt;<a href=3D"mailto:mike@fireburn.co.uk">mike=
@fireburn.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, 25 Sept 2025 at 14:03, Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">There has been multiple complains that 10 seconds are usually to long.<b=
r>
<br>
The original requirement for longer timeout came from compute tests on<br>
AMDVLK, since that is no longer a topic reduce the timeout back to 2<br>
seconds for all queues.<br>
<br>
While at it also remove any special handling for compute queues under<br>
SRIOV or pass through.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++-----------=
-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 =C2=A0 | 21 ++----<br>
=C2=A02 files changed, 48 insertions(+), 58 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a77000c2e0bb..ceb3c616292c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -4278,58 +4278,53 @@ static int amdgpu_device_get_job_timeout_settings(s=
truct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long timeout;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * By default timeout for jobs is 10 sec<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;compute_timeout =3D adev-&gt;gfx_timeo=
ut =3D msecs_to_jiffies(10000);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;sdma_timeout =3D adev-&gt;video_timeou=
t =3D adev-&gt;gfx_timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* By default timeout for all queues is 2 sec *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx_timeout =3D adev-&gt;compute_timeo=
ut =3D adev-&gt;sdma_timeout =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;video_time=
out =3D msecs_to_jiffies(2000);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LEN=
GTH)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((timeout_set=
ting =3D strsep(&amp;input, &quot;,&quot;)) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strnlen(timeout_setting, AMDGPU_MAX_T=
IMEOUT_PARAM_LENGTH)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D kstrtol(timeout_setting, 0, &amp;timeout);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LE=
NGTH))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (timeout =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else if (timeout &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D MAX_SCHEDULE_TIMEOUT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(adev-&gt;dev, &quot;lockup t=
imeout disabled&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_taint(TAINT_SOFTLOCKUP, LOCKDEP_S=
TILL_OK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D msecs_to_jiffies(timeout)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((timeout_setting =3D strsep(&amp;input, =
&quot;,&quot;)) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strnlen(timeout_setting, =
AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kstrtol(tim=
eout_setting, 0, &amp;timeout);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0switch (index++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx_timeout =3D timeout;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;compute_timeout =3D timeout;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;sdma_timeout =3D timeout;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case 3:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;video_timeout =3D timeout;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout =3D=3D =
0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0index++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (timeout =
&lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0timeout =3D MAX_SCHEDULE_TIMEOUT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_warn(adev-&gt;dev, &quot;lockup timeout disabled&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0timeout =3D msecs_to_jiffies(timeout);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * There is only on=
e value specified and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it should apply =
to all non-compute jobs.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (index =3D=3D 1)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;sdma_timeout =3D adev-&gt;video_timeout =3D adev-&gt;gfx=
_timeout;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;compute_timeout =3D adev-&gt=
;gfx_timeout;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (index++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;gfx_timeout =3D timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;compute_timeout =3D timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;sdma_timeout =3D timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;video_timeout =3D timeout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* When only one value specified apply it to al=
l queues. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (index =3D=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx_timeou=
t =3D adev-&gt;compute_timeout =3D adev-&gt;sdma_timeout =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;video_timeout =3D timeout;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index ece251cbe8c3..fe45dd1d979e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -353,22 +353,17 @@ module_param_named(svm_default_granularity, amdgpu_sv=
m_default_granularity, uint<br>
=C2=A0 * DOC: lockup_timeout (string)<br>
=C2=A0 * Set GPU scheduler timeout value in ms.<br>
=C2=A0 *<br>
- * The format can be [Non-Compute] or [GFX,Compute,SDMA,Video]. That is th=
ere can be one or<br>
- * multiple values specified. 0 and negative values are invalidated. They =
will be adjusted<br>
- * to the default timeout.<br>
+ * The format can be [single value] for setting all timeouts at once or<br=
>
+ * [GFX,Compute,SDMA,Video] to set individual timeouts.<br>
+ * Negative values mean infinity.<br>
=C2=A0 *<br>
- * - With one value specified, the setting will apply to all non-compute j=
obs.<br>
- * - With multiple values specified, the first one will be for GFX.<br>
- *=C2=A0 =C2=A0The second one is for Compute. The third and fourth ones ar=
e<br>
- *=C2=A0 =C2=A0for SDMA and Video.<br>
- *<br>
- * By default(with no lockup_timeout settings), the timeout for all jobs i=
s 10000.<br>
+ * By default(with no lockup_timeout settings), the timeout for all queues=
 is 2000.<br>
=C2=A0 */<br>
=C2=A0MODULE_PARM_DESC(lockup_timeout,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;GPU lockup t=
imeout in ms (default: 10000 for all jobs. &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;0: keep defa=
ult value. negative: infinity timeout), format: for bare metal [Non-Compute=
] or [GFX,Compute,SDMA,Video]; &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;for passthro=
ugh or sriov [all jobs] or [GFX,Compute,SDMA,Video].&quot;);<br>
-module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_l=
ockup_timeout), 0444);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;GPU lockup t=
imeout in ms (default: 2000 for all queues. &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;0: keep defa=
ult value. negative: infinity timeout), format: [single value for all] or [=
GFX,Compute,SDMA,Video].&quot;);<br>
+module_param_string(lockup_timeout, amdgpu_lockup_timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeo=
f(amdgpu_lockup_timeout), 0444);<br>
<br>
=C2=A0/**<br>
=C2=A0 * DOC: dpm (int)<br>
-- <br>
2.43.0<br>
<br></blockquote><div>Hi=C2=A0</div><div><br></div><div>This patch is causi=
ng issues with running:<br><br>=C2=A0=C2=A0<span style=3D"font-family:monos=
pace;font-weight:bold;color:rgb(84,84,255)">~/GravityMark_1.89_linux $</spa=
n><span style=3D"font-family:monospace;color:rgb(0,0,0)"> DRI_PRIME=3D1 ./r=
un_fullscreen_vk_rt.sh<br><br></span><span style=3D"font-family:monospace">=
<span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A00 us: ../=
data.zip: 313 files</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A015.19 ms: Temporal ant=
ialiasing</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A015.21 ms: Fullscreen m=
ode</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A015.22 ms: Render Stati=
stics</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A020.77 ms: Build Date: =
Jun 20 2025</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A020.80 ms: Build Info: =
version=3D20250429; linux; x64; release; vk=3D1; gl=3D45; gles=3D32; cu=3D1=
; fusion</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A020.81 ms: Build Versio=
n: 1.89</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.06 ms: Name: ASUSTe=
K COMPUTER INC. G513QY ROG Strix G513QY_G513QY</span><span style=3D"color:r=
gb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.09 ms: System: &#39=
;Gentoo Linux&#39;</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.10 ms: Kernel: Linu=
x 6.19.0-rc7-drm+ x86_64</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.11 ms: Memory: 62.1=
9 GB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.13 ms: Uptime: 19.0=
0 s</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.15 ms: CPU: AMD Ryz=
en 9 5900HX with Radeon Graphics</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.17 ms: GPU 0: [AMD/=
ATI] Navi 22 [Radeon RX 6700/6700 XT/6750 XT / 6800M/6850M XT] (rev c3)</sp=
an><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.18 ms: Device: VEN_=
1002&amp;DEV_73DF&amp;SUBSYS_16C21043</span><span style=3D"color:rgb(0,0,0)=
">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.19 ms: Memory: 11.9=
8 GB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.21 ms: GPU 1: [AMD/=
ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c4)</spa=
n><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.22 ms: Device: VEN_=
1002&amp;DEV_1638&amp;SUBSYS_16C21043</span><span style=3D"color:rgb(0,0,0)=
">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.23 ms: Memory: 512.=
00 MB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.53 ms: Desktop: 256=
0x1440 1.0</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.55 ms: Screen 0: 25=
60x1440 0 0 eDP-1</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A048.57 ms: Set fullscre=
en mode on 0 screen</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A051.48 ms: Creating 256=
0x1440 Vulkan Window</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 147.88 ms: Render Size: 2560=
x1440</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 149.22 ms: Using Fetch Mode<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 233.88 ms: Device: AMD Radeo=
n RX 6800M (RADV NAVI22)</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 233.95 ms: Vendor: AMD</span=
><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 233.96 ms: Version: 26.0.99<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 233.97 ms: DeviceID: 0x73df<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 234.35 ms: Group Memory: 64.=
00 KB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 234.36 ms: Video Memory: 11.=
98 GB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 234.37 ms: Max Uniform Size:=
 4.00 GB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 234.38 ms: Max Storage Size:=
 4.00 GB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 234.38 ms: Creating SceneMan=
ager</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 416.06 ms: Creating RenderMa=
nager</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 547.17 ms: Ray Tracing Mode<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: 547.20 ms: Creating Scene</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.481 s: Creatin=
g 200,000 Asteroids</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.600 s: Updatin=
g Scene</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.751 s: Gravity=
Mark 1.89 Vulkan RT is Ready in 1.7 s</span><span style=3D"color:rgb(0,0,0)=
">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.751 s: Startin=
g 2560x1440 Vulkan RT Benchmark</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.751 s: Count: =
1</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.752 s: Resizin=
g 2560x1440 frame</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A01.753 s: Build b=
uffer 44.74 MB</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">radv/amdgpu: The CS has been ca=
ncelled because the context is lost. This context is guilty of a hard recov=
ery.</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A04.151 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A04.152 s: VKContext::Frame::submit(): can&#39;t submit command buffer<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A04.152 s: VKContext::submit(): can&#39;t submit frame</span><span styl=
e=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A04.152 s: VKWindow::present(): can&#39;t submit context</span><span st=
yle=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A04.152 s: GravityMark::render(): can&#39;t present window</span><span =
style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::finish(): can&#39;t wait frame</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::finish(): can&#39;t wait frame</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKContext::finish(): can&#39;t wait frame</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.347 s: VKWindow::finish(): can&#39;t finish context</span><span sty=
le=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A09.347 s: Clearin=
g Scene</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.575 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.575 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.575 s: VKContext::finish(): can&#39;t wait frame</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">M: =C2=A0=C2=A09.575 s: Restore=
 fullscreen mode on 0 screen</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VKContext::finish(): can&#39;t wait frame</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VK::error(): device lost</span><span style=3D"color:rgb(0,0,=
0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VKContext::Frame::wait(): can&#39;t wait for fence</span><sp=
an style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84)">E: =C2=A0=
=C2=A09.583 s: VKContext::finish(): can&#39;t wait frame</span><br><span st=
yle=3D"color:rgb(0,0,0)">
</span><br></span></div><span style=3D"font-family:monospace"><span style=
=3D"color:rgb(0,0,0)">
</span><br>It&#39;s only the full screen and RT that seem to have issues<br=
><br>Dmesg:<br><br></span><span style=3D"font-family:monospace"><span style=
=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http://axion.fireburn.co.u=
k" target=3D"_blank">axion.fireburn.co.uk</a> kernel: [drm] PCIE GART of 51=
2M enabled (table at 0x00000082FEB00000).</span><span style=3D"color:rgb(0,=
0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: PSP is resuming...</span><span style=3D"color=
:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x82fd000000 for PSP TM=
R</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available</=
span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucod=
e is not available</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: SMU is resuming...</span><span style=3D"color=
:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: smu driver if version =3D 0x0000000e, smu fw =
if version =3D 0x00000012, smu fw program =3D 0, version =3D 0x00413f00 (65=
.63.0)</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched</span><span=
 style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 </span><span style=3D"font-weight:bold;color:rgb(255,84,84)">amdgpu 0000:0=
3:00.0: amdgpu: Setting new power limit is not supported!</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!</span><span styl=
e=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=3D0x=
02020021</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0</sp=
an><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on hub 0</sp=
an><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0</s=
pan><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0</=
span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0</=
span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 on hub 0<=
/span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0</span>=
<span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 14 on hub 0</span>=
<span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8</sp=
an><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 8</=
span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 8</=
span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 8</spa=
n><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:13 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: Dumping IP State</span><span style=3D"color:r=
gb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: Dumping IP State Completed</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: [drm] AMDGPU device coredump file has been cr=
eated</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: amdgpu: [drm] Check your /sys/class/drm/card0/device/=
devcoredump/data</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 </span><span style=3D"font-weight:bold;color:rgb(255,84,84)">amdgpu 0000:0=
3:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=3D99, emitted seq=3D10=
0</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 </span><span style=3D"font-weight:bold;color:rgb(255,84,84)">amdgpu 0000:0=
3:00.0: amdgpu: =C2=A0Process GravityMark.x64 pid 1794 thread GravityMark.x=
64 pid 1794</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 </span><span style=3D"font-weight:bold;color:rgb(255,84,84)">amdgpu 0000:0=
3:00.0: amdgpu: Starting gfx_0.0.0 ring reset</span><span style=3D"color:rg=
b(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 </span><span style=3D"font-weight:bold;color:rgb(255,84,84)">amdgpu 0000:0=
3:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded</span><span style=3D"color:r=
gb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)">Feb 15 21:16:17 <a href=3D"http=
://axion.fireburn.co.uk" target=3D"_blank">axion.fireburn.co.uk</a> kernel:=
 amdgpu 0000:03:00.0: [drm] device wedged, but recovered through reset<br><=
/span><br>I got things working with this patch:</span></div><div class=3D"g=
mail_quote"><span style=3D"font-family:monospace"><br></span></div><div cla=
ss=3D"gmail_quote"><span style=3D"font-family:monospace"><span style=3D"fon=
t-weight:bold;color:rgb(0,0,0)">diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span><span style=
=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(0,0,0)">index c7f44422=
939f..5a3f02a26192 100644</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(0,0,0)">--- a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"font-weight:bold;color:rgb(0,0,0)">+++ b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(24,178,178)">@@ -4206,7 +4206,7 @@</spa=
n><span style=3D"color:rgb(0,0,0)"> static int amdgpu_device_get_job_timeou=
t_settings(struct amdgpu_device *adev)</span><span style=3D"color:rgb(0,0,0=
)">
</span><br><span style=3D"color:rgb(0,0,0)"> </span><span style=3D"color:rg=
b(0,0,0)">=C2=A0</span><br><span style=3D"color:rgb(0,0,0)"> =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* By default timeout for all queues is 2 sec=
 */</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)"> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0adev-&gt;gfx_timeout =3D adev-&gt;compute_timeout =3D adev-&gt;=
sdma_timeout =3D</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(178,24,24)">- =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adev-&gt;video_=
timeout =3D msecs_to_jiffies(2000);</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(24,178,24)">+</span><span style=3D"colo=
r:rgb(0,0,0)"> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0</span><span style=3D"color:rgb(24,178,24)">adev-&g=
t;video_timeout =3D msecs_to_jiffies(5000);</span><span style=3D"color:rgb(=
0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)"> </span><span style=3D"color:rg=
b(0,0,0)">=C2=A0</span><br><span style=3D"color:rgb(0,0,0)"> =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_=
LENGTH))</span><span style=3D"color:rgb(0,0,0)">
</span><br><span style=3D"color:rgb(0,0,0)"> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;</span=
><br></span><span style=3D"font-family:monospace"><br></span></div></div></=
div></blockquote><div><br></div><div>Also 3000 works too=C2=A0</div></div><=
/div>

--000000000000307e36064ae3cf4a--
