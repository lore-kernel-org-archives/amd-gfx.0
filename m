Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990BFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 14:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588D96103C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 14:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 588D96103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2FD6EA56;
	Wed,  3 Nov 2021 14:33:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5D66E9BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635949720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjCrBXWwYzBj3m1TWb42Da2qoJJrqcfHeMnXi0fhczc=;
 b=jJRai2dU4RM0+tEparQIsy8VlNos8VTqdrSBYtIrFZw/5y0eTbyygdrQQIbYDmxdrV733S
 4/Z740NgcmNgE30MAjkpOU3Tov/Fad95YsnCplfC4vEknjVxobG50/9yA6CVIeYQFbET0D
 bAofaeTCbtBiPAqi2yUZKEVNFAyXjXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-vzPbogTJNDW_o1vUbEnJ_g-1; Wed, 03 Nov 2021 10:28:39 -0400
X-MC-Unique: vzPbogTJNDW_o1vUbEnJ_g-1
Received: by mail-wm1-f72.google.com with SMTP id
 g11-20020a1c200b000000b003320d092d08so1128500wmg.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Nov 2021 07:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wjCrBXWwYzBj3m1TWb42Da2qoJJrqcfHeMnXi0fhczc=;
 b=GsF7shjz5GB59CvUHjX8Cp2fHfXNnt7M7/3DJU8D5VQTBjbTw7+qSPYl9XRbyswRTk
 QHGAcUgT/+cd3WvWuUfwMnh3L/Jnnci1bV3Xf2Y50XeNWo/kF+2PV4bzQYr8tq4+N+AR
 KF6ft68HU1WaKN4Bp2EGBqx+dAKquzgG+N8jpMJtpm74hKM68n0++SHmB6SB9F+G1C1s
 cn3dELgnfy27PGBLchEsVC+j6A7G2dkLoKeMY4RU37nZUajRQy1WfYK7Z/wG9Zo5/SNw
 AXt8gSAuuTBSqB0yx6+RkM8gEosjOR5bMVZDfW5F56TX4Hga/7R73N/cvumJArRrQ9X7
 faFA==
X-Gm-Message-State: AOAM5328dUedb7HqfB393ZEqKSHjqz727D7SS9IiUW0M1iysmJQhiXgT
 z9dXpiQKsUdd1GG1jFf/dxmUCZ1HBhcuo2kaMLozdYAmqYAcGzly9NkvTD03un+NWViu4g6csUO
 /lIMRI107JlUV582z9eXJljaZIg==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr21502521wrs.270.1635949718018; 
 Wed, 03 Nov 2021 07:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygbrJwATC2G/bV3PqN0MYXRcgYe3aBtB674/ombGZ2HxFPH0E2H3yEXKRBe/gbkyWGcW/pQQ==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr21502482wrs.270.1635949717828; 
 Wed, 03 Nov 2021 07:28:37 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
 by smtp.gmail.com with ESMTPSA id z8sm2163734wrh.54.2021.11.03.07.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Nov 2021 07:28:37 -0700 (PDT)
Message-ID: <5b4e4534-4786-d231-e331-78fdb5d8496a@redhat.com>
Date: Wed, 3 Nov 2021 15:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 3/5] drm: Rename vgacon_text_force() function to
 drm_modeset_disabled()
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20211103122809.1040754-1-javierm@redhat.com>
 <20211103122809.1040754-4-javierm@redhat.com>
 <eddc2967-8355-b64a-79d8-6c1cda1bc732@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <eddc2967-8355-b64a-79d8-6c1cda1bc732@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 03 Nov 2021 14:33:53 +0000
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>,
 amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Neal Gompa <ngompa13@gmail.com>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Peter Robinson <pbrobinson@gmail.com>, intel-gfx@lists.freedesktop.org,
 Hans de Goede <hdegoede@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 nouveau@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/3/21 13:57, Thomas Zimmermann wrote:

[snip]

>>   
>> -	if (vgacon_text_force()) {
>> +	if (drm_modeset_disabled()) {
>>   		DRM_ERROR("amdgpu kernel modesetting disabled.\n");
> 
> Please remove all such error messages from drivers. 
> drm_modeset_disabled() should print a unified message instead.
>

Agreed.

>> -static bool vgacon_text_mode_force;
>> +static bool drm_nomodeset;
>>   
>> -bool vgacon_text_force(void)
>> +bool drm_modeset_disabled(void)
> 
> I suggest to rename this function to drm_check_modeset() and have it 
> return a negative errno code on failure. This gives maximum flexibility 
> and reduces errors in drivers. Right now the drivers return something 
> like -EINVAL, which seems wrong. Returning -ENODEV seems more appropriate.
>

Good idea. I'll do it in v2 as well.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

