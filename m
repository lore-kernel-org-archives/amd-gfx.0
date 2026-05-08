Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C702BCD3447
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 12:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB7E10F473;
	Fri,  8 May 2026 12:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="asrMxzoZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/N7m0La";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DE210F473
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 12:07:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486K6sJ1174056
 for <amd-gfx@lists.freedesktop.org>; Fri, 8 May 2026 12:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=; b=asrMxzoZ2nc8CVtb
 QfEsgxHkuEO4CssLLzL4PSG8xDjTMlc2yv9YiKlILTVYmhYe60VJ0n1AA4dABNPr
 DOxtm7mfjSQdrtePvy1RZqETCdeLaBXz8BAnmvIlos4UzryJGlpDCxJDBwVQFphe
 UWLeZm4R+8gNCFfrkfXxNyNNXQtBxz9yFS+ES1zRJu7cGFIkjArrMvb+766wAPs+
 TOCOT1vzGF8LRB2i6zB6ARFLKjqayaKjX5JoYuRpZoBNisdQGJ9iCO7vufvcrUW3
 tVnSqoXt9rpfcRfM45kGlMbv/OW+9pgm/2etfAj23oxPTgpzqvR1zfkH2ckPCUin
 kd2tzg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132hasux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2026 12:07:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-631289505b8so1000831137.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2026 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778242072; x=1778846872;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=;
 b=A/N7m0LaLUuxT6GeRXXEAg9snIXEfEQDCx7AgcoLDVkdNSa3JQA2ZmRzYZAUNPatyt
 DgVoPkdCwof3oy36IbKV4U585H3/4oJ5zfv6xLjGJVeJmnDvWt6y9xSpw2FnIEsElgUS
 2ce0PRz760BC+VMPrLThy++7zr+bLIlT0KBM48bcpLvxOOcqCK+7qy6sWBVFSCVCM7nq
 VDwvAiL+mpD87cq+NJHB7WvWSVETr6zFruudxaMLmLH9NX5vamlDk+aI/d/Im/eumeHP
 OunX7F54dDo407HHZPI922a1GYVqOXTmWq3/Fn/nKQkhvmnAReJSwdclw9TZ2ZKfSfer
 HwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242072; x=1778846872;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVsTALs8yQuwUz11IVk8+Pby7wTwW8t8CLZPh0Fg3XE=;
 b=MNGibW0R+65mwe+v57dDz/DJlKn6GKcf2X8NemhFa/FNyNIczXO/h99GMjY3cZMriO
 QoQlLAMgUOjmGIl0u5WnkhRGBVASge6VgFeuAqeQ+pjnDagBQ7c4vmZ1q9iF5KiidBPX
 AgcPOPZRF6NadQuGX/DuQ4iR5n35l6bWEmAWu6wq5azamdLoP9/bo/nI3CDAKEd7gPbR
 pFPLszeZtEfi5zVQ9kGnpgjvJSVanjDnY8R9XOKH5iDysxZEDzB/2IsPkdOz17K6KCEy
 2Q6aJ8tN5fp0pKTqv/vLvoY6NeQ8FGsWzLbfiqkVFWeF9e9pwAIBe/ccWvJkuyOiW6Hj
 fO+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/llii5nRW1seJ66tHKBhqdOmjIn5VUmytAjI+TJZBcf6kLTv9OXTSMkBrVgJXqm1WRaCYeiM9P@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyM5am5BsbKZykRWr5C5tHd3qoorlEQhSIJYbFnQ6ZFTY36rg8k
 tnG+L1GrRhIUEFR1zw27IaukbVXHpXijrm2IMFiggaXhtgoQsz7UL/FuaZm2sGgXFCf7tiruXeg
 OY1vJavu55E1BaaHwMWnxF5plNvS2CPizU5dU8fnSJMKodbvf4Klk78UVxLwx06uh3j8L
X-Gm-Gg: Acq92OGVfN9xvQR9fvU84Rq6kpFJL2fIk9NgHIicLPLhUrxjEIIc4xnijPH/h92UvSi
 Hyvb25pPjyLsBUmr18Ji4AS4HOrpffBHQALrmspKt0yS4beOwMtgYTD8Obhdo6G7Nk0z+PuqC52
 fIEBY3wec18MwSZ+fKt9FtKFWcmVXgLChFmhnNBSgHBGE/BMxLduw0yVcC4pkZqxhlL5Rtyw0fy
 5q4ZY476aH5oUxntgsU3HTqIO6aO6cLf6GW+R095SFIc3ZSPPTwBPer/zOcPnIOf/3m45bLN6Sh
 XHIvE74JD3N/84zQtLdJJjrsAGi9DiL/XJXsx9twOGy9spXj3kSDh5Sw9GAS/kWA8rykjy8R9z+
 JT0EL9BtUMOPh8yT0qOb7gFYKUORqYAEF9XQoCf579ykNox4t+QxWfTsYySY6BfIb150qvipcGW
 yNc0u6Dw0lM24V4F5RIrgcCwvPqZe4R7/pH5A=
