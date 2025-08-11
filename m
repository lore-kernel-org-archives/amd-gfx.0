Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F49CA0EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3531610E428;
	Mon, 11 Aug 2025 10:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9sOpvJs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED1010E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:28:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGqaT024522
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=S0wh/vf9/ahF7czkuW2zqdi/
 QK9zgAaa0tIwnSvWMPo=; b=d9sOpvJshStdAy5fa3QCF2K0LlzG6kYdh0u51C12
 tq/CY6gep0XLjkozWPaZQAAVnQKqRxdS22XjMpXF9KpTa/xwmJklZcYi58+wVtBz
 uccjxAgMX3MC0JIAnZBb19FrvZGpx6IfkxOaa+Oaw4McjQGiTFsw+pKUpU8mxJjs
 7N8dBL8C/OS0coltbGBCZHdG9r++tckpKwCpGwDM/DS10wGnY6qgBbwKEhy1sYxr
 kOIn4k/qhvBDr23TfRdX3tXIKif+NCPm8UvNEutjTP9aa6ceDjrb26lTlYkSltQp
 1okPKCG5h7mnm9HBgpDlZUdf7Uhjsf8pf+jXYzOJhqBDmw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem480ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:28:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b06908ccacso100656481cf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908088; x=1755512888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0wh/vf9/ahF7czkuW2zqdi/QK9zgAaa0tIwnSvWMPo=;
 b=e891AfvGRSV0jpLglClD2+UU9ylcUORyuVH0rc8llXJf0YSNqgzj/HFy0vLkTkPQ7Z
 mxEBl6aeK2wHCrV3qXBjzDcnAor0JrJFl6t77olTOZGjFsvaOUH14wCHHbfcBBHeOzIZ
 Ve9keY/cAI+LxtZGCdTU/4/u/KSYfRqIQF0ZMUv/d7mlKnikoeuZ5rZJmbFzyTzvzOT2
 vQ7nAqh93XPemuZaTN3yHGdELQ2w/dKMGxsEcL1h+qPbyk5LOAKdND0rDgaui26q+nfX
 vR28c8DtryX0Qi+wYyH+7BiA7f5/rc0FXWez1heqMUnLeeh+qkhCafWg12em+9nAvj1o
 5CvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSBZDd8ky6/H4mZNdWmuLks525s/6fyHaDnBKu8pO/tM8cgg4vHxOVvue34q3l8fz6FZxJva0Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDXTPpsVyi9fIuZ40SHVY18EHWqPMF8PnlCgJvMLGWbIAk2kMV
 A8u3DtRxwEW+MWw9q1bXhjaU71VPs2Pu/qvBy8yAfFAj4EgSzBhA772z8DUtWLQyJin52srAjwf
 mrUqZTnpG7f4XUHKBYkClQiM22Qj83g8zKs++lqF9Qx9Zgg4GxLNKRE0gxC+88sRd3lIDr571gi
 7r
X-Gm-Gg: ASbGncuSm74ulqr1JTp69hpnh7A+N6LABAj0dCCMlJULdgGiQ+KZ8yoljzUO35nd43n
 ECCXlerdzsMdc78wPD3qenw8epwduNMDeo3OBDV03db+toLKJWA0IsaaBLS5UAurtFxHmWDeZFK
 I6y2lElmOIMMmxNdltDr4O74omYD9U7pu2dveGudqDvaCmpmKu0UV1hNpj2mV5TVHg0VfKHNXry
 NXJW0I6Qva34DZmz/OTka8nhOv1cTiNp4velm4rB1DfGt3YOwIUwrCaKDHA474ATzvdH7V0HqAI
 j6F0gCu9KmcTaYyk7+zGzw8C3Y1ayAHs1XY4a6dZRcDN/WhiOhX2QO/3W2pXr17hhrqlfhWB+vn
 nTLHpJqM/XOzAeQDxpmbfbYF56jPaciFsUkKMidNazW54i5dJ+EOa
