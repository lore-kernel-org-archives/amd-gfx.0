Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1AFCCF2EA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 12:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7E510ECD6;
	Mon, 19 Oct 2026 12:56:30 +0000 (UTC)
X-Greylist: delayed 4200 seconds by postgrey-1.36 at gabe;
 Mon, 19 Oct 2026 09:14:09 UTC
Received: from 6.mo584.mail-out.ovh.net (6.mo584.mail-out.ovh.net
 [188.165.36.253])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B621F10E10F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 09:14:09 +0000 (UTC)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.254.231])
 by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4j7SVt0gZpz7yyF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 07:54:29 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-w2p87 (unknown [10.108.42.201])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A6EAAC3DDE;
 Mon, 19 Oct 2026 07:54:27 +0000 (UTC)
Received: from medichon.fr ([37.59.142.109])
 by ghost-submission-7ccd8bbbb6-w2p87 with ESMTPSA
 id VzFGHbPM1Wq57gYAh9bqlA
 (envelope-from <abo@medichon.fr>); Mon, 19 Oct 2026 07:54:27 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003e25b5ac9-02cb-4e08-a646-4f4adac193de,
 E22553FEB6AEB75B33DDF2A505A99149E93FA69D) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
Message-ID: <fd9c0bbe-6e0c-486a-ad23-ea99935a28ce@medichon.fr>
Date: Mon, 19 Oct 2026 09:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arnaud Bonnet <abo@medichon.fr>
Subject: Re: [PATCH v2] drm/amd/display: remove unused cgs register accessor
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
 <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20261017130047.42080-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14750696155911184108
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEC+pQARFvnW2RMvD9rJWwoSB5KeWL1zCtrex0rqKpMGM/5SWjDLMgrr+9PpUdSees96VENuuMOCUpYmiYcW4lsBEkE8EniYAkM9m3Rnj8NjyA7soRhfPa0JBImFi7NB5lrqN4GOn1OQwSMzJvMp/9HxrvZR/Jb9vXM8njCWKzRcxewl6oiGGkofXbt5b77yqFsXqJC/pfsOjBXhKcNlvZ34D4oJxjsKydJEd4U2ZpzrE8t8cjzAQRXQORBS6UbXMhaDk40DNY01DQUxTDRzULvuVsXfia3e2pEGnhcagdyPqNu0q+OuN+fRPDRf2RlEuRMQ9iiqoYkLWaeFtR3yiWkZjiJ5fEayEpLpiBgACirPn/5rigmFal9QnK0Jfnyq4i3Q4CBgvZkw1mnrxCQjF7SUs9ZlcsIpvz7BVcU1anHSnVqA2naHd3KqZzMOnFq1w1KntS1vHU3IOlncxZRzFwC1nShe5NjnISnET76pq8Rarwkvm0tiArx6mTkxX5KBp/UybNpusdB+8IbjHRoMADz8vKR/PJwOJjxqHfM9aNftkRnwS3knQtwK2cK+lQO2IhsViDrLkm2Z/rDjEHMEAaBm+sOrxospKLHAeSBufjfU+nwgnv8Uo10znli3E+9zw0+oWfVCjscDTL/l3L+5leMiK35218lpygzH2VOlspooQ
DKIM-Signature: a=rsa-sha256; bh=gTmA+d0ikT+8IflEYztNYyZ9CNFtEwNKlyOUdD5euEE=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1792396470; v=1;
 b=JhhVFO7VDlltUMNaBs5QxNf4mDuYlXJgSzv2iPVhIse9XoiWK3azQ5proojZ3M4z/CBRCEG1
 m/mrFcnqi/01zSrT0zj0xai+loshbS955gCT+Ktrk2QsRtkyYj0BLu9ctPMxcuf2nUwfLj/YC9B
 S0gbwT/AcuG60zA1KR5RhCYFiggbPVvnG/ZBf8p8ll6pLcbf+TBn4PV5wzrg93HeZfxd8xgPO7U
 6QQMhblNcTGmS6MqvQTqZhHnI94RLVqRTs/Bx4270JaB0q0/9E9FZPgMrxYScfm2Fn/9so/EskF
 Rkk2+8Yw0Wj9Xsxo/E8IdnC4Qo/5AKzDgdff9PNQ3eD8Q==
X-Mailman-Approved-At: Mon, 19 Oct 2026 12:56:23 +0000
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

On 10/17/26 3:00 PM, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, e.g.:
> 
>   drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
> 
> Each of the four typedefs is used exactly once, as
> the type of a struct cgs_ops member, so they are merely an
> unnecessary layer of indirection. Drop the typedefs along with their
> kernel-doc comments and write the function pointer types directly in
> struct cgs_ops.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  drivers/gpu/drm/amd/include/cgs_common.h | 60 +++++++-----------------
>  1 file changed, 18 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
> index f40b6a03fe63..1750401c7d08 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -80,43 +80,6 @@ struct cgs_firmware_info {
>  
>  typedef unsigned long cgs_handle_t;
>  
> -/**
> - * cgs_read_register() - Read an MMIO register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
> -
> -/**
> - * cgs_write_register() - Write an MMIO register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - * @value:	register value
> - */
> -typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned offset,
> -				     uint32_t value);
> -
> -/**
> - * cgs_read_ind_register() - Read an indirect register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -					    unsigned index);
> -
> -/**
> - * cgs_write_ind_register() - Write an indirect register
> - * @cgs_device:	opaque device handle
> - * @offset:	register offset
> - * @value:	register value
> - */
> -typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> -					 unsigned index, uint32_t value);
> -
>  #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>  #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>  
> @@ -137,14 +100,27 @@ typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
>  				     enum cgs_ucode_id type,
>  				     struct cgs_firmware_info *info);

Hi Omokefe, you probably forgot
-typedef unsigned long cgs_handle_t;
-typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
-                                    enum cgs_ucode_id type,
-                                    struct cgs_firmware_info *info);

As discussed I have built and ran some IGT on hardware for the versions
with and without these two, so you can still use the tag if you send v3:

Tested-by: Arnaud Bonnet <abo@medichon.fr>

>  
> +/**
> + * struct cgs_ops - Common Graphics Services operations
> + * @read_register: read register value
> + * @write_register: write register value
> + * @read_ind_register: read indirect register value
> + * @write_ind_register: write indirect register value
> + * @get_firmware_info: get firmware information
> + */
>  struct cgs_ops {
>  	/* MMIO access */
> -	cgs_read_register_t read_register;
> -	cgs_write_register_t write_register;
> -	cgs_read_ind_register_t read_ind_register;
> -	cgs_write_ind_register_t write_ind_register;
> +	uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned int offset);
> +	void (*write_register)(struct cgs_device *cgs_device, unsigned int offset,
> +			       uint32_t value);
> +	uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +				      unsigned int index);
> +	void (*write_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> +				   unsigned int index, uint32_t value);
>  	/* Firmware Info */
> -	cgs_get_firmware_info get_firmware_info;
> +	int (*get_firmware_info)(struct cgs_device *cgs_device,
> +				 enum cgs_ucode_id type,
> +				 struct cgs_firmware_info *info);
>  };
>  
>  struct cgs_os_ops; /* To be define in OS-specific CGS header */

