Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A5EC4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106F7613FF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106F7613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CB66E1A8;
	Fri,  4 Jun 2021 16:56:16 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20D86E1A8;
 Fri,  4 Jun 2021 16:56:15 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so9667013otc.12; 
 Fri, 04 Jun 2021 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H6LHbgNy52Ugn9xE6Njw7OtLaeKXGWqrKMiHAaaNoo0=;
 b=JXNWAZ4V09YmbaqN7UJyI+miEtdFviDNduqUgu9epQACEKhdjBEYV9BuUli2dWxu6u
 eU3Umhh7yJnJ2o/wcxptR4f8aCKf5ptn/TIkIIAPMINohtNz73Rkn6l1POAkkRjeHpGe
 tzb+0N4w0H3vOeUUhSO4yvrJ8aAatO7y1TW2htElfCBm51eCMS8bkklIS9jliA5QSWFm
 W8SUT9yMDN0g6Q6dkIB7TYOFO7gT8JklD+sanqi//4w+uV819tS52JyH15TbuANqfNli
 UM4pQBrp5f9s3wtOJLE5nIJ0Sklgdo+Y1HClAlZIi87SxW7XNeso8kbRElKKUbbuIU+i
 GZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H6LHbgNy52Ugn9xE6Njw7OtLaeKXGWqrKMiHAaaNoo0=;
 b=fvx2QZMxMMIu9e0bym7SnO4SIARUS9u4/Is6joA1SeDXuXkWnlipvU84bkKvWW/CnM
 4W3JVMdOtQWFzZt0XjNmIb/gHIXN1ujo+NWdeBPBKWSYvRBRN9vWolfjgQ3+A6yrqqf/
 WA2VcGP4k+Y65Lcajx6XhOkAMSicN2+iYSaaV/IOPRt9ZHb+GabwkXpLkdXVDCVQFs2A
 c0S+8HZbC3YGqn6rsnKppuEtR/a0Kj+6v8PMVFZI8qCp57Zl9RRbozPuCk7+2Ygbnd0D
 PIWTFsDwvL4rytnn6OfQa2teLwKpQLcrr657JMGCQpiaFOWu8oRfFSgF/KkJvsyYqH5+
 pWAg==
X-Gm-Message-State: AOAM531cATAceaEdwFMSEUvxAYNdZLbtzuK2lcSsi41jLkGsysp/rZuu
 KTkmbXxVImDHFBnFxaDD2FBeKfhT8OWNl9UaWUI=
X-Google-Smtp-Source: ABdhPJxuhdyOzEz5VW5nfgY1B5KIZXGb8L5KvrRMXRaPrm7Tg2bsRzBEb2J03ByBd9xw6YU3u0CirA9m+xvudrrNy3o=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr1913092otr.23.1622825774401; 
 Fri, 04 Jun 2021 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210604050613.GA240889@embeddedor>
In-Reply-To: <20210604050613.GA240889@embeddedor>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 12:56:03 -0400
Message-ID: <CADnq5_OSFqq9KxZ17B7abeUfdUOR1ix4OFHjxkgzWdm7FzPfgA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix fall-through warning for Clang
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Cc: Kees Cook <keescook@chromium.org>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Jun 4, 2021 at 1:05 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 22 in linux-next. This is one of those last remaining
>       warnings. :)
>
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 8f71f6a4bb49..43c3f6e755e7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -831,6 +831,7 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>                 break;
>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>                 data->fine_grain_enabled = 1;
> +               break;
>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>         default:
>                 break;
> --
> 2.27.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
