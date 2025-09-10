Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475FCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 19:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F6E10E0C6;
	Wed, 10 Sep 2025 19:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="avc37zmE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B136D10E0C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:44:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgFax020848
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MRFwGcw4G0+ktZMni3vfLtmQ
 O/YRU2ZQtqpoFx/hjaA=; b=avc37zmEzVW7YjVsxItPhtWI22GJZQQOvskkWisI
 fAPD0eUnTWrwGwoiLO6/vxsGmyPbq3IOT3bDNSVNVJ9Cb2MPH1f/YAmv7QAcY8Lh
 yTzmcpRFSSiZfYNDmLTj7y+7A+m6xea7WQH0GmwOe5wmaLw5jv5tY2TEC0YocBab
 CzOvW1/dr2D6JZc7kOT9YGSwQkckprDcudn/1rdT9By0GObcCpBRtPZxTT2b7c1e
 QPuKJ5WTYEV9Uc7qEOByIVZQUFjqVgbtBlcdN/okWE5aChurpHzl8cLP8lDRQrBc
 PU9xSiqsSMWBtA8NUcn7IkT2woCXAPQ+JlIxcIPC+4K4PA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc295d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:44:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-75e974f3f7dso13155046d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 12:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757533478; x=1758138278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRFwGcw4G0+ktZMni3vfLtmQO/YRU2ZQtqpoFx/hjaA=;
 b=sPk7cz8Iz/4ahOtddREbR+RzKGQIKdENBYcizW/TD+bJdzS64FIuSn410WFtqkQGdx
 L30AQ1+NIzQmeW1qG3Hti8MAoPICvkV2RxoUUAFlDByt19HC+qwLzb++YxV3Umt8Z2FJ
 KcpSNjlRYEZNm4gCYBD1M5frkn/5ZWcHydoUQxXxr8ljiKUUe9HKkGnQ/CNQhVIpS0ja
 sbTHuFH7mgrOpTnok4gZBvaCuUyjLe20t+4hr6IwjqCHfY+q1WZ1f93A4y1IBPPVEGtt
 MHYoW1njeJ+e5Q9XgQVkC96E2h5F6HaauFIa7agNkzwSMFn3Y57ENV64wScF9iVvE5Hc
 XLIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzhc//n3ZY6YyZZUzKFJFrAtkNfA0JhawpZ77ZWT8GgwVos75D3ElCAFumsT1oD5QQst1ySdyH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsP0nHWtwcyEW3Mb2BRELaDEGi6dWgpp3bD08yeo2rJtoTwgjg
 qjltOsuepP7tekt/qdgCse8TuY+l3p5FhOEkBRX0vXgjMFKWokCGWV8Z6q+tG6tW3wTJxQWNK26
 XHo45xCzoywSkodBN2yrLeG8uujZaB7AP2Rw9iGn4qduJ9gG61mfnx/OfWHq0GWlxMC5H
X-Gm-Gg: ASbGncu6S5oG2oEtcUmZDt2IQlkGCBj1SluZ1F2uc43JBdZ+x+o8L8okB41e2oTe4mM
 cNTW3OxIcfzD+j4PMyCSIgI71Xt7SPAm0l5fj8HgQlFL2LMFPrws1L4g70dSU/Zrv3se/D9lZzW
 GUNX/EEg7GucU4QZM7hGL0YsqAMj19t/7bx+GhoJkzJqjZ73k/UZ+0jpmJoqKbN9PBs7ux77z2+
 3nHW9iBvonoXkF0NeToteFsK7tDqRvRnZOPtprfdsBlXAxiywsASGDV+DgFR6xbGqb8RWyjHsmM
 IpP2ge8zgD6zpXYGfW0KqJ2G3Fu8wq43w3gtjWstUN877FXyYTJwGQxT0UtlS9vvY560lOz8+3X
 UtKY5GsJoZOOpXOo/3PIA5D5Fu+ehhl3fOHNAOKKvLwx78k3Ua0LM
