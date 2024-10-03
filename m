Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A673BCFA752
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 07:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9228D10E884;
	Fri,  4 Oct 2024 07:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Tr+SM4F3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEB710E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727977691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJlvHuDkFg4to1w3gK1SxyjzDAKplXT0LaEvspziFW8=;
 b=Tr+SM4F330n0Yb9LHgaOvGq7KMgc058dHhgERBLMhLUR0A+KoeAXwKhvRwZWv9Estioy00
 ZbxDx7q/5CUYWADCu4fSiCIcB/7xjR1sJuKboJmYw972ZmVh19o4naxZZ1dLJzmwR6KlZm
 907ClR2JHdhZvd8pCy5944yNvcHCAE0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-asH6q7DYMyOolb0_IAl4Vw-1; Thu, 03 Oct 2024 13:48:08 -0400
X-MC-Unique: asH6q7DYMyOolb0_IAl4Vw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a8a8d9a2a12so88101566b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Oct 2024 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727977687; x=1728582487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJlvHuDkFg4to1w3gK1SxyjzDAKplXT0LaEvspziFW8=;
 b=SQhNzbSKUr5YYSX2khQBwuiaJLuizl9+CPKLaoVzU+Pg9f+ENJInvyC7wYgB02snCC
 PS0TwOjGyxge7vbPMzpAisqflth8sF4/AeY2l62U9EwZHS/paY8AFquo7RNNTc0eVxZX
 TqU5mJg/WKZvXkaLWU6M01l2/Ook3hGAzQzp8eROhXI7ICw5d6RJhxkThkSvD+8VMMuV
 aodqNKWiA4J19LDuJVGLkV1Rh2p+sPCsChFmMpLwXWqz7LBQdTYZb3IOk5mnKz7ZWhbU
 +uUMt3lxDjF+yuCcPzY976r88vvVTffE7jfNu3wQ5dCrF5SL0C99AmkTAjaNo/vrxgl7
 DtrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXeodNtIeB8mCV9zw9Q6e4rsnOPX9sKKLoJC3O+IWuAH9V5BwE7UGp2Z+j6rKs0LpIZtFWO239@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzicBBonhQDrFO6rbdbfxNosr7IrFJ4QCppLwvr6UiNjCxPAs0h
 yT603XRg12gcZrlLH9o6KHt9ka2m7CciJNKp1G1GDCZXTRuVnQ1tWY2tTJqhagZwxxXTriVP49f
 iqsl26nOQ1H21LVK2rmfPVad4cp1cSz6pxkq41aTCQJeY3RL5X77ntrY0nusQyx4=
X-Received: by 2002:a17:907:60c9:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a991bd139b8mr19030666b.7.1727977686760; 
 Thu, 03 Oct 2024 10:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxxyof7QTMVZMS4QNE9XWZWHySOEJl7HxWxaAtNzVU5rP1ukRtbeYX6GNSgRO9L7MYoOQwEQ==
X-Received: by 2002:a17:907:60c9:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a991bd139b8mr19029366b.7.1727977686306; 
 Thu, 03 Oct 2024 10:48:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a991047318esm113328866b.179.2024.10.03.10.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 10:48:05 -0700 (PDT)
Message-ID: <8adb805f-14f9-467e-a37a-668e3a9e7b07@redhat.com>
Date: Thu, 3 Oct 2024 19:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: add late_register for connector
To: Alex Deucher <alexdeucher@gmail.com>, Wu Hoi Pok <wuhoipok@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241003060650.18454-1-wuhoipok@gmail.com>
 <CADnq5_PA37NQ52-Y8r6JEtXDRwPehzM5+cxysiZgVks4AkivjQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PA37NQ52-Y8r6JEtXDRwPehzM5+cxysiZgVks4AkivjQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 07:28:27 +0000
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

Hi,

On 3-Oct-24 5:54 PM, Alex Deucher wrote:
> + Hans
> 
> On Thu, Oct 3, 2024 at 2:33 AM Wu Hoi Pok <wuhoipok@gmail.com> wrote:
>>
>> This is a fix patch not tested yet,
>> for a bug I introduce in previous rework of radeon driver.
>> The bug is a null dereference in 'aux.dev', which is the
>> 'device' not registered, resulting in kernel panic. By having
>> 'late_register', the connector should be registered after
>> 'drm_dev_register' automatically.
>>
>> Please help testing thank you.
>>
>> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>

Thank you both for the Cc and the patch. I can confirm that this
fixes the crash which I was seeing. Also IHMO this should have
a fixes tag for the original commit introducing the problem:

Fixes: 90985660ba48 ("drm/radeon: remove load callback from kms_driver")
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





>> ---
>>  drivers/gpu/drm/radeon/atombios_dp.c       |  9 ++-------
>>  drivers/gpu/drm/radeon/radeon_connectors.c | 17 +++++++++++++++++
>>  2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
>> index fca8b08535a5..6328627b7c34 100644
>> --- a/drivers/gpu/drm/radeon/atombios_dp.c
>> +++ b/drivers/gpu/drm/radeon/atombios_dp.c
>> @@ -228,10 +228,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>  {
>>         struct drm_device *dev = radeon_connector->base.dev;
>>         struct radeon_device *rdev = dev->dev_private;
>> -       int ret;
>>
>>         radeon_connector->ddc_bus->rec.hpd = radeon_connector->hpd.hpd;
>> -       radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>>         radeon_connector->ddc_bus->aux.drm_dev = radeon_connector->base.dev;
>>         if (ASIC_IS_DCE5(rdev)) {
>>                 if (radeon_auxch)
>> @@ -242,11 +240,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>                 radeon_connector->ddc_bus->aux.transfer = radeon_dp_aux_transfer_atom;
>>         }
>>
>> -       ret = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> -       if (!ret)
>> -               radeon_connector->ddc_bus->has_aux = true;
>> -
>> -       WARN(ret, "drm_dp_aux_register() failed with error %d\n", ret);
>> +       drm_dp_aux_init(&radeon_connector->ddc_bus->aux);
>> +       radeon_connector->ddc_bus->has_aux = true;
>>  }
>>
>>  /***** general DP utility functions *****/
>> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
>> index 528a8f3677c2..f9c73c55f04f 100644
>> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
>> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
>> @@ -1786,6 +1786,20 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
>>         return MODE_OK;
>>  }
>>
>> +static int
>> +radeon_connector_late_register(struct drm_connector *connector)
>> +{
>> +       struct radeon_connector *radeon_connector = to_radeon_connector(connector);
>> +       int r = 0;
>> +
>> +       if (radeon_connector->ddc_bus->has_aux) {
>> +               radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>> +               r = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> +       }
>> +
>> +       return r;
>> +}
>> +
>>  static const struct drm_connector_helper_funcs radeon_dp_connector_helper_funcs = {
>>         .get_modes = radeon_dp_get_modes,
>>         .mode_valid = radeon_dp_mode_valid,
>> @@ -1800,6 +1814,7 @@ static const struct drm_connector_funcs radeon_dp_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>> @@ -1810,6 +1825,7 @@ static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>> @@ -1820,6 +1836,7 @@ static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>>         .early_unregister = radeon_connector_unregister,
>>         .destroy = radeon_connector_destroy,
>>         .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>  };
>>
>>  void
>> --
>> 2.46.2
>>
> 

