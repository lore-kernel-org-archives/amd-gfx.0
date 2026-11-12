Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CA606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJR5NJFh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FAC10E210;
	Thu, 12 Nov 2026 22:19:44 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFAF10E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:19:38 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-70c06172499so36358eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:19:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794521977; cv=none;
 d=google.com; s=arc-20260327;
 b=cZgm8vd95fpxf5EPm1dqWuSqTnv6DaP3aJ1IFb1VbcJ3+pviED1ZDeH8cOSgSHZcLF
 RrbJmr+hsvHyisRFTt7s3zxRn3O4+HmFR6Y4WDKwVVGj2ng1RnE67RMvBKUQIaZqFPX/
 DUWDAbRU7qR02YZQ8A8lKmE+pv8A95YIMn069zRhpqdz8sP0n8SQvP+huZCF8RCcgR5e
 guY8RunczueD3F3R6aiBq/1qamMr3Mo5jEPrXCMJfvl8GpGVv9nA72vPvSdI5XbIFrr3
 KjoJUNv8Q3/6H7drwTZ4q1lYAAghSeGoOm109kXrj+AD9nqnV9cIwLvyxt4qXFTmyDg1
 5veQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NfHBy9nuy/ds9uV2lnACHlDi/n+DP2C34RUR921RaSA=;
 fh=JpavnmbCTeDK2TvkSaw+DXXv8h3FFjr3xvzzG0SwgdA=;
 b=PavEcIbxW+uunIQb0wfzFLQE7l05qjqxi9rWbv12nVuwFJFjvp7axc7L8yn1PK5Jcp
 gLr89fZYSSPfD+kU/a8uHigz4UZ6dFbKzK3cT/++/EnqyEosjuDA1j1ootN3ikZJXV22
 +BuzyuqMlxjqZRXzGoHfYdUcZamXt4cWfji/DJhHVUmwS4pC3l1VCmjgyVu5c804wy4p
 mpB6LZQb9qz1zJEh0LHMj8mMmcW4X/x1vOdtnG6/aqvyXYjbJMcAixaMp32bHE5EKQHM
 6L/ylSoVWWFS/ESm4aTIQMM46CPDUtvpzkaBZ5AAkoK3/J00AVe4PQjEnqQmK4kher2a
 2xAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794521977; x=1795126777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NfHBy9nuy/ds9uV2lnACHlDi/n+DP2C34RUR921RaSA=;
 b=cJR5NJFhSl6AXCCMEd4OiFq7nyylK6zfqk0fbO5NqdOinCcm1sHE4GxjdNRnqehHGA
 x2c38IdcoMlTdwve3jj8jeNg+GPKz80Os7sTXIlVeilPuWuavckGnZwO9MxRtuUEUuGq
 3URSQz3R7tYU66psC/9hESPPbb6fJPdH/nl4ICGIkj+/JpFd99n/2TsB8X0LqvrGps80
 udg8mutLSnY5LXZYnd/U0sfiyfLTvseSL7MMV1O9SP+eqhS9olkVBPWQBL2ib+NynxUB
 j2TbF1rWb3v5g1fpH0uUOqoWKjsi2bgBOgzSM2sz/ppglmRJVRViuP8jl9iYZDeIoPbz
 UzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794521977; x=1795126777;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NfHBy9nuy/ds9uV2lnACHlDi/n+DP2C34RUR921RaSA=;
 b=lSn8pfZhXngDnzPGCn06MIL/iNovm3P4pQOMBFuLyG6dTP8H+BeyWam1pCbABPxQUI
 VY24VY8TxwBwEBInt4+nIRAZdFZLq9gCtsbNDptKNyBsaj+8LwKa5aMNYO6lQxICrcAj
 aZ1NKSFBdZ6Rq/b4tbZL4Wmc4BnL4m3f+6t0Gtbm/xq9zpgf3HOB3pSMUglktOuqfhSH
 +RGkEAS+bJBJGmbvPb8W16MHKpdYm7y1JnMBirY4PeTo0KrLpp+xFFUQqoXWuJF+QRSF
 xVZSEKvOojl3jWElaRfmAwLjhIMjJFogEIM4GMMqZUGP9uTPbpe561hgWHtSbH21S15U
 pyZg==
