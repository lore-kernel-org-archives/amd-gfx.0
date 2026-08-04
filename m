Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11597C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 15:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5141410EAF5;
	Tue,  4 Aug 2026 15:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SoVeoNx4";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8573A10EAE7
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 15:11:59 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso259051a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 08:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785856319; cv=none;
 d=google.com; s=arc-20260327;
 b=Dl4LAnpEJnGEx0jE3nc6H4jcjNnL/WujUcitSKe9Za2qm85QMa+TSxgQ9FdvtW1KNP
 OOFD4Q2wd3Ub0RKVUW4PpjZCIms2GMM+Fye1aolDKUuh6gnZuIkb9WWl4+iOBA2YaBuA
 DTQrusfOTQsMuEDXmnWVOnDawJrLMuu3l4tx4I2wUyqowWTn/fmnHbdEeRUpIaodyDjV
 pJjKSgylGmxa5GM7YtO/iPtkxf1K1/jP+KH9rhWDMf8uLowUQgxvIx9E+HEPuPJDc5ey
 xUGpcgW64uzFmZZdWD774G986+EGozbjvjBA7dMCRSflFKKcdVP53i1Y2G/brRWUdRnG
 tR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J3vy/wUCe/+Um8hcMO66uzIkZ38e/WCFLEqWrzviJ5E=;
 fh=mcOVARA5t/1cO+Jk7wQ755x9Gtliv/RVf7sw2tikS6c=;
 b=iw3GYCAK46uAmIdqDzhzmRNSppxZz6wXQaBWolR7rBJveWDrs4YpwuParSZFxd4aKT
 o4FnliYZyq7IKexNDhM3KACtDqGZjHJdtrDmps3yBXcEqx9p5a6LoStimP/dkVofBfsA
 PoOtYs5IHuPQUE4mDbnoR6Am57oht2/uz3Zf/FRJIFkE5HeXGEmZ2zXRVYfKZeFK0evX
 rbQdreC/FNjK+CkIRLDHb2GBQbbquRnTsUmG/MEJS45p5dd/MySpi0Alhqoqcax8TWxg
 vl5aazQnrxHOZ2l5J0142iO0Sf/zZBQ8cLgdJsICesiGTG8BqZlGoOr2VxOfpUh3tmnT
 N8HQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785856319; x=1786461119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3vy/wUCe/+Um8hcMO66uzIkZ38e/WCFLEqWrzviJ5E=;
 b=SoVeoNx4PKKeXvudWRVd0iKVpoZeOlBh0Gzj+12os1C1z4yPASyo05+4a4xMnMtM/8
 NsoW8NF6NyhLWHTUWDqXWGVjf6OMUUc0ZiWoeqcpcoPC0VRoZj76czhSA3L/yVUajKPD
 2aqhMQQjVIPwu0tvVuhAPO+nr+lKLVQhT48Dh81dBbknfyVx/5+xdMOGHknLScXqmnvy
 xPlGo0zjjzoPinfqiTiQ7BBVw/KDKYoXCOaaq4aePxq09mHVw6Ptc8pPK58614aX1cqQ
 F59SSq7b7adHqQJQ3aHYrN/rjraKz9Zlw7vzEmG/a3z/kiPeRBnyxFAFYeOrexvkJKVI
 1c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785856319; x=1786461119;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3vy/wUCe/+Um8hcMO66uzIkZ38e/WCFLEqWrzviJ5E=;
 b=WJn3ePxhWWb10o+M6s7DzsTWzfDTOnNzk5Vv2vcy/isOIENMqtntv2uNZ29AVPaGUD
 fykuIjL9rl78sn+12Hl8SY4uSHMR7pCNe1Nr2SLQ2GBFDEkFFBbqeQOdilwo8vQfwIoB
 nNkLQtC0n2uXQXZ+S0xxiZdGkdR/snn1JXti5iVJoflETKnDJiwAmRHdMzIBNzbDo2e7
 eMtWAQ4aj0e1OurRh9nQRKLLeqKKN6CZH/X9xtTRSxLsipI2lbAiXCuWygtvwXjBYR2h
 epjxDNc4Dr3/tO1eKD3L4Y0Tp60krYKsJ1AV6LbkeZu/iirIYo7Ql5EPLU3jwUXJC8cG
 HJtg==
X-Gm-Message-State: AOJu0YwlX2qhiXxA8MCift1VwI+Cf7YvyTjW+BUbDzqQQqZRMztHwdMQ
 DgCOo51HVCoXeZ9XR1bt4PMHN97n4rBQm2GNzwRcWSnkwTkDzkEyGpuCD3k8wiQe8jtac8SfQ4W
 hkqnCRp67cZKSyydNcykNlX+y0IpuoCo=
