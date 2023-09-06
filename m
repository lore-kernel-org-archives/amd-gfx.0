Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8260FEB8FCE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A7410E659;
	Wed,  6 Sep 2023 13:25:09 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751B610E60C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 11:14:46 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so58116311fa.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693998884; x=1694603684; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I7I0PovVYLasu/UMUTWYTFB8t8j//23E1al0pSkqV8M=;
 b=wKKfE9OXWSOSsZTZWCU5JC4fWzkYg8T5FSKzebAKd5knQ/eHZW6uxe5/IUvZxIehfT
 etolxsm6/j4nt2/pVRt58bdhfyBAbCqkewJRShV7QgHYJNAuZZn4s3l3y9FZZx5X+ZjX
 ojsrtyjCdrc7OvC6Hl0h8a5yOyyOo05svG5EEMdn9INzsNvesdb9ysZLp0l0Aaz1TJKf
 XQDfJ21OGmrPv0dKc+Sk/TYHrRFUXod1TuoHGHk3pZk2XKmlrrGBcn+ibh6ZFbwoKupn
 EU2px5NdLdXt8a2p1noXmgEU5TUKD19FT8+UMTJtnb97xHoc7KIyYttGKk+3AuQwDntQ
 ms4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693998884; x=1694603684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7I0PovVYLasu/UMUTWYTFB8t8j//23E1al0pSkqV8M=;
 b=YkDMqYLD/g2CCtq2wy4ncUgdRr9TRTOLhsPvYFQW5CYlIoZSflZpp6a7ip6bXE6Xwa
 hWhoq9dWOKYD9xE/2APnwLQCc38jUEJpTtXLwMvpSgHHM7Pk/8zpVU8Eik+l/Bq19/Kl
 h65TqkdJ2dhmIDEt0lY1pCjVSJeZ+pMX9NS5p9qZV8S4hv+1e3FyBxsPMrhiRPSr/1Rw
 EtvkemCINbhsIi7Nek2VDt+wLsYkj1UXTy4zDjdFm92sucITLoWlgyGwcuFnnGALhH5R
 U6uo2cbQ/GNfTNXp6yfxKNf5CBIwL0sVvlvCUtCOBc8E/4kxTxs/zJXBs5s7dziTssWl
 aLgg==
X-Gm-Message-State: AOJu0YxBpGIoOSBKgcCtoALBbfaY5cWLDjSTB/7/9TfJl4yZNUVuAyvk
 xj2SKXDj7W84VMGSrZRjmVT4yPLn3tNLntwr9GI=
X-Google-Smtp-Source: AGHT+IHG1fKvcZQXJ1n48+9u6Ljj1Lda0Fp64jQ4gDu8kbd1jVHTMaqUy7BPZpnR3mA6fNAUSxOPaA==
X-Received: by 2002:a2e:b0e7:0:b0:2bc:c557:84a0 with SMTP id
 h7-20020a2eb0e7000000b002bcc55784a0mr2156237ljl.30.1693998884620; 
 Wed, 06 Sep 2023 04:14:44 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fe1630a8f0sm22456217wmg.24.2023.09.06.04.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 04:14:44 -0700 (PDT)
Date: Wed, 6 Sep 2023 14:14:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lang Yu <Lang.Yu@amd.com>
Subject: Re: [bug report] drm/amdgpu: add selftest framework for UMSCH
Message-ID: <da2ea1d6-1b7f-4af7-ada0-ce59a6fe2356@kadam.mountain>
References: <dd425f64-868a-470f-b78c-8bf6a7b7daa9@moroto.mountain>
 <ZPhddADtKmOuVyDq@lang-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhddADtKmOuVyDq@lang-desktop>
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:25:05 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 06, 2023 at 07:07:32PM +0800, Lang Yu wrote:
> On 09/06/ , Dan Carpenter wrote:
> 
> Thanks for reporting this bug. Can you give a link to this bug report? Commit message requests it.
> ("Reported-by: should be immediately followed by Link: with a URL to the report")
> 

My email hasn't hit lore.kernel.org yet...  Presumably it will in a bit.
We could link to yours or swap out the the message-id.

https://lore.kernel.org/all/ZPhddADtKmOuVyDq@lang-desktop/

regards,
dan carpenter

