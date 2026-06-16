Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62906CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 18:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E332310EAFB;
	Tue, 16 Jun 2026 18:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQ2BhXJR";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD0810EAFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:47:41 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304e86ecebfso380367eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635661; cv=none;
 d=google.com; s=arc-20240605;
 b=KVEVrEvaF/iDaGLG7eb9u5ipQacBnXeE8tEB5V+GfRtCCzFNAbfZszJ303BaHfEtRg
 NE2wwxbSSkPXTlt0sY9/Sn8b8C5PiXKAqs2E4pYvk0/LMZiwcOwtF8YQ3FqN9zX2rmDA
 QWskHwr5zCqTs0wMntAwuLsWxLAaSpXHYVR3eZqbd57mcWFbbZF5+ine9wFwtRg2T0Pk
 UqXGDvlb3TsJHfCXkuyv2b8nNIJAzwehfbTAnGOcWnIkBafLUPzsShDlAcFhaCNGekRR
 dRkNY43p2fwUwILfv4pjLMqY1EM5jURlfZt8o+enz/8RZ5TAMNnHqeaqPT2QeUFPY/Pu
 e/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=chbf1Yf1+THO4a0FQzb5teKZS8AtuQg4HLPK2dstmcg=;
 fh=7yzT6K2nKUYDPXB1vsqv95xGzPCmGn5VMOMiP0a1Wtc=;
 b=FlMCCt/xcz6GsR5ZT4RwcnwCzAYNbaNKDfgLF0RK4x/9F3QyLVKnDw6uc8DKeggppe
 SgIpW1sZbv5NExMAN6gVBsdQrn2PS6XJmwmU7ht74w/gDpMTO/Hi1ezpWAyQriT5/4cq
 lJc5fpCgdIotg/wfg27vGZSP7NAriJLJd+JEMSpq+dHZyh5fuKUFDcQus9BGYadGeKlS
 YCojT+R1qg7wTstKPVgaAZe4Ihr3ARq+7EB86GoGcBDcsOc5nzxbry1yHksRPDfKxbCH
 63ZLqJCg0ZENV7khj2NJw0XasGDybwZJksyDZZEasfTyNzHGJpa+q5ETtlnKIcmqQ/ot
 jXgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781635661; x=1782240461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chbf1Yf1+THO4a0FQzb5teKZS8AtuQg4HLPK2dstmcg=;
 b=GQ2BhXJRRgdhGJ7x/PqXILMmFwIJKV7mkvRUmYlYLIGQtQzG9mxj231s63qgCJrxDn
 ANLrgcRthtDIq38AysmX/pOC/CxOMKztPCEzt5etlTDgmqqmY4tMC6EXsNfGKDpM434m
 7CCGL0PfBUdI8T22cK4Or+M3b1D6S8guvTQVcxi6ejgUk2pGZ10+rF038PY4NpR0yt1E
 3NcXdpUIM7lkVsbqV/kCdoY4jm4mDyeTpjSpUpWAG8CB1KXn9Q0/c+fSkBbB4KqEdl/3
 0nehAcjBk6qn/b+1ITxc/dUTOcKoGMWR8b7j9zmvEZ66EFLvV3f2pAWzMv3gDibHQ8bQ
 a5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635661; x=1782240461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=chbf1Yf1+THO4a0FQzb5teKZS8AtuQg4HLPK2dstmcg=;
 b=K1Sm0syx+tuNPC2KwcnS1AOhi0ICxI+9HGfb2eOhZL/SHhPGtkhO26yqDX5QpIFrvK
 ONxuiluegiqMdezQKlAD08b5p72jXWCgCg+6G0JShS3mrAboB6vbpuxsRg0dwlnNkK1b
 fs2U7L4okYIj/mDRB8P0qNXGNw4Dj83UenLbWeWHBr4kEMzmW+Ul2279FVu8VyeprkSJ
 FVj40WW3r+5JUwwiSzRkRcfQjCYeBG/Gjde1+Ib+ijxI/N3EHkMz7iXXDnXYUaGLhvo9
 HXnY2mVGMN3fYHZaJ2BPm3Zhz8JV6CqZWdLOmUPu0LvxVuZKBY+QwvwadyO7s5vubuMW
 aVgQ==
