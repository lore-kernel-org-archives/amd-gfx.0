Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E17FF885D
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2026 12:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4AD10E208;
	Sat, 25 Apr 2026 12:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gk3vtrNQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6Q8qywE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0894210E41F
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3Pku52365855
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=npr90gwsT5NmHlfS0yD/bLI3
 6eTJwhU1xjIXKSB/J18=; b=Gk3vtrNQjbbVlhzmPlbhxBpronK6iqfLEVQYwPPe
 Eu8dKttQeDXem680XaryEfUimz9i+LVgttnHImlUbq3YUdi+aC+0B/zwkk3C2u53
 4fUUh5b0LHgWBHgGgzuMaaBxHo8eahUBRAtmep25rO7HMn18Sp97lB8EFNKnVmox
 Vywmoyf1LPtzB2wGkQ0eWqRMJugcqz2mIISJ6jTGo5oksQWjRbE9/Gp12VP1nvVm
 /zTjjUygWlJ6ZNNlOs2fT0BPgRqQA4G8Sa7qV2MRmaiZiVqmfQS6nQzyWbM03/vc
 3EQvG27k15piB4TQGxNO/Q8VtMIulszXJG84cr9ertSMHQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnpw0v4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 12:17:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50faf575af4so1506981cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777119458; x=1777724258;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=npr90gwsT5NmHlfS0yD/bLI36eTJwhU1xjIXKSB/J18=;
 b=Q6Q8qywEOLu7ERRv32brjPMDOB5nc49Em9nQnMs8gq9A45nu5xlOcJJ0lOUc0J+/4u
 yQF7S5UfXqOt6Q9slPtvhqDxY4544CvWE1KrHgfppxG6J4wWwg8HIupk1mW1fGg8dBvc
 yuvpc9erCM0hJVouVKiR2ShTpHzC9q/9qh0tnVnGYdHWJBj5XL9NRjWI4XIrELZlYN4B
 ZkcMxT7um8EGR4TiS01jFwOsEdVHo9y+wfwtssnmc0AdR1Hi0JG+Xu/rqyrSPW5SEcvl
 azMc9HKzXgnwNj+lHXu2EZltToYfKq7ZMejiey0QGMWTwJ3EjjYLISu6umvLqEjeNf9G
 0jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777119458; x=1777724258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npr90gwsT5NmHlfS0yD/bLI36eTJwhU1xjIXKSB/J18=;
 b=bMVV3xc99SIRvnllSvmY7PcV8JTSUKBBEc+TEgARqSKHByYxMczN7XMek6Kzt9LnjB
 MPnb+O/FwgWm2fbfXMeqhDMw1Z0Hd7Z5InSjF61pU9HyM67jYaM9LCzFrjQFUhHRkDx+
 EG2uWxe/zjlnOGUiWPa41z/M02QKAbQcIqAertwwjfWkyvQoMi4bXMdR8U8z41lBMz+V
 /sCihAVHF8Oh6hxmvnUhDDx10CnLKzJBjPgw6V/RFzs7/58btNg9oKIEJVCNBtrZVMlz
 myXbIJKGDeK/a6e8Gt77jDuVFwA5L6tUwXjhJr+SHqUaPPbNgDoLYbFT+U5Kqa2MlRac
 SwSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Z6fhM9RIxr+9cVWgPbtvS0nnPBIP9ERyNWdM6zM67XByk3GShGCt8beDOKTNFqZLqZ2unLUq4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCfbCpsFvF2EAufwWFF9pkt+3pbSypQ6b+ynT/91CRcYROgxCI
 sRdGJP7Q/h8dEFdVv0FHURZEkGv7erOwgF6Z7udOeuT3P6l+mt89Xg4K4NWOPtzmNbBJNq3ZnVb
 A3b3Z+ECp0JXhS4aFXdF4kC9jDCHHfa7PO4mf7qih4IiRsUfcJVIPYuESyKVwHVcPyQm7
