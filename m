Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B96C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 14:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3358C10E8AE;
	Wed, 20 Apr 2022 14:05:29 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C699D10E8AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 14:05:28 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id g13so3807267ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=si9P5cIe35Qkh8ulloFbS42Li1HoTLTT3i7yN616oFg=;
 b=JQBSf1HY18FdSv1igPp0FckCb+xDPvJnGgzoEggM7QetVzALJ3Pc7jWq4Oo0fNHw/+
 FzXw9n9UNe0cDIAF4SJ20SHzD4VvKgEkx9xYRlKpja1yT+48tK7Wcf1gFiemqrQ4XprA
 SR09fepYPWwxwAG3CfuoshCyaTVmOfmscan99ycyp8acxS2w5+QWb3nJnj7zQlNcO/q+
 jSOhRVMTGhkQp3qt02FTQ4BImXL+SSq4YSi+2S6/QCt/tcVYifAa6S1k/MALoBDMuIt8
 nvYpfLgQmxRNgKpyWdQJr1+hZ7ZMEkXEZlPVDmjJ51hk/Qzoc78D70xyKw0u9O6v9CpB
 /lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=si9P5cIe35Qkh8ulloFbS42Li1HoTLTT3i7yN616oFg=;
 b=Mso4Rt1pxvmwWErxudAZ0EORKaFRU42S2a16csMl5eq26IrD4jxsYqOhDkPUT9amSA
 wuLj/bT0cZvdsdAu+D8l1SRS//BItzITfylpCjtNqLxvwmIu1P7uBmk8kbMnfvMBgma5
 22YycgLroVzogezARGK3bERdad+HVjYQLsdhi8xWLssJ0/2RKiTpRkvKwIaaviiV8JHl
 FzXPQVcFzOBxC0cg/7VaNF5+D2ntaDjP7MidWQ5kgRMVD1xiB56g+EimaYkidvzsa/9d
 GVZOpwwblu+yipSOqNxwSICDMdloMTaI1MYzUXxIuRSyEvgQ4+mpnD36LflF1Ly5w5R1
 ibKQ==
X-Gm-Message-State: AOAM530YopeDwxid5s2ZXGUZE6gV4H3WwCryVPYCXm196FNn0zV58RTc
 W5sb+bg/1rGv9tZ60h0G7os=
X-Google-Smtp-Source: ABdhPJzOonZLPKcwbkTGlbiqZijZ1xOJwf2HcYlts0MUZtSzBn2LBJDGgHwlhGOZ79ynLh1i5fIjfw==
X-Received: by 2002:a17:907:d8c:b0:6f0:1091:de34 with SMTP id
 go12-20020a1709070d8c00b006f01091de34mr547702ejc.376.1650463527159; 
 Wed, 20 Apr 2022 07:05:27 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:425d:2971:45fa:ac5d?
 ([2a02:908:1252:fb60:425d:2971:45fa:ac5d])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a1709062bd900b006e8766b7907sm6770607ejg.223.2022.04.20.07.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 07:05:26 -0700 (PDT)
Message-ID: <89aa325c-415a-5fce-bb23-b21c9fecfe8e@gmail.com>
Date: Wed, 20 Apr 2022 16:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
 <CADnq5_PGe7L+sKw4+wiq5DO6OfDqvJfPS9R8eORnAUDbpw14pw@mail.gmail.com>
 <CADnq5_PO7v8nM2FueQNxmJfhuvHCLfhgsYaVeSHb0qmfppxbKw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PO7v8nM2FueQNxmJfhuvHCLfhgsYaVeSHb0qmfppxbKw@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Michele Ballabio <ballabio.m@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I could ack it, but I'm absolutely not an expert on that stuff.

Our DC team maybe? Or anybody working more on the PM code?

Christian.

