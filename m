Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469ECD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 13:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF1910F53C;
	Fri, 12 Jun 2026 13:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlgLuP5e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EbdrtNtF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FE010EA54
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CCj6Vp2160816
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lj9iP4K0GcPnNCW95XMo8tVN
 jOPr4RfYCBOREwlPyGg=; b=IlgLuP5epKG7Z5khBWGVWey9TcvkzndL34gn+BRL
 wbvqAp7hbNbX81s1YbPiX7vmpFIfJH+h7VAPVJq4p8ifKI3T5XT8RBMqYSMstXHS
 ZChjsp16KOYilHe2GvI93MdroXzY/O0MsPLRyw1uUu8BkyiSBOubv5PValHc2rCu
 aD30yxKF5QIbdvvvpgXVXFGP+Kb6MblChW4vCdglMMF8cogrY5+BgQ+BHTAvedsI
 e+QC6dyVvfIPdXUD0PWalBxRuJ1SMovpDQW7z3K5saTUUgq4JePSDhT1ohia1Dtx
 SQm2OOijXfcwoGbdikDVHlcXCHeKI1orwQMKGk7bPczKBQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014m1ae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 13:56:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915b6b63056so213077885a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781272584; x=1781877384;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lj9iP4K0GcPnNCW95XMo8tVNjOPr4RfYCBOREwlPyGg=;
 b=EbdrtNtFm0TsMcLV2uvuNYaUj8YKbJboAI68HhqQqb3RJytJxbFJoq/WLAM5KLtVGe
 ExQ4hXcXrczvLl1Bn646fdSkbKkBAVfeaULSad+R/Gr4e+AKvEKGuCc/6bkSUWxZVjZG
 Zv1e8tAV27CemYEZXR0LXWQGcPBkGhLm5Yv+OJ/dZ0yZxpeMjoTD5o0RcOZErr0mylJp
 qmsPhsC4hmOxusXOtWsoVtWJb/FJdaCSglOailYzK+yTbYVHTZVGuPLUH8iaeWL0AcIb
 z1awzj7mK5lkRpkULM2z7BuayMT/hIp8lS5G/MuNX3Og9a0qO6yvuFzmzAT47OdhuqCW
 TYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272584; x=1781877384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lj9iP4K0GcPnNCW95XMo8tVNjOPr4RfYCBOREwlPyGg=;
 b=lTmhDbcwA+bZB2nk4EIE+fNtab4OMHv4xqX4MZXo2dnzmtYX9qUSkJJyJdYFjUp6mT
 0C3KtSKId9pyWk2AlKGIvBWI1S1lN9bFsu8c2X9AXExPSOvKfps951jHBGaLkr163IRD
 z4O5+lcCN+LaJRShgaTi1TOrzjWbdIG1GYz17PHj6EAXP95Ng4lg+GiHE5Bib9VyP1kf
 p7boCjiSRfP3IEPThqov5dv3uQA0rwgiArb/DoHCj2aYj9uUybl6OdjWY0/DAbTUkCla
 o61SSNak1vCGG1E62csfPHEtXKiCSyG62W9gXak0XP+DvgKJXsvT7+nE/xpO2HhzvkOp
 QZpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+65nwl8+wzIGf3HNmFgAXeJ4geVwkGPCh2GF6kIPYd/wd4Ns0H5DU0uvOu+RnXEfzTuONtElVw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx54fNum3FSnq5Tu0m4TlVZcNg8/wHRF5mYM/CedjcZEc+Ubp1z
 HMrGaiyzxiFOwrfZzmk2wU8HrlE5eSYPL8ISGJOgomxC7+CTh4fM/aAtKzuXjplCu7RIcAozehh
 LbuHZM2bsr06RwDKT8xOB2GxYWtuv6AEE/GUXZb6qYjDza9T/vqAffYq8VbCoQV4bQD8W
X-Gm-Gg: Acq92OFJpCk1x6cEpJ1MUFK2r/SMc2C5zyi7vIm15F6YYW8CpHfOj/MmPcBybF5rJ0p
 cGhvCzuY/CKhMOiWsIb0ms4scoEkhBfEPbScy7h/wuvnlatZLAPLIDEb+9E6pIhdiKFE10sDxN0
 BnlxUlnI/QRperm1cMtMsT9q+pjt0MngPG6LXlM9pCpj6bqI8BkvC5bHKFtMf3vu1afnEsQJio1
 ENLrfC0E15vlWmrnMeZpcdilZCSGLZhWxRqSGB1IBmF97ZU/MDPcMx1ntpyHmuw3eai9zPW4RUo
 Syz/Ts8YyzHS8eu63XXYOcKukbZE5MJ9T98wtwr+NU6eZpMN4K/Cr1jx/FT48cFR79jNnSrwIbe
 51nEzi2vcCATCpr1G0px+EXiPRT2vY972MYf19RAsrjt5zjHGxiBLi1BEnYsF/zL6oPMThvyBZZ
 +nHtujEr8B6Ud3+mxcNdzJcz0RBkKOSiiHih8=
