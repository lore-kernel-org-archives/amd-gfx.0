Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE37DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 20:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB3510E2F2;
	Mon, 19 Dec 2022 20:01:20 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E75710E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 14:00:47 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07B7F1EC06AC;
 Mon, 19 Dec 2022 15:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1671458412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrHMlGgXxTJ73LUp4i2Ab7rukdZMdTS7BAX5vUFcTHM=;
 b=lwe1ptVIQxAbLiuQVjZC5aUxo1u/bnCRrd/OGuBD8eLNpAtiFxTFoHYKjPTjj3OIr4NsCi
 QjQlyltzDJLCEPEFfvcefYqQv3+dq/PS8BIFglOibj3haGZdtPpzivLxaopCmIUl0R6zNC
 HBtePaHIYq3zTCGMxCRP0EK1dZKFZJE=
Date: Mon, 19 Dec 2022 15:00:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Message-ID: <Y6BuZ2jv8n9dEVxS@zn.tnic>
References: <20221219104718.21677-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221219104718.21677-1-christian.koenig@amd.com>
X-Mailman-Approved-At: Mon, 19 Dec 2022 20:01:12 +0000
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
Cc: mikhail.v.gavrilov@gmail.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 19, 2022 at 11:47:18AM +0100, Christian König wrote:
> That function consumes the reference.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM updates")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, that fixes it.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
