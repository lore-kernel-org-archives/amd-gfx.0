Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC9C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454582388D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454582388D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AFF89DA2;
	Mon,  7 Dec 2020 17:17:21 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DE189DA2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 17:17:20 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id 11so13145979oty.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Dec 2020 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=enu0feLtQLnsqrBZp6IU98h7u+Ax9f30Yuxai2gGoxY=;
 b=IqyO0HKDO0CU/jCKqKUEZuEZ9kOWlbE4i7LxRq5FyBG3tt40eEJDN/iLxBJabOg1/O
 B2TeqEwV8UH/x0huhi67odMeYUjD+v6Zf3HxgX3rj2jrG9i366DvH5ocg/LIaTtH6zJ2
 X7gU7CoN7vr0k1azUKm3CLa0CTRLNqzw4JDHwA9JstPGY19fo50ya6iMNH189/6hsyRK
 3ZDzKiWbF2wSKv2EW9XyBwjwumg/xDFwSAw2XjEA+G2PT98OCpMOpNrRHdmOy7JFq/lC
 g77ni1i06xT80McVkkwjdD1heKmwB1hMuSvD8NUNNaCk5Pn9Cxs851YNo+a3kHerUJj3
 COXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=enu0feLtQLnsqrBZp6IU98h7u+Ax9f30Yuxai2gGoxY=;
 b=sPNQHcXuwKYpSM5K5142oxuJzUbftT6h80E+uNvkn0M4jv0pZPhmSI9mV9hNNhUTNd
 NIeCi6nF0PvVGX2y+HsIlE0Odu8OzqptpiV0vXO+JXcncE26Fnzu+A9gqw6bcB8eI7AQ
 d8SRVhZLyDSarkcpRjeNxsc7X4VffkOHWiQihyPswnu1NY1hz13YlPijhAJRm6mpgnIM
 1+io0TtAZ/6RaKH25RV/+ofwYlIc/jRVKWMGZO8IjYi8oAKVkUVDaKrtIIQlmHvoKBng
 DiUNoUff6Xb6woxZnxjeAF7irTfLXzb3/KigOZVKLREfULMLUwuRihq3llEdEJT4eZnB
 MQIQ==
X-Gm-Message-State: AOAM530zdlYaVUB2VA3AO1v/LH9I4z/lXnAkKoc+N/B9ldILIVV4KZAw
 hOUMwzgtUXqXnI+tHOLwrhGb8RC3eOyGlg4Osm2mq66Z
X-Google-Smtp-Source: ABdhPJxC43Vt5laqtKyxeq/6VMWliCX3smEpKBUI3hDMnqRIXP8ASE1Vf7ihj2lKR6gJp0KwFbisP8NwnY02PaLXSDY=
X-Received: by 2002:a9d:4ce:: with SMTP id 72mr845216otm.23.1607361439421;
 Mon, 07 Dec 2020 09:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20201207064709.31404-1-Stanley.Yang@amd.com>
In-Reply-To: <20201207064709.31404-1-Stanley.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Dec 2020 12:17:08 -0500
Message-ID: <CADnq5_NC0-C0ziKs5m8z0-vvpk58YFa2HtSDdJrWORvVypzrqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix sdma instance fw version and feature
 version init
To: "Stanley.Yang" <Stanley.Yang@amd.com>
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

On Mon, Dec 7, 2020 at 1:47 AM Stanley.Yang <Stanley.Yang@amd.com> wrote:
>
> each sdma instance fw_version and feature_version
> should be set right value when asic type isn't
> between SIENNA_CICHILD and CHIP_DIMGREY_CAVEFISH
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: I1edbf3e0557d771eb4c0b686fa5299a3b5f26e35

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index cb5a6f1437f8..3fca9fc20dc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -197,7 +197,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
>                         if (err)
>                                 goto out;
>
> -                       err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[0]);
> +                       err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[i]);
>                         if (err)
>                                 goto out;
>                 }
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
