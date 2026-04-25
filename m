Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ABFF885A
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2026 21:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1110110E1CB;
	Sat, 25 Apr 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILN9yDMw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2ZROIvZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1F010E49E
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PLe2rA1392432
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=janQVdjbdXtAjA0DFdCMJpfH
 QpM66VqlFeO9eJvVBI4=; b=ILN9yDMwF8wUHsCGp+pNUzVbMv3oTD4SDxW+tjqD
 miakJ6elDDagBjyVKs5AFTUHXMZ1IibLBC6FLk12oRLzVYA/e6BvgEfZoV4p0qpn
 lhVeZBstYy2o0aKc9TUWX4him591jM5FBzhwo2V5E8zw1xyCd6cNJbGJpfwqTTRk
 tF5+OqpUfzH7Vc0yCdBEd2q9EzfJWl+NiS8wao84FYZyodrjnyssHkfwucbzWpWD
 7ZXZT3uCCxHBa9d6iVv8MWNPD9b0YCC9Q+a5M9vY3yWdTYTKftyfz5cMWkRTwW7B
 r7OXUbC436wUrvi+3i7EIiWmKBlXrveIOwtC0hNB1I+DvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrhqnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so239645691cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2026 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777153609; x=1777758409;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=janQVdjbdXtAjA0DFdCMJpfHQpM66VqlFeO9eJvVBI4=;
 b=M2ZROIvZxLNV+P/tw++AtrtSGruHJuUjy4SNMTz9r9HDhNKc/36RvwBnWVwT9xCxNt
 mNzPXWOsvxIi0HQH5B/r+M42FI2fryExvXnZz272DX6gbWRdOQm5OMqqA7nRaHHC9o7w
 tTAXloQroIeM4l6MCsn4MnJuF8nYNoQgYWA5SpaR3VO50rCs0aWUK0n8K1BBaF0xfZkQ
 R5sbjOkkknIb/tjiOAYJpstmkndym4sNu7v4837r76AqO8SsAj3p4V9FMwwy+6MoUo+k
 69SEjr1Ji/I4a0D3dYMqbarkyDSowQXcJs11LgP/ccWKuGStVndwLvXxxxlnbmIgTVf2
 rIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777153609; x=1777758409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=janQVdjbdXtAjA0DFdCMJpfHQpM66VqlFeO9eJvVBI4=;
 b=IwGeEQJ3Szo+lXmDKjXIG+n6+yB7/OU1C3sBQTGSOSKgyh60thx4WlXKAEgSkzpkmH
 QLzxGIGdB2vHV8w0AqMkTtdqPhdy0+peDBBgkFjVFklSkV4NRfT28ef7CkvAvFnNU0xT
 wvHQmXbevaGUe3SGRwy5zwDNPM9cB7Jc7g0h9yqutVTtICxvEt6vs72IXSik4YUyIB2p
 XB+miX2AQcOGg2UZOcFE7SYlGZs/5JzCmpLaV3vR6Sfy3vh3hEk7Hr18+W3EYPtBGlr7
 L3RXe/earXX91/F0EH6h13aMWWofgFBpZd2a12fwPtJelSSJxy1iAhat/QDwaHmCye79
 kedA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M2E+2GmisnSRJAcQB1OgnvGr0JHGzM5HZvpvvvFNtz3yBiecew0kQ+rh/Yo7GCj02TkQ6KCjX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweodiploC10Vp0w9jmKKHCyf8GLoToVA1DDnJE5pa/RrQ0a/ax
 +0pezTZPwt+r79QiU7hv4yzxx8kxmFYB1p6nTkBE+NQwAgRKRpz4IHi4H5B6py93wxzRzKMegbd
 EZLr1yLITnzrYjvPZlL0yg5A98K/M585Xvp4Iko+GHOvoxlCTznBCIN9yjwNu7iKQ8xd2
X-Gm-Gg: AeBDietihC5/VhxnoKhMorCS6Otr4J8ukqzNrAiURYxrFroB1sG693+G2Y6gj+kzMB5
 aLW7A57qtChOdAS31kCoQUHAcr55VO5nNv3de41Bu8boku2cLNma/snaNo12lU/ZrxGoXzyOjco
 +ukNtdN3m6OE2C5gM2c1Zez2zgm4SGJS95jKt4E2KxPueaPzJ3lsrTOCqWO60qbqs/WNtSn/nou
 O9wnhiyRpGVUyd1pToyU8W2FVTzdspAMBZMKK2yeyGffV6hpBbAPqPyUj4U0hLWQPDlOzQPw9iH
 1GAn4hVvtjkdXP5Df5sULOME5CC/uCioEUyrGBqH3EHwVd+Vqnvsd9t2WaiIyZ2BWjDAxppIBZy
 ZTcyKXjx/pCxiDqOGhRaX//hgKjCEvU2L4Q+wBxn2BF0kv3n31WVRSHXfKPLNXtRtivKARUXl8V
 uYpFsZQwDLgGvA71LwqMNFwhMmfKxDhWRkdBZsn7GoU1Y3Vw==
