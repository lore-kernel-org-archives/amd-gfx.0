Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A759BCD4F3E
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Nov 2025 15:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C2410E155;
	Sun, 16 Nov 2025 15:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="STV1aCeq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhmzmGtL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA9210E0D4
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 15:32:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AGBN4Ne943309
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 15:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=brXB1Y/LPVXbRpByEO14Lypc
 5NwpFVTcCsuQsNLy+W4=; b=STV1aCeqitSSB1V44tB0l1zmgK/7jDhruQaVos81
 EssOg08VRmId+HKWwnbjmu1A0oxPC5Ot0Oyvyo87OOJHticVG/YB653NVBPtYm9d
 UMItP9V/wSh+4E91LFlEQhJNuVhFvVTS+/bfsvX8obshzPQA/diigqQyXgEmYa+2
 zxXYJ2F40o0rqOYznjpqhDid9v6g18id9gJ19enQV+cFgUdkWcy+0mxpFb239eHs
 p3aVsMkvNCq6kwdAPk3OKLUDSbymiPKKYAioD2H3p7O3WWKAQeMEmM52tSJ1CZTR
 ylI817cj5MU9L4CVRhwrC+CcUAq4YwWU/UgKqZenuQxUbw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejh029up-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 15:32:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee1eb1026bso6403991cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763307127; x=1763911927;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=brXB1Y/LPVXbRpByEO14Lypc5NwpFVTcCsuQsNLy+W4=;
 b=NhmzmGtLKRT9CdGTvxFtVLRUqgTTYxe+8DLpyMskAvnTLRMSd8SBRL4LUFIwVPNlvE
 u0KFaCZ9Up/3usT6sMLMjYQCsCsqiUoK+s4Ha+LRxkfq4TddqwUtikodpyEgLL2iGI9Q
 94toYt/cR66WS9BFUNZNHDqeQ5sro3qyN6vMXsdkPJ96FnBLR5aF8HdusXGKkl+0CEjB
 GDhbQPzfZQc1KOzRp0z6R6TWxY1k9iRqq/Ls/zlgE/wNW3ComSvE/4TW+FxMYddawv5U
 Cn/4rEyJKcYqP0dtOdeYpo4c5hNTByH8waff0IP4RieWRW79Dhn7k5HgDmt9JYYJMObc
 Zj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763307127; x=1763911927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brXB1Y/LPVXbRpByEO14Lypc5NwpFVTcCsuQsNLy+W4=;
 b=CIOhkU2Yw4JqgWQM+ADsiJzsgyTyiR7qHd+fgE67vq0vHWfpBrNvcZb8qND0IyD16r
 pVcxvOdLv5A1PHFnvUJ4dvWtYFEMoqFdt/7ZAaITJnSokNRbN80+BmIIgX9oFhkvGzfa
 yrYmDCdw0FictGBrq+sogGQ9O10Ds9CVYAn/N7A4YtupYROJUtpd5jqZ3pL1qD3VcMqj
 9H5eKSl3dequd/nswO9d8hRFCjVUOCefn9gyDEkvdj53D7x3BtQmb05JO6tEhUz2/Hab
 89+8+xYQLu/3zuf9mSnQh044Mi5nRmb9qkOW4CltUAeptRTWPcn7FgldrtlW6iGnYwwo
 ADww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ikxqsfRZ5o5T01zU+xGSb8Ml5qyRVHYf4oMEgnZR5cJfnVpXF2/jpYt07VgHYhY17kwlKC+a@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3k8EPpwNrobAJMSI0wT/AqBMfivM0b9IkBl3RD9nB9V4X9lIU
 iST9OAbIDfEgVKk68VaViJEjQdZqywgnMltPSbC+58FdAWAwrTMywNVHJSb/Irv5NPpoyGKI498
 YY19/0dLCpmty6+n6b60q4m9pszULtY6K7T9Y+j7IlYYWdsS78SB/EPrjFILG7dRADpll
X-Gm-Gg: ASbGncsF4ojX/yN+3hmcUhn4s18NeKXD7r95YhZ0FLE/MJ2uAnRE0qm+nGi6ZcaDzCb
 dKZj3FFkoL67NJPkKJI4/RnmFVrApDq+m6Np2L2S/vgHWnH1zoH5Nb4RTXHuy//JzLYTqzOXTsx
 +Bu+RO317aoaBIC/4bcQGKSl8SAyaTF0K2xr2XtR3HXy2AjIY5dohzUhe1TINQpih41NRvoChOT
 oqyNylEk8MmdDdolXX5Q9Nq3gl8J2Xo9eVyowo6ELIG5OPmGSwtErFLZRU6BcDm/6JqRFRCb2sG
 41ltAcXPTaic67oSMuYN2msOYVBgWe0gekkUSNWAJU0l0YU0ybHEIlfLNwTgFfMHsbYtUdRdpHb
 fV02po0UDcc7xNy8IrtAAi2LEGxr5b8rnEYZCG7YB3ap3ewO3baNklu4IUpJbj/jZmZ7FXvUmz+
 eNKawPfupHZ0eg
