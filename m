Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB06ACD343A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108D810E900;
	Tue,  5 May 2026 00:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMZDiz0I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLqe/1Uv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA7010E05C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:35:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Lk0uJ1960499
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NpX6cchQLSsH6LH2boJjUcfU
 CfkpNdpGQlSuk6n0mLw=; b=UMZDiz0I7lVUfm/VJb7KhVcl4ksimUeZ2YvWZemi
 gvyC9lm8YCaf93HJKZcXMKiH3bVfs2cC8kfLbOlgn12p0YG7rN5gbBkXSdkmHNsR
 k3BajHitAQWal8EG095jqVV4TQb9Uh0x7z35nkIxmk3ETMZqMYN9/Usl6HFCPqFu
 Dc4vQvTIYV3ERffkVHo3FZlik1dDnFmQ4g0O0vPkd1ZNm8nA3c2+4tS5Wunu89e1
 I9pFoVRPjsEm/6Ap4FSE8hYF1In9YYdhOwRnPwe5qpc5EC7mJI+RP1WgnUjzJ56q
 tb3EKQ8VElC15C6UTyOCY+g6FB8XTrmSyXZtLodOBmlxuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dt233-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:35:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso163591781cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941351; x=1778546151;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NpX6cchQLSsH6LH2boJjUcfUCfkpNdpGQlSuk6n0mLw=;
 b=NLqe/1UvwCvJG57z26zqiPGAzPLDEVLk0R3EalQxUWxdVY1KZujqZEA54pgz+Ya2Z8
 ctEbkqx9c//NsFIldhPt9AJ/EyzSTxDDRWv6zqIkjtW8c2bisWJeYncW3xyBeZ0MAaKO
 HLuZJIxS/gnBHUQ3qPu7J2Z4+25iQYUmJhhSuRA7tQWJzhHjIF827bdGugq83084wWRs
 rfMxXw9dD9/kY9GBmrLK4J1v5Z2t3ZzmvsWiSQGxFweWltpXujCYAca5iuU3zZ3Rg3lC
 bGvvC5RN4YUQ9blDqME0tzOfXqT+gB5CJJQiMKwwjX1BO3VrZkjMUvAvbtaLljYro0iw
 Gg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941351; x=1778546151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpX6cchQLSsH6LH2boJjUcfUCfkpNdpGQlSuk6n0mLw=;
 b=e/UHNu3d8C53699ZQTJNOkD2jFwadv0KZu4DupOzAthfi3BSwfVYG3mZi2vfCPHmAb
 9JQvT63GAXbFkYM5R0izgzw64rrbGcyXhmj0WYhqCP8U+5smiooeowgGZsy1TZsjK5gg
 apH9VVRWwa5xAdujLlce1aoMp7NtETu6KLWFogXvEh+4rcRSKuDhl4eHd8V+prIXQhiL
 sUf8BnuQy4pLMtBLuqfD6sD1/M7k4oPdRf4jBrETUJCm5Vf0CH7STcCtQWbRkbYdcXwg
 vEHPsyGG/xtwq0kPFzov9P2JbDCOyxZMkSYm7aUDdUWwQoHrTSjAOXvbqv0faFqN0wrb
 +bxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Fnc8AfgZ1/iYd5nDj4XSJ3KHBMs/FxLACBsOEpQIqT50h6DR7PnPbeKziZofqnBy28tIlLPpT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg2ybsXztJ9TTF7MhT+bIxTn33JvCBf059VUvvTF9Nvckjph8S
 AnLE6tktt+TDmI4vAUZjhFqyVStC/514hVmd6aNXb4J7rt61foKa5PrmJdlohMzSJPeLY06Dleq
 0XsxsujZ7Wwd9LmzEfHAYMmfdkIP9UA/lfIaQ6Pf1vMbkENeGog15NuIJsLCLc7XatNyzU5GCs7
 xw
