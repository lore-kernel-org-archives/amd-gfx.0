Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DB9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 03:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5664F1F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 03:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5664F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16846E970;
	Fri, 19 Mar 2021 03:36:06 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FE36E970;
 Fri, 19 Mar 2021 03:36:05 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 x187-20020a4a41c40000b02901b664cf3220so1964287ooa.10; 
 Thu, 18 Mar 2021 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V5N2rEg9VhvQue8bVp0pO6l2JMPpHyJZDJ/KHUZ6Vc8=;
 b=gsF2SBGxPuldrPBxT5jwhewdWAlJbxr1L9dZBZUUcFwdgZx9Ms2OhyJXS2groCwCSv
 NGs1qwm/SvN9bBqhpLgNByrDc4kHjPn/+oKQX7xydlyomPlyJfaLfz+FeGWHAKJqxnRS
 bguiSo4SOkcgj5x4aatLQuvabk+r9ICB5Yn5uMCQXRKKdfpjUMeltXB/yvq0VKgRiPhj
 35qlxaR9w8n7jbDyKYbU383MwyxpV52t5yeymGHcjsdIk8SMlUDVM2mbnGlx9QSj2n96
 EK40qRsNSZ22qbw3kZ/M9aitqHhijPycjqZuwEEtwrQ9946SOrjwAyImgzwnxqXY09jW
 zaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V5N2rEg9VhvQue8bVp0pO6l2JMPpHyJZDJ/KHUZ6Vc8=;
 b=cQ3Tj86snYYM8wCCVjAHT9UJ04Anar1Jip94HCke3GSNWgmbZu/BnU5tVx/Fqgv4Bc
 9tHx3KeJjI7p2dCayJmm+7sjfw0fPEKwyzPZK+AC2sfCdFxudGuym66G9IAQJQTVu6A7
 XQQg1VhGnYRt8LFUiOvkEGQxNHl3z3vvO+OjPQx9IPMNS1pg5b5uwLKprENSY0Cyfqan
 Mmvwg5i0PBkQTT8GwOcsZ060bpyig3IyXZmR8JLcZqEW9YXTv3IwJ6/Jok5nD+IRMJy9
 DYfvAeSnQv9aoFzbyYzkg5kg2M2DzbmpB9PKDEJzpTcZFUp6seNMTp0ahTPzVkE0pISC
 y82Q==
X-Gm-Message-State: AOAM5335523b1BRydkLtgo260dLJKTTyoOrk/rw9jNGUUahNw2NPwrcj
 xueocjUlZCcNGQfinJ+QQS9SJBLSMQSgWtobOx0=
X-Google-Smtp-Source: ABdhPJyNOud3n18QxGzdZdz018WeLgmgfKwbaEPYrkO1ZJitepN9fMereYb0SpwZhay6NBxjkw/To45EBcK2OfWgoz4=
X-Received: by 2002:a4a:7615:: with SMTP id t21mr9986585ooc.72.1616124965033; 
 Thu, 18 Mar 2021 20:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210318231815.19546-1-unixbhaskar@gmail.com>
In-Reply-To: <20210318231815.19546-1-unixbhaskar@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Mar 2021 23:35:53 -0400
Message-ID: <CADnq5_MC6f72e06xhWxQ_UKMYiw_=KfiESWxFm8s8rXBPPkMSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, "Chen, Guchun" <guchun.chen@amd.com>,
 Dave Airlie <airlied@linux.ie>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Jiansong Chen <Jiansong.Chen@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, John Clements <John.Clements@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied both patches.  Thanks!

Alex

On Thu, Mar 18, 2021 at 7:20 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> s/proces/process/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index bf3857867f51..c1d5a3085bae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -598,7 +598,7 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
>  }
>
>  /*
> - * save and restore proces
> + * save and restore process
>   */
>  static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>  {
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
