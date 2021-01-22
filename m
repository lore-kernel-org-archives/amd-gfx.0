Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA5C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07554239D4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07554239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EB76E9FB;
	Fri, 22 Jan 2021 15:23:22 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1766E9FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 15:23:21 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id k8so5369139otr.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SgYomEdafMl4sBu6B5QVO1dtCJF2kSRapuZfCFC0JN8=;
 b=IIqAwJJ9RG2bMg3zuixGZs7/yRjNOH2fjHfYDUNTyfPDqWSyDJV08tWaNp3ZepJrXO
 WAgSm78N0e/AcWKAFuzomaU6JsCzzWAxnCKRtFL0kl4wwB4e+6PLrjIbtLVX99/QBYWU
 /9Xim9et2V8eqULf7SHl5oxlieY7xjo3bnQiCYQqjUY/7E0m6IAD+ZvWLWiPExYi0cmq
 mzF6+TVJ0WAy4zSiNOg8wboob0KTQKjTu2/SlkAl48nO+k0Oy3FI/gElrs5VSsnz6SZJ
 QXMTlbS6oeCzXs/CCXZYn8KTIF7gUuVzmlGPIVj33cNcV+nHRcu/smYykcbuDlSIwOZo
 D5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SgYomEdafMl4sBu6B5QVO1dtCJF2kSRapuZfCFC0JN8=;
 b=c6BoZBMjK+SwXL9uQaEkyg5JElDRknEIMAUh59iubr2+MAknbwZhYOPgqyR/q4oC3+
 0TP4wgbkPX049al8ydzTCDlCCFsDJZP04HIgAXRwqoEGFxs+s8GXynYXqW84UOZDsncl
 wahC/m+euHkZJC5FS+yvsPKo/yDMg4qqO0lsYs8tTMuozA2MfThbWXCJz8+tJe98fnRb
 lX68Ee1KMxcQkh02jdo/9lTrOgw/PVPHiwmHHIyM83c25RxD3FYTvVZB18csNr+BoHoA
 2wkg8nR8AkIEnNjCBhSm2bkKJnXet6SK15uwgmIENocJyl0+OQG1Zk0E1sQpYNCPZxaa
 SHMA==
X-Gm-Message-State: AOAM530VyIZNnnv4GU0iF9n8bKTekXOw70fAMjciYAx+0ilpK3JRJWG6
 fhBJ9TXPqZbxFBv+fUatqRVk7DGxs6I2igRRW+7Q5ahM
X-Google-Smtp-Source: ABdhPJzkTYNcjSd+7QCgeD+RQjDBnaWGMkbYRvW4Vh521gz3ekQhMdQ8E5LlKEROQXNHhpedme+PVLD6345QGzQufhw=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr3828270otm.132.1611329000534; 
 Fri, 22 Jan 2021 07:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20210122150439.15911-1-sonny.jiang@amd.com>
In-Reply-To: <20210122150439.15911-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jan 2021 10:23:09 -0500
Message-ID: <CADnq5_O-egBCuR8OC1u4-5uPy3wuUmSmV4jn6XYtUECLkyzkVA@mail.gmail.com>
Subject: Re: [PATCH] tests/amdgpu/vcn: clean abundant codes
To: Sonny Jiang <sonny.jiang@amd.com>
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

Please open a libdrm MR for libdrm updates.

Alex

On Fri, Jan 22, 2021 at 10:05 AM Sonny Jiang <sonny.jiang@amd.com> wrote:
>
> Remove useless codes.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  tests/amdgpu/vcn_tests.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
> index 0f5b4241..1ca66297 100644
> --- a/tests/amdgpu/vcn_tests.c
> +++ b/tests/amdgpu/vcn_tests.c
> @@ -102,8 +102,6 @@ CU_BOOL suite_vcn_tests_enable(void)
>                 return CU_FALSE;
>
>         family_id = device_handle->info.family_id;
> -       chip_rev = device_handle->info.chip_rev;
> -       chip_id = device_handle->info.chip_external_rev;
>         asic_id = device_handle->info.asic_id;
>         chip_rev = device_handle->info.chip_rev;
>         chip_id = device_handle->info.chip_external_rev;
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
