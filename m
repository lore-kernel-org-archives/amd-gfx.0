Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D67C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 19:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F2110E20F;
	Thu, 13 Aug 2026 19:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kz5lapto";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BD910E20F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 19:02:42 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so18636a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 12:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786647762; cv=none;
 d=google.com; s=arc-20260327;
 b=f5okxVgA79y5TLWU1O3FygnXY3XoRqEsea1sIWRRzwxL6Nlc8IAJDUzcL+xYgVExWN
 5frrmhHE5Y98y+JeioonAPAlA1h2x6AH4wOcQhNuLfP3mD2QGp+cu52qjdXEmLlDuU4Y
 8ekuz87lp+cXAFCy52filkdoAO3s05m82owrlEYMlPTu3URHlOk+IALpHq2+FZJH4mmf
 hV4TX/Nd1Rq/Vj5yVnzancAQlFkm9sjhrXYmNJmMZlWeNJxKTBOooMspF9jACt22bcA/
 GJR5Sz3LJrFGcW/1T2zqhRu/nbXmwDJzp7PzuHRo4jZO0licEQAGFJ+kv19DCZXmz7v4
 vV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/z+Uy3HejSrVCI10pjAPI9q6GyLVcGX/liopkYvuS2k=;
 fh=GN/o0e6iJIJKBv/q08m6Nx5sYL/0dpGPEYOcyLG1FvI=;
 b=W7fnBtqxUuM6YmkMennczLM60atE6sAPfO0bxMsHwTKwpUn/Wut3G6c+24Wl1xTS6a
 v7pWpxpj+DgOTiMQAroj45xjzna1t9qXSX+dqGWVMstzFmWZgPTjx+o2pAHLxCfSxn7U
 HQjaFUzdpK8HGn0I56rLdAHXADReLMi7x8bPUUiQVllcIeN7wKjaERG+quJxnJly0zOo
 uLhK3THOayw5SLSN2BpjD5x72vgtVSovUgseW0E28VXDr8Ovob+Cv+6AlmJO7sToxr9I
 teLE6JbjfYhiqNlwox4JRcJBcWAFdG6xtdcL3eX2+Vdy8h5FKzE0ZK3Hs5SY0S2nEL23
 KZpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786647762; x=1787252562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/z+Uy3HejSrVCI10pjAPI9q6GyLVcGX/liopkYvuS2k=;
 b=Kz5laptoYDUEL/84c5kq+QzMt271KhMeQ+EzVn20SQcLdFK6vNMuxunLzYHrauZWiw
 BFM50M4uQbPLK7qUCiigaK49OIKbr/LtxlVK6dTekiitgx28qGTTbJrdr8EQ/2RLkkRt
 LjqeXH/qGOeGoCDqGAQsapM3ds5TtDlSGYu+XNP8qJnwmhdgDwNj1dzd2iQ8kEwo+e+b
 BV2fsVE5VLngKM2y8cijbFMWZpoADlPFDr1z2Rb7Bnqm3juTDiMLLVPmH8Vi+gDJer8e
 pXLi+xsqPLTTsGoK7aMvJWa3XlFZ20CAFgd7YtFVD4r4847DPAYbe71uzfg5R85JM759
 iohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786647762; x=1787252562;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/z+Uy3HejSrVCI10pjAPI9q6GyLVcGX/liopkYvuS2k=;
 b=Jt95WQLtXM2bOO7b4otfet/jH3FmmjnZYk8Yiodp/E1lSjga+OeY/VxaGrhjHx3yiu
 N9rmE9/KjHXorbOvwmFeUY/evs1xo0mvssEWla/ry7jzMDgq1IxOJ/ZfDEVJDzYYsUOp
 A/nnMbW6NQ7xwRIsZdKE1Jern3b5bfbZHhON4i+8WG9MXK2rPWMXiQE3x6zIcaOTu1EN
 krBaVzAu8jh/XUXjhYtItiVsM5wVo2qYW+nV3nPTYUnM7SlqvhR4RgxoydN/oH+5xLv7
 pFSJOhyyfX788pqO8oR/spzU1hw8HD6c08Aau4eTnqeGzjsJv5uBgaShBAdEgI3AMVec
 zY/A==
X-Gm-Message-State: AOJu0YwXq8a7ENN7tJXZXqax6TdLQ9XOtlhRN6wFRpkSVxZ0kDtuXZEf
 KCeXyN8O0CmB6pbra0bQDlxhbaNYh1P1w7/5M3ZeF3SxgJJw+0rufYayBCz8OHVf7zgwES2qoA6
 GvFm+DmHF1R7M152I2pc7Gh6HM9xmjRE=
