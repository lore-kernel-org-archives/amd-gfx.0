Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A119BCD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3602A10F633;
	Fri, 12 Jun 2026 18:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8/dwL95";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UD53rUtU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9925710F633
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGWE8l019985
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RqyQKdmdhFpOP/koc6Y6uz
 FgnHqsPBjbh6L/Tsl5qEo=; b=e8/dwL955m6TukdEDP4m27B5Qjn1QRdzbXTYta
 HuLpRbl7S90126N3pTengdrOoLC9aIljwyDftACxeRNo124E6yzdr/+0ruubn4RK
 6EKofdZKoMvRRy2UMGANkWecXiWYVEQc7JBmJ8/03t3ss2pGInZ1sBf4ckgbk6iy
 qLVy6c/HfsUDwE2BHVgrlsdF9PbM511OtuSvgUaTS4jSh890NRWhesD701hYEep9
 wm28siusWRLvdCh58LyUrASrQVmxvfMRQ0DqtjGPJBtgFbzFgVwrvO1iS0QvZo4l
 2Qc1RaGrTLw8xOWRnEWi/JxM1x8JM45/Mi+NCovRvK70lJfQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbmh0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157f1be083so216146985a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289028; x=1781893828;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RqyQKdmdhFpOP/koc6Y6uzFgnHqsPBjbh6L/Tsl5qEo=;
 b=UD53rUtU702cia3aM8aRU5DebKSpn68pNoQv12CzVckCLuAUQUSg8oZLqf86GEyMEH
 YPAKKjz81mRE7XQRiX9U9BB49yKUX7ediiiBfJ1y/lzyXVc/gq2bmYiVfjTTfQ+dl/9j
 SkIATkbbznkG8GkTvftYj4SrJcZX/EZoBjUAb9iy44RSqVUEs/2Oa6XshtBfNELX4qgz
 Pkb1tasv9Obows44IRI9hKR9jV+iiZOoIbYMD3rlwTdx0iLsTbdtJVUqesR6A1dcmL94
 hkfpf3Sfktd4K5MlXE2eOK950r2Q6Me9LfEftivZi6+I11SKHdDVqYrL60p8TH+BTZ8q
 dLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289028; x=1781893828;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqyQKdmdhFpOP/koc6Y6uzFgnHqsPBjbh6L/Tsl5qEo=;
 b=cQTPrtzqSQIjWKEdMvWjdDHUTmkhyST+trzFf6zB0dtoIRgiwpA2VKd2DsSDSyn7AS
 SiCulrgn9069X9oCv4nwER78C0DNIenbK4aTwApbGpvrOuo8I54qDXq6pPUUHFGVX8me
 oVB8mBGQNwrZ3n7GF47DnaTVoptfr+2rUP9ThOZvvCQsg1Dp6lJghNf5Qe+3T7CVnMJ6
 UutdXztkMd0DPZjmO8ewF7pcbmIz42q5WKDahamxF0StYUVpMy+GIoYsl31N+Pw/5+vk
 wVlNuyjAloNG33yFYdpdqOQR2prkMcNw8RsPrwZMeT94xVlRrdn8SaM45VJIaQppexTy
 hCMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8szo36ahbOcQ1Zf4qRyw51+rlkuEsK+J5i1FtUibgEz1zp7VGWJNatJFFyacwSoQk/W0P7s7V2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq82IahoCo58V5FKjXmZXnCr2/6sqVLmVaSJ3wcd+YWMSMhLqi
 CNYxz34wRD4WukPwqwc4PYTFamN3OboMS0+FJQE4oxhzooZvqwY/2IAbYl49+pEJU1H5b3S7Kl5
 W9u2E4YzUyBLmce67TyBv457DgGVjn23u1PVnv5jXpFzyGfidvz4pVyvTqCvUKzCiMxTp
X-Gm-Gg: Acq92OH/kZRW4n28ZrFooLBePM7TW38s2UmtIf/XBXYihDbxJMXe4gb5oGd6/rWkkT3
 Kpjk4bQ/xuHSWOyaZK7ciyzHlrapU00eRA134hEOsCKjabQxq1R1LxxSGiqKxrctIt8w9maJNR6
 sdz9Zb/SEbAkH3J433o2t9UDp/ORTqssW4HWaDPvhIKO5DGHIUe8KPmdhat6eabpJI0RMf0C2jb
 4J+Q6ZhRxqbmq6gGcRVebipJNaz4Y5ipYbr8MxcoCxS8QHQ51yDyxjbTEuUQzAoEEU4s5/D3sVl
 zJpNjd+0uI1F1Twb5GtyItjeYf92w0BDhoE+hgel0vjFGv03hSKivzVVasvD8yFZFt0GhPMYzNw
 khA/5wgkPq65sJfAtrXsSrBY3AdhOQMXjFjf0vk2JYJSB+tg86Ugt0oQq66dh0EEvx2JDMlMHaY
 BURGnw5R/syxH/O+oc60JSr0oUhymHQub27WA=
X-Received: by 2002:a05:620a:2945:b0:915:6e30:5bdf with SMTP id
 af79cd13be357-9161baf833cmr572322485a.19.1781289022516; 
 Fri, 12 Jun 2026 11:30:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2945:b0:915:6e30:5bdf with SMTP id
 af79cd13be357-9161baf833cmr572241285a.19.1781289018558; 
 Fri, 12 Jun 2026 11:30:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v6 0/9] drm: writeback: clean up writeback connector
 initialization
