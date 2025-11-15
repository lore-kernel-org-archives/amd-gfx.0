Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9EFCEACF9
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 00:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1123810EB7B;
	Sat, 15 Nov 2025 00:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODckJlfs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4JMYz+u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CA710EB7B
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:45:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEIQd4k044311
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kHSr3Uxb5gfTp8PMcc+9CNwl
 Vz3omOLQcZ4QTy5X+lE=; b=ODckJlfsAxbyXTtcs5Zm543nzNcWtRpWXJwR+uMn
 0BqB/hWSyd4H8OuVqMp+yys58KTOTAThFhwxlyoThmB8gRaCIJKPfVhkcmZd5Kxw
 lfcbla9wgB++EGDkSmbCH3068Oov13I5BCMuM6f94boSl5AY/bvN+c9GpsOuxyr7
 MycHmceYdsDFwWcDa2NG0gHfD8rcfCSOQmWn8NIYI/9uFIivvkXUR12lN1VBKjT5
 Y3HSvqZFPm2DH+IcfCemhPBe1GISzlubXCJjqLHl0l7FtUB6DIxhlggAx+QrR280
 zmVmdjj2viq6ssQ/HDura3pZoLrKjHWEt8PvJRHceOdXOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae3t9t12d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 00:45:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4edad69b4e8so63045811cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763167500; x=1763772300;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kHSr3Uxb5gfTp8PMcc+9CNwlVz3omOLQcZ4QTy5X+lE=;
 b=R4JMYz+uJ4fMfL2h17xR72uCrcT5yU4YZWrNqNECWiQFPdxbkCsdShpaPBX1FT8reU
 YTAWcU/AnNIEayQcCIXq6RhlBW8QEB8xyBRSsmYCAiRmITv3rwyugFu3AL9qSDegYJyC
 7oIXPLu02MbnEWP+HgeiyW6zcYQJDG9F4DYYV6fXddEuV02PJ+C5xdt+IW5MDjyB0maq
 V4riZa0xRtR5xFQ5hEho3lNXOQdIndEMErOM1C/buKjKNl1pEY94D4t1mbxr6mzB0R53
 W5X1HFFjWhclFOhksGxQdzK/YoQthuKvTfUp8sMYc50wid7ls6B7JUQmgdPGzGWdqjPw
 PnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763167500; x=1763772300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHSr3Uxb5gfTp8PMcc+9CNwlVz3omOLQcZ4QTy5X+lE=;
 b=NisfsRJsfXkAQ74c8mdflKUsDrNQCrzrNu3NkB2gEDSvV5I6Ztwi9ruLtZcmVCsvBK
 59eJRnlJ2lSsbDf6v2GV7BgIW2IHyFml6Dpb4iNmaCiaSpzyZqlNBrYSLKoFA0XiLnpW
 4BNeCHruWD0pQfYQR0c9fYKsrpmqrVJJjJiW7OHPeSLxsbIDwzoywfu5qds/NFNeSKRl
 OX1/Vc7+LiEcgK7Xh2dlwJ4XOBoOR4gf71UcPAN++qHaBzhNbVMtZyWkfjUrqVPImVe6
 EQG3jBqPqO+Emp0MVhuMYbhtDYVygDqCywag29XQSsYhVQepAb6TfpsrTWotO9ykdsHe
 6jhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlyCINp9AhE4b4+kG7977auh2Un/qRW1dIeVr3zpVYuVl5CohNaRjWa7OB+VSH2kgG5aGaTvZC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGKxsvqS0AMJG5D6p4JxwHSXNVSxPk6UbPos11nnS9+rnj0ak0
 paRZmomb8Or5HihsOkPf55kH5i2kWitwED9Ne+8+QbjB7b8dqaMFO5CVi3M/XDeqx8ioPdZl2HO
 PttDd9gA+qV3QNn5pAqbt3N7iSj0N2S8rVFu48dRPQXNVs8SVXjxqoDrFCns0YfCJnir8
