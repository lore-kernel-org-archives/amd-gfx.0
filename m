Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B064C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 17:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0212310EE0A;
	Tue,  1 Sep 2026 17:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfAp2OdX";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7047A10E401
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:16 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-396afefb35bso11904a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788284896; cv=none;
 d=google.com; s=arc-20260327;
 b=F07dC45NjOymrvDWYEpB6PLFFeGrpoB6sv1uftIOoyZAfQ8MPlY00iMhmtlIm/HI0U
 gmbHTq4WAVlE/GrQWaXuk4PhC2Kmg7pMp8ImkFArZV7CJrn2gbYO3nPMdpOJK3y102gx
 UL4VVXMxtwQzR01+x4/CjkduKTAxRVrp95kZMUXhiLyqcOy/N5LAyM8PeCGgcSybUsLm
 UBUYooDO+K00Y409nv9je9nqecBreHVD+vYWPuLHAZoYWVeHcwM1T5dnbF4tg0188uhT
 GoOfNQ/h+aP21ajwy5IVgvA+e8xfXYCUTAQJYTvhxjehLYHJ5ON1bHQZJAAlPYPUCjz7
 evFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 fh=4GoCfpys1SoAXsdpX3FIQ98QqY81gymXQU3GJ1GAKSo=;
 b=BKBQm9Yc4KT8JHYBF+63rL2i3PK2QpjiPZHNnGioUdHiwRx4bFKVMsRAy0fGC/jL8T
 fdsexnMNqYpMQ2jyIk0tlO549pGh0K+c2O1syUquWr8wUyNSRjQc0rsgRd01CNQJMlrL
 EOupTQFj1cileU3aZ5XWRf+H56OPa3z07cRNnFsZb1F9a/wjHZKHFRB9nIzgME+CrTPR
 j0LWXt+gpmJPbc9Hv4Jt8H91PRmmCSUL1lwREe5nBbxPezqk4SwVgfDKdU6YQHLsHKlT
 S26sNwOQgWQBDC+H926VaVFRJa+LOprvNufqmF+Z5OfX7TpgfjLI5M/cDGe64xwlXfLq
 r8xw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788284896; x=1788889696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 b=VfAp2OdXOox8O51ZqlxCMlqiQWsD3q8xJHlU823ulQuviCQ3Z2BuuVsgcnIs1ULfOw
 bLhjCRMFT8MrwFUiQgQO1l57SRhzOdrhkNYOnAWmYJVSo18cf075BxGI6SLpfIwf/1fw
 ErBX/wS1Yw7Y4NgcEEyh3m0YM9D1CgeSUIYSBLpxMXXDNnWyGfIFEYumlPcWk616leCx
 TUkDKprYgAM4ORHhBS43DqCCqHCnnCregHEsa0GOppCwa4e79s9eZpFr6h+ekmdrM6d9
 O7PLnX8XWJom2IRGJPnIq0YxIgUy0RCzDKxhemihL7o8GTvG58tf9H1xXj04TIrpUuoW
 HN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284896; x=1788889696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcj2MbPf+/703LfWlGvVkcF5hM4WvaFgdE71pfXNPtQ=;
 b=kpASN+mQtCOrtBtmb9tyTanW71D5il9QTfYfJBvvdNZ6q6osbwEXH0yt/Vetv5ikrw
 oBhuWEwUAPo7szRjdoechEkgFGoV6f9AHcsY75/rBeKLllKQfN7mDnpDJ3eNoaCBgvxW
 DTbLxHe5ZaUv35Jt5UJ/QGDXC4qeisUbAMS+F3aUcEBUB30QkmsZtkOyIMvLrsNKWr1z
 HsPxQow6SE7tZAhDIklTgI4Lddp1yOSc748uC1ThScsC63zeuui/0hP7F3l0nawfQ7RT
 cmy8FnlOzEBjC1MG4R4ZpbPfkolqLMxGEKd8Sy8TiBMnudetSXLSTAIB8hmML+kBO+p/
 Kyvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDwdlRjZ6U6OaRTBs4skG0D3GlH4RmL7yws44TUhY8ia3y8huU1hGJis53E4RHp6y7Fg9uSDFN@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/HXszEHuQ8xyqSYqI1GG5Itgl/gODCeKOQODBuf+AAOIX/qKt
 3geID3fkJ03lda3jdUaVwDimE5npM3ieaQ3iYC1VCBsWnL39XSSi3kBcs2uzi4/QtygvXbxxaIS
 IiSr4irkz/2DIvekMdzT05rzN0YIiWDo=
