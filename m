Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664DEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1B360F35
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F1B360F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C546E4AF;
	Mon, 11 Oct 2021 13:16:19 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A6B6E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 13:16:17 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id a3so24607222oid.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nauhTuxi6fmKdy45+iePysuA9UDO88zWPFm5RApGZkA=;
 b=TVDFVRiMy13Yr4dqMx5FRs5p0KngLmRmSuUjUClOfGtW+nDPqwgo5t6NxArTqhIYIY
 LDGhOAkIGGbjpXIAuCzU5K9+nC7J3/QXhxmERFjhO6vGNee5CDCrv3TfP+G3+jE7KWKt
 eFC+Q6KBAXLyerGaY5PKSiXhM2aPm1jbPrsMNfepbyvb4FsmTqxiWDx00hPLDlmfjGEq
 i5Bix2WTzhkczbZfr37mwS+hnzMKKMKqbg7mUdphfcb5oiSc7WbxrQwApxKTh8o0Upi1
 x60lXkEqaaGJuO+Qr2sK5245YVvkRrTTU1q+6BxoLC1L5wnSYm2eSH4YDVcy2nzwwsQq
 qagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nauhTuxi6fmKdy45+iePysuA9UDO88zWPFm5RApGZkA=;
 b=Jz7WgZRppsXShYkoguZHf44tKYpI+hnSUCpnlXYCuoM3ViTKhI+V1yFvGGgKW7Ifv5
 J7/20PVHn/I3FzUTO0d0XGhcNl3Du00W9Sem7VaKjFtwdA+c4lOeT6WVYtALRIOFzwmQ
 carTlAJDsqSgwgmgrvWSBLi53fkhH4KvLTo64TngBcI/ZaWmP76YQl2vZMlhlR+WsDar
 2tebjKNRCMlzK/0WwrRv/urqFNF3kl6xTKaN9jRnZqS7K1RnuKVJJbNgJrHDzF28F2+4
 3LPjCFh0K+ja/BmAUTm5x73xfb2f30SihQbJGEEe190UYpBB0lgOHUKBYGZdIPYJrKE4
 jfIg==
X-Gm-Message-State: AOAM532oKTTpAuE0MTjqo9MP5/U3STkSGkV80RoWgbAmZ4EVixdlNQgR
 Cdr7sEJ5/IlpwmWixzfl61LBfts6kDPiTT9XqqcpwkYQjjc=
X-Google-Smtp-Source: ABdhPJwt3KaKI77LM/Xa4syOq1sW3PJAiTEqFEjUcRskI382EWpdR3O9Dx6Cn2fjkAABtNh5Wzk7mf8THuwLIambeKQ=
X-Received: by 2002:aca:4587:: with SMTP id s129mr26198771oia.5.1633958176804; 
 Mon, 11 Oct 2021 06:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211008212122.230566-1-harry.wentland@amd.com>
In-Reply-To: <20211008212122.230566-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Oct 2021 09:16:05 -0400
Message-ID: <CADnq5_PSr=1qP7qVoVnH_KzDDG4BVORSYpZfgJ47EkWmZtMEaQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Siqueira for AMD DC
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 "Siqueira, Rodrigo" <rodrigo.siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Oct 8, 2021 at 5:21 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> He's been helping maintain it for quite a while now. Make
> it official.
>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24d520c4b157..b107ddb306de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -876,6 +876,7 @@ F:  include/uapi/linux/psp-sev.h
>  AMD DISPLAY CORE
>  M:     Harry Wentland <harry.wentland@amd.com>
>  M:     Leo Li <sunpeng.li@amd.com>
> +M:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>  L:     amd-gfx@lists.freedesktop.org
>  S:     Supported
>  T:     git https://gitlab.freedesktop.org/agd5f/linux.git
> --
> 2.33.0
>
