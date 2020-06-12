Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70992C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EED20835
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fopozOD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EED20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5716E135;
	Fri, 12 Jun 2020 15:24:55 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84D86E135;
 Fri, 12 Jun 2020 15:24:54 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e1so10161973wrt.5;
 Fri, 12 Jun 2020 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fdrA1iXEBobTaCltTFCacW9YJrABdUKyjxuRObbJj7Q=;
 b=fopozOD8Q9Z316h4yVtPKbKc4/uZH8jo/Yv8Ed+vhZ2zQeOnNIBp9uuZ3U7aHsCENZ
 Hk/OB/Jw+k4+xKCd61Eybax+nVK94EPdXXonB+vQHqFF1Q4BOHDnZSUL1MdaBRxPxr+Y
 GqWlriaM/FTUdVrsgIZnkaCQhATCDCZ7RvqsmAxaz+uNfcewFS6su67gOj3XcHr6BDkl
 o5okfVLgoB+TN7NAdJwRNQsiE3XNI3NVs91y+Gb/BwjP2eUdYIP+qYTFmWWMmPosv5+A
 YHx94AkQtK5nH45f79IQw+yy+vjGFBKc8SeSQIkgx5MqP3dMhtbi98OFtObjwTQqTwwj
 4Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fdrA1iXEBobTaCltTFCacW9YJrABdUKyjxuRObbJj7Q=;
 b=Y6fw6ssPCXE9yd1magZlwiBxsDfB6LwJ5rqR6cC7+SOVWrvx0+pecTMwRy4Agi3kFh
 uB4E6jbz8PZ7HBlQCbA6oQd+8qqTXxkkWs906O4YEItVtAb39AX0NPeovYuTei2GDv+W
 o1KQCpglvWEuArTGa7K3JAD+iADS740xi+A3adHr8i+mVvYqTZzwvl7jjVROmbgmF9q5
 r5eBoPmK2GeWoNqDgjD7teGsZ2ChPR5SnBjjByekjHsUcJRvlDqi7PySFzG7AOOLuepg
 SlDnpkzAWxeDigHPHawLRka9T++CGRumMzvRYO/FpXXmn7VEa9J0SJldbF/2/oIXY+YE
 pWKA==
X-Gm-Message-State: AOAM530HaIu0YUs1TpDFvrIyQN044Dyfr/qZThKDnicoi6gpTqUba7ej
 IOEuUvSidKumEwDtUgeIlOmpE7GJmAXRW8EUu48=
X-Google-Smtp-Source: ABdhPJw/HQbjV25QRzQyt5NHirKIUr0sdJ8NaQMgtbOdZDHffLIShgu8/5/AFDXmgcgg3APrFmdNsuef1af5bjqGHh8=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr16355895wrp.419.1591975493465; 
 Fri, 12 Jun 2020 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200612122825.10450-1-bernard@vivo.com>
In-Reply-To: <20200612122825.10450-1-bernard@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Jun 2020 11:24:42 -0400
Message-ID: <CADnq5_M2V3g9AA2HpL_XEbRvLW=BWUbiE=RpZa2YKnTX24Zqkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: remove unnecessary conversion to bool
To: Bernard Zhao <bernard@vivo.com>
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
Cc: opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 12, 2020 at 9:22 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In function is_support_sw_smu, remove unnecessary conversion
> to bool return, this change is to make the code a bit readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Vega20 support was removed from this code path so the patch is no
longer relevant.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8c684a6e0156..3e1cfb010378 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -568,7 +568,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>  bool is_support_sw_smu(struct amdgpu_device *adev)
>  {
>         if (adev->asic_type == CHIP_VEGA20)
> -               return (amdgpu_dpm == 2) ? true : false;
> +               return (amdgpu_dpm == 2);
>         else if (adev->asic_type >= CHIP_ARCTURUS) {
>               if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
>                         return true;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
