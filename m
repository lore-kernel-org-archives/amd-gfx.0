Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0F810F582;
	Tue, 31 May 2022 07:45:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FB010E1E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653900795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhvgJCFXfv5RG+0oVTAct7gmCCzDguggkQSBJ+VAo/A=;
 b=fXliv7pHM2Jre6LMEQLlatcvDILw79rqi6Gypb6ohnbVrIBF4xpKqOggZPI9HNhPwX24+V
 1RchNcgvKJeYTD0ccHvO0yjR0zjGaFRhMXsa13qEmeqGGPbLcD+0MnTh8PJ048EfTuMFCr
 5BgyhjKhs/sYLII3dwdFnxfGFLTohC4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-Nlv_z6bWP9OShWvcOn60TA-1; Mon, 30 May 2022 04:53:14 -0400
X-MC-Unique: Nlv_z6bWP9OShWvcOn60TA-1
Received: by mail-ej1-f72.google.com with SMTP id
 bt15-20020a170906b14f00b006fe9c3afbc2so3819921ejb.17
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 01:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RhvgJCFXfv5RG+0oVTAct7gmCCzDguggkQSBJ+VAo/A=;
 b=TV403LZIcmtILG1rMYw6P7mIQyNPpdXUTNmoNAA1ZxSBEE6TfPvRQrMGhNuVDLykz5
 NFCRMyn8K0S2N7wPG3lCrjpSKeQr4JcAO/6DFlQ1rJhFtKcipRk4DkFvC2TwFDBEnPBO
 qKuNu6llUeLJPzDnwShG2Sb+jktmBtUdDS9+fOBC1GunqHnczUPgH7ZsY6kR810vXg6W
 hKR3lOaQ96dUeghsdnRMIbum8K2A5eqCJcVsftbBJ4rcXtMcdmgJ1OuMfROv804E6lVO
 Dq8hB0CYVZT2agUv0nAVEhtCoqCsQ3rdCUz7SAWsfSXIUQ3pqkBrmo3GZvrxhD1xo930
 o4gA==
X-Gm-Message-State: AOAM531pe7XUYOzzuVAgeadpyN1vkVnD6YojTnpVS8tRzfU6b4+3vLhK
 bpM3gqXcJ0WMEOMJVn8VHz1LpXKJwJNBRtMrMYXcOE8OrLZBdjVCOndhztz3V+MRy/ORc2lEbkf
 6b14NtmaUDUY/inpqDkRqHaOzeQ==
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id
 sd32-20020a1709076e2000b006ff15418d34mr20498805ejc.447.1653900793061; 
 Mon, 30 May 2022 01:53:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLS9X1+J2YlCZd50xUKza5F2TAaKjqsoBWgZZta9P6P5hLJgXAWFm13+BAHE9yuTPrdLSHXw==
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id
 sd32-20020a1709076e2000b006ff15418d34mr20498786ejc.447.1653900792873; 
 Mon, 30 May 2022 01:53:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a1709062f1000b006fea2705d18sm3807438eji.210.2022.05.30.01.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 01:53:12 -0700 (PDT)
Message-ID: <a8d1fe13-e747-016a-2d45-bfb50f23f2d9@redhat.com>
Date: Mon, 30 May 2022 10:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 0/4] Separate panel orientation property creating and
 value setting
To: Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20220530081910.3947168-1-hsinyi@chromium.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220530081910.3947168-1-hsinyi@chromium.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 31 May 2022 07:45:33 +0000
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
Cc: Rob Clark <robdclark@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 5/30/22 10:19, Hsin-Yi Wang wrote:
> Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
> orientation. Panel calls drm_connector_set_panel_orientation() to create
> orientation property and sets the value. However, connector properties
> can't be created after drm_dev_register() is called. The goal is to
> separate the orientation property creation, so drm drivers can create it
> earlier before drm_dev_register().

Sorry for jumping in pretty late in the discussion (based on the v10
I seem to have missed this before).

This sounds to me like the real issue here is that drm_dev_register()
is getting called too early?

To me it seems sensible to delay calling drm_dev_register() and
thus allowing userspace to start detecting available displays +
features until after the panel has been probed.

I see a devicetree patch in this series, so I guess that the panel
is described in devicetree. Especially in the case of devicetree
I would expect the kernel to have enough info to do the right
thing and make sure the panel is probed before calling
drm_dev_register() ?

Regards,

Hans




> 
> After this series, drm_connector_set_panel_orientation() works like
> before. It won't affect existing callers of
> drm_connector_set_panel_orientation(). The only difference is that
> some drm drivers can call drm_connector_init_panel_orientation_property()
> earlier.
> 
> Hsin-Yi Wang (4):
>   gpu: drm: separate panel orientation property creating and value
>     setting
>   drm/mediatek: init panel orientation property
>   drm/msm: init panel orientation property
>   arm64: dts: mt8183: Add panel rotation
> 
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
>  drivers/gpu/drm/drm_connector.c               | 58 ++++++++++++++-----
>  drivers/gpu/drm/mediatek/mtk_dsi.c            |  7 +++
>  drivers/gpu/drm/msm/dsi/dsi_manager.c         |  4 ++
>  include/drm/drm_connector.h                   |  2 +
>  5 files changed, 59 insertions(+), 13 deletions(-)
> 

