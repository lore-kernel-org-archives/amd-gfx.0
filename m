Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100EDC2D0D0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0DE206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/mHRcml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0DE206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310E689FAC;
	Mon, 23 Dec 2019 19:43:38 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B62489FAC;
 Mon, 23 Dec 2019 19:43:36 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 20so494960wmj.4;
 Mon, 23 Dec 2019 11:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1xSfKn4zmpnOBReuIpgRkN1WDqbNLIUpUWsHt9NqoOg=;
 b=b/mHRcmlAPeZcDvpC0y2iE3Gf+VS0lMaZorxQPk9/1+JQb6/A8Rv4fnOyBFX+GUU7c
 5HFamzUgNInEiTk7OvEkgiuvoNQ+a4FuTpWIxIbuDczpBuD81yiqJZesAqzNtwfnd2qp
 W/GmmBseghKs+xbiHDaU2h7919Mh/fXd0gRt0A2/7K9u5l0HOzigzk+YugDxRf3xJjKz
 1mt30marETsizgw8Jnb3gBERqjXjROZe1bvhw6lYL1RMwqUXJRZvxH6GsTKdKe8NYlFU
 4c4ojyHTd18o2L/sHT3kD2NjHHMY7Moc/k6a8DKzSh09eViWJaw95srTx/GVC2b51aDz
 m5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1xSfKn4zmpnOBReuIpgRkN1WDqbNLIUpUWsHt9NqoOg=;
 b=GnCmAmQVkwFGIR5uSWCS/v4N5X9EZCys9RW7pfB1uuRS6iBXQciaCaIC8h+ah9tgCM
 UT3Wbk1DitjXqcYQxPSfAsAkmE77I9oTj7ifkeC8XoL/DVdJh3Wa1xmk0zpP2RZWnn2c
 /xpM4ODwtYVdU+zpIiqXpW9pt++FgR7jh4fprbIpnQFw3vnMmCsiHLfeikGXQLBbykg9
 9/Kr6Unn027ZYDfB07oYttThMigbfWZf2LbDPrb78iYa0RbWgtzTaGH0/cvfiZ6VgcfG
 GQXHpifeLbYqkw7zM8pkqGYGr7lKXujwVdt6edKO9jvyW6ENXaavkK7Tlkau0NBm0itD
 7V+A==
X-Gm-Message-State: APjAAAXVjTWsQ7gMyxFeFc+pNOalb+/SQj86DH2I7qvizLM9nrvshv8e
 qtdkrtF7DdP/LbRKmaDzZREHl5UfS/0sCmVlTc8=
X-Google-Smtp-Source: APXvYqzxCvLrc/7jUh7Z7ZTTGpkId2XKJn/MQE4BP4690WruOvzoeO0ZjxNeC/pqglFuRVrbGRpqwGuPnvldls0p7mg=
X-Received: by 2002:a1c:b3d4:: with SMTP id c203mr503583wmf.30.1577130215626; 
 Mon, 23 Dec 2019 11:43:35 -0800 (PST)
MIME-Version: 1.0
References: <1577108781-68614-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1577108781-68614-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Dec 2019 14:43:24 -0500
Message-ID: <CADnq5_OAs9afhFyqLst0TeL9wuydHN5H=Stmv2nCGT3S9Ya_OA@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu: use true,false for bool variable
To: zhengbin <zhengbin13@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 23, 2019 at 10:26 AM zhengbin <zhengbin13@huawei.com> wrote:
>
> zhengbin (5):
>   drm/amdgpu: use true,false for bool variable in mxgpu_ai.c
>   drm/amdgpu: use true,false for bool variable in mxgpu_nv.c
>   drm/amdgpu: use true,false for bool variable in amdgpu_device.c
>   drm/amdgpu: use true,false for bool variable in amdgpu_debugfs.c
>   drm/amdgpu: use true,false for bool variable in amdgpu_psp.c

Applied the series.  Thanks!

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       |  4 ++--
>  5 files changed, 15 insertions(+), 15 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