X-Received: by 2002:a05:6102:5045:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-630f8e751ccmr6928161137.3.1778242072242; 
 Fri, 08 May 2026 05:07:52 -0700 (PDT)
X-Received: by 2002:a05:6102:5045:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-630f8e751ccmr6928116137.3.1778242071782; 
 Fri, 08 May 2026 05:07:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f9ffa0a0sm3001251fa.21.2026.05.08.05.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:07:50 -0700 (PDT)
Date: Fri, 8 May 2026 15:07:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: John Harrison <John.Harrison@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
Message-ID: <hzesog5n7iv7rsgk246uzjmqjvkxwv4nqx3uc3ybx4fgia7smq@fue5c3cjobi3>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
 <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
 <f6d9e805-328d-4d9c-8a40-32b47fcedd51@Igalia.com>
 <CACSVV00zgV02t0CGaDUJyTGBceBk7MFaOQ7Uc6ynpRkxdBwZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00zgV02t0CGaDUJyTGBceBk7MFaOQ7Uc6ynpRkxdBwZhA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNiBTYWx0ZWRfX2sclUTZlJdo6
 uOjb0rG8tosotcBylTAVwaIJXJUK3iLxkKLSHCHRjoKplrcVuM/tj2w2KjAnw+P1cXIhLBUW3QE
 Uh56bc7OHt/n18j3WkkjirARspNZrkX0tbb3Xxn5pA7V0FIx7bNYPLnHVqOCMnOI5nzxx9MFupi
 WjiTb/ZHfR306csRc2Pq1uYJveXwTbK3qIbSAnRCPutoqIDoOF5esWh3U8n3nmp9MXXFZDtsHM5
 q0pHBS85x4LQ+Vrn1Da13nL4V6L3r41XCk3QBqMDSruRXQl/tWMKWB9OlKYiOt1PmTlOsfLnBPw
 D+wlzfz9ZZWfchis3lLs3b/CJmtjtSShyQObEF/MPFnujm4iFZi0NHCzB65iB1zv17MZ28Ub07P
 O56jBMplqU4iLhIH6FhciB++6kPkEyfKdCMIav4s1LVR18DT1xcNH9Aq4sPbX7fDdZRcxUVX5Wi
 6bKPJGqPtWPFjQCt9/g==
X-Proofpoint-ORIG-GUID: mdVYlMhI-rAlc68-NNHtlYsJ1YTYVlFh
X-Proofpoint-GUID: mdVYlMhI-rAlc68-NNHtlYsJ1YTYVlFh
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fdd219 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8 a=ZsvpycJ9WFwsJDxaJ5IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080126
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

On Thu, May 07, 2026 at 09:30:44AM -0700, Rob Clark wrote:
> On Thu, May 7, 2026 at 9:29 AM John Harrison <John.Harrison@igalia.com> wrote:
> >
> > Resending because apparently it got sent as HTML and was rejected by the
> > mailing lists...
> >
> > On 5/5/26 14:49, Rob Clark wrote:
> > > On Mon, May 4, 2026 at 5:25 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >> Mixing devm and drmm functions will result in a use-after-free on msm
> > >> driver teardown if userspace keeps a reference on the drm device:
> > >> The WB connector data will be destroyed because of the use of
> > >> devm_kzalloc()), while the usersoace still can try interacting with the
> > >> WB connector (which uses drmm_ functions).
> > >>
> > >> Change dpu_writeback_init() to use drmm_.
> > >  From [1] it doesn't sound like userspace holding the drm device open
> > > is the issue (if that were possible, it seems like it would go badly),
> > > but rather the order of managed cleanup?
> > >
> > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753
> > So is this not an actual issue that has been seen in the wild? It is
> > just a theoretical issue based on code observation?
> >
> > If so, then maybe the comment should just be something like:
> >
> >     dpu_writeback_init() was mixing devm and drmm functions - allocating
> >     using devm and then passing to drmm to manage. This creates the
> >     potential for a use-after-free bug as drmm and devm have different
> >     lifetimes. Fix that by consistently using drmm management.
> >
> 
> I've not seen this issue myself, but I guess Dmitry has.  That comment
> sounds more in-line with what I _think_ is happening..

No, I also haven't seen it. It's a teoretical issue from my PoV.


-- 
With best wishes
Dmitry
