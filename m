Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CBC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D786823136
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D786823136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D516E212;
	Wed,  6 Jan 2021 19:46:44 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2835A6E212
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 19:46:43 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id a109so4137143otc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1km8OhwSR33fo0xrk/1cnPRG59moZnggMsTBBCFKtRs=;
 b=Tc2XX9+yV4zgqRRQ4i2gC+YRB3sO0n9m/sB9TVoxSMtWNRCEgYL/xksBxSfViNTS5a
 Jzsx+3ZQP3bdXSp2Tf8+bUgCEhpon2io1fT4V43rOXcUpebMtUVwt65UIsjB3QJlNk0I
 Q59WwNnBjORTdZWMUhOykt0VvtsBrlC2llDNwpsc8oqYmgmCBlKQoHIBND0Ci7GSBndU
 OxqE1WGf5RN+OxKV7NeMY8T5nxDg1xb/Np+QtHGvSQS0tMEP7ZnGNxg2NxpLGXDEIJdr
 +OPZmg53EzGxaofo/XTIxueLwzqzqUHw5ChS6w0CsQQziUS19//ttU4iO2/6jwiQhDgh
 yIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1km8OhwSR33fo0xrk/1cnPRG59moZnggMsTBBCFKtRs=;
 b=hd/YVuDCH/UvHrrSpAhQtzjZlq7Io1kZVxEBdgmRRm10jujiIRxWstRPUHYvrZgLAy
 WfETR51gxHOtCGQJl7VE/p66afq9yB4JJDSbv+jjlXyMMUdgFIyCU2/Ic5F9K6KdEV01
 DxWAGq9xDcuLU/I8XGs5TvzZmj0kTYn6dxt4khP4ozMUyE4zbBFJYTsY8gnmq9xTq7SS
 QnCmOpZOImXGZwx9dHKke2Obk5b/bDqiqpHqQRMD8wfeLQxNS/wP/s+9OqjtUjQKeMo/
 9cPxFagCylUHB+APvSO3qtzJZQd0Oe3YEzVAA95nf0Gn6DeOVkeVoU7cYG9i2jasFC76
 zk7Q==
X-Gm-Message-State: AOAM533dNdfkS/12whJYIjyLqFpK7fhzl6nTe1LiUT007rADsPGA+CX+
 zqyrI/w/Ih8cxOfipvp6uFSU3jSUsn/I3cr2QTE=
X-Google-Smtp-Source: ABdhPJzZp6ZmI/zaCi04VDSahm0vhGXpwrioR5R1j/Ym/5AkkiyU156f/hrV0qZJTJhV5hfQ2k0arIBSCxl94B+jyAQ=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr4547060ote.132.1609962402508; 
 Wed, 06 Jan 2021 11:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20210106010515.486545-1-Emily.Deng@amd.com>
In-Reply-To: <20210106010515.486545-1-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jan 2021 14:46:31 -0500
Message-ID: <CADnq5_M5cDYqOZyJJn0K6ngZQoCHk2thEMGt8_XKgLNFcQxL7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add new mode 2560x1440
To: "Emily.Deng" <Emily.Deng@amd.com>
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

On Tue, Jan 5, 2021 at 8:05 PM Emily.Deng <Emily.Deng@amd.com> wrote:
>
> Add one more 2k resolution which appears frequently in market.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index ffcc64ec6473..9810af712cc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -294,7 +294,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>         static const struct mode_size {
>                 int w;
>                 int h;
> -       } common_modes[21] = {
> +       } common_modes[] = {
>                 { 640,  480},
>                 { 720,  480},
>                 { 800,  600},
> @@ -312,13 +312,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
>                 {1600, 1200},
>                 {1920, 1080},
>                 {1920, 1200},
> +               {2560, 1440},
>                 {4096, 3112},
>                 {3656, 2664},
>                 {3840, 2160},
>                 {4096, 2160},
>         };
>
> -       for (i = 0; i < 21; i++) {
> +       for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
>                 mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
>                 drm_mode_probed_add(connector, mode);
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
