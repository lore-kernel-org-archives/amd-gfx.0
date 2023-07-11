Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A7DEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 09:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1309F10E34B;
	Tue, 11 Jul 2023 09:23:01 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0853D10E34B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 09:22:58 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so5248289f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689067374; x=1691659374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oYy+/aRuK2f3V9wHeSPTMdRwpJbxoMG9SDoExcMY6lM=;
 b=KpiuKFkBZ80bM+XjHS1q2ImVG1/xhrXAsVql6gG670YZujFrgw9Cfll+94JCRdjAkA
 owKHG/qRpIQdFeZufCtvOGJTgZFnCjuewgUD4f/fdgmvZ2I9cqD2opSIEX5mx789i+D3
 k8HtWlef3nRPiqfVM8dlDE+JgWJ8U27MuGjWnOH/6mUDExxIqPDQFlhtOLi5K/Hwg9l5
 rfRwDVvY6xIHNYV5crikvAI0MopoZHoaN0hexORHchmDaBGVkp4pf/x7tCHhwnA5rrBs
 Igl3wQRfpdVoOkwOTVy+rJZpmeCkwkdX92P58qyi01cHkZSI8IBleYXuDbJn131Oso6j
 m60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689067374; x=1691659374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYy+/aRuK2f3V9wHeSPTMdRwpJbxoMG9SDoExcMY6lM=;
 b=GefaFRui2P+3JkaUieGAA4TQLTgVdysymnzDoMEeUTtgpTaBGuPNzsVL8dyXtCimfg
 pAZ90SShyMYUpFnZKVyiXwvkjbIADg9KrxVHidfCYesv+1L1kP9E4eoNmMxq1gPWYTNW
 phJ1jt3PnQ69+OuOPAPPigiqi93C6w5qAtWZOvDXllViaKf+KQLviu0gv3NCh1gVzY9k
 s3Z7ScBdNnox6x+20XJaRHmphd/iDlP2WwF2Nqkt5sEUfmVB1HRWxExC+Zc8UF4BvbWW
 xX9EA4Y5pnhgYTWNdkpVX7Yp4F0hf0tV0/GxKhJl0uGCvwB08YqPRr1K0b7R9XHXsK/F
 u4yQ==
X-Gm-Message-State: ABy/qLadCaXaDRKCPjbGaNtAKtwHyxFSDMpPZlHd+agMuPzrpCJnx2cZ
 43VcFvqtItelDApndj0L0FQ=
X-Google-Smtp-Source: APBJJlFNNNzDcsYhUo/x57DA2gpX5lV/Dtu6HHLb4X0IzMqywReVYE8tMIqxH7nGF+0cdGH9pOdmmg==
X-Received: by 2002:adf:f781:0:b0:311:1501:ba53 with SMTP id
 q1-20020adff781000000b003111501ba53mr12347765wrp.49.1689067374132; 
 Tue, 11 Jul 2023 02:22:54 -0700 (PDT)
Received: from ?IPV6:2a00:e180:154b:c600:506b:c492:754a:b750?
 ([2a00:e180:154b:c600:506b:c492:754a:b750])
 by smtp.gmail.com with ESMTPSA id
 a4-20020adfeec4000000b0030c4d8930b1sm1721814wrp.91.2023.07.11.02.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 02:22:53 -0700 (PDT)
Message-ID: <8f8d56be-eb2f-3a4d-edb6-34640faeaea2@gmail.com>
Date: Tue, 11 Jul 2023 11:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
 "Prica, Nikola" <Nikola.Prica@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
