Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155CBEE49AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E22E10E204;
	Mon, 21 Aug 2023 07:46:06 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr
 [80.12.242.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF9D10E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:47:56 +0000 (UTC)
Received: from [192.168.1.18] ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id XyhbqE06S8hXQXyhcqw3V8; Mon, 21 Aug 2023 08:47:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1692600473;
 bh=VKY79l4BMS+XNL5J3gXH51QA4MGqOn2fyIFQ894irYI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oNAWQvmZI2xUCvFd5vsfvc4Rg0xT2d57oXjSqUqVl4pql2iZjSkXoNLUed4xgtROS
 lMtOos2PRov4AvnMnHY3xputg8PHPn6P1PPDAF/JczkmsBgoGlYjAg46MdS/DsZ8xd
 Zu7nxgmgu3aG98h+TmKWs0qboDrUkArStJLQF4YcQzl/DjMsU9IryeQfJEENWxlBVL
 jOLsBDjvexg3I+bBvEyALisDOBRSqYBIz2kGHLko2gokb8cLE/noTRfU7rhg/OAP4x
 GcIDw2ZbeOAPMVq1waCs0uyCnzYsbkm7uKrrJmm76cJvt7AWCcM9G1oWg9DcQ5S4UV
 3qgzUpWmE2JVQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Aug 2023 08:47:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7ac675b6-a000-6ad7-36f3-a3ce186414b6@wanadoo.fr>
Date: Mon, 21 Aug 2023 08:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Avoid possible buffer overflow
Content-Language: fr
To: Su Hui <suhui@nfschina.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
References: <20230821061944.197934-1-suhui@nfschina.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230821061944.197934-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Aug 2023 07:46:03 +0000
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
Cc: yifan1.zhang@amd.com, guchun.chen@amd.com, lijo.lazar@amd.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, le.ma@amd.com, dri-devel@lists.freedesktop.org,
 Yuliang.Shi@amd.com, candice.li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Le 21/08/2023 à 08:19, Su Hui a écrit :
> smatch error:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1257 amdgpu_discovery_reg_base_init() error:
> testing array offset 'adev->vcn.num_vcn_inst' after use.
> 
> change the assignment order to avoid buffer overflow.
> 
> Fixes: c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 8e1cfc87122d..ba95526c3d45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1250,11 +1250,12 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				 *     0b10 : encode is disabled
>   				 *     0b01 : decode is disabled
>   				 */
> -				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> -					ip->revision & 0xc0;
> +
>   				ip->revision &= ~0xc0;
>   				if (adev->vcn.num_vcn_inst <
>   				    AMDGPU_MAX_VCN_INSTANCES) {
> +					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
> +						ip->revision & 0xc0;

Hi,
I don't think that the patch is correct.

Because of the "ip->revision &= ~0xc0" which is now above it, 
"ip->revision & 0xc0" should now always be 0.

Maybe both lines should be moved within the "if"?

CJ





>   					adev->vcn.num_vcn_inst++;
>   					adev->vcn.inst_mask |=
>   						(1U << ip->instance_number);

