Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBB6CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 21:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9DB10E9DD;
	Thu,  6 Nov 2025 21:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7O+223H";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C1110E9DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 21:47:04 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-295395ceda3so69705ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762465624; x=1763070424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWPFs84U37BlV4HR4UfJZaWnurNpPXzSHUa9OWSU1Mk=;
 b=g7O+223Hh0w9Q4sO2QWPgvjs+BGq1eEWuVK1yeQg5AtupmuEYVGYeL5CSqoD8E7rBZ
 mZEfxzOvPAhEO5oqCpgHiy/orHTaQ9pW1cF6GKAvJeT48pvfAP6fI1G5/Dkoqbxz0clc
 jFQ04ppF/xkZpGfgfh829YgF0RW/kpEQF1QXNlkq3685PQY2s25lu6/q/5DNuSFnYbwo
 tJ3OwVwfJ1Uuup+/P9qr53FwDf/wKm1forMXcJH8v1GNpe5JsilPKgyFJzoxjj9HSG8o
 56suGVKVEhbplRZVUebPx9wp6UlzAtRpfrlwBzskoGCrPXeQvYrHs1X9BWyUsvT7t+U1
 h1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762465624; x=1763070424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uWPFs84U37BlV4HR4UfJZaWnurNpPXzSHUa9OWSU1Mk=;
 b=hhNflcZ9Sx9W+wM8e1XxhYvOTQhHOwjbSrTCIXpjaEN9qXqX0Fc3uxi6vmbjfUt7sc
 fXzA1zDLoYMpE+kXFwEUGt5T45CJJG6FZ1CAKRxyPCjBaXpBAMYk019vYwUAKArUFOUK
 Ra0VE6WbP2r9c5Cvb5n9T0/WvXEC0bPgN+Twr+GUPHDk1/CGthzlChv8NyOX+g7BfMeD
 SDLm0kk7abOi+wvXBlJEmAsK/Zdk3r7nyprVFY2C0vkI82sbMUeSP7e1Oy+zuHYBBq8e
 C3XvrpMFnmmmGGarqdMi+Eyw0t/yO9g9DRQb5NgpZ99fYUEZ4cxwjKUq4AWom9cqO1rt
 K62A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSmLOi4lKqxHejrc86i7iSVSh2Cm0VbmrQYGAZ4043gVSdXyiUj+J5xaTL4Sj/JsMiByhe3M33@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpWwBU1UQCQFIpMIbVaoRj6YU6S5UBEJLZyDZIuVkPmBtvV65D
 QNZbVzrhnxwIYW8GMlJ9AyuMymeIwNBVzTKWf15c1v9qiAz4qfTkQK17OGqFl7oBq1ZlOFFH1LQ
 5W7C6IVHGfRCfdvmhkppJQWk4AwRtZeg=
X-Gm-Gg: ASbGncvM/QOPsw72PGmZzMMCGMIK70QImCJhfTjKAzDLUTgjmGQxjNUdONrdrDm0f9a
 9yHRMSbIeaQ/+7KqSQbr9RWqAjNthaPx/Qv8ZP4hm9Mugy08LOGyBvzl3WtF31gKB4zughprkrs
 CuyElqOE5JYMV+/gRudyAk9HiY4FhdPdAMBDazamSQPg2TJ2siU70sVNxfpKdB2TBnjq/1wrhM5
 x9GpYefxoxn5zlpqg2UB2x6KFj7PnxZI4JeVMl9k9UFSAPsbVxgnkh0jGVE
X-Google-Smtp-Source: AGHT+IGwLxGeQwObIqsiRu60FgdR14mXv74V9sIBJquRbETpjgO/u71xJ576vnpk0XVXFQIkzHnAysyK3vaO7ZiVXAg=
X-Received: by 2002:a17:902:e552:b0:295:2cab:dbc2 with SMTP id
 d9443c01a7336-297c045708bmr8072615ad.6.1762465624074; Thu, 06 Nov 2025
 13:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20251106014747.46768-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20251106014747.46768-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 16:46:51 -0500
X-Gm-Features: AWmQ_bnzUjJ6HcFWpYUZnTLKwOZeb_N2f4pDuMRdliAyH8rVEieFGHJCx9d4LU4
Message-ID: <CADnq5_N5bZ20A4gwfKevVgzTrTRw=pGPmXEB+1wTMNMqfOHy2Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/userqueue: Remove duplicate
 amdgpu_reset.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

On Thu, Nov 6, 2025 at 3:56=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c: amdgpu_reset.h is included m=
ore than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D26930
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 836a14ef0052..9a969175900e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -32,7 +32,6 @@
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
> -#include "amdgpu_reset.h"
>  #include "amdgpu_userq_fence.h"
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> --
> 2.43.5
>