X-Gm-Message-State: AOJu0Yyu502+vjLyLAxoTZeSCI1NZAeVFcz+pXGNW1jYWCrMMemRpvoV
 jAepnaP1Ojr2c4kJo6Y5H5zvV5sz94Zx/JNw5l/uHa0j05d0j5JKuSzwMXVEicQfjbPUnvWsubJ
 0lpa79bQ4y+mPtBrXWiJSOUaS3dvPNdTzXPiw
X-Gm-Gg: Acq92OHAa2GsSswowwwTctZqrxj10IjB+3D0bLMmYQvqnaCoY4ZkKnbpy52083XWTFr
 RQDpN2I7qhij1FhhwsGvk/ZKHi3NW/I+Ex7JlwDU3DUpRdUqLZjVRJo04Gar/vOg6ZuL7kVRKQb
 4iWUirT+lkjl1dz8QKeZ+I7D3o8W9h7ekUi53Q6SoF7RN7WoTvSQ1E8b+YrLiGrUpbVPdl2S/YN
 Nwo996gGipaya9VdjJZ2V8sqeYUvEFaLSfuaVBRnNgz1CmTkuLslMNv/hEaVNStqMkZmQf/ol2P
 Cymd2ujjtB68sDiLEe4go4+mLttAC7P7agaeaqykLcFxbusOeNjVDv1homGZyLNXRxraAA==
X-Received: by 2002:a05:7022:ec18:b0:138:4a23:a1dc with SMTP id
 a92af1059eb24-1398f739c1bmr31509c88.7.1781635661004; Tue, 16 Jun 2026
 11:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260616020942.18980-1-tiagodourado@usp.br>
 <20260616020942.18980-2-tiagodourado@usp.br>
In-Reply-To: <20260616020942.18980-2-tiagodourado@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:47:29 -0400
X-Gm-Features: AVVi8CdCSyDNtVXCRy1iTMhBBSdi6BLG-KR_3PKYWSVK_tovzz4kO60vlTFiviM
Message-ID: <CADnq5_NiugifcE_p_sQ+X0xG+MGkCOn3Ac7DycFWJYk-D8aMcQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Tiago Dourado <tiagodourado@usp.br>
Cc: amd-gfx@lists.freedesktop.org, luiz.f.f.fernandes@usp.br
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

On Tue, Jun 16, 2026 at 8:59=E2=80=AFAM Tiago Dourado <tiagodourado@usp.br>=
 wrote:
>
> The jpeg_v3_0_process_interrupt function is identical to
> jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> in jpeg_v3_0 and reuse the jpeg_v2_0 version via a macro alias.
> Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> cross-version reuse.
>
> Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 ++-------------------
>  3 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 9fe8d10ab..9006fc57e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgp=
u_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       struct amdgpu_iv_entry *entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.h
> index 654e43e83..4f400fb47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ri=
ng *ring,
>  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg=
, uint32_t val);
>  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
>
> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> +                               struct amdgpu_irq_src *source,
> +                               struct amdgpu_iv_entry *entry);
> +
>  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
>
>  #endif /* __JPEG_V2_0_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index 98f5e0622..5010dafc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -34,6 +34,8 @@
>
>  #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET       0x401f
>
> +#define jpeg_v3_0_process_interrupt jpeg_v2_0_process_interrupt

No need for this.  Just assign jpeg_v2_0_process_interrupt directly in
jpeg_v3_0_irq_funcs.

Alex

> +
>  static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] =3D {
>         SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
>         SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
> @@ -539,25 +541,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdg=
pu_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> -                                     struct amdgpu_irq_src *source,
> -                                     struct amdgpu_iv_entry *entry)
> -{
> -       DRM_DEBUG("IH: JPEG TRAP\n");
> -
> -       switch (entry->src_id) {
> -       case VCN_2_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> -               break;
> -       default:
> -               DRM_ERROR("Unhandled interrupt: %d %d\n",
> -                         entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
>  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>                                 unsigned int vmid,
>                                 struct amdgpu_fence *timedout_fence)
> --
> 2.43.0
>
