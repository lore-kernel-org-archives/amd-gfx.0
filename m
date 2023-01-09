Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C732C54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 12:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE1810E418;
	Mon,  9 Jan 2023 12:50:41 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C94110E413
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 12:50:35 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id o15so6168083wmr.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Jan 2023 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OwZ7m6tA/I7tqsHoGdb3tVqan4AavH0yuZk5xNJc1Kk=;
 b=jjrQj/zmDS8Pug/7xzrgv5TkvIrPhzts0GGGPTpzJ3484QV/tE8j1c9BTT8Yn+h1VT
 HdlLTKipVS9TFrAVmAStgv3Jyj5so5vRNP2h58vceUssUF1AhH8WqX97GQUD6NLSgVQA
 t1QZ82NZkpz8jqsejBLZwMHytTj6kv7Uo7DZqDDU+hA3WN6ZaM2o6Mn2n3JZY9O2oUtB
 eROI2vDQklpghZw8LALRRF0Dic30G0HIoTr1QbqnHFQgU/2voe6srdI+NCluvzgD73UK
 f6KI7OxsnZ+pDCsED3hSsdWtqUbp52cPNfuAT+HTmQAoPGdxbT1Xt+xLF9HphvEJdpgk
 fw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OwZ7m6tA/I7tqsHoGdb3tVqan4AavH0yuZk5xNJc1Kk=;
 b=kWspUc/abxG0uQ1cy8Qn15J5k+FL8DWdBxzwaXWm/WJAWGtjtaKrYf5nAFbdm3nA+I
 3ES27qsan+6AaG7UIWiedIaqvRXph0N8Tf0Zw9LJXLW2u95WP4dfhTcLTM1oqO0/WhgP
 /hTSKRlLOIfc+ZBh+mll83tqv2BwIZeeRIljFKubc8dQyD04TQAqIWXGGu07OaPS4IXz
 4Mtt9biiu9ga7F+zfZBk5yBkhH+z2v7URHix8pG/tc5XP557I/8AYIcsF6AlhjTUy++P
 IOJ8PoJ/lYBRHydalqkqoq5aSQ4wvbQOVETtceR5N/UwY6OMKwM0yhdDWt5w7Z64qCz8
 dxGw==
X-Gm-Message-State: AFqh2kom/EuFe9nIUpCBv10xy+Adkr+AtbUZ9EC3hYo7ukqR8W375Ihx
 HhE0TvbqQxRVCqs6b/WLg2i0o4riszTS7fbz3ZY=
X-Google-Smtp-Source: AMrXdXtl89GZOaLtnX+eQkRYvFBrKoBDlMfwzE2UW1Fi7vYJ5Tpb3cOSeBYrQNYa1PFBg+nF9gx4jA==
X-Received: by 2002:a05:600c:5128:b0:3c6:e62e:2e67 with SMTP id
 o40-20020a05600c512800b003c6e62e2e67mr47468345wms.2.1673268633947; 
 Mon, 09 Jan 2023 04:50:33 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 j30-20020a05600c1c1e00b003d9f14e9085sm2889322wms.17.2023.01.09.04.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jan 2023 04:50:33 -0800 (PST)
Message-ID: <d00cf1c5-b95b-f8f8-4782-2cfc64bec969@froggi.es>
Date: Mon, 9 Jan 2023 12:50:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 4/5] drm/drm_color_mgmt: add 3D LUT to color mgmt
 properties
Content-Language: en-US
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>
References: <20220619223104.667413-1-mwen@igalia.com>
 <20220619223104.667413-5-mwen@igalia.com> <Yrmf+mWk13qkcsfs@intel.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <Yrmf+mWk13qkcsfs@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com,
 airlied@linux.ie, Rodrigo.Siqueira@amd.com, Xinhui.Pan@amd.com,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 nikola.cornij@amd.com, sunpeng.li@amd.com, alex.hung@amd.com,
 mripard@kernel.org, tzimmermann@suse.de, harry.wentland@amd.com,
 alexander.deucher@amd.com, seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
 nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/27/22 13:18, Ville Syrjälä wrote:
> On Sun, Jun 19, 2022 at 09:31:03PM -0100, Melissa Wen wrote:
>> Add 3D LUT for gammar correction using a 3D lookup table.  The position
>> in the color correction pipeline where 3D LUT is applied depends on hw
>> design, being after CTM or gamma. If just after CTM, a shaper lut must
>> be set to shape the content for a non-linear space. That details should
>> be handled by the driver according to its color capabilities.
> 
> I also cooked up a WIP 3D LUT support some time ago for Intel hw:
> https://github.com/vsyrjala/linux/commits/3dlut
> But that dried up due to having no userspace for it.
> 
> I also cooked up some basic igts for it:
> https://patchwork.freedesktop.org/series/90165/
> 
> <snip>
>> + * “LUT3D”:
>> + *	Blob property to set the 3D LUT mapping pixel data after the color
>> + *	transformation matrix and before gamma 1D lut correction.
> 
> On Intel hw the 3DLUT is after the gamma LUT in the pipeline, which is
> where I placed it in my branch.
> 

If the problem here in getting stuff moving for 3D LUT support in DRM is 
lack of a userspace that wants to use it, I would like to just make 
people aware that we are planning on shipping support for this in 
Gamescope/SteamOS.
(It is hooked up right now in the current Gamescope main branch).

We have pulled the patches for AMDGPU by Melissa into our tree and 
hooked it up (with a prefix VALVE1_ before the properties for now as 
stuff is not upstream in the kernel yet) and it seems to be working well 
right now.

I know that the work here not final, and we will definitely change it 
and update our kernel and userspace impl to accomodate that and are more 
than happy to provide testing for this work and other color work.

I understand there is a lot moving right now, with the new color API 
being proposed, etc; but I don't think this should necessarily require 
us blocking any 3D LUT, shaper LUT or other color work on the 
"legacy"(?) path while stuff there is being planned out.

I think it's really important that we keep moving with color support on 
the legacy path while the new one is being planned out to ensure we 
don't accidentally miss something later or end up with something 
suboptimal for a specific vendor.

- Joshie 🐸✨


> There is now some discussion happening about exposing some
> kind of color pipeline description/configuration properties:
> https://gitlab.freedesktop.org/pq/color-and-hdr/-/issues/11
> 

