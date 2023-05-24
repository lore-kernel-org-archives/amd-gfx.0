Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7254AC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 20:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870FD10E60A;
	Wed, 24 May 2023 20:46:50 +0000 (UTC)
Received: from 189.cn (ptr.189.cn [183.61.185.103])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4A91510E60A;
 Wed, 24 May 2023 20:46:49 +0000 (UTC)
HMM_SOURCE_IP: 10.64.8.31:40222.1578582937
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
 by 189.cn (HERMES) with SMTP id 0F0F1100282;
 Thu, 25 May 2023 04:46:45 +0800 (CST)
Received: from  ([114.242.206.180])
 by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id
 8f1ad3bc72be45a1a14ee973e80f2411 for tzimmermann@suse.de; 
 Thu, 25 May 2023 04:46:47 CST
X-Transaction-ID: 8f1ad3bc72be45a1a14ee973e80f2411
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Message-ID: <1b5315b4-ab46-df73-12d4-787ba087d92d@189.cn>
Date: Thu, 25 May 2023 04:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v4, 01/13] fbdev: Add Kconfig options to select different fb_ops
 helpers
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 javierm@redhat.com, sam@ravnborg.org
References: <20230524092150.11776-2-tzimmermann@suse.de>
From: Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230524092150.11776-2-tzimmermann@suse.de>
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
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


On 2023/5/24 17:21, Thomas Zimmermann wrote:
> Many fbdev drivers use the same set of fb_ops helpers. Add Kconfig
> options to select them at once. This will help with making DRM's
> fbdev emulation code more modular, but can also be used to simplify
> fbdev's driver configs.
>
> v3:
> 	* fix select statement (Jingfeng)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/Kconfig | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index e8889035c882..6df9bd09454a 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -158,6 +158,27 @@ config FB_DEFERRED_IO
>   	bool
>   	depends on FB
>   
> +config FB_IO_HELPERS
> +	bool
> +	depends on FB
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_IMAGEBLIT
> +
> +config FB_SYS_HELPERS
> +	bool
> +	depends on FB
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_FOPS
> +	select FB_SYS_IMAGEBLIT
> +
> +config FB_SYS_HELPERS_DEFERRED
> +	bool
> +	depends on FB
> +	select FB_DEFERRED_IO
> +	select FB_SYS_HELPERS
> +
>   config FB_HECUBA
>   	tristate
>   	depends on FB
