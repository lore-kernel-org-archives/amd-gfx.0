Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08972C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 17:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6208910E7F8;
	Wed,  4 May 2022 17:02:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2444410E7CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651683736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=su2fcE/ZTpO/A41EAyixuSURd7XYYslQVS9rF55do8s=;
 b=FvIpqalJkF2YJAM2DS9aG95FtsmEm/t0GK+uht1RKRn4A5UJiS1cu+FlnZZO6UeCOIhvjZ
 U7pJRYVpw7/fwkfICm2/PERNgps+H5YVDUkND1yurmj9qP+4dEbC9UV3ujH128G+7tS2nf
 AhqgdzDrfnH8E3bY/ALKuWo+ObwM1tQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-siEomklNNl6gMKW3Mz1xTw-1; Wed, 04 May 2022 13:02:09 -0400
X-MC-Unique: siEomklNNl6gMKW3Mz1xTw-1
Received: by mail-wm1-f69.google.com with SMTP id
 q128-20020a1c4386000000b003942fe15835so904064wma.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 10:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=su2fcE/ZTpO/A41EAyixuSURd7XYYslQVS9rF55do8s=;
 b=YSifDcfqlcFq+/9lhF2cXv47qAReti/gbwj5T3O0SFEclk+8leFL76szUPzyNijaLU
 b5Od6L0AfnWrXwO+9in93vddkjrNiTHfj5X36xcU3rWp5UYLmR46jK5Gg3lphq1f5Mbs
 Ht5w909umwRzbAJk8dQS46z8rVMKxBIegfpdVTxKpXsxHv1zoa5yYXO7dlMRjCvSzBO5
 8IDICQz5e/8I/pNzeqIbS7ETBKcQPXgXqfUssL9QZfirnJnh2kefNCcsoCOldsOr1Zni
 dLGW5lHIIiGICthuATJ4Y6Lbl4GA3ZZX6wYifBG+MT60gUuSWgM+iMQUSHi6/kOt0JUI
 qjPg==
X-Gm-Message-State: AOAM5337MuNI2DS808LDEJqYGznEipO3JTOIVRioN8zRydpEp/OycRy0
 b84OKOwnXfQeBpzBRXE6ZClBgM7mzzvYHDJMhQDmbm54aBQxVR+oNqPMo79pwnRiBjGE40+yuiq
 zW4EsdlGKFoZoMeKbHkgmtTPjWw==
X-Received: by 2002:a05:6000:1c02:b0:20c:7d20:cad6 with SMTP id
 ba2-20020a0560001c0200b0020c7d20cad6mr4049790wrb.373.1651683728521; 
 Wed, 04 May 2022 10:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf1id7XWx3NZcKVfmk3aRE3FalMReMMEUbJDaOtcBm4Gbck3VS/Amr1NlXOkEwj/GbfgB1RA==
X-Received: by 2002:a05:6000:1c02:b0:20c:7d20:cad6 with SMTP id
 ba2-20020a0560001c0200b0020c7d20cad6mr4049781wrb.373.1651683728291; 
 Wed, 04 May 2022 10:02:08 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c1d0600b003942a244f34sm3008867wms.13.2022.05.04.10.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 10:02:07 -0700 (PDT)
Message-ID: <fd36a5ec-e795-8b60-3a02-b865ef897da2@redhat.com>
Date: Wed, 4 May 2022 19:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable runpm if we are the
 primary adapter"
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
 <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
 <CADnq5_Mp7EnBUgXaT=-5ndWMW9svpsDbTypj+DdehOXsEAw_4w@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CADnq5_Mp7EnBUgXaT=-5ndWMW9svpsDbTypj+DdehOXsEAw_4w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/4/22 18:50, Alex Deucher wrote:
> On Wed, May 4, 2022 at 12:46 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Hello Alex,
>>
>> On 5/4/22 15:48, Alex Deucher wrote:
>>> This reverts commit b95dc06af3e683d6b7ddbbae178b2b2a21ee8b2b.
>>>
>>> This workaround is no longer necessary.  We have a better workaround
>>> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)").
>>>
>>
>> I would write this line instead as:
>>
>> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
>> displays attached (v3)").
> 
> When you do it that way checkpatch and some maintainers complain about
> splitting up a commit line across multiple lines.
>

It does indeed, how silly. Scratch my comment then.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

