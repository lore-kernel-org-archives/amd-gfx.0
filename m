Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B6EA3F18
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 22:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0B710E11C;
	Tue, 10 Feb 2026 22:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdEnIsj/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQr7pw5R";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CF410E0B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 22:13:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AIoY3G4013749
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 22:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5nTCr+xuryPJ1HpVPDG/DVIr
 pdNtB8DMTFv7L6Sd+kc=; b=HdEnIsj/u9lznKcM+cVpa5eAlJjqKYDIdfXWleDx
 ILcEWqi3xNQPG1uqcdNJVKuH6RDVfPeA27IGCPyNzunTkj3rB0UhqAcxY4CHCpD4
 osOg2arsTz+URJlKTNL9WtjlzrDlp3XOhEyN1gjO1N0V/LIakS4+C7WPkkZr0l2G
 APeufA8GrK0do4Em2NyYow+uauEPvQFQ1yxVRmkfEmo3djaLnTLDVD7WxOLQhlVx
 IgOn/GWSYha1OJBPHRg3pPAkGLKxLapiu+khCOPei/UcpQkl2AGJgXtxW56eUsqG
 awmcAC9T8OxeFQHXdAtBuoYiLUXQLjYrGYx2WUDp356dXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8aad8nu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 22:13:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c52d3be24cso205982785a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770761600; x=1771366400;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5nTCr+xuryPJ1HpVPDG/DVIrpdNtB8DMTFv7L6Sd+kc=;
 b=LQr7pw5RrnKr7xFcZrAXQurpkwtn/m5rDy+cC0kuhqg6KiCFBu8NymUZZtEyN6gB6u
 Exd2J0EBceJKH9qPsCYi6kEfewe92ySyvcwQfvWx/hPuTW16Yi/oK5cGtdZU3kq18XQN
 5Joar8unrjOro0jJ38wgS6QjjAHq4m40zPfyugEVmS4LEdZgdvZJJFmZ3KL/DKL/pHxK
 K9BiApTdYGVmUh6P8ZEqAz0JruxEfKXd8xZNQ9divgdI4m0jWnpbX2xTJobQfcVEAHQ9
 IYtwUwicZFtQBkmT10pJ5MOnhe6Lf6pnV1EFo6BWUMTdcJlzAX5o5WIxmRTJZvRghlBe
 R1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770761600; x=1771366400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nTCr+xuryPJ1HpVPDG/DVIrpdNtB8DMTFv7L6Sd+kc=;
 b=fSpuU89FofhpKseMkvrcKOr/1UhJPJqbNb3n0XPpYBdb6Oe5aPo8KttfalDms2G70A
 cYIPnK/tCQnjT4ixVsImDFZP1I98Ylv8EFNtbDaGWFyaKxJUaEjCMx6jyKYwwNSIiSfP
 VOMfqPY8fYneDLRHG8SL2wALMoKpt2gwUcyx3IW7GONarjMubYqi//adN/vlJYY0NNv6
 hUkKpjL0n60dZ/lvJ069bQuZQngINsbhxXgGH92Aw9Updy6hV8lCv0DcYxqyo+Mp53ij
 d1SRZtBi5IVSgCYovMj0BH7C/UYDEawG6vGd27moxfqhHnBWxq04opR/+q2MN3Var3yr
 kMRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYwFQ1XLwI27QjJYwNQTZqvBfIuVa+g0e4sr8e7++ak6lo4RNnS0AdgSvqY865QPI4tHfMvpAW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrZwFo8D0rA+CGeTfEXWvyyEjQILUpwurdv8b8UUkC54ohuLTb
 QJ2PQEPF4QAwIsh00PHUz2RlIEnszJ7NYcaJgyNRqioUkpPHxJLegHNAq4gWUAeCskgEQhjBnBh
 iRMtBVD5zQN3JdpqgCdqIXODCUEozHgI3/2pLl9kc+/ZLavCAFyKEfyTvGmkd4BJt30pX
