Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B11C35247
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 16:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2540620730
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 16:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KexPIN4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C267B89DB7;
	Tue,  4 Feb 2020 16:54:00 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB2789DB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 16:53:59 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m16so23951559wrx.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2020 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9BX3lKMiB84DZa6iKawgAaPfT8fDloPUQu5rhyRBGTM=;
 b=KexPIN4t/JZ0p86IuiYQYzeL8A0bSM5Wvp2ebw41rw1N7GZbS8yeCQ75V8L95Rh5P+
 6f41HXEcvo2vRNzRM+B3K/Veikq8Q2/H7XyOin4uiuxXYT0oa4eITHPcKpWBn8vjCqQF
 +z7a1WekQO7XFXjG42Neho6T/BWwt2zkZTTpO9YIWSOrIjR6CRHrSyDD0Aam/QiZeccS
 OtRG+yDmpa6839vtot5tC+qsOUgXOYOEPBEShmRo7cwJKKlTZMU80qIzQKz1PuTkc+nI
 5iDfA2T3KUYKj/5f9FQpoOfKg8hGrl/EqcC+yzINiJx7sLuvyRwr6mFGb/s9I6a1eKuU
 DdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9BX3lKMiB84DZa6iKawgAaPfT8fDloPUQu5rhyRBGTM=;
 b=jmUEVIgrA0pM2iWJe8i4t3tJSuFRS3+SZzYPzXcIIF9/3876Gf3/61PS3Rr/+EhnpS
 guQym+qpdox6FXWLNb80djzj/aLcv9CopyGkdabC9Xw4c2Ic7Ny0ClA9ZilgUNho3yKj
 3b64s30vBYTT+ADdTJ1lYWSswSxdXosxgRVx4d5ihtKx91onwRZ6hj4vcXWFLnRLm7w1
 HWPbzX9MsZ8ppT+djopK5JUnArrm7MU7X4VZlTkA7xpMkym1fv2ZGuS7dNMzXK28csg+
 alrrTMEzCDp/QULw0FmgM4wlAjslEkmBaxAu/7OtYLhSdBrj/xwNZ0Jii68HGspLrAmw
 8tjA==
X-Gm-Message-State: APjAAAUXyUUcbbJIsIlnA6YHmGU9E3yjm61kJ1uEFRXtt4+NsVPR7fhO
 QTkoKvW7F5Ryy32qiAv1BiUZNsE0W54Xg8RnTdw=
X-Google-Smtp-Source: APXvYqxBRDVTPdcgWuRhiIlbZmATngtxo+ZK6lQv76ZHYMxxF/1CeQAVyyQd0QJBgppurndmCEleritxRnsm2PlgLjY=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr24427073wrn.124.1580835238170; 
 Tue, 04 Feb 2020 08:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20200204145122.46353-1-nirmoy.das@amd.com>
In-Reply-To: <20200204145122.46353-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2020 11:53:47 -0500
Message-ID: <CADnq5_O78RiDRehdnhrR0pR7um2LnHQeuZoGeB_eHYs=AJraPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix empty return on non-void function
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, nirmoy.das@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 4, 2020 at 9:49 AM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> This fixes empty return on non-void function, amdgpu_xgmi_remove_device
>
> Fixes: b80574252499e (drm/amdgpu: move xgmi init/fini to xgmi_add/remove_device call)
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 78989e9560d1..490f57d6704c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -463,11 +463,11 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
>         struct amdgpu_hive_info *hive;
>
>         if (!adev->gmc.xgmi.supported)
> -               return;
> +               return -EINVAL;
>
>         hive = amdgpu_get_xgmi_hive(adev, 1);
>         if (!hive)
> -               return;
> +               return -EINVAL;
>
>         if (!(hive->number_devices--)) {
>                 amdgpu_xgmi_sysfs_destroy(adev, hive);
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
