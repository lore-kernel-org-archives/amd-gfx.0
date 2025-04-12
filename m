Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D47C369B4
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 16:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4D210E2F1;
	Sat, 12 Apr 2025 16:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zhyGdhEo";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7931010E0A4
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 14:28:45 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so2421743f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744468124; x=1745072924; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yug8Lg77jkFOaaSI2hhnGA0YoGthbaYjMrZs5RGYQTk=;
 b=zhyGdhEoxqONFclnTWorn31LGd6WOJI9ant+mweJQKsXj5LzevrvsnNc2iPvjFqDkt
 FC5cwr3zwV+QetoRVcYvo6Q7O1M4e+dUwOADqWbzgBYqzjH/AoBpbZMVqfT4UQ0HN3CX
 1J/ehYwKn4B+UXPqhKqQrI7awI+jKneeXm3naxK74ofz6nl0Wa/GJcgBYDZhO3HbVDD9
 w+wvjb2o59+7BH9quHtO/BtnMQ525n5Rbhjn26DwNIQfakIoV4vIq9Y8la0pyCXakScd
 hp4xO/K0+Nk3UoIkN5yEbF4JqSndJV5WlgdfMGvFP2Vx8LYiEOuT3O6R4KM6d4l+SUvf
 s8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744468124; x=1745072924;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yug8Lg77jkFOaaSI2hhnGA0YoGthbaYjMrZs5RGYQTk=;
 b=t7sK/E750KOVJp2dLs65M1HyP3mkHr9AEDh9RUid+VgRp9aT3ZdZKGmyxXlymOehOq
 tGzx/OXiWGpYsNE3xKFdKa0DMb0CUTqZhHWEN6lrrAkaEz285CM9YvL5++OfUV5jlNd5
 ngdkTfZPEmqQaEfx5n+KIbsMjtBvZgYFGUKlfyiS1RUD/zk2inSZQIoIQ6z48cqrfjue
 pPMdgSBPqGunBhP+KsHkOGV6THFbEkYNhIe9pDxDi4ESScV4lqmL9y3uQ3G/PVcXIrjd
 vfPJsxm0OPec+HuhqskVhBqcfrG6Ue/YOHNO2nRP7fQ10xAD81AJSTzziL+tWut+gKvd
 HcqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf2xtW9T6JAxFUeeXneR09J998aeJrpP+xFiibwaIaCqcuDV2GjjdAJJvHSB8uxWRgqpt6tR/r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1cD2Y0ADkmrv3xmXzNil/jhc4L9nuO1HqeK2sjEodn6RnZn8J
 ER/zzK+6wIauEMClwak8t24+CbSm5soJXLk8RICxmWmJGbMGAjftKDlhx2iKk8U=
X-Gm-Gg: ASbGncuXgFxb9fiAjLVbnZhXEmXxmVcrkVaFBmXPo8lzIWPSKrYNfdWoZZRHK/exdNg
 pc0zveZFfFc92YcOi8NoudDPwWAGyMtNCCiOySZ3MiFv0HLYN6z92yGfvZPDgJhvJ3t5c9Tm7i3
 baLMlGWcknx8tfblePKCpAQmuCtPA/MQqvtcaXAoGqJjoiYPJP4IdRjq4AVjr0UOJcKl/bCGMVv
 vCnCV67SEfOVrjc07u4jVbegj6jfkkLwzHyW7YKudQubUXO4EF7mVKSH2pWsEVMwZT5PZqH0bDN
 +KoTprYOvfo4RuXa0uBYaJwKNGBkTgwpYIhFaIODyUc+Bl+DSAXSCKUQ
X-Google-Smtp-Source: AGHT+IH34D5glm0+0TkKdRd2QqYl+pfjKMVxmTngaZruRkPsk03mWnWy81pDX8UHh5AZeQmoxzxDVQ==
X-Received: by 2002:a05:6000:2507:b0:390:e311:a8c7 with SMTP id
 ffacd0b85a97d-39ea51ecbecmr5651152f8f.5.1744468123668; 
 Sat, 12 Apr 2025 07:28:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39eae96c074sm5086157f8f.28.2025.04.12.07.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 07:28:43 -0700 (PDT)
Date: Sat, 12 Apr 2025 17:28:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Yadav, Arvind" <arvyadav@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/amdgpu: Fix double free in
 amdgpu_userq_fence_driver_alloc()
Message-ID: <344bcc64-bf13-4726-8530-48eca7d643d1@stanley.mountain>
References: <5ff4d367-b5bd-40ae-9529-56d08ea6c1d0@stanley.mountain>
 <92b7d28e-6103-4c76-17dd-6ae94552a043@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92b7d28e-6103-4c76-17dd-6ae94552a043@amd.com>
X-Mailman-Approved-At: Sat, 12 Apr 2025 16:07:59 +0000
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

On Thu, Apr 10, 2025 at 10:29:31PM +0530, Yadav, Arvind wrote:
> Please change this also instead of 'goto free_fence_drv' just return err.
> 
>         fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
>         if (!fence_drv) {
>                 DRM_ERROR("Failed to allocate memory for fence driver\n");
>                 r = -ENOMEM;
>                 goto free_fence_drv; // this should be replace by return.
>         }
> 
> ~arvind

I noticed that when I was writing my patch as well.  I'm always in favor
of direct returns, but it makes the patch confusing to add this unrelated
cleanup...  I'll send it as a separate patch.

regards,
dan carpenter

