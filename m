Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98774606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E38fEtW6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YOz08Ty3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B4D10E40B;
	Thu, 22 Oct 2026 12:01:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AF010E40B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:01:40 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA06b13115556
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pQIf+MPS9ZBgM7DuW4ui8ue8
 uuTAAxWxDd0AuH9xB3U=; b=E38fEtW6rUgMIG6tTA0UfhcHk0PAIJbK6oauV0ZI
 oXEl2HtfSTi4yOQzxTR+23gcKr+3Vt6ggAXZyHqrtUwdndjUjoM8ZYx95CX5q/Is
 g7eVOwJ3lNIH1mHdgEb6iRcTPWy6Tsq7I7u5PFU/SkZg8OxqMfA4nUf/ooy8L7X2
 9VYxr+8HhE+9X9tV47N/H7VYlbjbgAllPg4eSgYSKqVhUVeum18xu4ldiwBxJxZd
 CcbqT7ouWYzPHE1dloE+7BfQKaIv0Y0lBgMWTlu3+FlMJZAksh6ZpJy918iSLDqN
 b56ty9s+BOzNV4OhTIfqJS2WMZGjdVnoqPiYCcX9VJwP0g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bu1c3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:01:39 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99064f8c7efso1137869241.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792670499; x=1793275299;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQIf+MPS9ZBgM7DuW4ui8ue8uuTAAxWxDd0AuH9xB3U=;
 b=YOz08Ty36ccysEkgAjef603HPqo5MZG5Qj5CesuWwP8zwBJgbi9MS0shO54dkcPo5c
 IXXhsXquDwzfSAIyxQAte8FHTzFLZt28iSXzMIsw49gPUz7IWEP5nGSvLDYIPH5pEGHz
 m9L1ZtABBkrAW4aSdYQ9n33K+Mef6xAn8MwNL25upzVyoUoCRKW2SLBrQaOsluY20AQd
 tBc5hAZf/8o+CKOx9CMCN8bWnyMd8siDHvNhdAxOx/3LPiKe00tiiMD8YdcXvXgF0096
 MzPpU1niHLFrFUIC0wVI+2PkCxdbJjbnSpPERBQ3r9p739/4LGBVor1jmoz+aeroS5li
 ixJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670499; x=1793275299;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pQIf+MPS9ZBgM7DuW4ui8ue8uuTAAxWxDd0AuH9xB3U=;
 b=bOeAIyVVrzEKcFLhN66r8/2vmpNhHDymIFMzOOcozfm3STONfjdz5EToyPbhOA5tfv
 JvCcXI/mQXSukNvSmJRgMSUQFwLUT3DTdHHbKIFl8uG9imdCa9n7ryqEKnfmywWRRiMj
 KHTPVpYp0ruj7ZVHkFhAjR+DQ8LNBKP3eF1tuEg2TTWMK+60SyJbZ5OnRIkpwcxP9xjN
 IORwSuKlujz64LLzv5LVhMayN7svAZRa0WXsucn4xIDypKwabU8kyJ8Q63xnvzCbcvQi
 LtDUAh+DIWrOXxdwnzImNcw2YKe56HLExzq/pVarYTE1vLsgPovcmKnYT4QL9dM5N1hg
 yk/A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVAO2EPZ/TB4tk64P3jF87MK9ag5ylkz0L2poAMNEGCSGHTgGXTXN97q9Nf5q87iNrqn9eWTaY@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLMg+g+nROcZD/Z6kzfqWaAtj4SxP3DsnyNmVmqcLWnI0/Pe5CI
 cD6etT4agt7T9LEvwd0tHGNfWi6cXjrJAXzNXUE9j1V1boXlK/ItY2Qx4JEWAj2VMa0eBzObcxC
 57/2q5szLOGDuxZMJmPma6DAN+AFAy0uOottdJy5Gr0sFsnj6vpv+xaxZGntVOEx5oJS/
X-Gm-Gg: AYBFou0YKrRBbXlZk8qLjd7LQuokDyAezGOvvjfqL8m3PsFvdYq1HRT5IO9CLriCncS
 zw32jdeIUAGYr9oB50U6GZscNaQbzrQ/IpJTI7aEafM9GT3yII6Y2HRPnMlMqIrwl2AVYIwx4zs
 pWHskBeKtDFYGTu90ooESKiLYrZ2u9zxYjO2fFyn7eHkrxJFbTWiClJitHs9iUCjiTgS2BQgie1
 05JsDwtBmT0IKFqtDZ1wAtIVQLQHNSVJPXLTuE/CLQi26vtuXwktmn/LPTMzhyPR1hf2i5k2oWD
 38o/bMAmIdtz9lrFcobhyJxcc/698CsCcATchWT/WYyOF+SljKnunSg1MYlox0EgHvoYIl8J1Ud
 n/E8JC+oABPdXhpYo5z9FG84Pf7vAO4Tc8wIu/wsiV4Mgb8TxpK1iCZxkVY0ZFRyIOJdtxVbkv0
 hOrp/yxUJ2Ib7D
