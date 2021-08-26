Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A99C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 02:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A7160F4C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 02:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2A7160F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D7C6E479;
	Thu, 26 Aug 2021 02:01:02 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEE76E479
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 02:01:01 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 k12-20020a056830150c00b0051abe7f680bso1512040otp.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xr0W1stXhFhWBL3p+UuCXAhcOcwmdg8NiHE8AWT2uSY=;
 b=HaprRiAWgt2MViijqA65Votrp2cq7mKQL06fu4RYhzwy4Gxue92bajdwNzHWfmUTOj
 xh1ff96j1Z9FJ0T5oGi2FnKus3uBoa61NUuUnOUs144jPlE8JJoMXN/goGP0HXmw4nzZ
 LFvbbOP/Sa/cTr69gdMdD99TfHsGLSQpUz9pGgtIoaFeU/rT5AinfxB6s44vE3RMbhLl
 weM0vLZ626QcBtITQjiGe79oCZs8wbHFM33SNBZ1i2zRElOQS9rZnD2l4fNMsC/g7VC/
 xbsCEOIm0b2oTHSijGAeUPSFms7Wgujab+sIylHcQNCoR9HI6KfJxEtC9hAgk7jquH8e
 NeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xr0W1stXhFhWBL3p+UuCXAhcOcwmdg8NiHE8AWT2uSY=;
 b=nw+lhE6gZZFzDul63pK449GPznYQNyB6artEP76AsB6ZpCpKumWa69AWfovqYtqi43
 omi6mtQdd53zxNmXAYLJn/5VtDFo0wDxEHRxr24Lqfqjlp1rZXq+baRXHOy3uTIgtU2j
 RfOC66UlFR326O0kPu/+dEUzNEe/sEqTN0lSfOmhM53hETynPYbg2HhJ2ewzSPfSvhtk
 ZVM4/p2mYO/fjkcQVpBtoMPm0JfRBWa+HgLJjG1nYVgiWHDtstjW9Hnv2pFSvt/SzpJA
 BS5uM5i6OpoSrgvimaNhtn9SaYYNFAUfPAF9Gr5Sk6D31C44JGJktmFjw/sdn5erPNjX
 N9nw==
X-Gm-Message-State: AOAM531qb83q8QdohgNz0rFTW2UlQ7yxE8P/6SPfmHo0vcE/sO5e5LN5
 3rX32uPxPfrUZX6NC6cfpxObHRE76EjP1m41ND4=
X-Google-Smtp-Source: ABdhPJw4+DhN0LbPsAOfQArDqaUPwfIKYMO22ai3oGln7rX75UOVMMlONSM4q9tmXUZrvegfN6RPecruzpL42uoIyQA=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr1097224otf.311.1629943260680; 
 Wed, 25 Aug 2021 19:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210826011002.425361-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210826011002.425361-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Aug 2021 22:00:49 -0400
Message-ID: <CADnq5_M+THmHo_-ti=or18cRvBuExdiNcXybVLcVRj2_KfsBuw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amd/display: Update number of DCN3 clock states
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 "for 3.8" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Aug 25, 2021 at 9:10 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why & How]
> The DCN3 SoC parameter num_states was calculated but not saved into the
> object.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: stable@vger.kernel.org

Please add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1403
to the series.  With that fixed, series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 1333f0541f1b..43ac6f42dd80 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -2467,6 +2467,7 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>                         dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
>                 }
>
> +               dcn3_0_soc.num_states = num_states;
>                 for (i = 0; i < dcn3_0_soc.num_states; i++) {
>                         dcn3_0_soc.clock_limits[i].state = i;
>                         dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
> --
> 2.30.2
>
