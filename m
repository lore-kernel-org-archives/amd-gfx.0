Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17874C369A9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52DC10EBBB;
	Fri, 11 Apr 2025 13:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NnlTj+Ey";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A711B10EBBB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:15:09 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-871ac66dcb6so116487241.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744377308; x=1744982108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ww6fCCV0vui07Q9LUIakrp/4JSi77rsJHq4qQriVxGQ=;
 b=NnlTj+Ey5TejcNmrKl+d70Wyq6/J4BqsKitwGsMZe2AcjApm6ogIF9AK1DT+Q1+dT0
 iN/TXPc+UJ/hjf9DeQJVzVQx/15P0FQgpMWwnveQ0dj4FXtVCYkJvm37FdpJcioSt0VB
 BCQx0A3vFrtS6dfsTNuKVIImu28GhMEC5xfKmuP5m88zQeIIWM9W3BUqoNBbPxL5Pd4r
 5/LNWnnPlWlRtu03CnXe4Bo6q6mAqrnJDG+1DVhoMVTqyp6X/+aav9dm0zbMHWlZBtTY
 3BeNhIrku/3V3rFIFdZIJ8/wNwpx8vzk5dUfwWVbR20uF8RVO8E/G+/koIOcrDnOe2NQ
 Qvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744377308; x=1744982108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ww6fCCV0vui07Q9LUIakrp/4JSi77rsJHq4qQriVxGQ=;
 b=skjJJj42YDccf2Z9da9jNs+dsib+On7/ouqEtqEhAmbt67FokaSIoLuc7RTls46wRx
 C3kps6D68uYfTOFooP4AuLDKGLwMSQpk3CytRFAvcYk8Am48QQskf25r3obmF/u1Ipet
 vOqTGQzxokhoP98vCgyVyUG7uhzgptRSwerli8aTMvbjRvfhVXO3E7T+OpOP4jUuilvH
 hid1klmrLgoQm1yDIN1GPrs6R7ssOLm6unuEIkspxqxvYyO/JQGi54L8nxcC5lAyCzph
 +/CwzVHrldrDzOqd3MVO5R4fWZucnjBZmeG/NhBvz9ZcpDrbBJgPA1XEGmaOkzjCo62o
 EZNw==
X-Gm-Message-State: AOJu0YzGCYWcKFuHDgyKoxKwAo2QDwK38r+j2+ur7ojNFRbeXYQNfhQx
 D7NGcDsjLtzljMdgTE8hOWKhEMqJ84434Vhu3THadyepTXLRQCyQ6B2Qsaq+YaBS4tTHILwK7By
 6Sc5KH5GlHOPB/YR1q7qdEzCCDWs=
X-Gm-Gg: ASbGncvJNifxE2e66uu03g7X8hhDho4KEBQqDcs4tUX8ZhMOk778rnuijCyAnf1/vhD
 d/kWeb7CJH9sjt76cjEPdyDtx6Bos+D4122AkK7AFZ6frTSmVmNcbZsu6MaF9Vw4rPz74tSAxLt
 VJqfXcVFCZp0anHIADV1hRig==
X-Google-Smtp-Source: AGHT+IFA5CLHLTn+Trw6QE+XiCYo1lA2FjatY3KsjhyS6lTh/rMy1cQAZ1Sm2kV0PY+PcP9EUvWmYbr+zpJ8dsR8wdo=
X-Received: by 2002:a05:6122:1d92:b0:520:53c4:5718 with SMTP id
 71dfb90a1353d-527f73b396fmr263071e0c.3.1744377308402; Fri, 11 Apr 2025
 06:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082227.3228289-1-jesse.zhang@amd.com>
In-Reply-To: <20250411082227.3228289-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 09:14:56 -0400
X-Gm-Features: ATxdqUFrn6alhuqRUzL2soGDcIxwwfg2mrEZ809dgrNtHl0XY769diAWvcwkXvQ
Message-ID: <CADnq5_P-LUWZL8wQB8UgSYdvx7AsiFM_qEUGzr0YCDpHbo_tJA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix out of bounds warning in
 amdgpu_hw_ip_info
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Apr 11, 2025 at 4:23=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> Fix an array index out of bounds warning in the DMA IP case of
> amdgpu_hw_ip_info() where it was incorrectly checking
> adev->gfx.gfx_ring[i].no_user_submission instead of
> adev->sdma.instance[i].ring.no_user_submission.
>
> The mismatch caused UBSAN to report an array bounds violation since
> it was accessing the GFX ring array with SDMA instance indices.
>
> Fix the commit: a245daf3d7a143fb2df(drm/amdgpu: cleanup HW_IP query).

Fixes: 4310acd4464b ("drm/amdgpu: add ring flag for no user submissions")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 0ba3ef1e4a06..6a42dea775b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 type =3D AMD_IP_BLOCK_TYPE_SDMA;
>                 for (i =3D 0; i < adev->sdma.num_instances; i++)
>                         if (adev->sdma.instance[i].ring.sched.ready &&
> -                           !adev->gfx.gfx_ring[i].no_user_submission)
> +                           !adev->sdma.instance[i].ring.no_user_submissi=
on)
>                                 ++num_rings;
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
> --
> 2.25.1
>
