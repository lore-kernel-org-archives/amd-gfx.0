Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A88CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BFC10E512;
	Wed,  6 May 2026 07:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7qXeu7S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6jhPCTP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2127010EC26
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 21:50:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645KSJZB3187751
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 21:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=; b=m7
 qXeu7SooJdrbzx+ez3ztpKc8cu4TsY67cSrZycclEIrhwsW0CPKHbigfETGzDAPo
 tDqs6F0tR7ATCG+ZsPLPnFrmhwwUQ/ifgBs/SMVU2SUCt1oT+iq91dPTztQBzWZv
 JR3GwgS4ydL6REZZuzArZCL4ngfEDkhvxYDX/IRdqIHX8xdU9Ew/yhHUcUE4gK/4
 mx2taIugSHfLnsEH9EFhiShR8bnIVERJvLpIUpS6QKzBTrep28ncwwO6kesUM+sa
 6bdttxzy5hSDRCGFKJheAH2SKwfus8FipmeSM3biuol0d3GkT9OdoAe5U4gU3Fta
 mFB81t83iwxS1HHbUXLw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkbetv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 21:50:00 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-479d900d222so10559643b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778017799; cv=none;
 d=google.com; s=arc-20240605;
 b=PBBtry8AwQF602xb9e3rAM9C4uBonIeDog35Zc6zPLV7geeJK/GcDecwnccA3CSy1y
 WxhPLgbHwlNxv3UuBs6A0qz8sY2Y3WO/UM5Tr63oXh/F3GdYEq5agW8KfSHGY7qNI5TW
 l+t39DOc8RC2gen2WiOkVnn9QPiIL/Q5rQP4Dxa+O/+o7yW3OS7RRbt93yI1KodHySY0
 8U7SH5WGBJFSrD0/FrK70Lv/Eg9ul2gJ1SrG0W07GzDa2JZ3KXgpmRmtBUIIBomnS1lt
 wpHIZHOn1jqtbbTTIcCwcUSkFxX8pmpB4KaIMGsll24MFQlSVhMBapCLPUdtKfKi9k37
 FIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 fh=mgXOnsvd+mAaplSU8oSmez4REFvb7L4dTsQeVzjjlXc=;
 b=JqBElLKYXWBd7Z4RQKjFiSIJRIvdliAvNqzhf1gzqCrmmn8WeYectPn33lGSmWZsMq
 2qqyH+QX6ParhD24vcTFeoiy3PV0qQyCzqZsNxwaLQlRV2RJ3DuVJctrANqe/2U7551m
 8oGGhFsfQNYg+l+TlgYq/hO69603sfZTIgjAfme4NFavCuB4xIWlADxCoXXvVKyHOKv0
 Vmefhmd//ZEjKmCXeUwFXLG/vvW6fR6lOqKCKih5vTLTnliRaWlcKpWG7inXWR02IWdS
 z/ePdFtHUk6iD7iAx8A8iwjwCvX4VdQ+S9MKM8MSq02Ly1IelaNzxp2oCTwBZXJMIgT0
 2lyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778017799; x=1778622599;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 b=h6jhPCTPnK+b0FiHhBGN4KzdEWvUeET2IhzYdIMkLzyeKqu3Ad9zeYoXQtbQzg36bT
 lEUaPP2/0LOZ05HBTBL2wHaKaalOJ4Ha1Uz8qivEiEBckdFT+TdgGQ1GRiSfSiLMUxRN
 w9th+2YfHad9gD6P10vX/nkPiUDyqZ+oqYXfeejdVHQ8C0+eNFzqg+92aXdDMu4n4kvs
 VT5w4mVpyWtkXhFkK7JYQjhs50HbiOhx5gQcx4nbt6S/Sco9bBvFgXAQnkC0qFOM+58y
 TDkr1ftn0daqAzYKd58CdSXr0tdv0iAyt817phHhc+vFDMseeoMqoXtZKK5AZ7ONeTbZ
 XNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778017799; x=1778622599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWoubTXPQdVwM4tS4Rj7Dbfl7e/Ff9zwszps/EZhuKk=;
 b=XrCazRe4Rf+3ZM9S7tWyNPXqQJwtFowI5kakIBWxRgB0VLhb98FPH3hXE/nUcSkybw
 qhix8d07UIzxV6XLen49OcCWjRF7CEviYGtOJ2tB2RLbzXb4dlCdF4dWT22rBqaQqd6p
 0YHTyJhEcPeCaVB34eOc9fYWD3zFLk1scslA4GbZGTAva28wYudU7zCyphHqhlYokoUA
 aMyefE47Ae6Rhihi6/bWrE/+a2C+uOxtJGS6vBqsUHWItHW8kj//CgMH8rYgAYRAy+zv
 XRjGPaJXVREi1Z39bsyRK7GRuBjrCS1P7rZ4G0hQt9vmH5/p/nupJIBZ+EJ3K50qlkci
 C2Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/QhrzI2bMyUTHvc+EIQZOJXbJfONa/GEPGhkor4RtsVYhIcKZtX/OEOn5YPY7Q+/tNJoHaPqO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynSHuc/QewjklaYPT2x3+ungmUwXtWa//HEmKS0QJfngeC8W/j
 LvhWMSbm/XgLDgKBpa2HQEmXFzK3idMl8kmrMTkIENFm9KyrP+myeFiSmzhHozBragteTMHF4Pt
 mEiBbJr6IS/4LzWC+5oUI1rt6VpgyTmwvwhyLudWGf3s0nFr/ip2nWJgun/Bc3FdCB9Z9TCSPb+
 V2Wh5gi5HStM9FB2LzhtR+J+qSiaJTXxnHo/mQUFsjuQ8=
