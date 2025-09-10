Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5FBCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 15:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221E310E94E;
	Wed, 10 Sep 2025 15:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2pY150G";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F9E10E94D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 15:32:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgMcF021304
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 15:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +lQ+oYNt3WeGVVFIvjUy2y179TQJ656VsJ9sQPc6/zk=; b=M2pY150GjX/MSr10
 fpKXKUJ2RfzoEJUzI0bN215ZKEEThP+l6mwDM2zm4KRQmk0tajMRxKFtVQOaFNeq
 E7S8iEMvI4FtNwQiFT+CI4qUA0Qp70FydLHo59IBo9hCSbW7S2G/ZG9No3ZHTexz
 y/e7UlJfecgIM2DI9nHCN+gNW6VlNXVr4DggN8GHi+dk5KxgsoGLS/OAjNpAv5K7
 1MneM6hxiK+mZqJ0qBuJtZD5RMnfTA/aKXNcf+hfB94psLdYHFTOW2iqvZfTuZXv
 4Ty7jAkSyYixwaW+Eayn5GyxoFe350q/obHdJKocIJkKCv1d1i0wfkq1DcIhRKEb
 X0KmtQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by949ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 15:32:08 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-544a6eca14cso3726920e0c.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757518327; x=1758123127;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+lQ+oYNt3WeGVVFIvjUy2y179TQJ656VsJ9sQPc6/zk=;
 b=DmsIXs2QgLM0R3yvz24vUhXlw/pFJshf6dX0H2NiuW8XG9WLNrJ7p0kZPfgPxtLFSp
 APXzk2B0GlcJWYl6nPV8XZ+TwCx3MjoLHxhR6MGDVGwN+3leY6Acb/z9kqfnJj+t51Fo
 pmYICEtN01I3yH/6wwH+SPTdpRCHz1j4/PeA+vEDDdJvmCTries3i0lpWxLH8Wu9Eu92
 U40ULKYN/6pRkAZIFXeyk2fSx4s/ar7nSnDmd76SyOx7mFKaPcaudWg9c8U8eEJKbJuD
 UDUftWOMomx/EQqbdzk3e1EZyUysvQ53Vx8wtAGktJWuLUePMWeTIQEaEbUABKnOk0vE
 +uzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUM2EH2+EVb8rnfi+wgZXUSwk86AKwJeuAPYtUE/6eOIbBghsvHIoyTCpRALp/Wsajc50Bs/f@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyhvq+jMTMJMhfgIjh98LOkDU3vMtCWe63HwIUiEZ/jlBz/YakU
 h4xe55VYxxDE3yEXB8q5RYwPZWlKUQEhdAbu0ctsSrfYOu/LIFCrQkSFSI/xNAFzNj1MaMqVv87
 3SfqD4GQ2OknojszdXVGQKO5mqw1iHNY5JFS2SawUqkq+FpILXKNJtU9lOsb2s4498nMY
X-Gm-Gg: ASbGncup5ViwwtcgtQlzmcLghSr4UGQfGQQTYAerW6yt8FKhQ7j7z+Rx9wn1FvN4xhW
 EKPLDanXDkLYKrl4WA0Hyu9U8hAeqyn3r5EWKO5FTbzHvs7nG1giX1Yj3YOKX/+s4hGFk+Vqjf9
 8hYBTaKwlSEhLZcTIHgsCTFXofEijqRY6vAvHcja2cCFkF/DptdJssmgDI6ZZRcxCmHxSuAawqG
 WqMP5z9oWtn3BDgwIL14ESglwk9ydvTK1QnjYmBLmukcW61JVOO4gyvSPzE96EY6SO/CElSq4D6
 /o302TBwqCMUEulQzXM8ayblLcjJfN6STWKh9Io8zwIt0fcXAQ6vqZ3j4PSQ8J4Dhe2Veh0+cqo
 qUJ/oqSMz8toCkMOyWSyNAFlUrv5NhsdOpber7yd5/W5NZiwxWDVb
