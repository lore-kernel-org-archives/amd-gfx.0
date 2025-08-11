Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497DC87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC7810E424;
	Mon, 11 Aug 2025 10:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pWvBRDlF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C291410E421
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:26:35 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKM2018332
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/4tDhgxFTFm32rKj8OsdQCqN
 y65/pv1+di1cZhSEdpw=; b=pWvBRDlFziWWj5HuLW6H45HJTcZttvz9ESkLk0uM
 NtbaIchPIMRUyLPnyIR695bRbOQWNCjwWRwgAk98kCYBnBk2qh5jQ9es6go3Dgpg
 SX0ssCGAI/alg9bRIIxq88G2InB6hzr1moD5U2QhV8hcyL7P2ZOnVtuws4dAJudD
 P4Vl5Qf8a60HnW3Xrnv7Nj+bn70KreoYJvyxCBy2nKp1EHBjp1VEjRzZoYaV7NRR
 wr8dg/RegWDNJIexQISYO07Ju5oRebJOEov79b/yNy4tD2rXH16OGqiewyhKLbnP
 XhaGft8cga81AclHPne3cWxWUUNOydlCvoPt9MBVsTVZ1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g3ygm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:26:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b061ad3cc0so132744101cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 03:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754907994; x=1755512794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4tDhgxFTFm32rKj8OsdQCqNy65/pv1+di1cZhSEdpw=;
 b=Smz/YJtjKdpTk8I4tQ9ARboyywrEkEAqZ4tzCfAvluhTm5DNPCXszkQxFlFQ7K4tD4
 UAQkzg5bDPIUudszwUTFOegWr2MQc5Qx09KjU2NrvkSRtuE/R/puWL5LU2MYf7l3rzHu
 eEzWgddA+yEC4//Vu8yqqPVyD5zvF7keNnqxTgqS1xJILqK3zfx9rRsilnQ+ZhuCS9UJ
 AXcopx+G1Rr9QWFmvumvWRbNhmhH+sTSAMFGvw148rlrRf+W1Y0WwDok2XdBc/hyH2fd
 Aa71wdbwHLCctSYr5X41IVG6g301Q9mh7QA6MctnD4LfPAfG7BaCAEh/2d0qcKVplcIm
 ZXPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwZ4wXtEb7NY2FR8PCrTk/XnA2xmtx/tUgdG4JD491lWWqTEDuIPNbfpOIqM5uNLF3rtBln7rS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/0z+dTZCo3BuZvtfvy9aM7b9KKGfF5V6ZSj+Ndq6sVmdpU27N
 fXVYrGV38GjuPYgCZif5MEE9XzhtSWfvz+K4AsvG4ANGagdWHhGaxkMVoId0zXEzW0hOeZf+C4x
 wD52OTrh2g5RsvTR0lY0UaEjF93UJndoWqlTdgGHrw2Mzcgk+E5VCL5rVJfKuMg9+89Q0
X-Gm-Gg: ASbGnctp0NOK6Sc2Tpcf2dwvEMKtteWucl0bH4uGNwec7V2mtJZt06PuCn4gjw98Jwm
 ayU2pTqLwp7QEMa4GfeAcgJI/dQ8DOacPLaYxnoqbIFdHhRoqjAHKhoLc/J+VhyA5XkFAGUzJ/F
 9KVOn+i3aW4F8S4jxL97zMd7rekSotVL3shPeILqnXUH0wHLnwifKLkm7OrSbR1QnhkA3+HmiyZ
 tOa4w/eGqVGVd3Ejh78H8eC6e/GwUocUk2anVf9UK/YMDZWiFzR+sViqYbaduXAqhBEPz69weuM
 5DW55pXo9P93Djb3xG6K+R20PipPhJVjQe7O3Y5YMY0pOTXRreqTDx+pXvA4L7fArPM5HNabdWo
 3uWxjXWS836CDzFfPvglmVt9XD+qHVgZ5XT5LKJW9Q9h1hVwm/TMY
X-Received: by 2002:a05:622a:ca:b0:4b0:80c2:6674 with SMTP id
 d75a77b69052e-4b0aec9df57mr160251191cf.26.1754907993650; 
 Mon, 11 Aug 2025 03:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBtZfXQ4QunBGnECg8IgNPTThfg2oORkBUD9GYQsf+7kkjIYq2XXmXZ3mbOFg4UkIpF+IRdA==
X-Received: by 2002:a05:622a:ca:b0:4b0:80c2:6674 with SMTP id
 d75a77b69052e-4b0aec9df57mr160250851cf.26.1754907993170; 
 Mon, 11 Aug 2025 03:26:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-332388fef31sm41894971fa.70.2025.08.11.03.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 03:26:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:26:30 +0300
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
Subject: Re: [RFC PATCH 8/8] drm/msm/dpu: Adapt dpu writeback to new
 drm_writeback_connector
Message-ID: <ag34es6qm4b22qti4hbsju6sk5ny7ixq5fiwtni22vf7tvx5ba@ficntlx6i2hs>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-9-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092707.3986802-9-suraj.kandpal@intel.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c55b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=Fxrl8DOH8qgm06HfJ5gA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXwtYpu16laky5
 llUpQx/Omyr3MyFRBMMx73rfa3Nwra713QFQOprJAaQWuoflxvnNqRXwjnuhVk7Po6Oxy6FVXxo
 4eA77zKMuVDsHT7DvQicbXio3vuON7ixsyHMplG9BZ5jY2vys1CHSMitTM2rnetUspbyvnctijc
 mpLfJax+QCVxTd2ZHEMYN113NmDyd8s5pBGGKgFSJKL1Hq7zmCT09QgvnMzk7MgObKrYCQ5mNWj
 Tmg/einm4Dg+V9lbEM5DLiEjBumjBaL3r605MYvPsavEbObF+0jGW0sSOVprk4vrFnZgr2XflpA
 m0gS68IUFRkAez7Fz4qS+A0CBXeXPatOdcRla93VvPP4zYI7xPozczGp+1LZuC9VCZLtuAaSNg/
 B1CgHYZU
X-Proofpoint-GUID: 8LW8UQen061RpvRkV-LWyMBk7IVUL7mA
X-Proofpoint-ORIG-GUID: 8LW8UQen061RpvRkV-LWyMBk7IVUL7mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031
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

On Mon, Aug 11, 2025 at 02:57:07PM +0530, Suraj Kandpal wrote:
> Now that drm_writeback_connector is embedded with the drm_connector
> adapt the dpu writeback functionality to this changes. This
> includes changing the drm_writeback_connector to be changed to
> drm_connector within the dpu_wb_connector.
> Some other changes are done which are a result of the all the above
> changes mentioned.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c  |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c    | 16 +++++++++-------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h    |  4 ++--
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 56a5b596554d..0e60c1ac07c5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -484,7 +484,8 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
>  		return;
>  	}
>  
> -	drm_conn = &wb_enc->wb_conn->base;
> +	drm_conn =
> +		container_of(wb_enc->wb_conn, struct drm_connector, writeback);

Just store drm_connector in dpu_encoder_phys_wb instead of
drm_writeback_connector.

>  	state = drm_conn->state;
>  
>  	if (wb_enc->wb_conn && wb_enc->wb_job)

-- 
With best wishes
Dmitry
