Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8211F106ACD2
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 17:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1909510E434;
	Thu, 12 Mar 2026 17:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbxkBpfF";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D7310E434
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 17:45:08 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-56af17ce552so34819e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773337507; cv=none;
 d=google.com; s=arc-20240605;
 b=V+eajU+ruyn/VsMktsDojsQ0e+P/lbD+ByS+2oq1F80X1U3pm6USdlOgwfHA1P9IAD
 j1SjTXjq8Sf2n8NqTfx8zNBZdcH/ld4v97c8FTznRSsVM7c+CnjTSUG1O+lCDNGFWtA5
 Jh2B9n4gStVC7gTn+k6jdgUHocXpmyU0QUgZTCQ0b1mu/fLs+gFmGDd5dMNhuJooWD9V
 qZRWukB2epyxZ0NXCfSCwmcDW1Qkyv00MEAiDcHB4zOmvFLIP6jwoettQSBfrnLCZWKb
 /RGUP1PVMdWXnRFD5GgzfBWwSWLNZ2WEr7r4N3jmF7LU+34Kj82TOUJV8eeL9wrVRYDA
 Q3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jji2EEyi+P1ySeywcN9UiEDlQITzXlZIy6ODwjKagOg=;
 fh=xdeOS2+CrbFJAqae/bVoWmtCJo/4MfI+50VmSDJVowA=;
 b=D5L7LVATAumdcxClCGxFKRUfRZzXwesXNba6x/3GyLffWylOROaAlTaJxUfBTFmt5b
 pAaiSIbD7nZwgJxuZpc1i9AYa3nEYMMVBstyfr4aQXeR/7Bc/CXwkod+hfNY3O3SgtC9
 toSimLnryFzQeNyNDQLnwdBfFJ6cf4SkKiqD4cY3J+KPxpepjNGDMrhQUBlk6RBWPK4Z
 f4S4FEfMH4CT0iu5hw5b/rGjEHxE8tX1xYvvhk8jeJZFoYkXVrm30BR8gKgY2PcbMrb0
 J3hqpBXuKEWQWE671rM+3cPT/6lNut2mq1StlCp3IjjudCT6vD2SGE4pimfHhxN6a2av
 Jwrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773337507; x=1773942307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jji2EEyi+P1ySeywcN9UiEDlQITzXlZIy6ODwjKagOg=;
 b=WbxkBpfFbcO8LI1+gT42T20SnpHVqrTTAGVs7m3towAZsqBjjz4+tH45yQarwYTahc
 l7Joxw6ZngunZoaUOBz5d+NI/3fBM4pjO2Gjx1y3i19Qn9MGlPbgYU0czhZF5gDV+o3h
 6zWe1E+BGOCeGwkz2M3QpwcVeyJZEFYsgw+KZtSPurs7260WGbW1Rmys6UfCE4NY1Gbc
 CV3JiuXFzqjIV2AW7s9z1UTtP+dQrixKmkypUznLyGhuMGAnrYmGhzQ8AE64aZ8cjI4U
 /rN1sOsAKrBYEUZNGz9hoSdV5u2Uwf0KfOD8RzKEJGSq4lUkL/nQrEPeyzwyjK71kgNo
 9mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773337507; x=1773942307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jji2EEyi+P1ySeywcN9UiEDlQITzXlZIy6ODwjKagOg=;
 b=uBYNJlt8lj7q9gQoPc9LQWztPtYvrzghbStD/LrUU6P8i49D14bZDSOsBJW8yZpbwp
 Y2VLoXaDLAzOMMWqCKpkWcFPpSJJPdCWmFtU3t81oz8iptzFU5pg/VLl3qAI8+hGv8G6
 nMWQ8WEPaMGdteHA1C0X2iP9hL9p5Ykg6fmjmZAkMhKa7tIE9m3dQPHGKVNDG9Avj/N0
 2KOdlbfewSeWTqNJq2PCYv2oTKX0VT8QzmcDCkrQYgWZZuh5SzP+jlCwLiWyG75sZDoO
 QNpMXQWDZq6qBQ2WihXSH07K8epyfDuNc5mjI9+acnPFBGJO/2NbN06Y0G2hKRoSLHuz
 w8Kw==
