Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F1C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0436C20732
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqQsuivY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0436C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492EE6E8D7;
	Tue, 15 Sep 2020 18:36:57 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719206E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:36:56 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id s13so448538wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PGZwyhfQ5hF1oRwNrP+VuZ3IZC/ECZnLfXwkAyGp9xM=;
 b=RqQsuivY8eQojaEIqKqr64I42LRq4NVnUtUjGTxwqgFeWKa+X5zDlzy6PeeCe1C7AJ
 QwX9Uo0J0SaVG9qVlqDm3xN+1Kxx+gUI2y+VO3oS754MDFOjfLFiEViu/ui2ZXZ2M2fo
 vEWADTAm/+YpRQh8rxMaIpFdf8GW9lghLJluOXWNETYm3GEB3cr7d4ybhnzsJTQ4w6rN
 xs/0QrYLzbbSViyrpHXQer9blp+dDFs3yYxyEaHNzyZiztTzYELaDbON+e4Z3PJvsoL/
 9SsUFqPHyNura178d74lP+LIX51HDM+WpPVBsLzccQqgir2q8WbrXAWf7JKFhhpRi4nX
 mw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PGZwyhfQ5hF1oRwNrP+VuZ3IZC/ECZnLfXwkAyGp9xM=;
 b=jDBTtL0n3JgP0mPNb+BsmnIbRAI9wWvZjiz4v66Ft13hXk/ue0gk1SbJ+8nLWeHt29
 IPdU5wbg9an+qqkXnjxtHFegR8l+EIJehQTnlaKfICQ/l1w3+DXPRdOmws1rlAXpf6VC
 XxrJ7XmfXNSoATGTb7NKpd47k+jklO5TGkA1w0W6ffVYLufKwOs7JSvwagSXF+MEiEzO
 1DBstzTEcvwJoMItwwFIRGDjB1dPGSu6QijaQOc051Sdpz525DRnupxHuq6iTzz17yU9
 bd4tk5+nkoO9IqwwOs21I7cxtUhMOJgiPBCuoLLfBW2qgyprWpwezgoPWJEGPaVXZhil
 N17Q==
X-Gm-Message-State: AOAM533Lf3rY2PMAak6BPFYphnKma97UN3j6jNh5qNr3BrGsDVC+N/9s
 FBHxdrhCCwyaGeoouaP+8UsFJe3S8msh3TPlBRo=
X-Google-Smtp-Source: ABdhPJzBBQy5Ndy25EkBEl3SfFYC1W48xpM0FTDMwjQDlaXefnMH6sGnbq9fUjTqLlEn8uRI/HHFh1QnwNx1sRAjaMI=
X-Received: by 2002:a1c:a953:: with SMTP id s80mr713784wme.70.1600195015128;
 Tue, 15 Sep 2020 11:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200907090126.2542-1-evan.quan@amd.com>
 <20200907090126.2542-3-evan.quan@amd.com>
In-Reply-To: <20200907090126.2542-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 14:36:43 -0400
Message-ID: <CADnq5_PJs7fvQoHdSZLTPYLNwebU1W=XqtCPKgtMe7PVxwgpuw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amd/pm: add Renoir watermak WmType setting
To: Evan Quan <evan.quan@amd.com>
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
 Huang Rui <ray.huang@amd.com>, Changfeng Zhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 7, 2020 at 5:02 AM Evan Quan <evan.quan@amd.com> wrote:
>

Typo in the subject: watermak -> watermark


> Which tells it's a nomral pstate change or memory retraining.

Typo: nomral -> normal

with those fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: I8619115486021537b52c067c4d0b9bfc1417fc35
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 53d8beffc74e..63c72e33222e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -887,6 +887,8 @@ static int renoir_set_watermarks_table(
>
>                         table->WatermarkRow[WM_DCFCLK][i].WmSetting =
>                                 clock_ranges->reader_wm_sets[i].wm_inst;
> +                       table->WatermarkRow[WM_DCFCLK][i].WmType =
> +                               clock_ranges->reader_wm_sets[i].wm_type;
>                 }
>
>                 for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
> @@ -901,6 +903,8 @@ static int renoir_set_watermarks_table(
>
>                         table->WatermarkRow[WM_SOCCLK][i].WmSetting =
>                                 clock_ranges->writer_wm_sets[i].wm_inst;
> +                       table->WatermarkRow[WM_SOCCLK][i].WmType =
> +                               clock_ranges->writer_wm_sets[i].wm_type;
>                 }
>
>                 smu->watermarks_bitmap |= WATERMARKS_EXIST;
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
