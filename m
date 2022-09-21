Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E9DECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 18:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A170710E776;
	Wed, 21 Sep 2022 18:49:38 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE89010E7EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 18:49:33 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 j17-20020a9d7f11000000b0065a20212349so4565872otq.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=3EL6UP0wqGnMho5nwefVhFeMLbT4wzMqyt8elh+0Seg=;
 b=lyS7dP1byyVjGoqb6zXh0fYd0f85PfLRCsXzO0fvAP5i0jNRZKVPoBJPtA9L0acNEf
 7bHKFqmdreznHXHQp78A0h9OKjPg9nhIJzKFezD0yyDTcgh0VCVZ+8lJoZ6ovc25Q80Q
 TJV8lU0r/OCUsdZNBNl78lIejDpQ7CAx9A6x1/Q8LBCbdsnBCht5E6oMNlEFQFC1cNi2
 cl0TLzw0x6NqfbFp0u53Jn8ImiehcClGwY6ZJmmblROJm4e1uv4gGa+i6/bB6K79ByZd
 NHs9zA+QyvBbMkHA2u3a0+BBX/6TfRZu+SSIn8DH3p2jY4wlVnN8QWxucvzA1PtmIjFK
 cfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=3EL6UP0wqGnMho5nwefVhFeMLbT4wzMqyt8elh+0Seg=;
 b=ZY+WkxwQ5b2478btZHQ6fQZ9kGKm5WxI5ZoATOOmHM+rTnwtVDz9aOHI1+1ufTRuv0
 qrijRuFkiH8ZzJWKm27CW7oDdHlJe9qpqSZrDwR96m/UmLhPNK6GVGJLfoqr2qD/qRdh
 jpj2oQ8XcGTO6TypTyAB/+51UFLkkL+EsHtq9zGj8LBi2D3kwDtUtMAxrQ1d1K9IPXAf
 9mw13CaCQHObblSRd0N0ObLGOUJb2v34JxmiGen4S649ftQS7Wg+hcGqMAPC/2FJ5pyE
 mHRqD3ZdlS6GwVfyGPHVu7FeDscFZkY9+MJQ9ngxP115fgq/wsFSioM96RV4Jm7Xt6/g
 xXKg==
X-Gm-Message-State: ACrzQf03Dj4p9ZP2IXtLEwN4J58PfMRApAJMTR0cQuu4/t7H05IK2gKZ
 gPxzkfFDzNvSvIToqkuguXyxj5nW892wPw4UR6k=
X-Google-Smtp-Source: AMsMyM7gJ6L8tYyq1UxS8B8rGVJ2z/5fB9Wj8vuo5JXxSFJpEf8aVg3aT4wwsk34AObrvLAAJdbo+svxqFYrvsAVz7k=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr13181012otv.233.1663786172894; Wed, 21
 Sep 2022 11:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220921184700.617748-1-Graham.Sider@amd.com>
In-Reply-To: <20220921184700.617748-1-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Sep 2022 14:49:21 -0400
Message-ID: <CADnq5_O7G0oKtk9Am0O+-WzONsYF7Cp3XZufgK583+RE4Juq_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix MQD init for GFX11 in init_mqd
To: Graham Sider <Graham.Sider@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 21, 2022 at 2:47 PM Graham Sider <Graham.Sider@amd.com> wrote:
>
> Set remaining compute_static_thread_mgmt_se* accordingly.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index d982c154537e..26b53b6d673e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -126,6 +126,10 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>         m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
>         m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
>         m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
> +       m->compute_static_thread_mgmt_se4 = 0xFFFFFFFF;
> +       m->compute_static_thread_mgmt_se5 = 0xFFFFFFFF;
> +       m->compute_static_thread_mgmt_se6 = 0xFFFFFFFF;
> +       m->compute_static_thread_mgmt_se7 = 0xFFFFFFFF;
>
>         m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
>                         0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
> --
> 2.25.1
>
