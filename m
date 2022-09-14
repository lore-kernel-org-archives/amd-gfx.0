Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C198C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 17:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED1E10E96E;
	Wed, 14 Sep 2022 17:32:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B46210E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663174935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eAE9HpKpIVvmOEFXUeeAc8cv8ndkWqJta1h5pXlw4I=;
 b=ZQsH9RKdvDrLXaVxdMq7X1C4fRYxy9B8MSBF2GVSGMxvMDqPeihSc5om6ycBsu9i5nxBef
 b1CkuMAK/Wt79KMNMS+9j+BZl/9YejSlrFzcmm5gHR1kr5A24zkr9ybl6nv9Wm4gCC6kCl
 19UH+C6Strsf4DvZYBsoRxGpMQtSjN8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-JGncro53O8SakH2MiH7_Qg-1; Wed, 14 Sep 2022 12:59:02 -0400
X-MC-Unique: JGncro53O8SakH2MiH7_Qg-1
Received: by mail-wm1-f71.google.com with SMTP id
 f25-20020a7bc8d9000000b003b4768dcd9cso4412770wml.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=8eAE9HpKpIVvmOEFXUeeAc8cv8ndkWqJta1h5pXlw4I=;
 b=6R9TI4QUuSvNIQi3k5B5vK6PIHOAv9iPmz2BbFKFHfURNenTVT1xf8SlLVw0TIDVn9
 i4VBsEpF/HnGI64af+K3N+pIFdvM1jF+1S9gEgsP4qEfcE3hWZrpwS/QZk5z9Y4qq56C
 GYJk3oH+0gq+tcmeYp3r2MvJsGjf1wFCX25m/exiDX1sgESspD/0v6mzcO1os2PGvzQT
 C2lr3IDZIfekF/Y9GefjcoGMpU39tVmnHbs0AXPQBy+JOgOBOc1wgKx+Ase7c+Kguvkd
 yzqghLSZpa8YxtmyQdKAaXfxo/CUq6vmNB5aPhM2O57MUTKAR/g4vQsxt0aE+Ky8UoLD
 1USA==
X-Gm-Message-State: ACgBeo3zBjidJA+bVc45MrnzCnfmAzMvY4Z8HpCvSXfY6/dmAjjgUapZ
 RyMAh8USD0Z7hlPpbnyg1G+o5ebP06HvcGwAB0pGEiwXnPFyz4FEG6DXqoG6UDtyVxsME91Sl2c
 EcztvkDvTr3axi1LizXl9hrkQ8g==
X-Received: by 2002:adf:f211:0:b0:228:d6a4:3510 with SMTP id
 p17-20020adff211000000b00228d6a43510mr21648614wro.448.1663174741070; 
 Wed, 14 Sep 2022 09:59:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/hMrbSSVrICYCjqMv7OHktLT/ShhknRc4TABv3IGMoKgXGV5RhWzuT4s56YrRzLlwdjxauA==
X-Received: by 2002:adf:f211:0:b0:228:d6a4:3510 with SMTP id
 p17-20020adff211000000b00228d6a43510mr21648581wro.448.1663174740767; 
 Wed, 14 Sep 2022 09:59:00 -0700 (PDT)
Received: from [172.16.38.152] ([185.122.133.20])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a05600c3b1700b003b477532e66sm6954615wms.2.2022.09.14.09.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Sep 2022 09:58:59 -0700 (PDT)
Message-ID: <2b7693c4-b04e-425a-2f87-c4b12fa2f63b@redhat.com>
Date: Wed, 14 Sep 2022 17:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] Immutable backlight-detect-refactor branch between
 acpi, drm-* and pdx86
To: Maxime Ripard <maxime@cerno.tech>
References: <261afe3d-7790-e945-adf6-a2c96c9b1eff@redhat.com>
 <20220914112933.64ovljgsrv2l25rs@penduick>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220914112933.64ovljgsrv2l25rs@penduick>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Sep 2022 17:32:40 +0000
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
Cc: Karol Herbst <kherbst@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@redhat.com>,
 Len Brown <lenb@kernel.org>, Daniel Dadap <ddadap@nvidia.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Mark Gross <markgross@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Xinhui <Xinhui.Pan@amd.com>,
 Lukas Wunner <lukas@wunner.de>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 9/14/22 12:29, Maxime Ripard wrote:
> Hi Hans,
> 
> On Mon, Sep 05, 2022 at 10:35:47AM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Now that all patches have been reviewed/acked here is an immutable backlight-detect-refactor
>> branch with 6.0-rc1 + the v5 patch-set, for merging into the relevant (acpi, drm-* and pdx86)
>> subsystems.
>>
>> Please pull this branch into the relevant subsystems.
>>
>> I will merge this into the review-hans branch of the pdx86 git tree today and
>> from there it will move to for-next once the builders have successfully build-tested
>> the merge.
> 
> I merged it into drm-misc-next, thanks!

Great, thank you!

Regards,

Hans