X-Received: by 2002:ac8:7d4a:0:b0:50f:aeaf:b127 with SMTP id
 d75a77b69052e-50faeafc0a0mr353887181cf.53.1777153609566; 
 Sat, 25 Apr 2026 14:46:49 -0700 (PDT)
X-Received: by 2002:ac8:7d4a:0:b0:50f:aeaf:b127 with SMTP id
 d75a77b69052e-50faeafc0a0mr353887021cf.53.1777153609140; 
 Sat, 25 Apr 2026 14:46:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41a238563sm6801345e87.55.2026.04.25.14.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 14:46:46 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:46:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 3/8] drm: link connectors to backlight devices
Message-ID: <ngcy43m43k2e7wfvngmpdlefwr4i6l7z2ipk2p6frtd4itpxbi@yvod57mmsxdq>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-4-mario.limonciello@amd.com>
 <k632yfxvm4od52pnnbclclffo4l73c3ztwysrwnkp5lfgpddfq@4ddwbap7o7vt>
 <bec9ab80-cbb5-4e2f-afcc-e20221a365a2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec9ab80-cbb5-4e2f-afcc-e20221a365a2@amd.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDIyNyBTYWx0ZWRfX/tfPg5CDGF9s
 VcTkVI1wQ+yTFLZmjM47bM5P1xt8hIClvepLabM5MY74EoSOLSaKNjTWzTY1HPNZf8qGjya9y5O
 tVdW+/+uzJEnM1DH1nSEFphQMl7s1zrt7ib9kUct0OQHzuCq9HGz9Hpn8EMyCMbUDXfowgLjl4F
 yyCPFvOVRmo1y3O5qww3lT/rVzyaYbbQkZJc/wvDmEMAJhrD0/85GeuyEKA+DoKqW4TywBG585k
 xkaUc4tqg02QNhwZqpDJPkEGGHjpCVGhyvWcMAqS/UMr/BVjxcgPDcx1TjiWQqTuA7hDEJlno99
 0HcA+Waq4b5zyJ8WCjKpEfMkmR1bnhvoatGtQ5RsFb4Wxbc1qm7k8I1WZdJOOrnnZDTkA1s4s2Q
 NTKql5GO+jwwA/7s2u3vRN/8CZjxCla7PBLFNreX98+fcKOQPv4J17QMEU17ExFbbpRKzhVkTZX
 dobo5d7foYMOaST1/5Q==
X-Proofpoint-ORIG-GUID: ncNvH3g8bn-T_YLT7SGTyLyyobglMDLl
X-Proofpoint-GUID: ncNvH3g8bn-T_YLT7SGTyLyyobglMDLl
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ed364a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=zd2uoN0lAAAA:8
 a=tMRYVEbYVSoKfAMIh7oA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250227
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

