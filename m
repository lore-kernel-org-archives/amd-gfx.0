Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83E606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGyXrgBS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ln5tOYV2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1445510E773;
	Wed, 25 Nov 2026 04:54:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D395310E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:05 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP2BEcS1096958
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3s86VvG7B0bhUerbEXUlNzOcbhT+/CsYmE4Xu2ZdCi8=; b=pGyXrgBS0CVfPhAf
 F+DmeoCK04ETuCxvBx12lZym1mVvH962Bi+++BwWoB+o86Kw/1CRepy8fFzd7Rvo
 9k/oGNASssh9o744hg2W06Csl+pR9OfhSKTuv3eb9QxuCUQYm+RU7UtjLHnG5EPx
 zYGUjBgRoPYpYJrPH45PCm58btSVE7MvCDFw7Dt9GoJsYjLBKtzk7ck2YW4WPzSJ
 H7oiryhwoBYv7znOos5DP5QVfNpjIu/sP219f3Ef78C5Kf67cJorT9+srk/3a3zM
 xmQlpF4zhCaSRgmNr3m9uwaAUiasOToYilw4JHwJEsHAKxEoE5eDwdrdsRINXdgD
 74s1NQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5efftg3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495c71055bso115581685a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 20:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795582444; x=1796187244;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3s86VvG7B0bhUerbEXUlNzOcbhT+/CsYmE4Xu2ZdCi8=;
 b=Ln5tOYV226W7mr2Y+3L33ku8Jrbk9139LF71XPRMkLQZ58g4cDKdZ8N6XanvfOoMnd
 O8rLRSiXXuqOCGwn61lYsaJKzhojDnoC5YOkXdDgN6FGwmO1W51y0XsHlzUJKuPswpsB
 29YMYCM5YnGihmwj/C+tYD5TBOLknmlyV9tCwEkAkG84kX+6oX+009CxzspRNFDlTV6R
 BBaVE014dZW4/A+P8NhTv+XNlA0dbqi4o4+SILtis6/BGTZCTXHz+atPkxsHmPOTqclu
 3cEzNOO36Ohmj3rZGkTUX/sHShR4M4s+T8HQthyhyAo26JuwbSVfVuNnpfwFIposkLzg
 1j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795582444; x=1796187244;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3s86VvG7B0bhUerbEXUlNzOcbhT+/CsYmE4Xu2ZdCi8=;
 b=IMCfI5P5L5rSzHfJ7fWMPoiJ4fkxqxNNTvl5rqLdBbQ7be4O+4W2REe4P4jjcwePEf
 eepMu4on0A/2hhN7hEM9NFj/tVuF6Z4ByytE3SpFa9PkMxRmY74lmuvMx2OyF9qoP5Ik
 LrWQkBHYJBC6FS8U1anxeIHpz8I1Fr4qzrklGMrfPKt1zP1GiZ3ViYaBvBi1VjZB0ouT
 45yruOTYfD8dvbLHqJRu1aTfNCyKVByasIXBPBJhaBxoGLIunckgxC793UBk0vuLV+15
 uH9mtSESj4UNhTvaPPwA6B//pZ9T1C7PE1HWqEVS4TVz+Sbt07wDCVfBGyqx1k+OECAb
 brFA==
X-Forwarded-Encrypted: i=1;
 AL+hErF+vGBEKjYWCFc8Hwyh6n1SeSRJerbnsXlQSOCBZsr/UVdfAEkGJIwmsj+OD9fUFZoahUsL2ASb@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FkGzQyC6qLr3mk7BG10UFmvIZJrfMj71ZtxTkPOb81M748tjT
 5XuzDQ+1me2QRV/qDE0RVnNBz57YLXcma1Tfzw5O4XNc0QcmhUZGZew9uX6MAH/Wg5Zs9+N+pSB
 IIOZgQ371T9KMyzyrBWmnjz2J3rcQpGdXev32hwuNJnxCB7pTtNc91Y6c/JocfX/p5YYr
X-Gm-Gg: AZFdTZdugF0VH4BFp5FYTx2JStxCAOLH6Dwhij7OOsgELZsUvUAcJcVVW4eIsXC6uhB
 6tgZRzvFrk3n6vCy9dr4kwG7l5kuMuHKT81O9yXwIMv4kt5n95kC/sCxaQrHIwWYLldPVb/43x4
 pQf2aTnvVrT75r1Lvwa00U5XYed1KVjUqTgaSqy+/hzoVLfza7RdJRYfs5q9nLnhWRpcTfG2Lk3
 rfmnLoG3Yts8sd7TqgsO3F7PrBQcqKbgKmgXnflalGadbCAEJfId/7Vi381MBq0VBWykKQHIhNn
 Qa454cYsJciudIb2375A5Unsswobp33qZvsUa+Q7O7Xv1vMetEUV9vIJbFy6CspTxVqgOLLf+Fs
 8PdJe2kj6KQT91/dWDhWZLUCsphCiWhthEhaJEk8CMntmyFBqorc7eZrlTfxgg5gEbHN8WzyqsS
 DgN6nYEX566zluPebNsdUZYK3okXyxuRySeAYs8hQ3/Vkgjn15vvHB2c8oHWZF8Q==
