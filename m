Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C4EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 22:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1451710E62B;
	Thu, 11 Apr 2024 22:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pQdNMriK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479F910E62B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4KqKuVqO737JOdlms2UUjnxM37rr1i8T5egf6nh1/SM=; b=pQdNMriKJiJXINSTHtkKq7YVbo
 0o6ZMWqT8n2NpZty14MFiKcOuD1WLdiv5F/HfeXuGJVztTb9Hvo3myo7l8yLXksHw1pP0vqoXdHxn
 8PN5CmBT4YaOYeEMk37vjceTWtUEU5wGyw80dV+QocrOz3Insldd1x48+6/5keF8ChJ+YErgmTTSs
 OxjX3Nsw9YNbYOBK8Wq/FH7hFFZHtR+yuDoXksH08Wa/y2UhY7LbniN+tZATjG6FB8QH4b8cEYoHo
 mbZVvtsYl1ySaszfNlySTSJIQRqak0gVX1OumLL9tyk3baIJy/0Z4utwasc1sYT/TdeI1gebGQcvQ
 40uaP+iA==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rv2gF-003hu8-8v; Fri, 12 Apr 2024 00:14:03 +0200
Date: Thu, 11 Apr 2024 19:13:27 -0300
From: Melissa Wen <mwen@igalia.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Enable cur_rom_en even if
 cursor degamma is not enabled"
Message-ID: <sbakqshremrl753bo4ngeotffx3a5g2bfirz2nlmvf5bbjffmz@qrpoilxjdv3p>
References: <20240411220837.1985770-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411220837.1985770-1-Rodrigo.Siqueira@amd.com>
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

On 04/11, Rodrigo Siqueira wrote:
> This reverts commit 5aba567a2988400d4e01d44493c84bed92820d8d.
> 
> The original patch introduces cursor gamma issue to multiple
> Linux compositors. For this reason this commit reverts this change.

Thanks for checking the issue.

Reviewed-by: Melissa Wen <mwen@igalia.com>

> 
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> index ed1e2f65f5b5..f8c0cee34080 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> @@ -395,7 +395,9 @@ void dpp3_set_cursor_attributes(
>  
>  	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
>  		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
> -		cur_rom_en = 1;
> +		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
> +			cur_rom_en = 1;
> +		}
>  	}
>  
>  	REG_UPDATE_3(CURSOR0_CONTROL,
> -- 
> 2.43.0
> 