X-Gm-Gg: AYBFou2ONtwgJ0pX11Io2UGswSFB3WtcDf3mOkc2n1RRcZdWbb9BEn7Bm3LzYWPvh0d
 yLJ9tAR0Adf2B1tOm3UTbDTicTNOQ0HAAoFshZ4DmKiIv2s31gG77y8hgIgI5b0A0yJ9mLA5LgU
 iMc67WS/RAV3ELUzW4GCokl58zltQ74lBRFsY+me+NRIUXtlVem3bJTQ1QV263HGnvMHNfWMI4J
 TwpJdIbHLcA5Y5xGEEnsVNoKSDSoAW0DNyEsbjBx3Gm5SmSB1w1JEhZmW02ftXLbhWU3kOn9RdB
 vMsJHFrCt62s/aIroshQA+xBL86P66j9fK5K2SuwbRRsKZYy/wMGiy1UZ0q3O5heNS3WRzW7q4u
 beOPuM1+Bc7o5FC2fTcL4e8sMvzFdPniD
X-Received: by 2002:a17:90a:ec85:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-398bad20e7bmr20530963a91.5.1788284895589; Tue, 01 Sep 2026
 10:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260901072615.522925-1-hrushirajg23@gmail.com>
In-Reply-To: <20260901072615.522925-1-hrushirajg23@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2026 13:48:04 -0400
X-Gm-Features: AcwNN1WcS_X7Oe_rNMCrlpJl5NTeoyfqRDXOQdKoSI1aY_8E3V62TAx7S1S3eZM
Message-ID: <CADnq5_MM-_7FAWo9PLyZzJOHfck_Ya2_vWEGFm4uGTQp446SUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: use kzalloc_objs() instead of kzalloc() with
 multiply
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 1, 2026 at 3:59=E2=80=AFAM Hrushiraj Gandhi <hrushirajg23@gmail=
.com> wrote:
>
> dqm->detect_hang_info, dqm->hung_db_array and dqm->hqd_info are all
> allocated with a hand-computed count * sizeof(TYPE) size. If count
> were ever attacker- or firmware-influenced and large enough, the
> multiply could wrap size_t and produce a too-small allocation that
> the code then writes count-many elements into.
>
> kzalloc_objs() computes the same size via size_mul(), which saturates
> to SIZE_MAX on overflow instead of wrapping, so the allocation itself
> fails cleanly (already handled here via the existing NULL checks)
> rather than silently succeeding undersized.
>
> dqm->detect_hang_info_size is left as-is since it is also used later
> for a memset() call; only the allocation itself is converted.
>
> No functional change in the non-overflowing case.
>
> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 67137679a901..5aa42fd5bb49 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2013,17 +2013,15 @@ static int start_cpsch(struct device_queue_manage=
r *dqm)
>                               NUM_XCC(dqm->dev->xcc_mask);
>
>         dqm->detect_hang_info_size =3D num_hw_queue_slots * sizeof(struct=
 dqm_detect_hang_info);

Can you fix this calculation to check for an overflow while you are at it?

Alex

> -       dqm->detect_hang_info =3D kzalloc(dqm->detect_hang_info_size, GFP=
_KERNEL);
> +       dqm->detect_hang_info =3D kzalloc_objs(*dqm->detect_hang_info, nu=
m_hw_queue_slots);
>
>         if (!dqm->detect_hang_info) {
>                 retval =3D -ENOMEM;
>                 goto fail_detect_hang_buffer;
>         }
>
> -       dqm->hung_db_array =3D kzalloc(hung_array_size * sizeof(u32), GFP=
_KERNEL);
> -       dqm->hqd_info =3D kzalloc(
> -               hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_i=
nfo),
> -               GFP_KERNEL);
> +       dqm->hung_db_array =3D kzalloc_objs(*dqm->hung_db_array, hung_arr=
ay_size);
> +       dqm->hqd_info =3D kzalloc_objs(*dqm->hqd_info, hqd_info_size);
>
>         dqm_unlock(dqm);
>
