Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A5CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2380710E404;
	Thu,  6 Jul 2023 14:06:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C75010E403
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688652143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GE7k8I9982HVE9TTWbDiwrZOKfvdOMPK3S9DyegjXE=;
 b=bHuAjGdMeb5UM7luqOYiBeR/SBM0Uv+jAqXatTXJi/062i/HA8yoilJE8rurBOGAcNj6PJ
 6QkXfiyWmZ8I1+XwOC/2hHjGv2710/4PkQjn1WHxlCz9xzt178m6/jQdOQJkITqOcseSee
 rOrFxSlRIx5fxO95bWgnL4effoiLkVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-j2jn559mPj-HKLiI7yRfSQ-1; Thu, 06 Jul 2023 10:02:21 -0400
X-MC-Unique: j2jn559mPj-HKLiI7yRfSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3141a98a29aso417737f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652140; x=1691244140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GE7k8I9982HVE9TTWbDiwrZOKfvdOMPK3S9DyegjXE=;
 b=MC65W4Y/EM0ExlYyvdUxGQ6HxXndVfGY7Qtn65wxgwcMz1dpDtwwFMHyJe70EskEzD
 tYKkhu8JAguMK8eyzCqVyMfR2X3UUycaMvh/fwf4SES4ZCVojOwLhwXdw8TrWvd73RZY
 XUtYFXs2UgM7pDVlxH+TzQzAu4YnKx07JXagLqsvqYTWdyMDIgBs/EuvNWuSvy3ANNhC
 PFs1CuIzoapG3xzNpoIyfXZSApWDRW3rH85GLIJ4onHodMizSi/RaH/85dhJTiPW/c6N
 7HhGc8r3T7aYQh6MXGWlgPjc1rnppfCOwrGZcD1sA1DZNF83u945p51MooZpGwjpQo+I
 cVNQ==
X-Gm-Message-State: ABy/qLaA48M3YMyFlaR1/pUH8jLJeyKI/4Vb5lAK7tnvRZUXAFoDynoY
 BZycMYDKfwV4GZmYhz+V3UkaYP/TcNiaJE2vIc/PAx9sQiHpTDjnHTU2U4fFz2EoMc+iZRC0Tip
 39ua3FzzbCatT0pyL0LWlD2qBEw==
X-Received: by 2002:a5d:4e12:0:b0:313:e2c8:bed1 with SMTP id
 p18-20020a5d4e12000000b00313e2c8bed1mr2235658wrt.34.1688652140610; 
 Thu, 06 Jul 2023 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcrZAK048UNMfdOsb+IYlPvPsKZoDto6N+0HK8CkttE8tg+x61xjZ/Drujf9ZKOumGT2ngEg==
X-Received: by 2002:a5d:4e12:0:b0:313:e2c8:bed1 with SMTP id
 p18-20020a5d4e12000000b00313e2c8bed1mr2235624wrt.34.1688652140228; 
 Thu, 06 Jul 2023 07:02:20 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b0031434936f0dsm1960350wrs.68.2023.07.06.07.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:02:19 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:02:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yang Rong <yangrong@vivo.com>
Subject: Re: [PATCH] Fix max/min warnings in virtio_net, amd/display, and
 io_uring
Message-ID: <20230706100133-mutt-send-email-mst@kernel.org>
References: <20230706021102.2066-1-yangrong@vivo.com>
MIME-Version: 1.0
In-Reply-To: <20230706021102.2066-1-yangrong@vivo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jul 2023 14:06:34 +0000
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
Cc: Max Tseng <Max.Tseng@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Wang <jasowang@redhat.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 Alvin Lee <Alvin.Lee2@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 opensource.kernel@vivo.com, Leo Li <sunpeng.li@amd.com>,
 Cruise Hung <cruise.hung@amd.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>, luhongfei@vivo.com,
 "David S. Miller" <davem@davemloft.net>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 06, 2023 at 10:06:16AM +0800, Yang Rong wrote:
> The files drivers/net/virtio_net.c, drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c, and io_uring/io_uring.c were modified to fix warnings.

what warnings? the point of the warning is to analyze it not "fix" it
blindly.

> Specifically, the opportunities for max() and min() were utilized to address the warnings.
> 
> Signed-off-by: Yang Rong <yangrong@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 6 +++---
>  drivers/net/virtio_net.c                     | 3 ++-
>  io_uring/io_uring.c                          | 3 ++-
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index c753c6f30dd7..df79aea49a3c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -22,7 +22,7 @@
>   * Authors: AMD
>   *
>   */
> -
> +#include <linux/minmax.h>
>  #include "dc.h"
>  #include "dc_dmub_srv.h"
>  #include "../dmub/dmub_srv.h"
> @@ -481,7 +481,7 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
>         max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us -
>                         dc->caps.subvp_fw_processing_delay_us - drr_active_us), 2) + drr_active_us;
>         max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us - dc->caps.subvp_fw_processing_delay_us;
> -       max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
> +       max_drr_supported_us = max(max_drr_vblank_us, max_drr_mallregion_us);
>         max_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us),
>                         (((uint64_t)drr_timing->h_total * 1000000)));
> 
> @@ -771,7 +771,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>                 wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
>                                 (dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000) / 1000;
> 
> -               cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
> +               cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = min(wm_val_refclk, 0xFFFF);
>         }
> 
>         dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9b3721424e71..5bb7da885f00 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -22,6 +22,7 @@
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> +#include <linux/minmax.h>
> 
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -1291,7 +1292,7 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
>         __skb_put(skb, data_len);
> 
>         metasize = xdp->data - xdp->data_meta;
> -       metasize = metasize > 0 ? metasize : 0;
> +       metasize = max(metasize, 0);
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index e8096d502a7c..875ca657227d 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -47,6 +47,7 @@
>  #include <linux/refcount.h>
>  #include <linux/uio.h>
>  #include <linux/bits.h>
> +#include <linux/minmax.h>
> 
>  #include <linux/sched/signal.h>
>  #include <linux/fs.h>
> @@ -2660,7 +2661,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
>                                         page_array);
>         if (ret != nr_pages) {
>  err:
> -               io_pages_free(&page_array, ret > 0 ? ret : 0);
> +               io_pages_free(&page_array, max(ret, 0));
>                 return ret < 0 ? ERR_PTR(ret) : ERR_PTR(-EFAULT);
>         }
>         /*
> --
> 2.35.3
> 
> 
> ________________________________
> 本邮件及其附件内容可能含有机密和/或隐私信息，仅供指定个人或机构使用。若您非发件人指定收件人或其代理人，请勿使用、传播、复制或存储此邮件之任何内容或其附件。如您误收本邮件，请即以回复或电话方式通知发件人，并将原始邮件、附件及其所有复本删除。谢谢。
> The contents of this message and any attachments may contain confidential and/or privileged information and are intended exclusively for the addressee(s). If you are not the intended recipient of this message or their agent, please note that any use, dissemination, copying, or storage of this message or its attachments is not allowed. If you receive this message in error, please notify the sender by reply the message or phone and delete this message, any attachments and any copies immediately.
> Thank you

