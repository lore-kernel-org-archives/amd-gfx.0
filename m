Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD6606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yeAwaSe2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C895711259E;
	Thu, 29 Oct 2026 22:11:58 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F6D11259E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 22:11:52 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36a1865cfdcso15607eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311911; cv=none;
 d=google.com; s=arc-20260327;
 b=ktYlFbYMi+ic5QwY38GnvZbDNVMFSfE2retCJjmeYNJx7Ky0lqOHERybCO9S+BQFSi
 rNNjNkML5xPlAPQJlK84lZGu4KnxrHP6W2nWijQ8WTZ9+EjZ3n19qjwfAd9bzY3imzK2
 /Sm97j2ASpiXCn0LmlB8GZWDnQkkWfv9u9CzHnei8gnuEnWwc1UoIQCy65968zhLqheA
 dmKw0f5O8G0/zYv8sWsBYuV1UY5W2dBEKqdF4q99QIDnpJ6cCZ5iTWqk5tuDtgtRzTFO
 kkvA9PcTJdrNhfuoHHZimPlOmFLx6Un3rGN3KpAOw3dm2Y/LgBn7v8zoh1KfZx/S0EUD
 tm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 fh=deUl4kmLk5+OOJjWcgVPsIl9qjFLb8TrDkRBSrWslJc=;
 b=ed5r9SNH87/UpDBUTAQxOyiNPzgJdgNrAxjXEJpCZzOi2zQGuLHHvHvoT7YEoWc+lL
 +uHcGGsrBBdE+S14631rU3LRmzKMkjaT75l9/vxV0SCdBF6bbwv185Z7QksQBYG3vOqF
 1QNMgh2POHYwomMOuG15/nBjtKXCCxtaU1ZSrEbHbhkR3CsUeubrkr6kHvN2nyNH8BIq
 BJDdcN5VQ7sle9RVReilgeoQWS2ccgNN6IZI+iI/b+aLQeg2RAm2o7J5LiCHAa4f/gql
 /hm9ZoPNWmsdSLVRlNLcnIbBtw9J52kazjbsqfwNgcIkShi3MK/rpt4zna3JnvJakp11
 2OBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311911; x=1793916711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 b=yeAwaSe2K8LFKzyLew8S1w/zvFuym0AgNBZ7eO1bIAju9itMTh+uRk9/l8Nh3hY88i
 WsfEIDe9j9Bk6DHJaR+R1GnDC47fCoVL/g9XFkCKwizG+IlikrVk+DfBHl/iAwpIzL5k
 bYsQv868+MOr7xsV1YZr/m1rjvovp/qefBaUOBWzyKL7fLBv+HiXvstxDHjOOwqhrKBm
 HUYjqEnPx4kJG9rYdKgRjMgJLHDE2IXaG0GsBYffNPiaCqwDVfBw/lhN3pUEhZq2NGsT
 prLdxB1UvxIRWLtwD0Xid1ddEwwuwHUhC6xTBd+F9KYapiSriqqiMc7NWGLqTyKTuaPd
 VgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311911; x=1793916711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 b=JvB4v01B9B7zNUs0RNapC0V0MSqpzdtRYoRisqDjx79QBkMUfa1/CRrVCt7dqKs2jK
 R8hpRa+Tn11ZCMJrpqyK/jinDW2GXqk1d+lJn1S0Jau+/9KSCeD44BcIieoyh+lo8QRW
 ecfWFbNa19a41JUZqbBzJsdnSpsgIkoGyoWBdANs+PeqryvYzGTKe0UvyYNu5yNIdqgy
 g+8iwuHB+8J3gBOjoWQM8gh5xwTwGVxDsH4eqhAIlVgqN6is7HpilWv2bdASp5PF05ZJ
 sSU7XqYmTnKEz9upf5mc9+KXq7HR6txCkzU1VVgIIR0ZhR1djPWiBx7acYsf9Uc66UC7
 lrRA==
