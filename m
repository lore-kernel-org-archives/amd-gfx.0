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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BFC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 15:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38FF206B6
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 15:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPEZcm8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38FF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D624F6EC14;
	Thu, 17 Sep 2020 15:20:30 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEB86EC14
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 15:20:30 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k15so2501454wrn.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HyirKisQHQMLbjA//TxgS9V/PFYV1I2mvylzVx+6tLo=;
 b=cPEZcm8bjbEfZNFzLqVAiNZaho0L1F/q13Fw0Ez8w722g1iOjjXasABKrLrXnkPlys
 nVE7sNKzjCqCD/p1w5yWfPH9Zun+8doYGGjlnNNxc8pjhRw+6Lt7Rx+Z1pkhtJ0GR8Kp
 FwbYEYn0JMEwfMfIj3nLqDcsi0ukIEVRCUSB5tu7SD+qtKOuI2rtOFnQ80Jcj5+8zj9N
 6DfCNoCWijrXEO4N9kR9mc8G+VDpJMKF/G0xBukpzriaVeIKlz8IIfsbb4zEmLMEqkmn
 BcZ/8JhzvvPUJpUFtMWw6MPS4/i9EUfZ0RWQyA8lQH3/Ro4tLR2KZvybcoQDxcZ4on6C
 OXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HyirKisQHQMLbjA//TxgS9V/PFYV1I2mvylzVx+6tLo=;
 b=lr43RdQp6H+vkCfcYHyGzEcFWrTxsEGIcip+ys5Mo9VFnpFITYASIj7qoYT8JAOYG1
 goUjlkpDT35kMytfHlo4HkYegGFCHnK6ihVwVdS9ra+r4dmuPnIFrha7f01g0gz4MzMF
 GFfP1KOnBw3NXOP+FFJfPclljXG30tJTbDvfWOWYteX3uvtd9btVYhsxxuOvuOHkpnkm
 SEYDjqt/KKWdnsDFf0d8pUgSRtRviQJqh9Yp4pw4hOj4LkvWuBks9UavGvuavhZjAUPH
 iN71TidTfGSsHCN+R9UDExTGrqDg0Xl2OkzxNzLshOY9aEMWyDbgVQ0+iCIJZtys7fDh
 H0Qw==
X-Gm-Message-State: AOAM533xfRFGbbMRsSHF1C1ga+BEKTt63/xT48Z+tvYBsBBFhKbt6t67
 S4dNhBdENa/yktGXMEn2BjxbRqYo2GzZA3/g5Sg=
X-Google-Smtp-Source: ABdhPJzif36Zu9fgAlnK6XBex+yQ69ZXCgLrb98Z8RCkwIjUnUXDtRCxCLA9UDyDCdxywgkMLSpfNknroh8gmLbExFA=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr32432351wro.362.1600356029009; 
 Thu, 17 Sep 2020 08:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200917073331.440434-1-issor.oruam@gmail.com>
In-Reply-To: <20200917073331.440434-1-issor.oruam@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Sep 2020 11:20:17 -0400
Message-ID: <CADnq5_PsQSwUh1+5Y3Y5KiCgBhXMt7B-ZMDJ5qzSJkfkgxNt=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: dc/clk_mgr: add support for SI parts (v3)
To: Mauro Rossi <issor.oruam@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied with a slight cleanup to the commit message.

Thanks!

Alex

On Thu, Sep 17, 2020 at 3:33 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
>
> (v1) Changelog
>
> [Why]
> After commit c69dd2d "drm/amd/display: Refactor clk_mgr functions"
> dc/clk_mgr requires these changes to add SI parts support
> Necessary to avoid hitting default: ASSERT(0); /* Unknown Asic */
> that would cause kernel freeze
>
> [How]
> Add case statement for FAMILY_SI chipsets
>
> (v2) Changelog
>
> [Why]
> DCE6 has no DPREFCLK_CNTL register
>
> [How]
> Add DCE6 specific macros definitions for CLK registers and masks
> Add DCE6 specific dce60/dce60_clk_mgr.c for DCE6 customization
> Code style: reuse all the public functions in dce100/dce_clk_mgr.h header
> Code style: use dce60_* static functions as per other DCE implementations
> Add dce60_get_dp_ref_freq_khz() w/o using DPREFCLK_CNTL register
> Use dce60_get_dp_ref_freq_khz() function in dce60_funcs
> Add DCE6 specific dce60_clk_mgr_construct
> dc/clk_mgr/dce_clk_mgr.c: use dce60_clk_mgr_construct for FAMILY_SI chipsets
> Add Makefile rules for dce60_clk_mgr.o target conditional to CONFIG_DRM_AMD_DC_SI
>
> (v3) Changelog
>
> [Why]
> linux-next kernel test robot reported the following problem:
> warning: no previous prototype for 'dce60_get_dp_ref_freq_khz' [-Wmissing-prototypes]
>
> [How]
> mark dce60_get_dp_ref_freq_khz() as static
>
> Fixes: 3ecb3b794e2 "drm/amd/display: dc/clk_mgr: add support for SI parts (v2)"
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index c11c6b3a787d..0267644717b2 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -80,7 +80,7 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
>  /* ClocksStatePerformance */
>  { .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
>
> -int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> +static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>  {
>         struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>         int dprefclk_wdivider;
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
