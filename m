Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B551C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 15:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932BD10F676;
	Fri, 14 Aug 2026 15:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zjr2hQJk";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E42810F676
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 15:31:39 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-977b52f0659so24947241.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 08:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721498; cv=none;
 d=google.com; s=arc-20260327;
 b=Tp8AehEQ8DitrdNNQ1/vvRLGTczz/zpQlXxRshNAz3O2wv/Ofc2oF507PR86YTdDwO
 i0EF5CdMM15lSBqcPcN0TtKXoa9PRstkV2ee/CWzvVNO16nUtzdSMKUSC+NpIuiqXp3E
 bIiVq6JO4TqLLFQPQ7EnAqwE/iTlpAcsJ2lBORiCRrGCVp905WD/lmv/SkJAdNZtiVtp
 sModqWao8r8qQnKwxW27HOBxoZwba0fJLPSe/xYopoRPYgKlG2pIhbCVGZbTRqIXmGB7
 /iynRed9IMFKfOeGu8X94XO+xLsuDZRN72RC2a8RNv/F8OVAJypqDiyoBPQgb7UZICzp
 o+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mNG/s0B5/RiQPVIG/2/890LkpQx84Ff9oWL0pXyi+zg=;
 fh=sjBhvESLaW/EhyR1JeRMPVrGAZEVhivFcDDWAoTEjJE=;
 b=GWBaZnsHIC00OYD+9PjYsUfslqc3XPehLfEcPu8rXwWJkIM3EayM6BTnZ2yZJsyzTx
 WKWAyeopjRtj8olgkSm6YZv1eB6NO/ISXPDjnozZlLC3FdkNCfJDJMKr3WJ7mRFy7eFs
 3O8Ba0LCSrfev9OLM0YaWuvH0uMOOcqiXGwY8Ix1tnH5VZyTVi9c67XBnbR+nxaFEBlK
 +3YSWEeXMlR72PeJNsxOuyFV3eXPWlSvZVkEcfEA1ojAghNNMasFRMXBj5DujEWcDJCE
 WUjJ9fI1ouU0oGv/8t6WpH+G8k6ZcnDMkCelUi8faISzHwaK+mkvvD6dZznzqAXF6ZAw
 bgtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786721498; x=1787326298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mNG/s0B5/RiQPVIG/2/890LkpQx84Ff9oWL0pXyi+zg=;
 b=Zjr2hQJkudddkueYvP9qdOMT1Lm9FW/PWDXrsWmyI3VGbkEvX+g4jAF9L9M2qK7VFd
 VlCQFjyX9ezCJMDXnzDLeLB/1TOJT64PyQ+dlC+ZTYBWq7UN1ovWKTxGlENSJep0Ykyd
 Pdy16BfnB3Ao//t07wYonwIHCa7yHIUN/7dHvpBfqY2ALIRrUK8og4H4VM1wiEMZYERD
 qBI2gVeg4d4t2AvDwsEVem0HKO5y/Gh+0XhtSMEkeEwHTKvW2b7YvBrvvBtSUWQQk7eM
 Q7w7A9OQWWgAqydPT90dtL1PhZ0KvF832Ii8DoH+bskNhVHMV0UaRj59bdPfQGVbWQG7
 pngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786721498; x=1787326298;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mNG/s0B5/RiQPVIG/2/890LkpQx84Ff9oWL0pXyi+zg=;
 b=WVXutKau/js7N5GqxmkJ0FJapYk80zvxy+iu80u/jWPdT9fIs71Zw7CF9M1sV9t8q1
 MtvtfgWGLs23EInd+ZFV5KnVtlLpgnJhda7b88E7ecFElICvjGDlpjnIxruoUf0QHKi4
 DOLGiHtZYo13yLP9OMWnDtwcQm3HzSabhE6KhoLSZqfzNufUkDWoXN6m3N3AnvReo0xW
 C3nVw5wlZRQJG/+ynU5JAKMtTUoF1/aAdcRlxpwZzHFAfhox1XrjYJ0Mdl17yGlPBVlm
 P2F8HfpUH7lLbFx9MRn3YsRACQhKBXVFyfxe+br0ZlfpcHjfgvim5EzXEjyCHYl2DuDw
 9VSg==
X-Gm-Message-State: AOJu0Yw1Gx3vXI5ihPzOylwn/4eetqmut+4wbgfLbiQPrRReh0HENrAX
 ak3PvEhkctEMwLqTSKUqfVd+ct8oSNyDkmK1JFVajqOi2c0xBFREUrpHiinlSsZYfubXHEdcYao
 tanpDWxjs3BfGW6oyMM4wXoGuIL01bfA=
X-Gm-Gg: AR+sD12kY3Sw8jjTrz7HJTR8vUpwLxULLwo7yyi7VGCxTM8dqmqT9tFrQ7WnFrc5iOl
 Rccw99uZYcNOonP7Zo3j1x06v2vYQ6TI3RqZt4ZdY2wpp/OBFf+Oii2GoOQLlHQmE7yDzVtINqD
 UGBNsuJp65N6m/UJBS+Pfl7u6a+LaxEj7cKiIS5MxQZiyf2tIHLeiSOgn0ANQZpiOGLhuO5rKR6
 zotTi/ineAgQN+YsUUf9uaAIjy6DowLa8KpiW8ScRIGq2ecjBG90Z8MPt0hBTt7bWHEzNXi2BFn
 DP7oxUK8BTDo5Loqi2IdSjifcljbgyasUEeJrvnM/tW6k5F2bOf5HuU5NjTl2tzI+XM6u7pjzNN
 UORWUDDpsCb9K3RMCEThJD4Wc73Ob0jQ=
