Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D8C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603D3208B6
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM/PXE7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603D3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F115D6ED58;
	Fri, 25 Sep 2020 21:18:18 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C8F6ED58
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 21:18:17 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c18so5332974wrm.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rBj0wekxF1nf6zeYJf9lJIqnWaBS/Sfh98W2SeWrWl4=;
 b=aM/PXE7cCBJqsUn2mJ3l/zKp2qGoCq5SJKoL0RekSXQJTvEoNS9O0Rt9TPwNH7Kfs9
 6THYuUXD/4PtarEY2RCjF9KGTeZ8F0mO4Um5ehmB9DesFbgzb+u/n4/4NVKRdWSiKlXx
 qgavGnM8LSaib89Bm7EeqcZt8jz1xjc1hhMNtTn5ubikpmhwdWNe9OgKBhqhpNwxKzBF
 h6Ytw/6hTXUixj+ddPri1XgNhdADiacmotA/1G/a4NDA/AsSgYgdmg/sHqq9WFRPH4Cy
 oK4/unPoRBMcfgrJ+jwJlC+aLMP+D8bIK7JMEPWxYs0B6V31UbAJtiCPk+ior6/lwD5v
 cUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rBj0wekxF1nf6zeYJf9lJIqnWaBS/Sfh98W2SeWrWl4=;
 b=izAKcrYS0ZqpUYZSyldnxTGrHPNJzAVWk1/e371H8xYyX0xuIkYUcXwudLli2PApYr
 Ml2UGG9w0iBINEaT4bKpuELQbyi5GT+ZPqKn2ESR/sEjqTx4b/R7g6xHG5x70aieyu/O
 4zwDRhE8vg+DgtwnLolCw+F+TYGqXjes0WcCSfuW3oifYV75gFmj5l+IUdMVaiMz7bmo
 vq5bu7Hc636ls8VHe8Olw2OHfD7EI+om1V+9BUy4niN4YbSzOsZHMve7pvSxH/RYp+Qp
 63VTYM6ncm9CTa/01Qqwhh89NYnP8ENMhveE1MPcq9qBn/3YzzviRZp8zbPUdZ6QxKPI
 rcTQ==
X-Gm-Message-State: AOAM532wJcLti7cqRgMqNO2zFams56PRhMSBbgd6Io5aoAYf/6HQfkeH
 XwVBoad2AuflA5rUm/gYtZIPzFeTvTAyxGI+Bn9xpFqY
X-Google-Smtp-Source: ABdhPJxJcvnodG/1lpldAitCD7Gf23KKGu75gL2V4X1vcAOvSrVECqUMA+CmVBTH6KvsGyTkEdi+fX1/lj5uuMnvUcE=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr6370252wrr.111.1601068696702; 
 Fri, 25 Sep 2020 14:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
In-Reply-To: <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2020 17:18:05 -0400
Message-ID: <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: James Ettle <james@ettle.org.uk>
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <hwentlan@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 22, 2020 at 4:51 PM James Ettle <james@ettle.org.uk> wrote:
>
> On 22/09/2020 21:33, Alex Deucher wrote:
> >> +/**
> >> + * DOC: pixel_encoding (string)
> >> + * Specify the initial pixel encoding used by a connector.
> >> + */
> >> +static char amdgpu_pixel_encoding[MAX_INPUT];
> >> +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
> >> +module_param_string(pixel_encoding, amdgpu_pixel_encoding, sizeof(amdgpu_pixel_encoding), 0444);
> >
> > You can drop this part.  We don't need a module parameter if we have a
> > kms property.
> >
> > Alex
>
> OK, but is there then an alternative means of setting the pixel encoding to be used immediately on boot or when amdgpu loads? Also are there user tools other than xrandr to change a KMS property, for Wayland and console users?

You can force some things on the kernel command line, but I don't
recall whether that includes kms properties or not.  As for ways to
change properties, the KMS API provides a way.  those are exposed via
randr when using X.  When using wayland compositors, it depends on the
compositor.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
