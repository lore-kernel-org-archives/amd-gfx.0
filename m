Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BBC7115C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 12:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E23310EB52;
	Fri, 20 Jun 2025 12:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="knhDQnpe";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561CC10EB53
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 12:40:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-453647147c6so8157655e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1750423252; x=1751028052;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tWHsGUBFEN1KUfzCF8rv1/QvjATm1qfhGurlRc+Xo8w=;
 b=knhDQnpe2vzou/WJvA4D2Wj8eluMt8AH9axGPoy91pP1qim8sz5kfh+/ywiDDYnycF
 fzQxVe+LP9DF1EQUyS81v2i/1PBvUIEffZHR5XqcXylqMND0Q2OF+ZgbfFusoVzOII5R
 TKmUgWZTwsOiFiHhMZ4aiJ1Hqzy5r84c7UScWxzhTu+Z0wggNDNYh8kLSPNgcXDKNAyd
 prL4rhn/uPt+c6ALNXvySpDKuYmKFQNS6nVyhCmYq3mlsEzUhMsWwayShpAVnK+g0ReK
 fzNTKL6MnmDUR0e/6NmRoYveybzpVjeW8oKvd5wroP+yoosjz0ZTKCxEU5WeX39EhrlZ
 0mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750423252; x=1751028052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tWHsGUBFEN1KUfzCF8rv1/QvjATm1qfhGurlRc+Xo8w=;
 b=OY7jkWbYvXgK2lR9XMldtubFQ82C9wlGBXP4Np2KVF/0McfA1EYCLBYURuECBj+aa7
 01s98sN5lWsJ/iSZctODzS1l4FYBgcIa4DLg5LYEp3TIg3+a1U5zBx9LRlXGljBDwWrx
 gGUVq0TFCLxxXK81gQcyQtsQ8BFlJJE7ctE0BWQKnN+qYTvg5euqkNyrUEX+bYSjbMYC
 6xHQtgJ6sFHwPUCP6JLVxpUw8+q0qcyipHNnAUVvWUh+oCQ6+ovGN9QG1FYZKLLFtukR
 UhPlcQl2P9pkS5GR2W1+dpmRFBSyb7yoXicJL56orsDGcIOD3nuTwHmyGWbwqJq2v/48
 kPhg==
X-Gm-Message-State: AOJu0Yz5aSlyERzDHsZQYmLVnCZLq0EDRjvnMM+kDy6ICm4OtPa+vq5Q
 Kb+p6CCzUjqj/oS2HZw/6WGguUHP+aERbe54+eG8Y4jUlmCpBlpt7V/it+p0CEPDzk8=
X-Gm-Gg: ASbGncvh++eG2zsBqI9dKcdmr79R4MgfzS+UIgLgdFW9r6ICHJgUOiKf+1KaYXwvHGv
 BerO7MEQcxDWWAsvAPQIssIqAFj2w7j4VwroDgihcZliSKJgDMuzhtUoFsuo2ZiTQ1u9uRcDw8m
 IOKZ/ljJP9y2JtnISgAVQJPh115LD06+xbevkC2jDulOLPv/PBCTrpOSACBZL37JURIyN6cmvms
 C8VBkfFpV7DocJd2j7JoMK+z/bFeqONcIkJRag7hxl42am5CZiMBtx74HqZpdXh8gD6Z7O7ZsxX
 /jS/ZTelIdxYNbThs+Z2pKgiFwgJo3FrqS6dEhpfW7gDP1cQt48KdLIrG3CvHY7l/pp3eblDnz6
 V
X-Google-Smtp-Source: AGHT+IElOXijoyB+KGBKjJKjycZ49XMmKLEe2pa6xDkJBW3yU7xU50uT5NxqB7o/cFFnTHdxgNoR/A==
X-Received: by 2002:a05:600c:1392:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-453658ba515mr26170355e9.17.1750423251386; 
 Fri, 20 Jun 2025 05:40:51 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d1bbsm1982491f8f.41.2025.06.20.05.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 05:40:50 -0700 (PDT)
Message-ID: <2e76cb27-ef90-4da5-a10d-5c1ac20a3d67@ursulin.net>
Date: Fri, 20 Jun 2025 13:40:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] debugfs support for pt base for each vm
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
References: <20250613071537.701563-1-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250613071537.701563-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 13/06/2025 08:15, Sunil Khatri wrote:
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/clients
>               command  tgid dev master a   uid      magic                                                             name client-id
>        systemd-logind  1056   0   y    y     0          0                                                          <unset>     5
>              Xwayland  1733 128   n    n   120          0                                                          <unset>     8
>       mutter-x11-fram  2048 128   n    n   120          0                                                          <unset>     9
>              ibus-x11  2071 128   n    n   120          0                                                          <unset>    10
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client
> client-1/  client-10/ client-2/  client-5/  client-8/  client-9/  clients

How about making clients a directory? Ie. in your example:

# ls -1 /sys/kernel/debug/dri/0/clients/
1
5
8
9
10

# cat /sys/kernel/debug/dri/0/clients/1/pt_base
81febf3000

Regards,

Tvrtko

> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-1
> client-1/  client-10/
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-1
> client-1/  client-10/
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-1/pt_base
> 81febf3000
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-5/pt_base
> 81febe9000
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-8/pt_base
> 81febdc000
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-9/pt_base
> 81febb2000
> root@amd-X570-AORUS-ELITE:~# cat /sys/kernel/debug/dri/0/client-10/pt_base
> 81febaf000
> 
> 
> Sunil Khatri (2):
>    drm: add debugfs support per client-id
>    amdgpu: add debugfs file for pt-base per client-id
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 14 +++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  4 +++-
>   drivers/gpu/drm/drm_file.c              | 13 +++++++++++++
>   include/drm/drm_file.h                  |  7 +++++++
>   5 files changed, 37 insertions(+), 3 deletions(-)
> 

