Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA1FC87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE83E10E413;
	Mon, 11 Aug 2025 10:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDwP+B0O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABF010E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:13:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9jE028799
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tQBekwLY985lR0kL588BU9IYUYSsm3EJi76WLENqjaQ=; b=FDwP+B0OX5UBuh1A
 yaBnSgBA4PZ6KYN6UyxgXDpyNLwikqLtNO6NVZchMnFrdq1fHAr9zI3JLW/AKlB5
 nxIdKbXb87PbAZ2UiPni3kloNPTITgFmGv6lF1CH2AdwpxGy6DNhc7/lMRaa26ok
 AXFCp45EK0v4y/nT5fwiGnPWYU5wcC6mTKy1VYu3ol63+TOPdiuiJhcv9r7YqKYs
 RQyuqXukejuJ37d/tRE8V2Cn/2VVJ0n0OTxLwyvmy5rBgwi3p4b6oJM3S+Eqe5Zd
 9GSCTxs/jeBsJi5cJ0uWNqxOvHZKxGtVOz3gUSCF+MmelO9zM2JtUXFL9SlErhyO
 3BHiYQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sm32v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:13:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7074bad04efso94474616d6.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 03:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754907218; x=1755512018;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tQBekwLY985lR0kL588BU9IYUYSsm3EJi76WLENqjaQ=;
 b=NftEoteuneIOQTDWghlbYb89Q9uxmwU/F7guFKXUlcGAjdOyHr0HEDpZ9YKU597whk
 6zUE87vO8shg4wxpRYwHQEqJK0cG5NhCpHCWEcKRdBtRDFeoTXRipV9uNGA4O0e5NIy8
 rbjrfB+sRn/+qbCQxrp2YJRkcNTKe8qo+9mp3iSUHg99fkemqEmwLDysAnhZ6vuFQ77I
 I/vA8mFftQ3iymilc88AOSxX8/yL+Xw9ywAwiwwVH4yL6HdT9Ejtx9ljVHexYtJBQ6k5
 A2bOH10eszwFvdCmDdMNHtMiV9D1UH0G2OC5qndOGxtul1LYQU13Km0WOAQo19RtPSOm
 ymNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCZ4Kc+5x0rRERIL096/NwEuOahxJhddXovaEaTc0FVMZ6rNJeQgNDYTO3GQ4o0u5DufPxoqoL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg6odTCpqA5SOSDbfSvUvRuDy7JuHubNd7mc7fiNAFVJ3Wmwga
 rr+UJfcXeAzLO7U589BoPaAEuf5cY5pIXE8AyrbRwTYjtwMMorR0adNpU9hXDyEKT7GJIuXsdl6
 tq5ylEHbib7CfzVVVuGOdxfx2itQKVFgbCiMO3v8EHJ0ZH9EPl9lTqwFIG+bLUpzBnBSW
X-Gm-Gg: ASbGncvXZD0ZWa7t6osZimqiZ3Q0mSqgqLWQUcZevZ6QDEGiBVIdDltOkZwTlmYxBaM
 86QWtriMsoSU5rlnSHMvmaTsVzuN4j5rvQ7xUqzAhqUDauuT9h0T9adkNKo3CnjYUYWu89YYZHl
 c5TnG57PPkyLlJhEEh88sGMXXH3pUGyGbDGn8Akmoa9AiTs0KATCFMjZMqAVl89pCySrRZ5TNwM
 ottq2FAryllrcsolioZSYVnH+P0lQahKrENB+eqJHaeqEt8Xb286x0gym8B+eg7dsjXjwr7jBxI
 PsC1MyfPSMhTaJ9IHaIP4QXYY0YXofF/KJk6jAPzzEFVoLTv13a99i0Y9u1gF/IQlmAVEGFA8M9
 XKsDpkaZzGiSZQYjGgwxhL0z+E0q0owXF5N596P9bLZHQGgBMbQsv
X-Received: by 2002:a05:6214:2422:b0:707:6409:d001 with SMTP id
 6a1803df08f44-7098943a0camr242700466d6.21.1754907218071; 
 Mon, 11 Aug 2025 03:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BY/zT1y+b3ji4GZxhC3ZVhQrv/r/mWPNZE1y3jpndTSli2Cjg/bMQSHGPbSf9yhMaetFWQ==
X-Received: by 2002:a05:6214:2422:b0:707:6409:d001 with SMTP id
 6a1803df08f44-7098943a0camr242699906d6.21.1754907217606; 
 Mon, 11 Aug 2025 03:13:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-332382a905fsm41770471fa.21.2025.08.11.03.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 03:13:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:13:34 +0300
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
Message-ID: <gvshpndrbnojzwewwa3icd5fjwecqj57jj6gfgoips5xq2oo3l@3dsebzcjwr7t>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811092707.3986802-2-suraj.kandpal@intel.com>
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=6899c253 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=JhAXgKmwuo5aGy_CkLIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 7Z-YF90ZwAUjpuUtVbFmSFBgS3YJ6CQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX+Ro7V4bzKJfn
 7Bfhy+Yi2MoVNnGcHBWaecC4k/g0AD+kU0/x8d6kuij1P+VAy9D9TmJV3SLSRXRBGbeZZJT8JXt
 KZlwFoWLmBOIbapK4/JvqGc2ciInZs4p/9fNQjctfSNb/ehpwAyj+2I994pvXi4/C59we8BIxa2
 mU3BDosxunrNRRnJIm8oCm+1O96gt5Da0SWWr21ogZZmBnn4hAeLgFIxxej6BytJH47ymvAYR8L
 UKL5MR0eMi2/onU/htPIMXljQauB0c6Ujt8ejzHvKzSbQeWda1oHTHBBZ6ZxYhOwxWmsB5STTR8
 JtzrgM5WI/5lj66urjJ07mHkQQQVfrGoP8JNXx9w8OcLeYUyUZksBXiUwZ6UnhQsgeDoCcNXcZU
 XceJH5pX
X-Proofpoint-GUID: 7Z-YF90ZwAUjpuUtVbFmSFBgS3YJ6CQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
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

This patch breaks building of drivers:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c: In function ‘dpu_encoder_phys_wb_prepare_for_kickoff’:
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:487:36: error: ‘struct drm_writeback_connector’ has no member named ‘base’
  487 |         drm_conn = &wb_enc->wb_conn->base;
      |                                    ^~

Please perform step-by-step modifications, making sure that on each
step all the drivers can be built and function as expected.

> 
> @@ -2305,6 +2360,11 @@ struct drm_connector {
>  	 * @cec: CEC-related data.
>  	 */
>  	struct drm_connector_cec cec;
> +
> +	/**
> +	 * @writeback: Writeback related valriables.
> +	 */
> +	struct drm_writeback_connector writeback;

I will respond to this in another thread.

>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)

-- 
With best wishes
Dmitry
