Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1224C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 15:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8936960C3D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 15:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936960C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184656EB5B;
	Fri, 29 Jan 2021 15:23:49 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB08F6EB5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 15:23:47 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id w8so10225266oie.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 07:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tLLs2HIgNLEiVX5tgRDKgvIjee581F5GvhWCWiuauSo=;
 b=mHP2OVKAVMA1fM7BF7qEJGk3wF+yF+TvFh2S75pfCs4cpHfBueQ5uq5Tsg0jcZQnjT
 fyzzVnrdHp93SxUuWuocqLAoW1hx6Rhv3Mah+UeIfWW9ch9sF7r0pwbzwMU2c32WRu6/
 9WxmyrT1TfT1rI0XM01ciIWZnlANcwgBBU8z+Y7GePeprS3b8TkqY6F/DdubwxW+hOAw
 sKZHyUCHQxMN5csx6v39wCRY7OrWMZSj8lkPUbS3Th/UDLcZ3/r8OjHcLXBJHXiN0Lwu
 afO72I8MZDIlz8NWjvnsfpZMutD86JNl+KUDECSZriE9I/YW5fERoArpp6wwdsvoiJA6
 bE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tLLs2HIgNLEiVX5tgRDKgvIjee581F5GvhWCWiuauSo=;
 b=kJ33o52kpZQk3y+tqkccBJc2F8J+BvcL0SHMaBYQ3ZZKktoHlsGWJulTGvJJ1uVQrW
 TbHeMakd33pEDwbpu4FFEOIKOx2aPpjsXwnx2s1bdqtj6RJIHFFfqdXKHLXLnpwtuVOP
 wFwPFjYt4W37e/4NUvn7uOsLu0ZbG5jTgNgCsUdKnI6Ln8mrttGltZ7Gkuog0IsEf4Sv
 7t9w97GLzD/QpjewW8pGmEMp58rqJlijF23pp6Fe4G0OyeOVh7aSoiwCbJ6/T9voQ+dR
 AJ7VUxHCBGelKH6IM801TQcjkAEkmdxQT7crH3HZx7vkslulke9UB1TmZrEAe26wjYXN
 4Huw==
X-Gm-Message-State: AOAM532R5lNy0xJEtvpfzSYs8y4KgGgstMZztdBMcOumeSD0CBFWdLkj
 EkjAKQX42nD3qgi9xb9ZHUf39KB4etVwfI/Yq/kcN8ED
X-Google-Smtp-Source: ABdhPJzM7+u5RofwWWO9arrNQa0eGUkJFS+v42HSTP7OFZisJRuaw8xlNMvUP5ID9ij1Zd7xjRbkIqi4gZ7+8dgGQgE=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr2912509oia.120.1611933827029; 
 Fri, 29 Jan 2021 07:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20210129030721.23031-1-kenneth.feng@amd.com>
In-Reply-To: <20210129030721.23031-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Jan 2021 10:23:35 -0500
Message-ID: <CADnq5_PssThcofkfThPCssNc9LF432YbQkbrFu666yzq=x2B=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: enable ACDC feature
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 28, 2021 at 10:07 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> The power limit and clock ragne are different in AC mode and DC mode.
> Firmware does the setting after this feature is enabled.
> Applied on mobile skus.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index dffdcebc80e1..faddfa9f5642 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>         }
>
> +       if (smu->dc_controlled_by_gpio)
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
> +
>         if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) && adev->asic_type > CHIP_SIENNA_CICHLID)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
>
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