X-Gm-Message-State: AOJu0YzVlqX6wRqQv6F6MD9orAll0s58X613Wa8jchiCbPWaa6jqHCD9
 g5NX70fZE7ySbV7Ri2ZEVHMyAeAJ/E5mcuxtyTa0nXlfL+qmlIkoRwiVZsGaGV9DI0n0rtv1dXp
 TZHZPVfz4cqfP1EMt2NblYnnAZB+Xbx0=
X-Gm-Gg: ATEYQzz2WJRSfhkFeMAfL/1WeaRE4r0M1u7mXuAo9Ljr+LBwUd3q+uj0rK/qq1+pAm1
 Kig7uv4JEx/hAIiChMHLd/deEWix4LrUcqDJ1XK+6wjEEo53WZsGSzeGUWcGF+FCNbpBUIp6d+Q
 J49VbOnniOkPqX9gr+MF1FK6cTWMcFGTJQBXRgzaBBeXuzFDpuedU20M/IRPpjuVv26393FObi0
 AIzE61XgAIp3trBu3UJZ2gEPZ0vUSdIeOrxowZKI/bxsxKe0sB5+fs/7wshnhQqVWPUyvo3psOj
 ax3sFUyg5NE5mVfTvXOdMK0DhIU1XyDTMN2VCswctcPM+FXZlgmxHJ+4N71qH3p8WC0d+w==
X-Received: by 2002:a05:6102:5122:b0:5df:b52f:58ff with SMTP id
 ada2fe7eead31-6020e5c68e2mr70995137.5.1773337507471; Thu, 12 Mar 2026
 10:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2026 13:44:55 -0400
X-Gm-Features: AaiRm50RFrzAHx_shgoXp9tV-02zt-j4WdE1MDnBrv3mwEibuqP4JW_ZWit3hPI
Message-ID: <CADnq5_PXhLYs85cU2FZ6ZYtBBtv1wOmwiJL-rDbYsCFXpTL_cw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

+ Marek,

This was the feedback from Marek the last time this was brought up:

"USHRT_MAX seems too low. Traces for workstation apps create 20-30k
BOs, which is not very far from the limit. RADV doesn't suballocate
BOs. Neither GL nor VK has a ilmit on the number of BOs that can be
created. The hypothetical maximum number of BOs that can be allocated
on a GPU with 32GB of addressable memory is 8 million."

Does 128K sound more reasonable?

Alex
On Thu, Mar 12, 2026 at 6:13=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Userspace can pass an arbitrary number of BO list entries via the
> bo_number field. Although the previous multiplication overflow check
> prevents out-of-bounds allocation, a large number of entries could still
> cause excessive memory allocation (up to potentially gigabytes) and
> unnecessarily long list processing times.
>
> Introduce a hard limit of 128k entries per BO list, which is more than
> sufficient for any realistic use case (e.g., a single list containing all
> buffers in a large scene). This prevents memory exhaustion attacks and
> ensures predictable performance.
>
> Return -EINVAL if the requested entry count exceeds the limit
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.c
> index 87ec46c56a6e..3270ea50bdc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -36,6 +36,7 @@
>
>  #define AMDGPU_BO_LIST_MAX_PRIORITY    32u
>  #define AMDGPU_BO_LIST_NUM_BUCKETS     (AMDGPU_BO_LIST_MAX_PRIORITY + 1)
> +#define AMDGPU_BO_LIST_MAX_ENTRIES     (128 * 1024)
>
>  static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>  {
> @@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdg=
pu_bo_list_in *in,
>         const uint32_t bo_number =3D in->bo_number;
>         struct drm_amdgpu_bo_list_entry *info;
>
> +       if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
> +               return -EINVAL;
> +
>         /* copy the handle array from userspace to a kernel buffer */
>         if (likely(info_size =3D=3D bo_info_size)) {
>                 info =3D vmemdup_array_user(uptr, bo_number, info_size);
> --
> 2.49.0
>
