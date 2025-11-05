Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23434CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 00:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6010E689;
	Wed,  5 Nov 2025 00:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hP3HVb6O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTINQWzv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC81910E685
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 00:39:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4Kg24j2904473
 for <amd-gfx@lists.freedesktop.org>; Wed, 5 Nov 2025 00:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BzFWrus5ToDQoAoDgYGAeJvj
 7pPGBO5zh4BEeX+7e1M=; b=hP3HVb6OLtaKhgMbJqnE9uY/1P3GcyuUhB9Tpu7t
 JKMWJRQLZV4KabicOMHfnJ2J1/jYp/VwM1ITWplYb1YReCw9g78TTi5dNe1ETy0R
 XBGR8s1w7k8BHU4Q09IwMre9VhU6k205H3AVJ1ASYRETQ7GwG7fGaHVYl1tt3dl3
 9VnlUhzoMAaYpijecthL4JMzlb3xZQEOeNsUPYNfWIzPydDwpUAMpZpqs34LmrfE
 3buMGCUGFJmV33iR75mc+4Cq6eKHtQ/jKQ1r6Y7mk9voAKBYhIr/DZKv7LlSG3Ye
 ulLB5H1e5oONvebQrBxvv82X2DTMEwWEojZTcnVmGr7RVA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbshad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 00:39:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b92bdc65593so4750471a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 16:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762303167; x=1762907967;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BzFWrus5ToDQoAoDgYGAeJvj7pPGBO5zh4BEeX+7e1M=;
 b=KTINQWzvcVFosp3DAhff7DSgtCfAHqxxnpr/tu8I6Osm/ALz1eOFoPkygfrnUkb6rs
 IVrEPJkLbqklj5GHGZcVfuOfDCIIxWQYXmPcYleYH2ff0BlqFORKZRzygoGHkcXpYNDP
 Fes7DyW3/u5UlzoX0j1ErrqYPOGvVXU2Dmg792XmPVi3o/jByocMEoUSHR84Qd/jhxdT
 KzBESUFTQptw5vt+6uckhOU8f1XRqadNbQ7lyFqowPKLj4wU6+f7C1+dUWeMs9ZeDLVA
 iA6tVZRUgIvnqeLGQh7drJRuHfLYEqOTD0Zl+MCV/P5JwFjm/F9x8zbHyS5QF/rrc60y
 K+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303167; x=1762907967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BzFWrus5ToDQoAoDgYGAeJvj7pPGBO5zh4BEeX+7e1M=;
 b=dnU/j6CI7VvA+yji5U5br4iqLdw754wFAuD4oLwZKQL24Z/p+dRK/TTQHFFO4y0Ti2
 ONPlE0rza072hc0U6NYZisJqgYxiUpB5J3XUjMJ3WcMBrtvZgncldPGFzaS495oBrPHI
 cZM01pdgfeCbPgZfG2shQxdrQip6ve5bZ6MnLJevG1Sb1uAB6PSu3zoG77lC+pDmTzVr
 8/OK4viVCK+9DwNHx68m6PxDYwEDVz7mCMttto5aj9aeMgJps6Xr6eneh9Vq67kgTAnD
 UqHzlJnF/i5gXWwl0gajf5T5QDUtmJJNyzGWTzl61nhWQ8QKSHthDHym3SyGRkrDPxvA
 7wxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO6yjh0RH6WP+kYX7O85xUpEx4QGPcqjOxGFR+vq/nsWLoKD2LPm2MqD3M5jWTTF9A7Sr+zeha@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRAj9PI9f2PGH5Anq0OYdsfpXzXVpsQ7+JrmNpnVOwuHkiuQCK
 5V7HalhEaXvjYaArkRJS0FIck1esvLJ5kJNxg3iqAKCdUSeMyWVz77whtViIlCPrLCp17agU6Pn
 Fp9TgLlUR2izDVldqW98WrQMpkrJnX0v2RpR0PoxeV9SAt+UflP8bK47/E3KDOpHl8Z2s8ANzBM
 eLGadQTjKoWVLe7Fido4jVj1XuZRjlS54ZKm7xheWZ3h4=
X-Gm-Gg: ASbGncuc+nu0Gv021KnCc6zko+i+7eX/Y6lpmy/hkjVErlj2IM9jU8Gu3rBKU3eg9mG
 ivt8ZW03Mpy4kYLY9lhA2pFnwZ0e0TWoukWW4LPlGnxGWHNqJTFS1iVfc3l9WAoHNWt6/RUFQJo
 RG9RdXiUDrhFHxPGxKfCGjMJGPXgf/35gspJudmUkxaqs3672VBlEdUk+Fq0qzkXMXjQpsSpNAp
 2gsZkwR9qMLw24=
X-Received: by 2002:a05:6a20:9144:b0:34a:1da8:b8e8 with SMTP id
 adf61e73a8af0-34f86408f07mr1550665637.50.1762303167214; 
 Tue, 04 Nov 2025 16:39:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzaGLmiKsrRvSr4jPvA6a7wSEG94Y+iLXfyMLNCyUN32mroWfowJJT4oHvtGc87ilU+o9AHrd1pUJDCgsX280=
