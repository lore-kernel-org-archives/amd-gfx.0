Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84454C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 18:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FFA10E157;
	Tue, 15 Sep 2026 18:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AcFcJkBE";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874E510E157
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 18:25:34 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c6560f7a84so4382e0c.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496733; cv=none;
 d=google.com; s=arc-20260327;
 b=jvjMt0zQNHXI5u2AG0vbhlr7dctzUc5GLTr3V+unFy7yx6/rtiJpPYFwBovUGCCAyT
 X0jLOoHlI9Ty6K61B1XerQNtPAbIrJZ1J51TJBZWobM6qhau92mx1xxFvJuEk5oh29Id
 p25j0MncSHZYIh9sNRNL2kLATzi/R09SnQwcr23bZTCyarmjn5EKDCSuxsjjEDLkIhwx
 m5YOPWFzu+PH3KewdYJvwyt7vK8g4xwuFry49D+I+fOmDtSrYwNfJxqLV18JAuWY4KfR
 16DySlNRE85YI50mxEqT4KTCN1tDmW8lxuDsIdi8zTk+gUn+jpG5jH/FDCLGmUYOOUMp
 mk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
 fh=W6B3uYSUEz9JSsvhqG2qZVY41QhjtqHTIzpfHrDlspU=;
 b=ZZ0nF9ArGPV29fKpOvOMgwQ6xoQG5TrfUzT9AD9wp2Z6DVMOESTCfhmsQtyjBp2rrT
 STvRWxSyDclMmia72E/99/sqgo/1htGuAucIGY9S0+9RekRVMqBHrvSm10mEU08GW2SN
 C/yfWPmAsG39S4cAP5lTq2Vwex7nXlXpcBA95gNpZQ3N1MnBv+9AxG8QTDgIke1uDhOU
 IZ1H7uZ0sRpj1YNQSskso419PJVFLl8rMDCED8ddDpW7zoy81sry0HHTsEEC9La5Ozqf
 EBQcLy6tjIPahFG3CQe65HExOTSkDHiz1v6qoEag7bFrOoVuH89nHYXbKH5dLfsMuqGy
 qvsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789496733; x=1790101533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
 b=AcFcJkBErRIq+P0kmuuCaoO9iFo4PC2DJwk5jy5dq/8sza83T92N2HX81sdpnoaPPt
 oZL2pzyKGRTyhdcZmFeU5K0Uesv1V3HDAnsEFN17VaZ1bsxqaBEKaiD56OKE3rywlS43
 mgOe9zfnE9zUgcmE0Klr7cNkEltZT/Fqh5z/7at+3g41ZbUDp97AJ/4VWSLXKtRnJ32+
 H+32d66wtXK3a6CRdGF+v9CEDwgPx2CQ4MGbrDNNlsBASJMJthVM98xQdPe+hDxPICQt
 x9MfouoXN2i+tLopZ+08SbtveGCH52zNyV787LHXNYpEz4fLdulqpEjrOP5Ax8rXnsja
 QUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496733; x=1790101533;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=50tFOILj491KGFa/dHyjWyZTKVFZKm8h26V0Gp70eBo=;
 b=uh4BVdST+b4UDMNcU05iUk2EwXNRRHiQnVOhHS4IDrEcKvvv7ovwTf4touI5jTLhIq
 C5op1ghJ6GrkXO4Dc0CC6OIWyTSCQub5WsbXJvCluRaro9dqgVEU2efXzUYZKQkN4yqH
 p0FVXsUNmHJlkDvEQ5Cpyhp+5r5YYnSXN/O1o1fHc9sJqzo4/Sv4yZ+X9lG+RUmPpOIX
 1VdEdQkZ6FY2DDHMAnbKZYALxbu6v7JIARZKlZbuRclfsAVAYFg+MisJLAbUMEm3inVo
 yXb7YJfrYwhQkWq8+x6Rv3AJ/yCAKpVLhq157TF1CEtbT455wc7px86RfZui1avL0A5X
 VhTg==
X-Gm-Message-State: AFuF++lEafpp995zbNijBiYf83sBWdHH2nGrCAYJ09BgjBDz4ggVhk/V
 YTs0O7E3d/uosnvlWMmalToEkOgI9GRxj0xbR33qtpPZU7ynvw8tM0mAt+bYUp/pzBLlwMSnVe3
 ey2irf++RGII63iFz9gGVmNF6NBk4s5c=
X-Gm-Gg: AYBFou2feaErX8Laff6fpOm730jtvpeoPgoCdJ/D4BJM/NwnCbTPCpC6JZSN9sSkPXV
 lT/6pPjsjq97kGC2AdoKLGz8LS6uR9O+agLzo1QYsORyJ2+yPcqEgZUc6B9F1Dd2bfhTy75xkoc
 LSwGLMtNd3927VjNOiJS6fC/nwQv1BnjHA6PLZptbNbcXBheN+VdWEacTvhmIeewVhGvpjKoxMB
 RjcrJWttDcdCOVvey8jRC5EFQmNfJtbAeZ/I9ssWHhJSejhYxRSRj/xajcw4QPB6m2/qeTKmHlq
 YL2oRar3YCKCqHJLvFuE75iq+fVt2A0m9H1LQyK/kgPG7i4iXeQHmvDFx4FnUnth2mMki9ns5CA
 gzR1U33yzp1uwLaHecKshR5fHQM4KTLXxAxj7iF2Y/Q==
X-Received: by 2002:a05:6102:50ab:b0:791:33c:9d1 with SMTP id
 ada2fe7eead31-79b5b2922c5mr3710542137.1.1789496733210; Tue, 15 Sep 2026
 11:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260915180149.2162871-1-mario.limonciello@amd.com>
In-Reply-To: <20260915180149.2162871-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 14:25:19 -0400
X-Gm-Features: AcwNN1XubN3nOJ1hgbvFZZ5HbS76GvuN9dnHhwQ9WI77yqlr2_GO1PuDcPlSjvM
Message-ID: <CADnq5_PpPft_ctb6QGjkghoDJAEbCxLUztgW3dJbQXdC04GhFg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip KFD mapping clear before initialization
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

On Tue, Sep 15, 2026 at 2:21=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> amdgpu_amdkfd_clear_kfd_mapping() assumes that a non-NULL kfd_dev
> has a fully populated node array. This is not true when KFD device
> initialization fails after probe.
>
> For example, kgd2kfd_device_init() sets num_nodes before checking
> PCIe atomics support. On a host system without the required atomics,
> it returns before allocating nodes[0], but the kfd_dev remains attached
> to the amdgpu device. A later GPU reset then dereferences nodes[0]->id.
>
> Require the authoritative KFD initialization flag before walking the
> node array, matching the existing KFD reset and teardown paths.
>
> Fixes: 353f7430d1ec ("drm/amdgpu: unmap all user mappings of framebuffer =
and doorbell before mode1 reset")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5833
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 09feb45584bab..17365cd0a997f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -330,7 +330,7 @@ void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_de=
vice *adev)
>         struct kfd_dev *kfd =3D adev->kfd.dev;
>         unsigned int i;
>
> -       if (!kfd)
> +       if (!kfd || !kfd->init_complete)
>                 return;
>
>         for (i =3D 0; i < kfd->num_nodes; i++) {
> --
> 2.43.0
>
