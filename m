Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB4CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 18:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA3F10E032;
	Tue, 12 May 2026 18:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNz78uvc";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA6810EBDB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 18:30:06 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso407837c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 11:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778610606; cv=none;
 d=google.com; s=arc-20240605;
 b=UGr4AcGpE/2Cwd649cnHL8I4UR1USN7NdzZC76zws3VrnPOyLMmyRk3AdReGj58kh5
 tMA11sxA31Pxm5Kwxn0WGU1YLO8FM8FVMmduIx+4Y7cqY62uGOL4t5Qw2EX/NIaNeCkG
 icMjrxm3rjcSDNSg7bjVWI1US1Ji64qMoWFHhvJ0ViT1cQkszvGVWrp1QuLwgCGyOVyn
 ygCM/vBjZkKKYos91anDbEgLEwNMzU1ec+5l7BAPlFiwJwZJD3wr4Dhywy2/ptKQI7fn
 oeVz4gL685nQv1C/+LFFKuPd4tAQ8mXpa85vlHDXuXaGTEmB01BF4dkKW5LFdqaM543G
 hX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P4ZlKQSEBd9aslACP6D/vNg9Q3FaCWFPSVbCckjWNSM=;
 fh=VAkDBUyb4PWOAdC8m4uyOCx3AB4MjXpMstQUgaPTGyE=;
 b=FjmHB8jjdudcBNqmA47GNl5L0YCNY14QZ1S18ncXno3iDYD9TdsD5mj/5jgLX4kEoC
 PirghXRf3kGFwe7ELn/Y//MEbyxAYTXrxHK1BX0egJ5869mPiwWACJPJcIhsaVfJjtBK
 obKU9o4Ij5c+2yiKvZ2t/PAzlRQBzJOASJ82R2hmUyujn8leGcdttYRsmZNQloHLYPST
 vBClWiW9tMlmcMtKKRmsBSSaOEBKLraDvKdZXx1s8+aQL4WuhBqu1crIp3dPtETM4Xrj
 XqQASPZXW4f1rLK4ebGdrByYQjmi4zhVEsgE18xUlLLhiZzVInhVkK8aUj8sm0AKK0JN
 6NUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778610606; x=1779215406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4ZlKQSEBd9aslACP6D/vNg9Q3FaCWFPSVbCckjWNSM=;
 b=dNz78uvc6VoJwDiXCAylPFVMGOHQ+H7l0xpPh4jWJpudNR5DJuhEbL+k5ZZGbUEGiF
 4CdS6v0Yi67jiB/p/E1HasZoLbgBlxL6ghrsmxfwObTvXPly/r6jKHDUmP8gxXio1wK4
 tmXkjYNIFsOmbr4eAK1sNcXUP/cKRJfOJariOVE/h9TlXI/9Z2pSzCzzaTD0YCaqnFGL
 gG0cmo7Nj6JxeRVQ6kKPiHAgtRg45WgcyvMAqJliw4koSIvHvvnBFyL70pSdd/WqwHb2
 wlJfuBVreWF905/dv895HHsAHX3Kicd7Fdp/LbolZlyKZqpXPdyi07XsrUIzTrHi2nKL
 yOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610606; x=1779215406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4ZlKQSEBd9aslACP6D/vNg9Q3FaCWFPSVbCckjWNSM=;
 b=d6xgxVtzi9UAF8PHY1h7EZgYtWRoJWPufa2q78XutsNPl1ZdegLx9cSD/vzjLTVcUx
 gA7BfEhLbSUJ7wcE+HhB//95ec3zqsi7bizRZTzvyzy/gzdl9X7r0sdaa+N8pQcGjwIY
 LxOlcYiUUHlnL4DABJe3rBsaj78CgNsgxKo46finoFGkai8ah9+0izXOVVbpbyspESon
 eel2uimA9DNjhQeT4CcI2eVcTUx0tnu5FVL+Shkfre3+uev/pmqnf0vvzEKkrx1KHHUS
 h5lrfHgdIbcZEAFIznmjMIHIhbRvQNWiCGjN17atWa9kLda+v6OkzfLvMfbBMv+RlHSB
 6JMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/u0dSmx+LZnIVJg3ZPjRxowOK6Rij+2ZFjEHDrrfp4EAbl9cv40ebUI+lo8t2vYt2+UhNQSL7Y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCPMdTXA3mGjeq8Vdaqa4GAGEsYZdSpYyrHufMlvp6MXI7YqRa
 IBWakn/nIUPrNDFUdYxwHcnHSR0S5aioeJIhoxPXxkoShW7W64+kyPWK+yNRl4O8GhIjr/ClXpj
 W6AaPKn/UrnXfyOaeu3ewmkHVxnCPpYc=
X-Gm-Gg: Acq92OESZYDRLelqhWvlDb3CPkNSJPTZn9R1UPmuf65B/luyXPqm9aGnHex2psGGl86
 lLVWKjg+ksOQQTmj31HXOeJzvcb78vqzIoSLE02Bw1dxbKr+Ji/kgFYT+GQWpViRSmKnm52v8fM
 T0x179QYPjSPdCAWtNkGpgpaYtwXuxefFJW2ls2h/yXiraJ20H26UA45O2RDsrWdvFM1YWqEeiH
 +cQV6nLqhkOucnGRQoA90ahWauNmuVoVq1IHbWeYbrS8+TlOHaBz9uGDkyX4TMuF76CDk4ufqYD
 DzJp0UY/ubudnqk39wMsV/zh/XKf25p295NAMr+DGrvxCxTQ81W1guTsXhMh3R4gWkchpQ==
X-Received: by 2002:a05:7022:11c:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-13436a9e98amr21603c88.7.1778610605675; Tue, 12 May 2026
 11:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260512162711.51118-1-christian.koenig@amd.com>
 <20260512162711.51118-4-christian.koenig@amd.com>
In-Reply-To: <20260512162711.51118-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 May 2026 14:29:53 -0400
X-Gm-Features: AVHnY4KkrnU2wyM0zOOWtXof9uR5ShvVPNBRaDr3qT27ZHX5exKMacEcju21HjI
Message-ID: <CADnq5_MbH=cqzhRSa2oE2HbWWkej5NP+xFQF1VbVDzxD6eiwtw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: restart the CS if some parts of the VM
 are still invalidated
To: christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, vprosyak@amd.com
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 12, 2026 at 12:27=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Make sure that we only submit work with full up to date VM page tables.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 10d8dcc3a972..b26f681527f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1280,6 +1280,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
>         struct amdgpu_job *leader =3D p->gang_leader;
> +       struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_list_entry *e;
>         struct drm_gem_object *gobj;
>         unsigned long index;
> @@ -1325,7 +1326,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
>                 amdgpu_hmm_range_free(e->range);
>                 e->range =3D NULL;
>         }
> -       if (r) {
> +
> +       if (r || !list_empty(&vm->invalidated)) {
>                 r =3D -EAGAIN;
>                 mutex_unlock(&p->adev->notifier_lock);
>                 return r;
> --
> 2.43.0
>
