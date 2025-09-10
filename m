Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1ECA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 19:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EDF10E9CA;
	Wed, 10 Sep 2025 19:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4C4B47D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15DC10E9C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:42:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgDOk029730
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AshvdUVEa9FiNe5UYmEu3NEb
 RFgCfkbR3d/lUj1X4cc=; b=M4C4B47DFelWfTtHXBl58OlfAnb9kgVzh2KD5MDP
 u21jR0DMliki4JJ9sbq0tg/a+i93jCDeMlXDMvHLvtf7lP6zdaXEhxxR40DF68h+
 rU/qxdJlK0+ZmRfhw4E6cF67By/Tr+FieX8DVNFtWhOFAWxwvGr5eR1s72BMLocK
 /g2sryaJrEckcY4rJKMHckuG4bRdtmZmv+k7ig0la9HsVvpcCZ4RXA1kAkttl361
 6ckX43sYScEE63NUml41VV+UYRTAp8Z6clD8qHBQqabTgKjKw1MHHCSsIvDTZ3y4
 RhcJ4PBDMquA6XnTAn+tQ4uLj2dtQHl0xxkg7UDOFdLxag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapnc09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:42:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b5eb7b2c05so427431cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 12:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757533374; x=1758138174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AshvdUVEa9FiNe5UYmEu3NEbRFgCfkbR3d/lUj1X4cc=;
 b=mWUei5eNMnhV9U8Eh48KDYqFzl5h+wZv+EmNzpMgLwr2LUs2MGdbEZ27+mMcHbyMvN
 CeB0YVPaMaEnGakMpg4q7/ZPpHjkccnkz79LsUyd6oFWVJ3o/Y7LBMYZ4XrM47LZpvem
 fkhUbjqYDmdqtIgRhXZ7qbRdoZ/MFOSD5YFbivf8XcvjyQBTyaC4lKAC9+nq7qJ4XzBL
 4JbCdmXPPpZ7TqPdjSZ7ow3rhurQkQoBkuPBeknQt+4ojnrEGYIj/kx4/G06IlaHpCJk
 XiVapnWILWS3VTsiA268pCoFyxcXP0c241n5YdZ9J2wNbu9x5cnyh/ZG3e2XwC5b6VpV
 mY2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvyZ9D1kCnzTY87HM1j0P8VihFLEKCk1gnYFmwNCqnZ4DhH3Ai1vNruxeYW1KStWtRxZH51UMu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz+ylNx0jX4DCYZynMgtl6/SlyGwQ3MlrFiUvN459etmOcI6xO
 Fa4qihKTANQP/INNvIfaLO4vmaKCqgl5tz6xba5/7abW8q/Qzo7GsIQwFT7oANkmd32+4WDSIQ9
 UTMcPY5vwrwSH34TCCGRFXPNO7S+P7MrQtKRi2mLUqgWuRCyAFXGaFwzsCgjNuvdsTMtT
X-Gm-Gg: ASbGnctWQjen2AC1XnT1O0pdDyyFN0XAQolg3KZw4AZb5UhkRc2aMOuztMtUcNqM+gC
 iITgOEs3GNSRKIXQH9FZbbr6ZrlS2otkmYppRdcciFoYa1ICK4G+bloGm1Dmz9qgOheLYKXXPvX
 VHJfKbvCWz0wbQH5+z+uXS6zrE802fZmpja8HvO8ZuIp2UaSbMxA8mZCqsqd2B20IyKHMbyNgY3
 fNzDwwfJ83M/bHicxOdVWpAiTyd/CuY3+KaDyFpoF+aKc2fSNvAnXK57LnlzoHnS7Il2bqlpTe1
 PQow763gWrCD/4IvhxOj8eWn5Qs6QA32AkukgCa/hKxQgFY0wBEcDk1TTE/pDXEFolYvSA2a8bP
 pa2SU/pz6YQROePD4GyBchEED57wCKmsalPRNBKyNzb2i5zDrJu5d
X-Received: by 2002:a05:622a:1904:b0:4b2:8ac4:ef85 with SMTP id
 d75a77b69052e-4b5f84bdc04mr172828751cf.84.1757533373905; 
 Wed, 10 Sep 2025 12:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4LM5n6q3x7O/nMFCbv+KTdGAJSRvFARvfiNuJedE701eBLHhZVYWWeXkwyAfYeYOBgycy0w==
