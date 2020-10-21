Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F150C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959E7208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBCFQeyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959E7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD376EE65;
	Wed, 21 Oct 2020 18:33:26 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B58E6EE65;
 Wed, 21 Oct 2020 18:33:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d78so3133072wmd.3;
 Wed, 21 Oct 2020 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5j6DB/Z5rJHZN4Xv7MCF1wLoQyev8+XvCjJ+bJuvbWg=;
 b=pBCFQeyKSJiVVPEep2Tg482gOn+YHInxQc9UW+D6rVFfFdlNOMY1N8Q4kB9MpHRsiM
 7UddmLOyN+wpR46uQBiF5cQeXdF75LWERzVtR6T+kUBRbr1ZTaJSeHRHtiyT9EKG3fuD
 jXDw/Hcwp8PCZ/OGehABf2Qw+/HKgH0pWujaNTQN0HtgrcuamcptuGerIU/D/eQkSnGN
 1KqFjBZgzu9uF3sRmRfRVBEHLD8raWonn1VxSJcyiUk9nWAdoIwEGNXpL3fbF/BJAuH2
 9x5cWHx0VGiheV8uRQ1dFurChN1VygL0HmPk0qAHQ0gp2tnKA4GucmQUwfwdZ1DnX+lj
 5Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5j6DB/Z5rJHZN4Xv7MCF1wLoQyev8+XvCjJ+bJuvbWg=;
 b=ablnxbBJYKviG/XZVTt/j7VsKwvaoddlMnrfcENyYxcouOML/Jh3RtUeRGf/lszKWC
 wZuU0kSMFqBGu+CRXG6TWLJa63Y/xtzcaj+E+9Jng61yRZ5p3reHZDotC9GnnRyUq18L
 Ysa7uTtA75fUuYYyZ3VRDgi3ssJnTYPIIsNqrFceHwBDo3PTnbwIaWIrpOMMJj8eYsG6
 71HDBBYkFVnxU7kHcjMVzC0vE0tim0cdjBHzdsbzimFw1G7l74B1xbF2PrbKF8oE5eyE
 WydMJZvyST6WA0G+gF4nmyS5dIrNCvIAS8ipwibh5evmRxdwLPdVt2H/cSRR+Wyphirt
 h+OQ==
X-Gm-Message-State: AOAM530xj/ZHZGQIQDJArE/cK+2/5AmIiJSucEszG/iyTFLoR8wNgb0e
 KZyucEJ1yYuMsJS41shFpFVl4QrZUG0FOPBli7k=
X-Google-Smtp-Source: ABdhPJzPaIruAPrEkLX+4gFBwskCJuWJ/R1jH2ZlUJQ08UNuVVoDQ7DYW2fnxGZo+EekRucucu9hHau88dnsgXcrSms=
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr5008613wma.56.1603305203705;
 Wed, 21 Oct 2020 11:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201021182610.4l65yg3y3nhzcac4@adolin>
In-Reply-To: <20201021182610.4l65yg3y3nhzcac4@adolin>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 14:33:11 -0400
Message-ID: <CADnq5_PkEszu1Uz+vcnVF+_qUgVmMAcO_vvKhpVFVm0N0PUR3Q@mail.gmail.com>
Subject: Re: [Outreachy kernel][PATCH] gpu: amd: Return boolean types instead
 of integer values
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
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
Cc: Dave Airlie <airlied@linux.ie>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Oct 21, 2020 at 2:29 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:
>
> Return statements for functions returning bool should use truth
> and false instead of 1 and 0 respectively.
>
> Modify cik_event_interrupt.c to return false instead of 0.
>
> Issue found with Coccinelle.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 24b471734117..8e64c01565ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -66,12 +66,12 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>         vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
>         if (vmid < dev->vm_info.first_vmid_kfd ||
>             vmid > dev->vm_info.last_vmid_kfd)
> -               return 0;
> +               return false;
>
>         /* If there is no valid PASID, it's likely a firmware bug */
>         pasid = (ihre->ring_id & 0xffff0000) >> 16;
>         if (WARN_ONCE(pasid == 0, "FW bug: No PASID in KFD interrupt"))
> -               return 0;
> +               return false;
>
>         /* Interrupt types we care about: various signals and faults.
>          * They will be forwarded to a work queue (see below).
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
