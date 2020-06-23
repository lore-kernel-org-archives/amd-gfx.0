Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC188C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8F62072E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPayTgKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8F62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6116E7F1;
	Tue, 23 Jun 2020 21:05:05 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81206E7F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 21:05:03 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id s10so2005545wrw.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OtJv+QvJrCjwbAb7M2LZibEs1jJtugdY5UtP06D3o9Q=;
 b=sPayTgKfWB2juNFKCCTLWWy/9d67gd9qcOr6MUhl33T/LBBf/ABcgbOUtPFDiCWmCG
 l2RUW6IrwLCisC6/qHTcN67uFjQiyQAfEW35MvHO7bviUB/58gNw42PMXf+6f3Jrgqus
 WsF15+nmkwCnj66+RvyxNce8Rgv/YAHH6bTTVZqdf+342EzLiaKqV5C8OgeBnXowJFa6
 eVdLnAI7awIQT3dp/wW19qsNWVFNG9+KbIaz895wGVNHBblQhC9unVgCK1jM3zESTS2E
 bcLp7Qjm0iQW0nI1dCNDUmdxqwqePnJPdozE5FO5h9c6W5XnOvjwGz8YtlQE64Y0g8UC
 LB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OtJv+QvJrCjwbAb7M2LZibEs1jJtugdY5UtP06D3o9Q=;
 b=CfGDXSuxFWO0wvt0VmYbBKZTSko182rAl8ZvZUe4/bJB/Pt20bhLOt8dbxSi+D/O9Z
 A80GeK6Nq0hRx3gcEG13Mog3gaMs9/bte2mCwW71fbUkSt6YZpLG6mbMqwCCCJrXuKpz
 sgQyG9np8eR2h8AylR8b2l5mwFkOCkQhPDzdfn3ErAvPcAtZ25vCHPOgZwHx5J8KKZ8j
 mE3YUH8Y1aNBJYkqp8IVKZotmwz/SAAl+6ys4krtGOQAmxl7Mpwg37v1fHzqQeThafyU
 245kA/OX3w9Mv0GO/xbgRKexPV7PovK82V5ihhhkakCzNJS936XZUxhFk6wXuzEbZyYa
 ceiQ==
X-Gm-Message-State: AOAM532sMK4KUpXsay6cVHoAjAmM0oBLZWTTYK0JmZY1Mw2SnXhi2flL
 UpgSPULjhpLtvepxcA2F2KWJ8RHwBtUrWiLXIMvmzA==
X-Google-Smtp-Source: ABdhPJx2cFN3ZpJk3gotxO3a0q426CjvdGOWjhT5cLSUcx9kt6Sa85ChrWj8Y5X4b8uUGcTLRn6HNFFEaFQ9gGtQpy8=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr25985wrw.374.1592946302432;
 Tue, 23 Jun 2020 14:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2006232235050.3391@kirika.lan>
In-Reply-To: <alpine.DEB.2.21.2006232235050.3391@kirika.lan>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jun 2020 17:04:51 -0400
Message-ID: <CADnq5_PXTr35_zcbRTAxb9=rHSo8_WcNzCeqqkuCyHLzUAtAHw@mail.gmail.com>
Subject: Re: Mutex stays locked on error
To: John van der Kamp <sjonny@suffe.me.uk>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 23, 2020 at 5:02 PM John van der Kamp <sjonny@suffe.me.uk> wrote:
>
> Try to mail the patch again, this time inline. Hope this is how you can
> process it.

Can you use git to create the patch (git commit -a -s) and use git to
generate the patch (git format-patch -1) and then send that out?  Make
sure to add your Signed-off-by.  If not, I can just apply it on your
behalf if you are ok with that.

Alex

>
> John
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index dcf84a61de37..949d10ef8304 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -510,8 +510,10 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
>
>         srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
>
> -       if (!srm)
> -               return -EINVAL;
> +       if (!srm) {
> +               ret = -EINVAL;
> +               goto ret;
> +       }
>
>         if (pos >= srm_size)
>                 ret = 0;
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
