Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4259E105F7A8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 13:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A838410E04B;
	Fri, 13 Mar 2026 13:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxvOUzxq";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9345610E06C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:35:57 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12734af2cdcso101453c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773408957; cv=none;
 d=google.com; s=arc-20240605;
 b=NkbySJz0ht0Z0omS2J9zXYyuJghjDhga6071UqRTjYKvMh34NqtG/d4//ijosuVGJD
 JKMcX/X97/RcnFfp84iTeWQWxGoBQB9LXsykY9Tv6hkGYa5UkNV3fk9NBZsXgX9jUUkC
 5b+3JT8e4shAsHKbpSEWIT21cFej12b7gkcYr35Qtta5E/XVxyvqk4FJQHfAxiLzg4ls
 Z3kR5tgUZlZNwTIhasX9/gVeQHaznvhCXnY5E9t2OsTZQua5iT7l+SnyHsLvx8xpK01Q
 IdlKfehgqzHSKU1Be32c8ovMrXJ7zG2w84qb2MPnL5q8m2gF0mXWuKhWemRAQ1YcQNWv
 FOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 fh=T8YHLpiRcsektQknXKvT7DxHlNrmpmaX7yntWTVgXfc=;
 b=K7ltKQLtN1HlzE7ovIEb9R0udNT7US8V8w5OUdSwfEMfeXFe6ojv/jhOYDtmmuU/T+
 3dAMhTgiJFuHiW5mGkzVU8nG9uCiQZdIcWBNkrDsKPGd9a8P46cHcWyW0gP9mTXUNWMj
 fLe76WOxRN7umpDxdJv5kM9JQ4zEFeJSR3+wOwyfNlF1sDGCr1QilkPThZNaIfyfcwXR
 SGZ6wtDxp+F7Y22cSgrJKlTzXKMHY4+t9Z95n9AjBLMhSxmB9UbVf69SPELCoDhQoq0b
 Qd5B76VLOrIiK4SrqSiJfpm6KU5zfOiu8QrzMaLVMWhtX4cocQf0ZvVzu4afmEKM3TdQ
 XuIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408957; x=1774013757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 b=DxvOUzxq9SjNx/dKEIARpYy7j4Wlzh8AKM6u6B7/bTgx9nGSXJlctPNmXSekYvy8UJ
 MW3Ssom5RuHaBV2a9wBHOShZ/ZCaiCCLfFnft57zvfFncoPwBGW83s/nlh7mMXKuOMMJ
 NHSf722XTY1vdMa3VKOUyfkNgVdGEAm9dE4CkRAKmBYNQ4Us1/+zTb2uEsFWEzVuZs7o
 KEUED0DfmoRNUdujrFSCdF8sBJHbNl6KoGWB75CfAFCIZLgHb4XYSLGquTJTdTdeXoCJ
 WIDeLjXiQf7x8efKe+Ngm+WGYQkvpucpvnFBI1d4JCYldgNkEsw2STyDVuNlEoRRgDY5
 eJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408957; x=1774013757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhMxT5t81umetHP7OJdIfPfi7qUU4Lkh+7YuNP7wTXU=;
 b=FNoaGel1iDRcBm6opbBFMpf5yXPL1k17dq3NpIOwyuc68eZtMLXR8fPY0ACaWERGpa
 dVDyfBkPVfQ/9AbdzoSnt9EiMFthGLO3rvtda7FDyB+nc+kLk9ZXXM9zGVVgClbIKBH3
 oSZVtz5PYmNK2gbKyhucpuHEzYkCB23DODxOug9X85pWwKkBJ4xy14h2Z18oJgl+8BIt
 XhljvjvfhPe4uGQzX9TJ/e/bhN3Mo8LPGuJlMfXvAcUSHEYtOQOGHwPjg5jETu3kj64R
 AN5tuhT/LuU2nkjgKhzMFLoW6vboBDktKBUdQYV301zUdQcI2yaREkMux6wZyZmSwW2r
 r3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYPIzmIZXF2A/YdAyeQ3g1hSYVvqWMRGxNxajsHom4eahnMRiHFBxKD7/QOjnvu+mxfVWJn1/q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxqx2RlDM377VBNZImgNvfT3UjxXP/vP8G91S7Z9M7hIn5mFG+s
 6JIBItY7jV9l7g0uojLJpoBCM4bDizvALKC9e+uSmEblOyYfYu2dE2WPbD3XCwjQvzD0qY5TJJg
 30Vc4DrKgVo0IqPpWo2eZpncStUT17Jc=
