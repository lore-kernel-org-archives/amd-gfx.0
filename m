Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40CA610E368;
	Tue, 20 Dec 2022 09:41:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF17210E368
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
 b=Q7jkLfxfQyiVWjzUv3393IF/8mCrQ9TZ9s6dwDLyZ99VDb/GAZq6bIz8xyEPDG3NfOk4zs
 6/tDcV8bymcDeSxlbBstDpqqalm+ZXDxIn2xET0fmscdXAXR2+BokOLmmIS0oUTHYV6ac2
 guSt9PWz6+DI0yefZJgGvsWaldavAaw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-Q2nb6BdEOMGvkuX3pS7PnA-1; Tue, 20 Dec 2022 04:40:58 -0500
X-MC-Unique: Q2nb6BdEOMGvkuX3pS7PnA-1
Received: by mail-wm1-f72.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so7798654wme.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
 b=BbxOGbKNAxjxhAyoMfO3kCzfd+nCUa73nsZ4Uy8x6/vxou6bInK7zmLfvJg3QPYtrD
 6hcfm2itkkOxovTJosfnpQsPju/wW06tU4Zba9I/uaN+F5iaOzb+adDq9lGstxmcxMuJ
 7PjLvPAYMxlbSVNBNEnmE4KJb9hGeAWCAv48rlUeTm+fk/VmJuzLHc7zxQd2Kf5aRrmQ
 TEoDpk80nJo5mNF6nXbEcl9DNqu0qrrmkphg6NEdAZ6vRRYH4QODQ5wQtim+5byPvRgO
 RMPHDizORqkVuovCKsekCFJ/enknwupWn2YraVyeE1r/Hvi2TswoaXlgGJ7bn/byzrfk
 U94g==
X-Gm-Message-State: ANoB5pmDrFXqc+OZX+8Q10eQcd21Mivjdfjrcr4Ff0UfICGKs1+l7M2u
 FA/yl9Z61EPvDwkaFtLA/TqYe+xhWmc2Kf4gBJQUQTNdbcL6mr3bs2qqcg/wJb1pCTxpz33fzgH
 pF11f4P0JNko46hMRN21RPQwHMw==
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id
 j35-20020a05600c1c2300b003d233766f2emr22381405wms.9.1671529257842; 
 Tue, 20 Dec 2022 01:40:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eSfSzTvRvhDpxH502Pk0KEhQEu8qDdlhID/m63O9KppBhxg3tASNRV4SrXUiQOLpYrNpaag==
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id
 j35-20020a05600c1c2300b003d233766f2emr22381388wms.9.1671529257649; 
 Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 by3-20020a056000098300b002366c3eefccsm12187201wrb.109.2022.12.20.01.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Message-ID: <6b3825fc-e149-9096-0438-0fb2c717f3d6@redhat.com>
Date: Tue, 20 Dec 2022 10:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 15/18] fbdev/vesafb: Remove trailing whitespaces
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-16-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-16-tzimmermann@suse.de>
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

