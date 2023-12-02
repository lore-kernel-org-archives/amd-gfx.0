Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7417AC4167B
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Dec 2023 00:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3F310E15E;
	Sat,  2 Dec 2023 00:18:28 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508A310E15E
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Dec 2023 00:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1701476300; x=1702081100; i=friedrich.vock@gmx.de;
 bh=QfNSZbz2QggVa2H+50VqYb9bs7kAHds67objxMKFID8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=QPNIlSO02a60cUoMMMmUO+K4aN6NJzrE01xYyXy3AvmXu8YUH6kQCfXvHigXyGHz
 n5lY4MAkgwus6CdRQV8zJ1VC0wXe/EecXk4oMK3l6IeQsZy2+tt+pLatHxzMuhh0u
 vtGn7yctKipG0lJjSL16ArvxnTTlXNzdrEVszBPZPEfkXgDnC5Y8VoNxpBhgQ0Hth
 zE30oVG68aX183XFqbjM8hLYQKPfJRzjQsUy1bHZCrxI0RlaD474ch/1uY35Av/uV
 cRME2hLGsvbyLMOuIMQ1je0Zraq6Gn+3UHF91erHWgp16QfkFa1g5FUvWCm8CesWe
 eBz3pHbu1BLnwiQqhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1quHrO0Bwc-00PtNx; Sat, 02
 Dec 2023 01:18:20 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute queues
Date: Sat,  2 Dec 2023 01:17:40 +0100
Message-ID: <20231202001740.120840-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8K/k6KgUFwtqPgyL62hq8OHUqOFXRhxvgm/0jy4wlJ32R8/5Rip
 u52qeZGh3tNCDaky+aYuM2dJ3sYTinS6o2N99JYMxZgQrfaNo2GrQygbjpFsLmZHZQd3rGw
 vmMdKo6gjHULpHuPcQFe7LQNdjTFIVQIyvQvy+8BfCxxWn8TaVrDjj4b1U52CcUpQfYnDDd
 3vz7+SgcD0PZSGVC5/EdA==
UI-OutboundReport: notjunk:1;M01:P0:4CEcsSO0dX4=;hBGJi8rgHRniZRA3bjQsq1JJn+d
 J8ggQkdGx8TIVUkcbHnvs8NifAGxihsUyhnfybm7QwL4val+PsuGXQmBKdZb2/79KIy2ChUW/
 5KI3s1v+Uw5nSJkyU8vMOQ7f5WVNnCenvViklQHMJkVT7OxJCQ5zrahiOfX3lsE/OeZXipmQ6
 vEZjApNL6Vd8YVCcnMuBAP+gDGivry/qw9qdUnM/lMz4q5l4j5gBUn277eznx7tCrY2vBfCOf
 n7+poVpmn70BPeP3i0WUepfbwBS/DyGmp+OkKFc3PMZWL0HNj7eH/B4s6agNmQIZ6nqn32nuK
 mDkBVkdXByciuDVCLq+kU8sQ9pDt9Ogkq/Oo00FMfr1uT2zEA/0opRmtPFqB6pqLHcyx4pFyq
 J/liBlYvt9kzZD5xInaq1WUPcHPJfbcN7n/J7zKA8Rzz7NQFGKuvYCotV0LWm3DhQhk6W470N
 bokDBlHkYJqAjrOFcqkHgNuuitRRq0J7qgBqlI7/GIVllQjlB51oXPByGbZzupQBfTpJAcT0t
 GHL1+atMq4FagOUTR5QPV6/JoCcG9ULhN74ADMSgyKTKiyCrO5TCnaBhNrpDBHi4poSesDMo3
 vWC5bpPxoJlJxNnlm1Rh1x5z7lwPJ64Q4fpbLUVZw1o6+BexHalc8UaQUhG/pu132yecw2G58
 T6cPt7AYh+HYl3x1DcxxSoVFmOAua3RC8/FtnQvDj0gpmA9GzK74ieVysnej3rZfDdM6+tK/E
 +9MKAcgl2yiMCQh1S01ThvYtKcbmP+iSFiUF0lmOwJc77eXQkMd0OBBCLy13xcMCI1zl1rRMw
 cFSJnHBBuHaSM5D2jb0SwXckXaejE5zwOPH3KV30R5aTrf73o6Sjeq6HXuJMcQub//Bgu9oe2
 CZpuELLmPKiIFgoXZ/Fen/aQ78zZAJNkHYxuYSkyqHIkwIiKhREp55uvSsPlmVBWEsie9omoW
 mkOPhb++0/MxNrxlac1/emL+udo=
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This improves latency if the GPU is already busy with other work.
This is useful for VR compositors that submit highly latency-sensitive
compositing work on high-priority compute queues while the GPU is busy
rendering the next frame.

Userspace merge request:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu.h
index 9505dc8f9d69..4b923a156c4e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
 	uint64_t eop_gpu_addr;
 	uint32_t hqd_pipe_priority;
 	uint32_t hqd_queue_priority;
+	bool allow_tunneling;
 	bool hqd_active;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ring.c
index 231d49132a56..4d98e8879be8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_rin=
g *ring,
 				    struct amdgpu_mqd_prop *prop)
 {
 	struct amdgpu_device *adev =3D ring->adev;
+	bool is_high_prio_compute =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_=
COMPUTE &&
+				    amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
+	bool is_high_prio_gfx =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX =
&&
+				amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);

 	memset(prop, 0, sizeof(*prop));

@@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_rin=
g *ring,
 	 */
 	prop->hqd_active =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ;

-	if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE &&
-	     amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
-	    (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX &&
-	     amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
+	prop->allow_tunneling =3D is_high_prio_compute;
+	if (is_high_prio_compute || is_high_prio_gfx) {
 		prop->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
 		prop->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v10_0.c
index c8a3bf01743f..73f6d7e72c73 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_=
device *adev, void *m,
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
-	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
 	mqd->cp_hqd_pq_control =3D tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v11_0.c
index c659ef0f47ce..bdcf96df69e6 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_=
device *adev, void *m,
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
-	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
 	mqd->cp_hqd_pq_control =3D tmp;
=2D-
2.43.0