X-Forwarded-Encrypted: i=1;
 AKwUvByooVHnHmQq05eA6Sw4cslxxeWuDzb74aBn7sOQnE8QbN6qRPotO+yscmwJzowutDzH8rj09eQX@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIng2nR4F4SbISFduqefgO6WTR1jQCq7Ti2Kmt2gEttygtaMPrC
 AQ+ilg0SBUEgYjRQ3ZpZiY5wdH2xIvXXFogvWE05SS6sUFjNVGBee2BECDHTWcj18JUTGsKi31B
 7S76HK3KFxMczgqz00720Mt5Ax18Desw=
X-Gm-Gg: AYBFou3oAQ8VfqwSuTy3KXy2zGViaiC69RGCJHG2czbNm7t+EnZENWZoD+NMhPig3Ga
 Qbpz1vN/l3DYc42yCYkKII6HPkNYDFZoifgjpHNbSIKVkILyeTyPpdrJCuMXuEaRM3LEJW7SF6q
 JcEl6vYARbYsQWj86sF4LQI+zLUu29SCxae7Nu+vorWCdddF/pHC4qeciX26QKW3zNUuYLQrGM4
 caJZG2ZU/YbNRA4zVVPOGHZkLn6PzGZZbK4Bn/lGwL82aJXLMUypljPN2pdctpZprxp+oisanxW
 +jwlgsFdQGzkqJz5ZTzpS2gxetVfVdxt/NnwLfKlKjTzCxdO6xICxm/bKziW4ScdFc02Q+VZJcg
 qsyI5euGw0MCQVO97KkuO6XvHbQjg3K9ICOPf/H8MKWAW1XWB1XupVuS8u3X8HXV3v988LFcwPT
 bvrNtX+MUWw1b0kGfBwbaUPv8=
X-Received: by 2002:a05:701b:418d:10b0:190:e602:c769 with SMTP id
 a92af1059eb24-1ac59143aeamr818406c88.1.1793311911532; Thu, 29 Oct 2026
 15:11:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027193559.28474-1-amade@asmblr.net>
In-Reply-To: <20261027193559.28474-1-amade@asmblr.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:11:38 -0400
X-Gm-Features: AclHuK85g9fztoaVrlp_rJWPJHWRSqCOuLati5XqcOXZS0zoPwKNpaJFJhjLezI
Message-ID: <CADnq5_NOVHSLnxwmY5gsq4vMxbJP6QQPnPiAJt_uwkDtegpYkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Prevent debugfs nullptr dereference
To: =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amade@asmblr.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied the series.

Thanks!

Alex

On Wed, Oct 28, 2026 at 9:06=E2=80=AFAM Amadeusz S=C5=82awi=C5=84ski <amade=
@asmblr.net> wrote:
>
> Running
> cat /sys/kernel/debug/dri/0/psp_spirom_dump
> with amdgpu card that doesn't support it leads to nullptr dereference.
> Add checks to prevent that.
>
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e..627c74f16914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -5381,6 +5381,9 @@ static int psp_read_spirom_debugfs_open(struct inod=
e *inode, struct file *filp)
>         struct spirom_bo *bo_triplet;
>         int ret;
>
> +       if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
> +               return -EOPNOTSUPP;
> +
>         /* serialize the open() file calling */
>         if (!mutex_trylock(&adev->psp.mutex))
>                 return -EBUSY;
> @@ -5473,6 +5476,9 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *=
adev)
>  #if defined(CONFIG_DEBUG_FS)
>         struct drm_minor *minor =3D adev_to_drm(adev)->primary;
>
> +       if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
> +               return;
> +
>         debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_=
root,
>                                  adev, &psp_dump_spirom_debugfs_ops, AMD_=
VBIOS_FILE_MAX_SIZE_B * 2);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index a4ec60f6c317..975d12359358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -574,7 +574,7 @@ struct amdgpu_psp_funcs {
>         (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
>  #define psp_dump_spirom(psp, fw_pri_mc_addr) \
> -       ((psp)->funcs->dump_spirom ? \
> +       (((psp)->funcs && (psp)->funcs->dump_spirom) ? \
>         (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
>  #define psp_vbflash_status(psp) \
>
> base-commit: 83f32c773255720a661aa45d83e36278135f23f5
> --
> 2.56.0
>
