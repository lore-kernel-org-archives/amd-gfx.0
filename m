Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBA5C47077
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Jan 2024 13:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A2F10E0D7;
	Sun, 14 Jan 2024 13:05:52 +0000 (UTC)
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Sun, 14 Jan 2024 13:05:50 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A530010E0D7
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jan 2024 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705237549; x=1705842349; i=friedrich.vock@gmx.de;
 bh=duszS7bM++dpqcffrIBvbtLByssm8/g+HtXTUzxcDfM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=jxXMx7K9iURDl2LZKdX3cc7AuhqW3qBkuussot2YZmV10inr1+eeb/fd0tfKgHeT
 b7rd1G50OHqc+npxfdM1a3n5o7a7RrYwQOH3Yxu52MXmQpFiFj4nKSv0Zg52Fbx9+
 Dp2KgQCCN5yTwYvw5Hl7SiIQAtpNcZBhqNS1W7F8a28zfI/fhTbjKDY0zBT1cOmpY
 6iANOgBwPQxHrQN4i7LtQVAxZZaXMYHnNwpt9zKdHCL2f6ElCNOcDAQRCsXB98Ytj
 iG74maFgp7X8oF7X6t7fpNhnTtn9YYBCHAehLUFL+vPpyisTZVt3yhbVthD3qqeeo
 kBxUAEx1dubRt/5x/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1qgLbv2V50-00imI1; Sun, 14
 Jan 2024 14:00:33 +0100
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Date: Sun, 14 Jan 2024 14:00:08 +0100
Message-ID: <20240114130008.868941-2-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114130008.868941-1-friedrich.vock@gmx.de>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+y2u0kKULksfAXaib3mMiV5MCxb1UDjZ7zh98+Bj872gSbqZFiN
 JrOWTczPq81QgVSgG6GEkaw1PbKoQI7f4DVfOItfGAYljJakVIJZlwlxigm9MsHNWaB14Rq
 UXkTbH5gwHlkmDQvlFcumNpl8IdiWxiiMTjx43hFJq7ZTsT+mlAWleA+gPmWgDLbMmxl5va
 8oxYXBDJX7AfqQvwPRD5A==
UI-OutboundReport: notjunk:1;M01:P0:fnKNXSbcmdI=;qNQlgbMaF46/tziDoLnCSBegWcg
 ZDk0Bxw/UyEPncgENjME3eQnTw5cYGewR4hlo3D9rrKUezaubPAEIA/korXq15WTb1bQ8dd1O
 5M+bPDJZR7TwKlcrEUDOCBJmtxxYJtE8ftd6XEIpz4RP/Y7UsTxPj5tZ2VeyxJx60NaXXGiU/
 Io9CWv3djuladmEwsoSGjLdsZZgmmJ9VaKsmmGMrxjLgadfaeiTsYg07EDiPGCdd7V4rknDXQ
 KOEPL/HsjN6V6IE0Fbmz5vunFdZY/Ud9HE9K570GG7ZgOjuxln2LDhr/lm68z1dV33r/Nvk6E
 zgBRBcfCFTxctYi3sLjFBxE6dQMq1L6DF9sPoBchJAo2uUXYwziko57fvNH1HUnuUJtTYGvJR
 kKl8nb4KGf7yyxVQQBBwFJKjk1whwoXcKkAsKuqNZjSPbLI4jGF19T24ViHMAjgQ1wL6mX9iU
 aMpBSCleYmXcDg7f7fCeP1ApGFSrPYdSNxpijz2kIwaZTLNP1XpgZx+hdAFxtqP15GvRs6TIG
 ZF+PTHDHKjxUko/Sx/GHdA8WUaePAT7R81XK9nNewBzc2NmcP2TC9rCKuZFZKeVjRW+qrOQn8
 gJ4a7bHo0ub9LY4XvcGQbi3Sy0jcbJepP/P/FLJq7S7f9J1fF3wWiewmcGr6Bz3uHqUeps4Cx
 kB2PHDIex8fsDD4jdVsKVazKID7Xh8DZUUUrNW2oHc2OJAovFA2id1D/IUJrohSbc3A3+65gd
 tSZH9aLenokAw0PvwDfR+TfnosHdyucbj2C1shcV4yIK+Rl61e863MGLcVZKsgfuBDgfZ3iOp
 CggJ6Qiv/8rf2m/V1ZXps9Ev+KElieAOpl8t+V0WGbhSeplyWvtBPyDbBNv76Z7m5NDA0cYVE
 1gWAz8fj4qUzb8RB+gRh87wBqMS8v8tsEhR5VgtDwrRWA1Od1KymWcqg88M/uhAQboO2R+1RC
 vi/hp5uXMsyVKXbQ4DlkMU2NGmg=
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
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the IH ring buffer overflows, it's possible that fence signal events
were lost. Check each ring for progress to prevent job timeouts/GPU
hangs due to the fences staying unsignaled despite the work being done.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ih.c
index f3b0aaf3ebc6..2a246db1d3a7 100644
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
@@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
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
+	}
+
 	amdgpu_ih_set_rptr(adev, ih);
 	wake_up_all(&ih->wait_process);

=2D-
2.43.0