X-Received: by 2002:a05:620a:2411:10b0:915:75ba:179e with SMTP id
 af79cd13be357-9161bc9f023mr286844185a.30.1781272583857; 
 Fri, 12 Jun 2026 06:56:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2411:10b0:915:75ba:179e with SMTP id
 af79cd13be357-9161bc9f023mr286837985a.30.1781272583368; 
 Fri, 12 Jun 2026 06:56:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1b4869sm563523e87.75.2026.06.12.06.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 06:56:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:56:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alex Hung <alex.hung@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/8] drm/amd/display: use
 drmm_writeback_connector_init()
Message-ID: <kkfb5lvudgo3curnoakp3qre7pofaobaxynz7qhrn6jy2ll55f@clhfe664z5ci>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-2-42567b7c7af2@oss.qualcomm.com>
 <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
X-Proofpoint-GUID: JWzCLiNdSqoQepSSOL4g--PyFERBy8qc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX/C0/aQbirlZB
 4qV/RYQab9P8yNcQo5PSt5zQs7js3+XdJXhzbXxIkkkJR/Whj+c3sis6s4cuM+SkNdeM0O4/Lyg
 pkN4S+LsgLReUQwQceysT9DX51euJvM=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2c1009 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=t-2y4xJzw7g1bk7x_BQA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyNyBTYWx0ZWRfX66AKZzbnHdXl
 l+UGF/I0nCVSIhmowtYPOT2XJEgz44ETH6O7VKbcwwemlPTHvnh861EPrNBU343oVCFdxOkU0j/
 6guZaJ5A8EiYThLErxwhHBAySbsOI1Aw78GgPO32CqTUhfowmUBlUEbBAwXau4JhcoePaQB1DcI
 QJDAEGXgcpWvPF9V+B3K7MkvfO+TEC/7fdSeO2IqxFHZjOMW/Qj4cklC3ciCjKuq1X54mBoFKjs
 TumurpLq6MohQlOwlUBCvi/zXgTwiSMWLqsSLuOwjZcGPoqWRsFmguleNrwQpiTmr+M/ufyc6np
 zta0wVcXeU9Gp7M58UBC0WCQikZ6IgRBiTMFCaKFwCXBUxnqvd0qra6m3ZHR9jTdSX/euezv6Cu
 dqaoUtt5/PuLB6TtYnFoNDBJW8vJrju1/Dt2Njbz8XIgsMgb4sBbSP0neuHnsSp6N/YH9hw8wVa
 Q0kAUI7t8X2q6XOkf6A==
X-Proofpoint-ORIG-GUID: JWzCLiNdSqoQepSSOL4g--PyFERBy8qc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120127
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

On Tue, May 26, 2026 at 12:46:30PM -0600, Alex Hung wrote:
> Will allocating wbcon with drmm_kzalloc before calling
> amdgpu_dm_wb_connector_init be more memory-safe as below?

Sorry, it took me a while. Yes, it seems to be a correct idea. I'll
implement it slightly differently.

> 
> 
> @@ -5790,7 +5791,8 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>  		link = dc_get_link_at_index(dm->dc, i);
> 
>  		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon =
> +				drmm_kzalloc(adev_to_drm(adev), sizeof(*wbcon), GFP_KERNEL);
> 
>  			if (!wbcon) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback
> connector\n");
> @@ -5799,7 +5801,6 @@ static int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
> 
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback
> connector\n");
> -				kfree(wbcon);
>  				continue;
>  			}
> 
> On 5/4/26 18:24, Dmitry Baryshkov wrote:
> > The driver uses drm_writeback_connector_init() instead of its drmm
> > counterpart, but it doesn't perform the job queue cleanup (neither
> > manually nor by calling drm_writeback_connector_cleanup()). On the
> > contrary, the drmm_writeback_connector_init() function ensures the
> > proper cleanup of the job queue.
> > 
> > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > drmm_writeback_connector_init() in order to initialize writeback
> > connector instance.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
> >   2 files changed, 14 insertions(+), 6 deletions(-)

-- 
With best wishes
Dmitry
