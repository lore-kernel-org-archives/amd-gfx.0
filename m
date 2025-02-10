Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5596C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 16:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E1F10E1D2;
	Mon, 10 Feb 2025 16:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="C57N/ol2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6CD10E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mv+l6rWAvTvgHYCjihGN3fEqUE293raDGEMTO4Tbo/8=; b=C57N/ol2+S7R07xF1LWy/8E/Ve
 c3AqMb21X3668MtbBoPeuJd7dhDG6cvSIqYxdwZitDWQ592RFXQv9m1jvDTsj+Zj5KYSpFDuNDmKx
 ik736wgmXzaoBCdKT9PmvLL9shwPMSzL+LyVmSTiNp2B05YaCJUAxxe1zBksq8vP7+xP+pN7Z5xfe
 NVDwEgx7IoTUcnWcaCvyqaRfbvKcdRKxBZDAKYYRVFKBT7d7BbZTSB0D+6PPyunJOpw/EE/lR/SW2
 b9+/rqAXkGs54ynWJlmEM0zaP2nmJMSNEdoXs92Jpge6HRwTM01bqgHGzDA6ZstoUoik0K/kD5tw4
 ABPooXVQ==;
Received: from [179.214.71.67] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1thWOa-007K7e-CD; Mon, 10 Feb 2025 17:12:34 +0100
Message-ID: <5bb61fa3-0d32-4d8e-ae01-5f9728631248@igalia.com>
Date: Mon, 10 Feb 2025 13:12:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amd/display: docstring definitions MAX_SURFACES
 and MAX_PLANES
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
 <20250205184036.2371098-3-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20250205184036.2371098-3-aurabindo.pillai@amd.com>
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


On 05/02/2025 15:39, Aurabindo Pillai wrote:
> From: Zaeem Mohamed <zaeem.mohamed@amd.com>
>
> MAX_SURFACES and MAX_PLANES now have docstrings that better show the difference between the two.
>
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dc.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 42ba65e785ca..e1f4f643c364 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -55,7 +55,13 @@ struct dmub_notification;
>   
>   #define DC_VER "3.2.319"
>   
> +/**
> + * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
> + */
>   #define MAX_SURFACES 4
> +/**
> + * MAX_PLANES - representative of the upper bound of planes that are supported by the HW
> + */
>   #define MAX_PLANES 6
Nice! Thanks for adding this doc.

Melissa
>   #define MAX_STREAMS 6
>   #define MIN_VIEWPORT_SIZE 12

