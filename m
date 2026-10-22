Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2230606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Par7Xu1q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGuV5++v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B56310E41B;
	Thu, 22 Oct 2026 11:59:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B647112501
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:59:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA06CM3115553
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aPE/s6P0svckbKbkPg294wPN
 +bCnxy9mUDtCKQb3Cvk=; b=Par7Xu1qoevn8z3nPGjiV5KdFK0FBaEyRpwV76VE
 XGRuwy0Lu2kpYODoox0SU+jVM2P7MFEMMtiFHFZ7RkE97F+nuoWXXvfr6GtyoJPc
 vLI6afKNFzZv/os2z+ZIx3ocCUgI9uZfDaPrPpPY7jeQd+62LOD0PTq71TfSQOt9
 17QMYOMPtEnRT5ilsJrZNLa7reoASTXKljuA9EySM84j1UR5+ZSyiZW7JtCEM67i
 O8URo3Pmo6PZGp/sCiaRuxD/HDDNkVXArnLamvIYm/lUbV5bUnoy9itQuo2hgYhW
 3PCwEIz465UhVyGfBaT3boW9mBdrU5Z/aso6OnotODBdwg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bu0wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:59:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91bc57d4d11so42136346d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792670369; x=1793275169;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aPE/s6P0svckbKbkPg294wPN+bCnxy9mUDtCKQb3Cvk=;
 b=PGuV5++vFrAiERz0cqc3F9Q0njM1b5La4tePWLrdXpP/AAxsGRka7ohIT1CR165E/9
 YwZciI2u8jK2WckVg3ik3yhfTqA6+HptuYA0LSWvnOnfGXTDIVmgfC0qeIOQ8+HC8Ww0
 +pPbHEq76QVgDNvHbF+wA+b8WqsHKIw3NFarFynBKTRbIK8RSFkOu8pW7LIsw1XLTzzt
 sRUP1I3/QL5SWAOcKCgYhZheq2cuxkzjY1LgpEpNIcCbwkLoo5RGNas9gJbxGc6223JU
 fkO5A2CT3E9mp45XgdNegQApwNw7kjQdSTVcYND9lJ1lZiB22eQpVw0dbJWgBRiFLlDh
 JNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670369; x=1793275169;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aPE/s6P0svckbKbkPg294wPN+bCnxy9mUDtCKQb3Cvk=;
 b=k3q2lPJOQNt/fN0HRt2FvoKZ/AROIdoQqws65buaQStv4v1EjkgmbLe72Soly5sdE+
 nzX6Wb4WUyBcF/Vw/Dk3qQj9hwKVsZcVKC6KLI23u2fzkyFRFh2HcEojpvCCNwlljoQ+
 gMlK1rm5/OcjSvLXSUQqKwlKsV6QQ6XZgMtj04o/U9u4GPQyMyVvG6cHDhcScUdxT3KA
 ZL7uXH2JV0be3Y0ckdbWhRm1xHQnkmULOoUaleHJ8qgNqngbZ71bBuVebgilL4RXmt9/
 nBwlsE2s2yMr9gigiv5MHhSahp/zTEOoBOs5Iz6WaK2hrFov61l2Lxm4zi+djm2WwNLK
 SCCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI2agYYIIwJ1+L/kl8LJJGUTBVNfvLFKu/OIKkWhFi0qUSTMyu3rJF+THUXOzN3nZEF33eS2ze@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5sJYLKWOSQgnJR2bCk1qG0oyehoWum+g6fenIvRhYbAV+BWQh
 wzAWGIwZPP8SriezX0zLay/DHmnTsAjbFhw+Q/vLmIZBzpbmIZ8mA5Vys6Xt+M+3Nbj86PblvDs
 qp9tiBZO9tURrKzqF9gvkIrFXgqX2RVT4P7m9sIAE+fsCz9Ux9KqhCIXd/b0pX8rmKdMm
X-Gm-Gg: AYBFou3EwIlOKQ9QogKzPhpYpdPDKvbeqqBVtzmaTnxcHjcBV3w5ZlDKbVd2xP08fLr
 +wukysnhzWgAor9qtU1Yy0uGPXSqtfI4yP48gwIRgbr3KjMdvm5MkUCk7KuR8sc3u3FrBs33eU0
 nifsXgqfQvkExlwJYB34iyq8M0uWY6zBJ2HDACg5NTVQoAgZ4Tfbqs1LIOXd7ZypRBT95nJYBW1
 VBnuXzyeyPCr1uVxKdhmB1c7nPCzou6oCXgDz9/LLhNTJLxzW109rG8R+AQdyfV8uVtBurNIjj0
 Flvyjr6Ef3oSbKSheAK+5SX38xyW88E5B16gUZ52gmJ0DgQ2+sqhm5fwPe2F7hsG0S1Ad3Y38Vl
 3K7NUO0qPcpBBTFG8k9DaRe6LmNKiRoM3kFizoGX441cb/E5PMgOWfNhc581A6zpgySG/K9FPik
 ozFZfcs//vshrL