On Sat, Apr 25, 2026 at 09:40:50AM -0500, Mario Limonciello wrote:
> 
> 
> On 4/25/26 07:41, Dmitry Baryshkov wrote:
> > On Fri, Apr 24, 2026 at 05:09:48PM -0500, Mario Limonciello wrote:
> > > This adds generic backlight-device support to DRM connectors. Drivers
> > > that need to link backlight devices to DRM connectors can use the new
> > > helpers to create a backlight property and link them at runtime.
> > > 
> > > Also add a brightness changed notification so that sysfs and DRM connector
> > > can stay in sync and handle property updates around DPMS.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/Kconfig             |   1 +
> > >   drivers/gpu/drm/Makefile            |   2 +
> > >   drivers/gpu/drm/drm_backlight.c     | 406 ++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/drm_connector.c     |  12 +
> > >   drivers/gpu/drm/drm_drv.c           |   8 +
> > >   drivers/gpu/drm/drm_mode_config.c   |   7 +
> > >   drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
> > >   drivers/gpu/drm/drm_sysfs.c         |  54 ++++
> > >   drivers/video/backlight/backlight.c |  17 ++
> > >   include/drm/drm_backlight.h         |  45 +++
> > >   include/drm/drm_connector.h         |   3 +
> > >   include/drm/drm_mode_config.h       |   5 +
> > >   include/linux/backlight.h           |  13 +
> > >   13 files changed, 637 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/gpu/drm/drm_backlight.c
> > >   create mode 100644 include/drm/drm_backlight.h
> > > 
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index 8f5a8d3012e41..8c00f534d50b8 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -17,6 +17,7 @@ menuconfig DRM
> > >   # device and dmabuf fd. Let's make sure that is available for our userspace.
> > >   	select KCMP
> > >   	select VIDEO
> > > +	select BACKLIGHT_CLASS_DEVICE
> > >   	help
> > >   	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
> > >   	  introduced in XFree86 4.0. If you say Y here, you need to select
> > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > > index e97faabcd7830..9912306e94950 100644
> > > --- a/drivers/gpu/drm/Makefile
> > > +++ b/drivers/gpu/drm/Makefile
> > > @@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
> > >   	drm_client_event.o \
> > >   	drm_client_modeset.o \
> > >   	drm_client_sysrq.o
> > > +drm-y += drm_backlight.o
> > > +drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
> > >   drm-$(CONFIG_COMPAT) += drm_ioc32.o
> > >   drm-$(CONFIG_DRM_PANEL) += drm_panel.o
> > >   drm-$(CONFIG_OF) += drm_of.o
> > > diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
> > > new file mode 100644
> > > index 0000000000000..cbc6a855ed332
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/drm_backlight.c
> > > @@ -0,0 +1,406 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * DRM Backlight Helpers
> > > + * Copyright (c) 2014 David Herrmann
> > > + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> > > + */
> > > +
> > > +#include <linux/backlight.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/list.h>
> > > +#include <linux/math64.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <drm/drm_backlight.h>
> > > +#include <drm/drm_connector.h>
> > > +#include <drm/drm_device.h>
> > > +#include <drm/drm_mode_config.h>
> > > +
> > > +/**
> > > + * DOC: Backlight Devices
> > > + *
> > > + * Backlight devices have always been managed as a separate subsystem,
> > > + * independent of DRM. They are usually controlled via separate hardware
> > > + * interfaces than the display controller, so the split works out fine.
> > > + * However, backlight brightness is a property of a display, and thus a
> > > + * property of a DRM connector. We already manage DPMS states via connector
> > > + * properties, so it is natural to keep brightness control at the same place.
> > > + *
> > > + * This DRM backlight interface implements generic backlight properties on
> > > + * connectors. It does not handle any hardware backends but simply forwards
> > > + * the requests to an available and linked backlight device. The links between
> > > + * connectors and backlight devices have to be established by DRM drivers and
> > > + * can be modified by user-space via sysfs (and udev rules). The name of the
> > > + * backlight device can be written to a sysfs attribute called 'backlight'.
> > > + * The device is looked up and linked to the connector (replacing a possible
> > > + * previous backlight device). A 'change' uevent is sent whenever a link is
> > > + * modified.
> > > + *
> > > + * Drivers have to call drm_backlight_alloc() after allocating a connector via
> > > + * drm_connector_init(). This will automatically add a backlight device to the
> > 
> > I'd like to point out another kind of devices which might have been left
> > w/o notice here: the panels. In a plenty of cases the driver creating
> > the drm_connector (frequently through drm_bridge_connector_init())
> > doesn't even know if there is a panel on the other side of the chain or
> > not. Likewise connector creation doesn't involve any panel-related
> > operation. Some panels provide backlight controls. Others don't and rely
> > on the external backlight controls (see drm_panel_of_backlight() for
> > example).
> > 
> > Can we work towards simplifying possible support for DRM backlights to
> > the setups with drm_panel in place?
> 
> But to userspace it would interact with a connector not a panel directly
> right?
> 
> So doesn't the current design work well enough for this?  When there is a
> panel backlight control it could be added; and if there isn't just do
> nothing.

No, I wrote in the other email, why. 

> 
> > 
> > > + * given connector. No hardware device is linked to the connector by default.
> > > + * Drivers can set up a default device via drm_backlight_set_name(), but are
> > > + * free to leave it empty. User-space will then have to set up the link.
> > 
> > This sounds like a definite no-go. Think about any phone or any laptop.
> > Do we need to involve userspace to let the kernel know that there is a
> > connection between the DRM connector and the backlight present in the
> > system?
> > 
> > What is the usescase for having dynamic connector<->link connections?
> > 
> 
> Allowing userspace to setup the link was something in the original series by
> David and Marta that I left in place.  I don't have a problem with dropping
> that concept and requiring the driver to do the linking.

Well, I don't want to loose something actually useful. That's why I'm
trying to understand the usecase.

-- 
With best wishes
Dmitry
