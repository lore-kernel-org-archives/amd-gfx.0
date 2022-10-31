Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1010FA3742
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 12:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FDC10E229;
	Mon, 31 Oct 2022 12:22:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282C710E24B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667218949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVJodACOlUyVw6jJB0o/QffeIPQi24/sF6MmyMfBvgg=;
 b=AD3YqiH6p2ttr44BpYQxrxqMRTPybN7R/b6HdOO7WVOug/Q1OjwZu85lR+0dhw9vB0ZNLp
 v7HafG6DmjwvnlLt3brJJxuyUzEl6cdvpUV5fqKr5ZAt+IBZq1/R/Xx18Uo02XSc4VOIrG
 Mu6cRHxrbzkM8L0aY3CeC+LMDI6BwZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-6zEr5iyWMA6_RYbwnF1VSQ-1; Mon, 31 Oct 2022 08:22:28 -0400
X-MC-Unique: 6zEr5iyWMA6_RYbwnF1VSQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 t12-20020adfa2cc000000b0022adcbb248bso2982332wra.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 05:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVJodACOlUyVw6jJB0o/QffeIPQi24/sF6MmyMfBvgg=;
 b=DMcbsdKEcfNIP8IXb9sXRt4uc61NKiWss2Di9buXRpzGEQ8Y02319vz8ihra71jwho
 QGEQLEKdSuL/FXVTf8hbXVj67nQAJub+q+zAanHBuqCEq4Oe5Klr+gBi+uwAXJiJeqy4
 Dfd+oxeJWVi+zvopzfOIDucK8vACSKQy/jshCTjMX1x18VIhhaRgJCvTx8ZNACNGfsNT
 LQw/OXyDkLbV7LkTjx8lRQAuDtG1MiTFjfBivIVJqhDTN600Fz8SYhj5BP4fqVAYHVr6
 RcV6LVKOrCxh8hq5iKiGlbYUN3hSMvTMGodRHzBElEO6cdJKQC3sriS1aaL4i/ToGnN6
 CcGA==
X-Gm-Message-State: ACrzQf1BmvFKjAE7k01OzCSgBj+TzVrDxBSInsoFjR0nSJlZLBg6lDus
 /ii4mPLN1JrHphf9uguVemBcFk4FYMIu+X0BupMDBr/pRWtIBC5vt3oAQ+M0ah3RRPplBD/Jgab
 rTk8M/t47os8fO5Ks/ZaM2i+vjQ==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f274:33b2 with SMTP id
 q14-20020a05600c46ce00b003c6f27433b2mr7860197wmo.27.1667218947043; 
 Mon, 31 Oct 2022 05:22:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zVdpLNc1mYDp74XAWVtjpPddzcwMDONTh4D+G0X15w3fKqsphKr/pP9hn5PrcknLAkhJ5Mg==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f274:33b2 with SMTP id
 q14-20020a05600c46ce00b003c6f27433b2mr7860165wmo.27.1667218946788; 
 Mon, 31 Oct 2022 05:22:26 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 f16-20020a05600c4e9000b003cf568a736csm5157904wmq.20.2022.10.31.05.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Oct 2022 05:22:26 -0700 (PDT)
Message-ID: <ea046b06-fb0e-b7c2-8f70-b299401d9adf@redhat.com>
Date: Mon, 31 Oct 2022 13:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 10/21] drm/tve200: Include <linux/of.h>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-11-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-11-tzimmermann@suse.de>
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
Cc: linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 freedreno@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Include <linux/of.h> for of_match_ptr().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

