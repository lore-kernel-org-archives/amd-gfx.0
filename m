Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D07CAC588
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73AC10E0C9;
	Mon,  8 Sep 2025 13:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiTA8Bei";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110D010E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:56:39 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-24c95f20117so12045245ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757339798; x=1757944598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLnIH2nmm9uXWH9+Ny/pFxYe/vJgyJhpA+iAZAk2WvQ=;
 b=HiTA8BeizTXuX1INGfN9askVkHqAe7zH3O7xhTXwEVg5BIUdBOaZV1yhA+nHbdTPWj
 w84+WvLziFNCXxRSSBf1fz5/NTx9vF/Q5GNrugQnrNt/xDEE11qanfEM8GyzQKzqt2UK
 kY6FFkT4AJmPwvs/vEn2oRIWAUYEu10gBSwXdYCgxJG38/evw4W6rpK6zA5/5i4UPsZc
 HpCQFIAvNDE0Fuv1RT9S0xVlaCiS6ds5JDDtk3SS6a8ljApecvKnMRXWIax0L48/5ovl
 CMQG2Y4OXRWB4IU1Q5wZRiD2ACGCWkSGjszkU2M1Nw3y4LIaA76Rd+mrrwMS2e0WdL7G
 BQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757339798; x=1757944598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLnIH2nmm9uXWH9+Ny/pFxYe/vJgyJhpA+iAZAk2WvQ=;
 b=oM+YgvBNZACaFFXef43diEpoCqWDU+brHPMAmKgQb9h4fdfO8BgLrZTUyiu0PRkGAE
 roizvHrqeFo6vA1EzUK3T8J675SQdwgvaNcSLeHVpETrAGB2Bk2KoKPo2idjhfXdnM5f
 uGuFZ39bDrvDebJg4a10HlktXhHzjZWp3NOfP9MbMqVbU6jzkL8ITduhnJmzaBi+biM0
 /qsja7vybef1CrR9b/2itZk6tKGdhLG4aBdgvKD3lgLfocB3SJ0lbqyzm8CGPD7AJN9G
 WQz0yLCh1grDVHXvSAhZwfqIUyXp5fFrdqCHDIJE7SCdULEK8qHmo+hlioW7rwLvzIjk
 KgHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeBBcrGsgs3wpQiD24ScQQuQNlS0ULpJFok5D8aaZLHkW5DmDfDQizK/3RmRK141vznTDaVn39@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzj7/AeGGQndadcIaor6RKiPUEjGZI9FMmC/LmrnYAuf3ID183Z
 YHVIuoDyj78qmu3WmWJzp/DNSkHipKjqptbTcAwmU5IWjLxZCrVaFTYzY0oTdyMeSwiemxN0xj3
 sZ1xPjS4S5Jc3gpby+PokGMIDbRLdlEA=
X-Gm-Gg: ASbGncuHkM+SHd7Bk/VM0WA+qxuHsjpRNhCjwSj93T3QziY1bCfhZXdPB6NlIFgeBJY
 pmh4YgyWmMMnhqs+3KMNxcKG7Jxg6VT2uRuO8yRdvuS+R8/XsjCw12sD3SUKlRy+32baNUyvW+I
 HpRJ7SUqH2/cJ9MRTB8IIAXLZ41R5g2ecTSvuKNM+xAMnFWTdfxUVgvd9i9YkjHSw60THKG5M7I
 s2cKLQ=
X-Google-Smtp-Source: AGHT+IGRZMjQMhSxaHl0Dll+sXtdrlNAjrU4TW7IyR5aVSRZyi2IejB0zfix+fxgqC/85FLXgqLW1sJNAYe5+mWuUiM=
X-Received: by 2002:a17:903:24c:b0:24d:f198:7d7a with SMTP id
 d9443c01a7336-25176a22499mr56643365ad.11.1757339798450; Mon, 08 Sep 2025
 06:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250907230551.1804823-1-siqueira@igalia.com>
In-Reply-To: <20250907230551.1804823-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 09:56:27 -0400
X-Gm-Features: Ac12FXzx3QYlsIOS5bG2armPXBruvq_vro8Qf3dBRco6FXHy3NjCDoMG25-epsY
Message-ID: <CADnq5_M_+aVwvYrk63cekG7Ngr-dxz1omfXbTLB8Cp+em1NyYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unload issues in amdgpu
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: uajain@igalia.com, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
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

On Sun, Sep 7, 2025 at 7:06=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.co=
m> wrote:
>
> Loading and unloading the amdgpu module in TTY mode is successful at
> first glance, but attempting to turn off the system after this action
> results in a kernel panic. Sometimes, after trying to run load/unload
> multiple times, the user may also encounter other issues. The easiest
> way to reproduce this issue is by running the IGT test amd_module_load.
>
> The load/unload issue was introduced by commit 3d5470c97314
> ("drm/amd/display/dm: add support for OEM i2c bus"), which added support
> for OEM i2c. In the original commit, the new I2C adapter is registered
> in the initialization function, but it is not deleted in the removal
> operation. As a result, when the removal function tries to free the data
> struct for the OEM I2C, it has issues. This commit addresses the issue
> by checking if the OEM I2C has been initialized; If so, it also
> unregisters the I2C adapter before attempting to free it.
>
> Fixes: 3d5470c97314 ("drm/amd/display/dm: add support for OEM i2c bus")
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks, Geoffrey already fixed this:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/89923fb7ead4fdd37b78dd4=
9962d9bb5892403e6

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 242f98564261..6ce51f81ba44 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3007,7 +3007,10 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_b=
lock)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       kfree(adev->dm.oem_i2c);
> +       if (adev->dm.oem_i2c && adev->dm.oem_i2c->oem) {
> +               i2c_del_adapter(&adev->dm.oem_i2c->base);
> +               kfree(adev->dm.oem_i2c);
> +       }
>
>         amdgpu_dm_hpd_fini(adev);
>
> --
> 2.50.1
>