X-Gm-Gg: AeBDietL3q+1b4FDdbks4oD3QpyhyB26LGG+RsaRxoJ1430bHZXyTEZlXV7ezQc001m
 NPIY5sQ87LcMdLpCUsnlDkDUfBeLvSywDNJuHVC8jw6tX2MHiyOZ/lg0ttYrkSJ36mT01YFraVS
 MRAnneHLqplx8bbi6ksbhxyyzvPvKPbqJSK0VPSdlmQ0UpkmaC5PuLieBvjb0xLaebXYvpCeT/G
 bm/9MvSa1WljrAmPFfQFzkTR1bCapgEnBWtqL4E4J+H1DS4c8ek0uQ3tLxGsOXiuDmRt6Os4u/y
 YYp9GyrEgKlcWRqI/hspkynDaNYOwYbMvOkL56ynLpjhbXjH+q7atZ9Ce2DB75NMgaoR2NhzOAf
 h22OsToD+rMZyzaes8LxtTAVV+aA6Ge9QrgsFSTggys2vNk6z0h+r6CWHOBMbXNstIyj/zbQOp7
 yGY2veYS72xljtIrvWbnHE7IX0RpNwgpAhN4i2Zp0YYsy7/Q==
X-Received: by 2002:a05:622a:2509:b0:50e:defb:9dd8 with SMTP id
 d75a77b69052e-50edefba3b8mr340804421cf.6.1777119458103; 
 Sat, 25 Apr 2026 05:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:2509:b0:50e:defb:9dd8 with SMTP id
 d75a77b69052e-50edefba3b8mr340804061cf.6.1777119457678; 
 Sat, 25 Apr 2026 05:17:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a63296adb0sm2218995e87.6.2026.04.25.05.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 05:17:36 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:17:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
Message-ID: <5trcw3bcadvk2ltmat5axlezuznylsgm5xr7dmo66o5ijcrpdz@fhv7yhmlklub>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424220953.167058-5-mario.limonciello@amd.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEyNCBTYWx0ZWRfX/fPghvbl8exi
 OxJw3RhV6PL/FnWHgwx1YxRn+rorVJHOHh9JyPWkhiaKaJMutqP0RzgENP8vgPOnlhKwBLp5+mR
 iqEXJQOYtzqC0+9nzLdg4zZjVwMEpunJ/Xd3S5viXOfzeMULAUSF60aHon5GAUP2oBWlpOFFqvj
 3DfDNjnVWgnEN7YTovWd6DVqEt1CrZlpz2zWYLQLnCX8uTOI4nUYQzeyPep9OunKMItkC8EuuEt
 tiy0B1DYCzG7QJpZUbY7Wa3Xl76CpG9fZKOlX1ifkCZ+jSTKqzABWqabW/yrso/3dar7M6sFeQy
 2iCNlBJjZOEUZckzLaKfcickCsUCP8LHikq+hOFWaU/3M1+HapWuyOZjTkD4Ih7+ZXLeqEF5iWh
 ELgqdSp+UmKKHDDZkCFQnx0ZkThCCylEW//JCl1ye+c5YXzUKB8w2z4TM0EgFz/83M50z4C65xB
 RQbTVu7dTwSc/Sq+Akw==
X-Proofpoint-ORIG-GUID: uxc6Gjeu7VYxMfpw2tSv3puL9Nd73KtO
X-Authority-Analysis: v=2.4 cv=RaGgzVtv c=1 sm=1 tr=0 ts=69ecb0e2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ws1xHSm7LW_IKOyM:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zd2uoN0lAAAA:8 a=sgUbT2v92nCVnnKm-eoA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: uxc6Gjeu7VYxMfpw2tSv3puL9Nd73KtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250124
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

On Fri, Apr 24, 2026 at 05:09:49PM -0500, Mario Limonciello wrote:
> The legacy backlight control interface can only be disabled when both
> the client and driver have agreed that the luminance can be set during
> a modeset. Add capability for the client to register and for the driver
> to indicate support.

Please describe, why do we need DRM_CLIENT_CAP_LUMINANCE.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c   |  4 ++--
>  drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
>  include/drm/drm_connector.h       |  5 +++++
>  include/drm/drm_drv.h             |  7 +++++++
>  include/drm/drm_file.h            |  8 ++++++++
>  include/uapi/drm/drm.h            | 10 ++++++++++
>  7 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 27cc159c1d275..b5e6d940f2816 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -921,6 +921,16 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
>  
> +/**
> + * DRM_CLIENT_CAP_LUMINANCE
> + *
> + * If set to 1, legacy sysfs interface for controlling backlight brightness will
> + * be disabled.  The client will include luminance values as part of the modeset.

I don't think this is accurate (anymore?). The sysfs doesn't seem to be
disabled. Rather the DRM updates it internally. Which might mean that we
don't need an extra client cap.

> +
> + * This capability is supported starting in kernel 7.2
> + */
> +#define DRM_CLIENT_CAP_LUMINANCE		8
> +
>  /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
