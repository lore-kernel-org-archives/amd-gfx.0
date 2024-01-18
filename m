Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1534C47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 18:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B05210E050;
	Thu, 18 Jan 2024 18:55:22 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AA610E8B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705604111; x=1706208911; i=friedrich.vock@gmx.de;
 bh=PW+rQTW5qFJXFe4U1fsbFOzTTh+1IESqMddVbOcuLzk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=IysBx7jVQjndLeNle6ts15wwR7Q4eSFb6BPkE8UJhLbt903CXI9TdHh7fqjZo9y8
 vVcs/mH35n6hKwBY3G3h9zlWaDQwnOMzh/zWOTXaOVKzufXnZnn/2U76PnsdYi+pH
 6mO2uW53pUbhfArVtT/uMTFQSIvqzOVHCCNGRCpMfl/NQIaYBFCsS6xvKutVRO9pC
 9VtAANtMD6NLJ/btue1Yp9Xoihwr4/i3u2g3ZPunpiEc9kzTabG4BDciNc72VzUaw
 SAV0omdbgqHWQ2diG/+lnQbUoAhgtCYL5MvgH0BV3YAW6UP73K5Dr/pIDVHS4HkM1
 WJQNBwBchC43OMBC4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1qv2sS2GYp-00hyOH; Thu, 18
 Jan 2024 19:55:11 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: Process fences on IH overflow
Date: Thu, 18 Jan 2024 19:54:02 +0100
Message-ID: <20240118185402.919396-2-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118185402.919396-1-friedrich.vock@gmx.de>
References: <20240118185402.919396-1-friedrich.vock@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gttZm4NP4OxSMvhBVEYpItr8yHeqmhFBwVOHtPpRDgMEc345A3d
 WReA+XzejROLp390IN3rzEmQ1ZPa0TU+4pJwQWQGEFF15dFRqOZtFosbaJTr5dTl3sA77k8
 ejqt7FIb5/LKAb1sayHNjVFeRWJEYN+iQusenEQ0B0ZZJygBJM8zDuQFMp3k9xkbblY1qLp
 Z9gHHid1dO74x/TuzYLSw==
UI-OutboundReport: notjunk:1;M01:P0:J7v24b3ZFWc=;YQZybuEywyWO37urzJLrGunLoi7
 6gcj4FfOLfVGfAkJ1xWG3p1ooNAdQu7a6EMMWGPc3m+8vT0PIpE8ckkpY9wXAf4g0ps1TVgmX
 QPBEXXsCjaN+D8TRqJvDsVeSBmZFCCCowaakpbwzDyUeQfT2swx0sX2MVEF0Fk55NEa1M0oRL
 9ok1O0oYKy1nieu2jS3y2+VBABUh+YYock1hF9FwvvA2vTvnV9mYXetFS+u01eizWxksJfXeG
 VeaaaBzwhobF88sar+pmwwSyurG4jvUi2UPHIao0Tj0hFm7VIJXkPRTCuELBUAVOB2WYS9n/c
 GwJgt5rBWVxg3F/+w+CedcbHgYacTE5RZE9CJBLMUoqITHxkS52rlbCjxPCQ9F7zWPy/oWp9k
 XIyO147sLq3/F4K90SJqrdrgeLIQjyrL6FlLz2BjXUDH5p7lV3Ccq06UDP+O7PaZsi/Nhht7j
 pkmeLJV9PfVZqZTkQnyu/ryJju5U2lVjo72HWJ9wrqEfZJ2XGF56VJBCw2W78FpsZCEjTwYl1
 0x4Trnl+QNi47ULUzUuXVfmIDAGf7Rid9U4kF3t9YD7vhXf8WN2oK01Ne9m87PXPFZufOWA8I
 1Hqexj+Qcu4LyzyO6/YMvrBkYuVoYcEibXrMBRd9x2Fx4ufuQMRpPVfG2FtAFHxUPpXcvAZDT
 1H5IfPUg8W4zqde0uiOtgrFuBn3FDanaeixqhHeW0QUtHsVFVzS7mQzqzbTr+W8dNkemWko5r
 uKtBdU3hVUjn5NRB9VrPlnODJIaIuDTVf0PjPIajhuJG8R56t06pRzX1g96mt7hVoAGxpS4mB
 sMbD3VQL+VUrqhkJZs0SQnJn7agJqd3XLrHBvsrXJuol6wOxPmpSz46aiaMNcfb3EPABjWn/I
 iYjIkZ57tVoWGG4A8yjPNuKDXtu5VgQATqxx6/YL4BYuRSpTiGcUzc18tGVE62fYvYh0vh5Yu
 Vgm063WlzlDgu1TytLG/1p1niSM=
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
 Friedrich Vock <friedrich.vock@gmx.de>, stable@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the IH ring buffer overflows, it's possible that fence signal events
were lost. Check each ring for progress to prevent job timeouts/GPU
hangs due to the fences staying unsignaled despite the work being done.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
v2: Set ih->overflow to false after processing fences

 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..4e061f7741d8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, stru=
ct amdgpu_ih_ring *ih)
 {
 	unsigned int count;
 	u32 wptr;
+	int i;

 	if (!ih->enabled || adev->shutdown)
 		return IRQ_NONE;
@@ -227,6 +228,21 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
uct amdgpu_ih_ring *ih)
 		ih->rptr &=3D ih->ptr_mask;
 	}

+	/* If the ring buffer overflowed, we might have lost some fence
+	 * signal interrupts. Check if there was any activity so the signal
+	 * doesn't get lost.
+	 */
+	if (ih->overflow) {
+		for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring =3D adev->rings[i];
+
+			if (!ring || !ring->fence_drv.initialized)
+				continue;
+			amdgpu_fence_process(ring);
+		}
+		ih->overflow =3D false;
+	}
+
 	amdgpu_ih_set_rptr(adev, ih);
 	wake_up_all(&ih->wait_process);

=2D-
2.43.0