X-Received: by 2002:a05:620a:4086:b0:939:733d:cbe0 with SMTP id
 af79cd13be357-93f57e5e514mr788970585a.3.1792670368787; 
 Thu, 22 Oct 2026 04:59:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4086:b0:939:733d:cbe0 with SMTP id
 af79cd13be357-93f57e5e514mr788966485a.3.1792670368330; 
 Thu, 22 Oct 2026 04:59:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa4adbb65sm626196e87.52.2026.10.22.04.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:59:27 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:59:25 +0300
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
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 8/9] drm: writeback: clean up writeback connectors in
 drm_connector_cleanup()
Message-ID: <gjeqgaewd5omwhdmepqcsrjq3pph722j6rjtoedot5rqsjsaht@h55ako6z42dt>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
 <d792066e-c857-4e80-8587-44a58ab75815@Igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d792066e-c857-4e80-8587-44a58ab75815@Igalia.com>
X-Proofpoint-GUID: YLvB6mZhU35e8QUR6MEn4j1ImpA-rRtr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfXz5mD/IfANaHy
 o8VN/N89ZpmIIo26Pyl1c4F0DXBS4Mg1UZLjrA3TMq6TA4jadKAR5Y95di5ZELzOgYdfSnlLRYZ
 Z+IddTJZEpUtjlDYDwrpnPjfIobYDNKMzlArNasqCMz181geIn0e+aHvk5W5WNpdQ2QQp+3/fNv
 iaQPQw4xJarKPo04Z+Mli0jhS2iPuXHjRq62yw6w04y1Y3arNlPb1cCS4HLbdlUmhjSPOJaQXxw
 i1XOzW/2p2r8z2pklbt5z2lthNieGx1w4a2Ttf+XONuG+kjpqDDJYwLlBACv/WbDlJ7LIQW3i6B
 Y/jm+1WHwPpTtgOde5BsMWkfvwBtnVEvpUhjyc4fXCKwPJ9DrcfstOI5w63toVMRJXTSuvVLJp5
 gHK7U69zuIiUx9/Qr3XxWTdTl1XZqVU5Ua6fI0csrtk14zN+zPsAA1SWxyKM/Z1uw4TITaw1otz
 /bddicTjQHIEi+Q+XpQ==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9faa1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=dAgu92QZlaad2esalq8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfX3bYH8/TLnWZT
 9U/ay2fHoRuatTFDIbsA3S2YfS69Js1Oh4CqgHzQalV3UXKokO7nti7Wi/gziv7Vr+ilgN/188T
 pp06oRMMhibC4EWcp9Mw1KFrotro0qs=
X-Proofpoint-ORIG-GUID: YLvB6mZhU35e8QUR6MEn4j1ImpA-rRtr
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:22:48AM -0700, John Harrison wrote:
> On 10/19/26 06:12, Dmitry Baryshkov wrote:
> > Only drmm_writeback_connector_init() registers
> > drm_writeback_connector_cleanup(). Connectors set up with
> > drm_writeback_connector_init() (amdgpu, komeda, malidp, rcar-du, vc4)
> > never drop the formats blob or free the jobs still on the queue, leaking
> > them together with their framebuffer and fence references.
> > 
> > Call drm_writeback_connector_cleanup() from drm_connector_cleanup() for
> > writeback connectors, the same way the HDMI audio and SCDC state is torn
> > down there, so it runs for both kinds of initialization. The drmm action
> > now just wraps it. Clearing the blob pointer makes the second invocation
> > a no-op and also covers drm_connector_cleanup() being called after a
> > failed __drm_writeback_connector_init().
> > 
> > Fixes: 935774cd71fe ("drm: Add writeback connector type")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/drm_connector.c     |  3 +++
> >   drivers/gpu/drm/drm_crtc_internal.h |  3 +++
> >   drivers/gpu/drm/drm_writeback.c     | 30 +++++++++++++++++++++++-------
> >   3 files changed, 29 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 893716a9e489..1c2bef5e0636 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -929,6 +929,9 @@ void drm_connector_cleanup(struct drm_connector *connector)
> >   	if (connector->hdmi.scdc_work_initialized)
> >   		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
> > +	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> > +		drm_writeback_connector_cleanup(connector);
> > +
> Could this be done via a new connector->funcs->cleanup() vfunc or something?
> Set that inside the writeback init path and it is guaranteed to then only be
> called for objects that explicitly requested it. That would be more robust
> and would keep sashiko happy. It would also keep a writeback connector
> specific declaration out of the crtc_internal header.

I'd rather not do it. These are the generic properties of every
writeback connector. The answer to Sahiko would be that yes, currently
all DRM_MODE_CONNECTOR_WRITEBACK use drm_writeback_connector. Once that
is changed for the Intel driver, the condition might/would change here.


-- 
With best wishes
Dmitry
