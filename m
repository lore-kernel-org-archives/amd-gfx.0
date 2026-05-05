Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B624CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBBC10E8E9;
	Tue,  5 May 2026 00:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX4xsM/z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y8LPHlbI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8659010E8E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:31:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644IBcKE1151327
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9bpCGbXjqCOIAvvOUlLB2mc5
 4kkmnK5Hi4mDPrlwbVg=; b=PX4xsM/zVOQ+BGoq3faD6CRBTEjk/8HQYr4tOenZ
 SvRGdwDJQkJNGw/Wr6FzZ5pqu3iTRSieHe5vU/CrPRyEMIc4I92RYacX0zMmQIYx
 6S3II89aQ3eYYJuiS+Qp4NLKy5sR5KANdxzvPyf0G0WI2tsXq/w1FQ4xrh1DRE13
 oXBl/YAN2ozv9Rt7rgKU8oOzEpugxBY3fLAYX515vlCYVcc7sQ2GsXQjqiU920yr
 OTkCGvkzA/j8Pf06G3SNiYhP/QI5AsqSA8ytKLRDa+PMtN1d1aouUheADp88ZN1B
 c4KJeNtsydEogxYU8rn9416vI/+nf9+NOfEwAksf2UmvHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscyat06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:31:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso186202236d6.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941115; x=1778545915;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9bpCGbXjqCOIAvvOUlLB2mc54kkmnK5Hi4mDPrlwbVg=;
 b=Y8LPHlbIAGXxwN+78YEkMkj+OKrXbBh2BbkpHxUz2jlT8V2nsjCpwpwhEGOxWpItnZ
 iFqHY6AWEv8S5eTNoCJzObxuwFBeU00cj6/pPqOMTMZBlArRPEgA1vbOa0h2Bv4e/+d/
 IMV93q7KZb2Oh9kVJQ73zBVw2ECT8nkAVD7Ybof0rPfKEHrjcIFHL9UCISjqbFxE9XyI
 6n4zX0RoObHIQFhE8orVrnDZhOe19adXtH7To44ppgQXppbcJzM3cEm3H67EgT+g1N+j
 o6PAAbPyguQh7bGVgi5QqZCHYTiqpLjWkZ8MA6jAvzMTRjiz6grCfZb+omfJxNi7IPWQ
 ylzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941115; x=1778545915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bpCGbXjqCOIAvvOUlLB2mc54kkmnK5Hi4mDPrlwbVg=;
 b=HrutNPqqlwaQhgZ2X1m9z4LUMTZyZYwxt0vmzyq6WmtSdqtQd5JyE4p63AU66EjpAb
 we/I7nBQbEZj7JliMP+NzxRglINGy7Z1337rWso0s1+UsP3uC57jNE19ks+bwE9jPi84
 161shaQ4V9wttk54joPC2IhXQb8/aZWxX1gHwPqA08StZb7Dr++UnvdfNijjb+Js+2qO
 TKP5jO1a19RpFrzwGVU9HjVgfeKJGnzZ+GQauk0FLU8Rj/Yg3nc+Lxg6H2uX+jsmSKer
 mDcFTZ5s95XDa6yVV7rID9TNzkRoYf9rWYwBX9TzMdcAsj0e2sImgRjt41nlVCfxS1+K
 /DKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AlNat6ACoSFNqrJc8flb1TJ4yBeYh0lR4CpYzbYj/BaJAhdZKQ3+g/mtuQp3ZWB5jKX/YD0YV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyYyl/G1NmF+u1r895SzBAs38DzkSVXSNHPfyUc4ItztougD+I
 ujfQenkr/jPJ/Yd+P+Fn2sT+XfACngJB3UUP1F5lNTMxkRRDJqRT/vBU04xfVXqC3HhvCAHO4ok
 ddTOP8GsSvrq5PUDatHQfqme1/q7D6DiB2LoRjlahcZOC1VkIPJ98AbUW9TCFZV0tLc22
