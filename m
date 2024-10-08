Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9A5CEF173
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA9410E525;
	Tue,  8 Oct 2024 13:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyWx8rBt";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D8C10E525
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:22:25 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso664318a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728393745; x=1728998545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuOpg8tkvWoeClMNamH2mlGkYuGgAwuHdZS0sE5jCK0=;
 b=WyWx8rBt/lXkcEA+yY+qkLiEKzAee8NGkxvytz3+BCJUNc1lm6mm81I3DeiukpxXOu
 M1yiPmSknWL9pKS0Ont4DcQOMjJxsB4zu2LtIHvWvfERymSx1gIVYmcwdHA6r2BZp6rD
 cOTtYw8Xse566v+mO+BMZPk+eDmBoId+V/kTS9QTKm6C0T56hdp7x7U/yf5rtbCM5FOs
 3JYB23oy2TRbqfbI9fLWU6sW79UW3Q6hnUSvhl8syuv2BeEKk2pcN5/LAmT9jjWyabX0
 stf9IX0HGw3mTlsWWDSbiQPta7NodSrUl2EDrT59ia1gyg7F9WXfoJkbJMAlh3bTlHkE
 fgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393745; x=1728998545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuOpg8tkvWoeClMNamH2mlGkYuGgAwuHdZS0sE5jCK0=;
 b=a8eJD9zECz9/ENuRtDd2kIESdKUidd8NUk5BlIaPwwrm6pCYfwy1j8gPAeZ4p9iIxz
 RG7HrslLGCZ+4wxjxYhMp9ozHoZ4Z/KnnHBh165h4kq9arBxIouOLATf8zwz87V116Qp
 CVIa4hiNkUUaDnEEEhfVPARIdSwDbPKMocThkd1pDMNItZ+/8/ew48CwNrWpUI438FxS
 HNvLjQU45sbCP6NEQ5+soCZqZ50WPbeR1xVDyarSWnhdhRpCzgRLxvbgqDyQqaV92wKb
 E2/42zH/iH+6jaVr73Hml9nj45u8mDN7hJYdR1w6eAXCImeZhEHjx63hEgq/bMgIISks
 nubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwDnUE4To7wSftRTYQnSalasni/NnSjr4CNPYRyfWFB4E1a7iMW/4Wap/ESgvphcfqUARW8qFT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4I58UTXnQ/iMI6i11jXoCRZodzBDyu/pTNMao3Q5fU3xf3ZUQ
 ZNT2kamGIOr8eEQ/hShmF+P8IVkfuUfWg8nF6h6WeteJurI68JrOYJJMk6eqqUcT5yTBn14bwA5
 KMhJrsWPcIGQZPlNHnGOO6wHLmHrCkYAF
X-Google-Smtp-Source: AGHT+IF/lTFZKz1tnOFDynN1dT2Nkxa0rZJVKrdMo5q5nw2OfUIdwwlW87PoDP99rhVIGRrU2PVkMdb8Bx37En+6alg=
X-Received: by 2002:a17:902:d50f:b0:206:b1fa:ccb9 with SMTP id
 d9443c01a7336-20bfe39ffcfmr94667895ad.6.1728393745000; Tue, 08 Oct 2024
 06:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241008035953.595701-1-sunil.khatri@amd.com>
In-Reply-To: <20241008035953.595701-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Oct 2024 09:22:13 -0400
Message-ID: <CADnq5_NtxLADcJnjF8R9E-xu209Wso4sj00JJdytcXnPvLCTeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix dm_suspend/resume arguments to ip_block
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 8, 2024 at 12:00=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> "build failure after merge of the amdgpu tree"
> dm_suspend/dm_resume functions argument mismatch
> not caught in validation as it was under config
> CONFIG_DEBUG_KERNEL_DC which wasnt enabled by
> default.
>
> Change argument from adev to ip_block.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Please add:
Fixes: 982d7f9bfe4a ("drm/amdgpu: update the handle ptr in suspend")
Fixes: 7feb4f3ad8be ("drm/amdgpu: update the handle ptr in resume")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>


Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e4511f2fb929..6d5b899941af 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5201,15 +5201,20 @@ static ssize_t s3_debug_store(struct device *devi=
ce,
>         int s3_state;
>         struct drm_device *drm_dev =3D dev_get_drvdata(device);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       struct amdgpu_ip_block *ip_block;
> +
> +       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_DCE);
> +       if (!ip_block)
> +               return -EINVAL;
>
>         ret =3D kstrtoint(buf, 0, &s3_state);
>
>         if (ret =3D=3D 0) {
>                 if (s3_state) {
> -                       dm_resume(adev);
> +                       dm_resume(ip_block);
>                         drm_kms_helper_hotplug_event(adev_to_drm(adev));
>                 } else
> -                       dm_suspend(adev);
> +                       dm_suspend(ip_block);
>         }
>
>         return ret =3D=3D 0 ? count : 0;
> --
> 2.34.1
>
