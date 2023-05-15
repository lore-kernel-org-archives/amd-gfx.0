Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE7C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 07:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EFE10E15D;
	Mon, 15 May 2023 07:22:47 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15AF10E13D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:17:08 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f417ea5252so65871045e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684135026; x=1686727026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MPLWP3CUj7nXbwK1eig/zxowYW15P1YnC8aJ9O61dnk=;
 b=Xb6ItDRVMlzOOtJl7GbVYbqyugpgd2ZNrxB/ClgRnmCk7h7W076rSAs1VA2Zcrb9aE
 gXUgfq0+SF3gsgOjxNzXuawUHKpF+yXh90bm17bBHlgo/b8hKVyem/S6U/SeCLeVSCgL
 L7KwQuDD0FRFRf2qQSzATtju13vPd1YIZBPwcMq1b1sQtO+k2CnO/0k6QEsNe9DunfYo
 srzP1gDjTGkrN0mVdVkbiv45gZxf1qH8PK6DAp3pmz6lC4c3aCaOhr3lg/bQm3us9dy5
 +JIMBEG02AwoQRx21icwGZzw4EAJeTBe/7rR5zF81bk2eGCwut7dc6ahRmul00bQqfzH
 Z/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684135026; x=1686727026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPLWP3CUj7nXbwK1eig/zxowYW15P1YnC8aJ9O61dnk=;
 b=kthJuMyqVBe0+m06PyloPFL699PTGcWmbtubTSvGPUiqH4Oh/NWDfTqxnxnBIRqAri
 quLsw5JjSsZFZJ299nkaoToowymn9GIii+U/daCyT3nSniAtvNvdz3Xn/kmPXrLADTAb
 MpBOWiISfwJG37feJT+YOD/xK7y485NcWDqjVyCCE1jpzwv/aFtGz43aEvUheob1x8WV
 JjSQNDDx+zgAcR1X5pRT/luN3H/XJ5xCjOBiIr6fKl8LEJsJHkjbuJ62AJu6Tve0TIdx
 lN99k/Ij7GGgT5KKT+oNbK0vEkivD+JEU2FtICbkxmU20ZavfwokXZPeioXHtm+AIWUD
 ha+A==
X-Gm-Message-State: AC+VfDwtyfgWzl0TCDiG/+gz15GgmQ4B0f8IxOOzmh4Y0wD5RBEXoVsy
 1GzA+5wkhogUJipNha8sZCVJpg==
X-Google-Smtp-Source: ACHHUZ5VZHyW5V3zus65QYbAGDvzqPzVTRPUULpm8xMzYTaQO0OkqbPRJU0vTIbpP43eCZs0g/0c4Q==
X-Received: by 2002:a05:600c:2195:b0:3f4:e4cd:f6e with SMTP id
 e21-20020a05600c219500b003f4e4cd0f6emr9797595wme.17.1684135026626; 
 Mon, 15 May 2023 00:17:06 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b003f43f82001asm16132768wmi.31.2023.05.15.00.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 00:17:04 -0700 (PDT)
Date: Mon, 15 May 2023 10:17:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] drm/amdgpu: remove unnecessary (void*) conversions
Message-ID: <ebe9d98c-148d-4694-8f97-96bacd0b9f7d@kili.mountain>
References: <20230515013428.38798-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515013428.38798-1-suhui@nfschina.com>
X-Mailman-Approved-At: Mon, 15 May 2023 07:22:43 +0000
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
Cc: Xinhui.Pan@amd.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 15, 2023 at 09:34:28AM +0800, Su Hui wrote:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f60753f97ac5..c837e0bf2cfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1470,7 +1470,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  
>  static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct amdgpu_device *adev = m->private;
>  	struct drm_device *dev = adev_to_drm(adev);
>  	int r = 0, i;
>  

This declaration block was originally written in reverse Christmas tree
order:

	long long long variable name;
	medium length name;
	short name;

So you probably want to change the order now that the lengths have
changed.  Same in the other places as well.

regards,
dan carpenter

