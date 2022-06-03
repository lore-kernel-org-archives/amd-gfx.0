Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98879C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 19:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B7410F235;
	Fri,  3 Jun 2022 19:41:00 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC0F10F235
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 19:40:59 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 30-20020a9d0121000000b0060ae97b9967so6237434otu.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RCdJwDFPyi60ELfo8SyOKJtwk/It1tYmKPwKmsHcwEw=;
 b=CEUQ7Xs47xxxB7fQL0hxmi+CzjVMkr/TGer2vl5gGqeNMfb0TDQalMTeMLQcXpXuyL
 eGqNGkP+bdBTqhQ5CQLkQmp8+L89nMU6njr7wr3IdTZMCYt8C1zRuuKUnDffay7qN5dK
 38GUfuUh+57xY+FkakdVUvPL8u3eeVMy79wLxpyip7b0DYSNhHPmUuRrBCikMmlB7QpN
 i52eNV6kZNGmUV4crVHSv+38wRmnhExbyPUjClf31cJfyog4zWyViRg1f90oXIbj6wKr
 LmtiUCUTMndDwG2QRhw/R6HrGgIsF15OnAqSYZKlfCjr9SdloW+/HafEtouveDEP3UMI
 BFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RCdJwDFPyi60ELfo8SyOKJtwk/It1tYmKPwKmsHcwEw=;
 b=NaF9CUr1SyHyzULV4Co0Y/e6js/F8HvStQCBo+NfZeHxYjQykXRcZj4izV36VcvG8t
 rDiK/aAhp/hMIzoYZqr5GbxwPxRqFo+fRZJ9JQuHzcd/JblyRiOp8hqXkqlUxwmU/mQ7
 E2foJq83UKMgrRGKYhefAX+uki9Q6eo1rIFWSzRY5uRAgHV1uD1SgLXKojlRvKW2I5eb
 DDi6f9IXSGKs1tU3B5x9NnGuCiwzQA9TeRPVU1J2dkTJ+Lw0xpwc9siRP+7bIfBpMG2y
 vt0tZ6tYw633fO0EJdP0QnMPKTNF9Iaua/Qz2enkMKIlxkZU0m7AcMLJAMDLTx19EwEh
 5l8w==
X-Gm-Message-State: AOAM533YtKL+2GDu3V+sM82xoB/WlXlqs4z10wS8Xv1Sojm3YmvRgcuZ
 ZRgS74JC3lNA5NUsAGDCJOWM7wayGCA4/J6KCGY=
X-Google-Smtp-Source: ABdhPJyVewOtYJqZVKqzuBLjkgG4fyx2GlSdtuKkuVNxxgxCr2G2HDievS1CiO8RI0uRvRgFDM8PzFcrWL/jGLi9J3k=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr4872364otq.357.1654285258024; Fri, 03
 Jun 2022 12:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Jun 2022 15:40:46 -0400
Message-ID: <CADnq5_OusgUf+-Vtkky+mvpyy6Sr2zrC_ARLBe5-jtKi3DVidg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Cleaning up some GCC warnings and other minor issues
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 3, 2022 at 2:51 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> It looks like that we have some new warnings on display code and a
> compilation error when using allmodconfig. This series clean up some of
> the DML warnings and fix the compilation problem with allmodeconfig.
>
> Thanks
>
> Rodrigo Siqueira (6):
>   drm/amd/display: Remove duplicated macro
>   drm/amd/display: Reduce frame size in the bouding box for DCN20
>   drm/amd/display: Reduce frame size in the bouding box for DCN301
>   drm/amd/display: Reduce frame size in the bouding box for DCN31/316
>   drm/amd/display: Reduce frame size in the bouding box for DCN21
>   Revert "drm/amd/display: Drop unnecessary guard from DC resource"

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 67 +++++++++----------
>  .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 30 ++++-----
>  .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 58 +++++++---------
>  .../gpu/drm/amd/display/include/dal_asic_id.h |  6 --
>  5 files changed, 72 insertions(+), 91 deletions(-)
>
> --
> 2.25.1
>