X-Received: by 2002:a05:6122:250d:b0:543:e955:d5fa with SMTP id
 71dfb90a1353d-5471d655e55mr4220321e0c.0.1757518327109; 
 Wed, 10 Sep 2025 08:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/UH50wdrBGFR5Q3r5dgsOMEP45qmCh9JfN+fdHiiP/fiLQJRmv2nniCeeSVJR551+wmA8jQ==
X-Received: by 2002:a05:6122:250d:b0:543:e955:d5fa with SMTP id
 71dfb90a1353d-5471d655e55mr4220207e0c.0.1757518326248; 
 Wed, 10 Sep 2025 08:32:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-337f50328fcsm44301751fa.40.2025.09.10.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 08:32:04 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:32:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, geert+renesas@glider.be,
 harry.wentland@amd.com, jani.nikula@linux.intel.com,
 jessica.zhang@oss.qualcomm.com, kernel-list@raspberrypi.com,
 kieran.bingham+renesas@ideasonboard.com,
 laurent.pinchart+renesas@ideasonboard.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, liviu.dudau@arm.com,
 louis.chauvet@bootlin.com, lumag@kernel.org,
 maarten.lankhorst@linux.intel.com, magnus.damm@gmail.com,
 marijn.suijten@somainline.org, mcanal@igalia.com, mripard@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, suraj.kandpal@intel.com,
 tomi.valkeinen+renesas@ideasonboard.com, tzimmermann@suse.de
