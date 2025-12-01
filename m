Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC214D116F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 13:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C2E10E243;
	Mon,  1 Dec 2025 13:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="SXgNDoMg";
	dkim-atps=neutral
X-Greylist: delayed 315 seconds by postgrey-1.36 at gabe;
 Mon, 01 Dec 2025 13:47:38 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAC010E04B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764596856; x=1765201656; i=natalie.vock@gmx.de;
 bh=txtTrzHJym24K0gyb1mF5doofizsESMhalFu5YxWezc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SXgNDoMgw6CF06EydOopy6LzsazStF6+2j7e7XgRxno5yLxkasphIpSHfGv5s44J
 cvP954+QgRlwzXZSok4DaaaHqVUFSXgKyLk8yu183KO5mLX/IR7qcqfSI25YGvLYc
 ZLo2s8OVCpHsO4oKF/+h247Ijl7AvF2XI9mFIswyLOHH2SLtLBNzJSTtiBdopn1sr
 Jfr1Se9zL0QSAnWtMlkRxqdXGKtUtvYVyGkdDAg/POFj3cdxyXeDIwZNOzb7jN98R
 YIUuNoMHjuCfSSVF6g7EP09vAtg57mmRtkCLE9YhejWkGO/KQSa9UVovwrfgi0Mpu
 lqS5841ySLfSTB6Yyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rizzler ([80.187.64.159]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1wJo0s2PdF-00yXBg; Mon, 01
 Dec 2025 14:42:11 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Forward VMID reservation errors
Date: Mon,  1 Dec 2025 14:41:47 +0100
Message-ID: <20251201134147.10026-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I6w7hhtdkB6c8nQvtl2nUrjWqzgcEm3srW6JkP+4tvDUAKW1bcB
 zSmFGe7LvIZcaw8DapwWc6n3ofzqAuLm+vTNmSVqJ2cBYx3ILTv2Vanvf4Cgo8fLZp8t6ux
 oU1rNjycmUPf6DZV6GbeLaC5JMk7sLC6zElNJwLSiSmBEN1fs7E2CMDaUAcAtdWg38LgDeI
 XgUZFplRxLfA5aRaodtDg==
UI-OutboundReport: notjunk:1;M01:P0:NGqx82wy1g4=;HALSKtb6D5WlJgaV2rfQLmpLtZS
 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
 IuRYQ==
X-Mailman-Approved-At: Mon, 01 Dec 2025 13:53:38 +0000
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

Otherwise userspace may be fooled into believing it has a reserved VMID
when in reality it doesn't, ultimately leading to GPU hangs when SPM is
used.

Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process iso=
lation between graphics and compute")
Cc: stable@vger.kernel.org
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 61820166efbf6..52f8038125530 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2913,6 +2913,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *filp)
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
 	struct amdgpu_vm *vm =3D &fpriv->vm;
+	int r =3D 0;
=20
 	/* No valid flags defined yet */
 	if (args->in.flags)
@@ -2921,16 +2922,16 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		r =3D amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	default:
-		return -EINVAL;
+		r =3D -EINVAL;
 	}
=20
-	return 0;
+	return r;
 }
=20
 /**
=2D-=20
2.51.2

