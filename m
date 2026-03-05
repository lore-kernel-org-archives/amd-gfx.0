Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A5F3D31C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 16:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A5210EC21;
	Thu,  5 Mar 2026 16:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDv1cArV";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B72B10EC21
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 16:08:56 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2be22d699c9so228768eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 08:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772726935; cv=none;
 d=google.com; s=arc-20240605;
 b=b8uAKymzRTjlQaL/KYEYmwlSGpE0htDExrj6GMvyuFZduCb283DO+VqdSYqfFjUQn3
 sITDMmAXX5BbYzUaVFi6O0sZdmuzKrNqV8bIpdGg31g6GMUPFOjqAMxGfZFnNDbBNIYE
 OYEeDhLbZay+yxMkMvG70vatmTHivdCu7MzDb1utpvVcsyPiIdh7n57s3hBAfDsBua3U
 Ump9e8KxxyDE6NDLDdnHOcQHfnLQ0+bcyvSup3hsegUYzDq5orHNsWH5cxwisOVu1abc
 GP0SXx311U1jBSBBcanZl87+mJk2M3aL06ZfMxv1CJcruWrNIlIx8XpBpAjR1sr3oaKP
 Y+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dK/J8ibJ9vqPLIn+YDQpyW9uGinxxdR9Usb7tnZ3Nzo=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=exdc2MBa/GiGspY5menN9iJ4LgwPjiyF84cQoiT6zNEp8VGyNVbGtfGBS2m3u6dP11
 8CreQqV4UDRsXIjyBXzUZKIcmbYOwu1QWTwb+LMqlWdx6VImxtRV3UItCh7w9U7+eUYQ
 IFaDRgC/sDiXOWwXWyL7FQRbd0xYZnEYhJ9Xv2g4ZLUqcnPxfXxHBTc1/V+r/46EX2Iw
 L65vyMlD8zkOnx1Cbd51Ee8mrBFMwBgw7kfbQyZc0gHjGexTFNEkYVqIamMNCvSBSXsc
 JCBOVYlFlBjQmllRU+snLACgpVflgAjFsKwQY8zeh++DDFN9sNMEAohJVhz7Rh4hn6Ab
 16Xw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772726935; x=1773331735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dK/J8ibJ9vqPLIn+YDQpyW9uGinxxdR9Usb7tnZ3Nzo=;
 b=VDv1cArV76QBN3ZZyVg0K9aoAY0JS2TcYfL/W3WVR6PVpurkdIlAVYwMigk4T6lDlE
 OtHegT1x4Da7zG7YHxUZNLE4HOV43Cy9RUyYdOaRMSDOxexKk6If5p3vm3R3dDjCkcuf
 LuReeMPvLX7l2la1z9kp4v9aQaLVZ93Ftkqu/xr6hWjXRdVz0wZc7dtPNTV6nwUslEHD
 pIjE7yaAH0Fk3py6aduWlPeg/1Vd6UwinSIewesCZsMj0xCw5pM3cMKBax1qXIZSIGC3
 qB2h/XEWgHObZLTenLc3t6cyzCY0Fy0joov9kp9raM0oJaUF3nyqTfva00X2QqSYixxC
 0EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726935; x=1773331735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dK/J8ibJ9vqPLIn+YDQpyW9uGinxxdR9Usb7tnZ3Nzo=;
 b=XZpAmiRW2QRg3TWVv+nvlN41cganwvaMPKl50uvNzZ4LQ9vGJ/GDsgkq3xEMuoTauO
 Zyc31lhFKLvp8OyDZmlkRvewCce3Ai0+4vLRGWNZdizyYLlYlBY0Q0yqwjobdrcThZbX
 UUCmifCMPgtT9cdpdSWbXTQusweYNfH6P3Hao4ctSDyNKYOIKfLyrJ0Uq16if+l8FybJ
 o8IKUTJvD3nBQxAJMT0asHhTlZDbeof8tAOdreapJEV0tavkm2GMXxrS0RLMZKQVedtJ
 GMBlPjyopp5HvRaU6g6EblsUjVQJZVqBHg1eKH+6BrNaTlPd5PZDIyhKF3SEQ9iH8YgG
 uq6w==
X-Gm-Message-State: AOJu0YxmSjDoJoc+9hVJBcbIkBkplxR7dHAkhjpK8P9hOlraKw/+Og48
 grGynZ/BP1//nSDwmVOGezjA5+jqf/xdRfUWIVgpRZsIoO2/7jPJw7cyYWcvRqAHm+/9JZ4AWhu
 tPcI80wGhzC4cSgSLhbCibfVt4Y4i/GM=
X-Gm-Gg: ATEYQzy3F9dbOls1N8njbbboWTUVbcgz7UODUnmm3TsSEI732UUCvxJyjGHM3lZWT+F
 cy3NsMJYLafl5FB0KoVD5uizqlcEbSwO1gwTyEvHNnr3GqmcW7VA04cU7LqFHhl/eMeEKsKLpm5
 frtmMIdFtICZNRf2xvRBffhLVwdBQY8Ozk80RKs/poXfHDn0zpvqnzBM8BgItLSItI98shIyHET
 67NRas0LPNW0UUxwHSP9Jh3fpSWtgfrSoPC49GY4FlFcUXXLBX00ZONaCcVg1YGC+fKt7sOoR07
 wfo6qqKD7FEIGD9/64+sFQvnz481ZSTlX4XVIx6M+oi2KvjIqSmyZ5tUFuo3n+9RHP0aOA==
X-Received: by 2002:a05:7022:62a8:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-128b70c81bfmr1445898c88.6.1772726935168; Thu, 05 Mar 2026
 08:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20260305150611.1166241-1-mario.limonciello@amd.com>
In-Reply-To: <20260305150611.1166241-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2026 11:08:44 -0500
X-Gm-Features: AaiRm509hnQWQBJqhfYRLn7YB3GKobv9zlMr3b_4b107GcrIbc4FKzNxdU2uv9w
Message-ID: <CADnq5_PktSmCEVwMk8p531+h0M1DPaK2mSHOPbes5tmY+MHk=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix a few more NULL pointer dereference in
 device cleanup
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Mar 5, 2026 at 10:14=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> I found a few more paths that cleanup fails due to a NULL version pointer
> on unsupported hardware.
>
> Add NULL checks as applicable.
>
> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powerg=
ated state in some paths")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 258391ddee7c9..bc6f714e8763a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3508,6 +3508,8 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
>         int i, r;
>
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +               if (!adev->ip_blocks[i].version)
> +                       continue;
>                 if (!adev->ip_blocks[i].version->funcs->early_fini)
>                         continue;
>
> @@ -3585,6 +3587,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce *adev)
>                 if (!adev->ip_blocks[i].status.sw)
>                         continue;
>
> +               if (!adev->ip_blocks[i].version)
> +                       continue;
>                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_GMC) {
>                         amdgpu_ucode_free_bo(adev);
>                         amdgpu_free_static_csa(&adev->virt.csa_obj);
> @@ -3611,6 +3615,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce *adev)
>         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
>                 if (!adev->ip_blocks[i].status.late_initialized)
>                         continue;
> +               if (!adev->ip_blocks[i].version)
> +                       continue;
>                 if (adev->ip_blocks[i].version->funcs->late_fini)
>                         adev->ip_blocks[i].version->funcs->late_fini(&ade=
v->ip_blocks[i]);
>                 adev->ip_blocks[i].status.late_initialized =3D false;
> --
> 2.53.0
>
