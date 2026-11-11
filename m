Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385260A380F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cEsksMOt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GdGllp9a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E44D10F86E;
	Wed, 11 Nov 2026 00:43:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459FA10E02E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKcYM3715093
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Tg4X3cdll5T1S7kugUAtHU
 1yiOSVpqm9E/2y7Atjkho=; b=cEsksMOttxjAKuSzdboUbArSKwAsz/CF3eqM/9
 9jFuS7edg3Ynh7bPrA1UE7NFTHKIxC1U9GNFh2o7CGvroD2GJagqeZdKDGxZPrAt
 4OHM2hI5GSzHrjPmkpAytvP6s25PnL9J+ohO01joGrADV1EoV6GgBgoVMTokgdYi
 dVOrHPTE8urO75toSDGj0rN37AVEB6N3Hn0XtZPnVB7D1BhafCZOiF0mDByZCEaY
 AxaY2i+86Ij/YZNaVaRrtIG/jAld4Wbh1eXeyJn+lJ0oj7cN5x0UaaSGjRrXOxFh
 fGfWArXj3aTVsnqXjF2KdyLuWFML+3Ru+gvg3hx9o1Kbv3Jg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw4bjsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c8a517107so74860496d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357787; x=1794962587;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tg4X3cdll5T1S7kugUAtHU1yiOSVpqm9E/2y7Atjkho=;
 b=GdGllp9ajIocEMS6NVepWuZcqWOtU8YEyZYTQ0BCIi66HrNbz14BdhrFpJU4RE9HeI
 KGp+D2e3EMXf+6imgwOxZTTUZLj+u5m/KTt+lCiMBznelKMG0EM3hpYQvR7RCO4wk5Bg
 9xdAOetM3m1t5/RBlAxbFJdhLkBupkK9sSMxuI8AB8Z+gn8j2JQJu+6sCkpF2ERbpSNX
 3WCxxpqtZ3Sty/M3gbacp8Tg0YCYLRDvwnGA6qqeb9o7mr4IjhdyeD+D1rJzu4zAWlPs
 Wobyy3qQ/JgF8JixF0Kkf8TRK6z6MaTuG3IazbSQD7oxU74NOR+qR8kV8j/0yTc9RJPk
 5hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357787; x=1794962587;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tg4X3cdll5T1S7kugUAtHU1yiOSVpqm9E/2y7Atjkho=;
 b=JUe1V0Mv6meQUu71pkxgIF+SgvdLvmxuCuPu6bH2/o7+d9STQCkncAVxQn02dwygqP
 HELbyWZAoTFp2jB4fwO8q+szVlJAXXGkjq8N0/UPaQosooOecrFhkgg4PwCehpwTtrF+
 mTrpszDw7sjARVfOqPPrgC44Yhu3LBSFRKsqlUfo+yUmfG0QP46cwWDBgtyvl9cxH+iu
 Yo6W0RV4n6FaDZbkF4WEtkSNjqlMbJAehLidqXG5OdYAQnEex3OZecAqodoP6UgIgOnN
 7GIMFTKaUC3bjE88U6bww92ae54OuydUKWgt4l+z5OLJ3bYoctjgGmHULLzURZi+kfTD
 3gPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH5rlOATrblY0F+MBpQdWW82So4kyfLxPoPS5zjWhALbEx+xqyn7WpiH2Ak1PdBqBqB66JaRst1@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+53yHhGKSIDipyVV0KDmDpSNe3A4sukYki2rVsUlOQ0doIJjya
 2EoCZGfmZWOnLacUuWNL6qWlIn+RlQ0c3M8xn4912lKZb/NbTj5w1XkbGjmNn9lwOht/Poqws4Z
 A8FC2F9/YNuStPzNyv+pc2SbfsLaS0TMvhLQiC+9XjEHjM9jAja6vUt1qw5HraI9scjiz
