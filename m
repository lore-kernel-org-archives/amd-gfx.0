Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E5C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD9D64ED7
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 19:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD9D64ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBEC6E13A;
	Tue,  9 Feb 2021 19:42:08 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782886E12D;
 Tue,  9 Feb 2021 19:42:07 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id i20so18589355otl.7;
 Tue, 09 Feb 2021 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iIXI5cwCPG4jYC5gF0Gmq9cATGqxVntBOzHncU3t7tE=;
 b=TLf5KsxTI1BJBzl/ZWallpRTaNDOdA01qtwpLejJgNfsvmMLvgnIzouPp4EjPhFR/g
 FSouBQpXh8+ikgMawIBpgKvcVlk2UuEkABK2TJWKpfQm4DLIrURzGlwkyIb/vvUGZdIh
 PS/5P3EhlxvRGQIIj73LF8z3y1+GJ4valW3jgvnN81D92ILHYRQ9IIA3CAHtkQpuR9d4
 YahI8eS2UVlx8e5JREnt/YfhA5Y794L/m5eqXJrE6Me1UPRvMBlwVaKWHHt47514Vo1M
 EQcfzpEyYdmmnP5Rg0bficRPfLRc5QrljWa7n3grS5ovQWib6Te3cm5GSc4Scpz8bZNZ
 eewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iIXI5cwCPG4jYC5gF0Gmq9cATGqxVntBOzHncU3t7tE=;
 b=c4oQ4enMWrghKjRWDecFKSblEBJRqVj9MvWcWQUXN9SViOZ6ja3pJ9gHdtrw/B1EQz
 h7Q/QTzjDUlyyRWyPBnHcT0oujtwSpBMTSWkwjHyG89Ia8wBkWTnl2GpFMGgC9LhiIHO
 +TmG58YmYQxeuxsegNIauOPNeKJiWNT/jeZ7zW8E5utUrN+nQnMBX3Vj176w715hdr0B
 VIH25qdy/BEFBq4YtNszbBv7gZ14cgPNQWyUAm6Q6DguiVSw57PvanjXPYQZoiZYLkde
 PqD85hcrJQaObyFbGCSimLw10rHhBcvW5NcaKQPvoFfea1PIL68+6M4f8Ohp0Xn0OCte
 3Z/A==
X-Gm-Message-State: AOAM532gjGUUV6GrINLffeWtrDtQurIjfPwvgEUED41eEFVXtjf1dtEH
 zTGyqzGQLfdZMlR7HdhoivnzPaKzA5jWuJp5lo0=
X-Google-Smtp-Source: ABdhPJxe/LbNTDwz6oVoyO1velECOYaLooQth4WxT9G2lnxcCf8k4s9YX8aMa9AupKhej92nv+x3xyBrWRnU26DhHT0=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr10447185otj.23.1612899726866; 
 Tue, 09 Feb 2021 11:42:06 -0800 (PST)
MIME-Version: 1.0
References: <1612779458-70938-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612779458-70938-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Feb 2021 14:41:55 -0500
Message-ID: <CADnq5_MBY3nx+RmzgigfbBQ05KLRq6UHyCW0eoqfNQRAwd6g_A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Simplify bool comparison
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Feb 8, 2021 at 5:17 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/radeon/rs690.c:190:6-35: WARNING: Comparison to bool.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/radeon/rs690.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
> index c296f94..7bc302a 100644
> --- a/drivers/gpu/drm/radeon/rs690.c
> +++ b/drivers/gpu/drm/radeon/rs690.c
> @@ -187,7 +187,7 @@ static void rs690_mc_init(struct radeon_device *rdev)
>                 /* FastFB shall be used with UMA memory. Here it is simply disabled when sideport
>                  * memory is present.
>                  */
> -               if (rdev->mc.igp_sideport_enabled == false && radeon_fastfb == 1) {
> +               if (!rdev->mc.igp_sideport_enabled && radeon_fastfb == 1) {
>                         DRM_INFO("Direct mapping: aper base at 0x%llx, replaced by direct mapping base 0x%llx.\n",
>                                         (unsigned long long)rdev->mc.aper_base, k8_addr);
>                         rdev->mc.aper_base = (resource_size_t)k8_addr;
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
