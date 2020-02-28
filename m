Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFAC3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28CF246B7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgn/BGOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28CF246B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650636F4F1;
	Fri, 28 Feb 2020 22:13:00 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2246F4F1;
 Fri, 28 Feb 2020 22:12:58 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id m10so10290085wmc.0;
 Fri, 28 Feb 2020 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4vEgSlwH75ppaka6b+eKVprx44dYfhzjy3hFcJ1TMew=;
 b=Pgn/BGOmhwNTEW9jt9xY95LAAaP/UusK+8Su8i9f6r3ojI8KeWFQuDqpmJ1FzAhokR
 tT8tcCFvUGmp/p70sk2gIiHpRUeylLGWL0bpUAO6Kdp85WvIFX6wGSHzmFI8l2B2gSvu
 Qih+FYevFdaaedcaR0c6dFEw1RyExACbuXfv2iztndTNz8vDErMsRdzdevj4nTsTGOJ6
 NTOLrb6stEwM/3MZb6szs7jgOysv2cZhuMjBdrdu1GiSbYicm/kFRAECfyHxazTcRyzX
 785Z5a5QtAxxXzKU7+F7y4UVszryTRBQEdSvu2ZvpQmESl7UJRqRq5NbryYs4ZUr0G46
 PJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4vEgSlwH75ppaka6b+eKVprx44dYfhzjy3hFcJ1TMew=;
 b=WSGSyQN9nPsivsnF4qLlxi+9wuozUCnpQAQJ45TBKL7UgF2vDsXMT7VEp0u3cWfx/l
 Crs2w8FuylYNiyMhFDcXr4RIa0yU89Misd3GLNcREE2Fu4gRrUNktEva9R5O9h2QDTvn
 JCkcEmppdldER+P2boAIF3oJsZh6Nbb3Z+paPRkO428K1maIo4+Nf+175PuvejYlf5ay
 NvWLJ8A4OlDnxLE+2EkAnLrbqhjYNyZcjEDbi4Y5OM/C86zAz3l64bYnchYg89ehBeY7
 KFGzrJ7DA8dvQhzHEsdtevqN0lPqQWF1yrRpo64KXitKOPV1Z/+Z2JlqXCmTal9KbtyJ
 +A9A==
X-Gm-Message-State: APjAAAUlxFLlIKftOPl/yIpd5IjNWxzhYOa/KoY45npYg4MaPJD4rxsO
 qJvNLKZfOsO/1RH833Q9BHmGfy/18GAp1QbkjW0=
X-Google-Smtp-Source: APXvYqyg3Su2Vwre81Y3TJjLjQDh/KfhxYi5ii+aVVnW0os7zljNoaDM0iXi4ScsRG1uz0qAapyLHxVvt9Xn+3EXPl0=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr6528043wmj.70.1582927977310; 
 Fri, 28 Feb 2020 14:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20200228130821.64695-1-colin.king@canonical.com>
In-Reply-To: <20200228130821.64695-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2020 17:12:45 -0500
Message-ID: <CADnq5_NU-GFbj0pTkzjGeMh_J5KM_mNV_NJ_gMFsjt0-Xi=vZw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdkfd: fix indentation issue
To: Colin King <colin.king@canonical.com>
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
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Feb 28, 2020 at 8:08 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a statement that is indented with spaces instead of a tab.
> Replace spaces with a tab.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index f547e4769831..5db42814dd51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -490,7 +490,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>                         dev->node_props.num_sdma_queues_per_engine);
>         sysfs_show_32bit_prop(buffer, "num_cp_queues",
>                         dev->node_props.num_cp_queues);
> -    sysfs_show_64bit_prop(buffer, "unique_id",
> +       sysfs_show_64bit_prop(buffer, "unique_id",
>                         dev->node_props.unique_id);
>
>         if (dev->gpu) {
> --
> 2.25.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
