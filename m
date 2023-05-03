Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC98C77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C6B10E266;
	Wed,  3 May 2023 15:34:11 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CA810E304
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:34:10 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-392116ae103so2668499b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683128049; x=1685720049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WThOUAoJX89B2HUz8Mq+eDPMlI1TMXpmRJsL54MDZPY=;
 b=GZP/cAM+lMsEyO5l4cCUSOseyRYfak2reUwveynG9R63+gT2EZ3TU0UtEii/xKPB2A
 d+Uhigjvi44VLBnMjIwFun+Xfbe/KEkk2hrt5a9hIZPneIxHgihPsXwbxZC52gCj198X
 Y5StChrhajaUA0YR8um4zfuVCBMAlQ4gKdv5uLWWaM3OnkgoM1fsr8S8yEwLryyjO1K7
 clIUmCAvLXkxvFyGsyUgnvKZF4RSVEqDrY5k0/Im0J1mxJgr5BKtse3r/flW/h6LklCH
 TLv9/tucxrjryqNdnCy89Me196YaEGBRUlbcLVdF6f8mwGhe1x1PwtW/3Z29Su2shm4h
 FY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683128049; x=1685720049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WThOUAoJX89B2HUz8Mq+eDPMlI1TMXpmRJsL54MDZPY=;
 b=EmWkB5/QyL7QhPDIcXSxlJtJAcLycKVco4GgThjuMjahNlHE32TvyyrgA7+KJoaTWU
 jwfJZSTP5QBJLpBSOAWbUVYq2zOATw60+HyzuCz3vqScbQzDiARt3GrA7BeYSF5s0Gf7
 3Ng5ZkKFxpjrItHFHNBGu9FahkqEYMKuq+qpt59VqorIEYoGyLoKQ8fFNvM/SSG1KcZy
 /8efkaqM9DZI4rNuKy/WdNs0CsWqK/wsUFO7ZkKYzO1SEZVNIGHSKH6GVQoz+JMISXk8
 XzMMRGzS/dSUHvqYKorVJG5ViAt+zjSzl5dXh6tp5624avOaofAyQlqqp4hyUDBBZPQv
 GgUw==
X-Gm-Message-State: AC+VfDwYDZQ1EjDv78PXj1c/axi8Nhf1TVNTdbTDOQ5SJt57R24K0db9
 z7qlONBj0zybCi61XrjN5e346e0ctQAo+YWO90I=
X-Google-Smtp-Source: ACHHUZ6r7nejyMHl5GGHVw45u7b0iq1odtg40U2hOsOPQQ0OlwfskJJyhwH5LN6ImI8gNfY0WEyrflfUMrNSWRvcEo4=
X-Received: by 2002:a05:6808:238c:b0:38e:2a4:fd84 with SMTP id
 bp12-20020a056808238c00b0038e02a4fd84mr252148oib.47.1683128049504; Wed, 03
 May 2023 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <072c8bbb-76bd-42f8-bb97-ebc38acad470@kili.mountain>
In-Reply-To: <072c8bbb-76bd-42f8-bb97-ebc38acad470@kili.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 May 2023 11:33:58 -0400
Message-ID: <CADnq5_PqQuKRighnXrQrAmE0RojT6PQjLQ5a2iQXiHq3VhZEUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: unlock the correct lock in
 amdgpu_gfx_enable_kcq()
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 David Airlie <airlied@gmail.com>, Tao Zhou <tao.zhou1@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, May 3, 2023 at 11:29=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We changed which lock we are supposed to take but this error path
> was accidentally over looked so it still drops the old lock.
>
> Fixes: def799c6596d ("drm/amdgpu: add multi-xcc support to amdgpu_gfx int=
erfaces (v4)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 60bb4bba1994..1de3fffae9d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -566,7 +566,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
>                                                 kiq->pmf->set_resources_s=
ize);
>                 if (r) {
>                         DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> -                       spin_unlock(&adev->gfx.kiq[0].ring_lock);
> +                       spin_unlock(&kiq->ring_lock);
>                         return r;
>                 }
>
> --
> 2.39.2
>
