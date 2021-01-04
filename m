Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764C2C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B564224DE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B564224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E76895B2;
	Mon,  4 Jan 2021 17:08:22 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B0A895B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 17:08:22 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id r9so26614148otk.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y971lcegaOF8oA87t+LN1eIxI4vsYpzB4JAuLtwgFf8=;
 b=j1xjXT5pc7NOq/hUaQJ2anmLM8XZZ7JBMgTPpgg3wpRAVE3qL63e6+zhWtSsSg3FpL
 oQP67ij6AVPk2atKufW6ggtpEsGXI7aXhbsAn40sC+h9mpBPWC96jDELKrdgmiXz6cP1
 tlel2u92dZBdtVuhuM9Y/xXoYprNfTgpqqox9gK5xXp/m8FjPUmVGzrnOUmaXuRWrTkV
 gutzGFBOf9uvGLd3YFtrtforaU4Bhv9YAPqQfqEV4rRfdKZmZmoGPegH7SswJjwdgrSY
 M3cW+7YIoG2FvnI5cZZPzusicRstPmW6ud2q7+Hnh8XWD4zsCMGHESmd0wQ90qltKQny
 qO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y971lcegaOF8oA87t+LN1eIxI4vsYpzB4JAuLtwgFf8=;
 b=LSYc485GdZUneXzdEQDZ595NCNwn3GQMLxZYB31sMmdQWXIH9XODw62ApJxZNPMjNG
 g64pvfHxDfTQv/6rV7xH/r4dyFj+9/uZXFmNvibL5au0S4eI3zYg7bDStvIyicD+Oxe/
 xb7XpPxLX/pYExrX/Pfdw8rIW5pCKYUeg+9/HO4uK02rkg9Qr1SV6iK0NyEWx4jqMBat
 sGH/WkRFPs5Ga1iZfX1jpslmN3HQoc7LcgVeUGKgY7dIOlc94g3AJsUp4u+OOOQGujug
 EsKPnQDX0SP9bDBpaO55DKoSwBtItmi2Ism8zQ3BSmfrF8ySd5JdVnOhEoIuXQ9+JZwH
 1KCA==
X-Gm-Message-State: AOAM530Vm3A6TeDLXpu4wNTKFQ2+y6uzipjsxB7JMpcNo/lTlXiz3CVM
 J93v2oanysLoKXYrzX6fpXOZi5uFv+P5jDJTy18=
X-Google-Smtp-Source: ABdhPJz0KitZASfniZraJjWrhhAn10vxTAAJ8vQlyy6pFATB38QBfiiHe6hatumLRlwkuFZV3JD5EAcRmuUeMVlYUiE=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr38846565otl.311.1609780101475; 
 Mon, 04 Jan 2021 09:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20201226085607.155289-1-lichenyang@loongson.cn>
In-Reply-To: <20201226085607.155289-1-lichenyang@loongson.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Jan 2021 12:08:10 -0500
Message-ID: <CADnq5_NOsYr0aZxuJxFe=mRivP0KnL0BbCTQ5mzWYy640qkxxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in
 preprocessor if condition
To: Chenyang Li <lichenyang@loongson.cn>
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
 Paul Menzel <pmenzel@molgen.mpg.de>, Chen Guchun <Guchun.Chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sun, Dec 27, 2020 at 3:56 PM Chenyang Li <lichenyang@loongson.cn> wrote:
>
> Add an underscore in amdgpu_trace.h line 24 "_AMDGPU_TRACE_H".
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Chenyang Li <lichenyang@loongson.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index ee9480d14cbc..86cfb3d55477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -21,7 +21,7 @@
>   *
>   */
>
> -#if !defined(_AMDGPU_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#if !defined(_AMDGPU_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
>  #define _AMDGPU_TRACE_H_
>
>  #include <linux/stringify.h>
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