X-Received: by 2002:a05:6102:548e:b0:7cc:2bb7:1335 with SMTP id
 ada2fe7eead31-7cc92740fb9mr2034426137.33.1792670498623; 
 Thu, 22 Oct 2026 05:01:38 -0700 (PDT)
X-Received: by 2002:a05:6102:548e:b0:7cc:2bb7:1335 with SMTP id
 ada2fe7eead31-7cc92740fb9mr2034336137.33.1792670497623; 
 Thu, 22 Oct 2026 05:01:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa1212183sm1044229e87.46.2026.10.22.05.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:01:36 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:01:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: John Harrison <John.Harrison@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH v7 0/9] drm: writeback: clean up writeback connector
 initialization
Message-ID: <i5hyqavtg6fa5eaq34uxpv4egdydcbdqvlqzn3ctpmyguy7j3h@nrr2kcd62wuw>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <45638e6b-04a9-46b2-97c0-66f3e2f9930a@Igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45638e6b-04a9-46b2-97c0-66f3e2f9930a@Igalia.com>
X-Proofpoint-GUID: mzUWtj9BZWJYTLBtGu1Dk2Xfzybgp6ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfX2Han/Ua/NaRM
 ej4uW6J0+YUI1FvJ8EyCx+KutfKwOFtxLRXPoE1IMVm6fOT8Ju5QcpsYVYy51ebw42NroA9Rlez
 /Pce09KdgB6q/Ut2vDRwBR65YcLwiVEW+n1lQpdEusQyAPgCGqz1wf9PAqEmIRXCMLtysKaN2Ef
 E9daENd0d2e5b1+hTBtIskrkPaJDJVLue2oFfZG43AfiNQWfiO4j+XF5ouuMhgF1y7i7XGjz7g7
 AQ9W/issKotFvBz1sNkN/qI6ov4pT19qSZqbQKiqfOTnBmqS693jptecdDjM24S27G3VzKKrD26
 A22qSqqq9mU4oyv9y2rEmJd+VeluqtoPp6xskR5d1dxybEryRsq74uccWUWHus9mtxuEl5GHYqK
 pdQDAcSiRt1f+khQocbvYNPsY1tszlOhs/IGJMkp7y6TfIgVB/f2QkuIAfrn+YFv7NhsSzuLDgQ
 vIp93cgq0ImWYugShbA==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9fb23 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=IWSX7y9O8-nPMSrxZ4gA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfXxDNaxZ+LKkaK
 3PCcZyE+rKOYTJX6ZH2mBs1rR2fepbCQOBDdVSkLceSd2jvfvi4jKQpE4hmBssebteYQmL6gUoS
 VEVFLdhoWQRD/V5/IjhX5x7FCnQyUX4=
X-Proofpoint-ORIG-GUID: mzUWtj9BZWJYTLBtGu1Dk2Xfzybgp6ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220047
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:40:58PM -0700, John Harrison wrote:
> On 10/19/26 06:12, Dmitry Baryshkov wrote:
> > Drivers using drm_writeback_connector_init() / _with_encoder() don't
> > perform cleanup in a manner similar to drmm_writeback_connector_init()
> > (see drm_writeback_connector_cleanup()). Enough of the drivers don't use
> > the encoder embedded into the drm_writeback connector.  In preparation
> > to further rework of the WB connectors (as planned to enable WB for i915
> > / xe drivers, which would move drm_writeback_connector to be a field
> > inside drm_connector instead of subclassing it) remove the drm_encoder
> > wrapped in struct drm_writeback_connector. Rename the
> > drm_writeback_connector_init_with_encoder() to
> > drm_writeback_connector_init()
> > and copy drmm_writeback_connector_init() interface. Then, with the
> > encoder being gone, handle proper cleanup of writeback data in
> > drm_connector_cleanup().
> > 
> > ---
> > Changes in v7:
> > - Significantly reworked series, no longer insisting on using drmm.
> Is there an intent to move everyone over to the drmm version in a future
> patch set? Or is the plan to give up on that as being just too complicated
> for the benefit?

I tried doing that in the previous iterations. I don't think we should
enforce that change as a part of the framework. It would complicate the
review. Individual driver maintainers might perform this change on their
own later on.

-- 
With best wishes
Dmitry