X-Received: by 2002:a05:6102:32c6:b0:633:3bf6:977c with SMTP id
 ada2fe7eead31-76f2a2d3455mr524414137.1.1786721497925; Fri, 14 Aug 2026
 08:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260814145448.11178-2-david.rosca@amd.com>
 <CADnq5_PL-XC6_Y2au9OQxsD6xRm4dYqPX0xGh7PeLkHHTDf0FQ@mail.gmail.com>
 <53b535e4-c078-421c-9dcf-930220926465@amd.com>
In-Reply-To: <53b535e4-c078-421c-9dcf-930220926465@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2026 11:31:22 -0400
X-Gm-Features: AcwNN1WE7LAcuwh4T97k0qKEqwlytM_Ai74p_-VWhL4Q8oSNqG3RQR9xmOS-Tuc
Message-ID: <CADnq5_N1Q7=eiZLQTgXzRSJiU-WoSQXejv5vLOb50WLba=PSpw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Implement insert_end for VCE 3"
To: David Rosca <david.rosca@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Aug 14, 2026 at 11:13=E2=80=AFAM David Rosca <david.rosca@amd.com> =
wrote:
>
>
> On 8/14/26 17:08, Alex Deucher wrote:
> > On Fri, Aug 14, 2026 at 11:05=E2=80=AFAM David Rosca <david.rosca@amd.c=
om> wrote:
> >> This doesn't solve the issue, VCE still hangs in some cases.
> >>
> >> 4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> >> fixes the regression, originally introduced in
> >> 83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence").
> > This doesn't make sense to me.  GDS and SPM are not supported on VCN
> > in the first place so they would never be emitted for VCN.
>
> The issue was the extra fence when only pipeline sync was needed.
> With 4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> the fence is not emitted in that case.

If only the pipeline sync is needed that should also be moved up to
the caller as well.  I'll send a patch to fix that.

Alex

>
> David
>
> >
> > Alex
> >
> >> This reverts commit 7591335141a06d5b176510054576d9c64519f348.
> >>
> >> Signed-off-by: David Rosca <david.rosca@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++---------------------=
-
> >>   1 file changed, 4 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v3_0.c
> >> index a9497e2e07f7..9f4e88440c0a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> >> @@ -809,23 +809,6 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_r=
ing *ring,
> >>          amdgpu_ring_write(ring, ib->length_dw);
> >>   }
> >>
> >> -static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 ad=
dr,
> >> -                       u64 seq, unsigned flags)
> >> -{
> >> -       WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> >> -
> >> -       amdgpu_ring_write(ring, VCE_CMD_FENCE);
> >> -       amdgpu_ring_write(ring, addr);
> >> -       amdgpu_ring_write(ring, upper_32_bits(addr));
> >> -       amdgpu_ring_write(ring, seq);
> >> -       amdgpu_ring_write(ring, VCE_CMD_TRAP);
> >> -}
> >> -
> >> -static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
> >> -{
> >> -       amdgpu_ring_write(ring, VCE_CMD_END);
> >> -}
> >> -
> >>   static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
> >>                                     unsigned int vmid, uint64_t pd_add=
r)
> >>   {
> >> @@ -835,6 +818,7 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_r=
ing *ring,
> >>
> >>          amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
> >>          amdgpu_ring_write(ring, vmid);
> >> +       amdgpu_ring_write(ring, VCE_CMD_END);
> >>   }
> >>
> >>   static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
> >> @@ -900,19 +884,17 @@ static const struct amdgpu_ring_funcs vce_v3_0_r=
ing_vm_funcs =3D {
> >>          .set_wptr =3D vce_v3_0_ring_set_wptr,
> >>          .patch_cs_in_place =3D amdgpu_vce_ring_parse_cs_vm,
> >>          .emit_frame_size =3D
> >> -               5 + /* vce_v3_0_emit_vm_flush */
> >> +               6 + /* vce_v3_0_emit_vm_flush */
> >>                  4 + /* vce_v3_0_emit_pipeline_sync */
> >> -               5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
> >> -               1, /* vce_v3_0_ring_insert_end */
> >> +               6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
> >>          .emit_ib_size =3D 5, /* vce_v3_0_ring_emit_ib */
> >>          .emit_ib =3D vce_v3_0_ring_emit_ib,
> >>          .emit_vm_flush =3D vce_v3_0_emit_vm_flush,
> >>          .emit_pipeline_sync =3D vce_v3_0_emit_pipeline_sync,
> >> -       .emit_fence =3D vce_v3_0_ring_emit_fence,
> >> +       .emit_fence =3D amdgpu_vce_ring_emit_fence,
> >>          .test_ring =3D amdgpu_vce_ring_test_ring,
> >>          .test_ib =3D amdgpu_vce_ring_test_ib,
> >>          .insert_nop =3D amdgpu_ring_insert_nop,
> >> -       .insert_end =3D vce_v3_0_ring_insert_end,
> >>          .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >>          .begin_use =3D amdgpu_vce_ring_begin_use,
> >>          .end_use =3D amdgpu_vce_ring_end_use,
> >> --
> >> 2.43.0
> >>
