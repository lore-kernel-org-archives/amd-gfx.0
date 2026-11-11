Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52F606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BkYZGsDs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E5510FC5B;
	Wed, 11 Nov 2026 16:58:04 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9631D10FCDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:57:58 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-35159e0092aso76843eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 08:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416278; cv=none;
 d=google.com; s=arc-20260327;
 b=shGkUrnKjfJ4L9OLTRYJ+o/8bi6wXj+wuGiRlW39tdnXS8nTEAGKWRY/Cezrd1IhLD
 C/FlvLWM9mutn5TxiXnYlaLqgpzT8aG81sIwl5G1ZT4j3oJuQAGOOXHALwoCMIGCW5nB
 O5aAQCGCA4bmw1Vz8b1N9PCKrUj71OKQOHlZI7QeagLlUC02iaBIx8qn7aqnwSlAuR1X
 ugaeL5NAwc51Va6sQ6Ha+/NI5YPwaTTiRu6w3X5U51XVQddxS8LPA3ouVfjWbMhQTQc8
 +tAGMHP7NQBkYl08PkSoABfrpR8j0Xh8vRyUX4o+YccAw0UC7oyegzFYf84RaMPgP7EW
 jKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 fh=LkzIY5PN3JCv8Iqvwq8OXBtpmVVogfwvgLYwpUVIYNw=;
 b=JvMgVNP8ABdj7PjMvPMEzM6urZZ5wX3P6RzcOISqdJM0BHFHDfMwR+4Af43CwVid4c
 YGUiqQTk1Pt6IKB6kycXbUH04OaiD6OJTx/XNSnHfGcQ8ppZhmbSPl1BAzioXQ7bPJvy
 5DkLFHLh1o6Z64FeM5veGScbm9vJO4AYn3lIV2QQP1GmN9xx7wYyLy8o1vbSsrczkg8b
 ptF6Y7Jl2EG4ask8d9ZmeIIRVaB2XghwmRmUyXFmP8PnK9cVt+gyDO5KySY/P6ygLUMi
 ggxJ/3gusfzcT+8aaDrzASZKEqeEBNxprNBhY6kXqQwWwerBNOF8cZtOz5gEu+3A2Y3R
 3gGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416278; x=1795021078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 b=BkYZGsDsJeNvNbDUdnVixaQgNBiKnweNd/tJhV4WKAT6cBrG3C95KW9+EvWdvAF1GA
 41kIo/7mya7pvn/UjfN8wJ12lX6qUPmc2HNyVSgVCQwYAZIi0JQm2QABlUaYTj+gET4G
 VhmuIFjT4CnHBF+7tAubTCVFUE2BOxSsDuFfvqsRdz7yRLJDBlr13ddnK2JKHrfoDKG5
 89NgPrBhg2+oIt72PlshkR6dtwWttcH2XXXPQkPL/N1cyCUGL0KMQZPsBt+2G5Ksg61Z
 ALxS3b+aj534RFbd8F4oTmzuKydtQSyhtZI0NHGwVf0dnil5lynA2/nbqSus8urV6rTa
 Y8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416278; x=1795021078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5NwrvkVcWYRXcvvXDVMbg9XZrRoxtHq7/a0L67gwNMo=;
 b=qrPek8MJtNl5HCbUFySDfWLMJRTF8CP8m+K8bo4/dOdsRqgn56xmrmSXtUtswKu/n0
 Mi/OHha+B+lFFQsH5fvhXElcZWBC2AWY3kqtPOw6AwoHn5ZZ1LtArdIOafaz7ILyJj82
 yVexSSPC005r0o3o0Oo4VU1ah/aWF4kdr8I+TJZ7Wdlds7p0gMR12RKIPV7gq3a1FzCM
 AlYdzlo2WVLccT1pXT3kL/VzkW5AWSRyFCLt9P+Ok/YYsmV666uHuRK89ghmMnEz4WU2
 LUFa7hmrWVUb7Sg0sCVXaWJpvXTApzlTeFC8CHWv13M4jw74lLdlMZTJXCtfiJnUup2p
 CjSw==