X-Gm-Gg: AeBDievmaG0Bl52rE7iv2lbFR4H3+I/dWKYKvLIsI/f1v1kiy0kEadWYHuZgCi12/oY
 rucGwHTYj3pIBnfuu1n3vW3gXDFvhp5hy8vYFKZcZTq13M6Nsz/Zfhzz1NPbiv6GkXph7Q5+xrG
 62jdeAT6LvpfE10UGfsqT/sy83WLBtB0Ulhgih+DgJrGpdB7k1IqE+Ih8rbloyiDdgre4hsb39C
 CX7vN9ufeCoMGI363GtU5ttmYeLHfxZSa2K6Vd7/N0DNeA1X/HI1wC4jBRwifWBiCXHz8i2wEzy
 YLyshitXA+x0+VwS/Htec8BgLVjos6CmGP9k4dLgCzNOyNb1tuc+La5LXLApTSLru2DUcjA3TAJ
 ViOrkWl8lLjo6XBu5H8IqdcfFPJLcGTv6XcckHtmpXs6XMbT4ckdWyL+zwvywtNfzDPdDUHRa33
 uGVfLSqGI+zr2HEq+p2Y4kjDjJJfbS4Ftg1dcYGd8Q1DBiTA==
X-Received: by 2002:a05:622a:1495:b0:501:17a9:5ff5 with SMTP id
 d75a77b69052e-513069e6f34mr15970621cf.21.1777941115051; 
 Mon, 04 May 2026 17:31:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1495:b0:501:17a9:5ff5 with SMTP id
 d75a77b69052e-513069e6f34mr15970211cf.21.1777941114636; 
 Mon, 04 May 2026 17:31:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c346d1csm3387545e87.75.2026.05.04.17.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:31:53 -0700 (PDT)
Date: Tue, 5 May 2026 03:31:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
 uma.shankar@intel.com, arun.r.murthy@intel.com, jani.nikula@intel.com,
 harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, tzimmermann@suse.de, sean@poorly.ru,
 marijn.suijten@somainline.org, laurent.pinchart+renesas@ideasonboard.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v3 3/7] drm: writeback: Modify drm_writeback_queue_job
 params
Message-ID: <cccungluhdcfgdqdo24pgmqmugeohvqr76nuibp5m3tdfirj3a@yclibqr4ftr5>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
 <20260316083008.87466-4-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316083008.87466-4-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMyBTYWx0ZWRfX5l/7iU+14t/L
 wcBu9/pl0/hF5kSH7lhieioz8p+ULiA9UB+gQznpPkbbdx0N6Pk0fEUDV/zVBmeGM2xgG1V8Njw
 2KRRyClXhGonuGXhddIJIZo56Bb93s4eLv4VPtxz3Eo7Ve6rXrZ2+j7lAkiD81gud0Ims/M5kBG
 21zKypJLXM35pplCdzar+VevCWtHFZkRFUi1xIWwPFcYSrlDM6+FtcKeIec5oeSlycHXlrqkjO3
 o3Am4DPD7XLP+4hGwGRCYU3xESJRzAZIGjMbCR+/xp2u07P2d6ULv9PRWHGOwiurDk1EcprRJMT
 LERbXBe65MosoAeYFKwsVPP10Vt0j0m6kKgfK/YKKZmrcJeBUo3WnVOifLsOHu/Vd4v4pzKgfma
 UqCqWaDM+HjK2DnLcmJqVQKyh7fkQGYJPAfF+SX+K+u0GDIRerDVOk3Gssw6LD/6/SGy/PFybX2
 ESNmX7XXE8wiDuWhJqQ==
X-Proofpoint-ORIG-GUID: VUnylrBV6G0OQzrDNMHGbBR6ZB0RExgf
X-Proofpoint-GUID: VUnylrBV6G0OQzrDNMHGbBR6ZB0RExgf
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f93a7c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=O7Z1nR-Lyzu68zncWUoA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050003
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

On Mon, Mar 16, 2026 at 02:00:05PM +0530, Suraj Kandpal wrote:
> Move to using drm_connector structure instead of drm_writeback_connector
> since this now writeback resides within drm_connector.
> This helps make sure drivers change drm_writeback_connector
> using helpers provided by drm core.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
>  drivers/gpu/drm/arm/malidp_mw.c                     | 3 +--
>  drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 4 ++--
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
>  drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c               | 3 +--
>  include/drm/drm_writeback.h                         | 2 +-
>  9 files changed, 13 insertions(+), 13 deletions(-)

Except for the commit message (where John's note applies):

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