References: <20230711013831.2181718-1-guchun.chen@amd.com>
 <2a71b5c0-a79d-16e7-cba4-37018f2ebecf@gmail.com>
 <DM5PR12MB24692FEDD2317DF87B8DCD45F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB24692FEDD2317DF87B8DCD45F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
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
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.07.23 um 11:15 schrieb Chen, Guchun:
> [Public]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, July 11, 2023 5:09 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
>> gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Milinkovic, Dusica
>> <Dusica.Milinkovic@amd.com>; Prica, Nikola <Nikola.Prica@amd.com>; Cui,
>> Flora <Flora.Cui@amd.com>
>> Cc: stable@vger.kernel.org
>> Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
>> hrtimer_try_to_cancel
>>
>>
>>
>> Am 11.07.23 um 03:38 schrieb Guchun Chen:
>>> In below thousands of screen rotation loop tests with virtual display
>>> enabled, a CPU hard lockup issue may happen, leading system to
>>> unresponsive and crash.
>>>
>>> do {
>>>      xrandr --output Virtual --rotate inverted
>>>      xrandr --output Virtual --rotate right
>>>      xrandr --output Virtual --rotate left
>>>      xrandr --output Virtual --rotate normal } while (1);
>>>
>>> NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
>>>
>>> ? hrtimer_run_softirq+0x140/0x140
>>> ? store_vblank+0xe0/0xe0 [drm]
>>> hrtimer_cancel+0x15/0x30
>>> amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
>>> drm_vblank_disable_and_save+0x185/0x1f0 [drm]
>>> drm_crtc_vblank_off+0x159/0x4c0 [drm]
>>> ? record_print_text.cold+0x11/0x11
>>> ? wait_for_completion_timeout+0x232/0x280
>>> ? drm_crtc_wait_one_vblank+0x40/0x40 [drm] ?
>>> bit_wait_io_timeout+0xe0/0xe0 ?
>>> wait_for_completion_interruptible+0x1d7/0x320
>>> ? mutex_unlock+0x81/0xd0
>>> amdgpu_vkms_crtc_atomic_disable
>>>
>>> It's caused by a stuck in lock dependency in such scenario on
>>> different CPUs.
>>>
>>> CPU1                                             CPU2
>>> drm_crtc_vblank_off                              hrtimer_interrupt
>>>       grab event_lock (irq disabled)                   __hrtimer_run_queues
>>>           grab vbl_lock/vblank_time_block
>> amdgpu_vkms_vblank_simulate
>>>               amdgpu_vkms_disable_vblank                       drm_handle_vblank
>>>                   hrtimer_cancel                                         grab dev->event_lock
>>>
>>> So CPU1 stucks in hrtimer_cancel as timer callback is running endless
>>> on current clock base, as that timer queue on CPU2 has no chance to
>>> finish it because of failing to hold the lock. So NMI watchdog will
>>> throw the errors after its threshold, and all later CPUs are
>> impacted/blocked.
>>> So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
>>> does not need to wait the handler to finish. And also it's not
>>> necessary to check the return value of hrtimer_try_to_cancel, because
>>> even if it's
>>> -1 which means current timer callback is running, it will be
>>> reprogrammed in hrtimer_start with calling enable_vblank to make it works.
>>>
>>> v2: only re-arm timer when vblank is enabled (Christian) and add a
>>> Fixes tag as well
>>>
>>> v3: drop warn printing (Christian)
>>>
>>> Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 13 ++++++++++---
>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> index 53ff91fc6cf6..b870c827cbaa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>> @@ -46,7 +46,10 @@ static enum hrtimer_restart
>> amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>>>      struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct
>> amdgpu_crtc, vblank_timer);
>>>      struct drm_crtc *crtc = &amdgpu_crtc->base;
>>>      struct amdgpu_vkms_output *output =
>>> drm_crtc_to_amdgpu_vkms_output(crtc);
>>> +   struct drm_vblank_crtc *vblank;
>>> +   struct drm_device *dev;
>>>      u64 ret_overrun;
>>> +   unsigned int pipe;
>>>      bool ret;
>>>
>>>      ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
>>> @@ -54,9 +57,13 @@ static enum hrtimer_restart
>> amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>>>      if (ret_overrun != 1)
>>>              DRM_WARN("%s: vblank timer overrun\n", __func__);
>>>
>>> +   dev = crtc->dev;
>>> +   pipe = drm_crtc_index(crtc);
>>> +   vblank = &dev->vblank[pipe];
>>>      ret = drm_crtc_handle_vblank(crtc);
>>> -   if (!ret)
>>> -           DRM_ERROR("amdgpu_vkms failure on handling vblank");
>>> +   /* Don't queue timer again when vblank is disabled. */
>>> +   if (!ret && !READ_ONCE(vblank->enabled))
>>> +           return HRTIMER_NORESTART;
>> When drm_crtc_handle_vblank() returns false when vblank is disabled I think
>> we can simplify this to just removing the error.
>>
>> Regards,
>> Christian.
> Sorry, I didn't get you. What do you mean by "removing the error"?

We should just remove the "DRM_ERROR("amdgpu_vkms failure on handling 
vblank");" message.

When the drm_crtc_handle_vblank() returns false it doesn't really 
indicate a failure, it just indicates that the vblank is disabled and 
shouldn't be re-armed.

Regards,
Christian.

>
> Regards,
> Guchun
>>>      return HRTIMER_RESTART;
>>>    }
>>> @@ -81,7 +88,7 @@ static void amdgpu_vkms_disable_vblank(struct
>> drm_crtc *crtc)
>>>    {
>>>      struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>>>
>>> -   hrtimer_cancel(&amdgpu_crtc->vblank_timer);
>>> +   hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
>>>    }
>>>
>>>    static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,

