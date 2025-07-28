Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F88C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB3110E55B;
	Mon, 28 Jul 2025 17:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZHFP3Vz";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114F110E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:52:02 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-312efc384fcso853914a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753725122; x=1754329922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QILaDp7czOzJIv8c6wbD2AQCRqIMx5tsZ2XTAGjWB4Q=;
 b=BZHFP3VztG5EICZJVINHj8ClQoyCybgXtcuGW9skUwv1zazrTxgidsRmL7gVsG0xhB
 LGq1WzQ8WyfiMIO6/m5DnuYH1eMZXMc92wCmJFFFuoc8NLoGkAjrWaFrnY/RbvjxsnbN
 c9+jUj3POeK8etu87wjV3YYBerx5VdxLxQhZf6VO9TTRE/s07U6T5ero6hnRcsd/plzu
 hwRcnvHXAVDgC6KsN13g6MvZhnEPgaskEIfbn7paeQJhjHMaeJM7lXS7vgCME/GUwdpZ
 qR4ulDZ6/j0mulLW/AHmIjGWvs3+gHA/l8NZMdXUvzAzbmDrHwSh+ODuehio/VRfZ1wv
 uJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753725122; x=1754329922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QILaDp7czOzJIv8c6wbD2AQCRqIMx5tsZ2XTAGjWB4Q=;
 b=jCpDP/EwnUcCViaDGf2o6TemLmYryKI/zQ33yFOQ9uI12/inQZ1ljEWnDC51D7JFxm
 Xr8XpcklnY5u9FQ0l4OwiXIAw22543e47tPagPUbVAh0gzlefkNJik0TWRtxDu3fBRzY
 DNlrO93l+1ko9sQIbcoEybRYGc4K7mFOfC5AfgzCkjTZeEojxkVE30pTXgQzufi6xpby
 3Crawu7p2+B7VzWRjhJ4MUnuHviquw3WGx26uwl/f2C2ete1GmzK9E5jB46XYjjrYY33
 xZhWUH2of/sA1hhFYFM/zreHhRtSphbgv0hjdgndFHNMGvP8hTv+5AZvtfyztIpr9C9H
 kQYA==
X-Gm-Message-State: AOJu0YxlSAhq56hlEDwCbXlt3jZPRa0ubleb/pSCADcoFcFSb7SjJv6u
 3PIsTNNLvATcfA4ZJ/hWgn1jVvVF3TxEwGt28RJcRsBWkwgWtOyMb+kvPBOPhjKd9NZRZGxWPyK
 k+VnPx8JHzkvveORuVI8QxOkXi5xS2h0=
X-Gm-Gg: ASbGncvHYynsw/lvd5xy3gV8LJTC9INiGCdwoshjjYGAgifaCiz8F9hhEE8yVI90quW
 E8CMlDUJymbPba2/JGYqJA5uOddje0jqiUKSDLdyIaL1m8SUaZW6qId4O3VcsRtQ/3wD0A+ZQyO
 WRpkIFaoa3fxp2q+8fyBAiOhiBj/PXJEjo5UD2OIPAIt/JLcgjcEXsDx0yHuuk3vIt4gZ2o9kw+
 qJ2+ooO
X-Google-Smtp-Source: AGHT+IGR+5qrq9RTimtzV/0h9IyyG4vkIt4uDzwf3qegPCf8Rf4uPX2rht5/bKsh8flv5x/bTyOKSVChyDFJK7fez3Q=
X-Received: by 2002:a17:90b:3ec7:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31e778d9e57mr6933810a91.2.1753725122378; Mon, 28 Jul 2025
 10:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250725031222.3015095-1-superm1@kernel.org>
 <20250725031222.3015095-2-superm1@kernel.org>
In-Reply-To: <20250725031222.3015095-2-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:51:50 -0400
X-Gm-Features: Ac12FXwoYnB7H6dR3U8pJ0RU3FuXo-K_at5-WB4rxiHynEk5w2Y_KzXdNfc2XfA
Message-ID: <CADnq5_NF6+u+_E4sUBQnu_27mbybwg8aTFYRdFUVLJC4-E6R5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Restore cached power limit during resume
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 24, 2025 at 11:18=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The power limit will be cached in smu->current_power_limit but
> if the ASIC goes into S3 this value won't be restored.
>
> Restore the value during SMU resume.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index d79a1d94661a5..7537964c3c998 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2175,6 +2175,12 @@ static int smu_resume(struct amdgpu_ip_block *ip_b=
lock)
>
>         adev->pm.dpm_enabled =3D true;
>
> +       if (smu->current_power_limit) {
> +               ret =3D smu_set_power_limit(smu, smu->current_power_limit=
);
> +               if (ret && ret !=3D -EOPNOTSUPP)
> +                       return ret;
> +       }
> +
>         dev_info(adev->dev, "SMU is resumed successfully!\n");
>
>         return 0;
> --
> 2.43.0
>
