Return-Path: <SRS0=TD2D=DN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC24CC4363D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 20:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3C62087E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 20:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4ssUvuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3C62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4229A6E58A;
	Tue,  6 Oct 2020 20:52:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0377E6E52A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2020 20:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=l8q5XJeNH8/bVLIXZvnvF8loo3S7vmtNcXgo0ZhJTNs=; b=b4ssUvuOvp56fjYvJtEpG015TG
 xwQAlJLWrrxKXCzLoYtuhYoC/r6ZO/CkZpbSDhWI+gcCxoDd7SUDw7Cnso9ej/3SDMNolFX9FDcWx
 xxqWAWWR3Gp0L6WfEt4+SQ+hcoGWKjbprHgyctpIg6sElW69b97uL3L9S8VGOF1RRxXTpwaK9MbPC
 z9bfK+2KK0rUMw+kG89LCAxuCeJwvOa3oDrJhhyRSDST842/exidcJW3vDt/161QTaFEFiqO4eVkj
 DvXZj2+ZWEVi9h/oWhLGD3tCXfkFf12006J48O6QowWgp4iIKcGDZHTuPO/b7Vc6cobMFuRjks49O
 cj7dcT/Q==;
Received: from [2601:1c0:6280:3f0::44d4]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPtUn-0002Y9-V3; Tue, 06 Oct 2020 20:23:39 +0000
Subject: Re: [PATCH] drm/amdgpu/swsmu: fix ARC build errors
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201006132659.1486610-1-alexander.deucher@amd.com>
 <20201006132659.1486610-2-alexander.deucher@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <816c65cc-23cb-0295-a679-adc0d48091a9@infradead.org>
Date: Tue, 6 Oct 2020 13:23:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006132659.1486610-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 06 Oct 2020 20:52:13 +0000
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
 Vineet Gupta <vgupta@synopsys.com>, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/6/20 6:26 AM, Alex Deucher wrote:
> We want to use the dev_* functions here rather than the pr_* variants.
> Switch to using dev_warn() which mirrors what we do on other asics.
> 
> Fixes the following build errors on ARC:
> 
> ../drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c: In function 'navi10_fill_i2c_req':
> ../arch/arc/include/asm/bug.h:24:2: error: implicit declaration of function 'pr_warn'; did you mean 'drm_warn'? [-Werror=implicit-function-declaration]
> 
> ../drivers/gpu/drm/amd/amdgpu/../powerplay/sienna_cichlid_ppt.c: In function 'sienna_cichlid_fill_i2c_req':
> ../arch/arc/include/asm/bug.h:24:2: error: implicit declaration of function 'pr_warn'; did you mean 'drm_warn'? [-Werror=implicit-function-declaration]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 14 ++++++++++++--
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 14 ++++++++++++--
>  2 files changed, 24 insertions(+), 4 deletions(-)

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


-- 
~Randy
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
