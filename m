Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A869C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172AA2076A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQd8KHjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172AA2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D995E6E876;
	Wed, 25 Mar 2020 15:18:24 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564B46E876
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:18:23 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g62so3158062wme.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VV/qlS8w6RxJGoEbVU9s9Lx8hpGtMMGRX1WyaN9pPYk=;
 b=mQd8KHjIzoovJgCG372Jg113m45iDQp2RLFqqYsQXEhD+FU9EZof/i0EQpb6nkBbUt
 2xxaxOm4KGg3g/3AGRDg+17mDJXLS1XE5Q9v0XQLIKJu8K1EJdblHQvncXCKNuyGvtvE
 kcdsAbYs4asBkuzPDOFrNF1C5oRZeOVZPv6roFe/agFw0NHsIYRyxd9mV3OQGt4M7+k1
 Rst26qY764qquB7fiileemv5h9ES4D++Tqh0Zb+LH5m0/DgsgjyndEqOe/x27cR9Pzhb
 d09dMjMrFfx5apzzzcUJE+EnEezrvR6FUPyTQev19DYG4/4tqdf0nAgw9xWRAPKp861C
 pfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VV/qlS8w6RxJGoEbVU9s9Lx8hpGtMMGRX1WyaN9pPYk=;
 b=ftiToYeAS5NwG5UUdUeZKTp34Rttf/VWEH39IWE4szoqnRp7fmhYBu2BM88cSCSUtQ
 cQ22nLC+zEN5Y9ea6sWZcLATtrc0N6nUbfUOe0OvsNSTDv22zbbqhwHNKlgXnmwQeOir
 hznmU4s0fxi8PQOcjUMo7XXyj90ZvqiiD+vdF6DOWsK5TTkDBXGkFl13uJh71F8/N4C8
 DKAR7sju5tKAHbZ/qkuXyLtCGpJEw3B1s9GugD/Nqrc/Bz793g2x/g2qfFbcZjtsOmnU
 fbML07i0DCHeYlmeo8Pb7l09dQo7Kt8x84tFsEfiGk+PiYFwce3UNidal0Pd9ccz2PR3
 uPTQ==
X-Gm-Message-State: ANhLgQ1v7fXDpXIdhAXAuwt5vHMnRJT4gVfFqs5tQ1GV/1eopIjOybOb
 1AKwKyVX2hhny4SJ2xFbrmUjqMolGAk2Wf4fF95DI1+q
X-Google-Smtp-Source: ADFU+vs7uFQ9XrP5TQmfNoxbQvbjUV1/i03B34b7qSx7Q+fgneTZnHkTVuWc/qma5va88sFtX86EY8qXnpuNnGcaZlo=
X-Received: by 2002:a1c:de82:: with SMTP id v124mr3872706wmg.70.1585149501987; 
 Wed, 25 Mar 2020 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <1585125181-14195-2-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585125181-14195-2-git-send-email-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2020 11:18:11 -0400
Message-ID: <CADnq5_MNfq8wCd8xWXTudYO0n9z-22ePHMX-ObpV1S7D8KJG5A@mail.gmail.com>
Subject: Re: [PATCH 3/4] SWDEV-227979 - Add 4k resolution for virtual display
To: Emily Deng <Emily.Deng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 25, 2020 at 4:33 AM Emily Deng <Emily.Deng@amd.com> wrote:
>
> Add 4k resolution for virtual connector.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Please fix the patch title.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 3c9f2d2..8656cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -281,7 +281,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>         static const struct mode_size {
>                 int w;
>                 int h;
> -       } common_modes[17] = {
> +       } common_modes[21] = {
>                 { 640,  480},
>                 { 720,  480},
>                 { 800,  600},
> @@ -298,10 +298,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>                 {1680, 1050},
>                 {1600, 1200},
>                 {1920, 1080},
> -               {1920, 1200}
> +               {1920, 1200},
> +               {4096, 3112},
> +               {3656, 2664},
> +               {3840, 2160},
> +               {4096, 2160},
>         };
>
> -       for (i = 0; i < 17; i++) {
> +       for (i = 0; i < 21; i++) {
>                 mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
>                 drm_mode_probed_add(connector, mode);
>         }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