X-Gm-Gg: AYBFou1GhKFURgGckwNPyKlE4Q5+OAjRQ/JLtt0ZV2+t6QJ7EN5zX/NXSOlqdJnigzE
 xX7pTKgAcQGoAl/Ri7HTxfeLkRHCd/9Q8pK/a7xE2owRDQ6IzVQrcZEPdBdVi7kA34RxdtHs3iN
 ktjXJaHPs8eeQgmalHYSeE26FtLDYSfZqS3XAf0/gqu7MGusfrU2udeRh8xNZsT78tVOy1U4N1r
 SVniia/CDatLaARvdp0Nvv/UOJNa00x39QO0ANMBIahcktE/f5BA3l6PVio9og0tVe8wHQ9JzqV
 XGxnme/gYDyYHcDZA2uevsN2FhV+mFsjMVW2dd9uN3QpDNUWR1DTh4A1FMKvpVxTqemXq8yFLvj
 wfvqsSX3P84KYzLL5h+4eZYH1Cij9jcD0XNghpHbNrvZ7dvjKIALU9c2kD84wuyIpUJJuupubFd
 U39WC90IxNXWgbejaJrB1Kv7BuencODI4hn66l2tgr+0J5W102Abeo+mlqtIquFw==
X-Received: by 2002:a05:6214:4109:b0:91e:8cb1:b842 with SMTP id
 6a1803df08f44-91f0416afc3mr18101496d6.49.1794357786481; 
 Tue, 10 Nov 2026 16:43:06 -0800 (PST)
X-Received: by 2002:a05:6214:4109:b0:91e:8cb1:b842 with SMTP id
 6a1803df08f44-91f0416afc3mr18100956d6.49.1794357785839; 
 Tue, 10 Nov 2026 16:43:05 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Date: Wed, 11 Nov 2026 02:42:29 +0200
Message-Id: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPW582oC/3XS327CIBQG8FcxXA93OOWvV3uPZRdQYCNZW4Xau
 RjffajRmdTeED7C+ZGQ70hKyCkUslkdSQ5TKmnoa9AvK9J+2f4z0ORrJggoQAOjP476PGxp6Nv
 Bh0yNstAq4bzwitSpbQ4xHS7i+0fNX6mMQ/69PDCx8+myNTEKVCOXXALHqPzbUMp6t7ff7dB16
 7qQMznhA8PknMHKRCOYD8Ajj2aBaR4ZM2eayjiurbRRGWjcAsPvDEPUc4ZXRmiPOkipDbAFRtw
 YCQLEnBGV4SikcqpVNuICI/8ZyXDOyMqY2FjBo2YNgwVG3RkGz/5GVcZz1NqiDE7wJ8zp2oYcd
 vtaq/FaCeJsCfR8KY2blc8d7VJpX28b2ofDWEdPf380LrSZAgAA
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 John Harrison <John.Harrison@Igalia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6121;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eaXxqDG4WrpTkfdaiMoy+rNXi5klWk6+CeDvCurUMK0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87n6hOU2QvpLiPujdsHCYHYfu8QrSQipqUVwh
 rP0H5Xo42CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO5+gAKCRCLPIo+Aiko
 1YvTB/0a9YP74Woyq7Tx/JgbG6dxAN/qjgPFsMEZehC+9i3MVe4qiudQeHjHIGfJQvTduTO9Xqk
 tdFImxF3Hgmud1zSHt2T9loQX8oTx1pNCacq6kCaciiI64Y6SJ+d/N0vUyVVUpH77b0Nqw12ESP
 kl/TbEJKOBH8xPUzhMrDp8T/Pc7d3r64JpEgNO8lHLEU6Ts1z+j8neRmLLYq5T9Fb9iE0gaW3kI
 GfP9BXJtkeRj5M23Zcn3EyEa/S3EJqpa0deIEt/yaP+JFeGtn5+NZAwlYlDobyduHTYEIcIoXJ+
 WhoS8YRnyTSA1orhhwRUBgKDvvyat0rVOikzuzu5bOQkV4Em
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX4IuZeSlTY4MO
 ZDtr8tJeJE92rxtiFkgNy2YnepNY2Cma+Ep8FruSMe11d1advYkS1+GfimHXpQ5xPN6bqcuSFyW
 pvANn/eGPE0shcOtQa9CRdJYL/P7AfvGmgt0GSxoIZn6+Yfi9gIgooD5EnEkXtud8ISFkgInFvJ
 TCjY600Q+ZSV/Pqps85wbvZwlBICcIHDfHfXls6hpMc15xHFZGBq3fKgumnZe1l3hrr8rdREGqG
 +OMccu0jD8Pn76vA8prS4l9L4XUH5I7HAB9iXgIRxwIndQjGgoVt0I2qS7G2AyXN/Krg+4q89Oy
 OWyD+xYSZ4rcuJDDTOQrc8Er5K9fhumuefjiffzQwJKpkMc+Q29UHTbfQZEO72m0+/iAcqgQi4L
 f0mRhVDOhk5HI+2QLn/JXpYol2dMTjkcG3/MFrq63uLQfl4S5trrHv24oig57HM5KnMCoRdXp6G
 PqmIrq3EDTBTFo6NPLw==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af3ba1b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=V2sgnzSHAAAA:8 a=zd2uoN0lAAAA:8 a=7CQSdrXTAAAA:8 a=P1BnusSwAAAA:8
 a=RF00TdSWAAAA:8 a=P-IC7800AAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
 a=wUE-LUHtHEr0u8wc4aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Z31ocT7rh6aUJxSkT1EX:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=D0XLA9XvdZm18NrgonBM:22 a=_nx8FpPT0le-2JWwMI5O:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=srlwD-8ojaedGGhPAyx8:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXzAUd9Dbef7w6
 BjvJkpgYIIs+lCC0MyiItQfv7txQuwUuQx781+MUr7MeHvx1yUZrn0bCbA986jh9Riuu4Aq59us
 lzOzvGnQxEIiWjaXouSpiIFhpyXXs6I=
