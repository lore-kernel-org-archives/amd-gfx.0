Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A165D58CCE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986B910E368;
	Mon, 23 Mar 2026 04:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkB7ye1A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJ+CdmxD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FD210E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MITpo42104697
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FkOlnsc0EKvOIhkAtLnyw5lm
 SHO8rtw4V09fAITZLBs=; b=mkB7ye1ABcjRkiyURKA6wmiG8gu2qAXGJgZYQfvJ
 ys04tLxs4TicdQbJAnSx1QrGvOI/bS2qSouJw9b59PiEeMYFbBx6awIaPGFioOKH
 D9Fm4SNw7zNoaoz8bw5lDksOz0792gDPV4/hn/T+vmnCG0D+bdzNAv6vuNTo3Gfy
 yXK5x0dNxWoEOd+3l/QpN5OURspZ4R4/RJ7PIwIANXfMBzg8WXBs2kgWI5kPb8Cu
 Vgfxb9to87kSFRUIRwSqEE0/abOf7aYutz0S3EmGAEXZcKD/vhcAdUqinQ6hvxZP
 vzfZgAMXEsfq/dl1rJPcbYykgUoGgjt7H6UH3mx6Aq2Trw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5krmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso180228091cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238838; x=1774843638;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FkOlnsc0EKvOIhkAtLnyw5lmSHO8rtw4V09fAITZLBs=;
 b=LJ+CdmxDHk6JfdgDQbKAEHbwXAuWKzgtk5kMju2dWGHFObuQAYHHG/8vh+47edHS34
 DQ74eqaLThre+euqrDc4QdK5kayZTToKuQk+O/iZxfBiPIvKlR+k0A7JBBtawlTBLQmZ
 Fprz78VbIp4WkAS6rS1AyiTZptplrKo+/PVhiA/uLaRL9wJAC/fsgrGbOZFJXfp76Cgu
 BogB7jN+OkYVQgDqafswCIuK5JmTML8/Uflg2Yh2vKUXNgQE0YSkaQ4k22kBuKrmrgVi
 Pu/0N+IrWzrmaG+oo5Zsjtf9ts0PDIXh5v8dVN4uNjoGMX00JnRhAB29y6J9W61Jnle7
 gAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238838; x=1774843638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkOlnsc0EKvOIhkAtLnyw5lmSHO8rtw4V09fAITZLBs=;
 b=Hi+EzOw3dMqZ2DLDxT/Q4XSDj392Yi0zJDmuKIOkIhcESXPBM+0VBkVsiBbHyM2DXY
 OG0h2pCFMhs37Cr0ZgW0thQMQd/lph6nL3iZ8/9EL8wW8vgfSc3arLvcEBdjFhWsMPY5
 PjKU/l7OrTFWerwteXwM3ZUJay0JD4Th8ot3ydqzanhDT7x0ov/HfGoNrdjYAv3ebhrf
 UB9KRl+QJ97ZUT17MPUxfzZRXd5tPx0rYNQ+JOp7k+GvPufB8NRz7NWM5Rj8ZK/qbcqV
 BomOCBhdK9ASRpgzYrSBEBP7nlt0LZZpTSyBXdz08e2/Py7/bGICt0+1Mn5K9yYu7amp
 9mmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEwRXxAbiYjlgPOcO0Ver+y+/qXmuPymPPTYQYTtpIQVPJ6T4xtF/VdFv0uDw4Q3VVE4Eniqqb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymPNk+05Wjsodov8y8ZgK/rNoZ3vX47l4wEloxDE5VkufhDxFm
 jKvSdx9fEHOiqbkYunmINNeR398bLb/hpc3TftoWvZTZkQWDLrpdFhxMGPGnq2EM7jyD4xZfGbp
 mL2E+3lCJmPRuyKErSgyYFQ+/hhopB5fvv5ka2XXbPKbyLwI8jvFjluXeT2pjEPAd9t/k
