Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE73C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2333764EBA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2333764EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAC36E32A;
	Thu, 25 Feb 2021 21:29:13 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A7C6E28A;
 Thu, 25 Feb 2021 21:29:12 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id j1so7611894oiw.3;
 Thu, 25 Feb 2021 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vNmAJW/zyB5XEgw8h6FvBxPzYo4y5t37treLZpDOceo=;
 b=sCz9tTsaYlGjyP3OVvfQHFE1Jq6AsnZXv+DwdO+YsX5JKbirG+dxUiAQcZel9UnGqe
 6wGtCpgN4+68XYtWekQ6PmZOEBre3BbkSMKVINyqWimLyYkrhbZqL7I+Pb6YzzwEQZhT
 gm+7dCJdIkCE6jhtx+dyFrKO+viz0wd7E2zM+HVtjx1Gp/NN2nuwMudtsDs3lmM46eHc
 R8NWfSK2tB8EAIYdNkB2CGiGq+JL77iXK2UEhm7e6lABHemU0KDRpjD3lR1BCtVoSZjd
 KrHd5WrbJXGoIp9ZylUcomEIHcByTk90TUvzltlJ9lASAaQPDvdZP7/7qPrA1Zfj2fu+
 gxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNmAJW/zyB5XEgw8h6FvBxPzYo4y5t37treLZpDOceo=;
 b=BpwkvhPpj5VMBUqogtsVN8JhDS/d2xB2uxESeh426IrQs9mqb7LqUbvm12OfTkc5O+
 axc7t4kGeEIBy880cffr0OvW5VY8f+oU0g2RkNaOqXRgdSVp/S/hCf/9COG1uIRIsNUR
 uca8ZkfQ9Sc5dAGu7BwjB5e9xQ1NNcwozm7gKXOweVjZSi03yqQqyMmIpfpNLCcmlbCp
 kBjSA+W1+IQauw61YSEVtOOjJSLVqJkUQtWCZOUPylnSrocAENSxlPgnmyD5BJRGHl2C
 ZDhF9QTstG+fG3CZa6mcBf58mFzV3Lsvnancfst3/rQOzby971FVETuHxnoHCtLyNeii
 QiVA==
X-Gm-Message-State: AOAM530wzp1SNncNSWO6DtcV9AsiyOg2wiZf+adNcwQ1xlNKAixn85J8
 7gUccvLTHiwk3AKzCsK1yqG20iPlTcraq2ot+RE=
X-Google-Smtp-Source: ABdhPJz8h5CbpNmNWFW+5CPs0D5Ot6TYcO6pJ5ZglZgFse6a4n332blIPY1hL7WS4TLDebN2ONgPU+pxu72DeVZttco=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr254325oiw.123.1614288551794; 
 Thu, 25 Feb 2021 13:29:11 -0800 (PST)
MIME-Version: 1.0
References: <1614243728-52952-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614243728-52952-1-git-send-email-yang.lee@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Feb 2021 16:29:00 -0500
Message-ID: <CADnq5_Net7GN_zaMJWeO_b-zXwOQMNNsx5YqvhR_UdWxP-rsYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
To: Yang Li <yang.lee@linux.alibaba.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 25, 2021 at 4:02 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1589:0-23: WARNING:
> fops_ib_preempt should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1592:0-23: WARNING:
> fops_sclk_set should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0a25fec..52ef488 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1586,10 +1586,10 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>                         amdgpu_debugfs_ib_preempt, "%llu\n");
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>                         amdgpu_debugfs_sclk_set, "%llu\n");
>
>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
