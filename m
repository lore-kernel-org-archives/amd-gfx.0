Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6335FF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3335010E8FD;
	Tue,  5 May 2026 00:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DkluRK/U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQhzmGXl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3CA10E8FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:33:08 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644K4lcv331221
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zQhAbMMChSVIrW8bHgvy56iM
 nhslWxiT0BF5DVUHFIg=; b=DkluRK/Ubp0ZK8IF2ffFM2rVoZXCoe4QlbtfBKj4
 I4mQ8YouSHrlCgs8V6c2bjj9IioQUWNp84YKdftfezbluUfML/1AWvKb4+iblgTw
 SgH+oUpBsluafKU5TSMRjaJvXymB2HH8VZGj59XtJvssLgr9ukw4B0LTUcFGZLrO
 O91Mbb52dTIl7si4P53r3ytydxYfSBpMEyADoMoO2F297a4PHU6Fn8JdkInIxs8o
 Gc9Snsqj4JAVmFIdsdiIkon633fwN/czvQxDsclUePA/tZtUrk3/dqHfBlTi05vF
 QmhiQ6w/QQOsKzjRgNthshMIzJnY9ji5c5/nNfLbNM0yPw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1a5j5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:33:07 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5752402f5e1so3606906e0c.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941186; x=1778545986;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zQhAbMMChSVIrW8bHgvy56iMnhslWxiT0BF5DVUHFIg=;
 b=BQhzmGXlWxEQB/OgCgyCwwEcjYTdSdyZ/Kz8D3DxPFuC1F6IIl18s4e31iaIqylxER
 LbDOGiHCKsac802H7Wem2D4wmMGr4GomFlTlazpuWUMtd5MVkZDqwBBiEfgQQhZD3hU2
 yROHw/tVoUFdKkLzpWXgBkG6l3lRCpEHaAbGi+TSl8jy++cS+TBL3BFx8M11lEnksbzJ
 1jbYwtg5+vSL4ne6aVU+DPrM16tqPouUdoiLBRBr02jvxZTNKaKafr0EIU7i72a1Nn7F
 mYX0QCLV/EWNYO6JKL9mQ+Hs6Y/SMriTIA3bt4YRm96+GlsGGgjzGWYE35hXTrz5Hhz5
 xmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941186; x=1778545986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQhAbMMChSVIrW8bHgvy56iMnhslWxiT0BF5DVUHFIg=;
 b=Wa+DeJgj7uG+iE5MlS4Bdq/btm6P4Ue+77+zT8WirrrNWi20qfXo1q7m/NKSzSpztM
 QM/0veyNLxZZWUvXnpWZNMK0YOuV4x1hux5Dy2w2K2+LutqH8/ArOIxmFcvD2fcE/yvA
 rQooNSkl7ZznPu5mlx0lwy+eP/T9bGNV5MaWgrHy98yZahZEBtMM9ep5uLV3+OhJvr9X
 DzyGx1cShZ43r9mTbyy5SFvss1CZZGE5u8GzQ4pOSYDxIDVn/ebZaJozA+hgsGXslLiW
 5puuahSceh2+nLNnuHtZxF+1PI/aOtJ8Ga/dAn0JfzGlYzHJ/zs0HmOMjdoC8/3kQ1Tr
 cnBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TRHiLAsvdclf16f4Ts80pd2s/WEbrusQfYvsFnFuRTzqIJfcJOI9QMjW4zsb3v6VDTHl6D1Km@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHrNUgdZdaCVh78u2HOF1oRNsgE4rRQzTfvOrr3LvoLoUN2jt8
 hWEGN1YFLF/xkEzcWTY6fF70BGCgW/Y2HrgjjUOZA/3p8xo5DyczUNNjrj8YsJgo2CM1cegO23R
 0QcqPR3IS9V7UHgk3vDV2CvAmdgD9uG2/naaglQjTqmtEZ2Xz9OuUq10+zVgt6gnNYBvv
