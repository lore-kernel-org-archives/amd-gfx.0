Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7820620781
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHMmhLBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7820620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B00D6E0EC;
	Wed, 24 Jun 2020 15:19:30 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D416E0EC;
 Wed, 24 Jun 2020 15:19:28 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j94so2709620wrj.0;
 Wed, 24 Jun 2020 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Py6R13MD/ALi+lmKz+0wD4Voo520rKERVOmYa94FmgM=;
 b=WHMmhLBrGsTKq8yguQB2bjx3E8JorBYdumZsxQYbxblYDAb8jiPDC9IByepKx+eccf
 A5h7Tlqxva0/EkSd32fHC2vvXjDnYlQw4RseSVvOxbp7Juf4pL7awzGRSAf9IzCzGIDM
 CPee79NMTwFDmyScJR/rHTnO+4ExhnAmEuTlQWu21xxH34an6xtftGYQLJGfuzsCr002
 MKZ21DNsuBIYBUKHkN0jphHx0ASZun96Ch6VbyQ109D59xnKGMvdJDqX8uVfq/OSqWcl
 S1rXrgUcmvjggtekDWmBBge8j7P7zTP1+3dUem26Xg5YY488gkAkSSBhNTni+U/DZFRv
 UWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Py6R13MD/ALi+lmKz+0wD4Voo520rKERVOmYa94FmgM=;
 b=P/3UAHKkw2/MbvM1qIu+M8cW4T/j5XacVlUL7vI3NOryjRSe3jsz1D7iXk6DoqcBbT
 X4YG12LDQdOeXC6kEhANkOpm9h3fDvSVAtepwWY8c4AkqeBAV0jY4D6Mq9j2uqTFiQ0b
 noO3qjlegJE9AezUfk6YGiye+lVyAEWOuu+r1IZ9MtDywkI6I+ZHZyIC7/BeftfBvY7u
 eEqsG7gEKAmYy9DNa1EIvSPFCxLpJgmzIqKhWxwydSSqNCPZuxyFtbn1zsMyWOOwgnz7
 wdpeocYA7HZdaUqiDcdVg5EbyW+KqDs/UAB01sDqauoblFY0BGSSUgBgFyI9LUXL4kAG
 raZQ==
X-Gm-Message-State: AOAM530rPP8ZzBaaJO3YPkmD3ngbuApo+97SbDP4OzGWVWfQ7CqfSnoA
 cDSSGPR+M9HzM4aH3NpB8U+SUvjctmK5pkOPWz0=
X-Google-Smtp-Source: ABdhPJzkiAB8rak7/EF7xQt5xkZIsOH0iRZ9o4lt3W5kLDwG6kLpL6P22IQui3lFLPjKWXPAPlyPVqKx8E1Jd9qgHCc=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr4633910wrw.374.1593011967560; 
 Wed, 24 Jun 2020 08:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624120710.10957-1-colin.king@canonical.com>
In-Reply-To: <20200624120710.10957-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jun 2020 11:19:16 -0400
Message-ID: <CADnq5_NGQzU6rrrqO4iXTHPSxpAt-w0ayxfrS0jj3K8u38f3hg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix array out-of-bounds read and write issues
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jun 24, 2020 at 8:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an off-by-one bounds check on the index into arrays
> table->mc_reg_address and table->mc_reg_table_entry[k].mc_data[j] that
> can lead to reads and writes outside of arrays. Fix the bound checking
> off-by-one error.
>
> Addresses-Coverity: ("Out-of-bounds read/write")
> Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
> index 134aa2b01f90..86ac032275bb 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -4351,7 +4351,7 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
>                                         table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
>                         }
>                         j++;
> -                       if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
> +                       if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
>                                 return -EINVAL;
>
>                         if (!pi->mem_gddr5) {
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