Am 20.04.22 um 15:57 schrieb Alex Deucher:
> Ping?  Anyone care to review this?
>
> Alex
>
> On Tue, Apr 19, 2022 at 9:47 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> Ping?
>>
>> On Wed, Apr 13, 2022 at 4:15 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>> We normally runtime suspend when there are displays attached if they
>>> are in the DPMS off state, however, if something wakes the GPU
>>> we send a hotplug event on resume (in case any displays were connected
>>> while the GPU was in suspend) which can cause userspace to light
>>> up the displays again soon after they were turned off.
>>>
>>> Prior to
>>> commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
>>> the driver took a runtime pm reference when the fbdev emulation was
>>> enabled because we didn't implement proper shadowing support for
>>> vram access when the device was off so the device never runtime
>>> suspended when there was a console bound.  Once that commit landed,
>>> we now utilize the core fb helper implementation which properly
>>> handles the emulation, so runtime pm now suspends in cases where it did
>>> not before.  Ultimately, we need to sort out why runtime suspend in not
>>> working in this case for some users, but this should restore similar
>>> behavior to before.
>>>
>>> v2: move check into runtime_suspend
>>>
>>> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
>>> Tested-by: Michele Ballabio <ballabio.m@gmail.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++--------
>>>   1 file changed, 72 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 4efaa183abcd..97a1aa02d76e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
>>>          return amdgpu_device_resume(drm_dev, true);
>>>   }
>>>
>>> +static int amdgpu_runtime_idle_check_display(struct device *dev)
>>> +{
>>> +       struct pci_dev *pdev = to_pci_dev(dev);
>>> +       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>> +
>>> +       if (adev->mode_info.num_crtc) {
>>> +               struct drm_connector *list_connector;
>>> +               struct drm_connector_list_iter iter;
>>> +               int ret = 0;
>>> +
>>> +               /* XXX: Return busy if any displays are connected to avoid
>>> +                * possible display wake ups after runtime resume due to
>>> +                * hotplug events in case any displays were connected while
>>> +                * the GPU was in suspend.  Remove this once that is fixed.
>>> +                */
>>> +               mutex_lock(&drm_dev->mode_config.mutex);
>>> +               drm_connector_list_iter_begin(drm_dev, &iter);
>>> +               drm_for_each_connector_iter(list_connector, &iter) {
>>> +                       if (list_connector->status == connector_status_connected) {
>>> +                               ret = -EBUSY;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +               drm_connector_list_iter_end(&iter);
>>> +               mutex_unlock(&drm_dev->mode_config.mutex);
>>> +
>>> +               if (ret)
>>> +                       return ret;
>>> +
>>> +               if (amdgpu_device_has_dc_support(adev)) {
>>> +                       struct drm_crtc *crtc;
>>> +
>>> +                       drm_for_each_crtc(crtc, drm_dev) {
>>> +                               drm_modeset_lock(&crtc->mutex, NULL);
>>> +                               if (crtc->state->active)
>>> +                                       ret = -EBUSY;
>>> +                               drm_modeset_unlock(&crtc->mutex);
>>> +                               if (ret < 0)
>>> +                                       break;
>>> +                       }
>>> +               } else {
>>> +                       mutex_lock(&drm_dev->mode_config.mutex);
>>> +                       drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
>>> +
>>> +                       drm_connector_list_iter_begin(drm_dev, &iter);
>>> +                       drm_for_each_connector_iter(list_connector, &iter) {
>>> +                               if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
>>> +                                       ret = -EBUSY;
>>> +                                       break;
>>> +                               }
>>> +                       }
>>> +
>>> +                       drm_connector_list_iter_end(&iter);
>>> +
>>> +                       drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
>>> +                       mutex_unlock(&drm_dev->mode_config.mutex);
>>> +               }
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>>   {
>>>          struct pci_dev *pdev = to_pci_dev(dev);
>>> @@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>>                  return -EBUSY;
>>>          }
>>>
>>> +       ret = amdgpu_runtime_idle_check_display(dev);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>>          /* wait for all rings to drain before suspending */
>>>          for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>                  struct amdgpu_ring *ring = adev->rings[i];
>>> @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>>                  return -EBUSY;
>>>          }
>>>
>>> -       if (amdgpu_device_has_dc_support(adev)) {
>>> -               struct drm_crtc *crtc;
>>> -
>>> -               drm_for_each_crtc(crtc, drm_dev) {
>>> -                       drm_modeset_lock(&crtc->mutex, NULL);
>>> -                       if (crtc->state->active)
>>> -                               ret = -EBUSY;
>>> -                       drm_modeset_unlock(&crtc->mutex);
>>> -                       if (ret < 0)
>>> -                               break;
>>> -               }
>>> -
>>> -       } else {
>>> -               struct drm_connector *list_connector;
>>> -               struct drm_connector_list_iter iter;
>>> -
>>> -               mutex_lock(&drm_dev->mode_config.mutex);
>>> -               drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
>>> -
>>> -               drm_connector_list_iter_begin(drm_dev, &iter);
>>> -               drm_for_each_connector_iter(list_connector, &iter) {
>>> -                       if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
>>> -                               ret = -EBUSY;
>>> -                               break;
>>> -                       }
>>> -               }
>>> -
>>> -               drm_connector_list_iter_end(&iter);
>>> -
>>> -               drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
>>> -               mutex_unlock(&drm_dev->mode_config.mutex);
>>> -       }
>>> -
>>> -       if (ret == -EBUSY)
>>> -               DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
>>> +       ret = amdgpu_runtime_idle_check_display(dev);
>>> +       if (ret)
>>> +               return ret;
>>>
>>>          pm_runtime_mark_last_busy(dev);
>>>          pm_runtime_autosuspend(dev);
>>> --
>>> 2.35.1
>>>

