Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C264C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 10:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D117810ED8E;
	Mon,  2 May 2022 10:50:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF1C10ED8A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651488599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TKyHWDgC93OfXdwv3f/QQ+fWpsgCb5Bjp407TIVwrw=;
 b=DAqtLe5X0+i4+6MQPjnTWKSQZ0OB07BWxS2oSWaXHe3jciRMY1mboNGC9jF9h8IvSt7n7O
 jxrYTzmHRH18zldzu2cVGOFmIYwNUK7ebeG5X0C/C9rn1uhmHIr+GdPqRWX6hkLLkpn+0G
 MXadIZM+DSL50TqG5O/v7y5DKu8In+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-RHxOdyuCOYqOiAP7Vj_avQ-1; Mon, 02 May 2022 06:49:56 -0400
X-MC-Unique: RHxOdyuCOYqOiAP7Vj_avQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 t17-20020adfa2d1000000b0020ac519c222so5155687wra.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 May 2022 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3TKyHWDgC93OfXdwv3f/QQ+fWpsgCb5Bjp407TIVwrw=;
 b=smXx/fkkgPHwM8yonTACDcz7tZnwb8B89UV4JJ0hgLxscaearOqI9ya9FPcAp7B+pT
 4Vx+PxhSZN8jDEQSTt45gqcxNzF6H/RXDsto8oXihS1etJZNV3Sb76mfZi3MZZ+uf8Zq
 myFiw2D7RF2MBLA8qeZh4YcMsiDDPgyu9M1jh0PT4D0G7Ns8T/He5X2LuRkcnZbpJPA7
 omAZQCyVkYznka0UdHJDo0C3cBuS5wK2gUMB2L9K9+XX6PB+iFdNuNtiMdpvAk6tK5oC
 nBJtVJ6NJ+Us4scZ8HBi7tWa+UGN0J+L4uB8zQT9uxlhjQqXgOqdHgA8t9sSwHVKn39Y
 3Z2g==
X-Gm-Message-State: AOAM53000QNudYoRQr3EJNuJHTEiGkX5DbJPkwIjcG1cuiagRASEvaHz
 ZgKuZRHLy7sWdWlbCmw5KruPCjBNx6In9pjEAT5fSoXic2kqfvKDsmuYihDqOJpSfFOPIlAWYac
 9e+zugC/fxpgXY1jJfgbJhoJ2Mg==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id
 h17-20020a5d5051000000b0020ae005cca3mr8676800wrt.560.1651488595433; 
 Mon, 02 May 2022 03:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznK7MTrWwTm+wtuLbm1AtWbuZrM/hnsYDFHNU2iLGSqHpPTjz/i73gvAXGyZ+XCXckc/fOrQ==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id
 h17-20020a5d5051000000b0020ae005cca3mr8676723wrt.560.1651488595161; 
 Mon, 02 May 2022 03:49:55 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
 by smtp.gmail.com with ESMTPSA id
 w7-20020adf8bc7000000b0020c5253d8f9sm6707583wra.69.2022.05.02.03.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 May 2022 03:49:54 -0700 (PDT)
Message-ID: <1d2a03f7-d4f6-66ac-6e2e-adbd2eaf7d90@redhat.com>
Date: Mon, 2 May 2022 12:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20220502084830.285639-1-javierm@redhat.com>
 <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-aspeed@lists.ozlabs.org, Neil Armstrong <narmstrong@baylibre.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Paul Cercueil <paul@crapouillou.net>, Nirmoy Das <nirmoy.das@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-stm32@st-md-mailman.stormreply.com,
 Jyri Sarha <jyri.sarha@iki.fi>, Jerome Brunet <jbrunet@baylibre.com>,
 Marek Vasut <marex@denx.de>, Hao Fang <fanghao11@huawei.com>,
 Evan Quan <evan.quan@amd.com>, Emma Anholt <emma@anholt.net>,
 Samuel Holland <samuel@sholland.org>, Kevin Hilman <khilman@baylibre.com>,
 Alexey Brodkin <abrodkin@synopsys.com>, Michal Simek <michal.simek@xilinx.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Joel Stanley <joel@jms.id.au>, Alain Volmat <alain.volmat@foss.st.com>,
 spice-devel@lists.freedesktop.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 linux-sunxi@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Chen Feng <puck.chen@hisilicon.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Alison Wang <alison.wang@nxp.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-mediatek@lists.infradead.org,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-amlogic@lists.infradead.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 virtualization@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hyun Kwon <hyun.kwon@xilinx.com>, Tomi Valkeinen <tomba@kernel.org>,
 Boris Brezillon <bbrezillon@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yannick Fertre <yannick.fertre@foss.st.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-mips@vger.kernel.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-renesas-soc@vger.kernel.org, Solomon Chiu <solomon.chiu@amd.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 Shawn Guo <shawnguo@kernel.org>, Claudiu Beznea <claudiu.beznea@microchip.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Thomas,

On 5/2/22 12:35, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 02.05.22 um 10:48 schrieb Javier Martinez Canillas:
>> Hello,
>>
>> This series contain patches suggested by Thomas Zimmermannas a feedback for

Ups, I missed a space here. I meant to write "Zimmermann as a feedback..."

>> "[RFC PATCH v4 00/11] Fix some race between sysfb device registration and
>> drivers probe" [0].
>>
>> Since other changes in [0] were more controversial, I decided to just split
>> this part in a new patch-set and revisit the rest of the patches later.
>>
>> Patch #1 is just a cleanup since when working on this noticed that some DRM
>> drivers were passing as preferred bits per pixel to drm_fbdev_generic_setup()
>> the value that is the default anyways.
>>
>> Patch #2 renames the 'preferred_bpp' drm_fbdev_generic_setup() parameter to
>> 'options', and make this a multi field parameter so that it can be extended
>> later to pass other options as well.
>>
>> Patch #3 finally adds the new DRM_FB_FW option and makes simpledrm to use it
>> so that the registered framebuffer device is also marked as firmware provided.
> 
> For the whole patchset:
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks a lot!
> 

Thanks for the prompt review!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

