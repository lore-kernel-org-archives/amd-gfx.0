Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B72BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8243694CAC;
	Tue, 12 Jul 2022 14:41:23 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1894CBE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=70K7Qb3I8kOHQRMfWIAOwsJADOddUdXa3JxnJBIwj7U=; b=RuVywhsfGYL64hjAjDolk1+45b
 lYZgJ+4yyC0ZpfxzJIClKXwwhZ8ptUf0PE4G3P7+fyOessLsGFsA7zJNu0ADsm3DVmUMkvg/EbTJX
 0AVbgTspr8N/MYZ50QgfOK1sGU0mozLQum86D/BZTQy9witRbdxhP9QSrvSF2UY0vTImFe2uY9N45
 Xuf6cMKrfsKTuuDt/vX/ohMJvzvvMKbtM/kzj1HGN4xKqbVh0PXsvDgdlqIu7mp8rowIU8N9oPbNa
 GqMkO+nu170r1KcqztoDIve1HVSeKdHj/YGrEQEN0iH7jp9WCmKxFseDo4i4Y1+hCB6iTpI+cVWHk
 RzaausJQ==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oBH4c-00Dea6-Ig; Tue, 12 Jul 2022 16:41:14 +0200
Message-ID: <541e256f-0ca0-d2fa-18ef-b31cdb48e5b2@igalia.com>
Date: Tue, 12 Jul 2022 11:40:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amd/display: fix comment format
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220712143159.2700970-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220712143159.2700970-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

Às 11:31 de 12/07/22, Alex Deucher escreveu:
> This is not a compliant kerneldoc comment, so make it just
> a regular comment.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> index c4a5f8198209..436c3545a983 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> @@ -42,7 +42,7 @@
>  #define FN(reg_name, field_name) \
>  	optc1->tg_shift->field_name, optc1->tg_mask->field_name
>  
> -/**
> +/*
>   * Enable CRTC
>   * Enable CRTC - call ASIC Control Object to enable Timing generator.
>   */

This comment is placed in a random part of the file, the proper fix it
would be to place it above the function that it's describing:

static bool optc314_enable_crtc(struct timing_generator *optc)

There it could even be a correct kerneldoc comment, fixed the function
name and adding the argument description.
