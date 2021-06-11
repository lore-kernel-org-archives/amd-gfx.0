Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D4C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 16:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2515613BA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 16:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2515613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596EA6E82D;
	Fri, 11 Jun 2021 16:55:45 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D470C6E820
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 16:55:43 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so3779013otl.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qPeFWdSGUwPoLTtvdw+t3PTmisXJgjO/+2CUFTVvAnI=;
 b=XUkvVJHchQ+kAk+yIhaQge+ivcPZrMPs7PgXCmX/KvJOXnvFC9AlX8qrDopPUUqgFJ
 A6cWKqh0x2utyk0nrTYQ4xUF5IJfRxLrlUciJqc8HFJcyu+Tw2KDpt9TWXQ4Pk9SIvqC
 Ar7OJXl4mE/jWN5B6qYD0/9UgPaT8WS7GbxhxU6fFTgAPOc2NLJEHbnPWlTnhOO0dbjZ
 AaQMVp7DbrsJuV2h/4Qdzvb/PjPrwooKJpbp67YZpyhqzGF9VLwejTfS4NDUN22qelmo
 Sm2JJt1Pce+MFa1jKQXzEZr1e5LCkDnsZHAmvieRHEfRMiQX90yxi2f4tAb3XlchkPbN
 k+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qPeFWdSGUwPoLTtvdw+t3PTmisXJgjO/+2CUFTVvAnI=;
 b=SpnVB9vFzXqQxKkX/ZiqSN+slSkplW1iNMK4lCrfqStdZx8+ljYY4vTAXqntcIuMt0
 4XA33qs8LYl/KtSeZdpfFxdOVpgjUrZ8/M4hVYizNNSZE/8/XfNkyARGOzuNn8SvNeRo
 SfRsYSmqhzp+5Ajv7eAGkyPBjbkt70YjNL0Qo/ufhixuNVARZ0XNxXqOyf5JKAJkdFSW
 W/wXnWq/04tH0KvKD5ctQ8M7aXSkokQ++at/FClXfCmus3bUIol+7/jlnJtOJUX0/XcO
 8DGvjGCR9xFX+ND1KhuCGcbtEcP4K2bYXSnxrKAju/481av8smW1MB5i02G2iX8ea6Rg
 dzIA==
X-Gm-Message-State: AOAM530DEhrd3TVnf5vDNdWM7/Es3uuxkTmWNToV7jVXaC+94gFF+QK8
 HFuvAWGczrYHuMFt44hyePR5vFkgzCONP8aG0Kk=
X-Google-Smtp-Source: ABdhPJyBS//Oq4DVmHLeNXOXVkN5codPHnBakK9v3hzJfJ7UcklZvbDU79heU6Lgoci8wYJYWHS5FK4k55lHB8ITY3M=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr4020375otk.132.1623430543221; 
 Fri, 11 Jun 2021 09:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210611154839.109966-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210611154839.109966-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jun 2021 12:55:32 -0400
Message-ID: <CADnq5_NC0_9+noqbqvm9u9QY-p1igpsv8YRHs9th96bn-a2rDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add dummy PG callback for beige goby
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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

On Fri, Jun 11, 2021 at 11:48 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> PG registers are absent in beige goby, so programming these registers
> generate call trace. Fix this by adding a dummy function in dcn303
> initialization function which prevents writing to non existant registers.
>
> Fixes: 54f910c6372e ("drm/amd/display: Initial DC support for Beige Goby")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c | 5 +++++
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c  | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
> index dc33ec8b7bdb..b48b732aa647 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
> @@ -38,3 +38,8 @@ void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool po
>  {
>         /*DCN303 removes PG registers*/
>  }
> +
> +void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
> +{
> +       /*DCN303 removes PG registers*/
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
> index fc6cab720b6d..8b69a3b76c11 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
> @@ -13,5 +13,6 @@
>  void dcn303_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
>  void dcn303_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
>  void dcn303_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on);
> +void dcn303_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
>
>  #endif /* __DC_HWSS_DCN303_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> index 86d4b303d02f..aa5dbbade2bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> @@ -16,4 +16,5 @@ void dcn303_hw_sequencer_construct(struct dc *dc)
>         dc->hwseq->funcs.dpp_pg_control = dcn303_dpp_pg_control;
>         dc->hwseq->funcs.hubp_pg_control = dcn303_hubp_pg_control;
>         dc->hwseq->funcs.dsc_pg_control = dcn303_dsc_pg_control;
> +       dc->hwseq->funcs.enable_power_gating_plane = dcn303_enable_power_gating_plane;
>  }
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
