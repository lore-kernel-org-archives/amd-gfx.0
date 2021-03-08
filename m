Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7247C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 21:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EAF64FA8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 21:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EAF64FA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB0B6E426;
	Mon,  8 Mar 2021 21:16:53 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879256E426
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 21:16:51 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id j8so10728186otc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 13:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ivu2yd46/9CTke00q3sZMb2FfM9EoWmD+aM49E0iuEw=;
 b=pUSPMfa6nLQPHtQOEgG4mU+u0iXf4yBlsXBKJjjYpg82YXN6ZYR/0z+xNGdw9eLzSA
 WS1f7a1/ejTCU5cXVvOO4wVBcS7C6Ll+vYyFki9OxkvDz6Cu12S2oqQi5w14mTU4wcs+
 jDw1++KkWsF/Ef3z6ru9U5AzPTxcLIinah4FrQtVI/ULY6wwU+wc36850PgHMg+rl/US
 p2Y6NWZpaqmlKnftnkSwsRorAjw87/s+2Ht3a8ObMUHM352t7jag8CgdgxoJ21qy1Fmy
 y/C0sW2vGuptjpzgtbYCfGRebFhbZog0y17BycNsMdw/M0axN98A0W21tMocwAV+Xrt9
 biaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ivu2yd46/9CTke00q3sZMb2FfM9EoWmD+aM49E0iuEw=;
 b=PT3J6HfaThsd+gNO2YcAEQfkoOJEFQcbjWMcKpbOmu1vMs9npVv6IhE7N+qOB27Hlq
 NuuH/gyEKPW4+f/khlDLlSXsRNZBaZKrmUYmzHBaJpxUKBoGx/6/KQOWBu9rAp1D91B9
 kaW2mK8Lvvd6lnejuv6TAmRBZ8/WBZOh5yD8QX+4bH8F5+m1cCBy/+9Cl0TedHbfMSuG
 T/Zs2mrSLPLU9Kx1jULLbWK8JklRvZNdXW5PfqQIsr43ko++mCWLPXomt7oRTps959Os
 t1Md7Bv827YJvK8XL7/gI9dERPUbIQWK5SmcIzJEhxnvTo141kEnR782NP4psCcR7fpL
 NXNw==
X-Gm-Message-State: AOAM53099mMmmsrvLl1naUOrbEBI9Zbsbll4E2612VHiWiTKPrInlvmr
 6HdQqqlb7X8vBE3gJOF3og43PUaJjPVSJXl8Wz6eOR54
X-Google-Smtp-Source: ABdhPJxYL0LdDjmeP3pXHr6NT8dcM7tx7j/1Q73CPOchhQcbylzGsRz3hxZqv4wkR1FNIesfeQ1JQrl2qlfz66jMAno=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr21636820ota.311.1615238210845; 
 Mon, 08 Mar 2021 13:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20210305062517.583041-1-evan.quan@amd.com>
In-Reply-To: <20210305062517.583041-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Mar 2021 16:16:40 -0500
Message-ID: <CADnq5_P284StRh+HSgZGX=uGWcKddxNFpkV8Wp0ZiWA9PGGwdQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct the watermark settings for Polaris
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Georgios Toptsidis <gtoptsid@gmail.com>, "Chen, Guchun" <guchun.chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 5, 2021 at 1:25 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The "/ 10" should be applied to the right-hand operand instead of
> the left-hand one.
>
> Change-Id: Ie730a1981aa5dee45cd6c3efccc7fb0f088cd679
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Noticed-by: Georgios Toptsidis <gtoptsid@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index c57dc9ae81f2..a2681fe875ed 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5216,10 +5216,10 @@ static int smu7_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
>                 for (j = 0; j < dep_sclk_table->count; j++) {
>                         valid_entry = false;
>                         for (k = 0; k < watermarks->num_wm_sets; k++) {
> -                               if (dep_sclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz &&
> -                                   dep_sclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz &&
> -                                   dep_mclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz &&
> -                                   dep_mclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz) {
> +                               if (dep_sclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz / 10 &&
> +                                   dep_sclk_table->entries[i].clk < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz / 10 &&
> +                                   dep_mclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz / 10 &&
> +                                   dep_mclk_table->entries[i].clk < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz / 10) {
>                                         valid_entry = true;
>                                         table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k].wm_set_id;
>                                         break;
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
