Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10DDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 22:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BF210E1A7;
	Tue,  8 Mar 2022 22:17:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6A210E17C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 22:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646777438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHHapBKRdhhDXmnYrTeCKV1NnPAwLYWNecWuP/Gyuk4=;
 b=Z6YPF0km4S4SwMR56R2hStdTQLjMbBXJsM5IFgec4A7ojgfMnuyPcjk7NvR05TF9sQWjCg
 CBeVkmZlB0yOGZ1HcnZTnBQcLMT3V6p5D7TLOy+BrYbenCe4vngFR4onDdQiZALcu06K/e
 A9jY85ZjTex6DnW4HSL7onOqzgoElFk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-zq0z8Y7XOkGT8vNGUOFvPw-1; Tue, 08 Mar 2022 17:10:37 -0500
X-MC-Unique: zq0z8Y7XOkGT8vNGUOFvPw-1
Received: by mail-ed1-f69.google.com with SMTP id
 z19-20020a50cd13000000b0041693869e9aso6342edi.14
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Mar 2022 14:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rHHapBKRdhhDXmnYrTeCKV1NnPAwLYWNecWuP/Gyuk4=;
 b=LU38I7Kxh49dVEljqBdsnl+w6AiuQo+OhPyhrRZvDYk3AK6nbBd6yhtmUi4ZlsuyGW
 rRn4LJXh5pUr6NqoSZ+SxMx3+GVFG8sdRxMO04IZtEI9hbM8dDztJaaimQU9mmb3ro5M
 fjg+/9UiEW0IdUxCih0MvHjeR3jhrpy/Qt7Hmo+oEG4IW6QoGU0wKG9QsF4/qreb4o6a
 Fl8cc8FqaqeRTsgS5eju11kCFzJYuf5AP55yYJLuOcY5uh2y0I3GFNmrJ4z8jpR/0lSp
 RnqQXH8HRb6rSNF9EUngmxNoWJ2e9L5IP/my3ej4fpmY+pTAdZNQSsxH1A4Bx7SS1kR1
 9TNQ==
