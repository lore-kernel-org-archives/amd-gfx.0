Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE8CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 18:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C9C10E05C;
	Mon, 18 Aug 2025 18:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AvjKASPb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5715110E03A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:29 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IExaqI018175
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LfY4G4CqKEkHfEGc9webJ8Mqx5xO+pkxGHroIuo5mZY=; b=AvjKASPbcVWwYskt
 0bn6JVWulXwUfOFRaszps5kb9D5NoNNW+HDMJINRW2jpYzFuRW9XF2Su0Uw4cXhF
 y0qSvjt9/mPVXu8nLMYJdwf87AeKNR/2Im/8vyWGUJdbcYuVcBndK9muoRJLJ/xh
 Nz0YJNL2fiF5PCUh6oo5HQbQNvowR0vb10hKZr75SBJSUOZI3Vlj66G2uXF2DVIN
 D89f1xjjNnhhIhugWOsfmP5TywGZ7nRZSrYic3JLq4SHe97YgjyPVeEQc4uXrMVJ
 733FptaxGEChuHzUDxpI6U4X+C1Qa+TcRrPTy53x+ihduKuWeDo2EhUAKro77YnW
 CBzjVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj745war-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 18:35:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-244581ce388so101860405ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 11:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755542128; x=1756146928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LfY4G4CqKEkHfEGc9webJ8Mqx5xO+pkxGHroIuo5mZY=;
 b=QgBE0ksF1HvVTHmCeHfMnkxTFMYhZW6XENjpNJwt0sBx/10xJMi9vxBIx+eCmT3Uha
 uCDIwB4xYeJYI0mw4hsIP5gVOp7djsek1oAQMR/syyn3R446PC1+21yjMRRfcP3j4aLX
 0oiQXV7VrGRcQSjPkoJiCTUMVhFX+G+YSZa+sa8UzXrpWJL8CVS5y+Nu8R+8swAPIhHc
 O0CO1++NQlupAlgcnvMTkpW4E58io3FEX1nqrdUFfrie/bwYEhuFRCSndWAuC8EfREhC
 yDwG/BkYy2TVu3YJkh+IJcNwMH4LS6cmhVhxJwglrVD0SYiInfZH1hUWMnMew5wxzvXs
 tiaQ==
X-Gm-Message-State: AOJu0YxVToEQEkIsfGSJ1l1OvS96AFwo8s7MdZbrzt5TirzB/I6EfQNN
 rm0wuq/uT5aq7PCCCKhGfIZ2P/VlIJE4zCc8y041MiFQcm1OkqQrPTBCTAWagP+FRqYIPVa1GHz
 uQweC7maaQ4VVPluwd6XI3NWWNaZIWZ1LAgF7zDsn1jcT0ztwnJPWOlEofmPvtfKE8PG7
X-Gm-Gg: ASbGncsjtdNjKdyKxytDs4KtnS6yviwQkSDQLSywzJbKsSw6wUEl7RILAnz/u4R1HHT
 NP28Ivu2XU8LWVZIDrseRKnC8UWZgCue+k9dBjEljkNUBQcd8BM6zTzagnY2JxxEAbkYlXX4E5v
 lNWRsEwgcRk8O6yR+UIPvomopikRnLdYtKDhMvIrwWtqZLUGD+4Qgnkss0eKiEDl+3M9hk7Ul1a
 zLS/TY99YdsEioz+W1Ey9eAIZXV5drmmNOJTMLaeyhsEcwPi4DGazUTZiFF1rodWHcL6xxEzjji
 jL1sd72HTt8VewHYNsyjb/oZH0sajqn9Ej6Xp+xBFzpnKWK/7mVyWMfuZL4Vq+Tkya+L/cfWZoG
 cfHYPd9DSiZmC17zZroPV5g==
X-Received: by 2002:a17:903:2ac5:b0:23f:f3e1:7363 with SMTP id
 d9443c01a7336-2449cfb9e80mr5221175ad.23.1755542127999; 
 Mon, 18 Aug 2025 11:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELuEhzg1tInCp2J0UUI+JjVQtMm+T8qI7xf/0+5/2hJCOJis2Fde9uo5MCZ53k19fKQnY75A==
X-Received: by 2002:a17:903:2ac5:b0:23f:f3e1:7363 with SMTP id
 d9443c01a7336-2449cfb9e80mr5220815ad.23.1755542127524; 
 Mon, 18 Aug 2025 11:35:27 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446d50f8easm87137675ad.97.2025.08.18.11.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 11:35:27 -0700 (PDT)
Message-ID: <41dacae0-0c66-493a-b5d8-a6df5f7e3b9e@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 11:35:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
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
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
 <20250816-wb-drop-encoder-v2-5-f951de04f4f9@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250816-wb-drop-encoder-v2-5-f951de04f4f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FZ5v7sy0WCGAIEWlW3U1bXKi6CBXkiNa
X-Proofpoint-ORIG-GUID: FZ5v7sy0WCGAIEWlW3U1bXKi6CBXkiNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX4s472UoQtlIa
 jL6VbWJfaI/FM+5tdWuRzD9hlvzJ6/khrcLK42fYBOC8WqT+aICuiVs1AkKvBfL4nj98geiItpk
 xGKn3vSuAWAH6HRuN7SSrTyaeTakB0mBwuknTytjEwly45O85RBcYdbepmoimZAT6q8WkZZ8AJM
 ubaSvYQUljONhXDm33LX/mb31id8NVUoaRkLNc2hN1XP1qD9sJiYMmZsuCkVJVk6a+MoiWaACdO
 0RHgeXShV0TN6W8YH6/R3HLOKxqjG6HgX7SrwjCeJUET/6rb4x3XSKWrbS5l7RlDsb1H+F4iDNO
 V7ofyzKCs/B9QW0fOKe5FiC7bjmFXQtnScvbd1ioWJHrJgSWRYr0agU8C/dkEM0I33v8u/t0Npe
 XjptecbB
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a37270 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=NHqv8PQFZmVaGbn79gkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=d3PnA9EDa4IxuAV0gXij:22
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
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Hey Dmitry,

Just a heads up, I think the commit message prefix here is incorrect.

Thanks,

Jessica Zhang

> ---
>   .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..64cea20d00b38861e22fc53375ab41ae988ceb59 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
>   static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
>   	.reset = rcar_du_wb_conn_reset,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = drm_connector_cleanup,
>   	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
>   	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
>   };
> @@ -202,15 +201,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   {
>   	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
>   
> +	struct drm_encoder *encoder;
> +
> +	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);
> +
> +	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
> +
> +	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
> +
>   	drm_connector_helper_add(&wb_conn->base,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
> -	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
> -					    &rcar_du_wb_conn_funcs,
> -					    &rcar_du_wb_enc_helper_funcs,
> -					    writeback_formats,
> -					    ARRAY_SIZE(writeback_formats),
> -					    1 << drm_crtc_index(&rcrtc->crtc));
> +	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> +					     &rcar_du_wb_conn_funcs,
> +					     encoder,
> +					     writeback_formats,
> +					     ARRAY_SIZE(writeback_formats));
>   }
>   
>   void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
> 