X-Gm-Message-State: APuU4Z8wOmHGEHdnrY3grNL1RCdxDInO071pV3eWjIo/6jo6MnuJ1a+F
 HgZzG7JFxwykBtTqE4CPTphibUCRePG0dZEW+OO8N47NRxEE6nI1/WAm6XwhDuZGKw4Wp90zfrl
 JWI9waPJamXCGIERXqLEZS51Z+TB1Hbk=
X-Gm-Gg: AYBFou0RNJjrgvXuEeUhs8E9u1xNm1AsGEDUN6sqoMDbmDkNtk3SerrT4jPvdgCTxu1
 2h6LOaI1Tsqsr+osiHczpiMsVffOPY8g7FulJLZE1pPnNy/ulw3Mng0Bt/taU4xWZW9uM4Z9+UV
 UTDgebECVNchBLacHxoJZKD8rsLCIUT2y5S+QRSsqIHAi0QjxZ1YeC9TOayMvi8nRIPhA433242
 nJMME7HC+6pObSWuKNra7UKokZ0fFrVHkrmAieHix3cTIsktupBb0LbvDAaPbXCE6Ut+pKXQzTv
 G1MHktf0YZyk6DpQ8J69CNSwW8Juse23S/dZj1mB9aSI7p57GatqSwd0tuID4oIGeEOX3fz7Gq1
 PBMoIjSB1Cv1clMHqpgTJzYwmpYx6zBS8zuQNycFZgld8DxogJw5WQ+YESH5sfaiYIY+aM0W00b
 sfEo99W16JkSatJWt7shMqK6ixDCitFmAsXW+7PgK3x7lE0RahOE5FdCZ+HPg=
X-Received: by 2002:a05:6808:1914:b0:55b:f88d:baa5 with SMTP id
 5614622812f47-56e66a9517emr830012b6e.6.1794521977634; Thu, 12 Nov 2026
 14:19:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112114049.327046-1-erhan.bilgili@gmail.com>
In-Reply-To: <20261112114049.327046-1-erhan.bilgili@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:19:26 -0500
X-Gm-Features: AclHuK8ZVA7RFhlMt7SeuAO29LjhUGaLQmU2GgxRNjKdE9wsDo3FSKBw_BCzaAI
Message-ID: <CADnq5_P2MhHx_j1WZ8ynVx6CRtmNHzMDRPxFS-F0kix1=7F40Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix UserQ slot availability checks
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, jesse.zhang@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Thu, Nov 12, 2026 at 9:06=E2=80=AFAM Erhan Bilgili <erhan.bilgili@gmail.=
com> wrote:
>
> The compute and DMA queries check each other's disable_uq flags.
> When the flags differ, this can hide available slots or report slots
> for disabled UserQs.
>
> Check gfx.disable_uq for compute and sdma.disable_uq for DMA.
>
> Fixes: 78d0a27ae0e2 ("drm/amdgpu: Add user queue instance count in HW IP =
info")
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 14a72a406d37..c026a07bc050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -474,7 +474,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                             !adev->gfx.compute_ring[i].no_user_submission=
)
>                                 ++num_rings;
>
> -               if (!adev->sdma.disable_uq) {
> +               if (!adev->gfx.disable_uq) {
>                         for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i=
++)
>                                 num_slots +=3D hweight32(adev->mes.comput=
e_hqd_mask[i]);
>                 }
> @@ -489,7 +489,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                             !adev->sdma.instance[i].ring.no_user_submissi=
on)
>                                 ++num_rings;
>
> -               if (!adev->gfx.disable_uq) {
> +               if (!adev->sdma.disable_uq) {
>                         for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
>                                 num_slots +=3D hweight32(adev->mes.sdma_h=
qd_mask[i]);
>                 }
> --
> 2.56.1
>