X-Gm-Message-State: AOAM53299pcyGbCnYpLym6Bs70kRj6MnIgxXkcJ4A0zwlDcQOY8o2aDU
 Kc5Vrq59hctkQP8FOpC0gSy6Z6Q8OtZV5rmcaagi6Df/JP+oLEi9puyZ4Sl/I2U4jf05JNZJ3Mh
 dGqbEcltfKj5mycVnd5d82Es3/A==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id
 k11-20020a17090666cb00b006cfe4f79504mr15555264ejp.142.1646777435899; 
 Tue, 08 Mar 2022 14:10:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJkWfUcGkz9ggnBpwYVSu24Z2hXbLs1jI2HrK8WgIjy0zn2WjNeI+6H8+Y21prYdH3kVuvSQ==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id
 k11-20020a17090666cb00b006cfe4f79504mr15555248ejp.142.1646777435657; 
 Tue, 08 Mar 2022 14:10:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1?
 (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a17090626d700b006cfcd39645fsm16503ejc.88.2022.03.08.14.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 14:10:35 -0800 (PST)
Message-ID: <0775d772-4aa0-de5f-e878-930b2722554e@redhat.com>
Date: Tue, 8 Mar 2022 23:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/amdgpu: Add support for drm_privacy_screen
To: Harry Wentland <harry.wentland@amd.com>, Sean Paul <sean@poorly.run>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 alexdeucher@gmail.com
References: <20220308205638.1744064-1-sean@poorly.run>
 <f19cddab-1053-39e7-10f2-5a775b452b4e@redhat.com>
 <3782c8c3-de17-08d3-7979-93993c877f0d@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3782c8c3-de17-08d3-7979-93993c877f0d@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 08 Mar 2022 22:17:03 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, rajatja@google.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 3/8/22 23:07, Harry Wentland wrote:
> 
> 
> On 2022-03-08 17:02, Hans de Goede wrote:
>> Hi,
>>
>> On 3/8/22 21:56, Sean Paul wrote:
>>> From: Sean Paul <seanpaul@chromium.org>
>>>
>>> This patch adds the necessary hooks to make amdgpu aware of privacy
>>> screens. On devices with privacy screen drivers (such as thinkpad-acpi),
>>> the amdgpu driver will defer probe until it's ready and then sync the sw
>>> and hw state on each commit the connector is involved and enabled.
>>>
>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> 
> The amdgpu_dm portion looks fine to me with Hans' comment
> addressed.
> 
> I don't know what the impact of the EPROBE_DEFER in amdgpu_pci_probe
> is.

Since it happens first thing in the probe function and the GPU
has not been touched yet (and thus cannot have been put in
a "bad" state), this should be fine.

The kernel will just keep retrying each time some other drivers
have successfully probed, until the privacy screen is available
and then the probe will continue normally.

Regards,

Hans




> 
> Harry
> 
>>> ---
>>>
>>> I tested this locally, but am not super confident everything is in the
>>> correct place. Hopefully the intent of the patch is clear and we can
>>> tweak positioning if needed.
>>
>> Thank you for working on this, from a drm-privacy screen
>> pov this looks good, one small remark below.
>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  9 +++++++++
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 16 +++++++++++++++-
>>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 2ab675123ae3..e2cfae56c020 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -26,6 +26,7 @@
>>>  #include <drm/drm_aperture.h>
>>>  #include <drm/drm_drv.h>
>>>  #include <drm/drm_gem.h>
>>> +#include <drm/drm_privacy_screen_consumer.h>
>>>  #include <drm/drm_vblank.h>
>>>  #include <drm/drm_managed.h>
>>>  #include "amdgpu_drv.h"
>>> @@ -1988,6 +1989,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>>  {
>>>  	struct drm_device *ddev;
>>>  	struct amdgpu_device *adev;
>>> +	struct drm_privacy_screen *privacy_screen;
>>>  	unsigned long flags = ent->driver_data;
>>>  	int ret, retry = 0, i;
>>>  	bool supports_atomic = false;
>>> @@ -2063,6 +2065,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>>  	size = pci_resource_len(pdev, 0);
>>>  	is_fw_fb = amdgpu_is_fw_framebuffer(base, size);
>>>  
>>> +	/* If the LCD panel has a privacy screen, defer probe until its ready */
>>> +	privacy_screen = drm_privacy_screen_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(privacy_screen) && PTR_ERR(privacy_screen) == -EPROBE_DEFER)
>>> +		return -EPROBE_DEFER;
>>> +
>>> +	drm_privacy_screen_put(privacy_screen);
>>> +
>>>  	/* Get rid of things like offb */
>>>  	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &amdgpu_kms_driver);
>>>  	if (ret)
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index e1d3db3fe8de..9e2bb6523add 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -9781,6 +9781,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>>  		if (acrtc) {
>>>  			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
>>>  			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
>>> +
>>> +			/* Sync the privacy screen state between hw and sw */
>>> +			drm_connector_update_privacy_screen(new_con_state);
>>>  		}
>>>  
>>>  		/* Skip any modesets/resets */
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>>> index 740435ae3997..e369fc95585e 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>>> @@ -27,6 +27,7 @@
>>>  #include <drm/drm_atomic_helper.h>
>>>  #include <drm/dp/drm_dp_mst_helper.h>
>>>  #include <drm/dp/drm_dp_helper.h>
>>> +#include <drm/drm_privacy_screen_consumer.h>
>>>  #include "dm_services.h"
>>>  #include "amdgpu.h"
>>>  #include "amdgpu_dm.h"
>>> @@ -506,6 +507,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>>>  				       struct amdgpu_dm_connector *aconnector,
>>>  				       int link_index)
>>>  {
>>> +	struct drm_device *dev = dm->ddev;
>>>  	struct dc_link_settings max_link_enc_cap = {0};
>>>  
>>>  	aconnector->dm_dp_aux.aux.name =
>>> @@ -519,8 +521,20 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>>>  	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
>>>  				      &aconnector->base);
>>>  
>>> -	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
>>> +	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
>>> +		struct drm_privacy_screen *privacy_screen;
>>> +
>>> +		/* Reference given up in drm_connector_cleanup() */
>>> +		privacy_screen = drm_privacy_screen_get(dev->dev, NULL);
>>> +		if (!IS_ERR(privacy_screen)) {
>>> +			drm_connector_attach_privacy_screen_provider(&aconnector->base,
>>> +								     privacy_screen);
>>> +		} else {
>>> +			drm_err(dev, "Error getting privacy screen, ret=%d\n",
>>> +				PTR_ERR(privacy_screen));
>>
>> This will now log a warning on all devices without a privacy-screen. The i915
>> code uses this instead:
>>
>>                 } else if (PTR_ERR(privacy_screen) != -ENODEV) {
>> 			drm_err(dev, "Error getting privacy screen, ret=%d\n",
>> 				PTR_ERR(privacy_screen));
>>                 }
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>> +		}
>>>  		return;
>>> +	}
>>>  
>>>  	dc_link_dp_get_max_link_enc_cap(aconnector->dc_link, &max_link_enc_cap);
>>>  	aconnector->mst_mgr.cbs = &dm_mst_cbs;
>>
> 

