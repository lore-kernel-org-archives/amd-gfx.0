Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B58606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OAtSSExf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB34910EA2E;
	Thu, 26 Nov 2026 13:48:49 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DACD112245
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:38:21 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c51c294cef6so58656266b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795685899; x=1796290699;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7hFok4YO/saGKTiR7BJD0f0RtD+AEg5luKgh7Om5dxE=;
 b=OAtSSExfAlWFt/MCSLdZQyZEDBtrWHxKYXmMipmM2/deF+qlnFb7VkEo32gxATMgLU
 NPAtq7OIVoNQfy43BaOK5j08y2iGizWm0Dn3Axn7x8pFsvkvjIGCv/tAqVkMwU8p0Ovk
 X3VFB4QcDXCdJP/5XTVXfHGGINwQjflgOcnOFzSioYa5MZOkwyqXuLxBmmCYZ21jj71Q
 SPOxPJjpMVjlWrd6etTR0GfKs7tVff5ORCSn0Zf3cJBmA5lJ4pqJ3QcYsXBNbpltLHDN
 hm0YMF0neV7FzF3ZOXcMg9wDxOTYNUTHSCl+A8py6k+gzPUE3gYKCcHznqHGs+sIRT5O
 aVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795685899; x=1796290699;
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hFok4YO/saGKTiR7BJD0f0RtD+AEg5luKgh7Om5dxE=;
 b=qAmhYHQqPi3cB5mieq4bO3lD02xVm6asc+0ViH/5/rI3iPbxoGDCSvC9iG9lZaFh2g
 lf13XO+mdlUftTpqeCx8PSfqwcLX/xJjzyh106gJaRrvmoNXgdOAa+MWwechwfGTkEIN
 oAxAWXs7vER+EKvxFkhRtC6FOoQv9vzKQ3w1nPKuWy8ivk2oaqagc55ygRuTxxVCQkqI
 YsL994e7u3wJu/QkdJqaZ8d4qXiJqAip6CGW7b5qEjnV3k/w9FhhaBJCSO5pZnYhtNxe
 GBwl2PhTZM1kNhv/m4W/dBSP+OI3dC1bA9addrjaV1TfDLMCMF2VULv8Q8kSEVxWH8ln
 LL7g==
X-Forwarded-Encrypted: i=1;
 AL+hErHloElqTE8Vdeaf/LVFYLMjHqLLP5cTBuGAFSnRCVn0OKJxixQmhN4jhr5hYH8C2Kshq5R2x9V5@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8cMfE2Q9vZxsM4W5ENvrK6HnGWzVzSj8HEbbAxtHpR1u9zxXpr
 9EUStEYv9jUTnSklWFvq4tKH/j5qXJnH1UoPnPiE2e2YWFwglzM0KDL5NmjpB/ZUtmI=
X-Gm-Gg: AZFdTZc6IX9iepUMm28MiAPddjGv76hydYI+6oCnyyjtdHT0FpPVPzbFTZEsQ8IlQuB
 ulkN7OR3LcalGjn6tKgDcuvNt20ACkMkvFpFVQraCIxKie2EScAEhIjcrE+aTwDTsnbSreMHeXV
 V0vE+CVyR5D10fElwe9q5Wz9IvJZ87upxXK7UVAR1bBzH6FfKJlQn6kKcECOpg4nqHUyB/w94Qq
 5H0+xo137FR7dYNX3pZBc/+Li5vtUut1UBq4IraWSgcwsjvPrB6vMRK2I0AR3qxzxRKKtQo8tx+
 zKIXT1HyWfKdTu47m/eq+xUidxH+28ZNmQtoykaOshhs/xHXxff4X1dZmjsEPHgIcqoWqL49vXA
 0Z9OkqymQxGaGUyqiL+8CxhU/Q3g6ClVONEu/AwTBPxoZoC64IVtEuLFbCV4mW9Udho47BbIPUD
 n7hsw5ChLTTmrUDt+DTG4OwDNncQWreajwQ/YXHC5Fz4i2NCpi3VDFksGknv5sIhfNDfEbXoO/d
 OpaNmGLCMOOvu7cywV6xssSicg4mS2Kpw5nBXVfJf13vcPGG59FoccmgD9+AiJNGbobtGeibUgu
 nIduMkY4NPPbJX2Sum2oei1S2VbFqNV2l86ICJRbM4bozmZQA7KrM9eQBW6dACwbC8rF/MVevOM
 wlaUWOTrAnhB1XaK61anCmt9CLIvwj7y4h4K7rdZBHAQmzl+c
X-Received: by 2002:a17:907:d489:b0:c51:b953:d5ab with SMTP id
 a640c23a62f3a-c51b953d709mr314505166b.5.1795685899489; 
 Thu, 26 Nov 2026 01:38:19 -0800 (PST)
Received: from localhost ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm748783166b.86.2026.11.26.01.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 01:38:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 10:38:17 +0100
Message-Id: <DN51IX9FDFYG.1SMQCCH6JPCYJ@okonski.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: allow dispatch tunneling on GFX12.1
Cc: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
From: =?utf-8?q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261111173146.3157865-1-alexander.deucher@amd.com>
 <20261111173146.3157865-2-alexander.deucher@amd.com>
 <MW4SPRMB002512C807FB91C614F27E62FB422@MW4SPRMB0025.namprd12.prod.outlook.com>
In-Reply-To: <MW4SPRMB002512C807FB91C614F27E62FB422@MW4SPRMB0025.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:48:49 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 4:37 AM CET, Prike Liang wrote:
>
> Just curious, was this missing set caught while investigating a performan=
ce regression?

I was tracing the evolution of co-scheduling and preemption in amdgpu,
testing it on my GCN5 and RDNA2 GPUs, when I noticed the difference in
how GFX12 is configured.

Regards,
Jakub
