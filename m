Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887FC00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 10:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CBF10E31B;
	Tue, 24 Oct 2023 10:14:34 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C74210E31B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 10:14:32 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40850b244beso33835445e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698142471; x=1698747271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3nBks4lwoVedgylmPrC0c/+H/rOXyq/Ae0WPQgqcPSM=;
 b=UkdOtVBefyKaXAfEjJ0wlTFR0+enYEM7boSaojZm1wYhykaX71LAwGrp7wz80V2uKt
 UjDpS1wNs8ANPDjelCexO2YOIC9xQzusSsQ/5s9jkc/67weSpC7yRZxvVoGE5vyNbYRD
 kCaPL+mrSkNKeTc1rB7REWoBeC5RRZK4Y39q2uGf1f39WQTSYdfYypg98h+W5jLCAKAr
 MvhgM2VXSY9hkWp8gZ3nCkwPQvGZfbXeVPlEX9i2b3Z3IxD0/8zjFiCfqGZVpoUQkkhh
 lwZqlKD9VrsvkVaAXKhKmyoh/2t2wCk6BKAox/Z3QczGPpv+LJTcGPyuIT41LPPUeHrM
 Do8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698142471; x=1698747271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nBks4lwoVedgylmPrC0c/+H/rOXyq/Ae0WPQgqcPSM=;
 b=rfy/XN7q4ftAnLOqPKzovVKbc+PvBYQhMMxZlECtnY1DhrS9zvL/vUDdcvIXS5dZSx
 OCSvgBeTx4tii+GvdowGZ/9ZkV2I1o+4n+vf6WsXB2E+9rCCb3zxtPT3cm1vz6/jJ9MZ
 LVnLmWWI4Ix18PKBDZR9fhw7W/7NGLaRx56P5HSn+T108+fcrUHY+wCAorVc5qWMFL4m
 9f58o2eX5unqwSnwYYIMdoyaGlxCoSvXJeChFkTWjCrdg7ZlbY+TALd2SlYsVw+Ggc4B
 9l7NX5YqoE+5zqwYZOYFybftfu5EKAnPfz6kH+bwbjjuoGJMu5qRXGqAhXwaf310vDrr
 Cm+Q==
X-Gm-Message-State: AOJu0YzVQq0JKqcw0e+nGWGiiKyi0lx8jxOw8VTtLWOyHlpuPw7zzWQG
 yOj2CC2UX6hcHxYkBndRqonhSLTVWpQLnA==
X-Google-Smtp-Source: AGHT+IF4R0fLm3nL6HJIT8jcjxnKMJw8W33HppUOaOBhV+xYCfYnJ53q9tSpDFYEJvCebClnJwxKQA==
X-Received: by 2002:a5d:58e5:0:b0:323:3b5f:3564 with SMTP id
 f5-20020a5d58e5000000b003233b5f3564mr7698480wrd.10.1698142470436; 
 Tue, 24 Oct 2023 03:14:30 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 s3-20020adfea83000000b0031980783d78sm9586059wrm.54.2023.10.24.03.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 03:14:29 -0700 (PDT)
Message-ID: <6dcf471e-6daf-4aaf-a534-322b6483bc87@gmail.com>
Date: Tue, 24 Oct 2023 12:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Initialize schedulers before using them
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20231023032344.164925-1-luben.tuikov@amd.com>
 <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
 <53e14f59-6743-4a11-bf27-151507071bb0@amd.com>
 <bf4e2094-3304-412b-a196-27c289e080a5@gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <bf4e2094-3304-412b-a196-27c289e080a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[SNIP]
> Let me take a closer look first

I think I've figured out why this isn't working as expected. It started 
with this patch here:

commit 5fd8518d187ed03403a4d4f7f56f52c00b11c148
Author: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date:   Mon Dec 6 14:59:35 2021 -0500

     drm/amdgpu: Move scheduler init to after XGMI is ready

     Before we initialize schedulers we must know which reset
     domain are we in - for single device there iis a single
     domain per device and so single wq per device. For XGMI
     the reset domain spans the entire XGMI hive and so the
     reset wq is per hive.

     Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
     Reviewed-by: Christian König <christian.koenig@amd.com>
     Link: https://www.spinics.net/lists/amd-gfx/msg74112.html

Andrey separated the scheduler initialization from the ring init because 
we need some of the rings for XGMI initialization which in turn in 
necessary to figure out the XGMI hive and so the reset domain for the 
scheduler.

The code inside amdgpu_ttm_set_buffer_funcs_status() is actually 
correct, the problem is that this is called as part of the hw init which 
comes earlier than the scheduler init.

@Alex, Ideas how to fix this? My best guess is that we should move the 
call to amdgpu_ttm_set_buffer_funcs_status() from the DMA specific code 
into the higher level handling in amdgpu_device.c

Regards,
Christian.


