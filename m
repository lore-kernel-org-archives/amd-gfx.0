Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0FC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A05810ECAE;
	Tue, 22 Sep 2026 13:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PldQqJJp";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B0B10EB8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:30:28 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39e6298aa19so575761a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 06:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790083828; cv=none;
 d=google.com; s=arc-20260327;
 b=EPbyt8CgaysryqX3Ywxw0Li8s3KFEr4LFXx8jf+sS+X9ngxDiF4ocqf8Rke2Elj/qd
 3hoQKHaUaYgohckDDZ7xQ6J6vbi4hKFcQbwtjTcH34pN+1KyNdQhJsrGl8UzvYHt7505
 YErRgdMsvEcwSg3Ct61UxSqxquWhM6vYJ7rcQaHOQ7jhdQUJ9dx7Nd6vB1ABzzghlG/A
 Ry3C2SaLR34qnSuBzi0EzfCbm0DdInhImHk7MVrNCXzhNSRnXibqF5P5Tgdh0B7n4FeP
 6d/Vbyw+49Y4IUXzftPkifRvLKVHWs3lwsK3YS/ujIYUw0I6dfn06tPXqOJOwW69n7DG
 +FTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 fh=yhkhOKhkBo5ew9iQkPgKk8U2Mi2Cg8hfrtq9YHdiyAs=;
 b=TwJiErm9fxkTeFeXip3YZtYYNQKlMuuYdjTJJhhW7YxVpYkkQIHbghQ5qd/b9FvlCe
 CtgRXuK4XHSkFRBRLu7QZBNb0PP5e4Id2aIHCPvk8vStzLlFDg70yeL6997saVjns54p
 CP81vptNKv9o9WYdx9pkbomesCqeaB6KPhEEVx4LNBiDPPLuDiyXvneTmw5fkRcc4jYL
 V0Lib95KQgdj59yezA9w7coY6q5TsPLfBAzoh8RboD0inJr4za9uqMUZc29ocLFHfnj6
 QrR6w5/vqs88ygKtl5LvJh2xGUSv4xT0x3yrkxl8cnIkdkky9daxjfb5wTsM3HGrQ0SB
 luFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790083828; x=1790688628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 b=PldQqJJpoAqcAqB50R0B+V4h+WzjI6Q4J2LmBEPGN47MrEOwrOFJRNpEr8Ewac9pFk
 CkvF7S/LrCDwCy5EllMmZ8BCUNWDkW8KQ+ogSuQ2bj92h68W391LMWWaeCFQkdx3p42f
 T2oqi0T3+AtS+UWHoMEDq97n3iuWOcnUQ7aU2cxlYV2hIFIOQecjqijNPR+7zXcPOrpd
 TVbIG1VIlNIntBwWbQTkTZOvbNDTnb8XnJoNlVdyCzpWgfPnhjrGd2Hg7NVSiMfvnREy
 gBgp6bQJJSnCHq+jcrgM3IgiA6HahbwrDyKjaXJZdigkOghvQqwKe96UmP0x4qSxFj4K
 2kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790083828; x=1790688628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wA0KBR683Rxf67wOoQaReSR/BOf+zjptaqpc+T3kfE=;
 b=LyzGblUt6Oql6fp3mgTkM0Gmp2wfGtfE4gRxpzGd5mpq4Y2tX/Fa0OEDbCLIQcGtEL
 6hv/c3xQ6gugRENduyaSGPFtUh0U81quF74//A4Mq0jsEr3aRrcSliO8VJ6uGLeh8MhY
 Fp31rincNNQVHnyR9MXjfmLcCGtsA2SDM9Kf0TvA5b88lPF5UIGW+FKpDWlEQqJfXszT
 e2moL9Nj1XxYSJffAozJ6D5+q3m3Ko/ZHQyX44gc8u+4oUqj6Pc+04WuUwkiBCW+cWu8
 lZgIQVWZc8ucUdGNqEaOYQ1e+Op5rCxCAp6Mkqm2+pVL/xIaS3VExWqrdz1hLObRAn/H
 iL7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpp6bqTJoE/U7jixSqLCxcIVOo3xIHlOZwrycnAl0iqmIfLaDCtCAvy1s8kAAjuzugiVV4fZAz@lists.freedesktop.org
X-Gm-Message-State: AFuF++nutzUeh/rSigFMzQX6qZ3S9sZmNBrg8peItAft+9MLXh14npBL
 BoX+p6AGZXNr/NO/MBiW5Jn1rFeFE8hyeNYt7wfbPxqeO16yNXqfWXQEjVSvmBNKvEAfXNJ00q/
 RjEDDG6IA494apsK6RGUnEVnsYpVvjDw=
X-Gm-Gg: AYBFou0xjwTuP4eUc/6WLChXwddT2BTdB/bN2++5FSKBMlL23t3QM/t48Tcg7Tlo5e8
 sJ/gfmhJV9KvvC5nzf3s6ktzt1UpU6D4YcLn3FXr6MCFoLo4GZzy94IOnAlF68enltJbCeBiy/C
 cGFddvOVaSycfaY18bJtaGE0Gs88QbZZ2uiBkC/DqAEkSbtypxewIQteG+Z4CPEZmRE/1zXg0sH
 2sIl3mi0PjBJF3Pow87P/Y7VL5wXZG39+m/Q8DZ525TvAm5Lg44aQCxDOmxuWmK7/GQtg9XfV20
 VM5jShGxS/y5iORShaGhono8w9owiJOFEVf+Zi5gSywXrJ1tKvXkuna7HbEvFYFJcP4bqPDHZ27
 pp0srbOZGd5K5oq3W+nmgNuYdZoaXHMZG16BdRJJ5gAbv4HLbKIYl
X-Received: by 2002:a17:90b:2f90:b0:39e:2f57:67c8 with SMTP id
 98e67ed59e1d1-3a07333690cmr2055086a91.4.1790083827685; Tue, 22 Sep 2026
 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20260922015411.116292-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2026 09:30:16 -0400
X-Gm-Features: AcwNN1Vh3Py1nkVejJCuQAOkulIvl34lmizTsCKnEe3GX6RsIUZUqrjredfWcos
Message-ID: <CADnq5_ObCd1rXewb4YXEZVTF4R_ZM5Vib_Rnr21sAbpNTfnqoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx6: fix firmware leak on teardown
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Sep 21, 2026 at 10:01=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> The firmware requested in gfx_v6_0_init_microcode() is not released
> when the GFX block is torn down, leaking the firmware resources.
>
> Add gfx_v6_0_free_microcode() and call it from gfx_v6_0_sw_fini()
> to release the PFP, ME, CE and RLC firmware.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 95e939363db6..a5553d181d97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -322,6 +322,14 @@ static const u32 verde_rlc_save_restore_register_lis=
t[] =3D
>         0x00000000
>  };
>
> +static void gfx_v6_0_free_microcode(struct amdgpu_device *adev)
> +{
> +       amdgpu_ucode_release(&adev->gfx.pfp_fw);
> +       amdgpu_ucode_release(&adev->gfx.me_fw);
> +       amdgpu_ucode_release(&adev->gfx.ce_fw);
> +       amdgpu_ucode_release(&adev->gfx.rlc_fw);
> +}
> +
>  static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
>  {
>         const char *chip_name;
> @@ -3254,6 +3262,7 @@ static int gfx_v6_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>                 amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>
>         amdgpu_gfx_rlc_fini(adev);
> +       gfx_v6_0_free_microcode(adev);
>
>         return 0;
>  }
> --
> 2.47.3
>
