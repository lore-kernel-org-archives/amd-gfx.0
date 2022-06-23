Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E1C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 20:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B085410E360;
	Thu, 23 Jun 2022 20:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694D810E760
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=FSMg2Z7yO0AcWYQ2gWnef9GPN8JvwvL0049CciGXkhQ=; b=47o098vAIvp02jqSoWGX2uS/Cm
 10e9UlhtbQoMVH78coRqkO/K06s/40+49doNoAxwtWQnabRjgKC51GhrInqJyR/0Ih61BMbNgechN
 /GQp6Q+qRl4eYz796mv5wLVWpW02RYF8NosqID9MCcDDHHvaJ3II1/N+y3LXl0IqvbGIbje8Zzu1M
 /QVRCcIqwFhnX8YxWyjYGPsF/D5Y5V4nFr4pgoRECbfM8gAelCZ8vinMoWPSCaF0rY1M71GmvvoRw
 qyZwpf9m37ec4jXBkM/fz6k+QlmcHB/3MB1V6BGChKgez16N3p6aIw42vn/lZUQuCmwVvEn8oKvo+
 HuDR16sg==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o4Sz4-00GeSN-Cy; Thu, 23 Jun 2022 19:59:22 +0000
Message-ID: <082d7355-819e-a1a3-7d41-0e642a302e35@infradead.org>
Date: Thu, 23 Jun 2022 12:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: Tree for Jun 23 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220623165724.42f9bf9b@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220623165724.42f9bf9b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 23 Jun 2022 20:05:34 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/22 23:57, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220622:
> 
> 
> The amdgpu tree lost its build failure.
> The amdgpu tree gained a semantic conflict against the driver-core tree.
> 

on i386:

ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!


-- 
~Randy
