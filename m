Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ACBC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 07:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCC210E212;
	Tue, 14 May 2024 07:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="hDz5kHB/";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8AC10E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715670428; x=1716275228; i=friedrich.vock@gmx.de;
 bh=NOvVbCpo6mtWQfO06tV3u4RiAK1JmvTKpArBZfU/2Y8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hDz5kHB/EAugHVbo17yy6gDtNTCdpn7dY6r7Qw3XeQ55MHdKXYF3t51NjMvXY9Fu
 VZ3vLxd4tPBkQZzdkZq9z/tYDUXsRXi+DxQAKbjGewANsxbRgqUGnzKRHKqzcYUUA
 Lm/jG5OJh5eF4qakKXKTvJll72XniSDZHTh10lhHJgXrLzsuLBl0Z/MvODmjAyPer
 QTR53mRGx7GCxmKCK0zVFVZ9h2aKguQAXwIt09mDftWUOc4Y45F22VUL7WXDF9EjJ
 eljtXzQc3724FDKf1Q9PrkaeFFxJIWbCV2abCX6yui8GT/8PP1QjaNT8/q+8l+ZEB
 F3nIj4LLvR1JqzJCOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from arch.fritz.box ([213.152.117.111]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1rsqAJ07wh-00Q8PO; Tue, 14
 May 2024 09:07:08 +0200
From: Friedrich Vock <friedrich.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Check if NBIO funcs are NULL in
 amdgpu_device_baco_exit
Date: Tue, 14 May 2024 09:06:38 +0200
Message-ID: <20240514070638.199124-1-friedrich.vock@gmx.de>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hFoJx3dkkNj6jKuVoY46GEKlMMY8n9NmBi0s8qQiAeN3Hq4k+kJ
 zHkFcCRfS3koLIZMW+kFuO4IzvKxUSD/sEbBWEoxz7MJVoCgd7Flo8QWjTdwQ81s/KN5SlZ
 VLKsYKCLvIkIS9ZYHxTSiNiej4COewJN2R6axdxuOG24DRVEDLr4UruCbH/Ckz+NmugfA2S
 aKJfL+TCqMFnO+I5fSDnA==
UI-OutboundReport: notjunk:1;M01:P0:6dd5qO5bltw=;2FISk1MKBz+3o8RQMkWmBvCaxN3
 K8J5VptahVpFUKQ8Pp9YVdMulZEWMxGgzGb6UCTcu9IsQjy41GwlBG/IhEn+OlnjvQPlibXSD
 LXErRKAgq8Pcxa1OWdoma0LGAqod3GUZyD0Y9towbKvXoscsRxcIR+mUZsPbejxTSglodeGjF
 q+fW6q1TcH4fRCOSJlAsEVbJh02INbH1mgSp0DIxVZv4D+uXe7FZ4uZBhZvrsb5dJlrWZbxX8
 44L+UUzwP/Ruy47JzbhPIQ7wP7sUh+gzxt0RnNqxiipA1tU5epgCfs6J1kmTYBdyvr9hGPTQU
 0+p6zp5+v47sa7Vb/6wr+LquiaaCtwEpNlvBzGprcYPEVG5Y9b9U2Ds0WLEfNHa+APAR9fvKO
 gXG4rNL5fXvHUgPVH0the+z40MeiKnFVFujZYeLgVm10ccZOtqWYFEpwL2KNnXIuLeg3C1O4I
 doCKgTVjuuaR5wpNSwN343kTOGdU67X7BPgmJluF4PCogxz5RSbwS+Tk2phNlrIPXF+76B0+H
 Wi3ivfOpfgjWglokp9WVIan2RA5dMpBNBBsXqPPRkaHW9UAEOwdXYOjNYgUwh+S2ICd4WyoWb
 mMjHd6oy4sFU/ydpwNXhaSvqLD4n+fH7V1/tRtf28NYyceV7j72nrn7sN1QF5aNUkJTDhzmWI
 3QfSZ/x7meLpQVvGPWtyT7JzJ7TSILeMUA1+pB6c9N9pIXO4pnxfDTkNYDjWm4aJ2v9cIBhwb
 kXXNkidhdLWnq/ZfhPecCT/jTlwXtGFE6IOWJ7+UvY2rKk1OIRVY9xCgddcMVC1c/4wcMHxTx
 Pmat2okXJW1X4rNevKaM3r14q1gLgW1ABXLYXk5GU9OOk=
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

The special case for VM passthrough doesn't check adev->nbio.funcs
before dereferencing it. If GPUs that don't have an NBIO block are
passed through, this leads to a NULL pointer dereference on startup.

Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Fixes: 1bece222eab ("drm/amdgpu: Clear doorbell interrupt status for Sienn=
a Cichlid")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_device.c
index 861ccff78af95..83c4533ee75c8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6165,7 +6165,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);

-	if (amdgpu_passthrough(adev) &&
+	if (amdgpu_passthrough(adev) && adev->nbio.funcs &&
 	    adev->nbio.funcs->clear_doorbell_interrupt)
 		adev->nbio.funcs->clear_doorbell_interrupt(adev);

=2D-
2.45.0

