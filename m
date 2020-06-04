Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D6C433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF2A2088E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDrViyRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF2A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03986E56D;
	Thu,  4 Jun 2020 18:55:16 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF8A6E563;
 Thu,  4 Jun 2020 18:55:15 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id x14so7286843wrp.2;
 Thu, 04 Jun 2020 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uiinNKg/VAAIBsMjrTVJDCNhmBGSNxHkcjt+mWjcnNg=;
 b=lDrViyRHFcdsinb5IHbP2qqOylfphQlSRMERDMe/wtWEswGJIceld6eWHhWVmj9kwY
 S9GDEP0NS16fM+nVJhx89txvsDrW8ZZPerN1C/nr8xYKjrLIJ1Dj67yMXuLMtidBXCjv
 l+uaJ0XsIXIb4XkViWBX1q43C7BVVfOVhxmBNVcFfMDZnzjQcCcXsx+HP2/L33r49U9l
 1gqQClBCFhkzWQzH5HubbtmYfShFnXIaUk+sA1cOP9p0adzuhnYRYCP3CshXQEppsPs6
 n5zO4FlxpRudlVm5V/E1QprnephQG9ygNndFspWN/lLh5tZQl0dNtThKw/VNb5KfvKBV
 gEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uiinNKg/VAAIBsMjrTVJDCNhmBGSNxHkcjt+mWjcnNg=;
 b=rfSmU6WkW82VkSqTGoE5xWsmDXaYF6VF6L9HcMMd4WpJsX4S471cHKbTZ+qNql/LLj
 pqnszT0VFeal7VZeoSjkDbWspkKzGUITG3qhJ1oe/iQ6q4gjN/wZ01Zsm3NfTRnvxI9k
 xlP8BIbuOXLwf5CKJExIuJtUGthSjd6H6d6YiWkJAQbL5vttssFw4jg0NgEw22nQw7aR
 Pp2G0Y2eC50wxZ/yEnvEohTT6CEWuSElgQBY4GQQb+Y4DPO+sA1pd6ecbfI0wbbSs30i
 0flTZZXDhpwRDSDs7ByQXutX9Qa9r430WcNh+DfZsABe2t8MY84s+KNrB9xuI9X5HwxS
 UHDQ==
X-Gm-Message-State: AOAM533gzgE6AwwF82QzPbIIjV3R173lmJGIkPMDFYSd6geuqnCpZJHP
 2Ljzgg+n6nXXFWej71netX8ZCd3M6XTCO7/SZ40=
X-Google-Smtp-Source: ABdhPJyO1qtFfu8kgFgNsp7xryFcB2IwdjYxZjFEdLusH+8TaUd3IzJ4bblyVzCLX2N+e0qXfwjUFreeN2ucvhsw9nc=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6163777wru.124.1591296913673; 
 Thu, 04 Jun 2020 11:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200604103544.14515-1-colin.king@canonical.com>
In-Reply-To: <20200604103544.14515-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 14:55:02 -0400
Message-ID: <CADnq5_M1f8WrNfmo3xS7G=kVaCougjk1Ebiq1yWN1QG4gTkxZw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake:
 "propogation" -> "propagation"
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Jun 4, 2020 at 6:35 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dml_print message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 65da6304d6a6..2a32ed6682fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -1308,7 +1308,7 @@ static bool CalculatePrefetchSchedule(
>                 dml_print("DML:  Tr0: %fus - time to fetch first row of data pagetables and first row of meta data (done in parallel)\n", TimeForFetchingRowInVBlank);
>                 dml_print("DML:  Tr1: %fus - time to fetch second row of data pagetables and second row of meta data (done in parallel)\n", TimeForFetchingRowInVBlank);
>                 dml_print("DML:  Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)LinesToRequestPrefetchPixelData * LineTime);
> -               dml_print("DML: To: %fus - time for propogation from scaler to optc\n", (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime);
> +               dml_print("DML: To: %fus - time for propagation from scaler to optc\n", (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime);
>                 dml_print("DML: Tvstartup - Tsetup - Tcalc - Twait - Tpre - To > 0\n");
>                 dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", VStartup * LineTime - TimeForFetchingMetaPTE - 2 * TimeForFetchingRowInVBlank - (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->HTotal)) * LineTime - TWait - TCalc - Tsetup);
>                 dml_print("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %d\n", PixelPTEBytesPerRow);
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