X-Received: by 2002:a05:6214:d83:b0:722:4cf0:43ca with SMTP id
 6a1803df08f44-7393ec165cfmr207443146d6.36.1757533477914; 
 Wed, 10 Sep 2025 12:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLTybLfL00fFfCA42iPicU5GPH+S6SfBfiUJaoauFhGCNadtLOwQ0vunk0e3CAte+J5/R2vA==
X-Received: by 2002:a05:6214:d83:b0:722:4cf0:43ca with SMTP id
 6a1803df08f44-7393ec165cfmr207442566d6.36.1757533477313; 
 Wed, 10 Sep 2025 12:44:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-337f4c4ffd5sm43997081fa.14.2025.09.10.12.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:44:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:44:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
 arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
 harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, tzimmermann@suse.de,
 jessica.zhang@oss.qualcomm.com, sean@poorly.run,
 marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [PATCH 2/7] drm: writeback: Modify writeback init helpers
Message-ID: <nw4ehd7a655rzyf6g5yxb3z25en45esja2i5uowzy4wpmb2el6@orycag5iccho>
References: <20250909100649.1509696-1-suraj.kandpal@intel.com>
 <20250909100649.1509696-3-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909100649.1509696-3-suraj.kandpal@intel.com>
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c1d526 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QyXUC8HyAAAA:8 a=T65gB5C1oy4ZwBZl7KYA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: MH8u733L1GaFbuKnLguEqBvpoERXWRvp
X-Proofpoint-GUID: MH8u733L1GaFbuKnLguEqBvpoERXWRvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX4DLPbBOWwlp4
 S85e+HG9NoqPKFH5OS2tQvqoqmoVB5nQAgVROq2MjYcfvHNZqsfMoGMyMJ0Kl27/ODhUsmeP2xH
 sOacjhrTZVbcfKdlsojAGBGpz0saZyU1cRnKTnwXeFmOcVGw/rwDQXni1/0C/REKjaPwmThqGwU
 xWXSeici3hEUHto5AZFbwC6F1I9BtLM1OnnjjCAAIKkVijz4roYcwckl4wbdSt/ravrrYRyflx/
 wSS2stsq9fjoi3UOO/zTDupZYf7IynWjNKacNs+bxu2Ds2BT8+oyM2W+t/3vhzspaS/+78R9wSz
 8+z1RA1g3i221tCoS09RMkx5c1WHaeLiuTqCPQ+fJmMdx8ujn+ztaRAN7RafstJ2unDJMhbbJWo
 ebfRVulx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094
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

On Tue, Sep 09, 2025 at 03:36:44PM +0530, Suraj Kandpal wrote:
> Now with drm_writeback_connector moved to drm_connector it makes
> more sense use drm_connector as an argument rather than drm_connector.

than drm_writeback_connector

> The writeback connector can easily be derived from drm_connector.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c |  2 +-
>  .../drm/arm/display/komeda/komeda_wb_connector.c |  5 +----
>  drivers/gpu/drm/arm/malidp_mw.c                  |  2 +-
>  drivers/gpu/drm/drm_writeback.c                  | 16 ++++++++--------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c    |  2 +-
>  .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c  |  3 +--
>  drivers/gpu/drm/vc4/vc4_txp.c                    |  2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c            |  4 ++--
>  include/drm/drm_writeback.h                      |  4 ++--
>  9 files changed, 18 insertions(+), 22 deletions(-)
> 
> @@ -338,13 +338,13 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   * Returns: 0 on success, or a negative error code
>   */
>  int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>  				  const struct drm_connector_funcs *con_funcs,
>  				  struct drm_encoder *enc,
>  				  const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector =
> -		drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector =
> +		drm_connector_to_writeback(connector);

You can use &connector->writeback without extra wrappers.

>  	int ret;
>  
>  	ret = drmm_connector_init(dev, connector, con_funcs,

-- 
With best wishes
Dmitry
