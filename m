Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32DD33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 14:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9CC10E4CD;
	Mon, 28 Oct 2024 14:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K+b60hZ/";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E5510E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 14:43:02 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36d5so123745b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730126582; x=1730731382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpCi3DYH7I5RRlI5UCETI3eZm6LyO3QQBw2bC1QCznE=;
 b=K+b60hZ/IU73SkCyMHqOTPYBSZy74QkbCZutpPqwfDjF36dWUhhvmc3xYz6TDEJJU6
 dk3QCsw4ZE72II5AfSULyuzPq4jQM9dfb6fnphIinQ0NmMnB4t2qvKgdyuTj7i4yjuwl
 K8nYWmUnXys8RX43A4G+dDJBhmjZCRQGWLzp/OCKFDlpkn29n8kL/T8jLUCkoNbMQnMP
 icqyRfI8Mu35UmWvANF5MxrZQ7WEipy+I68xqefmuKFmIrekJtlic8HG3sfM+220sHq4
 C3ajp6RUvQTYgOGKUn+GLSYENY8RFt7/Sc5wlVJWZ2y1A14qjxSs0muUpDp6FKO4Z2Gb
 kKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730126582; x=1730731382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpCi3DYH7I5RRlI5UCETI3eZm6LyO3QQBw2bC1QCznE=;
 b=EGKp5o82KYszRqnsdFQPhcy3HQ+RZ853/NhKEcqSiaIn/8cXteYjS/+MuArI3399iJ
 /MaTwV07GuT00yOCJhoBqoW6wv88t8ZfgCLGFmMitlBCr6eSvCxXrmQLe905bzmjLjjG
 3BnsQTX6C/ir8VPPca6i1GoF53hE5p295oEW1zsrV4K3N5Q0jlE/u9uUeY9HAmcoS5+a
 Td/LPrOWXNYUidGU2VRnZqkt5BV/ddi7wkGJaCYpHwYvFlV8gClbZECDo+rwE+vP7s2F
 +ATxnIS8alr8JqUdh5TuSlqWb/q8dg3qbmPzZg3yVYY4O+NUA4lMLIQs4PIE4v1HRBB8
 +cXQ==
X-Gm-Message-State: AOJu0YzU/3VHgtUJZ9VS8aiWiFHkN/aQgfqyUceuME4z4GrKMAPMV24e
 EV/SkfbwF0akfwDL9UHQQjF7BEqaWDwhEXIiywZRHfUu04wB2vNeJ7EvNnm99BCOyUMMDX4fgYe
 8NsVXh4tlQ15GHR2021dachkSLtNqpQ==
X-Google-Smtp-Source: AGHT+IGzGAHievt/oNtm5O97AQ9MYIGzyrXvaND6R5/Z10todZnMZKtiy7r+KTEBfO6MRCmzL/zxei7ULj9aDs0hnrg=
X-Received: by 2002:a05:6a00:218f:b0:71e:5580:f461 with SMTP id
 d2e1a72fcca58-72062a67d17mr5179077b3a.0.1730126582338; Mon, 28 Oct 2024
 07:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241023210342.685808-1-alexander.deucher@amd.com>
In-Reply-To: <20241023210342.685808-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 10:42:50 -0400
Message-ID: <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping on this series?

Alex

On Wed, Oct 23, 2024 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Regular users shouldn't have read access.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 6e6092916d4e..e44a44405266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1654,7 +1654,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *=
adev)
>
>         for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>                 ent =3D debugfs_create_file(debugfs_regs_names[i],
> -                                         S_IFREG | 0444, root,
> +                                         S_IFREG | 0400, root,
>                                           adev, debugfs_regs[i]);
>                 if (!i && !IS_ERR_OR_NULL(ent))
>                         i_size_write(ent->d_inode, adev->rmmio_size);
> --
> 2.46.2
>
