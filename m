Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA212C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34FB208A9
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQGXeQoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34FB208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5440D89CF1;
	Mon, 31 Aug 2020 14:17:44 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A0789CF1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:17:43 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z4so3330609wrr.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VEITWF3H/jMjDbjfqt4wA5+5dFMt9FdMLgFO2GdUbnc=;
 b=lQGXeQoRmqm31GG6Oe4dO1SsWcjG8IhP1KZYYMBHGYONf/O3R/MkUcHjBmW2hULE8h
 07QRcN3aNnXMGJnj78YsksIx/Wly+oVLEFeGVXyBFNyBm/B7ytX/IklY2xHuztRil0G8
 uPEm53OXner1HImIWSNFdzNE6vcPHXieqwz4GrNq2AeSsWTYsARqqdkaM5cdQ9spgPWq
 bjfGP7tN1W4B+Fqm553KEOrWojd/5DkrmK/jWcgvZ4KHo+4Ve0/11MXDNC5/X++5vH8W
 QLchOVsuG5VkoQ6ku+9WuuWg1zaI8a4gQekETqzKwnJ01eng8DZ1gUuu3eBPREFAX+yI
 XtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VEITWF3H/jMjDbjfqt4wA5+5dFMt9FdMLgFO2GdUbnc=;
 b=b0gKidI3weDLeY4SAlMrLgXvkcL8fN8j7NUtSWhXzE/NcPgWjl+VzInSylfihfXoXf
 r72F1lmVzDWfPUbTSdGJ7WA0n5HK7cZOETdzrgyqxx71N8VJMVrbEKqODmXKPek55Da1
 rRr1nbfhLogRKsQGuLbyXumuHxXC0p+OpEriWrRLCx1jfsOKuF6FCcaH4Vw7DdQ+kuIG
 ABsNos8myWTog6PCRTVfQnIFvCqVwfFuYek+27a1rkwSKH0zWGrJ6NIgzDlpmMdoUm1K
 qfGucmW6aYN/WnCk4wOfuyCGRdZEGFzGjYWRfZKbzN6DKiezSEuvF3qgSasl9mRb31UE
 PgLA==
X-Gm-Message-State: AOAM532Y5Qt6EIx17mnOE3mTekTpUh5pPbNI2/0VodlOoM5u7Imb/tJD
 evidqW2ocL3t3VXPXHklh+EfuJk2hc8oq9rzynyCu0Ky
X-Google-Smtp-Source: ABdhPJw3TJ/r3ssrsEKSkQEx4vtZbSDFRara65v3utQOvWrtNjEdYgxgL8PIkUjSVUUqZ6lhOKIaKBd7S3YsMtgS4Cc=
X-Received: by 2002:a05:6000:110a:: with SMTP id
 z10mr1967586wrw.374.1598883461872; 
 Mon, 31 Aug 2020 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200831104553.10207-1-nirmoy.das@amd.com>
In-Reply-To: <20200831104553.10207-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2020 10:17:30 -0400
Message-ID: <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 tiancyin <Tianci.Yin@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 31, 2020 at 6:41 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> UVD dependent jobs should run on the same udv instance.
> This patch disables gpu scheduler's load balancer for
> a context which binds jobs from same the context to a udv
> instance.

typos: udv -> uvd
With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Does VCE need a similar fix?  What about UVD_ENC?

Alex


>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 59032c26fc82..7cd398d25498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>         scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>         num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>
> -       if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
> +       if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> +           hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> +           hw_ip == AMDGPU_HW_IP_UVD) {
>                 sched = drm_sched_pick_best(scheds, num_scheds);
>                 scheds = &sched;
>                 num_scheds = 1;
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
