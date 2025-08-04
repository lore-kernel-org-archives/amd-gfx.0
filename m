Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36AC87FDA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 07:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6FA10E607;
	Tue,  5 Aug 2025 07:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jOmICTFZ";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4F010E58B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:49:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4589968e001so29444515e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754318962; x=1754923762; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5MAh85Y0saa+euoszKw3nA4pGBPwcX9w5nxBz0NKd0A=;
 b=jOmICTFZDI18/jzZqAipD8SqJV3spTOLCUs7melJIJwhrwgE7D+SW5DIuBnqD9RAkN
 FGfG3yASw1tYAQvO0W2YW3FpPOWh43dWKOX4k2LsuDtFL3s33fJrn2bTRQG1wJ7dfdDC
 YPG/YfCbLqB9ZA7BhBleej6eFrbwSOkXe2aUTmd7KY/DqpMCzOEE4sjSVlqNNm4k7sG2
 yRH8g78UKgj2pn/e1E6h6MRTHnGLAJFgaJztfdh1gWq6xxS/uxTqG8tJcjzad9WGAUkb
 I9JRWeY/BWRdM1zhqFyImt6U5ScRsw/IFq8ozWHYOkXqgbCBKzOA+HttkGWtHX6b25cp
 BDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754318962; x=1754923762;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MAh85Y0saa+euoszKw3nA4pGBPwcX9w5nxBz0NKd0A=;
 b=tIxYAitn8S5UjPBBgg0LBfrk7qxB7UGzHZQYeZiV/slFnI+sml8qShMLXriid8UhiC
 WqQeZeYOp4nmyY8TpsFF6VcOScpbgDiIOXpNB+eCyW69o/BV+1C5x7gNIGjz48Ri5ssE
 N72WUZzu6kEyo0IKl8bJwktFLTccAWbkThM/bi9TScCvwBr6ha5y8WXDfEsuByHfTxZG
 PvfNzM8frX7fMumeyGIHCJA9sj6eSKt4HXy4vp3HGhyAjDLV/vKopvU/NVut3GHa9rxh
 g5Qwdg7aY3qtHm5IErL7DnP3dBSTsE9j6Jj7nrTd7NvjoScuaMYn0xqSmRPMzEBGOxoY
 PWVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvrNvrubuM33dg2YZQhIKNccZ1hqvhXzTb2+OQ0KDrRt3ZNDOc1+jCqFCWqrAwU7lJixpNma/3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc6IIQYb/1Ik/AG7r4dFFT0BDfkvGyuaK4lCtRLhSqdP0K5Ecj
 vA5XtiNAXmr5HXWbJsy1vAC4wxyPgyP6ICI7S1Y0Ner0DmPB0JSp8NmBMoIn5oUCqQ4=
X-Gm-Gg: ASbGncs6w5nOhXfJlx5ANWEA5OJuILZh+EbKsHHl1roWNBe+I2CoFzisUe1Cd44/Q0e
 tEmoccMIkiDxBDGcCDHk8n0kw9aH0BeByrvQ1CTOWc4PjsQ1eFY2JPxheMLqUIM0+RA5wNJL4u1
 VUkssd+olBaMeBhnSSze2/xIdz1M/5cPvwNvqZoq1pvvx3eJP+hGujdma4mhzAtAudvatJZOD/1
 ldtvhb/aggn90eD6K6H7ndy6fuqrteVsFsL0gNrtuVb7LJkDK7L3Yi8NscVJOE0o3no7VM6LV/C
 VfKIxbHZmJ+/Srm20/jKgLGwiEIngL8nHuOLsktmXHPBaJx5UTtIrPll8jbqv5ENnKhcKnt9dFK
 sRmojmkvbOK+JIa1e0rsw/43YhiEWtuWCz+bTeA==
X-Google-Smtp-Source: AGHT+IExUksj+hCR+gj7NMUPXAk78VVx0bqD4AGsjGqehS5x2aQlIlZBpW0rJUPuZBL200EPhOnGsQ==
X-Received: by 2002:a05:600c:3b9f:b0:458:bc3f:6a72 with SMTP id
 5b1f17b1804b1-458bc3f6d41mr61463425e9.4.1754318962444; 
 Mon, 04 Aug 2025 07:49:22 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458a7c91c0esm150589255e9.11.2025.08.04.07.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 07:49:22 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:49:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
Message-ID: <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain>
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 05 Aug 2025 07:11:43 +0000
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

On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> On Sat, Aug 2, 2025 at 4:22 AM Ethan Carter Edwards
> <ethan@ethancedwards.com> wrote:
> >
> > The repeated checks on grbm_soft_reset are unnecessary. Remove them.
> >
> 
> These are not NULL checks and they are necessary.  The code is
> checking if any bits are set in that register.  If not, then we can
> skip that code as there is nothing to do.
> 

It's not a null check, but it is a nested check and it's a local
variable so the patch is correct enough.  At this point we know that
grbm_soft_reset can't be zero.

regards,
dan carpenter

