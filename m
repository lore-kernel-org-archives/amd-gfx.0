Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F69C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 05:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CB42053B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 05:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLqNJfGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CB42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932756E1BD;
	Wed,  1 Jul 2020 05:33:14 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F126E1BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 05:33:13 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f18so14376866wrs.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ao//83C1Xejq6HdIflw687LNRmxMJnlIJk1YJtdFB/0=;
 b=sLqNJfGLK++vzRS32khXAMctOuLD3J9lQRh6bSCObhIpIpQc9vTrHEXIgyF3YY3KxP
 QU7/1XHRNia7k+YT/ep01J0L+6GYId7zDB0IN3/L4FucJBXXQxzTBwtlywtvZVR83zkY
 2NrDk/bAO80yKALV7zlDeXexuKfpZ8/Rlhnz6/T1CXFhxRfFJ7bcLDmJDfw789V1I8xD
 xPqtIFDnsC0jEAKLYGIpmeeywGPFWAj9f/mlYGvs9RX1B6HFnIShRiZzh6pJtjzmlYSd
 DRHKnF8SawZPRH/SqZZADg0b6ISR7eK8hrUchdtA6nTSMM1G9jQiSH3cV4Dx5C2JHSe7
 Jvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ao//83C1Xejq6HdIflw687LNRmxMJnlIJk1YJtdFB/0=;
 b=rC/wC9hA+nQxykkPTwEqlfpl3gAuybNG0pWgyhdrP4YPj3kPZMoSKjSFlfJE66a4fa
 2dZaamEWXFX/XUVqRmsd1BqZqBgwvy5ozzNq1z9K/Y8QofJrfFa4ta04hM26VVyPOFi3
 BAC7e9g7hK5Q2/jZdEYF2Gld3aQ2VUsVQkOP/RuzUm3szT1Qi9MAn2BNudCfG8/m2EkP
 9gpfPuhZFjeAvGXLbsQ3sImcm6qkcdRZEvIJsbDqMM+XOy5jzwDo/NxIE4154Uz7/DiC
 dCgL+Ng3tAkCXOQXifx4Hl5lD3nWxfxy1gIYZlH68OetSX7FyP4ZzJLRDSHLYX3zMV7i
 tW2A==
X-Gm-Message-State: AOAM532p89cLMg8nE5n790yIFw2Ylrpx9Q7vwInVbyRi7FXig3voJmO7
 25CBgWAfv7Adil3+eslQcpe/an5e8KFuev74G97rtQ==
X-Google-Smtp-Source: ABdhPJyvKupBWry++aCtRN+C6LqN1MoxMBubduV9kMjmehby9dCh4PKghAGWe67kHkAgO3aj/JTWrv4PJZYLn0JLSgk=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr26608379wro.124.1593581591875; 
 Tue, 30 Jun 2020 22:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220453.1367084-1-alexander.deucher@amd.com>
In-Reply-To: <20200625220453.1367084-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jul 2020 01:33:00 -0400
Message-ID: <CADnq5_N215YKdJoFvrHdajKzbzfjOuwjvtAk56VCO-AGkiGdjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/atomfirmware: fix vram_info fetching for
 renoir
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

On Thu, Jun 25, 2020 at 6:05 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Renoir uses integrated_system_info table v12.  The table
> has the same layout as v11 with respect to this data.  Just
> reuse the existing code for v12 for stable.
>
> Fixes incorrectly reported vram info in the driver output.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index e249b22fef54..4b8aad1c0b51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -206,6 +206,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>                                 (mode_info->atom_context->bios + data_offset);
>                         switch (crev) {
>                         case 11:
> +                       case 12:
>                                 mem_channel_number = igp_info->v11.umachannelnumber;
>                                 /* channel width is 64 */
>                                 if (vram_width)
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
