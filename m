Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B76CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 18:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092E710E1EC;
	Mon, 18 Aug 2025 18:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PjbJ4SF5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D1E10E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEoiIw017547
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rTw5fI/EzQLooVwdnSKD6j5ks0u5Tik6uLBbFQaZ44I=; b=PjbJ4SF5jsGRuPM8
 lRiJxw1u113tX7wBLGTbQoy+3C6mIwKOJavCnyjt0KQfMN5t6oFVnQPOBVFoUtJQ
 EneaDEiUuLXqtzK5PTacSnK7X/Jr8zazde5n/R9zdJHoO0J3TXn/aWyG32UWilXy
 OEerE0aj750vPxvduioVB33IJ6wu32Xv0hGd25L/AAxffaXz9svr2Xyw7fYZ0mCI
 gZTWWjAwdv+B2UWYuVDb3HZcpSJkDNx/hvt7bjszyLHe2+Htog2zTVX1DJKuuthT
 Rl89WKPzZ9Ol2YfnDRgKI535EjA+i7w8peleWdhzNZHYS5+dWqKo66v+HOi3mb6f
 1Zs8Pw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj745wcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2445812598bso120568445ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 11:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755542155; x=1756146955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTw5fI/EzQLooVwdnSKD6j5ks0u5Tik6uLBbFQaZ44I=;
 b=xT+R1fg88OoipU4kL0XmtWL2JM2M/19EuXRbB7/mAFTJ1XauXFkInOq4Ebdlycd34a
 8j+VHC5TVv1FtJcTFM/rO1QsK3Os0uE3vTQyoqIVMK4CRKB57RjujFKEoDSWB66yBEn8
 issIZJ3tYdvmQ2bt2h8/kApSzj7xKLzBAfqei75ekUbgvTbXFrPisssnZuVMBXAqOkgD
 gLuZ5MN6ES10L/KUPLBkNrCvCbKBGU5szG1P3eN+acQk/+ckTEmzic2Me+3CZGvcMvIF
 fm6ucSXty7Lix0IAwHKbkFrPyRaJA/tP3cGa+RWZQEgrzyxAA6EPXKJe/ln7ohNTfytw
 mIKw==
X-Gm-Message-State: AOJu0Yzy4pFNG3cWJ7hJegWeOo6AfJUWljpzsnywqgNvXdY8oXxKPWkq
 jyUO0duJJafl/jGBayIyONZ35MNi6jEChV9m93JujjqoODsKf9GgbOrDCjUHYXgoGiojO0A+upn
 vi865kzzYNfzBmGFsFDh4/kslq1GOZTYoC8LbXoUtx/e8qiR+YmtafXhMS7kElISICMLy
X-Gm-Gg: ASbGncutdv5sCNx/I4KZeDEoWlCTPmetGxTDilsc80MRxuNHjwvEnrUJORJBlVpPeUS
 ZOpMsOAPO7nNArB2lvLLpzjBekj3A/GrXpwGfCCXKt6+ZFrmbFC0J32XsghFVNwhkwQl53E+zh0
 CVQSiK5ZbkIOAyd52b+eSEFbbz8+ciMWCkD4YzgCeeXUzpZvtah9+fbd63DVFL7Yi9aERVgCUCN
 IPyiUnHZkAzAMlIGL/QhKbGwxYztAwvk662qMqoSJoJPUAOUANKFRVd2CH87ZVI2rc+k+kNQCFD
 3TkGaF4XsUEOLTdgUb8VTJo25UmwC/dnwzxXmHCzsV/bUNIDpHF/PZ3GfDvJBGIuvb7jQzAiYyH
 MeQC9wV7FoCwTts5+5DygDg==
X-Received: by 2002:a17:902:e883:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-2449d05e2e0mr6013335ad.38.1755542154896; 
 Mon, 18 Aug 2025 11:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxDSynULb4PcFzZsBZRbHZngTsBrC0gfJFLCUyi3LdHcS+4FTyZjXC2laEfmopJd/tkxjqtA==
X-Received: by 2002:a17:902:e883:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-2449d05e2e0mr6012665ad.38.1755542154422; 
 Mon, 18 Aug 2025 11:35:54 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446ca9d9a7sm87175925ad.23.2025.08.18.11.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 11:35:54 -0700 (PDT)
Message-ID: <eddfb43e-2d8c-4e6a-83a7-00c88b3ccf7d@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 11:35:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
 <20250816-wb-drop-encoder-v2-4-f951de04f4f9@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250816-wb-drop-encoder-v2-4-f951de04f4f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HLLU37KLPlLRtqEuhowT2zrPjFDOTCzx
X-Proofpoint-ORIG-GUID: HLLU37KLPlLRtqEuhowT2zrPjFDOTCzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX223Qmh+2no2n
 0IBX1JVxqvpedyG/RybExblUCdJDYmJxYM9e9N/h7hw+xzjO/G/Emzr6+fDlAA+OWiFP+7K5bWp
 lpVSTZiKjgnjgYtatfC1DdyfGQBeij4O9APRlm/QGvv+eyH0a5d3s5/TtNSTUsihZWph/HjZlAF
 Bk85n1wAGfteLrCV59XlyQVllHIabRBRVgjsMJUXs3OTN3NhpTh6LLfgbsUoljlv2XbCi3s5aIT
 +L1Nr9z0lzbK0EF98njRNl3RRx3atq6ZPylhaXKF5jYCJWrUaSaIdQxtrMgyqWCHsFEQwvbKB3A
 B1odIeRjdv/rltf2yH6JfEpNIe6+1J7cTCuO/GdacJMQOxxGk8e7NRtRaIlggOSIWgkMfn+G6lu
 yzKaULGA
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a3728c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hy87YkSEx0gxqBhA-1kA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033
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



On 8/16/2025 8:19 AM, Dmitry Baryshkov wrote:
> Use drmm_plain_encoder_alloc() to allocate simple encoder and
> drmm_writeback_connector_init() in order to initialize writeback
> connector instance.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 8ff496082902b1ee713e806140f39b4730ed256a..cd73468e369a93c50303db2a7d4499bcb17be5d1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -80,7 +80,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
>   static const struct drm_connector_funcs dpu_wb_conn_funcs = {
>   	.reset = drm_atomic_helper_connector_reset,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = drm_connector_cleanup,
>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
> @@ -131,12 +130,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>   
>   	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
>   
> -	/* DPU initializes the encoder and sets it up completely for writeback
> -	 * cases and hence should use the new API drm_writeback_connector_init_with_encoder
> -	 * to initialize the writeback connector
> -	 */
> -	rc = drm_writeback_connector_init_with_encoder(dev, &dpu_wb_conn->base, enc,
> -			&dpu_wb_conn_funcs, format_list, num_formats);
> +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
> +					   &dpu_wb_conn_funcs, enc,
> +					   format_list, num_formats);
>   
>   	if (!rc)
>   		dpu_wb_conn->wb_enc = enc;
> 

