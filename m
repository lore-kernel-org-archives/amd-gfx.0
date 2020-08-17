Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43BC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54FA207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAD0bGb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54FA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794FC6E137;
	Mon, 17 Aug 2020 15:21:38 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABF76E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cbeb0PuYX/kgT1cVNgWIip3Mn2nin0XvTMat1DoR7XA=;
 b=QAD0bGb+xsUrzMFDNrdJR64savR7AziYPAVMMJhwHW1xOqYElxwzIVk2q5htDhMiq+0mlL
 sk87HkK7lf3f+PSExVJdOscQcwhcoO2IBjJHvcpzzC2tx7pcGMc7n1Mgl2g7GZNFw99meB
 QQbwBVzVnigM4TVwe2VyfPSBrP/lSB4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-EQnWVZQlP3a7V8qwh7jhNw-1; Mon, 17 Aug 2020 11:21:33 -0400
X-MC-Unique: EQnWVZQlP3a7V8qwh7jhNw-1
Received: by mail-qt1-f198.google.com with SMTP id q19so12307789qtp.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=Cbeb0PuYX/kgT1cVNgWIip3Mn2nin0XvTMat1DoR7XA=;
 b=mNxKUnOuY4G+clHUlBfpWsvgdNwM/dZa+qjqtTOiT2zm2DaTAzGnhjffN6dUFMW6Es
 RH4akhUCogN1Yay8gRIJ4hr1onw+/HdogyLOBHp35N13/w22LUc8MN3WltAy2OHsIrB6
 6eixqAizBuIi9MZ3DbO9PId5wpeiVMnC9uhD28bwswdC+u2cMLee+J3BFfAc+vnk1MI6
 MTe3c97eQbfRHaldGVxVhW9Js/d3NvGvsEjp9I0UagP7nAeuLx5LoL4afsih3zLb5h0o
 aF1N/jZrGf+Se2jM63/8NRLKmw7K62zku/eV8Y8PwMqi3epO88SxMlVsddSlnl5d4mCq
 ODtw==
X-Gm-Message-State: AOAM531/+7Y/pgakZZ5JBemQhSPh5ldWhNsZC+3/7MqwAzYinMpdhKdr
 D2AYv7yir1UZW+VFpSDPrXXqQRDRcHMfSDCI7rHAl2snR/NjgwiJEh36Y0eSie+SUr3/cw9ifdp
 24J2GVfGE6sIwayJTiAm36mJiKg==
X-Received: by 2002:ac8:4d51:: with SMTP id x17mr13555232qtv.73.1597677693415; 
 Mon, 17 Aug 2020 08:21:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1MKv4bXK88vqodhezur1r/o2c/gfdRpVruisZy+AE42hO8GED1MCnwbKax2pqifcc17HPhg==
X-Received: by 2002:ac8:4d51:: with SMTP id x17mr13555210qtv.73.1597677693190; 
 Mon, 17 Aug 2020 08:21:33 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id k24sm20347974qtb.26.2020.08.17.08.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 08:21:32 -0700 (PDT)
Message-ID: <ab808ea5782ea14c7d521d2869c211b925bbcb5a.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Don't return error code when crtc is null
From: Lyude Paul <lyude@redhat.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, mikita.lipski@amd.com, 
 nicholas.kazlauskas@amd.com, alexander.deucher@amd.com
Date: Mon, 17 Aug 2020 11:21:30 -0400
In-Reply-To: <20200814170140.24917-1-Bhawanpreet.Lakha@amd.com>
References: <20200814170140.24917-1-Bhawanpreet.Lakha@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will go ahead and push this to drm-misc-fixes, thanks!

On Fri, 2020-08-14 at 13:01 -0400, Bhawanpreet Lakha wrote:
> [Why]
> In certain cases the crtc can be NULL and returning -EINVAL causes
> atomic check to fail when it shouln't. This leads to valid
> configurations failing because atomic check fails.
> 
> [How]
> Don't early return if crtc is null
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 70c4b7afed12..bc90a1485699 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -5037,8 +5037,8 @@ int drm_dp_mst_add_affected_dsc_crtcs(struct
> drm_atomic_state *state, struct drm
>  
>  		crtc = conn_state->crtc;
>  
> -		if (WARN_ON(!crtc))
> -			return -EINVAL;
> +		if (!crtc)
> +			continue;
>  
>  		if (!drm_dp_mst_dsc_aux_for_port(pos->port))
>  			continue;
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