X-Received: by 2002:a05:6a20:9144:b0:34a:1da8:b8e8 with SMTP id
 adf61e73a8af0-34f86408f07mr1550611637.50.1762303166627; Tue, 04 Nov 2025
 16:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20251007054528.2900905-1-suraj.kandpal@intel.com>
 <20251007054528.2900905-2-suraj.kandpal@intel.com>
 <aQjDejhzGRYJT614@e110455-lin.cambridge.arm.com>
 <DM3PPF208195D8D5DDD56AA88E006E66AD9E3C4A@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <aQoIBroBqQc3B-RD@e110455-lin.cambridge.arm.com>
In-Reply-To: <aQoIBroBqQc3B-RD@e110455-lin.cambridge.arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 02:39:15 +0200
X-Gm-Features: AWmQ_bnEJwcu6XSjUjTu8rMBuA8ieKzJYCA5nkQvWatiwJBc8AoL_uq6o3M1DN8
Message-ID: <CAO9ioeX2qEyjwi9LsnUh-cRv88iaRcdZtFr_yidf55A9_ZbLWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drm: writeback: Refactor drm_writeback_connector
 structure
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "Murthy, Arun R" <arun.r.murthy@intel.com>,
 "Shankar, Uma" <uma.shankar@intel.com>,
 "Nikula, Jani" <jani.nikula@intel.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
 "abhinav.kumar@linux.dev" <abhinav.kumar@linux.dev>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "jessica.zhang@oss.qualcomm.com" <jessica.zhang@oss.qualcomm.com>,
 "sean@poorly.run" <sean@poorly.run>,
 "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
 "laurent.pinchart+renesas@ideasonboard.com"
 <laurent.pinchart+renesas@ideasonboard.com>, 
 "mcanal@igalia.com" <mcanal@igalia.com>,
 "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
 "tomi.valkeinen+renesas@ideasonboard.com"
 <tomi.valkeinen+renesas@ideasonboard.com>, 
 "kieran.bingham+renesas@ideasonboard.com"
 <kieran.bingham+renesas@ideasonboard.com>, 
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: evRyVQicyLEp-BowO6caijCElRrfIR12
X-Proofpoint-GUID: evRyVQicyLEp-BowO6caijCElRrfIR12
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690a9cc0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=cwjfTKyZ_bUBt8LYXKAA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwMyBTYWx0ZWRfXxF9w4P5eyT1X
 2cU2G+C5unERNLMIOQMvFTh5y81BrA9HAg1BEinfX4e9mzsBWPNIQx7KkubKyfCIWs/6NoSgDjU
 L3neZphjBogEpoLcEgx/pfUQgW7nI6Woo8Jw9gGYadSAU6wmw/0niWJ8kfQaz7sszQd9XtShY3L
 ih2L7pB4iCF4vJzvKEIIR5HnteBgUI/dUDrVEnwmRa520tgEAILsciPjp0JmeF34BVtbQESxIFM
 W85IxU5TWGuDd9LbSfjiBZ6yNRuegJfUnMzjPrk2iCpMG/0oy+XpTnOlVU5Oj/l376Ho3YX9M/8
 97qhFF/1o79/g3ErwCDjD5s37TBEBouFy4H5CXPYwQTafC2KQECWfjUgXz+7pG3lwg4jj2h50fS
 K/26x6BIJC775BljUCxV75456IJufg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050003
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

