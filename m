Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B384F483E3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0F910E431;
	Mon, 23 Mar 2026 19:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q3CE1atH";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659F810E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:03:17 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bd801b4078so307934eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292597; cv=none;
 d=google.com; s=arc-20240605;
 b=fFx71xqOS+atfaBB+43BQoy0xfjIRJghhggERCHnGWwOZsP8FrgGq1kCiRpbcF8xDa
 n7tVcY+wDi0UzHFbc3OtiVVln45E2ZcTFm3EBpGzxYLlk4uWOMiSqnzdzDlVQC5bVkSz
 tI7zYrQ7hT3XSQ3ht1e7+eS2EZkhO1UQrBVAQmjRf2HVWNzoz4AiLWeGeyvupvg0q3iy
 6Svw96MlsisnymCpTV4451bWqmwXVyJYypJikVDLDmPE0EkvwBuaT7PR5fYpU1bLRRkM
 /+OxT+MQP1Es//KsXU7ILVbeLR9/Gp7/y+OinxAdYnSDIdcXX44D8awm2iCaAss8w3le
 DlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CygVWq1TKNFU7hfnfe5pZMEXQwi5S6I+OUgitiv9KME=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=CGFAbrpCYWhVMj469za3gw3GqYye4eMqx22ruoLYvdE3n1Jw8O4sSd/ztzAkBkq99C
 ZsBMrrN7p345NBbWbsfLnnse2aCj9ItfY/iUWLB0MgHPhRsyJc6lp/q6znMOqobKUMeG
 zThUp8GHSAVnNCI8LOocMZZfPPFXeLVcT4wqmFkDvNlLLARTHCbz58lIu7c1NUquCwpG
 Us1SBH+pQQZQDiAv6KibBp2s0LFsO0BBiICUea0OyjNJ6L7ElVnBkna2bMzCw3j5wV7j
 5C64Nzr+eDOeuPi3iWx5/viiPLIpQpgfgFkMnOzJcx4pKTIxF3YbAI9qdOcZ/jtfp0Y/
 qUTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774292597; x=1774897397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CygVWq1TKNFU7hfnfe5pZMEXQwi5S6I+OUgitiv9KME=;
 b=q3CE1atHguLbdd0m8DB+1LNnu+NB/JSfknlwGlhTgycudSmD9Qq3ySclmREadKoYTH
 N8YDSQtDidAOv/FIQ5CW8xd1LVGot/DH+rPRFdEOba0EuTANi6Ls8/Cq7POJC27bDphL
 UAGSg1uy63l0VoHycNrKaa/1uj/UKunBlYnAJ5djl/2iQTMCE+TWRxnnXkZ2RF+909Ii
 Q1FUSjIaHuNBPcfuLLQ426dh3RtpoYd5Lo7HqitCkh/+CWBfaNDZ+aeUmNwBGsa2Isgh
 hN8DHe5fB6MLwntusxEtU9rhQjI8iEPKJ/Ih5+K9PvMVmq9TNKQ4G7NVsGsWN2Ywt+/u
 CTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774292597; x=1774897397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CygVWq1TKNFU7hfnfe5pZMEXQwi5S6I+OUgitiv9KME=;
 b=HZ2xhqGl2jbzMlYVx7mPxhEXdU8KzArUG+7NWiXUSAELAf+nCaXuKGfOgs8LqrcfUP
 ucqXmH13sf/YcTgP9TOW6tL6TAQ6TtM1W9evzQP4YrKsZQ6tlBOH+0ymY+8hmFCROK9+
 Y8obL4xInjWw59mhVW3M8LwE7hugbcL9kcwF7HlT8dzru+uTaMEpa7s9AlkOxYGMEivl
 MJqJpEVzGNcrt9oIFh9bM11uWIyXCyShMue2HuEhPSKAEEH+P7wt59633P8KH3iP0PDT
 KpulQ5F4IMiCh1LonXr6naQufSrrWQp5R+yIXjdPFUnvY5Srb3dhA4TDpb1wBOTxk2lq
 BWKg==
X-Gm-Message-State: AOJu0Yy7hjsj14YQtyXCoxksOwJKNu5DZnls+5HLHMiDlJCbsn9QccHI
 GnRI2fb6uSTPacYEgr0QO0Bnk30M5fUi4XHfvPsGc3p5cMHDh1pz/FWG8Pd8WeIOC4lvzYCO9FB
 jhrPqEmaj4WZ++gIkZBTgBX2c7WjO+4o=
X-Gm-Gg: ATEYQzy88Un5U9fGT98PbcM7oJx+82xjxfgZvXiGhqkpPOxaQunZf+S4N/B9rnPmmTP
 Zzhy+WuOoatF6RB4sZwqDEKFLnhNomtOseURDD1Dw1/jcQ6txZHBeu6khKPkgmOARG1+8VElgp8
 5dq9RjXM1eR8/Mmc8i3pdCRM777GefgNmg3n8T7arJ5HRVPA+TQDjupCkOLAEze7wyrd7j3a2Fi
 910ZWaBcLVUCOOk5gi0bcIsC4M9V7d6zUxpshy8/Wy4Er64g/lVrNG8vOzRStCFKEQV2I6QnXr7
 e0HBMWx3mWSYXbryMM+usC0AnqtoFDd4UliG7OIEQxYF00aQLmbXE53VDQRN0bKDoH0wtMfN21T
 mB5mq
X-Received: by 2002:a05:7022:792:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12a72651381mr3070544c88.1.1774292596541; Mon, 23 Mar 2026
 12:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-2-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-2-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:03:05 -0400
X-Gm-Features: AaiRm51mEtWx_zxZ4kj85zrM7MBomLsyVkTqrTo8cG4X2Qbi0bdndC0fBka-fiE
Message-ID: <CADnq5_NfJbi9OSdGD9Li_bYmoz9dZEUaGKo-eiUd4vkNOKhHjQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Fri, Mar 20, 2026 at 4:02=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Same as compute and sdma, gfx_hqd_mask has been initialized properly in
> amdgpu_mes_init. set_hw_res should use those initialization accordingly.
> Hardcoding it causes the mismatch between driver and MES.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 5dcc2c32644a..70d80c2aed52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -633,17 +633,6 @@ static int mes_v12_1_set_hw_resources_1(struct amdgp=
u_mes *mes,
>                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_sta=
tus));
>  }
>
> -static void mes_v12_1_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pk=
t)
> -{
> -       /*
> -        * GFX V12 has only one GFX pipe, but 8 queues in it.
> -        * GFX pipe 0 queue 0 is being used by Kernel queue.
> -        * Set GFX pipe 0 queue 1-7 for MES scheduling
> -        * mask =3D 1111 1110b
> -        */
> -       pkt->gfx_hqd_mask[0] =3D 0xFE;
> -}
> -
>  static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>                                         int pipe, int xcc_id)
>  {
> @@ -667,7 +656,9 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_m=
es *mes,
>                         mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                                 mes->compute_hqd_mask[i];
>
> -               mes_v12_1_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +               for (i =3D 0; i < MAX_GFX_PIPES; i++)
> +                       mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> +                               mes->gfx_hqd_mask[i];
>
>                 for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                         mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D
> --
> 2.43.0
>
