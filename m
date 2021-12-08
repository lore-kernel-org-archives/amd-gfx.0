Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF0EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D9F6E5CC;
	Wed,  8 Dec 2021 19:42:36 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63886E5CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:42:35 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso3902173otf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=atHVI73ad1Lb7UwbbseeZBgoQjT2vdGnmn5cSu0IS/g=;
 b=nHAZsziEhvFJ/naNdI4784fFHLveF+MUp639w/G56DHAw4DV7C9cd+ridL/Yo16ze4
 2lOKezerkt3igMYKmRO2jUzSKh9KRQeHO0G9EehguCUOXGPtM62BvvCpm6yfgyeedoMC
 6h6Cuy1kBvv41x0VAbuwSdz1mOy9YDrOK7YM6rzxyhc5qT4nY+k6aMXY1FdUSGCQX60d
 I6Eb1mk3D2dmTAdfWNPXdr80g7D86l2F59nhTOacE8frpFCwlrKAMk8rvGl+oz80O1bX
 ozgrEmELZ2tR69ex5FaV5f4ydaq2KB1MwrDlEjfZ1NbYTYoDevDQWrK8TepfdQtRbj/O
 iaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=atHVI73ad1Lb7UwbbseeZBgoQjT2vdGnmn5cSu0IS/g=;
 b=RGzdO4BmtLYcGXUnIrJHamriC8TSx6BTh1hdTDTZScnXQ88fEueZOlRQvP2yflpCFB
 u1IeNjZRN0VUwk2CKwfaYUBz360hz5njI/ELgMoEP6VaLhk/a8YLBuADPWOC3DApB+Pc
 VJaxzdl07NePQlR1XmPP+XhnQOHhCSIjiRGfEpF/xUM8bx1vmai9uK5jaYC/SRyGRDLr
 C4HWYzt/QEJQ3+F2OLSLBdErZK3y9Prvna1QcJpTHC7NTpoDN/IIS4O9pDGqAmlU0Kf4
 La+RwXhbFPJ3z/3d6VxawkxT9T8htmTqy9larLk0pacKLWu6P5NlFnVzIXxJpcf9k4aM
 qGgw==
X-Gm-Message-State: AOAM530Cjpu0LHHDGEIgYUs2ow+kWiZlw6rDtw3QlvulMqpIgBYUgdci
 uuIjp+o51djK5fqAEZFJq2Y4TFkOx1VFrEign40=
X-Google-Smtp-Source: ABdhPJwoaw5xQ5ep8UlGrxHV8YfoqWXGlI/FZR+w+egQ/65xSTFLHB5yMNLUL1KfA7pGca1NhEcRzS/zrDygMrgDV5k=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr1431029ota.200.1638992555019; 
 Wed, 08 Dec 2021 11:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-4-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-4-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:42:23 -0500
Message-ID: <CADnq5_N=ArmDXnRKc1GiK-VLS82_Ku_AFxX+5yBGUU3hWAknFg@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm/amdgpu: add missing function prototype for
 amdgpu_ras_mca_query_error_status
To: Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote=
:
>
> This commit fixes the compile-time warning below:
>
>  warning: no previous prototype for =E2=80=98amdgpu_ras_mca_query_error_s=
tatus=E2=80=99
>  [-Wmissing-prototypes]

I think this function can just be made static.  It's not used outside
of amdgpu_ras.c.

Alex

>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h
> index 1c708122d492..34e651f39bd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -620,6 +620,10 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *ad=
ev,
>
>  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
>
> +void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
> +                                      struct ras_common_if *ras_block,
> +                                      struct ras_err_data  *err_data);
> +
>  int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>                 struct ras_query_if *info);
>
> --
> 2.34.1
>