X-Received: by 2002:a05:620a:130f:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-949bab20007mr2846366585a.44.1795582444175; 
 Tue, 24 Nov 2026 20:54:04 -0800 (PST)
X-Received: by 2002:a05:620a:130f:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-949bab20007mr2846362185a.44.1795582443689; 
 Tue, 24 Nov 2026 20:54:03 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcff6e32sm4243023e87.17.2026.11.24.20.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:54:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Brian Starkey <brian.starkey@arm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
Subject: Re: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Message-Id: <179558244222.1572056.13569389105654454020.b4-ty@b4>
Date: Wed, 25 Nov 2026 06:54:02 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b0669ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=t1lj0SIDRZ1apvpNlpYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfX3+rfuf+EiV3C
 +HiAnyoctKNfCRY6fIdmgURHPCoAzorp2sy0XmM9xQp2BE0bgzIHKlKJjzYpKD2uIJkxcjtlu0s
 hmiywp+6in6Rg/UpshkD643kMRj6iXW7Q/iqLj4xZsxNR2rFzugBwlhlF1JNY48l4ogaChbkEcc
 GGOseqyIpVRlx6yYJ2ZnKm82pCrja6fPZa1/Wh6FlUHAYha5ypIw/x60qkREYx9wHHSFA2qpxNv
 mP7xrDf4TKVu6DbuaXrErCsW2Z5pGocSNH3n2Oo90db2ogyR0/GqNZsJTtt+vZw/j3LFy5ypuQk
 +RBBsXnRN8Dat54BCUrqu9Rg40OG3TJgo0YFShIk9U+7G1zDLilbIK/Z5wXb0nmVBm5BX8RnnaR
 elnBQ7Cqeg5VcNWhRTBJ7mczzigDjmZ3qJJmmqD944+E3z+bLeVAdhy5CL4Eb/F6a4+N9ETIX9f
 /9KWsJZFxU2V9n1R1Ww==
X-Proofpoint-GUID: lzZSLxLG9QZXHxgbjygmuUnGm1SvJhZs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfX99Oron92KEGL
 4tHDwCGb1Zs8FBvc3bsfm2XjuWPZsrgoqcgKC+mpD30yTAEBBXtcTOJqN/hbXviUxa3z6rrelq4
 f5hTZLIsgjvJeHT+/ML5HclRaCn2w4w=
X-Proofpoint-ORIG-GUID: lzZSLxLG9QZXHxgbjygmuUnGm1SvJhZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250019
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 02:42:29 +0200, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Enough of the drivers don't use
> the encoder embedded into the drm_writeback connector.  In preparation
> to further rework of the WB connectors (as planned to enable WB for i915
> / xe drivers, which would move drm_writeback_connector to be a field
> inside drm_connector instead of subclassing it) remove the drm_encoder
> wrapped in struct drm_writeback_connector. Rename the
> drm_writeback_connector_init_with_encoder() to
> drm_writeback_connector_init()
> and copy drmm_writeback_connector_init() interface. Then, with the
> encoder being gone, handle proper cleanup of writeback data in
> drm_connector_cleanup().
> 
> [...]

Applied to drm-misc-next, thanks!

[01/10] drm/amd/display: embed the writeback encoder in amdgpu_dm_wb_connector
        commit: 283a3cfbb29cf3d0af1ad03012fcd049dece6e64
[02/10] drm/komeda: embed the writeback encoder in komeda_wb_connector
        commit: 9d5cdb46eed94ddee3732fbb5f8c008c798aba51
[03/10] drm/mali: embed the writeback encoder in malidp_drm
        commit: f07e5e8eac86bc7db2ffdd2e748e256ee2b419a1
[04/10] drm: renesas: rcar-du: embed the writeback encoder in rcar_du_crtc
        commit: 12c88af117c77a1604bb02397cb2b622c47da9e6
[05/10] drm: writeback: drop excess connector initialization functions
        commit: 7bcb37603df095e56e87d6144201179fe911e4dd
[06/10] drm: writeback: rename drm_writeback_connector_init_with_encoder()
        commit: 81f61b4e0467ddab3695be58a94fc322c8bd559a
[07/10] drm: writeback: don't destroy the shared writeback properties
        commit: 7a5c8848606a9c1c9a57dab4332c9445c7f1d60f
[08/10] drm: writeback: clean up writeback jobs outside the job_lock
        commit: da12cfd8400b7b2fd00be22cdebaf2efa6299c68
[09/10] drm: writeback: clean up writeback connectors in drm_connector_cleanup()
        commit: 2bed5919e005687d163d1b6d273db450449b8bdf
[10/10] drm: writeback: drop the drmm writeback cleanup action
        commit: 616a651a5be4655d2cceed0612f70f076eb24cc9

Best regards,
-- 
With best wishes
Dmitry


