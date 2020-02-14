Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECFC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB8024697
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MyHARi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB8024697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B186E82B;
	Fri, 14 Feb 2020 16:31:44 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3F26E82B;
 Fri, 14 Feb 2020 16:31:44 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id s10so10570954wmh.3;
 Fri, 14 Feb 2020 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eAPiyJCQWJAYuCQbg5vLQMsHB0XHMIF5EmjZS4cVVMc=;
 b=U/MyHARiUoYbmegGISDczV0sWnxf/CnBisvcw2jP8Q2HgYSyL06jv5gfeTBP2p4i3D
 QhuS8B+4XAy9CwyDawix1OFxAgYhQpFMMsmC94tYIm2qmJnfyh55YEg0pWY1pHMg+ocI
 manMWCwf4ahuziuNMS3zGbJONPoQWeeIR3zEGrreA3w7fmh8XdV/8B78hr80zPWdC2LT
 cVlEtA0td92IIYlzvtt2X0tnS9sXkgKV/dqnFWYcWfP6BnqJjk5hQc+N90kscu4bfQXt
 FkBvGcZCIWjwRCYqPZxbptIimSIJ9le4M94WzYU5Og0VLFp9HC3MZoCehWOIBKHr6K6o
 HyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eAPiyJCQWJAYuCQbg5vLQMsHB0XHMIF5EmjZS4cVVMc=;
 b=c6SRKHPMDijLMPqmY9bqq1ouFqa75ksV9bZ21Wtd5m6RgpgR1brARrtMhM9nmR2cyR
 53dPVmCa6DmdAoQCf9PL+n03xKm/6KUIghILUUYPJY4QRkrRkOvk3ejmTQI98UvDoPSc
 s92D/e/ycaeQUR2bw+wduYH6tF7SdJfJ/P0iF5nJOjAPMqY+hSGgdzoa9SA7lP1Jhfh0
 XKvJAOZl4smbqJGQ5/iMD8lbbllOgwdSV2WpM+N8mvV8dmmN8DRntzJbhexT4wioB3k1
 1sSkr4qKr0REvbAWtRop9ysfmW7hdr8MUWHUDogivVbP+v6ZjF1aV0TW+tz/r+TldjUh
 Q9Zg==
X-Gm-Message-State: APjAAAUbZOEf1KR0hndxi5KrT9q2cEWFhsG05CHBb2AX2odWmIpz/X0e
 Gbl5AqS+vCQJgDVqR14dcDcHefDAzZ2JRNL2JBE=
X-Google-Smtp-Source: APXvYqzlHaboZa+02wB3RWO97MuTp7IBVGo1BoTiJj/H1xoW7PoNMQhdrNk38Zh5PiWw6BYvdcF+waGi/AJsrdjus7I=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr5496620wmg.39.1581697902657; 
 Fri, 14 Feb 2020 08:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-530-sashal@kernel.org>
In-Reply-To: <20200214154854.6746-530-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2020 11:31:31 -0500
Message-ID: <CADnq5_Oq-6VYYMWgvSbTcs5S6+DHP1K+ambo3Cd_BBkYFQk8HQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 530/542] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_voltage
To: Sasha Levin <sashal@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 14, 2020 at 11:00 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> [ Upstream commit 1064ad4aeef94f51ca230ac639a9e996fb7867a0 ]
>
> Cull out 0 clocks to avoid a warning in DC.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/963

All of the upstream commits that reference this bug need to be applied
or this patch set will be broken.  Please either apply them all or
drop them.

Alex

> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 627a42e8fd318..fed3fc4bb57a9 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1080,9 +1080,11 @@ static int smu10_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
>
>         clocks->num_levels = 0;
>         for (i = 0; i < pclk_vol_table->count; i++) {
> -               clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
> -               clocks->data[i].voltage_in_mv = pclk_vol_table->entries[i].vol;
> -               clocks->num_levels++;
> +               if (pclk_vol_table->entries[i].clk) {
> +                       clocks->data[clocks->num_levels].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
> +                       clocks->data[clocks->num_levels].voltage_in_mv = pclk_vol_table->entries[i].vol;
> +                       clocks->num_levels++;
> +               }
>         }
>
>         return 0;
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