X-Received: by 2002:a05:622a:348:b0:4b0:889b:bc5e with SMTP id
 d75a77b69052e-4b0ca69c598mr83121341cf.22.1754908088384; 
 Mon, 11 Aug 2025 03:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChlYy+rk1d69F1ULSQJbZUJQYjmNVQhVTyYQ4mc1AGZP7o17UaEkItyvfAe/6wocgG6cF7g==
X-Received: by 2002:a05:622a:348:b0:4b0:889b:bc5e with SMTP id
 d75a77b69052e-4b0ca69c598mr83120731cf.22.1754908087789; 
 Mon, 11 Aug 2025 03:28:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b88cabb7fsm4247040e87.146.2025.08.11.03.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 03:28:06 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:28:05 +0300
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
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <g7ny277cnctr3edw53qyutiyv3yxah2m7pulg2u6gud6f2gla6@micq4aliwx3i>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092707.3986802-2-suraj.kandpal@intel.com>
X-Proofpoint-GUID: A0qshM5UJjKlWKGD3V1tMr7Z38jSXpyx
X-Proofpoint-ORIG-GUID: A0qshM5UJjKlWKGD3V1tMr7Z38jSXpyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXzH0vCAgMGS2j
 ZUzE6eljM02+URicYh4ThO+CbQsJZ/uq0FgB3fxA7otkqOQ+uj167Q4br2Ctc6ki83EXNUSdEbj
 mppTjDeKV4ljWb00oQnR5mCbDgIGvVCRd5eyF3hO2BIg0vbJH6LQ6aOubaWEomczbHsJ44AaFdM
 BfPM1V6ahfbCTdJVHni1xHDaZK+Pwgw11P2pd8hOufg/A32/ECDTHHHXxS5jAI6ZS5N4usRrIlK
 c24czk/z29IUN4LELx363PY1tnbyQ6ddQwsdwm1/vcaEQbhojN4uwfXlM8dK3G6MpOhp9jdZBmD
 l+kLPG8vUkQHYihEjBH63LZxhlCwHeeTbE7q7OlUvkwlfplmJuSCbfbw2Ustrr89lJUpXo6A1IQ
 RqIMwrRO
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899c5ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=-zeacxS0QVZa6ZkZsZMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068
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

On Mon, Aug 11, 2025 at 02:57:00PM +0530, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not.
> To solve this we move the drm_writeback_connector within the
> drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. We do all other required
> modifications that come with these changes along with addition
> of new function which returns the drm_connector when
> drm_writeback_connector is present.
> All drivers will be expected to allocate the drm_connector.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/drm_writeback.c | 33 ++++++++++------
>  include/drm/drm_connector.h     | 60 +++++++++++++++++++++++++++++
>  include/drm/drm_writeback.h     | 68 ++++-----------------------------
>  3 files changed, 89 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index ec2575c4c21b..198b8c488056 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -89,8 +89,10 @@ static const char *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
>  {
>  	struct drm_writeback_connector *wb_connector =
>  		fence_to_wb_connector(fence);
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  
> -	return wb_connector->base.dev->driver->name;
> +	return connector->dev->driver->name;
>  }
>  
>  static const char *
> @@ -187,7 +189,8 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>  					  struct drm_encoder *enc, const u32 *formats,
>  					  int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  	struct drm_mode_config *config = &dev->mode_config;
>  	struct drm_property_blob *blob;
>  	int ret = create_writeback_properties(dev);
> @@ -269,7 +272,8 @@ int drm_writeback_connector_init(struct drm_device *dev,
>  				 struct drm_encoder *enc,
>  				 const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);

Please pass drm_connector instead (to all init functions). It would make
more sense.

>  	int ret;
>  
>  	ret = drm_connector_init(dev, connector, con_funcs,
> @@ -339,7 +343,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
>  				  struct drm_encoder *enc,
>  				  const u32 *formats, int n_formats)
>  {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector =
> +		drm_writeback_to_connector(wb_connector);
>  	int ret;
>  
>  	ret = drmm_connector_init(dev, connector, con_funcs,

-- 
With best wishes
Dmitry