X-Received: by 2002:a05:622a:1904:b0:4b2:8ac4:ef85 with SMTP id
 d75a77b69052e-4b5f84bdc04mr172828411cf.84.1757533373376; 
 Wed, 10 Sep 2025 12:42:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-56dbfb5d10fsm49073e87.108.2025.09.10.12.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:42:52 -0700 (PDT)
Date: Wed, 10 Sep 2025 22:42:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
 arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
 harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, tzimmermann@suse.de,
 jessica.zhang@oss.qualcomm.com, sean@poorly.run,
 marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [PATCH 1/7] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <curkiddhkz6k4rtbxxmmmm4oqyjzvda3xc2bc5c6dmq2c5qgkk@z6cwzap2hwgy>
References: <20250909100649.1509696-1-suraj.kandpal@intel.com>
 <20250909100649.1509696-2-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909100649.1509696-2-suraj.kandpal@intel.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c1d4be cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QyXUC8HyAAAA:8 a=ht3OSqXAj6RBLq6GiRYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: CBqjEOiCTTXkiWSKDlUEvICnK2E1Ouuo
X-Proofpoint-ORIG-GUID: CBqjEOiCTTXkiWSKDlUEvICnK2E1Ouuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX00PVJLbzkHol
 5HY3nP/hQsbGz4p23kU2w5LVO+WtTrkoDvMDszpK5vjxB5aohJKXE/tJZkeI88fnAmUeoxlVsp6
 wzrAocQEmwcGe3pnM1yK+dW5EqkjffcRVWDKpSdQaMwTeoE05Gbi4XfGo27/MKH/p4GzTwxUQYs
 XowuprqkdMw33Ui/05yE8dm/BJYJuXLb8FA3UPhem0ls6+3fixF297keBgwk5rL00YIrs0fjZ+a
 Ckl72wvkRdoZ5rMf2FLWQ1DsinHksQiEqSUP23uaP2KLcvSBZJ7AQhI96rHv2qe7cTM3b+heq+y
 rHP/zOctYFPavQPjfiXJOqWCWpr/PSTMJu5BbUVZ1OPyT3oFM7Ve4z/LzxFyAtFkV9Wov88SYQf
 ZxHcYmg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000
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

On Tue, Sep 09, 2025 at 03:36:43PM +0530, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as Intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not,
> this is due to the limitation of inheritance in C.
> To solve this we move the drm_writeback_connector within the

Please take a look at Documentation/process/submitting-patches.rst:
s/we //g, etc.

> drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. We also make this drm_writeback_connector
> a union with hdmi connector to save memory and since a connector can
> never be both writeback and hdmi it should serve us well.
> We do all other requireda modifications that come with these changes
> along with addition of new function which returns the drm_connector
> when drm_writeback_connector is present.
> We also modify drivers using the drm_writeback_connector to
> allow them to use this connector without breaking them.
> The drivers modified here are amd, komeda, mali, vc4, vkms,
> rcar_du, msm
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  8 +--
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  6 +-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
>  .../arm/display/komeda/komeda_wb_connector.c  |  8 +--
>  drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>  drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
>  drivers/gpu/drm/arm/malidp_hw.c               |  6 +-
>  drivers/gpu/drm/arm/malidp_mw.c               |  8 +--
>  drivers/gpu/drm/drm_writeback.c               | 33 ++++++---
>  .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 16 +++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
>  .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  4 +-
>  .../drm/renesas/rcar-du/rcar_du_writeback.c   | 19 ++---
>  drivers/gpu/drm/vc4/vc4_txp.c                 | 14 ++--
>  drivers/gpu/drm/vkms/vkms_composer.c          |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c         | 13 ++--
>  include/drm/drm_connector.h                   | 70 +++++++++++++++++--
>  include/drm/drm_writeback.h                   | 68 ++----------------
>  22 files changed, 163 insertions(+), 137 deletions(-)
> 
> @@ -2305,6 +2366,7 @@ struct drm_connector {
>  	 * @cec: CEC-related data.
>  	 */
>  	struct drm_connector_cec cec;
> +

Probably a refactoring leftover.

>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)

-- 
With best wishes
Dmitry