Subject: Re: [PATCH v3 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <elql7sqecqlik7shmgvpgnghgapzp5oe4mf4vlklx4ml6z5664@f5mw6g4fvjff>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
 <20250819-wb-drop-encoder-v3-4-b48a6af7903b@oss.qualcomm.com>
 <78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr>
 <zw23hgjduxgijown52jyiomungxx4cjyv63qixtnx5nbm3w7xb@2yy65777ydnj>
 <654e04e3-d80e-4d34-a1a0-21f66d43875b@wanadoo.fr>
 <75tzn4xg2k2zxdqko4b3xsplbtnolhrxzbowisdqogoo2qhfkl@szr3ar5dg5zd>
 <ae40f623-4cfc-4a49-9eed-affb08efdfd1@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae40f623-4cfc-4a49-9eed-affb08efdfd1@wanadoo.fr>
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68c199f8 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=TSbVqHtbAAAA:8
 a=AbdpToo3CINEX3bgUq4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=tNoRWFLymzeba-QzToBc:22 a=d3PnA9EDa4IxuAV0gXij:22 a=NJcUIoPEKLAEIzHnl83t:22
X-Proofpoint-GUID: G7EcSHV6HBr0NUVrxKLSrk6hNSNO_7pI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX6/J0vdLkA82o
 5EAV7AnabbWyNN3mdDevxPe4sfyuWceinls0IiZdWkTdkHXh9jRAb6FMemxqOpreKVOEaRXFg36
 cyjkp35UU3bU0b6BjbZ79Qdg5W9k+nTQ/No2Jhiq+AfJ+W83XhiF3p8atcVyLaS56igPUzF2RSy
 oJ9gejOE5iuBLubHF3ePvGl7GXjkW/S0hiyWB3PIVJ8ZQO5mT8DAvhNRTBlX7lIJ4zTRoFzolhX
 61fkLF2eMZglc1B0B502GkI9VFw/ZkeL1DAPno2knKrhl1JeElGW1TETAL3EeAqb7ZFhGUJ7Sl4
 DHpysUQnkSYBQ+VnNTd5yyRZAersHfQ3DC3XWgyv+45df6ny/BgeeJ8/gXpLpLTphcEmqeTsx+t
 rOVABPKQ
X-Proofpoint-ORIG-GUID: G7EcSHV6HBr0NUVrxKLSrk6hNSNO_7pI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018
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

On Wed, Sep 10, 2025 at 07:32:51AM +0200, Christophe JAILLET wrote:
> Le 10/09/2025 à 05:47, Dmitry Baryshkov a écrit :
> > On Mon, Sep 08, 2025 at 11:38:44PM +0200, Christophe JAILLET wrote:
> > > Le 08/09/2025 à 23:26, Dmitry Baryshkov a écrit :
> > > > On Mon, Sep 08, 2025 at 11:09:07PM +0200, Christophe JAILLET wrote:
> > > > > Le 19/08/2025 à 22:32, Dmitry Baryshkov a écrit :
> > > > > > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > > > > > drmm_writeback_connector_init() in order to initialize writeback
> > > > > > connector instance.
> > > > > > 
> > > > > > Reviewed-by: Louis Chauvet <louis.chauvet-LDxbnhwyfcJBDgjK7y7TUQ-XMD5yJDbdMReXY1tMh2IBg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > > > Reviewed-by: Suraj Kandpal <suraj.kandpal-ral2JQCrhuEAvxtiuMwx3w-XMD5yJDbdMReXY1tMh2IBg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > > > Reviewed-by: Jessica Zhang <jessica.zhang-5oFBVzJwu8Ry9aJCnZT0Uw-XMD5yJDbdMReXY1tMh2IBg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov-5oFBVzJwu8Ry9aJCnZT0Uw-XMD5yJDbdMReXY1tMh2IBg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > > > ---
> > > > > >     drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +++-------
> > > > > >     1 file changed, 3 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > > > > > index 8ff496082902b1ee713e806140f39b4730ed256a..cd73468e369a93c50303db2a7d4499bcb17be5d1 100644
> > > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > > > > > @@ -80,7 +80,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
> > > > > >     static const struct drm_connector_funcs dpu_wb_conn_funcs = {
> > > > > >     	.reset = drm_atomic_helper_connector_reset,
> > > > > >     	.fill_modes = drm_helper_probe_single_connector_modes,
> > > > > > -	.destroy = drm_connector_cleanup,
> > > > > >     	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > > > >     	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > > > >     };
> > > > > > @@ -131,12 +130,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
> > > > > >     	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
> > > > > > -	/* DPU initializes the encoder and sets it up completely for writeback
> > > > > > -	 * cases and hence should use the new API drm_writeback_connector_init_with_encoder
> > > > > > -	 * to initialize the writeback connector
> > > > > > -	 */
> > > > > > -	rc = drm_writeback_connector_init_with_encoder(dev, &dpu_wb_conn->base, enc,
> > > > > > -			&dpu_wb_conn_funcs, format_list, num_formats);
> > > > > > +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
> > > > > > +					   &dpu_wb_conn_funcs, enc,
> > > > > > +					   format_list, num_formats);
> > > > > >     	if (!rc)
> > > > > >     		dpu_wb_conn->wb_enc = enc;
> > > > > > 
> > > > > 
> > > > > dpu_wb_conn is allocated a few lines above using devm_kzalloc().
> > > > 
> > > > That's a valid point, thanks!
> > > 
> > > I've not analyzed in details all the patches of the serie, but at least
> > > patch 2/8 and 6/8 seems to have the same pattern.
> > 
> > Not quite, 2/8 and 6/8 use drmm_kzalloc(), it is fine to be used with
> > drmm_writeback_connector_init(). This one is indeed incorrect.
> > 
> 
> Hmm, for patch 2/8, I looked at the source, not what was changes by your
> patch... Sorry. :(
> 
> For 6/8, I agree with you.
> 
> For patch 1/8, I think there is a issue too, becasue of [1], IIUC.

There is a different issue then. It's a memory leak inside the AMD
driver (since the memory for WB connector will not be kfree()'d by
anything).

> 
> CJ
> 
> 
> [1]: https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L5257
> 
> > > 
> > > CJ
> > > 
> > > > 
> > > > > 
> > > > > Based on [1], mixing devm_ and drmm_ is not safe and can lead to a uaf.
> > > > > 
> > > > > Is it correct here?
> > > > > If the explanation at [1] is correct, then &dpu_wb_conn->base would point to
> > > > > some released memory, IIUC.
> > > > > 
> > > > > 
> > > > > just my 2c.
> > > > > 
> > > > > CJ
> > > > > 
> > > > > [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753
> > > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry
