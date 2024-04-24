Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06562C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F68211A27D;
	Thu, 25 Apr 2024 08:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xRTRROsU";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024F10F9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 13:39:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-41b2119da94so1864935e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713965949; x=1714570749; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eIDjR8nmsolOxVRznr4LV9PEh0hWdtOUeRoonddM+RQ=;
 b=xRTRROsUgQeECsYTTq9oKBkPs0xH5BqLp1XgagpEHu8TPZkSwnhyuyjH4syVmdhav+
 vmj3eqTW8NGEevu8Nk3cIEDqFnnT9+0CKx6KYpxvb6DiNothYQtr1Beq7gWGKEJoiMn3
 ogm1mL2kYpj5pEFzm9IBWO5+U9m8L+Bsy/j36iH8qadBvnlZWTS3FdFw6y2W9McQo9N4
 rKqqQCiro+HsVH/Vr3PYc9Rxb6HJ/B69UM2JTR8AQ7UziJk0kR1csy/AJ5XgxKlVAM5o
 WbJgauWruEAd5gqPwtjcyR8+Z2ngulr4T5eXA+rCj2CmOF2va/WguvT6CDV8utHv61JS
 ejdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713965949; x=1714570749;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIDjR8nmsolOxVRznr4LV9PEh0hWdtOUeRoonddM+RQ=;
 b=CHmbtskaTkU+WTTLiqxzK6PPz4kCR9Cz8kCexLqUVJithEr85V00xCsbrBgu/wefHx
 KtzZcSRGL0X0WSrRGYsMBy3RXgOhArkOvXWtUkjrZdIAIMFmD9lyudL9v18WE7n6RrJt
 a7n+h+WF1NHIZQUCQpueB/WWMuckETqAW8yypOr7QK1npgs7/2nuNKil4Er68pg1NDer
 WX2v/rRRLoVScvdhJ9uXXBPwLzmUVJ0aqwg3ypy0vouIVngF3Ez+ZwOaczOTzaggO4aQ
 HDOtV/itG1LYaKWRIalKIeuW6Mh4wqzssjPwXP9LGfBQ3as8LRl1g5y4R6TfPmQ7VueK
 1Gxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfEnMYbzJz09AnIj0KcgSf9OUKgRlsrXHAT9NovSCA5phjCwDAuvmON5dQpIUitVX1UfZewbEBIJ7xayLBqDy53Wy/Y7HNpAufYsidwg==
X-Gm-Message-State: AOJu0YxOz+Nbiuvj2tVXenGPBPy8KphKnVmzTeMSa2z7suFL2ftj480e
 5z826LyXODaPV82lWTuuvP72if3AzT9+6wVmoG9Xj0if+cOPohoWnW3wdZ1eLKc=
X-Google-Smtp-Source: AGHT+IGNGlL4K3RRWvrPnAS8pS+Nk+ThgYEusmDN6lyoq8bygca8tJqniABTWOqIDwkwqhh9NtmiVQ==
X-Received: by 2002:a05:600c:1c13:b0:41a:3868:d222 with SMTP id
 j19-20020a05600c1c1300b0041a3868d222mr1706203wms.0.1713965948935; 
 Wed, 24 Apr 2024 06:39:08 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 fj3-20020a05600c0c8300b00416b2cbad06sm27796791wmb.41.2024.04.24.06.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 06:39:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:39:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: re-indent dc_power_down_on_boot()
Message-ID: <d3a49914-65de-492f-9bf4-f3daa0c9f3cb@moroto.mountain>
References: <e5f538ab-ebc8-400b-8104-4642b8089b4f@moroto.mountain>
 <bbc315ed-3482-4abb-b3f6-88c335dcf9d2@amd.com>
 <4a996c51-e101-47a0-8a89-78c6f9f01e0f@moroto.mountain>
 <f3b0e0fe-edb9-420d-b4a1-71c267246875@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3b0e0fe-edb9-420d-b4a1-71c267246875@amd.com>
X-Mailman-Approved-At: Thu, 25 Apr 2024 08:11:24 +0000
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

On Wed, Apr 24, 2024 at 03:33:11PM +0200, Christian König wrote:
> Am 24.04.24 um 15:20 schrieb Dan Carpenter:
> > On Wed, Apr 24, 2024 at 03:11:08PM +0200, Christian König wrote:
> > > Am 24.04.24 um 13:41 schrieb Dan Carpenter:
> > > > These lines are indented too far.  Clean the whitespace.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
> > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > index 8eefba757da4..f64d7229eb6c 100644
> > > > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > > > @@ -5043,11 +5043,10 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
> > > >    void dc_power_down_on_boot(struct dc *dc)
> > > >    {
> > > >    	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
> > > > -			dc->hwss.power_down_on_boot) {
> > > > -
> > > > -			if (dc->caps.ips_support)
> > > > -				dc_exit_ips_for_hw_access(dc);
> > > > +	    dc->hwss.power_down_on_boot) {
> > > > +		if (dc->caps.ips_support)
> > > > +			dc_exit_ips_for_hw_access(dc);
> > > Well while at it can't the two ifs be merged here?
> > > 
> > > (I don't know this code to well, but it looks like it).
> > > 
> > I'm sorry, I don't see what you're saying.
> 
> The indentation was so messed up that I though the call to
> power_down_on_boot() was after both ifs, but it is still inside the first.
> 
> So your patch is actually right, sorry for the noise.

Okay, but let me send a v2 anyway to delete the extra blank line.

regards,
dan carpenter

