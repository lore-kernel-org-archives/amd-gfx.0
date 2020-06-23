Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB092078A
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE1v1mPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB092078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973756EA5F;
	Tue, 23 Jun 2020 21:48:30 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE0E6EA5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 21:48:29 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z13so140639wrw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wz5tZbtvhDL7V2IxGI6ReABJtU1BmQXXx12c3iNwt+A=;
 b=kE1v1mPmow+WF/pPjFnrNh0+i5qnPIzxKm61S+ep2h+QO1hMTyw91H3ccvE18jsLKX
 IBDQOi7ki9iFwpmQtpZoz/qvtIXeSYb2O3TqGSaqEmEV0QB+82Pvv/L3XzatmopR4r6A
 x3hHsWRe2HwrR9RXWH2VG2n7363GBPoOFATJu573WzeIzNCDqUYYf3brcsqC5RtvfDJs
 cIAPIbrEf9UEHquWtHoc83/wZYGMu6j72V+yAQdo5qXmM1eeCb+8h5w/wANxeJQKNp9y
 OdFkfZfHFxkh9SHqmQ0WlaIePa36TGZcttkOPliTfAy6a6Ek3CikCSXPXSTxKLtgPJjz
 QZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wz5tZbtvhDL7V2IxGI6ReABJtU1BmQXXx12c3iNwt+A=;
 b=sQQnSZRhNDuyWhg5G8iXgL5ntUUBihnacRUUy0AzFnnUMDUmfKx7uYL5iUPCosRFv4
 r1AosZrtKAFY3jjYVkEjuRwi11367MSI7xmeyjEUNW/ya8jyW88yJlrzc0jycyyyxFSd
 FxejO+1lK5JgufoPBkSFtIla0O4//wz5ohQFI+tq067W8lmVnnjegYHzTAdRDntx4MMq
 E+hHMQ29C5GrroEa1xCTLcObda836JxHruSD9HYtUc5+jihKuBH7H3liWL3S1ZRFK26a
 0syT9bi1FpfAMAhCH/GD8Djrw/YkMr6lqKmaohw1qye3oXjVKZ9viibgvCwaSRUJQQyK
 v82w==
X-Gm-Message-State: AOAM530rEx+bSZJS/NF1WzpW9Oh8Bv7IFkJqNdm5aiGRsk1Yd+5+wCe9
 xvr9ZkllnpOnS9SX+fjZr2C7NMaUte+6zzP395f7LQ==
X-Google-Smtp-Source: ABdhPJwEgMgE5NrYlnE0KPLyJIHy5kJXSFdQyLTO+v+9p0q65zvu4+vjHoWmhXh2rSB0aW7Q3OEAM20+lp9OnOrMg5k=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr17603669wrl.362.1592948908156; 
 Tue, 23 Jun 2020 14:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200623213054.8847-1-sjonny@suffe.me.uk>
In-Reply-To: <20200623213054.8847-1-sjonny@suffe.me.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jun 2020 17:48:16 -0400
Message-ID: <CADnq5_Ncs3V8TBvNjczODd0M4OqiBZNnGN6CSUowo-_5WCikdg@mail.gmail.com>
Subject: Re: [PATCH] Unlock mutex on error
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

Applied.  Thanks!

Alex

On Tue, Jun 23, 2020 at 5:33 PM John van der Kamp <sjonny@suffe.me.uk> wrote:
>
> Make sure we pass through ret label to unlock the mutex.
>
> Signed-off-by: John van der Kamp <sjonny@suffe.me.uk>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
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
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
