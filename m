Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978A9C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 21:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D3510FBD3;
	Thu, 30 Jun 2022 21:48:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4724B112389
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=A3V6UKwCYMxyP2P2EKQsUvnT4PsS1dPG+eOzF0lwulo=; b=udyfgSPNC2FJ6YBG+Xe4n+FvRg
 v81cKaP1snFM5kaRhoGgr9FdKlOTwlhlJSESNY9h2Xc6fsPF/TGAC1JL4HrDYO/61saABvjA0weDH
 6NV9AbL9vUJ82bpaZ5YlPWiMwGhPjVpP8tN4CGsppWSg7X1rP4UNTK3w94eMHeyz4K/rzfNMjlRNG
 iz7Bolq+W8yqVlur0tbUck/JBDjrHtXfJ5rE4N9z/WLovtDsjtGvjgFYngFkzonIAn2ciCYFg6VPf
 J2LKs/tCqsMA8y7InZ5Q3rblEypgPuKVvNHQ1wTwfAHdUWkYbLtV8GJWbBn/9qjIEHQB8ZOxZ/Ee4
 LC8vJMdg==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o71zM-001gaw-Ob; Thu, 30 Jun 2022 21:46:16 +0000
Message-ID: <bc4a6200-6114-e89f-a7f1-4a76d0d67515@infradead.org>
Date: Thu, 30 Jun 2022 14:46:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] Fix compilation issues when using i386
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_M0Ec4dOD0JE+wYq4oCLJkJVZuCkr8D4c3CdcDSik-E2Q@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADnq5_M0Ec4dOD0JE+wYq4oCLJkJVZuCkr8D4c3CdcDSik-E2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jun 2022 21:48:58 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi--

On 6/30/22 11:58, Alex Deucher wrote:
> On Thu, Jun 30, 2022 at 2:46 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> Fix compilation issues when using i386
>>
>> We recently got feedback from Randy about issues in the x86-32
>> compilation.I was able to reproduce a very similar issue by using:
>>
>> - gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
>> - make -j16 ARCH=i386
>> - amd-staging-drm-next
>>
>> I'm able to see these issues:
>>
>> ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> This patchset addresses each compilation issue in its own patch since I
>> want to have an easy way to bisect display code in case of regressions.
>> Please, let me know if you see any issue with these changes and if it
>> fixes the 32-bit compilation. If you still see compilation issues,
>> please, report:
>>
>> - GCC version
>> - Config file
>> - Branch
>>
>> Thanks
>> Siqueira
>>
>> Rodrigo Siqueira (4):
>>   drm/amd/display: Fix __umoddi3 undefined for 32 bit compilation
>>   drm/amd/display: Fix __floatunsidf undefined for 32 bit compilation
>>   drm/amd/display: Fix __muldf3 undefined for 32 bit compilation
>>   drm/amd/display: Fix __nedf2 undefined for 32 bit compilation
> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> 
> I think this patch is also relevant, if someone can review it as well:
> https://patchwork.freedesktop.org/patch/491429/
> 
> Alex
> 
>>
>>  .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 +++++++++------
>>  .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  4 +++-
>>  drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 +-
>>  3 files changed, 13 insertions(+), 8 deletions(-)
>>
>> --
>> 2.25.1
>>

-- 
~Randy
