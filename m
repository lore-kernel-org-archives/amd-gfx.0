Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA0BC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 07:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAB410E637;
	Mon,  6 Jul 2026 07:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="IhmL96HM";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF5610E10C
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jul 2026 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783211705; x=1783816505; i=spasswolf@web.de;
 bh=XI7crHPYzaUYyMnD41HPJv7MDtUrviFMCHZRU0xBtnM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IhmL96HM6P7dwDBU4FrXEAjBp96Fl14h+9e9w08/UqEin2nRXctVCYmpP1zssWiz
 +Wslxs834Jk6yUsKXDuMDw4LUALwHmNogEeRJWel9LddODQ2pE9pt7G3fe89TnMx2
 2jzxoj2/EvFttpz0nmJARKZlqjnYgHKux+U2M6nt0A8ayI/5nq+G4isBcznPsu6XZ
 K80+XCSM2830U92ZqEhGX1JwQYCCztYKAyXh6pRf7sYxkozHcu/IvAdZh1+KmoyW0
 o8FAJvEvmLTGCpje5RSgLpGqs5deZl1WdDYXQn4I9V2x2hnekmqDWqI0DTA5oV7HC
 jM4++zSI+fboQPHaxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1xG3TQ1cSj-00ibpi; Sun, 05
 Jul 2026 02:35:05 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 Jesse Zhang <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12 and
 next-20260701
Date: Sun,  5 Jul 2026 02:35:02 +0200
Message-ID: <20260705003504.31425-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703124405.56248-1-spasswolf@web.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OJYITrLKLMkaU+TKpVljLrgsgcatRa3Ku0JK7Ln1FTBPeJXShfU
 SeTTUofRfUDtH5n+bGdXDLVELCwgOwQK6slPlRs5WO9B+p05ideWj/BJ/XOSnI7RTnyTk9I
 q4ztDBFFG1PkQevOI3jp7bGaOKazTFBNhiDmYLAoD7pnF2HhA6Ryy/x9qL4IGr0WOW5MPA/
 TEnSz9znmBbEOGmMit1eA==
UI-OutboundReport: notjunk:1;M01:P0:YFWIs0cImuM=;ddEHmr1AhnoFYKOZ5HhNI4iPIWD
 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
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:20:18 +0000
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

I identified the problem in =20
f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute reset"=
)
it's reset_queues_mes() being called unconditionally. f94bbd648bb4 can be =
fixed
like this:

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6054c8e216b8..ed1ffa8b1743 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -484,15 +484,18 @@ static int suspend_all_queues_mes(struct device_queu=
e_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
=20
+	r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
=20
-	if (!reset_queues_mes(dqm)) {
-		r =3D 0;
-		goto out;
-	}
+	if (r) {
+		if (!reset_queues_mes(dqm)) {
+			r =3D 0;
+			goto out;
+		}
=20
-	dev_err(adev->dev, "failed to suspend gangs from MES\n");
-	dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU res=
et\n");
-	kfd_hws_hang(dqm);
+		dev_err(adev->dev, "failed to suspend gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU re=
set\n");
+		kfd_hws_hang(dqm);
+	}
 out:
=20
 	up_read(&adev->reset_domain->sem);


But when I try to fix next-20260701 like this

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5c9dfb0c424f..5a78b1504f8c 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -493,7 +493,10 @@ static int recover_bad_queue_mes(struct device_queue_=
manager *dqm, struct queue
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
=20
-	r =3D reset_queues_mes(dqm, q);
+	r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
+
+	if (r)
+		r =3D reset_queues_mes(dqm, q);
=20
 	up_read(&adev->reset_domain->sem);
 	return r;

I still get GPUVM errors (but no GPU reset) and when running

$ /usr/libexec/rocm/libhsa-runtime64-tests/run-tests

[  146.577245] [    T418] amdgpu 0000:03:00.0: [gfxhub] page fault (src_id=
:0 ring:157 vmid:0 pasid:0)
[  146.577247] [    T418] amdgpu 0000:03:00.0:   in page starting at addre=
ss 0x00000000002ba000 from client 10
[  146.577248] [    T418] amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_ST=
ATUS:0x00000B3A
[  146.577249] [    T418] amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: C=
PC (0x5)
[  146.577249] [    T418] amdgpu 0000:03:00.0: 	 MORE_FAULTS: 0x0
[  146.577250] [    T418] amdgpu 0000:03:00.0: 	 WALKER_ERROR: 0x5
[  146.577250] [    T418] amdgpu 0000:03:00.0: 	 PERMISSION_FAULTS: 0x3
[  146.577250] [    T418] amdgpu 0000:03:00.0: 	 MAPPING_ERROR: 0x1
[  146.577251] [    T418] amdgpu 0000:03:00.0: 	 RW: 0x0
[  146.577606] [    T418] amdgpu 0000:03:00.0: [gfxhub] page fault (src_id=
:0 ring:157 vmid:0 pasid:0)
[  146.577608] [    T418] amdgpu 0000:03:00.0:   in page starting at addre=
ss 0x00000000002ba000 from client 10
[  146.577609] [    T418] amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_ST=
ATUS:0x00000B3A
[  146.577609] [    T418] amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: C=
PC (0x5)
[  146.577610] [    T418] amdgpu 0000:03:00.0: 	 MORE_FAULTS: 0x0
[  146.577611] [    T418] amdgpu 0000:03:00.0: 	 WALKER_ERROR: 0x5
[  146.577611] [    T418] amdgpu 0000:03:00.0: 	 PERMISSION_FAULTS: 0x3
[  146.577611] [    T418] amdgpu 0000:03:00.0: 	 MAPPING_ERROR: 0x1
[  146.577612] [    T418] amdgpu 0000:03:00.0: 	 RW: 0x0

This means there's at least another error in these commits (reverting all =
these in
next-20260701 fixes the issue)

b789664e3e30 ("drm/amdkfd: Clean up suspend_all and resume_all mes")
a665d09b10af ("drm/amdkfd: Pass known bad queue info to reset")
a4e4d945cba8 ("drm/amdgpu/gfx: defer per-queue helper_end until after MES =
resume")
f401a2633e02 ("drm/amdgpu: Remove faulty queue before resume")
f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute reset"=
)

Bert Karwatzki
   =20
