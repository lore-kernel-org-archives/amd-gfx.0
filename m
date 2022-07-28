Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01839C19F2B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C43D10FDD2;
	Fri, 29 Jul 2022 14:16:20 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4685011B9B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 22:48:48 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lv5RF24Lmz4x1Y;
 Fri, 29 Jul 2022 08:48:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1659048523;
 bh=mwPzqIV4UuXxDn6ljSWvgbOCpVyOwUH09MPyk56EBOY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RZVg5oFBMFfW8k8XO5aOVbeu35E+PfLdXIM2yghnEKGgywisWyrlFhogBVqOVYxI+
 RWcpCp2CHVFxCoiI2pSsz5DPjNWy7J8EIiCktFnkVywD07oWrGzek9j+Aqdnkmwe84
 5gLtD3n7i7XTNzKaNuxFiBNB0+KlJ1f2wd5ruTU+WZ83D4RW+yBS7MYEETLwUgIbz7
 NxjY6pIHzl7sfJEpR0wuzvQJLVZdB+09bRGaEG9rb3gqwFL4CpiUfMXqDZ0S9B2mG+
 DQpWvqnbffgckswIS/axHUP5DokaaZbkV/cKWoRmpGGEoW+DIpiXL0rg1P2dXDgzsX
 190CUnzFVeLSQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
In-Reply-To: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
References: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
Date: Fri, 29 Jul 2022 08:48:40 +1000
Message-ID: <87y1wcc0qf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 29 Jul 2022 14:16:19 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> writes:
> We got a report from Stephen/Michael that the PowerPC build was failing
> with the following error:
>
> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
>
> This error happened because of the function optc3_set_vrr_m_const. This
> function expects a double as a parameter in a code that is not allowed
> to have FPU operations. After further investigation, it became clear
> that optc3_set_vrr_m_const was never invoked, so we can safely drop this
> function and fix the ld issue.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c        | 8 --------
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h        | 3 ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c        | 1 -
>  drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 --
>  4 files changed, 14 deletions(-)

Thanks, that fixes the build issue for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
