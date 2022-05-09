Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26229C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 11:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5657110EAA6;
	Mon,  9 May 2022 11:46:36 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B9310E76A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 11:46:34 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 88DF361E6478B;
 Mon,  9 May 2022 13:46:32 +0200 (CEST)
Message-ID: <eb1be303-6819-a09e-1d40-3e621ef72527@molgen.mpg.de>
Date: Mon, 9 May 2022 13:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fixed no previous prototype warning.
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>
References: <20220508173008.281673-1-James.Zhu@amd.com>
 <20220508180014.313767-1-James.Zhu@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220508180014.313767-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear James,


You sent this message 30 minutes after sending the same message before 
(Message-ID: <20220508173008.281673-1-James.Zhu@amd.com>). Are there any 
differences?

Am 08.05.22 um 20:00 schrieb James Zhu:
> Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'

Please use imperative mood in the commit message summary. Maybe even:

 > Include header for `vcn_dec_sw_ring_emit_fence()`

Also, please do not add a dot/period to the end of commit messages.


Kind regards,

Paul


> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index f4f97f0f5c64..1ceda3d0cd5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "vcn_sw_ring.h"
>   
>   void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	u64 seq, uint32_t flags)