X-Gm-Gg: AeBDievAZf1mqpGpsKSxz/a9obecKGH8XxcgskzDCLIPPlkyX3cXtUAsTNvZZ8Re2cE
 N2RUP05V7Vb/a+GNut+cnGPrhSYK/W1iSWOEu56hfdyquVKmyMKj3WjrkfSrmIvmyZWNSRSa3YH
 sLTeDcFYNa3SSxjPl0kPL6M8o8TutEpAsTCgty/xVcP46lP0cGsHdkvKVwMyYqm8XLJ6gGGF6OQ
 PAJx2jvV/5eyCvmCsH1galu7ktXRgPtcocCQHzP95oO1jBzPMI6QvMwPxcj95oDWx92pJbqq+yM
 AHDeX8nN0LsB4el8ZtsySkd85XlufSaVrZxcOMbob9+rfPdkVP1fwBQGajFKKSna4eD7lW22NJ+
 LovhlQoZ+DVGNQDnfpPLdIkXNTFfRxWUMVZjwHMwgg8hAaIZ6QbXwj3RLPd7U5c5wGi2TQ5FhtF
 Gy3lWTPGdFHISoC42qe3/0Wo1iW98SgFgiUMs1YQOS28DNGQ==
X-Received: by 2002:a05:622a:4d8a:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-5130698bfc5mr17753741cf.5.1777941351524; 
 Mon, 04 May 2026 17:35:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8a:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-5130698bfc5mr17753151cf.5.1777941351115; 
 Mon, 04 May 2026 17:35:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c3418b8sm3432152e87.64.2026.05.04.17.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:35:48 -0700 (PDT)
Date: Tue, 5 May 2026 03:35:45 +0300
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
Subject: Re: [PATCH v3 7/7] drm/connector: Modify cleanup_writeback_job helper
Message-ID: <nfxifrthux5hej4foawtavpiaegtnorai5j5l5hljmrvxwi34s@nryizbirf3lv>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
 <20260316083008.87466-8-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316083008.87466-8-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMyBTYWx0ZWRfX31KwwHiM3jT4
 DT9CS6igjZJApQCJunoU8aVRGn/QHOT3cyrl6OiScajU5m51DJt2vwTBrBIB5LXdsnMItO24SGA
 Vwe2FqagRBLO1hx8D0B3PiZy/Fh5aUv+lUZvFM31HnueZDEfMTh+NhllBTyd0XgH1G5seRw/2zn
 7G2z6NIA34mSBLJ1f3YMog5cRkn+DlOQdo0E7tGxtACInwGBPDP/oLhpt+fIa4hFvFmzJ0gswKJ
 zEvClMMeowIYeG+GT1Vo/xxKnQ6ITxthqd9bSfTKXgvw62hKRIzXe8BQ6hIC2yaj+picFmaDaxP
 Owkhf5MLi9mXoJZG9f3gBd9v4ibfyIp7yzxQ4dhaAUT9Dpk6hxJxVgKS9P2tI/zP8sizG/cxzLr
 UjSQw45qqgX8r2GoK55SC5t10gA5NjrgsgZHgvQEUMHhqPpgv7Y2zYBtnpSolB5ftHrFlSsx65K
 Qx2yBWVRfYRhWjTt4Mw==
X-Proofpoint-GUID: yZWOSftYGf-lf98Is4uVwVY902mPuUM0
X-Proofpoint-ORIG-GUID: yZWOSftYGf-lf98Is4uVwVY902mPuUM0
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f93b68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=tQ94oCB4lqOImTN_oEMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
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

On Mon, Mar 16, 2026 at 02:00:09PM +0530, Suraj Kandpal wrote:
> Pass drm_connector to prepare_writeback_job since

Typo: ... to cleanup_writeback_job callback ...

> drm_writeback_connector now resides within drm_connector.
> It also makes it uniform with params passed to other
> drm_connector_helper_funcs.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 4 ++--
>  drivers/gpu/drm/drm_writeback.c                      | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 4 +---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 6 ++----
>  drivers/gpu/drm/vkms/vkms_writeback.c                | 5 +----
>  include/drm/drm_modeset_helper_vtables.h             | 2 +-
>  6 files changed, 8 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
