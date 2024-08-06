Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4402EC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E208A10E404;
	Tue,  6 Aug 2024 20:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTeDx+SG";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329CD10E404
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:54:32 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so886097b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722977672; x=1723582472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alCRvCnFWgslS1pOiwhLJ+GiKAJTAw/vNb/IVQei/0c=;
 b=hTeDx+SGFh7tzP9yHNQ2MnJwtJYC5uUwd92bJTk8hM471Ly1Dwf4Kq8Bj5h17mPFYN
 M/D2jCywwN/FRuoZEjTCZblSIcYTXYhK3PNjGJSzzTYZyH808pMz2yoZaH5ZnBvnDTHH
 7mtW5Lf+nRyITX28ieQJ0G3sRv5W92xfigCd3MoOXNF4pt9LnwtsTUjwBdi8I3q3brpz
 xL8juXi4LtzN8Y+svsEFRqY6XS6qNkIn2UMDkmzK3y8PUL4RpqoTOUosuV/I/yg4DhVW
 JUJBDM24DYgBTp12G0iTdqVxqWDe6QUuj3FYgZa8DgOGPTI7I5CJbVcFEltIyg1WqI/f
 ExkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722977672; x=1723582472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alCRvCnFWgslS1pOiwhLJ+GiKAJTAw/vNb/IVQei/0c=;
 b=nDb2YUtedQnpWrRl2dDfuEdYJLJT+bhwwiy/PSG7RLoPgBpWb3cNVXowltXtwgVpqz
 ZZj31cA34WS5QoPfViQDEm1VFP/LMwMHywuPlQCMGR+H/LazLa9J1r3Uiqs2NLvicnmf
 6/5AYAqyrUyooThXyJ+PTFa8aPUi7/PTf/FIEfPkl3sW0wxBejCJyAJNouwb9Rcl+o40
 OEYSJvGsJ5QKRKvzxfi4R3f8WTjhaBG0WaLJe5vYuhKz/4wmhFAo8u/f0voG6x2fboPF
 MVEm97zE+C3y9mL9UvZAqFUC/a9rvKGoCDFuYR6/q/wRTGIOOnhdxayI7EaY+hyxizKG
 6Ojw==
X-Gm-Message-State: AOJu0YzmpBTEDHYoQ/Sjdl/pJN0cAfub48X0OlNtQGG72KhCBXbA8bJR
 PqKXcCik0Cl2+9zfH2cpWJVhOmKWS5w2uMM8djWZlwY3jwA+IUA+f34PuXj1OweVXSXFEHdUtso
 Pm51Rb7VRn31M3hgX9XoTc0tCUrI=
X-Google-Smtp-Source: AGHT+IEdqoiSS7Zp74xTSKujp6QVe7YyVCc3fzccTbcbny9+hMJWzZFLAeOFMDQJRMG73HDNbgosCvZbZ6+HDlMEdJE=
X-Received: by 2002:a05:6a00:1253:b0:710:58ef:1746 with SMTP id
 d2e1a72fcca58-7106cdd6141mr20897749b3a.0.1722977671649; Tue, 06 Aug 2024
 13:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 16:54:17 -0400
Message-ID: <CADnq5_McPRzWsvxqtJTOkWJss3MOkMEhnS4nsiS72+oenG9fFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Actually check flags for all context ops.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian-koenig@amd.com
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

On Tue, Aug 6, 2024 at 4:35=E2=80=AFPM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> Missing validation ...
>
> Checked libdrm and it clears all the structs, so we should be
> safe to just check everything.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 5cb33ac99f70..c43d1b6e5d66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -685,16 +685,24 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *=
data,
>
>         switch (args->in.op) {
>         case AMDGPU_CTX_OP_ALLOC_CTX:
> +               if (args->in.flags)
> +                       return -EINVAL;
>                 r =3D amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
>                 args->out.alloc.ctx_id =3D id;
>                 break;
>         case AMDGPU_CTX_OP_FREE_CTX:
> +               if (args->in.flags)
> +                       return -EINVAL;
>                 r =3D amdgpu_ctx_free(fpriv, id);
>                 break;
>         case AMDGPU_CTX_OP_QUERY_STATE:
> +               if (args->in.flags)
> +                       return -EINVAL;
>                 r =3D amdgpu_ctx_query(adev, fpriv, id, &args->out);
>                 break;
>         case AMDGPU_CTX_OP_QUERY_STATE2:
> +               if (args->in.flags)
> +                       return -EINVAL;
>                 r =3D amdgpu_ctx_query2(adev, fpriv, id, &args->out);
>                 break;
>         case AMDGPU_CTX_OP_GET_STABLE_PSTATE:
> --
> 2.45.2
>
