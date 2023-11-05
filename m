Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E4C4167D
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 09:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678EE10E28F;
	Mon,  6 Nov 2023 09:00:04 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3308210E11A
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Nov 2023 17:55:58 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so33666845ad.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 05 Nov 2023 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699206957; x=1699811757; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=HIXC95EsfE1M+IH5iNxhZaF/mLKVXVH52rDOYhksDf4=;
 b=KW47Ns1nmomh1fZR7dM11DbKIXxhEuZJKmK8tOUtewm5JYA0tZ4yH0i0aIh0Z4gMrU
 3F9NHqR6c6dxA7b08bHe3RgoVVaJnWw7dA3XxzdzcCaPzoar80zeweYkggFQ1F9AOP5S
 HzQrS+JnPftFLpne66VXJRxtcBBCkSq11CDxJ8gFvkqFtMUkbWKIjfwc1OH2xqzJzXwG
 YXsuOmEMa8DD1eiwqAUn4BZl09k3DiZHPlEQyrw6cUDP631bGRmOew4YPPvy7vt5R6aK
 1hj/dPxVAofcRDdRT+AW57Wwe5yxk9bY49PiECpGwArHZ1du8p0u3NwXEyroMBwI3S5/
 Ixng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699206957; x=1699811757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIXC95EsfE1M+IH5iNxhZaF/mLKVXVH52rDOYhksDf4=;
 b=rI2gZRihp7FjnsHO419k1QUqorMKG5hY8xqDiqWFJshxEgfhQhIxJwLgiTthkHle8D
 pygIfz0p90uWgE6jKrIJI8NAWUgx5RTDLNcu5BJyX9FvsBKRHuyNqdBtoAOpYTszqJxD
 rdnMFFMU8XBuhs8T0qWHIKsWR8YZjaKsyZEXT+4onS0cJ288cMIyHt+4yJUqw8mvVclz
 2WcptpVDMp1FPNTuUKU79xOy7ffQ+Nmns/Dt7tMOIu1GexHEfG74HuykhI3IPZo8ez9u
 18nAI0CwESX1wjqiwsGMvMxgMQ0T1cB9iZ7sUFBcGb1/XUBBUyG4hY37a7fXaM26aph1
 V04g==
X-Gm-Message-State: AOJu0Yzj2H1acrm1GWkzbbehI9qKMJZBxNejGbry9sLQ6PYcL902dTA8
 cU4wMQO1molAj8A+JrJikX0=
X-Google-Smtp-Source: AGHT+IFBLGY54PYhYsI+r9J0zFjt+Lj9MUAmvwx6SjMhszUI82oqENWEtbcEZk5jA75+E2fw/54IEQ==
X-Received: by 2002:a17:902:ecce:b0:1cc:59a1:79c6 with SMTP id
 a14-20020a170902ecce00b001cc59a179c6mr22992191plh.18.1699206957551; 
 Sun, 05 Nov 2023 09:55:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a170902db0f00b001c7443d0890sm3062865plx.102.2023.11.05.09.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 09:55:56 -0800 (PST)
Date: Sun, 5 Nov 2023 09:55:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix stack size issue on DML2
Message-ID: <aa6344f8-abd4-4f9e-86cf-febecd6fd747@roeck-us.net>
References: <20231016142031.241912-1-Rodrigo.Siqueira@amd.com>
 <20231016142031.241912-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016142031.241912-3-Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Mon, 06 Nov 2023 09:00:02 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 16, 2023 at 08:19:18AM -0600, Rodrigo Siqueira wrote:
> This commit is the last part of the fix that reduces the stack size in
> the DML2 code.
> 

That does not really help when trying to build allmodconfig or allyesconfig
with gcc 11.4 or 12.3.

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In function 'dml_prefetch_check':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6707:1: error: the frame size of 2056 bytes is larger than 2048 bytes

This is with v6.6-14500-g1c41041124bd.

I am overwriting it by forcing CONFIG_FRAME_WARN=0 in my test builds for
x86_64, but of course that affects all code. Maybe consider increasing
frame-larger-than in drivers/gpu/drm/amd/display/dc/dml2/Makefile ?
Currently it is

ifneq ($(CONFIG_FRAME_WARN),0)
frame_warn_flag := -Wframe-larger-than=2048
endif

Guenter
