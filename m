Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4754C87FCF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Aug 2025 07:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931E710E25E;
	Sat,  9 Aug 2025 07:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8L7Eauf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC8910E214
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 07:52:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5796fNdI019188
 for <amd-gfx@lists.freedesktop.org>; Sat, 9 Aug 2025 07:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VpEHcu9gcEArGq0cNR0CHEpsGr9nMZuYOYDfPme+0QE=; b=b8L7Eauf+2GTa4uH
 F9FNVrkFO7CgNzK4FCHg39V/+Ea32BiqVcOdCR/R9fpjyfciN+JGUAAzpTALVkbs
 S6sF3kooi/1CXYHdyxI+aab0q1uWho6jLMSGHmBBtfrxbRejsEwkHIAWnTsSVZpO
 Xqg9o62Hoo35E9qq5v8TFjiNuGAAyx59I//Bf4vWSZKcdiylxSG2r5Vz6CfBYIJE
 8go+hR3R1glDvDcTLXgI8UvYZgqaeUwqX49YzYDAPBCnX4o1lGI3H8XfXZCVwrld
 hvB4zsoLceL0rUzQlo6YDB/4DPwokVDOalsQ6gvKd+NDxm0lCgN9hn/m78fYZK61
 IQmVwA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmggd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 07:52:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e7fc5f1e45so586892885a.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 00:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754725944; x=1755330744;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VpEHcu9gcEArGq0cNR0CHEpsGr9nMZuYOYDfPme+0QE=;
 b=iRwp6+vKB7mikMyfYP5tgLdNcGKRqezVINlSCT/ep6kh1C3Vdgn4hxmqnrqaKZ/q07
 q37IMiBIWQM5mf3HswBEI5c3ZR/+E1/5blDcFbeSvhMPORIx7Qhb9WJRqg8zbWpmeYjp
 83gKxQWOQtWOzSXLGEKzp1+2XJQbdESZQCDoEeuXSZqowTpp90iyAZqgV/S7h9eLckUD
 3YI2LaimhxDyuhiOtmImWOPyr5ffSBmNSYn3cbIbrycvyc0Ri/zPe2wl26fG0xhkEC3t
 8OgIkZDAyZMvTaMyXbjDZrnccmuX9M/bXpORIWUUEktjL8oBY5nRhIix9wTE/KZEgBWy
 QPwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo08FIMQsFPr6PmoLiz4DRy+ZBS6teVTF4Nckxgxpy1G4baO0aIKbh3tFHBafdluSJZVqa4jUK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW3LNJ7lEPWzyBe6Kku7cngvOQhhCZlu8nW44rs3i1sr0VeViB
 o5JU8+smgI5jQ6C4FrD13TxVJNUjD5jIJ9Qo+RJt8XP/G7QknNu4bE4ALbRF0KdMAVQqAHMlR8B
 +HI8DVv3Hc+t7FBR9fzlt7m9BppGYhP0kt9VlN1Bo8IgsCTrEP++43vThqClHW75jWmJQ
X-Gm-Gg: ASbGncsG8hc7yCpj9ZT8w/VidOI7Ob/An/Ugdpel6knG8M94Qxn+pXbdGPvNV9ks9a6
 5DShgKEs5dUIOv7FCxZgGEJnXOUhuh3Hb6B6v8zHajjd/LvUg0W5+wy2t3r2pIz0CJIi5pNFqn+
 JGcsXucU3vsdxcoOWPVuw6U/kBrQL4L45oWAZ+GfojH53RR23VY2/RiODKgMGZhz4ATOO3PEF6m
 QxxEg7+l3wpXJ5YdFbe9XzwtI5xt99cIAASFp+VY6Cc/Nuf+G5vdPZFk5c3GDRuuEYiWmZ4A53+
 +UI9Pxc5CY3M/NZD1gtqBBgZwsKmkO11RkatH8z8TGRuQsuzCys9w/H6Vm0ZrpbEWi6v7nGot9j
 NQXBHKyGnysiK4NgMJK1O0ipGariHDc3l7AHPkF7VPA9uCcIDDSON