X-Gm-Gg: AZuq6aIJNxOyDA6a56aD8veQzKbDTQY5yA13dN9bf+tWXix5dpnngsoan3V033XrpSM
 PAARd1tzvQuujfQJaQYTf3R8/iqpKW/k8fHpF5em7kXEvfjLkWHD5tgd/JNSfWcM0k7mEs6O0uP
 KpMkg0RylhuczIDvClB1H0jCPxzMpbhTwleUOmdYAmGtsHUpDwFIcfAwDUJoMeYMtdEfKUSpB3B
 jbpTDUpuLB3R/le1mGrDQGZd4CJAFkMlKXYeyrvSOLCz8RK1ueEp+zjZqGE4DBlwFJ8vVraqtWq
 crqoaEVlLP/bnm07V0nkXwBa/uncPwDQ+JH1WlMP8LScMcjXIIpRAcyiL+NoQAAWwYsfN1ga3KK
 ilvljIFwm4cvIbadAtisyIB6mi9hl7GEEOS9jkQuCTNuo595iym0czY7+J9ztdFxWfYSEVyt3M6
 zcSYcQQg4pbXWPWYAE3R8UfGlTvsdgBFAWGkA=
X-Received: by 2002:a05:620a:410e:b0:8c1:ab1c:f2da with SMTP id
 af79cd13be357-8caf13083edmr2257940785a.70.1770761600399; 
 Tue, 10 Feb 2026 14:13:20 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:8c1:ab1c:f2da with SMTP id
 af79cd13be357-8caf13083edmr2257938385a.70.1770761599898; 
 Tue, 10 Feb 2026 14:13:19 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44cf6f72sm3521414e87.2.2026.02.10.14.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:13:17 -0800 (PST)
Date: Wed, 11 Feb 2026 00:13:14 +0200
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
Subject: Re: [PATCH v2 4/5] drm/ci: move qualcomm baremetal jobs to lava
Message-ID: <55cjkwps5sfd766uxab5viu36tez77rnrlnabocqb3o7t5hhr6@nydrmwbimnzj>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
 <20260210071138.2256773-5-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071138.2256773-5-vignesh.raman@collabora.com>
X-Proofpoint-ORIG-GUID: szy9DHT1Z2wQynGphe3tDgh4cCiKUjFp
X-Proofpoint-GUID: szy9DHT1Z2wQynGphe3tDgh4cCiKUjFp
X-Authority-Analysis: v=2.4 cv=OoVCCi/t c=1 sm=1 tr=0 ts=698bad81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=9K-sheTcyn_FmZRYi04A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE4NCBTYWx0ZWRfX4U++HOdRUjQk
 fG73fG2Ugs2Zmfcq9Z9SfqIhY/CQWTPvW9C0wgOynDhaXWvVSdmUE49HBd8H6On15siSb/DTXqC
 MlOB865qHFNjXdFgM4nNy068HOLTK5NRQ6lZv4Pu8RYUH2roM8DvWQ0WzVKIuibQbHOS1xiMC0Z
 l+F7Zpb+evfSTA1YjK+zXGLWjOpFr9OfxsJbsaNIJU84W8UYXb3kbJOn4XmnmSbJk2TvmcYUW3P
 fBfX4jxpvWogU31y98V9EF4+NTEij/PR3Ls9XKqYPK8a0SExGGAqqchldjD6NPM+fIytpB4GWND
 XqpDzi11gSkhi7QU7aUpUPdiffCw8k1YzGrpXp6ef2PZ3U5wPPb42PZKbMjjrP4SLt0Qbj9UhWc
 vAn1fYPgNeIbGDrFkNJ7HFHvHZD1moVYNFU4UVd3s8h2GTSPhquaAG6Kg8E96mLpeD9eXug60G+
 F0U3stwtqeQvlN1Rq6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100184
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

On Tue, Feb 10, 2026 at 12:41:33PM +0530, Vignesh Raman wrote:
> Qualcomm apq8016 and apq8096 DUTS are moved to Collabora lava
> farm. So enable these jobs to use lava and update expectation
> files.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> ---
> 
> v2:
>   - No changes.
> 
> ---
>  drivers/gpu/drm/ci/arm64.config               |  1 +
>  drivers/gpu/drm/ci/test.yml                   | 41 +++++++++++--------
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  4 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  2 +
>  4 files changed, 31 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
