Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C87C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 18:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C9B6508B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 18:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C9B6508B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A3B6EB6D;
	Fri,  5 Mar 2021 18:38:20 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6623C6EB6D;
 Fri,  5 Mar 2021 18:38:19 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id i21so3573978oii.2;
 Fri, 05 Mar 2021 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NuHbNZ1pCaMD75xKPyicfsteJCNdNgmFyqDm5jntMkg=;
 b=QTriOvFOgzxFv2eZ9ihENSK9Df09qTS/DruECsSFH5Sw4oG5qzZp8dI5XzMGXH15Dh
 y2qwHDqCvJ2QXqvo+txAz2tLQMaxC13wIN2f+9blsjLVvy5glhB7P9IAwwRXnTORChQv
 XU5mE1Veu52ojTGnk0TrGJ5JKXxg36ONwyTwJaZleJFMELIN/qmxyFzjrjtIJ0UVVDpn
 kg2r5yIl+gy/+KaZK0LzlvT+tWx06slMIerNge13J6h2waZLv3CeGi9XMdkYOmwWwvpt
 SUO3wS5V+puwfdol9aeeqsnJmVX4B5GkpmzFzuLxKWW2+8KmzK/wM5moqN4dc+gB7t1k
 S4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NuHbNZ1pCaMD75xKPyicfsteJCNdNgmFyqDm5jntMkg=;
 b=Y9wNZDigN3TfVPRP3J2JKVcMnPRkWObGVXzHgR8kY8+3K0Tx8Hfkf0oMTouEog1tUe
 xKRTsjsfbzBhGZdCoFyjqBekq+ozuzS/DuYMvNAO1WtozbkR11ZEvhtJMhqXpqq2dS3A
 ziaZLXL0205Rqyn/VzKSsifabR8fnOY0EEoBC2cLmgXcahbe3NjWbth9FfDQUIpFsMVp
 r/EM9SNCSolWi2SYBtGdvhVyztRVvrW84Y7p3wu9NOycF2TTpYYWUlF+Z76CfuW04NB9
 UNna1Qb1MiE/poJdcqb89El/ryazU7btzfY3rdE5JaMy339ilDlH6Pbp2bqh1bWexAye
 C3QQ==
X-Gm-Message-State: AOAM532PmP5yx8QocOI/+1APNEmB0TF+TWVXyWyL7yKYjQnCmCOjnIaw
 HtVGaTN2KT0vNzgL7/gJK0ilXBbwYrjv6gTAX98=
X-Google-Smtp-Source: ABdhPJz0QWrubxnVvKfD+3rMD2OUVXyA1FXnY3QQjHZaZxL2kT/xA2ba7/jwCphvhlofJ9ONnGpq3uvRfWAWoyX3+04=
X-Received: by 2002:aca:af10:: with SMTP id y16mr5168997oie.120.1614969498664; 
 Fri, 05 Mar 2021 10:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20210303140654.67950-1-colin.king@canonical.com>
In-Reply-To: <20210303140654.67950-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Mar 2021 13:38:07 -0500
Message-ID: <CADnq5_Nj0_X5E0gqtMEr8FL_UVn+WwjWSycBhWUvcg=zVRHEZA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant initialization of
 variable status
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
Cc: Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
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

Applied.  Thanks!

Alex

On Wed, Mar 3, 2021 at 9:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable status is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 03741e170b61..15ed09b7a452 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -81,7 +81,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
>  {
>         struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
>         uint32_t raw_state;
> -       enum dmub_status status = DMUB_STATUS_INVALID;
> +       enum dmub_status status;
>
>         // Send gpint command and wait for ack
>         status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
> --
> 2.30.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