X-Proofpoint-GUID: ZpAaZteKg8dl9s_x62rXtcamv6L_L61v
X-Proofpoint-ORIG-GUID: ZpAaZteKg8dl9s_x62rXtcamv6L_L61v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Enough of the drivers don't use
the encoder embedded into the drm_writeback connector.  In preparation
to further rework of the WB connectors (as planned to enable WB for i915
/ xe drivers, which would move drm_writeback_connector to be a field
inside drm_connector instead of subclassing it) remove the drm_encoder
wrapped in struct drm_writeback_connector. Rename the
drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init()
and copy drmm_writeback_connector_init() interface. Then, with the
encoder being gone, handle proper cleanup of writeback data in
drm_connector_cleanup().

---
Changes in v8:
- Fix the out-of-bounds access Sashiko reported on v7: track writeback
  initialization with a new drm_connector::wb_initialized flag and key the
  cleanup in drm_connector_cleanup() off it rather than the connector type,
  since a plain drm_connector may use DRM_MODE_CONNECTOR_WRITEBACK.
- Clean up the writeback jobs outside job_lock so the sleeping teardown no
  longer runs under the spinlock (new patch).
- Link to v7: https://patch.msgid.link/20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com

Changes in v7:
- Significantly reworked series, no longer insisting on using drmm.
- Link to v6: https://patch.msgid.link/20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com

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
To: John Harrison <John.Harrison@igalia.com>
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
To: Louis Chauvet <louis.chauvet@bootlin.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
To: Eric Anholt <eric@anholt.net>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org

---
Dmitry Baryshkov (10):
      drm/amd/display: embed the writeback encoder in amdgpu_dm_wb_connector
      drm/komeda: embed the writeback encoder in komeda_wb_connector
      drm/mali: embed the writeback encoder in malidp_drm
      drm: renesas: rcar-du: embed the writeback encoder in rcar_du_crtc
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()
      drm: writeback: don't destroy the shared writeback properties
      drm: writeback: clean up writeback jobs outside the job_lock
      drm: writeback: clean up writeback connectors in drm_connector_cleanup()
      drm: writeback: drop the drmm writeback cleanup action

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  27 +++-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |   3 +
 .../drm/arm/display/komeda/komeda_wb_connector.c   |  24 +++-
 drivers/gpu/drm/arm/malidp_drv.h                   |   1 +
 drivers/gpu/drm/arm/malidp_mw.c                    |  25 +++-
 drivers/gpu/drm/drm_connector.c                    |   3 +
 drivers/gpu/drm/drm_crtc_internal.h                |   3 +
 drivers/gpu/drm/drm_writeback.c                    | 156 ++++++---------------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |   2 +
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |  29 +++-
 drivers/gpu/drm/vc4/vc4_txp.c                      |   8 +-
 include/drm/drm_connector.h                        |  12 ++
 include/drm/drm_writeback.h                        |  22 +--
 17 files changed, 159 insertions(+), 167 deletions(-)
---
base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
--  
With best wishes
Dmitry

