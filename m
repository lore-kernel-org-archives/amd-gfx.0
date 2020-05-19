Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 16:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD6E20578
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPf5Ms8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD6E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5863B6E362;
	Tue, 19 May 2020 16:06:21 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4E889D6C;
 Tue, 19 May 2020 16:06:19 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f13so3615171wmc.5;
 Tue, 19 May 2020 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=guiQOg83wk8Re5uEuJo1BoPo7XFCPazuk/VvCpyeK1M=;
 b=mXPf5Ms8ET6YablA99JN6u4VA/YVAadQQ7qlTUqWiZa4Yy/4v1W/A6Hv8uDOCqKDBt
 wHLXvP92KiOdRfjd4mtpEoNpOKuApoZeyI4+FEWwTxp8Y1Rv+kYjTTfYUyOeMGkNmxz/
 sSk1e675A9gKKswjNZfpBOf2SylUC6w60t6FM6t2Sd7OYy+S6MV3GLkFeUUBuzZ8Xrww
 mEBRF42H5WAodaO+zprmH8O6EfTarkUc7fySKqO5yt6mNJypof+qVkczsBHnxAUpzdMQ
 toDM2XnrMZeD/g1mLak/DlAd8BCI0ibMIWMHKRtvuMW4JJ0QFKXx0dJc7QcfM0ga4yH5
 Wt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=guiQOg83wk8Re5uEuJo1BoPo7XFCPazuk/VvCpyeK1M=;
 b=R3MY1OwHNAeYCuKfsKAAnmflIR8qt9J8FPkfsIrzJRQtrkJXFrUIL4fxA0W8THsQRl
 B9l2ErC42xAaw55TDyD4Wi7RODvowuTZQvs6/548SFhHdkFIbMvT+nnn5yhNFX1g8V6A
 BL/hUrSuuRk3SrAZmCymG4QxEtG68h/GZ4HOonxuhnfjGbckAgMSwICz3XgK6xGHEvUt
 Vi7kun6e++SI+XXx3edRYqcpIlhAJ6xadc5ynOharNZZJ0W9wAjEaAkauDgcsU7mYLLM
 HxTF/gXUEM5vqNpAhJYWgub9nB+d/8gycvOgFY+wTwjxWouEmyYhs1NKsup0+X7cbMV3
 igGw==
X-Gm-Message-State: AOAM530F/YikLMj5ptc+qpJ5caT33LK3gZwrNURU12WnApo4SouOCVi7
 MiVa5dRhLRwxQINWtGP5Twfo7mFg39i3dkfo/fw=
X-Google-Smtp-Source: ABdhPJzL5f1OBDcocPrtJ6fbylZ/xk9NChZVvHdXkRF7kKd7yOgiz/X65De/UPsERoG9SUFs6bKzwUqLMWaPLIl68ac=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr94893wmp.73.1589904378124;
 Tue, 19 May 2020 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200518162312.18059-1-aishwaryarj100@gmail.com>
In-Reply-To: <20200518162312.18059-1-aishwaryarj100@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2020 12:06:06 -0400
Message-ID: <CADnq5_N4u5GD+j=RSsTzpdOmZjAKV45aAtN2ffb+cizMcB9ygg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix boolreturn.cocci warnings
To: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 18, 2020 at 12:37 PM Aishwarya Ramakrishnan
<aishwaryarj100@gmail.com> wrote:
>
> Return statements in functions returning bool should use
> true/false instead of 1/0.
>
> drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c:40:9-10:
> WARNING: return of 0/1 in function 'event_interrupt_isr_v9' with return type bool
>
> Generated by: scripts/coccinelle/misc/boolreturn.cocci
>
> Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75ecda21..fce6ccabe38b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -37,7 +37,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>         vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>         if (vmid < dev->vm_info.first_vmid_kfd ||
>             vmid > dev->vm_info.last_vmid_kfd)
> -               return 0;
> +               return false;
>
>         source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
>         client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> @@ -69,7 +69,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>
>         /* If there is no valid PASID, it's likely a bug */
>         if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> -               return 0;
> +               return false;
>
>         /* Interrupt types we care about: various signals and faults.
>          * They will be forwarded to a work queue (see below).
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
