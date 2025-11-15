Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AE3CD4F48
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 03:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B83010EB76;
	Sat, 15 Nov 2025 03:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9xyueey";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/UCpTQf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EA210EB67
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:55:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AF3ZOpK1129193
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kpUJE4SYKU9ynxkJ/T5JJhpa
 CqT/i8ZykNmysQrjF+s=; b=V9xyueey6blpzm/jfavsSbhlfoxZqh6ziY9GLiVo
 pRLERZ2MEX31+yuGsAhlfVnpx49LUnkivh7VOeVkX+iEZCpUszfAr6RWAvx/GoxG
 ZijhYK8E3mzyIqhG1hK2L5/w9DdedzrozrD9Lv3PvXEGCefrjA2nK2F6EPnJkN5Q
 59YLYTARTJ+Imk6JfdjaS45qa6wSMYck595UYohLzKOGwUnrjp4w0vmLrwRUpeB6
 SYq4g3sGHee1nq0e3QSLce0NkDu8LM1+cCMEAkTcfdWp6FkDpecyTGsY74vra0rZ
 jqFpR49ENgMSjHk8p1Xtfaa+aw5Hd9R3LM0WfZoyiVfmLQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aehr2r0ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:55:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4edb366a926so37120051cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763178923; x=1763783723;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kpUJE4SYKU9ynxkJ/T5JJhpaCqT/i8ZykNmysQrjF+s=;
 b=g/UCpTQfO73g6ax4TdPunUDNmGHZ40sf6V0J9r6L3gcsryDjKvLe84nLkphFT31XKd
 tEGYUZ5NSDZT3VRa9lxHfX8orDdzUFkXxtx7Sos3WTHyHnceAB/5SoS2xm8koSIOSfz6
 7ScBTp8stiLUrHZJm4TppAY8XwO87ufPKWYLPW5M+2JE/O6nUVcWn8/oBWWWrBg9Wj4P
 +Ag7TZbNW6gyHnlTzvBrI5YIn1hw6glbMTqZSMFxOIWn/7QsXUg2LahD2X2wXUqGVDD8
 0Bpa5WRdyr+by6zv5YBv0gu9DGkDdoD0yfChzQKmvm2VFfxOchxZqFbcVuC8GLuOsNWg
 PaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763178923; x=1763783723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpUJE4SYKU9ynxkJ/T5JJhpaCqT/i8ZykNmysQrjF+s=;
 b=D/l5pHfStAzWafwjC40BdzwQZcMMMVI3lumd6G5MtS98s8R29LOGOlK42hXZBgl8GQ
 V1jOztzDBxC/Yp0WNwu0k/ja9i0yhhJh0EHxHmAHQGw8gk1tWexPm2DGKsKrOv9VOi66
 Oi0N53Nr5gEsQIoc8L4B4O3iPLGA+We2zqi4Ec9OInmSaPPHzj8kcXf7u93k2wCUt8cJ
 rLwJ8EEQGHJwpsk2fTeEpehrxOZufYSEkdqbFhf+QqrfwaXL4a4sso3sX0ozlzixW6On
 q4Rhl9RKO3BHtmpIuqkJWH6z4euArD/xrFLZYxuQdGa+iIfYhXeNyIsCaDo9abR2ty6y
 ZpqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWASdnB1g59sqqsfSVDo+lwrXBySqlA1t6kgbbuf2SL8JMjlMPIdELrhwjCGdHqhgQM77ldAHCi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAIvXaK1rom11kR8+VzxKRKXBDXXD7Z8z6aNqPHRoIJToLL1AK
 xA8L95ZcVtceAR1hSpfO4ZpBFun4znEtgtCG25BScvVKSziB20tUkm4yUTFnHRIS4xwK6tMw6S+
 auDdzQmpy74ArfiHJA/EC7KH04X7CgSpv5X19f30h7tKd/Dekkmuknj7OmLL/XSLxBDte