On Tue, 4 Nov 2025 at 16:05, Liviu Dudau <liviu.dudau@arm.com> wrote:
>
> On Tue, Nov 04, 2025 at 05:11:25AM +0000, Kandpal, Suraj wrote:
> > > Subject: Re: [PATCH v2 1/7] drm: writeback: Refactor
> > > drm_writeback_connector structure
> > >
> > > On Tue, Oct 07, 2025 at 11:15:23AM +0530, Suraj Kandpal wrote:
> > > > Some drivers cannot work with the current design where the connector
> > > > is embedded within the drm_writeback_connector such as Intel and some
> > > > drivers that can get it working end up adding a lot of checks all
> > > > around the code to check if it's a writeback conenctor or not, this is
> > > > due to the limitation of inheritance in C.
> > > > To solve this move the drm_writeback_connector within the
> > > > drm_connector and remove the drm_connector base which was in
> > > > drm_writeback_connector. Make this drm_writeback_connector a union
> > > > with hdmi connector to save memory and since a connector can never be
> > > > both writeback and hdmi it should serve us well.
> > > > Do all other required modifications that come with these changes along
> > > > with addition of new function which returns the drm_connector when
> > > > drm_writeback_connector is present.
> > > > Modify drivers using the drm_writeback_connector to allow them to use
> > > > this connector without breaking them.
> > > > The drivers modified here are amd, komeda, mali, vc4, vkms, rcar_du,
> > > > msm
> > > >
> > > > Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > > > ---
> > > > V1 -> V2: Use &connector->writeback, make commit message imperative
> > > > (Dmitry)
> > > > ---
> > > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
> > > > .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
> > > > .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  8 +--
> > > > .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  6 +-
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
> > > >  .../arm/display/komeda/komeda_wb_connector.c  |  8 +--
> > > >  drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
> > > >  drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
> > > >  drivers/gpu/drm/arm/malidp_hw.c               |  6 +-
> > > >  drivers/gpu/drm/arm/malidp_mw.c               |  8 +--
> > > >  drivers/gpu/drm/drm_atomic_uapi.c             |  2 +-
> > > >  drivers/gpu/drm/drm_writeback.c               | 35 ++++++----
> > >
> > > For the komeda and malidp drivers, as well as for the drm_writeback.c
> > > changes:
> > >
> > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > >
> > >
> > > [snip]
> > >
> > >
> > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > > index 8f34f4b8183d..1b090e6bddc1 100644
> > > > --- a/include/drm/drm_connector.h
> > > > +++ b/include/drm/drm_connector.h
> > > > @@ -1882,6 +1882,61 @@ struct drm_connector_cec {
> > > >   void *data;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct drm_writeback_connector - DRM writeback connector  */
> > > > +struct drm_writeback_connector {
> > > > + /**
> > > > +  * @pixel_formats_blob_ptr:
> > > > +  *
> > > > +  * DRM blob property data for the pixel formats list on writeback
> > > > +  * connectors
> > > > +  * See also drm_writeback_connector_init()
> > > > +  */
> > > > + struct drm_property_blob *pixel_formats_blob_ptr;
> > > > +
> > > > + /** @job_lock: Protects job_queue */
> > > > + spinlock_t job_lock;
> > > > +
> > > > + /**
> > > > +  * @job_queue:
> > > > +  *
> > > > +  * Holds a list of a connector's writeback jobs; the last item is the
> > > > +  * most recent. The first item may be either waiting for the hardware
> > > > +  * to begin writing, or currently being written.
> > > > +  *
> > > > +  * See also: drm_writeback_queue_job() and
> > > > +  * drm_writeback_signal_completion()
> > > > +  */
> > > > + struct list_head job_queue;
> > > > +
> > > > + /**
> > > > +  * @fence_context:
> > > > +  *
> > > > +  * timeline context used for fence operations.
> > > > +  */
> > > > + unsigned int fence_context;
> > > > + /**
> > > > +  * @fence_lock:
> > > > +  *
> > > > +  * spinlock to protect the fences in the fence_context.
> > > > +  */
> > > > + spinlock_t fence_lock;
> > > > + /**
> > > > +  * @fence_seqno:
> > > > +  *
> > > > +  * Seqno variable used as monotonic counter for the fences
> > > > +  * created on the connector's timeline.
> > > > +  */
> > > > + unsigned long fence_seqno;
> > > > + /**
> > > > +  * @timeline_name:
> > > > +  *
> > > > +  * The name of the connector's fence timeline.
> > > > +  */
> > > > + char timeline_name[32];
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct drm_connector - central DRM connector control structure
> > > >   *
> > > > @@ -2291,10 +2346,16 @@ struct drm_connector {
> > > >    */
> > > >   struct llist_node free_node;
> > > >
> > > > - /**
> > > > -  * @hdmi: HDMI-related variable and properties.
> > > > -  */
> > > > - struct drm_connector_hdmi hdmi;
> > > > + union {
> > >
> > > This is a surprising choice. Before this patch one had to have a separate
> > > writeback connector besides the HDMI connector. Going forward it looks like
> > > you still need two connectors, one that uses the writeback member and one
> > > that uses the hdmi one. Is that intended?
> > >
> > > I was expecting that you're going to declare the writeback member next to the
> > > hdmi, without overlap. If you do that, then you also don't need to move the
> > > struct drm_writeback declaration from the header file and it should be enough
> > > to include the drm_writeback.h file.
> >
> > Hi,
> > Thanks for the review
> > The reason for this came from the discussion on previous patches and was suggested by Dmitry.
> > The idea is that a connector can never be both an HDMI and writeback connector at the same time
> > Hence we save space if we pack them together.
>
> Hmm, but you can still have all the CEC and HDMI codecs data in that connector,
> which feels strange.  Also, what's the issue with having a connector that has
> both a valid HDMI state and an associated writeback at the same time (i.e.
> don't use the union)? Writing back the memory the output that goes to HDMI is
> valid, right?

Writing back to memory requires a separate connector (with separate
setup). The CRTC should also support outputting data to both HDMI
_and_ Writeback connectors at the same time (aka cloning). Not all
configurations are possible, writeback requires additional bandwidth,
etc., etc.

>
> Maybe that is not something that you considered, but with this patch (without union)
> we can drop the need to have a separate connector just for writeback. We're breaking
> user space compatibility, true, but it feels like a good change to be able to
> attach a writeback to any connector and get its output. The drivers that don't support
> that can reject the commit that attaches the writeback to the existing connector.

Well... No. It's not how it is being handled in the (existing)
hardware. Nor does it make it easier to handle resources for the
writeback.

-- 
With best wishes
Dmitry
