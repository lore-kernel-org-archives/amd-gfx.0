Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B21AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 19:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F5310E622;
	Mon, 15 Apr 2024 19:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RiBd+iFI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2C710E622
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0PvUk7ZjBL1fyypjF5DKenEz7VBXkL7/4qSWEM1d5E8=; b=RiBd+iFIijPKgycz/+KS4pP+wk
 xBQG5YI59fNh0JXbZUhmmDvfhOViZ9yrn2ff28Gm272bKzds+0Wp6AC3ElUGJKIgW4G8R82frpDiT
 +CaIgscgIv/oYwiEV+v6EmsKmBkGDYp1bPxp0LTys0DKRXIfpsQ1H0QSGFVvmD0dD3eVcXnUZAjur
 D8ak+By6ZCLUxQazGnb4oFZ1xweOyCP/yxOwVEMayMIOwbzamPGzC7778GIkyY1QGioQV/N2HAMMR
 KDgTqNg2Y5QYhO070kHr3T+StOyKp2DGrvf/i6z4d15FOh4DFDz/APAbDlR+gZGW7iPGFutWL3jLu
 aklrEyAA==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1rwRp7-004sM5-Mh; Mon, 15 Apr 2024 21:17:02 +0200
Message-ID: <0cb45d1e-1fa0-4cf8-afe2-4e7d3b76d675@igalia.com>
Date: Mon, 15 Apr 2024 16:16:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] drm/amd/display: Add a function for checking tmds
 mode
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com,
 Chris Park <chris.park@amd.com>, Dillon Varone <dillon.varone@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
 <20240410212726.1312989-3-Rodrigo.Siqueira@amd.com>
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20240410212726.1312989-3-Rodrigo.Siqueira@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/04/2024 18:25, Rodrigo Siqueira wrote:
> From: Chris Park <chris.park@amd.com>
>
> [Why]
> DVI is TMDS signal like HDMI but without audio.  Current signal check
> does not correctly reflect DVI clock programming.
>
> [How]
> Define a new signal check for TMDS that includes DVI to HDMI TMDS
> programming.
>
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Chris Park <chris.park@amd.com>
> ---
>   drivers/gpu/drm/amd/display/include/signal_types.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
> index 1b14b17a79c7..a10d6b988aab 100644
> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
> @@ -118,6 +118,19 @@ static inline bool dc_is_dvi_signal(enum signal_type signal)
>   	}
>   }
>   
> +static inline bool dc_is_tmds_signal(enum signal_type signal)
> +{
> +	switch (signal) {
> +	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +	case SIGNAL_TYPE_DVI_DUAL_LINK:
> +	case SIGNAL_TYPE_HDMI_TYPE_A:
> +		return true;
> +	break;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static inline bool dc_is_dvi_single_link_signal(enum signal_type signal)
>   {
>   	return (signal == SIGNAL_TYPE_DVI_SINGLE_LINK);
Is this patch complete? It creates a helper that isn't used anywhere (?)

BR,

Melissa

