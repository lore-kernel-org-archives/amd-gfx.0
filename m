Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A962ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Sep 2022 21:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4FC10E910;
	Fri,  2 Sep 2022 21:35:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A27910E911
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662154504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tLM/3lJtaAYsqKeYEGRVJvBSiRQW7/b6UjPp23Gpt8=;
 b=eecIaoIdClM+KXOx0uIB/YIrNJ5+wAZ1Kles7Z2tKWklohoWWjo++g8Zq/7ThbaZ/PByuz
 QeNxCvuQWHT/EEFQ/hjjiR60QuZOCBq0qSFYB4yCTDh1Y1WOHThzvD1b8tjHS/oPs8NYlt
 VBzyWZaM9sNZwYTKP2xNlFschQ658P8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-9e7PD-BpMg2GgEbAaAp1jQ-1; Fri, 02 Sep 2022 17:35:03 -0400
X-MC-Unique: 9e7PD-BpMg2GgEbAaAp1jQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 v5-20020ac873c5000000b003434ef0a8c7so2489411qtp.21
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Sep 2022 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=8tLM/3lJtaAYsqKeYEGRVJvBSiRQW7/b6UjPp23Gpt8=;
 b=2sRcgEZ7z16c4cE9FJCoIhUAp4qvCJzLMWEwVbwE/LKXAaDe5/EpD7DN1OgQA6VOOr
 WK7l5W7pSwgtuq2b3IK0s76L4MOCCvj7Fe/MfCba8xaPpGyek9Zzydx5nEmOxRlozdkV
 HFMC5xWzeovHy3oh3OPbXvlx6brRAOE5b6W1FIv+B2eNp5cXJ5iRv4i6X/gOiadBZRMM
 zZR1N81RFzH3l+PcAZVO7q0ygQXGnfSLXjF0RRtnyfR5K6cCo7ORM304EV7vnIOa/+vz
 ugNSDMOdz/hqQEvY+JAiiqzZ+ppfx4iOtWQE5StBLNvQRfHrmEUPXn2VBGq+qcBBc1Bl
 ZCEA==
X-Gm-Message-State: ACgBeo0puoAeBxgNfU9/YsKYfgEhDVxh+t2BjomOCLR6QMzwjck8SzhC
 WdTixw2Mn6oZR0BGGtcin4AH07zzSV9YJnqPLB8pJFVgy4p1ODMMWos85tI1tyRenOcXDEEuNn4
 hN+yuk+Yq5wSZIS09fks3M/NIJQ==
X-Received: by 2002:ac8:5a55:0:b0:343:72f9:7053 with SMTP id
 o21-20020ac85a55000000b0034372f97053mr29376151qta.518.1662154502986; 
 Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71MqC8+ulzndg1RInO2Lgus6TlkwKGDoiDVHA9iSaBYpFk7mer7xfBbfAfM9XAI4bEWzDHfA==
X-Received: by 2002:ac8:5a55:0:b0:343:72f9:7053 with SMTP id
 o21-20020ac85a55000000b0034372f97053mr29376127qta.518.1662154502700; 
 Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00:e786:1aff:4f5c:c549?
 ([2600:4040:5c48:e00:e786:1aff:4f5c:c549])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a05620a254400b006bacf4703c5sm2215158qko.111.2022.09.02.14.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
Message-ID: <cde7369a1d078249244759662989427b1f853bdd.camel@redhat.com>
Subject: Re: [PATCH] drm/dp: Avoid Reading DPCD_REV Before Native Aux Read
From: Lyude Paul <lyude@redhat.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Ville
 Syrjala <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Date: Fri, 02 Sep 2022 17:35:00 -0400
In-Reply-To: <20220831221321.748264-1-Jerry.Zuo@amd.com>
References: <20220831221321.748264-1-Jerry.Zuo@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-08-31 at 18:13 -0400, Fangzhi Zuo wrote:
> The attempt to read DPCD_REV before any native aux read breaks
> majority of DP2 compliance.
> 
> The spec. requires DP_SINK_STATUS to be polled for the reset status
> DP_INTRA_HOP_AUX_REPLY_INDICATION during the clear training stage.
> 
> Polling DP_SINK_STATUS each time gets DPCD_REV read first
> that makes non link training regsiter DPCD_REV get read
> during UHBR link training. It violates DP2 compliance.
> 
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e7c22c2ca90c..c7aa5bafa667 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -571,24 +571,6 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
>  {
>  	int ret;
>  
> -	/*
> -	 * HP ZR24w corrupts the first DPCD access after entering power save
> -	 * mode. Eg. on a read, the entire buffer will be filled with the same
> -	 * byte. Do a throw away read to avoid corrupting anything we care
> -	 * about. Afterwards things will work correctly until the monitor
> -	 * gets woken up and subsequently re-enters power save mode.
> -	 *
> -	 * The user pressing any button on the monitor is enough to wake it
> -	 * up, so there is no particularly good place to do the workaround.
> -	 * We just have to do it before any DPCD access and hope that the
> -	 * monitor doesn't power down exactly after the throw away read.
> -	 */
> -	if (!aux->is_remote) {
> -		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	if (aux->is_remote)
>  		ret = drm_dp_mst_dpcd_read(aux, offset, buffer, size);
>  	else

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