X-Received: by 2002:ac8:7dd6:0:b0:4eb:a3fe:53d with SMTP id
 d75a77b69052e-4edf2177a96mr137561101cf.79.1763307126918; 
 Sun, 16 Nov 2025 07:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLhJkaOMAE2symS5kOW15WypsaRmGyogTqDdNGkh+5TTdpKm+0QEXmKB8gHRw7DCEiCrhb5w==
X-Received: by 2002:ac8:7dd6:0:b0:4eb:a3fe:53d with SMTP id
 d75a77b69052e-4edf2177a96mr137560551cf.79.1763307126391; 
 Sun, 16 Nov 2025 07:32:06 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-595804003a4sm2483875e87.59.2025.11.16.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 07:32:05 -0800 (PST)
Date: Sun, 16 Nov 2025 17:32:03 +0200
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
Message-ID: <2obhppq6a4ercfnhvm42tbbgh3xut4lz66fc4j7mpev5oxxno7@dydu2wysmgvi>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
 <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
 <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
X-Authority-Analysis: v=2.4 cv=W9U1lBWk c=1 sm=1 tr=0 ts=6919ee77 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=zodt2Hv4yxvvtHnNIosA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: PNZbpE2ag0gRwwl44D4a07tD-xnm9ric
X-Proofpoint-ORIG-GUID: PNZbpE2ag0gRwwl44D4a07tD-xnm9ric
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDEyOSBTYWx0ZWRfXxvobp1HrYopC
 oyqXxM1OdukRb/LcnIjoU3vdK1PlkUFMXabV9ua0/jwkgGKdhfVRRDLyo6nhozGl6SaBzg0m96R
 5ByWqRkxUtsgyuR9ilcDIsKz8ZrOt9mtQUsGHYaZOnFElMbhm91XRH/GjtxcG3ke/Uvo4i3vh2E
 gp8gtozVvxHbE0pgBspj2o/+TSmr2Ibp2MABeU2mFSmMgC1wE3P/hQTnFK2B51pnd/74PkatXQt
 3bAuSRpKRitaUFt7RRvBu4jSb+IEgg+YUgXkXrxh2FsotLVGcpmZxXr70y2TbMy3ADy5sDiYBm4
 gP5eF+/7f26U6QKQTNutC2Scz3eIX35GfpRKGLQMDr4YJBpWLdovZyjMpc9DHXVvy6CaiZ/Zx0I
 X21/ci/iYvRh/2cu2BnJdROo1Tf5HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160129
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

On Sat, Nov 15, 2025 at 05:55:17AM +0200, Dmitry Baryshkov wrote:
> On Sat, Nov 15, 2025 at 02:44:56AM +0200, Dmitry Baryshkov wrote:
> > On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> > > Uprev mesa to adapt to the latest changes in Mesa CI, including support
> > > for firmware via LAVA overlays, removal of the python-artifacts job,
> > > split container and build rules, use lava-job-submitter container,
> > > and various misc fixes.
> > > 
> > > Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > ---
> > >  drivers/gpu/drm/ci/build.yml         |  22 +++---
> > >  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
> > >  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
> > >  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
> > >  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
> > >  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
> > >  drivers/gpu/drm/ci/static-checks.yml |   1 +
> > >  drivers/gpu/drm/ci/test.yml          |  18 +++--
> > >  8 files changed, 186 insertions(+), 105 deletions(-)
> > > 
> > 
> > Thanks a lot for taking care of it!
> > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Hmm, this causes a lot of failures, see [1] (note, the run is not
> finished yet):
> - On some platforms (msm, rk3399, mt8173) the
>   core_setmaster@master-drop-set-root test fails. On other it seems to
>   work correctly
> - sm8350 seems to have some issues with this uprev, it cant' finish the
>   jobs at all
> - mt8173 and rockchip:rk3399 seem to have other test failures too

I have fixed most of the fallouts, see [2]. But ideally this should be
split into two parts: fix before mesa uprev (I think some of them are
already there), uprev mesa, applying necessary fixes and then enable apq
jobs.

At this point I have no idea what's wrong with MT8183. Most likely it
needs either a DT fix or a driver fix. The driver fails to probe because
it can't build a sensible component chain.

On i915 several tests kill the hardware, making it timeout all remaining
tests in a bad way.

BTW: I see that for some of the drivers we skip the absolute majority of
the tests. What are we actually testing on those?

> 
> Could you please update fails / flakes tor all the affected platforms?
> Also I'm really interested in the master-drop-set tests. Why do they
> fail on some of the platforms, but not on all? This seems to be some
> infrastructure-related issue, since exactly the same kernel with the
> same IGT passes those tests (at least on msm hardware).
> 
> [1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1547684

[2] https://gitlab.freedesktop.org/lumag/msm/-/commits/msm-next-lumag-db820c


-- 
With best wishes
Dmitry