X-Received: by 2002:a05:620a:4143:b0:7e8:221c:c968 with SMTP id
 af79cd13be357-7e82c7a1401mr845380585a.65.1754725943930; 
 Sat, 09 Aug 2025 00:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4XWRAAnL1JlYlSACEe9f4C6EFHC69s++GpGa7tj/KvlYxLz0g3xleWIOEQplk3ocUxXH+1Q==
X-Received: by 2002:a05:620a:4143:b0:7e8:221c:c968 with SMTP id
 af79cd13be357-7e82c7a1401mr845373285a.65.1754725942444; 
 Sat, 09 Aug 2025 00:52:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b8898bd63sm3312345e87.20.2025.08.09.00.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 00:52:20 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:52:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <opjgpsvd3u2pje5ytyy422uxq7xzvuhfv2uhf3xz7ccampfohh@q5cu2lpcfjem>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
 <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
 <6cbe8955-cb34-43fc-9950-0fec4b7cac3e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cbe8955-cb34-43fc-9950-0fec4b7cac3e@bootlin.com>
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6896fe38 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=ROXIs7_yG6JpRt47qDYA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: tfhkogB0aHN-gh9yPeZ8L3CsSjZtWWAL
X-Proofpoint-ORIG-GUID: tfhkogB0aHN-gh9yPeZ8L3CsSjZtWWAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX6oVxH+urAaPm
 pmizzSeMmEj4QirzeVuTf3wTlMn/ytLBZRXmjPVmorDVbOPfa9u/WuE/zOw/AyQgoM/+noEd4+5
 JM7BkfWKVVDSIu4lJPi3BVyb+eH7tFfWFZ28gqE6qv+gj2wK/Cj8ff6ZkdOwUSCgksO1uwSWsFu
 XNdZQEuZYW/SI1Ijz0SvE1Bgp+f/4O+yrqwtshQt/+p6j2d/KdsTjLYXaPZdj8qk1mB7/4MPleD
 fev3BLqoE0N9Vn+rwJ30MUfjVRNfUqJ+G69T6jAHMw3daqhE78o7Qqmu7ue2Jv/gYXWX6B4XKH4
 nH8rz0SPyQrz2YksSHmjiCQHM1bifnw1N7o/cP6BWSui0wYTQeFoz/oT4toA7KLKh5J/kVq5fkA
 kIjh7Er7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000
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

On Fri, Aug 01, 2025 at 04:08:37PM +0200, Louis Chauvet wrote:
> 
> 
> Le 01/08/2025 à 15:51, Dmitry Baryshkov a écrit :
> > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > drmm_writeback_connector_init() in order to initialize writeback
> > connector instance.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> > @@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
> >   static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
> >   	.reset = rcar_du_wb_conn_reset,
> >   	.fill_modes = drm_helper_probe_single_connector_modes,
> > -	.destroy = drm_connector_cleanup,
> >   	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
> >   	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
> >   };
> > @@ -202,15 +201,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
> >   {
> >   	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
> > +	struct drm_encoder *encoder;
> > +
> > +	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> > +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> > +	if (IS_ERR(encoder))
> > +		return PTR_ERR(encoder);
> > +
> > +	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
> > +
> > +	encoder->possible_crtcs = 1 << drm_crtc_index(&rcrtc->crtc);
> 
> drm_crtc_mask?

I was just moving the code, but I think this kind of change is fine

> 
> With this:
> 
> Reviewed-by: Louis Chauvet <louis.chauvet>
> 
> > +
> >   	drm_connector_helper_add(&wb_conn->base,
> >   				 &rcar_du_wb_conn_helper_funcs);
> > -	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
> > -					    &rcar_du_wb_conn_funcs,
> > -					    &rcar_du_wb_enc_helper_funcs,
> > -					    writeback_formats,
> > -					    ARRAY_SIZE(writeback_formats),
> > -					    1 << drm_crtc_index(&rcrtc->crtc));
> > +	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> > +					     &rcar_du_wb_conn_funcs,
> > +					     encoder,
> > +					     writeback_formats,
> > +					     ARRAY_SIZE(writeback_formats));
> >   }
> >   void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
> > 
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
With best wishes
Dmitry
