Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EC8C001DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B93910E082;
	Wed, 26 Jul 2023 18:29:39 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFF610E082
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:29:38 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1bb98474b8cso144973fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396177; x=1691000977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc3oHflsf+w4HsGIT7nlh5gwtqQ0j+vZyaFkBuqK94o=;
 b=Tt/RToipcSnKFxNL/2DibbcjJgx00wxForsOLTUITAUad+Rj8e3fG++rEGzhmzobV1
 rarg8Vst8oeWDr2ZRNY2i/yLis8n6jAUP8cwFKnTdr8molPEqYTuCkyCBoKYG2kg2u2b
 vy2FLPBo2xz07tfNmW3DJufX7B2YFMHji0fgWvo+Fj9SsxHdIXSS7awkZZKfdocT+iuH
 ZPq/LNmZHNLafU8zdhdZt1CN7hDFAt6HrnHaNdTrhBxyfspNuCyltkhXybjkVMk8a79i
 fBY3EGkbgvK2HTluqaIT/Fs+DoJaI+PPtH9tznd9nqVNSte6w8GuNWWWdEqAM6LeumU0
 D7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396177; x=1691000977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc3oHflsf+w4HsGIT7nlh5gwtqQ0j+vZyaFkBuqK94o=;
 b=JNrxKN1Kfb9NSJQFdW+nARGPnhTeReUHXrHTvITotHywTP7SNg6kGm1zm+ly5QPYlg
 69d2KQ6EBlWJ/cdcrIsCe+IobGtWfPzbw3hYdGkv6hD4J/ULkptpN55HFvwvwABw1XmA
 9FxnZGRNiVVMrs5HI2Z/3ZJnLeiqfU9I29bCWj9rIYZlmNlWw188lrd5XX6TP532/yn7
 p/KlYXdkIu1HTIbGoOl+xEmdJ/DVcxGPTSICyExUUhDcYdyh5qh7e7R1Wz6Kg1j3AtOS
 tkKMUj96+8xicG7eDm66SP4JadEz2XQed1XMlhhzuYreAGR0FUlrBOnCKv9r3YUcNNf2
 X75g==
X-Gm-Message-State: ABy/qLYp54OufWvw+JXbwFrnSM9a2Y/p/hwAr4McKaFgl19nG/F8b953
 iAdBdfhrSKtsv/FA9T8wjokeKZ5zW+WY4y2ew7pKHNBAxmc=
X-Google-Smtp-Source: APBJJlEd/AuMZu7UMmmfoRNA9Kzp1APQ5c8wBQ3LQrp6yrvBYsotPbrujDxvi3MdILtuW/f2YaB2G5WMeM24Rtg/Dg0=
X-Received: by 2002:a05:6871:295:b0:1bb:6485:7988 with SMTP id
 i21-20020a056871029500b001bb64857988mr405751oae.35.1690396177517; Wed, 26 Jul
 2023 11:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153851.2219088-1-Praful.Swarnakar@amd.com>
In-Reply-To: <20230726153851.2219088-1-Praful.Swarnakar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:29:26 -0400
Message-ID: <CADnq5_PcNWfRF=MsvduFFT9-xmmOr2GJNkCE-rDu3A-o_3_7vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix style issues in amdgpu_debugfs.c
To: Praful Swarnakar <Praful.Swarnakar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 26, 2023 at 11:45=E2=80=AFAM Praful Swarnakar
<Praful.Swarnakar@amd.com> wrote:
>
> Fixes the following to align to linux coding style:
>
> WARNING: Missing a blank line after declarations
> WARNING: sizeof *rd should be sizeof(*rd)
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 00ab0b3c8277..a4faea4fa0b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -375,7 +375,7 @@ static int amdgpu_debugfs_gprwave_open(struct inode *=
inode, struct file *file)
>  {
>         struct amdgpu_debugfs_gprwave_data *rd;
>
> -       rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
> +       rd =3D kzalloc(sizeof(*rd), GFP_KERNEL);
>         if (!rd)
>                 return -ENOMEM;
>         rd->adev =3D file_inode(file)->i_private;
> @@ -388,6 +388,7 @@ static int amdgpu_debugfs_gprwave_open(struct inode *=
inode, struct file *file)
>  static int amdgpu_debugfs_gprwave_release(struct inode *inode, struct fi=
le *file)
>  {
>         struct amdgpu_debugfs_gprwave_data *rd =3D file->private_data;
> +
>         mutex_destroy(&rd->lock);
>         kfree(file->private_data);
>         return 0;
> --
> 2.25.1
>
