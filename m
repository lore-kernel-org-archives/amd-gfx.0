Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E1AC87FCF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Aug 2025 07:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D69910E28E;
	Sat,  9 Aug 2025 07:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3azN5yR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA2710E27B
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 07:55:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793jmbU011978
 for <amd-gfx@lists.freedesktop.org>; Sat, 9 Aug 2025 07:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Bpy41yTW5kRsP7L2ucrV9Bxz
 +ufAx1/nlB3z+r30uRs=; b=L3azN5yReOvTEHISGrnQ1UntSANurOTQT5AqzaY9
 PQLv+vKNoOlcpr7LTQiuHi2gMPlcGhAGYBYi5siKR6d8IoeWxWBcLA5QTA0XzbDW
 XlhacyWDqFfoRMH9YDI2i2Xeq/UY8KInMwyT/Z8CzT0bAQWBN2quRFpSIQ8u7PRa
 slxPcjxFlSY+EJ+liNs8DQtMertIXlSplXdSNrkFBmiet6O359ajuJoCPDsukY6J
 +J3s+ywvucLrI7+I7qJ7ozOQPTOEdNmSWr9ymB7CfYLxO1kbRnp62WIUqXDTrEsM
 ayjKPZ2AYiD12ZAm8iwFPE649siuQ8W535y/Wz6JJqE93A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6r972-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 07:55:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b06d08d61bso86182341cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754726129; x=1755330929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpy41yTW5kRsP7L2ucrV9Bxz+ufAx1/nlB3z+r30uRs=;
 b=i7rZG6Fq73z93qCleECFscsg0JGHLZht8h+pWHNoGe8zSrs6NUXD4VicA+MdB4KRVp
 Gsb/SxSFbLhDNLHd3y6p67WkWG70/ab3Li1YYj6twS53B9lWVZJtJKOF+rOEsIzJQ2qZ
 TeAzV2NHj7+umyMiTV01xhRc2mClB+zI7UQDZTXWM2mGRRuF0Z9pev0tANFn6p19L87v
 J/D0YkW0AxpOHWE6XdVjPofBWJNeKBcXTVaiiPVljnEFzeFrvjHrhXbKsktRIinTXq5q
 QuNNV/dpr/lNFr9vRouvJQRIxaWxObH3VlUWS8UPt+mk5z0S16YgxZBtGR0U8GfSn1ZY
 vM+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpOt6hugY8vu0op6L7P00dTDM8bV6UtqplDAwM+xUMmnOEae8oxySmU5cuB7TE/nOhK/yDgmVI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2bxsHH/PuSIj6QpGbayWJ0FWihviQ3KNtgin2fj986nu7eugG
 4+DSRiqlHJQxNKJlNlBy1tGe4efg0DfGvb1Mjf968TK+9nQEZeNWRoUV+NZSQAQNTBhWLyrh+Z4
 AvgCT0o7C3AgS0wdQJ7bAX94wS6quWR3EhLk5UgSza7DOAVAu4wg1JT+kCfCTdRKsQ4MX
X-Gm-Gg: ASbGncur3n7fr7onQdsN0KoetBb7etOKiU8t+gz+FbdX0c60Dh7xFW9lXxxJdARiXdq
 G1xOeszVrWRp4mB9poxvKf1X6oCv4l+NcP3nOFGqmicLCSgKyc8rp97wUsSxYpV88g5SnoBK1t2
 AdIWPcsX0hMryaPoT83DXcgtjApgruXZIPVXGDMTP2cJkY7IIsv0EvN20fXw9yTJypYUzXEKgcq
 48DnnWYYs7AbX3dEl1/5fYRIFzubkXjf4ls8LfhqlGOKWKer6EYnFmbfxy786OPAoNDYRX+5AiF
 p3LcekjaiKiKIyhuHEqWd6u5IWcvEusNsmi2Qqmqfu8qMrwh37LEgyq1m0vi72JaB2JUc7/nSXY
 oOrSMJrKQWdGjB5CvLoLyx7ZZVGZakQ9aj74JrTbAa+duv0F9am5d
X-Received: by 2002:ac8:7c45:0:b0:4b0:aba1:d716 with SMTP id
 d75a77b69052e-4b0bfcba7b7mr22351741cf.51.1754726129100; 
 Sat, 09 Aug 2025 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWh0wH/XYu6MxnL9BGa8/d04wIKlcDPKSSS431MPGMBx8HxPe0UWHgnixqCdznmpzQTN6fsw==
X-Received: by 2002:ac8:7c45:0:b0:4b0:aba1:d716 with SMTP id
 d75a77b69052e-4b0bfcba7b7mr22351431cf.51.1754726128504; 
 Sat, 09 Aug 2025 00:55:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-333bab6a92bsm27111fa.45.2025.08.09.00.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 00:55:26 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:55:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
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
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 8/8] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
Message-ID: <bxobv4ofetrhnxa7n45fmm3sllqgy37fzgxnyutm3osjqg4yhl@tvdsf6mghuqk>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-8-824646042f7d@oss.qualcomm.com>
 <3c522dd8-0e56-4ab3-84da-d9193137d4fe@bootlin.com>
 <DM3PPF208195D8D863A5A2E8A151A77A7B3E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <DM3PPF208195D8D9DF6BA02300F667B1967E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF208195D8D9DF6BA02300F667B1967E32FA@DM3PPF208195D8D.namprd11.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfXy/5inv+rj7s8
 R7BbUEmgA068VaYAXIIur1RkRXnY7fkMdV+TW8ophxwGWqPZ2sMxGByGRYefx3hlJLYWt09WAgE
 1kCQysk0LBj+G5ZvLTt4rowmLRjOAkkK6iSvQrC7y0skM10bo8Q0DaxSMm81ZQXFWSuK14i5ztv
 rnutExp4+dg3AycEx7mH27SBDMKdtG406QyCPu5Nb5XZir9C6HDFaPHg4wHypD4y6PQ4sW+9pId
 91r9ilTQxdwEuEFyqMZB98PKVLBdFM0B3V08Ozt7kc65UogOiDq2sjfpLglUu/LXn7V9P/JtjC3
 u8y0llznLJhya/fKijpf2GvA/3cwfJNFe4uBkrl1vvOhMeF9SA5jbiq6wMFoGxCawyguz7lV3Dn
 u9mVYaFO
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6896fef2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=ft45mRQNhs6EWNLFJ_8A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: rNCo6nA9qhLx7xnq3hI6975xLayC00eY
X-Proofpoint-ORIG-GUID: rNCo6nA9qhLx7xnq3hI6975xLayC00eY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028
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

On Fri, Aug 08, 2025 at 05:24:19AM +0000, Kandpal, Suraj wrote:
> 
> 
> > -----Original Message-----
> > From: Kandpal, Suraj
> > Sent: Friday, August 8, 2025 10:35 AM
[...]
> > Subject: RE: [PATCH 8/8] drm: writeback: rename
> > drm_writeback_connector_init_with_encoder()

Please fix your email setup to not include this splats.

> > 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > LGTM,
> > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> 
> One thing I noticed was after the Rename both drm_writeback_connector_init
> And drmm_writeback_connector_init have identical comments both allowing custom encoders
> To be used now is that what we were aiming for with the only difference being the 
> ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup,
>                                        wb_connector);
> call ?

No, there is also a difference in drm_connector_init() vs
drmm_connector_init().


-- 
With best wishes
Dmitry
