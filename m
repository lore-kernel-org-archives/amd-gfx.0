Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F24C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D6410E954;
	Thu,  7 Dec 2023 17:38:23 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B454910E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:38:21 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59082c4aadaso106366eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701970701; x=1702575501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XY+ElXH/ptd4GrM5sf1xpUwvXuA/rMJStUHnsVXIuww=;
 b=enaJUb8J924qRLQnpgBmBJVqqKx+2HXE+Cml8FfvUWDmR9vzrvwA1sUXg2afc79iP8
 5HHWlBA1mpWt/5Dl+eHbnyCrxV93ZHWSCUpycwJrniWTZdubD94BB/MvA/udZ40Plblo
 DxB7v4ijWvamiSwWYC8PTWHinbLQMKCt7/qV6TpH7KiNsF9EQMf+dQZ4R4QU+OsLhL0P
 Dz2ZBq+7prsc66klt8z7W4cEwxFK7WtSfVlQBfMJg5OZ9PFMB8q7+dF/8Gpsdl3piTXU
 60Nc1/kcOJ5wqdAyWo3gC1zNGg3uMWze3KDJVD1aQxVK5KkYhc4j2b9tHQZLZ82aUty+
 cSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701970701; x=1702575501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XY+ElXH/ptd4GrM5sf1xpUwvXuA/rMJStUHnsVXIuww=;
 b=Vk6S7tZRoceQHGTrDNX315rnpMtbrxIdvbDpiq7X+7jYctArXKf0Ps7NP5sz+XMpdE
 WFeshCXZSLUApcYxxcXvMJRs9aRz57ht/cUJffkTllOSuNFxN6a8/f5Qh6GYeLsP23Mx
 ZhO9PUOwa29bO2SGbvFYlZkqKoMZBawW2xQ+09/7lyjJwQrfqAwA9raOiHlzJ3pioVD5
 R/adMKImlluP8f+QPlICanndkgC1LJGW2vRywSxyiHsS+5L2CNOGvXyk32rTVnnT/Yea
 exokyh14y6Vp31K787pmBlU12M80CfWkCbKt+2vm4zGTQNUH2qAu7/dgwkkZFhR9ZDqi
 xQRA==
X-Gm-Message-State: AOJu0Ywt+u/+OlT1JbO9v6X+Rb81nTHxQSdgqBlpxVdkQ1EYeI+V5Xt8
 A7Hsex553nv5FqegLXClGy756UaaBEZxECQb8yo=
X-Google-Smtp-Source: AGHT+IFMS2O0s4vPxNjhuK9ntKdu5XEkSaPjJQxTbCTLQGotAkfMfLOE/eXCbv3mOsPbOtvkiBlb3Fx4pfl+h/9Xt3Q=
X-Received: by 2002:a05:6870:9728:b0:1fa:df7d:754a with SMTP id
 n40-20020a056870972800b001fadf7d754amr3352716oaq.5.1701970700874; Thu, 07 Dec
 2023 09:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20231117152339.28627-1-alexander.deucher@amd.com>
In-Reply-To: <20231117152339.28627-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Dec 2023 12:38:09 -0500
Message-ID: <CADnq5_NdfMQDRV2hpcxSJOeC2JF799r6APCwx8b8f2S8+Fp+fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/atom: fix vram_usagebyfirmware parsing
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series.

Alex

On Fri, Nov 17, 2023 at 11:17=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> The changes to support vram_usagebyfirmware v2.2 changed the behavior
> to explicitly match 2.1 for everything older rather than just using it
> by default.  If the version is 2.2 or newer, use the 2.2 parsing, for
> everything else, use the 2.1 parsing.  This restores the previous
> behavior for tables that didn't explicitly match 2.1.
>
> Fixes: 4864f2ee9ee2 ("drm/amdgpu: add vram reservation based on vram_usag=
ebyfirmware_v2_2")
> Link: https://bugzilla.opensuse.org/show_bug.cgi?id=3D1215802
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index fb2681dd6b33..d8393e3f2778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -181,18 +181,18 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct =
amdgpu_device *adev)
>         int usage_bytes =3D 0;
>
>         if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev,=
 &data_offset)) {
> -               if (frev =3D=3D 2 && crev =3D=3D 1) {
> -                       fw_usage_v2_1 =3D
> -                               (struct vram_usagebyfirmware_v2_1 *)(ctx-=
>bios + data_offset);
> -                       amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> -                                       fw_usage_v2_1,
> -                                       &usage_bytes);
> -               } else if (frev >=3D 2 && crev >=3D 2) {
> +               if (frev >=3D 2 && crev >=3D 2) {
>                         fw_usage_v2_2 =3D
>                                 (struct vram_usagebyfirmware_v2_2 *)(ctx-=
>bios + data_offset);
>                         amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> -                                       fw_usage_v2_2,
> -                                       &usage_bytes);
> +                                                            fw_usage_v2_=
2,
> +                                                            &usage_bytes=
);
> +               } else {
> +                       fw_usage_v2_1 =3D
> +                               (struct vram_usagebyfirmware_v2_1 *)(ctx-=
>bios + data_offset);
> +                       amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +                                                            fw_usage_v2_=
1,
> +                                                            &usage_bytes=
);
>                 }
>         }
>
> --
> 2.41.0
>
