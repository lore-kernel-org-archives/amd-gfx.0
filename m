Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35571C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 18:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F520691
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kwnt0ned"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761F520691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8686EB33;
	Wed, 14 Oct 2020 18:53:58 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A3889D02
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=/f2tj7o2fCCAStmJQdH+6DZ0/JQnBrKtT9HE22TGbUo=; b=Kwnt0nedv79S/uFsOAIag9G/P7
 ssDCGqUTBdNGlH/e2PhrjZWhaeJAPaFB1GKxNrmijSW4EuEL0im/RZMXotKfnSoh7lo+nvBudDVAR
 N1rPS/JnqOWpnCueixGy9iW7DEx3FLDDI6nh1yrohOCnrnta9vh6+WkCZQo2LjDW6p3nsoNiDfQCq
 HtjE91IeDDYlinZE6oFxjKyexdWZyFaX9LR5/kUOHhwUI6ubYHLMYBfEFA406SCQs6me/EH/jhUb/
 9tF1D/elccDYAk/rwPSncmFzQzSQRlWQb2WrMsWWdUy3jU4PpciAhNMnuIwjrr23HN/ishU+uvL7j
 68gQX8QA==;
Received: from [2601:1c0:6280:3f0::507c]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSlgW-0000wj-L7; Wed, 14 Oct 2020 18:39:37 +0000
Subject: Re: [PATCH] drm/amdgpu/display: DRM_AMD_DC_DCN3_02 depends on
 DRM_AMD_DC_DCN3_01
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201014175507.973772-1-alexander.deucher@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eae6e70d-c5d2-bab9-4dfb-d48d2696effd@infradead.org>
Date: Wed, 14 Oct 2020 11:39:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014175507.973772-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 14 Oct 2020 18:53:58 +0000
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

On 10/14/20 10:55 AM, Alex Deucher wrote:
> Fix this to avoid build problems if DRM_AMD_DC_DCN3_02 is defined, but
> DRM_AMD_DC_DCN3_01 is not.
> 
> Fixes: 36d26912e8d854 ("drm/amd/display: Add support for DCN302 (v2)")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/gpu/drm/amd/display/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 5906778627f0..93cdcd1ee9ff 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -45,6 +45,7 @@ config DRM_AMD_DC_DCN3_01
>  config DRM_AMD_DC_DCN3_02
>          bool "DCN 3.02 family"
>          depends on DRM_AMD_DC_DCN3_0
> +        depends on DRM_AMD_DC_DCN3_01
>          help
>              Choose this option if you want to have
>              Dimgrey_cavefish support for display engine
> 


-- 
~Randy
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
