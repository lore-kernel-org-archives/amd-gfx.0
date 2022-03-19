Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA11C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 08:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F341E10E4D0;
	Sat, 19 Mar 2022 08:37:26 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCD510E364
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 08:37:25 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DEA4161EA1923;
 Sat, 19 Mar 2022 09:37:23 +0100 (CET)
Message-ID: <067e5cf6-71ef-2a95-9982-c65be8656b1d@molgen.mpg.de>
Date: Sat, 19 Mar 2022 09:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 06/13] drm/amd/display: Update VTEM Infopacket definition
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-7-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-7-alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Leo,


Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
> 
> [Why & How]
> The latest HDMI SPEC has updated the VTEM packet structure,

Please add the exact version, as “latest” is relative.

> so change the VTEM Infopacket defined in the driver side to align
> with the SPEC.


Kind regards,

Paul


> Reviewed-by: Chris Park <Chris.Park@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
> ---
>   .../gpu/drm/amd/display/modules/info_packet/info_packet.c    | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index b691aa45e84f..79bc207415bc 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -100,7 +100,8 @@ enum vsc_packet_revision {
>   //PB7 = MD0
>   #define MASK_VTEM_MD0__VRR_EN         0x01
>   #define MASK_VTEM_MD0__M_CONST        0x02
> -#define MASK_VTEM_MD0__RESERVED2      0x0C
> +#define MASK_VTEM_MD0__QMS_EN         0x04
> +#define MASK_VTEM_MD0__RESERVED2      0x08
>   #define MASK_VTEM_MD0__FVA_FACTOR_M1  0xF0
>   
>   //MD1
> @@ -109,7 +110,7 @@ enum vsc_packet_revision {
>   //MD2
>   #define MASK_VTEM_MD2__BASE_REFRESH_RATE_98  0x03
>   #define MASK_VTEM_MD2__RB                    0x04
> -#define MASK_VTEM_MD2__RESERVED3             0xF8
> +#define MASK_VTEM_MD2__NEXT_TFR              0xF8
>   
>   //MD3
>   #define MASK_VTEM_MD3__BASE_REFRESH_RATE_07  0xFF
