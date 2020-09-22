Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE01C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D25239D2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw2IvrJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D25239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968C36E895;
	Tue, 22 Sep 2020 15:38:21 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8F66E895
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 15:38:19 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id s13so3801965wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDTzR527JqAakxyGl0Km5kB9ru0gbQm+hoO44ofmoA0=;
 b=cw2IvrJNdoteD6W/canzidONhSX3WxKH+OnZ3cjhkovb2qWNebKS4qje0V8YqmFffR
 HnewDLqMbPGn2p/0KeHr5CBX6Lx8QY6Sl9sRsIbY57GDBz8gW78Giumo/86YxwZG8XhR
 MoAWZHvHfHD4HXitGDIZuifebp/tZSDbL0gjrQtFAM7NOrAMJuzbZCmV2Qbz6NG6B3v+
 hcPD9M39koZ59iBNikuRQarF7BwM3XRWyqGyKp6djVIZDJT4otIIpNiwl1pL/XLkL7vv
 acZc7GXcVVTzN5gRH5Zx9IEAaqkq6bdP/vgZppd5wpyBZ1eBHEbJyr7IZheIKraRO8+p
 mlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDTzR527JqAakxyGl0Km5kB9ru0gbQm+hoO44ofmoA0=;
 b=E9FDVpZyUXdU5Xt6pOdx+tWEgGj6C/vx/oVTiZf1HhL+wov9cUQRfzsMHvgr5rAvs6
 c92oTNw5Qd7IrTWAVPsMvXhFMLQIotcYCv136jOMN+GKBUYOSMR05D6oSQqJx83b3sWE
 4eUJGx+N0soCl3LMpIMKx/KQNIZDkeZGuzyCeuuwsBCqtkMf1ZciIkntgPE2PKQ7/8RI
 4laxh0tSMeakOvvPQvnG401Te0JWDgFoSyzX2h7F+utXqVDot8OFbaHttMlwMSaH0Xef
 GnBWOhM/C/FW2AuCKXo6oinGG7zdrkuO1MgAQV3C42Mb///GzCQRcz9PedJRrhL2qnkJ
 4/wg==
X-Gm-Message-State: AOAM5320Tlw7UJJIldLJiZTEjhuB5+u0uvF7t15P5HIw3C3NrQaUZcpI
 VXdRIZ4t4h1JLJLAQiD2OyqpOU2tfV3cwUJcm5E=
X-Google-Smtp-Source: ABdhPJyZ0dKEE39b5vCfSaK6QCYA0JkPpm7H6kgBCdxB8lFHn6eLJUchIpSt4BEMNSC8s3O+MVXaSYCdR0yshl9hxnA=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr1667495wmi.79.1600789098613;
 Tue, 22 Sep 2020 08:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADBwLwpTrsaBL_=U=4Oe5zDAEuc5qJV61rb3F-Zrr=Sn6G3uLw@mail.gmail.com>
In-Reply-To: <CADBwLwpTrsaBL_=U=4Oe5zDAEuc5qJV61rb3F-Zrr=Sn6G3uLw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2020 11:38:07 -0400
Message-ID: <CADnq5_PHMfQAb6SkiaQ7CkHgke945rFjzyos0xiaf=gotgiUeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix dcn30_optc.o unknown argument with
 clang
To: Anthony Benware <hyperkvmx86@gmail.com>
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

On Mon, Sep 21, 2020 at 6:12 PM Anthony Benware <hyperkvmx86@gmail.com> wrote:
>
> [Why]
> Clang can't compile dcn30_optc.o with '-mpreferred-stack-boundary=4'
>
> [How]
> use '-mstack-alignment=4' if Clang is CC and '-mpreferred-stack-boundary=4' if CC is not Clang
>
> Signed-off-by: Anthony Benware <hyperkvmx86@gmail.com>

Thanks for the patch.  I just sent a slightly different one to fix
this up properly with clang and older versions of gcc.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index 025637a83c3b..fcded5498393 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -31,7 +31,11 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>         dcn30_dio_link_encoder.o dcn30_resource.o
>
>
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mstack-alignment=4
> +else
>  CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +endif
>
>  CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
>  ifdef CONFIG_CC_IS_GCC
> --
> 2.28.0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
