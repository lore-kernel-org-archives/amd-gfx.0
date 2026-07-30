Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE3C55164
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 14:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D983510EF6F;
	Thu, 30 Jul 2026 14:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7nfep44";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C5910EF6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 14:50:04 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84a6f026675so415692b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 07:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785423004; cv=none;
 d=google.com; s=arc-20260327;
 b=fOKUa2U17/zlkeIj6XJ3Y89G+NHMLFrTtJ37l/y7yTsBKDCOTZymqVOBTE4z7za2E4
 oYOo+NEpwyRtCw3ke/q1by0l1JCRe22xKoumkO27qj9TP+K9v/FkOUD56GbWGnUb0fkk
 sDZAnbsFodk+V7NbX4hBbv7NVxS+TpPNvxWZbu4BOPJIgFoUnwPFvhJ2HZ/O86cEzSa6
 O5+HrspGF4XIU+E1KknXGMM7oFctZj8rY6MkprEIY90tSpA79qvzVmoS5Kvm1tmUpYz0
 QOs0zgO8tyGuiubEJcLOdh4E3PgBmz0ns1nkU+wmVUBfLWUZEuyRMepkP/U8h4lsLL7a
 Ob5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=THB3yv9o/jOOTFWioflZ1PTPe+pp6cYfTsYUcWJtirw=;
 fh=SbSqr0wpJNJ4l9bgD1OGmSzjeoSctYkUD5x/CIhtEkg=;
 b=fMcT14uICc4jvlJEMT51ip4e4J9H6Uf6qhnNpaNo2XQYZjpeEsLA6MyK5b2FQyM2cU
 AF94FnF2UBfufCWNKvfqsAZ6mDJCZbvMr1siN8t+9V3G6y29WWU+YZ/QOulJZMnfADxw
 G6r3Pvj3mXE99HjklfajFEwDYq9QFw8VXyKUM2+csKrr8ICkpPvHCQ15R8aOD4dwKj40
 ArYOQxYmW2eyBV5w05sLpZikSXzAsVb55F1dGnm+QFh8zQ590w6g4i3FUizwrc8geKEA
 sZcViMnnoa5Zd0PHigviT26tdB9dSikCSCa96FsTL7dDhYQjdSwtFpY5ekoDC1mnOMJv
 t7kA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785423004; x=1786027804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=THB3yv9o/jOOTFWioflZ1PTPe+pp6cYfTsYUcWJtirw=;
 b=H7nfep44N2puAaBhkF5EUg7bszbiqWISq5pDA3KYhnbkh8YXX/7yxfUz/k1aFbK2dz
 HRAnj5k6V9crO77mR27o2gS0JViJ+ikgz2AJgtPycl0I1TkVnfK6Ve7Z87mbJJJHZXpU
 NSJNIFvVFNVafENJU5Vn1+iWN+guV0FbRhbS1+MlpuPdz+D4EByTULkqK9wWHq1pMTAD
 fhXVDWscds0pebo9v0tUs8hlapAakWVJVWPnyFFYpuA64mK3vdAkj/JkOUQ862a3e2wS
 5b45hNjuK+LJXmpC+OtQJQ5g2kaocvnhF1kqk1MFfqa6acYwDWBg2drHERKxz40gUfSC
 f3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423004; x=1786027804;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=THB3yv9o/jOOTFWioflZ1PTPe+pp6cYfTsYUcWJtirw=;
 b=A+HP7IK8Ik7kZmQby5RvaG/P5aZ44y5LdcLdh0vSuTuxqGvQS8p6wi3KuLh6YLeOwr
 //kFyhfCpQeaQ36poi27tAno+24pFHgEaXna41BAmjoXZOrFeyZ2xrTFJxwgumvg5Bg6
 CSLExSgO/bsh4aByIeCS1FH21DActTlDIN+yeAyvvbsXfZiTS/whDWoR+ExxgcXOtwfl
 21KgNSfmlf4ZAD13TWBiCcWw6tTlYCmZB5s1qOUTdG9ACZPQtV8+kF/wt2Cl/BR3VX9X
 SV8JH2fxxLK2MnCnKvOrj/3r+9YiouIzDCrZfTblFGnmRrH904YFZ37esb1bFM+yauGu
 N0Fg==
X-Gm-Message-State: AOJu0YzBukCN6PZP32Ni1k8Cs4TyOqjXUuydsOykI2xqpd89gs2I7uda
 hOnsO/4Jjdwmm0rEPh0sy0DWkI64H58YZRme0HxHPWv+IHIqJ9Q+ActFEP3KQG3/tm+1sEbx/E1
 8DI9UjWRk2SAZYvqonKkbK7/W948Rwic=