X-Gm-Gg: AR+sD12n2pT6YuK3C2yR01hAF3uM3bfjcARJ2n/Uxf9NkVuWDCqqDLc+NXOeCw8Krio
 mzUB0DZLRiDlWsph2pIEavjTi0c+e+RQE/KMwm6Z/aI2+J17Pce3HqR1qL0Syfh+fo34E8oPO8H
 F735MVqmsMdj55Xhs4qlYjUFhXsgpd5Ko/Sk3fat1n7D9eSbJW5AhEjGjOOZP13XrtGfHsP455M
 iZtrqzvhxM4plPhD0KwlBQCy5UdjD8fThCMj5KZiT0bR7Ux99cCBmUzqgi6eYW5GjryByjBIEsW
 DbsTi3KyeqsoWbRp9VEBc6NQetIwSmG4VmjWicmdgyn10myId3SEvwswSTnT/lP91Cq5VvDFTgJ
 ah710XpMaspfKGtLizNzy0mLIE/IUZwQ=
X-Received: by 2002:a17:90b:562e:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-38fbc4ad251mr19153829a91.2.1785856318637; Tue, 04 Aug 2026
 08:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260803132309.36326-1-timur.kristof@gmail.com>
 <20260803132309.36326-2-timur.kristof@gmail.com>
In-Reply-To: <20260803132309.36326-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 11:11:47 -0400
X-Gm-Features: AUfX_mzFoQ6o1rgBDH2LfgMCqRxslKJI4SvHjZcRZWs0DnEopkFxSqMjivjZi1A
Message-ID: <CADnq5_ObkWpxABbDk4EGho9PySsAq58nt4_ZmNSc2Q7PTxeaZQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/amdgpu/gfx6: Fixup emit_cntxcntl()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
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

Applied the series.  Thanks!

Alex

On Mon, Aug 3, 2026 at 11:13=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Set bits on dword 2 like GFX7-8 except load_global_uconfig
> which doesn't exist on GFX6.
>
> Emit VS_PARTIAL_FLUSH before VGT_FLUSH like GFX7-8.
>
> For reference see old PAL which explains the bit fields in
> this register and that load_global_uconfig doesn't exist on GFX6
> and also see gfx_v7_ring_emit_cntxcntl() for the GFX7 code
> which this commit follows.
>
> Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for=
 si v8")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 28 ++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index cd2a14ecdba8..0cbaae73a0bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1882,11 +1882,13 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_=
ring *ring)
>         return r;
>  }
>
> -static void gfx_v6_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
> +static void gfx_v6_0_ring_emit_event_write(struct amdgpu_ring *ring,
> +                                          uint32_t event_type,
> +                                          uint32_t event_index)
>  {
>         amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> -       amdgpu_ring_write(ring, EVENT_TYPE(VGT_FLUSH) |
> -               EVENT_INDEX(0));
> +       amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> +                               EVENT_INDEX(event_index));
>  }
>
>  static void gfx_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> @@ -2997,10 +2999,22 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(st=
ruct amdgpu_device *adev)
>
>  static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t=
 flags)
>  {
> -       if (flags & AMDGPU_HAVE_CTX_SWITCH)
> -               gfx_v6_0_ring_emit_vgt_flush(ring);
> +       u32 dw2 =3D 0x80000000; /* set load_enable otherwise this package=
 is just NOPs */
> +
> +       if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> +               gfx_v6_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4)=
;
> +               gfx_v6_0_ring_emit_event_write(ring, VGT_FLUSH, 0);
> +
> +               /* set load_global_config (load_global_uconfig doesn't ex=
ist on GFX6) */
> +               dw2 |=3D 0x1;
> +               /* set load_cs_sh_regs */
> +               dw2 |=3D 0x01000000;
> +               /* set load_per_context_state & load_gfx_sh_regs */
> +               dw2 |=3D 0x10002;
> +       }
> +
>         amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
> -       amdgpu_ring_write(ring, 0x80000000);
> +       amdgpu_ring_write(ring, dw2);
>         amdgpu_ring_write(ring, 0);
>  }
>
> @@ -3527,7 +3541,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring=
_funcs_gfx =3D {
>                 14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fe=
nce, vm fence */
>                 7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
>                 SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v6_0_ring_=
emit_vm_flush */
> -               3 + 2 + /* gfx_v6_ring_emit_cntxcntl including vgt flush =
*/
> +               3 + 2 + 2 + /* gfx_v6_ring_emit_cntxcntl including VGT fl=
ush */
>                 5, /* SURFACE_SYNC */
>         .emit_ib_size =3D 6, /* gfx_v6_0_ring_emit_ib */
>         .emit_ib =3D gfx_v6_0_ring_emit_ib,
> --
> 2.55.0
>
