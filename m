Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD1C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 14:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF4910E553;
	Tue, 28 Nov 2023 14:30:15 +0000 (UTC)
X-Greylist: delayed 639 seconds by postgrey-1.36 at gabe;
 Tue, 28 Nov 2023 11:47:58 UTC
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C12410E4E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 11:47:58 +0000 (UTC)
Message-ID: <ee38d09e-52f2-4b32-b3bb-95b3c93a19e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1701172076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PEP0y6b8YPmo3TxW7nBtwEPxFe/V/Vxl7mo9MWFelXo=;
 b=Ejwq/Nb1at/Q5qXPoigj1GLhEKkL0bsy7BytA11hnyUyV8hNzBHFXGn4ApW57XR1tu+VI9
 hhS0YN8B7+usiNrEJdMbA/WD4UvHg8iz85mAtIb+o0hirliNFiSt5JQ42yhwhQjUYCfwG8
 aQgEjTOXQ5kwduFvdQ5ONDjE1twdIA8=
Date: Tue, 28 Nov 2023 19:47:48 +0800
MIME-Version: 1.0
Subject: Re: [7/8] drm/simpledrm: Do not include <drm/drm_plane_helper.h>
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com
References: <20231128104723.20622-8-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20231128104723.20622-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 28 Nov 2023 14:30:13 +0000
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
Cc: javierm@redhat.com, amd-gfx@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, laurent.pinchart@ideasonboard.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,


On 2023/11/28 18:45, Thomas Zimmermann wrote:
> Remove unnecessary include statements for <drm/drm_plane_helper.h>.
> The file contains helpers for non-atomic code and should not be
> required by most drivers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> ---
>   drivers/gpu/drm/tiny/simpledrm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index 34bbbd7b53dd9..7ce1c46176750 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -25,7 +25,6 @@
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_plane_helper.h>
>   #include <drm/drm_probe_helper.h>
>   
>   #define DRIVER_NAME	"simpledrm"