X-Gm-Gg: ATEYQzwxw7THZB3gTqQahFWr+ey3sgc2pCskyD10le+ekRlCqzkNS1e7wGcZmEE3KPO
 Tg3WJbcHaxp/o+XYq1x0A5aJtA+TbKWtKT5mSsRYmwhH7Fryr3wVzi0OPxWdWm+JS9QFGF6pW+s
 kmaLeEJqZBQhbhAAUw75ostwnRay4YhUmKCs0W+Z6yZorl+2KaxbLZPP08eAZ7fax7KScHbLVDl
 POxVB0sOqjBl8nR8t1cL1KFc5mV5Fe9Kj57M3a9OqNhJjDBHt+c5NDhUc46mv6Wdqfj7s+voQ+/
 gVnAd+s2zKwCAQTe/TOhdTYk18IUB0AfKi4lUINTWbnDmPvUQRuTGxvPmAjQ0wkfymQv1yIF79t
 +TVW9Im2ioCi/4XQ031siiMl0UtFfibNFceGuEE63NXhRk29IQqsmlQlakF0wy+DpdK0jT1ZIbe
 VprbkliLPKQQu965NplV37yY00xqvULCOUwuI=
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr84026471cf.62.1774238838049; 
 Sun, 22 Mar 2026 21:07:18 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr84026151cf.62.1774238837540; 
 Sun, 22 Mar 2026 21:07:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9ac2661sm22658351fa.39.2026.03.22.21.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:16 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 01/14] drm/connector: Introduce
 drm_output_color_format enum
Message-ID: <mvur5pb6jjbvssdhvbzoekfy7hq4h5vketlzembwb2l6fgt63i@a5f43tecwecr>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-1-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-1-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c0bc76 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Myhj0e63kkGcRKXW9oMA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Unm3QIeNyTAqnUvEyNz7DWZME-osP5TL
X-Proofpoint-ORIG-GUID: Unm3QIeNyTAqnUvEyNz7DWZME-osP5TL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX5uFmZn+7dZHF
 8Qp1tc25tsxzC7oWLMe50WT2XyxUEvGWpC8wZKGHG6KcdyH4sRxRauxX2Bi6dfmGc1rb/yHhj1G
 dlG5PFhxCOXmdmThYWLVUTVBr15grr1TrXrEkk75sClUdx2HwqcLIKL/cyxUEPo1+s8gT4i1dFa
 pAeOa+NWYYUj8kR8R4Ym4iRZvftpH4XeUuIlibvDyukhaNbOs5TNWoNsh/enIeumtrBeEWdIPNk
 iszvG3jgGV9+oX//GOpg3O3eIuxhCdOFuVL5h/Ft1qXD3Lo3ZjWqrQWPRh4Wn0fIj2GG8ujPAID
 hcjEk+sk1PzK4neTyKnRrkzAMCIF3mUR372O1/4UFIXfpoDWjFuLLYIzKMORnN4mTW84VwnJanO
 siOVrRttRFtz5r4vccsvBJIcTp2dCBcPA0j9MRib5lt+wJImV0oPEfOHgi1cV+hXxE93oHt0QPh
 nhHFZx3GQMz5y5G/NZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:53AM +0100, Maxime Ripard wrote:
> The EDID parsing code initially introduced the DRM_COLOR_FORMAT_*
> defines to represent the sink capabilities. Since a given sink could
> support multiple formats, it was first defined as a bitmask.
> 
> However, the core and drivers have since leveraged those defines to
> represent both the supported formats but also the current format being
> used.
> 
> Considering the latter case, the more natural, and consistent, thing to
> do would be to create an enum of all the possible formats, and then list
> the supported formats using a bitmask of the individual enum values.
> 
> Let's create a new enum following that pattern, drm_output_color_format,
> while maintaining the DRM_COLOR_FORMAT_* compatibility to make the
> transition easier.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_connector.h | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
