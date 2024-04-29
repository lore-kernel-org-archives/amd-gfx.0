Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BA8C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA98810E18E;
	Mon, 29 Apr 2024 13:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6xI3cXd";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F7410E188
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:53:41 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ae913878b0so3350057a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714398821; x=1715003621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSeK+G4L1XE19Q+dKJYNP67TM76ppkNc+WgAV0QY98U=;
 b=b6xI3cXdmUqKcfyOCQqWNeRZbVlNEIVK264+JngxeEp8LmQkoMsWN7Mt7AAOtt5pEg
 P3Fl4iQiZz1YzzGbq+tlxwjifaQc1aa04QFDYyIhWOwSrm61fkaC8FXwsU38gcoK0f/t
 keEu+aLf1zTm5yvnz4wdPsQ85akLhcYPlFRtCDxvzJdRHGrTGhpeFi2kQequwAbBq51y
 SOUfM0YBP7Cb2I3stO/yWQBRvuRmOMQdaQ5DLeWhaa/u40+ovyMCWWUcNSdCzo2Ht+xO
 FfoeXjSxhFT0pNVYJiqaS7LoVBfey3vqrUAkJGvor8W+oNZcAyAhMFoI3Mr1s95U+HgP
 FyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714398821; x=1715003621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSeK+G4L1XE19Q+dKJYNP67TM76ppkNc+WgAV0QY98U=;
 b=GgEzV2WEi//i7bg9rpMQnhXVirLzzYdGZEWzJgZAbPB3EhUBDDWeI/pmZr00XKj1yf
 1JcvHNPtfyhB+DyvUd0vleTiqSixFMYdJnSO7UC6qp8blAz1X6OJcLLRlc6Yn3sPP7KG
 RMBbRbExB5HUIi69ikQXepAuKsvfXAaIcIWrnW3MsI9s5MGcri0Co0LjgonQJkIjOsFh
 71co2BSDF5dOcPqJoaL3q7v0o3SyOzHg7QiryU625syl7r83R9Id5l4edjnV+dudABlI
 vZlbiRhUPAzfqjVFCRJcA2i/UaVAeosQQceKYqxXFwCNVp/swJN0xnWkPosJOc1Pzb0+
 vCVA==
X-Gm-Message-State: AOJu0YxzUTdTvTq+6utfQo3ktyVm6vYBFr1Za9mAjF9K6KsxKs4igBae
 7hsxcBo7MXgPZ5GEnRyGJ25BhAVCHXxokFOda5srGMBSGl6eDg00OQQkaqQUi0DkG1xBvlF8Otq
 CT8w9Hm9vB0jO6pQI6fPkRPovjsBGtQ==
X-Google-Smtp-Source: AGHT+IES9BorEW5RJoTW1gpD9TZGqRA8uOCN/v3ykR+MRLeNfV7Qoyq+FYOGfh+tv3wcXkq58PEMeK3PytMojSCND+8=
X-Received: by 2002:a17:90a:5c86:b0:2a5:d313:4d3f with SMTP id
 r6-20020a17090a5c8600b002a5d3134d3fmr6827273pji.34.1714398820921; Mon, 29 Apr
 2024 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240426093749.21707-1-Jun.Ma2@amd.com>
In-Reply-To: <20240426093749.21707-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Apr 2024 09:53:29 -0400
Message-ID: <CADnq5_M-0+VduYjDSgmLxJZd7yA-Q=OogzzMNgN7cViZV66E3Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix the uninitialized variable warning
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Apr 26, 2024 at 5:57=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Check the user input and phy_id value range to fix
> "Using uninitialized value phy_id"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 8ed0e073656f..41ebe690eeff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(st=
ruct file *f, const char __u
>                 mutex_unlock(&psp->securedisplay_context.mutex);
>                 break;
>         case 2:
> +               if (size < 3 || phy_id >=3D TA_SECUREDISPLAY_MAX_PHY) {
> +                       dev_err(adev->dev, "Invalid input: %s\n", str);
> +                       return -EINVAL;
> +               }
>                 mutex_lock(&psp->securedisplay_context.mutex);
>                 psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                         TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
> --
> 2.34.1
>
