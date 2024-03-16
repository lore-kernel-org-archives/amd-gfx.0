Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655BC54E60
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Mar 2024 09:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BED10E5CD;
	Sat, 16 Mar 2024 09:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ssKccD9z";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DFD10E4DA
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Mar 2024 09:12:24 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-41409c8edb6so210575e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Mar 2024 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710580342; x=1711185142; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=25u1uqmfe7Gs1AsR6MpvcafMdO21YBRxSE6nNbzCabA=;
 b=ssKccD9zQDUkcvyg5O4Z+FxtB060wMjIOKtBqi6NXoy3mpeKL3dsW3p/+YBjce1K+w
 rknjZbTe7aTGDa6UN96kDt2cCeWXWFgZblYt3aRfUGcxlID0ZXuugP5dRZHrUPlkWRkT
 eWGAgVly0f/pAfyzLwdPC3QHMrHlH+xRmUn4Y53UFaS/IK9yk4K4lX21U3CTVo7p2Cjx
 nJiKsA43xzLMlRnzab9nfV7KGXLg4aYnqIZYd9fHsTwNXTNslAP6WpM86xgruVbKDFCe
 KEdmkxF3xVQN3Kdr7z77jNwoM5IUHu60vubpdEgP8a7DlEa1fqu4dRHok5cZ/IAKT/LL
 pW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710580342; x=1711185142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25u1uqmfe7Gs1AsR6MpvcafMdO21YBRxSE6nNbzCabA=;
 b=o5O5dRhk5ctmyEIbKqrJEstgkSKiFJrLKRaGwiMrZyaz2pG3ai3BXxDHMPWIvNpQsQ
 n2eUkDusr0/2uvlr0UDbPMKdqJ3uBBwwUnO2XSkowmVhmGXyHoNxprmq7y1QKwLDNhZ5
 5/4ZO9JSwRjqQpYVvYNxfxcb0pz5+gls5XZvpC5nNcJie/nIh/Vs/pavTuf7G/k4jO/n
 IYoGsgTQw5+p3Z7u4fx7k/uFhy9W0AZSPhtmSee2ovrWW4mM7YaviYAGhmg9K0SMn55i
 p5Vxyszkk/3SZcpF0MAtyeig/DyhODyzEuUB0lSjnUcJUToyxqL1ljYp7LHfnS31lts8
 iR2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWyvoNOzlJj4a0Mq4nf04MJn6XxQvH5Z9L2B3fY9Of1m/bAwoRQQDemKvxM4nxmzOpdUC5DxqMzIO8ya1hg+J8W/MBDOQjldsK4i58fg==
X-Gm-Message-State: AOJu0YyEWN97ZuMeoiDz1Ik3C1JCcz1EJEJJvwElKFfjNqpN3IRe5Gpi
 21csD5pOo07+OfTlC39tXohOa2sv46dZ9xGdo4ZL0xsZxwf5DwIhTLERsScY3sg=
X-Google-Smtp-Source: AGHT+IHTZUuE1FQaRXo1pAJk/xeKvOMlwJpusWQb7Va+NG/rKCDsaWh0y14YkD1ytHfwfVJDPRUfYg==
X-Received: by 2002:a05:600c:1908:b0:413:f236:64d7 with SMTP id
 j8-20020a05600c190800b00413f23664d7mr4865854wmq.32.1710580342220; 
 Sat, 16 Mar 2024 02:12:22 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 n14-20020a05600c500e00b0041402278895sm4208172wmr.30.2024.03.16.02.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 02:12:21 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:12:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: sunil.khatri@amd.com, christian.koenig@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [bug report] drm/amdgpu: add ring buffer information in
 devcoredump
Message-ID: <9950abd8-55c3-4c53-89d5-a9c4d0c33b0f@moroto.mountain>
References: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
 <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
X-Mailman-Approved-At: Sat, 16 Mar 2024 09:45:22 +0000
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

The static checker is just complaining about NULL checking that doesn't
make sense.  It raises the question, can the pointer be NULL or not?

Based on your comments and from reviewing the code, I do not think it
can be NULL.  Thus the correct thing is to remove the unnecessary NULL
check.

regards,
dan carpenter

