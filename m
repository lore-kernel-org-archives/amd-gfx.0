Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 06:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7206D10F018;
	Thu, 12 May 2022 06:54:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A46B10F087
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 06:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652338438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9qrallTCJWWrD1tmfcAYPYM1KeQaHZcmgYv8BoSEF0=;
 b=MIlw3VSrHhOT4/FIfIrDFeNODY57exxJlcFs8tNBJBarga2ffGW0UV7bHWWHA3RT/FBxFQ
 A1TjFS22RGd0tDS0irREx3Y71fy/1n52kI//P96uBT/rXwOdWohG50AVhroS5p+ByTh6wV
 4/HcdFM8ye1U+AE8u4UVSZPO+2KOkx8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-PI1AQJK8Ni6xW8dol9jc0A-1; Thu, 12 May 2022 02:53:55 -0400
X-MC-Unique: PI1AQJK8Ni6xW8dol9jc0A-1
Received: by mail-wm1-f71.google.com with SMTP id
 o24-20020a05600c379800b003943412e81dso1295088wmr.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 23:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=m9qrallTCJWWrD1tmfcAYPYM1KeQaHZcmgYv8BoSEF0=;
 b=mE2fnEiZ92DH3c25UwUd6pZVPq8VPXGPL8HXowS/gUmNoQPRYjyX6zBYpm7xhbUPso
 nVjPk1DGnVpf5XtLROmkaOs8qTHddKwb8K9X0zXXrXAuWP6vTCU7K9GPUl5tu8tJvtCz
 1qF/MPmXRs4fG3LmNhQquQWGs1HJSH6R8/Umh/55YBJJrxiFlkwUhOMVW18NDcKeL88G
 psCrg3DtQX2PSA8Oh4mkNKNWnblVMayGehvr++J/VUT69AALRNxqcKxrmA24yfGu1adu
 3qaGpbnEPDrpOBlSLH+QOOGC8Ibv6y8T8EkrabngWgzfJGSSH6nWhy/cn5JxTGOA9Evx
 RXnw==
X-Gm-Message-State: AOAM533BijWkV93qXbZv4Vl17hFvwmejEuMqdnrRnVh/Far2LH7guzMS
 bB4xInmFSRbHD6nBRQCC4O+221B3Kx8zpE2A6Lir98uIcoH7hx3xy52TxZ4hWQx602qva7/Ctdd
 r7HunhzW1UgKW4BwN34fTKGU5eA==
X-Received: by 2002:a7b:c156:0:b0:395:b669:5c83 with SMTP id
 z22-20020a7bc156000000b00395b6695c83mr7053681wmi.141.1652338434242; 
 Wed, 11 May 2022 23:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyXJf4J232MvrKUWbwaiPp3FGyyip+AF1RPM/uoHxObgWZHdaCGStWwSfjgtB8rwzUcpS15w==
X-Received: by 2002:a7b:c156:0:b0:395:b669:5c83 with SMTP id
 z22-20020a7bc156000000b00395b6695c83mr7053662wmi.141.1652338434040; 
 Wed, 11 May 2022 23:53:54 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 i6-20020a05600c480600b003942a244f40sm1640432wmo.25.2022.05.11.23.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 23:53:53 -0700 (PDT)
Message-ID: <a38b92c1-50d9-52df-43b4-a7576531419e@redhat.com>
Date: Thu, 12 May 2022 08:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Add 'modeset' module parameter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Lyude Paul <lyude@redhat.com>
References: <20220511181935.810735-1-lyude@redhat.com>
 <CADnq5_OWH-Bat3OyCmHz6hTE++7hPLXqqMgg2=Nk6HB_Qk61JA@mail.gmail.com>
 <beb6cbd2-445f-c864-3283-ebdacaed37ac@amd.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <beb6cbd2-445f-c864-3283-ebdacaed37ac@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/12/22 08:17, Christian König wrote:
> Am 11.05.22 um 20:36 schrieb Alex Deucher:
>> On Wed, May 11, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
>>> Many DRM drivers feature a 'modeset' argument, which can be used to
>>> enable/disable the entire driver (as opposed to passing nomodeset to the
>>> kernel, which would disable modesetting globally and make it difficult to
>>> load amdgpu afterwards). Apparently amdgpu is actually missing this
>>> however, so let's add it!
>> You can already do that by passing modprobe.blacklist=amdgpu on the
>> kernel command line.  I don't think we need another option to do that.
> 
> Yeah, this already came up multiple times and so far we have always 
> rejected it.
> 
> Stuffing that into drivers is not a good approach I think. If we want to 
> prevent some device from exposing it's display functionalities we should 
> rather push that into the drm layer.
>

Absolutely agree on this. I think what we want is a drm.modeset parameter
that would have more precedence than "nomodeset". Because the latter is a
built-in parameter and so it can't be disabled at runtime using sysfs.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