X-Gm-Gg: AeBDiesWQZ4g1vPTCoN8q6u09o04noqho0pEvym39UzJf6ixlCBFK82azsBEtBbYZoZ
 +SeGhjMExQKcsrzySX2z9veHzHPioYSCxBEwPO9Csv+GLEYsrOI6X7KfjJQY9M+GOzsKfVc+TEv
 8e4mF7I44dIuYcuSDfOBLaM4CkduIeyB9ayGArLwvUNJ5Km/NgEZCPwyqJmWkpnbXkmkG43NZ6n
 KCwy1TUXdE9Dkckz9xdXapiK0DUS/VrLfkLFNF5yJM2Q2gI
X-Received: by 2002:a05:6808:d52:b0:467:9ca:4b8a with SMTP id
 5614622812f47-4804221828cmr643107b6e.11.1778017799383; 
 Tue, 05 May 2026 14:49:59 -0700 (PDT)
X-Received: by 2002:a05:6808:d52:b0:467:9ca:4b8a with SMTP id
 5614622812f47-4804221828cmr643081b6e.11.1778017798961; Tue, 05 May 2026
 14:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 5 May 2026 14:49:47 -0700
X-Gm-Features: AVHnY4LH0uDMjgYOgFKujr3D57r6UVTyvfwJmoAF1iOOVmgpBbGDoiGs-TovmEk
Message-ID: <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIxMiBTYWx0ZWRfX83vj3B4ufpR1
 6zxBe6ZZeYIJbQnCXWJhj/GCYW1jWNZ75LOTChOBxHUbKD+nCEEchoAVLqkDS+3KQ/6bzfHPgNr
 HRf7gV7sy7A0x2uShDm42Rf58XjVjCy3CemyrKpKQdcJDyLEIeIoUQ1DCE702M0WddgGdxqDqNv
 a6F8KPv2zf2pm+UN6xjsxmMYy7CImNFFJnL59XfOj8uZEnwN/MFJ1VSQEcclsVDgP1IYaXo9RqU
 ZtNZU3vftjg2bll178MHoKSZkKUZOOFFRIi4ou8/xqqKIUlxejd0bWlF8ANz1HuQdQIZh2zz4iR
 c9sBstxWiMExZlxW+7h5uFwlg1W1Bz/PeiW8vjKwD8KmAVo+mQ/wOFj8zRndeE2XBkxTVFH5cmC
 IFJy/97ZVdJjZonnlJxNjtXxVTHYscAZsHoKdZthEU/4HJBHPg5lrqYgHI4HiMgrTMCzxOGeWI6
 RaJlIGqS/9YD9Re1ZGA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa6608 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lAOjoZoF1AEScRdHVYcA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 2_p5BBZveOLkVOqTM0HslSN1tlG_seem
X-Proofpoint-ORIG-GUID: 2_p5BBZveOLkVOqTM0HslSN1tlG_seem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050212
X-Mailman-Approved-At: Wed, 06 May 2026 07:50:24 +0000
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 4, 2026 at 5:25=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Mixing devm and drmm functions will result in a use-after-free on msm
> driver teardown if userspace keeps a reference on the drm device:
> The WB connector data will be destroyed because of the use of
> devm_kzalloc()), while the usersoace still can try interacting with the
> WB connector (which uses drmm_ functions).
>
> Change dpu_writeback_init() to use drmm_.

From [1] it doesn't sound like userspace holding the drm device open
is the issue (if that were possible, it seems like it would go badly),
but rather the order of managed cleanup?

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3D3a13c2de442d6bfaef9c102cd1092e6c=
ae22b753

> Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wa=
nadoo.fr
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_writeback.c
> index 7545c0293efb..6f2370c9dd98 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -5,6 +5,7 @@
>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_framebuffer.h>
> +#include <drm/drm_managed.h>
>
>  #include "dpu_writeback.h"
>
> @@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct=
 drm_encoder *enc,
>         struct dpu_wb_connector *dpu_wb_conn;
>         int rc =3D 0;
>
> -       dpu_wb_conn =3D devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_=
KERNEL);
> +       dpu_wb_conn =3D drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNE=
L);
>         if (!dpu_wb_conn)
>                 return -ENOMEM;
>
>
> --
> 2.47.3
>