Date: Fri, 12 Jun 2026 21:30:10 +0300
Message-Id: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADJQLGoC/3XRS27DIBAG4KtErEsKmGdWvUfVBY+hQapNAo6bK
 srdixOliuR6g/hHMx8Sc0EVSoKKdpsLKjClmvLQgnzZIL+3wyfgFFpGjDBBNKH42+FQ8gHD4HO
 Ago2yxCvhgggKtalDgZjON/H9o+V9qmMuP7cHJjpX162JYoI145JLwllU4S3Xuj2e7JfPfb9tB
 5rJiT0xVC4Z1phoBA1AeOTRrDDdM2OWTNcYx7WVNipDOrfC8D+GMqaXDG+M0IFpkFIbQlcY8WA
 kEUQsGdEYzoRUTnllI/uHud7/v8Dx1BY53peAnK2A56Y07jah9LhP1b8+LniA89hGr7/93VP4C
 wIAAA==
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Alex Hung <alex.hung@amd.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9il6fypLWksHY5Vf6qI9Q21kNPjGAdIILaanJtMNbDY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA13Wjb8f/EE9CA3w++J9kx3Ncdj59xl/eE+
 VE0wKwtaGeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNQAKCRCLPIo+Aiko
 1RaJB/9dozGc5nGDV8+8wZMl5wDq29h9EAVYVQwH9xyq2H0AeYw5dmrncFxw4kKmOi8Gnav/Mo1
 jesWVr8IH3fomshJveLOQZWQ550qu4/9UYPH6Fnz+vIvZFabLcYdZAF3kDtlfsL6SVuRb+iPs5v
 3VFnr+1BMjQmkCcrMxysAt6yO91OHnDUcrqY3cLGHCNEt/84tYF/ifsT4jHMeGUHj2WLSdCnlph
 IDxXY/b6A2AecTCJevTLUxek3hufKC6olvgyteP81k3eC/LXh2IZOqIHrgE3BVezbdPh6FeZSFI
 DuCOzO/pnib9JFq+2NPzwgtA4fB47/TOl38NUUBfr7wxSpfS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: T_6yvgwF1CZlOpBDren5tOTGsP2ZuLxU
X-Proofpoint-ORIG-GUID: T_6yvgwF1CZlOpBDren5tOTGsP2ZuLxU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXygwPWcuBsCYV
 0NdR420S2GzrOr3UEkDfWhdtXcFZvf9IXKpXSNcaBb+umx/esjas7q5edhytF1kwE57X8R8Zvjk
 tBo2JWxMssyIoJ2YDW0in7/u8IS6DNk=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c5044 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=zd2uoN0lAAAA:8 a=V2sgnzSHAAAA:8 a=7CQSdrXTAAAA:8 a=P1BnusSwAAAA:8
 a=RF00TdSWAAAA:8 a=e5mUnYsNAAAA:8 a=lNIPRDuYLkTERnwjT3UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=Z31ocT7rh6aUJxSkT1EX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=D0XLA9XvdZm18NrgonBM:22
 a=_nx8FpPT0le-2JWwMI5O:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfXyXyaHsnwfUL4
 H1a83KTxW8n6vmouE9RwVgw5mFXadi07x9PNcywANjLF8QOUetNnkegD7u6JhGH4f4YmRdC1dnM
 yNr7mLwUYe0QAvw7N1n51ZUnjf7MhhYMTC9fH0xzCApiKsHLuFjyZh6S9DRE/dIqLVd+09j8uD6
 6EQYgah4X3HXy+B9tgfwpJTInqQ6bWawOimxlWA2qX20s2P5R6ctaUrfEvrDkU3PtDgPFL+h0Co
 Q0MnhE7R5xVhHjYQ4PtnuQtPhxwzX1JMZ+i7B0lbxSi6DIzsXC/BIIDrXeVu47n8uZsehSixC8l
 xzjgXSzk9zxzenzokm2E9nJLEq8j/PeRwE333YJpOJ0U57SVNOuAmaWvMGNRdSqNrHztIJ7dkxd
 hWjAqLGidXBC3Ej2/SI5fkYDblb+ZA23aaHGbiLJYX25j1tjnpNxsM8U22fE9M1C+XmxmwYtIra
 zfyZZaeUjYP8B9IZY8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

---
Changes in v6:
- Dropped applied patch
- Implemented suggestion by Alex to use drmm allocation for the
  writeback connector.
- Link to v5: https://patch.msgid.link/20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com

Changes in v5:
- Rebased on top of drm-misc-next
- Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
- Expanded commit messages, describing why the drivers are converted to
  drmm_writeback_connector_init() (Laurent)
- Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com

Changes in v4:
- Rebase on top of drm-misc-next, dropping applied patch.
- Added a note regarding memory leak in the AMDGPU driver.
- Fixed a devm vs drmm issue in the msm/dpu driver.
- Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com

Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maíra Canal <mcanal@igalia.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org

---
Dmitry Baryshkov (9):
      drm/managed: implement managed versions of kzalloc_obj/objs()
      drm/amd/display: use drmm allocation for writeback connector
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm: renesas: rcar-du: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  7 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 22 ++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_managed.h                          | 22 +++++++
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 98 insertions(+), 126 deletions(-)
---
base-commit: 2afdfc658f7a7e9ee2a67ec6663922da9c799c53
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
--  
With best wishes
Dmitry

