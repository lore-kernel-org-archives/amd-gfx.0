Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A713DC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C6310E185;
	Thu, 23 May 2024 18:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSjG9dJk";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E50D10E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:44:29 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-681907af4e7so67196a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716489868; x=1717094668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p8WWoTxiIqYyuOpPW6UtUt6OiF88Jvf8SCYo0d7hPo=;
 b=QSjG9dJkPCWbrbdB0/DqpzlDK9du6arY3TzPRWWoSMmpAL8TE0zy3gZ6AWBUDXJdYG
 WSbTg92dV3a4jLnY8GW/qtMONyoI3zgfKEglM91IpH68U4uEvMgp0TTcK+coraWBlh8y
 JE2uHSvALb3pQBLsBD3b+r2m5Kdrw4+Wd4mxaPM3GnPQx90zIAit+IEmoWgNoVkqgu+M
 Nb0COG6dY4ESQ+18qJsas4G29izbGtDzwni05Dqbddn/64N01xz059/ZHfgEqgcLDer6
 wlw7NTDxgChwr54uwU+l5eCtGvFZ6Fa+tOfRgcTMzUKMbMlM/mncgrzlIYEJ09IPbWCQ
 BRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716489868; x=1717094668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+p8WWoTxiIqYyuOpPW6UtUt6OiF88Jvf8SCYo0d7hPo=;
 b=W1hFTA9FW52jehH76gO/VrdC2nFkC1fNwrXTZX7mn4PwVq6d/PCTorPkw/8AVL6gwn
 q+fhO/d+ns93Sa/541XJvVXSaf640Or9DviG2Lyob1meLlqftpy7lSMag+JAhdX7pklo
 CUaLinwie8IPPx52xq3T5w+xrebevjHSSDnnzrNronFw7ktWXosaD0rg3pkv4lgCbjwY
 qV9Xb4rgWtlBiU5r448f99Pytq7bO9MhjYbANOBjQAT0unjRf11GcOeI9ThGdXL44SwI
 xcUNurLU6/hp+hnzdMgtWBbdPwpYv8hie3E4iJP4/kOhEGn6cHc4+7kQ7AnbJUoc/NxK
 6DZw==
X-Gm-Message-State: AOJu0YwDIfwaxSorO7uSk4cde3tVyDdcke/+kqkg1doNwdOE08m7RRRp
 VG6rfekYoDA8dwQseFXygf1PgZRbx8yHbL97qg2of1hWMA461qsw8CUORVx6f+jVizlWCflLxwv
 B10/9gsb+GwLeFIuMBIOMdmSGvg8=
X-Google-Smtp-Source: AGHT+IFB35nZhOpMq6KGz7Rp3Y7f7YMTW2oy0IbScmHrcHSlpSr0JFnqyD9roiOnFAtsuhf3ob9MseVLm9hFpgtTT88=
X-Received: by 2002:a17:90a:c7c3:b0:2be:9549:799e with SMTP id
 98e67ed59e1d1-2bf5e56939fmr9617a91.9.1716489868370; Thu, 23 May 2024 11:44:28
 -0700 (PDT)
MIME-Version: 1.0
References: <20240520184538.2711265-1-alexander.deucher@amd.com>
In-Reply-To: <20240520184538.2711265-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:44:16 -0400
Message-ID: <CADnq5_PJu4r2yyK5RgUqL9n0W=UnGdmpjj91H_mwGjN+w3zcaA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: fix gfx_target_version for certain
 11.0.3 devices"
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Feifei Xu <feifei.xu@amd.com>
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

Ping?

On Mon, May 20, 2024 at 2:52=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This reverts commit 28ebbb4981cb1fad12e0b1227dbecc88810b1ee8.
>
> Revert this commit as apparently the LLVM code to take advantage of
> this never landed.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Feifei Xu <feifei.xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 6b15e55811b69..fba9b9a258a50 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -426,15 +426,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *=
adev, bool vf)
>                         f2g =3D &gfx_v11_kfd2kgd;
>                         break;
>                 case IP_VERSION(11, 0, 3):
> -                       if ((adev->pdev->device =3D=3D 0x7460 &&
> -                            adev->pdev->revision =3D=3D 0x00) ||
> -                           (adev->pdev->device =3D=3D 0x7461 &&
> -                            adev->pdev->revision =3D=3D 0x00))
> -                               /* Note: Compiler version is 11.0.5 while=
 HW version is 11.0.3 */
> -                               gfx_target_version =3D 110005;
> -                       else
> -                               /* Note: Compiler version is 11.0.1 while=
 HW version is 11.0.3 */
> -                               gfx_target_version =3D 110001;
> +                       /* Note: Compiler version is 11.0.1 while HW vers=
ion is 11.0.3 */
> +                       gfx_target_version =3D 110001;
>                         f2g =3D &gfx_v11_kfd2kgd;
>                         break;
>                 case IP_VERSION(11, 5, 0):
> --
> 2.45.1
>
