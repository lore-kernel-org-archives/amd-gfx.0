Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF655C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 20:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F8110E750;
	Thu, 25 May 2023 20:08:30 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1FA10E029;
 Thu, 25 May 2023 20:08:28 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-38ea3f8e413so43997b6e.2; 
 Thu, 25 May 2023 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685045307; x=1687637307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5bw5FEUQf9zpYJ2CuVxnYu5kgESmPOsJcyv6u9Z4KI=;
 b=b9RPGwzD+6sZyUhZgx5VS9Fs++v/NsvzvmOXZvbQBUyXr3pAubOp/zop/bCDmZ4njZ
 eZnIrbw7j6vRZPPLyqCjISOKra4oY2FOgNF1Ou8Hv2WuRge3Erner1TCOzFyHNKgN8Dj
 XjFJr4XbbpXQFDMX2rlnYEHykTu2RbCt++25GMuJRhjiiS5Xq2bQDYxQ7vtRwo1Wvg9j
 jwcsk74AtPc2ajibQLEBSfsDnr9b5ivzAemgRBPry/irwAbWL1z40vLc4RJmmFWXkPgA
 1GqT6Z4EMv3CHOxV2rdsA/ibPJAYw5dirLekgY/nAFWSn+YwEmvYJNJre1gSTJER0Hne
 DQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685045307; x=1687637307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5bw5FEUQf9zpYJ2CuVxnYu5kgESmPOsJcyv6u9Z4KI=;
 b=Wz2r2bnQ1wD4ZMxljDCgVhEx7a2JnuedpkWnBn5SEF2SGB+IYvPY9ms8GOhPm2Mne+
 Y3u+6NpFiJtoZG2XlzNA5Z0dMU04wqsi/QlwL9Y4Mz1sb2tQJ/7b8nSsinksyq3+7dU4
 RtGb6xUlROrkxCdht+AEx2SZbYq0DMT58petXx1gY/6bxsBK1c3ZiSuWQbW4HmfuKCHc
 ZYfUXlhFCF4Kwau1nyKjI4BtZmdSI/Q6IVQQsQASWOrII9M+kxs1cuL7UP0HkGLIfRLW
 ld9xGYr0BUdT1c3VtonTwTW/P71O4A7mKm+01Ymb5Zuvc49BguDDB/MtXndkrfaBLy4R
 hYgg==
X-Gm-Message-State: AC+VfDzuKs8XqvMWw+JuME0FUGVBmnigROVSSp3xq0n907dLpABGSJxi
 TbWlK75DIPrYVmIIwz0+H0Yxf5i1XvgyzIon7Dg=
X-Google-Smtp-Source: ACHHUZ6KgN36WvvpoxW6luV8USGj7stU14tUHlrBarEMrI7gwIem5gyo6OO6qBJ+uFNZLg1aXwUR7ZpqotXD39Ckt74=
X-Received: by 2002:aca:d909:0:b0:398:5b90:710b with SMTP id
 q9-20020acad909000000b003985b90710bmr422149oig.13.1685045307206; Thu, 25 May
 2023 13:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <bd6a37e2-438d-4292-81e8-5a8f0b10d647@kili.mountain>
In-Reply-To: <bd6a37e2-438d-4292-81e8-5a8f0b10d647@kili.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 16:08:14 -0400
Message-ID: <CADnq5_PD6wj_c+zXDDkN2HWvb+h9=gXk-06o5-h6dwJLPU1jNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix up locking etc in
 amdgpu_debugfs_gprwave_ioctl()
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
Cc: Tom St Denis <tom.stdenis@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Sebin Sebastian <mailmesebin00@gmail.com>, Victor Zhao <Victor.Zhao@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Lijo Lazar <lijo.lazar@amd.com>, Le Ma <le.ma@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, May 25, 2023 at 4:05=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> There are two bugs here.
> 1) Drop the lock if copy_from_user() fails.
> 2) If the copy fails then the correct error code is -EFAULT instead of
>    -EINVAL.
>
> I also broke up the long line and changed "sizeof rd->id" to
> "sizeof(rd->id)".
>
> Fixes: 164fb2940933 ("drm/amd/amdgpu: Update debugfs for XCC support (v3)=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index c657bed350ac..56e89e76ff17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -478,15 +478,16 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct f=
ile *f, char __user *buf, siz
>  static long amdgpu_debugfs_gprwave_ioctl(struct file *f, unsigned int cm=
d, unsigned long data)
>  {
>         struct amdgpu_debugfs_gprwave_data *rd =3D f->private_data;
> -       int r;
> +       int r =3D 0;
>
>         mutex_lock(&rd->lock);
>
>         switch (cmd) {
>         case AMDGPU_DEBUGFS_GPRWAVE_IOC_SET_STATE:
> -               r =3D copy_from_user(&rd->id, (struct amdgpu_debugfs_gprw=
ave_iocdata *)data, sizeof rd->id);
> -               if (r)
> -                       return r ? -EINVAL : 0;
> +               if (copy_from_user(&rd->id,
> +                                  (struct amdgpu_debugfs_gprwave_iocdata=
 *)data,
> +                                  sizeof(rd->id)))
> +                       r =3D -EFAULT;
>                 goto done;
>         default:
>                 r =3D -EINVAL;
> --
> 2.39.2
>