X-Gm-Gg: AeBDiestmiXDD3erbIxS/RpfLiPePPU63DYE8rrhEXI7DVw+UyIf7inJG4FRS9zwCA2
 xjq6+r0kfbgIg26ehEKLX8vFW6FsjFYeKTLuz91RDrLegWslDRq7dgCwqs9mG1xup9OK8HuyjTr
 b4mHaea+Q1K5+9Vni3NURGzzfVRHFAn2Oyi9rwmcxtJEqDnw+wGMqpSgfc7+f8NG5x3mt31yM4V
 s/CTOwPa64xQvR8QGYHuYRNQDMK5pPsNT4RM1FBf5Wp8A+pqxVlKaIQmMYunByPzMij/jwyXXfR
 cY+Q109U29U7wtoAl8Ac9rrt/CVY2uGsMvfy9gOiB+K2l/JPTT6dL4hvq0FcztvGLjaW64Nc5An
 4zouieoSBd2HlVTVmlh2I0E3+uGUArmysCN1hw+lv+Hbq7sOo55CEpE7HGrOgW+kuwfu7nT4sz1
 N62iBd7GlIS0yHQnFRdxQczLO0JtR4NT3cCPR0j4S9OvTuJg==
X-Received: by 2002:a05:6122:6090:b0:56f:a329:6859 with SMTP id
 71dfb90a1353d-575482d1800mr509459e0c.7.1777941186550; 
 Mon, 04 May 2026 17:33:06 -0700 (PDT)
X-Received: by 2002:a05:6122:6090:b0:56f:a329:6859 with SMTP id
 71dfb90a1353d-575482d1800mr509452e0c.7.1777941186127; 
 Mon, 04 May 2026 17:33:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3936db4ff8csm30303011fa.23.2026.05.04.17.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:33:03 -0700 (PDT)
Date: Tue, 5 May 2026 03:33:00 +0300
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
Subject: Re: [PATCH v3 4/7] drm: writeback: Modify
 drm_writeback_signal_completion param
Message-ID: <bmk67tbapjnfcsuz5bqivnzytnwrhk364c3i6oe4pnilwgisz5@25b6jebsxxq3>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
 <20260316083008.87466-5-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316083008.87466-5-suraj.kandpal@intel.com>
X-Proofpoint-ORIG-GUID: cd9E1V6JCo11NOmDviIeqqAKLT5SFfMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX+H2tJjBFGb4e
 0vj0ieSnjzlJWYuhe9QUNeBGe2nbyq9wYY648/lNfQZ+L40bo2w0cLrF06WyJ2h3Z0tprnzkKUD
 qafibSZBh5yPysz+eRa5dxmUP8o/KIFJ5p9M8NJiYapELYjFzq02cVQE8IFXEoY/eZzl4bvkiaX
 7IA9UIYQ0f18liiYdakasmGzZwlXUa2O0RmMIxHw5SisN7N34ksyPhJ99qfz3rHNHGqtJN+WbEO
 j6+Bl+lJ06NjGDoKnVLRFs7Exsl9aMxEfD4pXttQeM7cZxAalxp4hqeMMkxP5tlyBRu4qisbhzI
 yoLubCqGDWH58Fl/rXbUlcnd28eGkxjTBNFTofr+tOY5zmqI7pLgTwW9Q/qkki4BlcKS8+DLaeD
 Xbv1nDesLDK2dehHmjis8ZpPbxrdSdhsdPDkqXXxobdsou9gFmTUyUfNbuivAig4mdEDChzN7W7
 s5jZF4cZuUs1O+Rr09A==
X-Proofpoint-GUID: cd9E1V6JCo11NOmDviIeqqAKLT5SFfMX
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f93ac3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=w4tPeIWWwG8LP2YZpMkA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050002
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

On Mon, Mar 16, 2026 at 02:00:06PM +0530, Suraj Kandpal wrote:
> Move to using drm_connector instead of drm_writeback_connector since

"Make drm_writeback_signal_completion use drm_connector ...."

> it now resides within drm_connector. This will also help make sure
> drivers do not need to access drm_writeback_connector as much.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
>  drivers/gpu/drm/arm/malidp_hw.c                     | 6 +++---
>  drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 4 ++--
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
>  drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
>  drivers/gpu/drm/vkms/vkms_composer.c                | 2 +-
>  include/drm/drm_writeback.h                         | 2 +-
>  9 files changed, 15 insertions(+), 13 deletions(-)
> 

With the commit message fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
