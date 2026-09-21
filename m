Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E936CC982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DE210E770;
	Mon, 21 Sep 2026 21:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dCmn+OVC";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0964210E770
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:28:37 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so659149a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026116; cv=none;
 d=google.com; s=arc-20260327;
 b=e3vejuNRgS7eUcPzusKw2+dm/bHJVEfLhf5iflk7UMgulSCBm6gHJG+VnFLw53nlYe
 EoDzMC/LrcVKlZ+m53zyIg/sy4LoGxpiZS4xR6GF0ySUCw6jLNBE36nw2XqwplwX7jcG
 0E+/ScjgOu/uu1mclhafd0J2bf8/k1arERUooOASfyR/7o5jqxcLB6HZVE4c4hVM0xY/
 /XoPWtzOJmUMsYQx4KyfVDZ5yZeFXbM9CMah1SyFM0Akaie3PsZhS53EibSJSY+Pf8PW
 qGhKguv9juvzu4INeXnX+3gJeOdcgTdMPt26Yy5FgxKYxJjoUFO5l7sjdxPPEGgm7uPx
 ctMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W186nfxlOO2gE6dfsLGd+t0KMOBcakcQ8EWrYsulnJk=;
 fh=QGorB5rmOBMZ7omrFRbw4ryTP0XS7z0IjjEFddjD9ag=;
 b=saYQ6zh/mlSRV1gmNMIauKiu4kT5el6DRPdXCVeLBC65BCPeY0olaDL47F1IWTJYoo
 TFgqYMWc+WCuqMNSFBarH07AILZw4Bsu2aCAP5mefa0n+/EvPw8Yy+hG5GmePeTj37Dc
 KbKxdjIlMY20xbh9paXRsWT4/jHLWbgear539rCqMwuQqsZnqlzigwUcUogKUURcfVwB
 6atB3gYKAbdDLXKKj27GjnoUZEMk073Uv+COvxrIbYBMZh7UW2sL9XoypI3vhPtw4i49
 Ej7aCuUrIoVyrrHEvMvJUAIG8esAx7mR962n+yieGX3rxgJt48NJqMqQ+UZK6y+qZeAS
 n4UA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790026116; x=1790630916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W186nfxlOO2gE6dfsLGd+t0KMOBcakcQ8EWrYsulnJk=;
 b=dCmn+OVCGOsLWfvs9wuUPx7o6jvGJJ2l7QRaJZc0H+r7vwnlyrVCfVKM6XQ4lhPjbf
 z4Ei1wjwD/lKUSB4C5a8yfPaaF60bmGa8sYllsscouYbcvJq3HKU1Oj3arAGwpQYNnMM
 90zJTSDQ1efgCY1HqFkFFut0iuHSFAXkoha4Raj43r86v0zFUzJJituKoiF7vUh3c7GU
 GGxR6D0EiIEN//OpLSLUZzRVyGeE70t8P7XiHh5b2k5x7/HLIO09dJkG0vLEUzRREYt8
 vYakSzi9bdbXrrlzysHV/eLhgL0YvOJmEoA4/bXy6USuVxhOGJu5dqW7aOMRBByro4TY
 GO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790026116; x=1790630916;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W186nfxlOO2gE6dfsLGd+t0KMOBcakcQ8EWrYsulnJk=;
 b=MwMNjODUZF+Z/Ha8PrMxQvCwK2xYlxtTYoMJ64EbEKwaddGyt2v4g3tOYp0N+mlPt5
 v85jEyM5TasAhN+PBAqAozmkBO4COvhUBff16so2pmavtDbIjTcYbG7tgSsVmEJMdGO+
 Cu5cQYQ9ucLUYOi/6kU0BSLaXnUQl8blBtJbeNcQrFatvWjwuSVAOBstWvziZrivE5i2
 cdNDLgMMEcsZZsQ4/nii927CyioY+a9aYjnGPW3igQsCe2YOMPqqPT5EDSTMFyP5J0WY
 DHGh3tvVQ5vtHCnUA7hBHq0+gNrwH2WrXf9PF3D8IbiCLu75bgqMsf8BEk2vpELfZKU9
 mcTA==
X-Gm-Message-State: AFuF++l2fb8la/iWGILOPiLVjYeb1JGM/13DP7QUn9ZD0MQ9Z/tIev0g
 8RA/3+oQG9Ox3S8MHkQ1IkzlmFYk4RAmLGywEbIXyY9CcpIaUUkAEwdZI3vk3i0hXRmx9GSRo2c
 5mUuv6dp5XWb3B1QGs3RIBqXFbvuwavA=
X-Gm-Gg: AYBFou1qErnh7vdjEi2vRFWIG+iQMvNUMSDXmeg7aevFLVLwhh2lCzRhuTJIahx0EJ0
 PlsUgKKjbPJMqY6j6CaQuPE5qp67nt14mhg/Kn6t4ilxuuyubUit+nrqJXn553i8Xv8QXh4pvdx
 JiDYfMYL+8+K1WEZzVo/SLVqUjHY9/5W2GXin9f3XbAfB42Q0H7YujnWmln48gNH99fj+tT8Q4X
 RYL8AiRDjQAupZTknUVzer50UMGKmtE6kd6Gt0mZQujRkrJy18sYp8VLKA5nLry0Uvk/e94ZYOZ
 v/Xh4eZbbFO+nwdWuwlryC7FEMEo7DxsES/ILlCe2cncif4vgwV1+BdIkhHkc9EL01+BHbI5aSP
 tqFO4AL2ieVIz5o+RBnmNhr/68Kvn1+0Q0w624RbwCA==
X-Received: by 2002:a17:90a:2ca6:b0:39e:6f26:936 with SMTP id
 98e67ed59e1d1-39e6f2628f5mr11684440a91.3.1790026116465; Mon, 21 Sep 2026
 14:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:28:24 -0400
X-Gm-Features: AcwNN1WaLjUF_7S2zYHAQebKIH5Bz1lawcj-WF0Oxhsg5BelkZ_P_l-3jmJ-_IE
Message-ID: <CADnq5_OT9cOZLF-uXWfGg-cFPpZkod3KTg=8EeyZ6BedVj9QKA@mail.gmail.com>
Subject: Re: [PATCH 01/21] drm/amdgpu/gfx: add a detect_hung_queue callback
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Lijo.Lazar@amd.com,
 Prike.Liang@amd.com, mnovales@amd.com, Jiongyu.Zhu@amd.com
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

Patches 11 and 12 look like bug fixes.  Maybe move them to the start
of the series? One small comment on patch 15.  Other than that, the
series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Sep 21, 2026 at 4:11=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Allow GFX recovery to resolve a doorbell to an HQD (ME, pipe, queue)
> without querying a stalled MES scheduler.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index f5fb2e585e8a..a158b7f71b2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -373,6 +373,9 @@ struct amdgpu_gfx_funcs {
>         int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
>         void (*get_hdp_flush_mask)(struct amdgpu_ring *ring,
>                                 uint32_t *ref_and_mask, uint32_t *reg_mem=
_engine);
> +       /* find the gfx HQD slot (me/pipe/queue) for a doorbell */
> +       bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbel=
l_index,
> +                                 u32 *me, u32 *pipe, u32 *queue);
>  };
>
>  struct sq_work {
> --
> 2.49.0
>
