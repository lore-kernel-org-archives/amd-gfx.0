Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC14C2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 11:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9648206DB
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9648206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866E788F16;
	Mon, 30 Dec 2019 11:15:24 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892B288F16;
 Mon, 30 Dec 2019 11:15:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Dec 2019 03:15:22 -0800
X-IronPort-AV: E=Sophos;i="5.69,374,1571727600"; d="scan'208";a="213299813"
Received: from mchanan-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.32.148])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Dec 2019 03:15:19 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/dp_mst: correct the shifting in DP_REMOTE_I2C_READ
In-Reply-To: <20191230070516.4760-1-Wayne.Lin@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191230070516.4760-1-Wayne.Lin@amd.com>
Date: Mon, 30 Dec 2019 13:15:34 +0200
Message-ID: <87mubaoyi1.fsf@intel.com>
MIME-Version: 1.0
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
Cc: jerry.zuo@amd.com, Nicholas.Kazlauskas@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 30 Dec 2019, Wayne Lin <Wayne.Lin@amd.com> wrote:
> [Why]
> According to DP spec, it should shift left 4 digits for NO_STOP_BIT
> in REMOTE_I2C_READ message. Not 5 digits.
>
> [How]
> Correct the shifting value of NO_STOP_BIT for DP_REMOTE_I2C_READ case in
> drm_dp_encode_sideband_req().

Which commit introduced the issue? Fixes: tag. Does it need a stable
backport? Does this fix a user visible bug?

BR,
Jani.

> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1d1bfa49ca2b..0557e225ff67 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -393,7 +393,7 @@ drm_dp_encode_sideband_req(const struct drm_dp_sideband_msg_req_body *req,
>  			memcpy(&buf[idx], req->u.i2c_read.transactions[i].bytes, req->u.i2c_read.transactions[i].num_bytes);
>  			idx += req->u.i2c_read.transactions[i].num_bytes;
>  
> -			buf[idx] = (req->u.i2c_read.transactions[i].no_stop_bit & 0x1) << 5;
> +			buf[idx] = (req->u.i2c_read.transactions[i].no_stop_bit & 0x1) << 4;
>  			buf[idx] |= (req->u.i2c_read.transactions[i].i2c_transaction_delay & 0xf);
>  			idx++;
>  		}

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