X-Forwarded-Encrypted: i=1;
 AL+hErGMddxp+W4xig9XUyr3RllK7Cyw4S1GcfaCuVXHvX5/s/bLX7MzkA1qgmMXdMfyrNz8oQctktBz@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CrXCeaDNpjmDhJUg+05JDzxFRSpLrHv1E535l6+Fx0IxMR9di
 a9DbzfYpVFKBBqM3ajq1PzzPhkImywWoBw9Cz9mluhD2YDZrQXNHyioTa5pJ83c6m66UxbUj6Ri
 rrT7nyIv5CK2J9GWucRBrLltzW6xDTEw=
X-Gm-Gg: AYBFou24z6jqpTbvE33R1l1pmIJ4GDi9Dyl9+1DVV4Cot5mGyYo3tIz8ztidVTt18oS
 oMAd67sTH6NyjdFyoVf54oq4wTvz1fU1FZTsnOVjVD3wYYJmV+sYmhdAF5StuiqMzrikdmBj9Q1
 B04jR7IIrki5VHEfiVgsBtkZYIBQ7CY4RA1URQZ8xNBgMXzwtskiT0/TlToqoz+yRZjnzdPIfqU
 Xvh5UnVJgZDDtw794kbH5EzY3qA3yYivS0H/4oBP059Jw09CL1is8RgwnxrKnVpX/lt3CdZm0E8
 1DI7+9d9rZgvnY3j83DCOwmnIGOlQjNTmyic2f7ZmpJRAydDFIO97YogUk6vFRv5QdAUNKvrc4x
 Wxpp0g0d+K/Z6pyupp4VapVr7TYImC/nLHcW9OrUdsd9YbXkTgHdT7m9gQxOn4jx4WqBjlVaevV
 EfQn51s3uLOOxCKvHf3zXv9hqjBmnXLbvZdCgbwQCkWsCy4rGDsdB966I6NVpmx1w7/RfCmaRYC
 +WCspOu
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4291753c88.1.1794416277403; Wed, 11 Nov 2026
 08:57:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
In-Reply-To: <4VYoOFUjYIK--SKrUsijHVOOHA6ruEc8z_hXR_OMj7syXD6492lPaEKmsRRV3iLW1QAkn2X29F7_-lVKnIx4vUE1KQtKx8Zdk8sX_rFaZIA=@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:57:43 -0500
X-Gm-Features: AclHuK-DMzwioV5PBa5WXoevsVpI761BeBU3ynr40SlnxuCKodphabVoHdQR7zc
Message-ID: <CADnq5_Mp0dxiK1cJOgkCcHap_0y4GhwnW0E52PR7gkySnkMk3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: do not dereference NULL vbios string
 pointer
To: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.com" <simona@ffwll.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 4:41=E2=80=AFAM Noah Weinberger
<NoahWeinberger2003@proton.me> wrote:
>
> Hello,
>
> In atom_get_vbios_pn(), when the part-number string is empty and
> atom_find_str_in_rom() cannot find the ATOMBIOS anchor, the fallback
> computes NULL + sizeof(BIOS_ATOM_PREFIX) - 1, i.e. (unsigned char *)8:
>
>     vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64=
);
>     if (vbios_str =3D=3D NULL)
>             vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>
> The subsequent range check is false for a near-NULL pointer, so the
> value survives and *vbios_str dereferences address 8 - a NULL-page oops
> during probe with a malformed VBIOS that passes the magic checks. The
> recent hardening of the neighboring date/version/build helpers closed
> their OOB reads; this fallback path was left intact.
>
> Simply leave the part number empty when the anchor is not found.
>
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670b=
d (v7.4-rc1, 2026-11-07), drivers/gpu/drm/amd/amdgpu/atom.c:1491-1503 (atom=
_get_vbios_pn).
> Pointer-arithmetic-on-NULL is pre-existing; this window's hardening serie=
s made it the sole fallback outcome.
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07);=
 every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

Missing your Signed-off-by.

Alex

> ---
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5..7598606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1493,8 +1493,6 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
>
>         if (vbios_str =3D=3D NULL || *vbios_str =3D=3D 0) {
>                 vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX,=
 3, 1024, 64);
> -               if (vbios_str =3D=3D NULL)
> -                       vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>                 if (vbios_str >=3D p_rom + ctx->bios_size)
>                         vbios_str =3D NULL;
>         }
>
