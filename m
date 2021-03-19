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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80C664F33
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80C664F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7D26E8A1;
	Fri, 19 Mar 2021 02:57:07 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17156E8A1;
 Fri, 19 Mar 2021 02:57:05 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id w70so3270405oie.0;
 Thu, 18 Mar 2021 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hJSUzh3a9Ci9GF2WJa03GDqj6BCOXA3nbTj13cSlJSY=;
 b=inWhndTguE05k6A7vQ8Qmp43ZhyR3koAqnI1eSixlQubdA4skH+6HD0R1rF2jQhQMh
 qblIzkGa50qyVEot+bnvj+kWgG2ecNTPYrgkHAOp47msgLIjm0ly8xS/uP8qq1KTeF6z
 fuPGFpuMBHEsXZbI26yjGvjB99zBcFIi4GvyiLh8Tp8AItxExGCmlBRoCgfDPJtprneM
 alIeu/2on7C6juijw6DemrB6ECdFe4L26MQR/yv96lZbzsbw3Ip+hfObtgUdoc3+0lp4
 YVrRUWcK9Vi72HzmZq5FB2H0XJjE83jNIENsKbqTRmA7dSeonHetHHq34x46CwPufsKL
 QIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hJSUzh3a9Ci9GF2WJa03GDqj6BCOXA3nbTj13cSlJSY=;
 b=hDfzj5q5tBj0v7LmWweFnjvQ7XjMGdzvK3vH7LdrPdlsyLYIleEoE3x2qMY0VqTOJt
 szcFmMpN+cyJxYF2BdwUaQu2nwVu9GTlQ/zfT/BtvXqPWT6gWC+yhlFpzQtqDMRwXUF2
 j/VB9Ccv9teTsbDyBvm6rjIB6wdu/tWgGnCVc77wYfIhgqZXBHP06Nj+jnjLOabYYqtb
 0ByiUn+IKgCSAx4/SUjld1TRz8kEcv31pJCbSFE0L8JPxzz1TCstgTPZ1xDkdzKLmZo/
 I48TXvExLKn5nMtERDosrYdN97mEx+Fg4IossiGxul48yA4tW2l7UO3M5+yzm7lWLWSH
 m7OA==
X-Gm-Message-State: AOAM5314qGN6z4mzXP6A6MrgiZXqK4Ho+gILEgGaMah2z6yRscsR4pdM
 dNvkEQASGpWHo7drUluW/sChosDw5OFMfM/Wp0U=
X-Google-Smtp-Source: ABdhPJw1qiC+EETgVv2jNRzLNO/zi1fvMFYU9hpdvn0b+pH9QHVxAXxOZtdD+VrtfXAaoLDeKAIrL4UJ4qXU0ivWJ7A=
X-Received: by 2002:aca:4748:: with SMTP id u69mr5012897oia.5.1616122625209;
 Thu, 18 Mar 2021 19:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210317160840.36019-1-daniel@qtec.com>
In-Reply-To: <20210317160840.36019-1-daniel@qtec.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Mar 2021 22:56:53 -0400
Message-ID: <CADnq5_MRskiOaMw-p4Xdq3i3Z2fJ=J2u+8LYFk0EydhRBPeafQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
To: Daniel Gomez <daniel@qtec.com>
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, dagmcr@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Mar 17, 2021 at 12:09 PM Daniel Gomez <daniel@qtec.com> wrote:
>
> If userptr pages have been pinned but not bounded,
> they remain uncleared.
>
> Signed-off-by: Daniel Gomez <daniel@qtec.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9fd2157b133a..50c2b4827c13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1162,13 +1162,13 @@ static void amdgpu_ttm_backend_unbind(struct ttm_bo_device *bdev,
>         struct amdgpu_ttm_tt *gtt = (void *)ttm;
>         int r;
>
> -       if (!gtt->bound)
> -               return;
> -
>         /* if the pages have userptr pinning then clear that first */
>         if (gtt->userptr)
>                 amdgpu_ttm_tt_unpin_userptr(bdev, ttm);
>
> +       if (!gtt->bound)
> +               return;
> +
>         if (gtt->offset == AMDGPU_BO_INVALID_OFFSET)
>                 return;
>
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
