Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101AC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A89F6124B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A89F6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9364E89D9B;
	Mon, 23 Aug 2021 13:07:53 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by gabe.freedesktop.org (Postfix) with ESMTP id 108586EB46
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Aug 2021 05:00:24 +0000 (UTC)
Received: from [192.168.1.18] ([90.126.253.178]) by mwinf5d11 with ME
 id k4so250043riaq2034sp7R; Sat, 21 Aug 2021 06:52:52 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 06:52:52 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH linux-next] drm: drop unneeded assignment in the
 fx_v6_0_enable_mgcg()
To: CGEL <cgel.zte@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Pan Xinhui <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luo penghao <luo.penghao@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
References: <20210821020844.26864-1-luo.penghao@zte.com.cn>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0956a2af-d168-92e3-35c3-43966fa75e33@wanadoo.fr>
Date: Sat, 21 Aug 2021 06:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821020844.26864-1-luo.penghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Aug 2021 13:07:52 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Le 21/08/2021 à 04:08, CGEL a écrit :
> From: Luo penghao <luo.penghao@zte.com.cn>
> 
> The first assignment is not used. In order to keep the code style
> consistency of the whole file, the first 'data' assignment should be
> deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:2608:10: warning:
> Although the value storedto 'offset' is used in the enclosing expression,
> the value is never actually read from 'offset'.

Apparently clang only spotted on place, at line 2608.

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 6a8dade..84a5f22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -2605,7 +2605,7 @@ static void gfx_v6_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
>   	u32 data, orig, tmp = 0;
>   
>   	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
> -		orig = data = RREG32(mmCGTS_SM_CTRL_REG);
> +		orig = RREG32(mmCGTS_SM_CTRL_REG);
>   		data = 0x96940200;
>   		if (orig != data)
>   			WREG32(mmCGTS_SM_CTRL_REG, data);
> @@ -2617,7 +2617,7 @@ static void gfx_v6_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
>   				WREG32(mmCP_MEM_SLP_CNTL, data);
>   		}
>   
> -		orig = data = RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
> +		orig = RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
>   		data &= 0xffffffc0;
                      ^^
but you also change here where it is used.

>   		if (orig != data)
>   			WREG32(mmRLC_CGTT_MGCG_OVERRIDE, data);
> 

CJ
