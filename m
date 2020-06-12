Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE5C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 15:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DFF20801
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf0hW7Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DFF20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266916E997;
	Fri, 12 Jun 2020 15:27:47 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7BD6E994;
 Fri, 12 Jun 2020 15:27:45 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id k26so8671378wmi.4;
 Fri, 12 Jun 2020 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=02KYCiUi0pgpoGPaAyXU3/Qv3U6znMf82l3OyYwC3f0=;
 b=Gf0hW7Z+qHXyJ7gqSW2FBj8L9rejLee+kNaDyyrXb8UAvRwO+yF+tD7PvTfKAwvBP0
 SyDKqfSQXWJabq2Q8W7bwZfcS8Kxv0c+uZXfmy9p057xIz2o+YKFP7PYhEAakJD4nO4T
 awbi5kARLAlz3fkftBK+WcMgYqhvnDgZki5NJqCkG5Hl6qLHjAihU4ku6KcewteIPa4d
 WiLGnt7xycuMbG8hPHTPIeEaBWw74zYMKUsK4WGyqVpKKGZpVymcGka3FrrJVeBytLnF
 9sdNADqiJQc/XXjZVOpua4a51EPutwSLYkcPa40k4qzJzHqe2mAWGCHEjJ2wsgu3ZlL6
 15/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=02KYCiUi0pgpoGPaAyXU3/Qv3U6znMf82l3OyYwC3f0=;
 b=GO6OcaNLgnxeoeIvgMN9iJdMlrYAKf0OehbJDpRYIsjQAuDvvXuZ9dcNiHy3gT9SvE
 voiTH+4O1HxXXDZzVsow4rXTesh5cXEppnksY+w5uIUjiuPaKC05JQPBz897Fa0Q9Jou
 wa2NxsU9XuE4L2YRzGopOidybRffNHQQMKsYNNQm8hlbLe2hl4saXNWwVZkmZdZK6bUm
 X2bSX9RHACc8IaKK3e3IjeNdo3+9uebT4EfkdDUnlJXVyBjpQPy3zVInuYwNz7eMdsCk
 LFjbivxGaQrYCipsqE1KCtKV7RSGHvRdudXuRB8M5+x5XtW+4PmjmhDZdH7bhNNCvzQ7
 LjAA==
X-Gm-Message-State: AOAM531uTV0ZGKRcEp3/Di2U3IEZtc0aDHzbD56Zqx37woPmQ7b7PfSJ
 NvY6rgaKIVV1kqTl0N/SHTQyNmLwcvHxHEd7zfI=
X-Google-Smtp-Source: ABdhPJyZnmHTSsRayslyx0/eLvs546da9/M8cW8sRZBJrZlTygAmnfxUjX6OCy5tAILeS9eDuY0SpcrrQujUIPsMSMU=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr13885808wmb.39.1591975663618; 
 Fri, 12 Jun 2020 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200612115851.7123-1-bernard@vivo.com>
In-Reply-To: <20200612115851.7123-1-bernard@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Jun 2020 11:27:32 -0400
Message-ID: <CADnq5_OSYYySsYr=0R2Qo7Ku2Vs5+DAv=X4R=Nfpzmg=8G=dCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: add missing fill of the array`s first element
To: Bernard Zhao <bernard@vivo.com>
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
Cc: opensource.kernel@vivo.com, Josip Pavic <Josip.Pavic@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Wyatt Wood <wyatt.wood@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 12, 2020 at 9:22 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In function fill_iram_v_2, the ram_table->bright_neg_gain`s
> first element [0][0] seems to be missing. This change is just
> to make the code a bit readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index 8c37bcc27132..7604a01be19c 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -350,6 +350,7 @@ void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_parameters
>         ram_table->bright_pos_gain[4][1] = 0x20;
>         ram_table->bright_pos_gain[4][2] = 0x20;
>         ram_table->bright_pos_gain[4][3] = 0x20;
> +       ram_table->bright_neg_gain[0][0] = 0x00;
>         ram_table->bright_neg_gain[0][1] = 0x00;
>         ram_table->bright_neg_gain[0][2] = 0x00;
>         ram_table->bright_neg_gain[0][3] = 0x00;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