X-Gm-Gg: AR+sD11DhH0FOpyPhFsSr+KPp5DQtsDTQhfOxBJAOJTAAeAfqca2AJ3um1/VlVleBr/
 5Uwfd1nvUw19xNtPFdJutJdJch3K2S/zVSTFmlFLD1uGLM9QMOAI71e3S5C0toVZFT3zVKA9AUE
 VOecz695qbBaVd9cpm+L8UJK9ybelt/0+yZnOKjcHF+ozB2J3T6CNB5eM9c2GrlurRp2FmaWaL+
 xnu+gvmePtaXCKnpmlDMUIMFfd/b+rSNXRTMTjS7Z4gkLOu2u6PtF8EPYN3icayKOKYz8W3H9tV
 Ca+jqnAteL6LO0EpXbwG2foAh5EW2pfUS9KKAiwfnuSdQWB2XB+TYHQE0HMjLT9qp+bPNKC0Nbc
 hLZxyrAG65cMRhvCNUEUaz2AuqXlI4Pc=
X-Received: by 2002:a17:90b:1f82:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-38fa7f26f3cmr554290a91.1.1785423004232; Thu, 30 Jul 2026
 07:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260730093847.2250791-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260730093847.2250791-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jul 2026 10:49:52 -0400
X-Gm-Features: AUfX_mzp5kw8KE00FriiomOrucQgHTDmU18YBFgptASjJs5NgChV2N9D7DzXXz0
Message-ID: <CADnq5_MiL8fgKUWGnWhVG91PEXcB6gCOxAbfZ0re=Z2pwm4nXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes12: use basic+ unmapped-doorbell handling
 for concurrent AQL queues
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Chris.Freehill@amd.com
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

On Thu, Jul 30, 2026 at 5:48=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> On gfx12, concurrent dispatch from multiple AQL compute user queues in on=
e
> process can intermittently stall one queue's first dispatch: its completi=
on
> never signals, while queue creation succeeds and no obvious dmesg error i=
s
> reported.
>
> With unmapped-doorbell mode 1 (basic), a doorbell hit only sets a coarse
> level-wide hasReadyQueues flag. Queue-level selection can still be filter=
ed by
> work_done/is_queue_ready, so under concurrency the ringing queue may be
> skipped and its new dispatch not fetched in time.
>
> Switch mes12 to mode 2 (basic+). In this mode, MES consumes per-queue
> CP_UNMAPPED_QUEUE bitmaps, identifies the ringing queue, and clears that
> queue's work_done in the unmapped-doorbell path so it is reconsidered
> promptly by scheduling.
>
> Tested on the amd-unified-interface branch on gfx1201: multiple
> concurrent AQL compute queues now pass repeatedly.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 04465804c254..5f9e28f8f007 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -990,10 +990,21 @@ static int mes_v12_0_set_hw_resources(struct amdgpu=
_mes *mes, int pipe)
>         /*
>          * Keep oversubscribe timer for sdma . When we have unmapped door=
bell
>          * handling support, other queue will not use the oversubscribe t=
imer.
> -        * handling  mode - 0: disabled; 1: basic version; 2: basic+ vers=
ion
> +        * handling  mode - 0: disabled; 1: basic; 2: basic+; 3: basic++
> +        *
> +        * Use basic+ (2): on an unmapped-queue doorbell ring MES reads t=
he
> +        * per-queue CP_UNMAPPED_QUEUE bitmap to identify exactly which q=
ueue(s)
> +        * rang and clears their work_done so the scheduler re-maps them.=
 The
> +        * basic (1) mode only sets a coarse level-wide "ready" flag with=
out
> +        * clearing the ringing queue's work_done, so a concurrent AQL co=
mpute
> +        * queue whose doorbell rings after work_done was set gets skippe=
d by the
> +        * scheduler and its dispatch is silently lost (intermittent hang=
 with
> +        * multiple concurrent queues). basic++ (3) additionally map_gang=
()s in
> +        * the interrupt handler for lower latency, but basic+ is suffici=
ent and
> +        * touches less state.
>          */
>         mes_set_hw_res_pkt.oversubscription_timer =3D mes_rev < 0x8b ? 0 =
: 50;
> -       mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;
> +       mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 2;
>
>         if (amdgpu_mes_log_enable) {
>                 mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> --
> 2.49.0
>
