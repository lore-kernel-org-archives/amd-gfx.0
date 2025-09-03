Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CECCA1015
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C352D10E88D;
	Wed,  3 Sep 2025 13:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u2rtgHj9";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B83110E5B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:55:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45cb6428c46so3027255e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756889749; x=1757494549; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5cV4mqPmxW1tPyF9dbost7ZwM2Dt79PTTYDkgTZFQBo=;
 b=u2rtgHj9femv9sqEtwUa/uQ7ddMtuGnQifo6kyAsz2iTv3XkGsePYbLvCJMgncj9KB
 v6+sVgWSuxWxenVYnnDmHcN5aZjw8UdaY2cuPD68f4OFKujRrLEjaQgi3ZRPaArQc+ME
 CSNyO0aLNyT09oRL3iN7S0hTcMfNMX+qDZF0VDGtlCyikklUOBH3VTJMDv1t5vGDisqi
 4yr6i/U6u263yGpwqxciDyZguu30nC+liZWMIBwzRY/Q3r6E0a1G4ehM/paTMOyZSWps
 2hu8sXIr4tFbq0iSPlsBm5xMmHSiQ/CMiErTY1dWb4KbtrEZ8pgeI4B3sgDWjMgXpF5+
 NFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756889749; x=1757494549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cV4mqPmxW1tPyF9dbost7ZwM2Dt79PTTYDkgTZFQBo=;
 b=oOC5qSJsQpv/N2mfbEskQNqxGeazFau7J0Kudt2qeUVV3TdonVNTKHUBqQWhla3bPN
 9F+e5M6c0r99MJZtBls+DPhAUvrG3/Q0Ts+EE+2mVUhqqt94oL7hWRjIpuVETljpVRey
 pNrfswkTPpglpx7bKouM7mSaUfeDkknYRijq+N+T22aa8Wlyxv7M6fATXAutyczkcUGR
 uJm7Abac9xjY/IBsT7/NtAQtRnEiM3QDm5sXK40bIzVcHC8r2Bp0ks5MpJJ1yVlZ2Ayq
 M5OHQWwgs/89n93+TMC+IUpP6AsJZs6nIvM2BzbmlIBEI6PYeem9Jcge3h9pqJx8gc/a
 8/uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWfo0jmOyIUB7GMkvGlKAmF8MFlRr/Tb/SDVtkImJX8vZ4u3i7PNMen7fH+hLlEFkQr3098GKY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWUPVZS073RsiQP0RJd3A2ki+05Fg8wyY9WNkJsTZqih+pREii
 XwQEAQoJd7rU0u/Xcghse8L0fWyNDL5YHr2IkQtamLnRZuMDXB80uXldlS2QnkLhQhM=
X-Gm-Gg: ASbGncuoaUyWS6cOIpV3sylUiILPWSUWqb/jIYeqWarLLWNZ11cau7eDx8C1dwvzz9F
 R1EW0NieCwUKcsvS971ucxgTB0qQivlLsuolK/jiGNGLY9LAYCUQ/2KiUf3LsYFfYnLASMUyc2n
 E+ykrqw3E0rc3d/ch0J/fF3MWVrbAq2R35vM3BBhLbW8mXFbQ1dLSSIyc8r1oe/cKsSQKiDxv3C
 zDeO3d5ozvJ9vU1oeiSxnggEBVXppFm7fD1Z4I4r5xMELMIwmaRaIFuCd7sxfH0F6Vr89UVUKrc
 0hdSjYm68OXsi2BppAcEnImiC2gf1u++b8YGLqFQ+ti6sclm21EkW/84fPzItNgcYuW0YqssKoS
 mL+MPzn+oZ4eJ3EyV21ieP9Vrv6K1whuljPuqdg==
X-Google-Smtp-Source: AGHT+IH/I5haMU97rwsp/23eXdJD7jSFORVKYid/zP+DHP9530edfSTunocGOnjSttPgmZD8RbnDJg==
X-Received: by 2002:a05:600c:1f1a:b0:45b:47e1:ef76 with SMTP id
 5b1f17b1804b1-45b8559849bmr123014385e9.37.1756889748976; 
 Wed, 03 Sep 2025 01:55:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3decf936324sm1205616f8f.9.2025.09.03.01.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:55:48 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:55:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix a less than zero check on a
 uint32_t struct field
Message-ID: <aLgCkRO8jkzwuxW5@stanley.mountain>
References: <20250903082018.2702769-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903082018.2702769-1-colin.i.king@gmail.com>
X-Mailman-Approved-At: Wed, 03 Sep 2025 13:20:17 +0000
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

Are you editing your CC list?  The get_maintainer.pl script gives me a
longer list.  The most important thing is that you've left off Shaoyun Liu
from the Fixes tag.  Added.

The kbuild-bot did report this bug on Friday so the AMD folks likely have
a patch kicking around on their end, but just haven't sent it out
publicly yet?
https://lore.kernel.org/all/202508290749.ti6u3cLL-lkp@intel.com/

Anyway, the patch is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter
