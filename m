Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D76C7115A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 14:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484810EA6E;
	Thu, 19 Jun 2025 14:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ffw1EAgp";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD8710E8F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 18:19:04 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-73a01a7bee7so2212596a34.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750270744; x=1750875544; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vep4PV2pZ+9tPEurvQr9lDJXe4H1SpULEo3WQUGiLXg=;
 b=ffw1EAgptSdt8V7oUafyYAXj+EncLPgrW123LtlSqZ2IwaiaztBtCzmwjnSsTvs4oX
 1KF+TiYfBqTjc6fgm2UFPkvtPCYQMiZI189rWnHiowYZ4u9tNZu8+SkJ1nChxM7PIcpQ
 4tPFA4Pbp1uB1EOKfiJBKobpP3tXJE9ZwAw4wSYXOBmVeLB1sCaYmfCGl5EPO0HDumjc
 Uc/3hqDourSYmpPtpUstQ3Ud/EOQ3K0KU526eiIuDhZ1FrdTTz7GPKnWm+Lxto0x6dyc
 kCgVlgWTKsImJb4oP7lCRrrF65RnaY+1n5AeHuzjM2WLRsaQ5SKDqcqIucU5+8wUET+a
 Sziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750270744; x=1750875544;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vep4PV2pZ+9tPEurvQr9lDJXe4H1SpULEo3WQUGiLXg=;
 b=vHz2zWbjBZ9iiEveTGaw65sRXAW9k+P6YT+oTOyrkssUtAXZyafjO8B9m7s7jcEDIp
 Mc8g2kgLVlkkQVVAQPKXHhdrpOMXKPXbOYi9+ttxtHHIveNzmovqK9Fq/6Rgm+9+iWUH
 owIsbNUr3uzN407fPCma53gtGxuEoZ5WiBi5jgqAPPyu9/qZYP0YRyBK5SXPrMpAZrDy
 DCBIY7KMPg7fKI7rFkoYOAa44YdG8fuWp/jdysj1FsXZOLjnbGr7SbRqXaR/vevoW44Y
 KTCQ1Z9hzkNpdbu4tRSD/HLib70HOSTvgvWLFVLVw2LwCz60zGxuOzfLY4OqPXT3qwsD
 1RGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoRHGOIOo/TV8lmqKnkN/D8MqTYspAwDr1Y0Sr6SMLQVSaEyL0m+e4UUgETqbZwozTZbaTD76e@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKOJ2O3DHuxatXknuvXVIBEcpXy1CybxGLmNiL7bxlgyyUDLRv
 gOVkZY/We+XZvUGdB7BBoOtvF0F8c0yOFwFabxQldOfozeGg7UgwxncAk/AzcSB6xHc=
X-Gm-Gg: ASbGncvcE6KH84e+Mhoi0PFLJe6LWMZ0TC3r5oT7BKixGncz20qf4lgaLYDDUXSmYdj
 hriJfhUGyO/yRapjAdeA9U9R7f/ljMQwHZ+fiwcJ6z2diG5wEOemDSaFZJDsprVE/9Lhw8JXf0N
 9mUzRSrnsgv0PXaVICyiP9W/26DkyQ3ABxfje++V2AUmvwYM9kcK2LQZLDnEOTBQSxSrGTroJYS
 BJ+F1u+y9uGoBy9BJG4RisMy0uRV8gU0S7ECQK8kW/vmH+suNvDJrD5sKaPKHMPk6NhYLKnMJ0T
 VTE3y3aknx4ODeyViq7+W0GiDlWsr5+e60pq+PPBQyu7UJGALzrZbk8IZl5HX7M92wuS1Q==
X-Google-Smtp-Source: AGHT+IFKnX0nztNeiuWkt0W77J0j5V4cIVncVTmr2DaNrpLni49egH0ASp6YufKpwNA2PVb7YBrY6Q==
X-Received: by 2002:a05:6830:6f42:b0:72c:320b:f827 with SMTP id
 46e09a7af769-73a3626800cmr11319258a34.6.1750270743621; 
 Wed, 18 Jun 2025 11:19:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a28403dc8sm2055669a34.27.2025.06.18.11.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 11:19:02 -0700 (PDT)
Date: Wed, 18 Jun 2025 21:19:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Melissa Wen <mwen@igalia.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev, cocci@inria.fr
Subject: Re: [PATCH v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Message-ID: <7ae66816-f682-45f1-b848-eeb5a57a68d9@suswa.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
 <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
X-Mailman-Approved-At: Thu, 19 Jun 2025 14:02:00 +0000
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

On Thu, Jun 12, 2025 at 11:08:10AM -0300, Melissa Wen wrote:
> On 06/10, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 10 Jun 2025 07:42:40 +0200
> > 
> > The label “cleanup” was used to jump to another pointer check despite of
> > the detail in the implementation of the function “dm_validate_stream_and_context”
> > that it was determined already that corresponding variables contained
> > still null pointers.
> > 
> > 1. Thus return directly if
> >    * a null pointer was passed for the function parameter “stream”
> >      or
> >    * a call of the function “dc_create_plane_state” failed.
> > 
> > 2. Use a more appropriate label instead.
> > 
> > 3. Delete two questionable checks.
> > 
> > 4. Omit extra initialisations (for the variables “dc_state” and “dc_plane_state”)
> >    which became unnecessary with this refactoring.
> > 
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> 
> Hi Markus,
> 
> Thanks for working on this improvement.
> Overall, LGTM. Some nits below.
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@intel.com/
> 
> As the patch wasn't merged yet, don't add these two kernel-bot-related lines.
> 
> You only need to add these lines "If you fix the issue in a separate
> patch/commit (i.e. not just a new version of the same patch/commit)"
> 

If you're going to fold the fix into the original commit then it
doesn't matter what the commit message says since it will be gone
in the end either way.

regards,
dan carpenter

