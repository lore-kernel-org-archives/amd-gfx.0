Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECDC2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DFF20739
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGv7MGiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DFF20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E907B6E096;
	Mon, 13 Apr 2020 16:58:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2746E082;
 Mon, 13 Apr 2020 16:58:40 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p10so10846430wrt.6;
 Mon, 13 Apr 2020 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=786Abko4OwymZpA7zq9NIU+Jcj7CJ578QomD1bj3ank=;
 b=lGv7MGiYg7oEqYLypfycQaA6ew5I9aewcYJs9NmfJNETIijLfn1NwaDh8AFpk/A6aZ
 x8K73t3qPZTrdm/iXN5neVTcVukcTESm6TxmmAltPPoRdM6w6ta1X8KMW0822rbr/7Pv
 XZ8RzIk85b529lnkQYGf7UIlfSY9Fy/v+TZIajPYd8DS/FAbuuhObHapniZuosPkU3E+
 IC0OxraDowSo5wtqeDC2BpBpqBmG1gD0BeTgjr9deMN83wt6ems1YRVHtG4hXsqPXAI+
 gf6D4GmNPpWNdrAVePhYwlIlQTV0PmrhrzAU72QMkXUnW4uJV995oqf8IDEZ/8e8Pk1J
 7Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=786Abko4OwymZpA7zq9NIU+Jcj7CJ578QomD1bj3ank=;
 b=l23PA/ewY9+1t1/TqAs9yjUpjZKDFErcY7flZDZIL9x5CM1C6+n6UdWJcMinZThkog
 vgFYJcDTZ2ycBCCUwd3GAmoeaazLCggUckVs6UMSzDKS6s0uTZ/2jzKBgpn2TD9bMfBk
 D+Q6AaEgjLLhNQkbBervg2VZIu0luJYij9HNifyNBv40L6sUhs+NrD+HGeXdVa6xCcim
 guDz07PbrIIfjCfDPSO5wzldK/A8KKYP5dIIlQkeswiKMp6GE/2WQohCrdTVp6eVdd8E
 C9R8ToBQNHgLbk+Uctw4NkUt5U/BGyxYcX9lUEGJlsWVHjWZey8ejc+KP8aRNczSSGbf
 Attw==
X-Gm-Message-State: AGi0PuZF967boWWmtkWKHGher2QE7rg3BXXmKHq28dwMmVQ0Oj3o927U
 215Wa2jgTQ70Do5P22polH0WrDkAET6WML9ixrDZ3Q==
X-Google-Smtp-Source: APiQypLgM6ORe/fUey6PXuV88ju5z6/RrBDlwexv9u4wPO+3r3jSj9FiVWLMwss0rxgA7h39Knz1M70XeoItHyrc3oI=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr15152734wrq.374.1586797118982; 
 Mon, 13 Apr 2020 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200410114613.15271-1-colin.king@canonical.com>
In-Reply-To: <20200410114613.15271-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 12:58:27 -0400
Message-ID: <CADnq5_MBQyMaLdJE=WOz4pV7u5UZQy3Y_qjL5ZO=7Y=NHQor=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant assignment to variable
 dp_ref_clk_khz
To: Colin King <colin.king@canonical.com>
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
Cc: David Zhou <David1.Zhou@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  thanks!

Alex

On Fri, Apr 10, 2020 at 7:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable dp_ref_clk_khz is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26db1c5d4e4d..b210f8e9d592 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -131,7 +131,7 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>         struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>         int dprefclk_wdivider;
>         int dprefclk_src_sel;
> -       int dp_ref_clk_khz = 600000;
> +       int dp_ref_clk_khz;
>         int target_div;
>
>         /* ASSERT DP Reference Clock source is from DFS*/
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
