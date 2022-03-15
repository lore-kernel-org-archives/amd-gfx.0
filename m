Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A66C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 16:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04AA89F8E;
	Tue, 15 Mar 2022 16:17:25 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EC489F8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 16:17:25 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 801E461EA1928;
 Tue, 15 Mar 2022 17:17:23 +0100 (CET)
Message-ID: <cf500efa-1e16-9109-e724-017d2ede2e23@molgen.mpg.de>
Date: Tue, 15 Mar 2022 17:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test
 robot
Content-Language: en-US
To: Yi Peng Chai <YiPeng.Chai@amd.com>
References: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Yi Peng,


Am 14.03.22 um 06:52 schrieb yipechai:

Please use imperative mood in the commit message summary:

 > drm/amdgpu: Fix kernel test robot warnings

But, for the reader of `git log --oneline` it’s totally unclear, what 
these warnings are, and they need to take a look at the patch. For the 
summary it does not matter, who reported it, so the better suited 
summary would have been something like below:

 > drm/amdgpu: Remove unused amdgpu_mmhub_ras_fini() and 
amdgpu_hdp_ras_fini()

> The reported warnings are as follows:
>    1.warning:no-previous-prototype-for-amdgpu_hdp_ras_fini.
>    2.warning:no-previous-prototype-for-amdgpu_mmhub_ras_fini.

Please add a space after the enumeration bullet number.

> Amdgpu_hdp_ras_fini and amdgpu_mmhub_ras_fini are unused
> in the code, they are the only functions in amdgpu_hdp.c
> and amdgpu_mmhub.c. After removing these two functions,
> both amdgpu_hdp.c and amdgpu_mmhub.c are empty, so these
> two files can be deleted to fix the warning.
> 
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>

Please configure your full name.

Also the kernel test robot asks to add the tag below:

Reported-by: kernel test robot <lkp@intel.com>

Also a Fixes tag with the commit actually introducing the warning would 
have been nice.

[…]


Kind regards,

Paul