X-Gm-Gg: ATEYQzzS9nN1HAurbwWmSuXQksjM615OlsYAi0SHmRpKk+WfxI5rKC+115+6IA5j0+I
 2xsbJdnmpqQ4vs7nwpcAoXM+hVA+jEl0gV/T0Y1NmfzNZvAo2z5SqlNcWPT4Xcn24CkRJTIKsWu
 DTYddnuU1fvYSidkDNiFOsKuDVoxZs0yK3yYMuYhIimu2OFfthnMV4ROrxqrahrp0kzrYBqZp96
 nTuhsHMlQ02Gegjhb8JwEjXUUtz0x5H9uHopciVJ0sJSjAmzyvMbha+M6EhUQE6B5sIWqM0K5od
 kiz/awXnQmiN4XQ4eQDFooZNpdU56cXhYjFWpeszVFFq3TYHGQue7pVuit2QDlYZvzBPVg==
X-Received: by 2002:a05:7022:2391:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-128f3ddb7e9mr736853c88.7.1773408956533; Fri, 13 Mar 2026
 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-amdgpu-fix-clang-c23-extensions-v1-1-59883120a451@kernel.org>
In-Reply-To: <20260312-amdgpu-fix-clang-c23-extensions-v1-1-59883120a451@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 09:35:45 -0400
X-Gm-Features: AaiRm52K3lFtnPCDTCHQ46AGp4JF3gz3oOt-LlB3C1NBMH_-HZtICTmqKkOb1PM
Message-ID: <CADnq5_MbW=jfGJE=jJi4EXacQs37P1d9KV4a8HjNDLwicwZV7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: Add braces to case statements in
 amdgpu_discovery_table_check()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev
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

On Thu, Mar 12, 2026 at 5:54=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When building with a version of clang that supports the narrower
> '-fms-anonymous-structs' (as opposed to the wider '-fms-extensions')
> along with the associated kernel support (such as in next-20260312 [1]),
> there are warnings (or errors with CONFIG_WERROR=3Dy / W=3De) from the
> switch statement added by commit 47ab777c16c7 ("drm/amdgpu/discovery:
> use common function to check discovery table").
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:560:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     560 |                 struct ip_discovery_header *ihdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:568:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     568 |                 struct gpu_info_header *ghdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:576:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     576 |                 struct harvest_info_header *hhdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:584:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     584 |                 struct vcn_info_header *vhdr =3D
>         |                 ^
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:592:3: error: label follo=
wed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>     592 |                 struct mall_info_header *mhdr =3D
>         |                 ^
>
> If '-fms-extensions' were not present, this would be a hard error in
> older clang versions.
>
> Add braces to the case statements that declare variables to clear up the
> warnings.
>
> Fixes: 47ab777c16c7 ("drm/amdgpu/discovery: use common function to check =
discovery table")
> Link: https://git.kernel.org/next/linux-next/c/0d3fccf68d9873a3c824fb70be=
0dbb2c4642aa90 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index f9f785c5d8ac..4209945af66f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -556,7 +556,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>         checksum =3D le16_to_cpu(info->checksum);
>
>         switch (table_id) {
> -       case IP_DISCOVERY:
> +       case IP_DISCOVERY: {
>                 struct ip_discovery_header *ihdr =3D
>                         (struct ip_discovery_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(ihdr->signature);
> @@ -564,7 +564,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le16_to_cpu(ihdr->size);
>                 table_name =3D "data table";
>                 break;
> -       case GC:
> +       }
> +       case GC: {
>                 struct gpu_info_header *ghdr =3D
>                         (struct gpu_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(ghdr->table_id);
> @@ -572,7 +573,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le16_to_cpu(ghdr->size);
>                 table_name =3D "gc table";
>                 break;
> -       case HARVEST_INFO:
> +       }
> +       case HARVEST_INFO: {
>                 struct harvest_info_header *hhdr =3D
>                         (struct harvest_info_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(hhdr->signature);
> @@ -580,7 +582,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D sizeof(struct harvest_table);
>                 table_name =3D "harvest table";
>                 break;
> -       case VCN_INFO:
> +       }
> +       case VCN_INFO: {
>                 struct vcn_info_header *vhdr =3D
>                         (struct vcn_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(vhdr->table_id);
> @@ -588,7 +591,8 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_size =3D le32_to_cpu(vhdr->size_bytes);
>                 table_name =3D "vcn table";
>                 break;
> -       case MALL_INFO:
> +       }
> +       case MALL_INFO: {
>                 struct mall_info_header *mhdr =3D
>                         (struct mall_info_header *)(discovery_bin + offse=
t);
>                 act_val =3D le32_to_cpu(mhdr->table_id);
> @@ -597,6 +601,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "mall table";
>                 check_table =3D false;
>                 break;
> +       }
>         default:
>                 dev_err(adev->dev, "invalid ip discovery table id %d spec=
ified\n", table_id);
>                 check_table =3D false;
>
> ---
> base-commit: 7a9419ab42699fd3d4c857ef81ae097d8d8d5899
> change-id: 20260312-amdgpu-fix-clang-c23-extensions-1fb28eee64c2
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
