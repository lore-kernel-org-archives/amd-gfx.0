Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EFD61215
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5EFD61215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9B16F37F;
	Thu,  4 Nov 2021 20:20:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB917386C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636056559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRdrRlX7d6jR9XJ1WlJwuA/7L4WdNGNHCwwgPSMtrew=;
 b=dDewa/LtGBJX7ac4fwngfqrK3V0fYBgwe+JLjd8GGTEQ1eZqtvHimZmHkNb2MWId6OpMe4
 HTZd/hQxjMhhf1/oCMVhZIyNr1OO3vGG7gUcU+MqTAZyqMZM+UmA92DYXS5vxkJy3HaJHG
 WZC+ZVdbavgqa5ilcXPTOemEuhnqZWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-MdBN0-EhNTiyWC1gtQ0NBQ-1; Thu, 04 Nov 2021 16:09:18 -0400
X-MC-Unique: MdBN0-EhNTiyWC1gtQ0NBQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 h7-20020adfaa87000000b001885269a937so260276wrc.17
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WRdrRlX7d6jR9XJ1WlJwuA/7L4WdNGNHCwwgPSMtrew=;
 b=wRRdDr63mbRhtO8pxc6GHimK84i2WipfxrzNOJancB7jVSM6XF8kI+FTgTv9QNsPZp
 byHbNm0lcVJagJYxmeEmeDNwz0XbKEVCPzBzo6Xjjj7F4mrV8vOk9hrNHuQNpl468vPO
 WEF0sC9ozTmBZf1hGAEzFbjceKOaw+6ZFEg1GPTTj6UbCJ+GQvnu/r9hmJU5anU7z+WW
 d4F94KTvZex7jH33hpEZhTqYMSTIaakBI1Z2VxolWTPIMRcpifTaxxELHV00JQ1DXoGE
 SJVMyTtdPWh1WzPQ54OxOlNTVjQ1xYW+jSiUVxIXcgldyYCGMo0NlmtkAuT6migVBJng
 p3lw==
X-Gm-Message-State: AOAM530XFcnm3/LlpQCrcgylKRuIeCKfIkqU8pIqyWRr2cVbedlwrYIp
 nk17SJmUAEdQsrWcuccKXL1NgPWBjn6RtDlLoOMPWHst/VnAFh247ToPOBt0fUX247yZhY5ch57
 X1ncaUI/IVRImgTcfhG396JmncQ==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr26040191wmh.86.1636056557045; 
 Thu, 04 Nov 2021 13:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy76MY/85Rr56RxIxfOCWbJkdVKLFu3k+Td/GsoIreVUO3gSrCM0LaAND1RBuRZ0S+UgTUN+Q==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr26040146wmh.86.1636056556830; 
 Thu, 04 Nov 2021 13:09:16 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
 by smtp.gmail.com with ESMTPSA id z15sm6028960wrr.65.2021.11.04.13.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 13:09:16 -0700 (PDT)
Message-ID: <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
Date: Thu, 4 Nov 2021 21:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87ilx7ae3v.fsf@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 04 Nov 2021 20:20:12 +0000
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
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Peter Robinson <pbrobinson@gmail.com>, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Jani,

On 11/4/21 20:57, Jani Nikula wrote:
> On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
>> +/**
>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>> + * @driver: DRM driver to check
>> + *
>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>> + * if the "nomodeset" kernel command line parameter is used.
>> + *
>> + * Return: 0 on success or a negative error code on failure.
>> + */
>> +int drm_drv_enabled(const struct drm_driver *driver)
>> +{
>> +	if (vgacon_text_force()) {
>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_drv_enabled);
> 
> The name implies a bool return, but it's not.
> 
> 	if (drm_drv_enabled(...)) {
> 		/* surprise, it's disabled! */
> 	}
> 

It used to return a bool in v2 but Thomas suggested an int instead to
have consistency on the errno code that was returned by the callers.

I should probably name that function differently to avoid confusion.

But I think you are correct and this change is caused too much churn
for not that much benefit, specially since is unclear that there might
be another condition to prevent a DRM driver to load besides nomodeset.

I'll just drop this patch and post only #2 but making drivers to test
using the drm_check_modeset() function (which doesn't have a name that
implies a bool return).

> 
> BR,
> Jani.
> 
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