X-Gm-Gg: ASbGncskymvQ6OnnOWLjo8eDWBIpVpal1UhMG/X6z2m0KM3RV6H5zPZVZQrh/5iQ/VC
 OgARE8N1GvxSAjMtektFSGNmL31xzc5ZkdQZQGhaJPFtsHinfkqHozIyjOupC5mCKqzDdDq6f3u
 1Ff63gkYeUnQyMnB5kDI49m3KrX7kSAXAPLBEPASbhug58rcek5KxPFdRiEvTar/KHYTV4l+4h6
 iRVwuqNpYCzmnJiW6nlqEee6WmQ3lgQJbkvzF7wseET25940MGA2T4eBSL6fdUKJjVFatCyWQsX
 wjeP94s+1R/fGJwtoKzT4FRXr/4VBiffZC6krbbah+2WSp2zBMuSPOWbJVQyUfHixV9yStLVV+d
 595i79fwlNyxZZ4apHfulcW2hOQx2OEUHIvZ5b2t4iFlaQzoxoio/+YkBG+8TbSLwWQT2xRSKue
 3EOz77qwUL/Y12
X-Received: by 2002:ac8:5dd0:0:b0:4ec:ee54:b141 with SMTP id
 d75a77b69052e-4ede70699a3mr106378211cf.26.1763167500290; 
 Fri, 14 Nov 2025 16:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTsDRVIqLn1VpOlz5z6xTpaoGY3LMTcHDBpzhVsFe6h8FITQwTVx2wdmRWmkQbySXE0rNnig==
X-Received: by 2002:ac8:5dd0:0:b0:4ec:ee54:b141 with SMTP id
 d75a77b69052e-4ede70699a3mr106377841cf.26.1763167499760; 
 Fri, 14 Nov 2025 16:44:59 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37b9ce1577fsm12961501fa.17.2025.11.14.16.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 16:44:59 -0800 (PST)
Date: Sat, 15 Nov 2025 02:44:56 +0200
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
Message-ID: <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114030056.1139570-2-vignesh.raman@collabora.com>
X-Authority-Analysis: v=2.4 cv=IOAPywvG c=1 sm=1 tr=0 ts=6917cd0d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=H-B6EOQw763qFByNOf0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAwNCBTYWx0ZWRfXyG1wiNZQgEcw
 RwIl23shXkHj+lgqFk8a/LjxVb2r9TJjfhkAMttpJYvmk0XsXf2c36Lty0XyAEuxWcbuiqD7Ep6
 fTqx7KqFiDMADIej3p10MNEmS2uKhw/3ha4UUeJZG4RAUu2vciI5idpQ6kmUxcWkqDej2/b+h+b
 NiRHMHfDFJt17SD5rYEa1L679ZJCMrS7buD1spNdNXKPNZZQB0XbvztABUn1lQLq20km0JSn+hJ
 vH5eoUleV8UP1azElggedTUPv6319wgraUWjtbx0XUjqWtqOFwmsVa/jNxZCgiWZIUPGu5AG4iu
 qjwb9S/aQoHkBLrUv1f7zRI3YpkpY54m6Pk2jsxW4idBOeivRP4UiiezsKq3bWbUSKyDXIXlGDX
 4tSXrJ0caXpqvQioMsOLlVz6SEFNxA==
X-Proofpoint-GUID: 5apiY8LsUpifPwX-7yaSXnaiHRicjRcQ
X-Proofpoint-ORIG-GUID: 5apiY8LsUpifPwX-7yaSXnaiHRicjRcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511150004
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

On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> Uprev mesa to adapt to the latest changes in Mesa CI, including support
> for firmware via LAVA overlays, removal of the python-artifacts job,
> split container and build rules, use lava-job-submitter container,
> and various misc fixes.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build.yml         |  22 +++---
>  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
>  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
>  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
>  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
>  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
>  drivers/gpu/drm/ci/static-checks.yml |   1 +
>  drivers/gpu/drm/ci/test.yml          |  18 +++--
>  8 files changed, 186 insertions(+), 105 deletions(-)
> 

Thanks a lot for taking care of it!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