X-Gm-Gg: ASbGncv1AW+lPsu6ggdRWzWRI76d4q01m64koag073691oi2DVlI91Ps2YfQLdbd6zB
 QC5+pSg1akl9LsQqMpZXQSCSLL/8R7wsV+9F+Q1mtvSYCwPDDwfWkR3XAPnnlvS6xRVgp5sxUN5
 38mgdkTSeBJB2DB2ix2rg4KKOprEMMFEJFLqBBDrNat3mrn24Vb5GoqK7KnYKYXsC8DW/IZbfm0
 5Tm66+UqWbELevy/AIF3wEdCFJW+bPed5IANd/c3xva7uw8VO+ti27uFkBGsyj16t9OR0TIzFa8
 tJqiUJDIWQzJKFWMZxwCBGvbqwJhXAmA3OX5+CCbTDCMELthXwQX6u+SuRmnPhUlRJSbDmcGPpD
 WphJ60Sz6gPavIPiDsA9svHFcmZvihIsvK53VmQ0xhfaqbOSOb7f8vh16fL82u7VbdtNxr6cYqq
 YnTTOAhRwbzcY4
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id
 6a1803df08f44-882925f280amr79893376d6.26.1763178923088; 
 Fri, 14 Nov 2025 19:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH21xNZD/1SaQbAJXQ9lzSs2ET/wK99qDySnRnPvmoMPz0h942r+lDos6cmgLn70aSgdH9ifQ==
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id
 6a1803df08f44-882925f280amr79893116d6.26.1763178922595; 
 Fri, 14 Nov 2025 19:55:22 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5958040c7ccsm1449901e87.100.2025.11.14.19.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 19:55:20 -0800 (PST)
Date: Sat, 15 Nov 2025 05:55:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/ci: uprev mesa
Message-ID: <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
 <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOSBTYWx0ZWRfX7JlhHYJJyANo
 dLMuxs1FLlRr/WdaEAIhANl6/lG703e1fs24c7N+ZswAPmsKEnDj4jta+3RG6Xjmts7+k4bvAGH
 j4v0EztN3McptN4md1y1XeQKLd8aKtrngAf6C0OQa/DnSbyLo18ShnLZ/gZ8eN2dDH4tFkcJVzN
 mg9pXM+JWQdNRvLYnfUh7OLwRk+jVy/56FgiiLKQpPEYjFU7Bd1MzRF8Vm35kIduaaWrqkaqHUr
 0AE0BNNltSyBCYk7RTlJNSCmQn08jDR7x4aLW0hRA6NN+goxhdTWVdkFlI9jwOfILVHGGMG8tOH
 E03m/e90u5+rF8vyyyMF6fj2XtRP0pCqjY7TH/DORZNmDAdx9zBvNN7F6H62mB5ATKDE9TgxkoD
 Il/bvETw0nQ2sQmrJUDNKnOh79Qx0w==
X-Proofpoint-GUID: W32ExvDKJYnz3BohlSXIuO0yUcL1aUQp
X-Authority-Analysis: v=2.4 cv=TtvrRTXh c=1 sm=1 tr=0 ts=6917f9ac cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=E-Vn-V3zxCEcjh91BPMA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: W32ExvDKJYnz3BohlSXIuO0yUcL1aUQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511150029
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

On Sat, Nov 15, 2025 at 02:44:56AM +0200, Dmitry Baryshkov wrote:
> On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> > Uprev mesa to adapt to the latest changes in Mesa CI, including support
> > for firmware via LAVA overlays, removal of the python-artifacts job,
> > split container and build rules, use lava-job-submitter container,
> > and various misc fixes.
> > 
> > Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >  drivers/gpu/drm/ci/build.yml         |  22 +++---
> >  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
> >  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
> >  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
> >  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
> >  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
> >  drivers/gpu/drm/ci/static-checks.yml |   1 +
> >  drivers/gpu/drm/ci/test.yml          |  18 +++--
> >  8 files changed, 186 insertions(+), 105 deletions(-)
> > 
> 
> Thanks a lot for taking care of it!
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Hmm, this causes a lot of failures, see [1] (note, the run is not
finished yet):
- On some platforms (msm, rk3399, mt8173) the
  core_setmaster@master-drop-set-root test fails. On other it seems to
  work correctly
- sm8350 seems to have some issues with this uprev, it cant' finish the
  jobs at all
- mt8173 and rockchip:rk3399 seem to have other test failures too

Could you please update fails / flakes tor all the affected platforms?
Also I'm really interested in the master-drop-set tests. Why do they
fail on some of the platforms, but not on all? This seems to be some
infrastructure-related issue, since exactly the same kernel with the
same IGT passes those tests (at least on msm hardware).

[1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1547684

-- 
With best wishes
Dmitry