X-Gm-Gg: AR+sD137ZfoZ6MauN3KtG0B9PHQDsfAdbpV/uZZB0d9Vd16Sj72VCtvyoZOqD783kGx
 jdvMqblw+3wsXHp9mzBxxekYcdlndFsiGclvQqdHy2Vm8cl77JZ5+WhST6DtHReqKJjDSFH8ubH
 JvbFUSDlFnqvh2E3CA2b7yUAtkL0mED5X6emO+V+DH/oPh92U9EOEgx5hHDLsLrpIysZKQKKtIn
 knFmrg3KsJ2Q9+Ycfuc7u6r+XgDR6sUjbm/MCTsbZhuNNVbPvq/ashfnFfNmfvIfVZmXtYYXZIk
 uJVuoTIyaHHdJ40friC7ct3csMYoJCRlFSlTT1NMtq1KB0O4AkA2UYA4NaF+XJjCbcXkE5ajpIN
 VOKdWs++7t5hN6u3G1ff9nprMMQpvuy0=
X-Received: by 2002:a17:90b:2d8e:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3933bd2c8bdmr68606a91.1.1786647761623; Thu, 13 Aug 2026
 12:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260813054220.450509-1-Priya.Hosur@amd.com>
 <20260813054220.450509-2-Priya.Hosur@amd.com>
In-Reply-To: <20260813054220.450509-2-Priya.Hosur@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 15:02:30 -0400
X-Gm-Features: AUfX_my5pm9Jt9Qaunp8fxbXEM0c9GJNk5JzW76333_YoX-q-ooqzpDd5A_g_Ns
Message-ID: <CADnq5_Mge5MoNRyf0Nnynx5M=V2HKN8L-pFXV88GnLzAfOL5dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
To: Priya Hosur <Priya.Hosur@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Lijo.Lazar@amd.com, 
 Alexander.Deucher@amd.com, Mario.Limonciello@amd.com, 
 Christian.Koenig@amd.com, Pratik.Vishwakarma@amd.com, 
 Veerabadhran.Gopalakrishnan@amd.com, Felix.Kuehling@amd.com
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

+ Sunil


On Thu, Aug 13, 2026 at 1:50=E2=80=AFAM Priya Hosur <Priya.Hosur@amd.com> w=
rote:
>
> MES (Micro Engine Scheduler) does not perform heavy-weight TLB invalidati=
on
> after unmapping queues, unlike HWS which does this automatically. This ca=
uses
> a race condition where in-flight DMA descriptors can access memory that
> has been unmapped, leading to page faults and GPU queue hangs during SVM
> page migration.
>
> The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest/1 failure=
s
> on gfx1151 (Ryzen AI MAX) with XNACK mode 1 enabled - the GPU compute que=
ue
> hangs with packets submitted but never consumed.
>
> Add kfd_flush_tlb() with TLB_FLUSH_HEAVYWEIGHT in two MES code paths:
> 1. evict_process_queues_cpsch() - after MES removes queues
> 2. suspend_queues() - after MES suspends queues and mem_fence completes
>
> This ensures all in-flight memory accesses from unmapped queues are flush=
ed
> before memory is freed or migrated.

Can you check amdgpu_userq.c as well?  I suspect it needs something
similar when unmapping.

Thanks,

Alex

>
> Testing on gfx1151 shows this reduces failure rate from 100% to approxima=
tely
> 7-10%. The residual failures require further investigation.
>
> Change-Id: Ia83e6af7a66fe2bff56cb62c741728e9a18883e8
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..71c60a42c581 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>                 dqm_evict_mqd_bo(dqm, q);
>         }
>
> +       /*
> +        * Heavy-weight TLB flush after MES removes queues to ensure
> +        * in-flight memory accesses complete before memory is freed/migr=
ated.
> +        * HWS does this automatically, MES does not.
> +        */
> +       if (dqm->dev->kfd->shared_resources.enable_mes)
> +               kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +
>         if (!dqm->dev->kfd->shared_resources.enable_mes) {
>                 pdd->last_evict_timestamp =3D get_jiffies_64();
>                 retval =3D execute_queues_cpsch(dqm,
> @@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
>                 if (!per_device_suspended) {
>                         dqm_unlock(dqm);
>                         mutex_unlock(&p->event_mutex);
> -                       if (total_suspended)
> +                       if (total_suspended) {
>                                 amdgpu_amdkfd_debug_mem_fence(dqm->dev->a=
dev);
> +                               /* Heavy-weight TLB flush after MES suspe=
nds queues */
> +                               kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT)=
;
> +                       }
>                         continue;
>                 }
>
> --
> 2.43.0
>
