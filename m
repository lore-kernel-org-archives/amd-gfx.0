Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739BC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C9E64F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C9E64F3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A0A6E0E9;
	Mon, 15 Mar 2021 18:19:38 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F03B6E0E9;
 Mon, 15 Mar 2021 18:19:38 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 31-20020a9d00220000b02901b64b9b50b1so5602855ota.9; 
 Mon, 15 Mar 2021 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JeDHtCDxywj9r6bA/2S0wPWpH9Q9pfJGq85V9QGOnw8=;
 b=TF7MqunSHLZhiqjjd5eKS6a1ZWsfyx6blhMKMqPybtS5JPw4NzQcK2xItEXkpphYPJ
 8QWlhHoSOyzKbsUYUrrJ8yHht6KEqZrPPGtbwD5vToVHROi8GIgPXOsTOd91WY4e1f1w
 4dj7qN2iBYJ/+ATjMLTpc+Cd0PZSe4yCx+UkRyBpQrdLKcZBlvac67lr3gUbQksGfNZe
 obIT8L8nKImSEVfNCG/qXXqb5HIOC1JKKJyaqEEExdW3l/qu1sO96+BI0qs5nrTte4rF
 MraIQVxq0DmDE4LXZFC+Qfacc+wu3XVpX6PVV5O/9IEdRCE5UULjnCCNRpKeAvJ0PE76
 3c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JeDHtCDxywj9r6bA/2S0wPWpH9Q9pfJGq85V9QGOnw8=;
 b=FM8fox0vlAmn1b+zad3dfAWxjiYfN8SlBzmaMQWp7lF7b205oAU7xKBD9KU5HUJBIa
 5FJD+nMkEhVtGH08mkyh+AVacMfUodNWhWOX7/lXPp2MbqhFJfTbJBiLTwthhrQNXy8A
 iJirkCNQ9ys66VV6lErMvs9Va60xBWzAbGJ0UjD+LKcYLqRFYcc/dLBhus4sFztoAC9/
 +S6pj6+oXSz6gyVwQt71W55dz/DLN4okUii2ayg8NpWI4Ag7epQnxwlu94PyjxGUGUAi
 lGu0UOqDI0JZn2ydSC9pZ2hzR+ITUaklEbg0uBzwTlNhkBHcKv/3lD2uic4tofra5D3R
 t2Ng==
X-Gm-Message-State: AOAM532IigtCZIQ6GdVBecnvalq4EVmWqzNpLvzOfckcio2FThrsYDwA
 iZny03bJgL1Rc2mynXC0frYlWvswdDcTjFyYZEQ=
X-Google-Smtp-Source: ABdhPJyAxg+bB/x4V9sYZuqgUOEM6BOJkUKpErYFa5jBJaxeSIB/YQj4BCsKJcWuMzSE93UQTMd/eX9jCImPxzpIB5k=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr333800otl.23.1615832377776;
 Mon, 15 Mar 2021 11:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210312100842.127242-1-colin.king@canonical.com>
In-Reply-To: <20210312100842.127242-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Mar 2021 14:19:26 -0400
Message-ID: <CADnq5_PUo9cLui_B81Kn2LB8jmyZG2HsgWLQ=WqOWP+_wqcfsw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Fix spelling mistake "disble" ->
 "disable"
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Mar 12, 2021 at 5:08 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an assert message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0d725b66fb78..7edafef095a3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1300,7 +1300,7 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
>                                 (0 == smum_send_msg_to_smc(hwmgr,
>                                                 PPSMC_MSG_PCIeDPM_Disable,
>                                                 NULL)),
> -                               "Failed to disble pcie DPM during DPM Start Function!",
> +                               "Failed to disable pcie DPM during DPM Start Function!",
>                                 return -EINVAL);
>         }
>
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
