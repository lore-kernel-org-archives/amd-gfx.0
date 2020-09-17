Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DDC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023E420708
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssoTF4y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023E420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FF66EC48;
	Thu, 17 Sep 2020 15:26:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCEA6EC48
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 15:26:31 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a17so2532024wrn.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N37IRDVH8rbn7oFGhvRNKCy3yhsWD9yjXO2oqRvKp78=;
 b=ssoTF4y7KzA2xWZr2q9mqDGcN3+wspOUOe/Sr/CeYxvEF4pV0UEfBv7hFhVgUcJK0L
 GsycHPIxnS80sAKzNQUXyZRc723HNoU1Dakf4yf9JUYrvMW+lSWi24R2KwADGumlk8MS
 Jue6XaK/g0cGbfqZVo9NEytqxcztO098fZx3qWhd9a4Ppkdi9hhnd4tNs984uN6YsX5k
 P2sxbUnP1R5MJyMaRw/54SDFmSTbwL59BV5u0CtWNCGnmLF2h9gWhdypKAnTOzmGrfRj
 WnNuwDoXv3UbIbZqOCjyURySA/BuvKXeJztnWaUS6bdCj7u+4bB1dt7nfBQDvGvc8LAu
 QIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N37IRDVH8rbn7oFGhvRNKCy3yhsWD9yjXO2oqRvKp78=;
 b=kXutCNREXPsPWmb6ZpjF3lc+mJrMOyc3R3Blc34jMJeJmssFLLWZH3+6MHk8RWIzKl
 S1jxWO7e7bVmCEddZd7jAnVrVzVwDS3jKq5WjGwM6H7lNdp+wwG/v6gNhAQaMkWBzCGI
 6y8VkssDKReE/AJGUGAJoRPK0fVbAB1OfwLUv3nwpUKfIoKDWRfWRVkGvY6qLX0bQPOI
 TzPh6WntEySP91Pt1FqPmrNYH4RMXnhG52/iIgr3eVg9B7s6xXTw2arbFMQCdPok0f+1
 MeJNQNkIW6RFV7umUPn4jSzBnY+5fwaqWtCBVn/4fpEU3suUWphDF0BgcKf5b2XSAwl+
 eVjg==
X-Gm-Message-State: AOAM530SrqkLGp71gbhf5o1khcSLlB5c0Z13oKcmiH7oDWcQlDjYFGHw
 GMStPksuKLwsHLRCzHinfP/Tp2OqfDbAicxSzDY=
X-Google-Smtp-Source: ABdhPJyC7BmH6EAbEdxJR4u8e80mRNECq2hj2rUliGTfzf22ZY4zZzHKNutGHqDaBT0IzuU1VRk3tP7BUPqFS/sELMY=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr34109435wru.374.1600356390395; 
 Thu, 17 Sep 2020 08:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200917105759.51129-1-yebin10@huawei.com>
In-Reply-To: <20200917105759.51129-1-yebin10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Sep 2020 11:26:19 -0400
Message-ID: <CADnq5_Oqn2d4Sk0bWzAWxWA6dJ+EqAqs=jjKGRiWF8T4qs4TDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Delete duplicated argument to '&&' or
 '||'
To: Ye Bin <yebin10@huawei.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 17, 2020 at 11:09 AM Ye Bin <yebin10@huawei.com> wrote:
>
> Fixes coccicheck warnig:
> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c:282:12-42:
> duplicated argument to && or ||
> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:3240:12-42:
> duplicated argument to && or ||
> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5520:7-91:
> duplicated argument to && or ||
> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5309:86-122:
> duplicated argument to && or ||
>
> Fixes: 6725a88f88a7 ("drm/amd/display: Add DCN3 DML")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 6 +++---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 8f8bf83a60a1..50b7d011705d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -3237,7 +3237,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 4;
>                 *BytePerPixelC = 0;
> -       } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> +       } else if (SourcePixelFormat == dm_444_16) {
>                 *BytePerPixelDETY = 2;
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 2;
> @@ -5307,7 +5307,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                         ViewportExceedsSurface = true;
>
>                 if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
> -                               && v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
> +                               && v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
>                         if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
>                                 ViewportExceedsSurface = true;
>                         }
> @@ -5517,7 +5517,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
>                         if (WritebackPixelFormat[k] == dm_444_64) {
>                                 WritebackDRAMClockChangeLatencyHiding = WritebackDRAMClockChangeLatencyHiding / 2;
>                         }
> -                       if (mode_lib->vba.WritebackConfiguration == dm_whole_buffer_for_single_stream_interleave || mode_lib->vba.WritebackConfiguration == dm_whole_buffer_for_single_stream_interleave) {
> +                       if (mode_lib->vba.WritebackConfiguration == dm_whole_buffer_for_single_stream_interleave) {
>                                 WritebackDRAMClockChangeLatencyHiding = WritebackDRAMClockChangeLatencyHiding * 2;
>                         }
>                         WritebackDRAMClockChangeLatencyMargin = WritebackDRAMClockChangeLatencyHiding - mode_lib->vba.WritebackDRAMClockChangeWatermark;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> index 5bb10f6e300d..416bf6fb67bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> @@ -279,7 +279,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 4;
>                 *BytePerPixelC = 0;
> -       } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> +       } else if (SourcePixelFormat == dm_444_16) {
>                 *BytePerPixelDETY = 2;
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 2;
> --
> 2.16.2.dirty
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
