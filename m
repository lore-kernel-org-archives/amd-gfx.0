Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318B2C8302F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 11:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF82810E591;
	Tue,  1 Jul 2025 11:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxGCbSNY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5B910E591
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 11:05:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561A1ugP018568
 for <amd-gfx@lists.freedesktop.org>; Tue, 1 Jul 2025 11:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZogMt6KKsiaz5/xedtL9aHF64V+0fejV+AuVX29tpF8=; b=HxGCbSNYdM9dEslB
 SjttVn99Amwenu1R7wnkDaKhJaGda/8kM8YFf53/KU128vsYXxNaf/6p19urg5Hm
 mYCDLIZ9YNp0bV30kTJ+Rt4Foy0l704s9vQWadf1pTdTdPoXhVRtrebwpprrgpCi
 UY3DodkPK3T9pc+OLDNmF4JSjRfRTeHRljUvYejXugYVPq2SzWPo2HounfW42x9K
 v188gBN9G0wwqxoqbexRfJGHSn+RRnABE9Pa5gYXip7lwwcUgs+8NTYf5SI0+Mbu
 YEfwZlOmCdqKzcOvF6RoyxB1GUM8rC9ES7eG3VmqFoaRNnK+/03UvbjwbEYabwFJ
 l02HNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxgnb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 11:05:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5cd0f8961so653532385a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 04:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751367943; x=1751972743;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZogMt6KKsiaz5/xedtL9aHF64V+0fejV+AuVX29tpF8=;
 b=RMBjaydjN3Zg2gq9Ff1839AZ9b+qnz/jtYmCwY1mZWY6uUQlWR1ddckvu2fzx29Ect
 kvBz7gRZBJ5VHPu2R69aXkVbmFD1QXGDkfpMxa++WqY6qAefSmtA97aBpNNDqTJBRP34
 cEgQLueFEXmk/2kfSBwzb1FeVOsvJy2tQ6ZbnPUkdIqL1e3gvl90otbay5PxtHsOkq5o
 6ww7U4bG6CPCSOHHlIyKvX20fEUSGT3Q0DpuuE+Zh8oPizycBJckV8/L9pNguri/w3pR
 UccaQVhOeEnwYT6UmwTpN0uSkuMnFAVtmkdMVKQzxhLKkOuNHDRbEI24KXKDu7QQRTUa
 RHEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF6ViwvDUy/XAE25bZ6WhD3zJUdc7/+WDqn8hHpMyDDUHmWRt09qhTOd/yphcWL0WAzYmhch6N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxySs7Q+T4tRYghEDbRhbIBqlM8tGWLKzZdTevfC32ZQd1iZKnW
 JojSEfgEWkt50qYaKPDyqkH8icG+fwulrnk72MJp1THawaYlCDGK1uIJVEJSONSa43RxYD9QPw1
 atnFnCm9DSd3tdeFFtzsK1CQ1+mMMuhS/LfW1Afjv7gITzbqo8Rpp2+WricV15qiv3anJ
X-Gm-Gg: ASbGnctLYYw3xNedjnol9uLuVcS9QDqqrJjR9aw26A3fjnmooXovuIx0xiG4XVIcD8r
 HLg4Ud8/WAglOgK3MYCUfWgstwZaOGMMOHy3usAvzxaLKERHcuZwXQh0hG92E3/N3En7b4CYDzr
 ph4xgYqYmLm7eav8kunacqLrMnhVut2DuP/kEu79b3zaZHXaaGGW4h710kI18KbX3J545+4MPRg
 BUZFKLoFafjwCL12M7zL0I2ck5M0pq0boE3O25ZU5Dkui2T/DZ8jWsaictuM+BC6ziCsKHSiWZh
 gzXZxYtAaZMlw9I2IbXUw0JCzskWKFyOFQXWWns+V8uzHfzu76h9qatLnU1VGav4G5pRTiHN0IG
 HECEAC9lVcXAmLhCWqRdd5FNIk65sGab1MKw=
X-Received: by 2002:a05:620a:84c3:b0:7c5:5a51:d2d1 with SMTP id
 af79cd13be357-7d44398f399mr2458869285a.55.1751367943264; 
 Tue, 01 Jul 2025 04:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkaK5r4kmwq1bTXLA+Z1Z3MCVlUfECWUH1iOnueMEvJSOkDSVRInqR72D3IhCu8jIVuwHmSw==
X-Received: by 2002:a05:620a:84c3:b0:7c5:5a51:d2d1 with SMTP id
 af79cd13be357-7d44398f399mr2458863485a.55.1751367942731; 
 Tue, 01 Jul 2025 04:05:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24048dsm1783299e87.28.2025.07.01.04.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:05:41 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:05:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 05/19] drm: Allow the caller to pass in the format
 info to drm_helper_mode_fill_fb_struct()
Message-ID: <t6yywwa4z42d3knc3ihr4d4hzenhtzm5noln5y57uwzlotdkxq@6neoszj33sgx>
References: <20250701090722.13645-1-ville.syrjala@linux.intel.com>
 <20250701090722.13645-6-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701090722.13645-6-ville.syrjala@linux.intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2OCBTYWx0ZWRfX87EmBz6ho5FU
 dpffndALHesMngaEr7WaZ8/UdqcW8lny7IF+MZpCxm8A2tEuEl6bW6z9y7GIJuxNBeZvWwPXT2j
 s/AbzHVqh/idYoITaglZY+iiA3nIm5CE+0KwkIP9wGCqlnN29+Hlf7d7dgH9j1FIkMF80W3174e
 kx55dSi9bv2RFc058CGhUwigEi1utVWgTeLDwPsW03gX3r4/5ajCTouLroac0la5/TSC8Y0yA4z
 UkVJeSZsVbCXx6R/tS5nlEtSxwbdUeiS7VhoSBUza5/yH9BwXtZ2E8AcPpjMsstPFc67AXu0lCc
 n2LFXd1aUXBiehA8Vr2wsQjtqh1XCA2XEnb8RC0Xron7wcL3s4za26nAvyYau34oSFQzDwwAgIi
 smB41zTZVDEUEogn7PbaIm3lLp6vGPz4A4QV/5Cl0YvR2PPRORtFpuDD2WUxc+Za3Fu6rIiX
X-Proofpoint-GUID: uq7K448UmlvCJhyiFeXC1NhRIC62ChMf
X-Proofpoint-ORIG-GUID: uq7K448UmlvCJhyiFeXC1NhRIC62ChMf
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6863c108 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=p4Kof4svB8ImVrqtDUEA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=609 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010068
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

On Tue, Jul 01, 2025 at 12:07:08PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Soon all drivers should have the format info already available in the
> places where they call drm_helper_mode_fill_fb_struct(). Allow it to
> be passed along into drm_helper_mode_fill_fb_struct() instead of doing
> yet another redundant lookup.
> 
> Start by always passing in NULL and still doing the extra lookup.
> The actual changes to avoid the lookup will follow.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
