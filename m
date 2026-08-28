Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE17C61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4462310F365;
	Fri, 28 Aug 2026 11:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/BfyNas";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4068010F34D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:33 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so126074166b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917292; x=1788522092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dyXXTcYmbHIHLJT4ADyb1lhamE3C9aXEyjHVkuAarfk=;
 b=e/BfyNasFBRqv1dy/rs0wsEnkOYjp7r8vx0VFVMGvypKDSt66qFaLJov4qCgfBDaaQ
 XJ6JYU+SCVU3IElHqPYsfoZ8AdUrCxKenEmHSYRXZVweIZQuaOQJ5NFZ6CPctP1UUsD4
 ejlkeDai7L/mv05UaJ6NVpzm0e9qI5QySYw0IcWS6LSZkLruJO0SRfwJovCsPEzjBFRD
 Y/NKk7iCvQxAPnR2uQLto6MmW6E0Iz+JJjyOZnIsaq8TbpT5soPVdVDxPMgWB3+hfVMf
 b/TiqIhfGD7BLby6SVSW/OiHML9yg44Ftx/3QqfWASRGN1ewtjQRrlVciNAxNcbF5Oo4
 8WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917292; x=1788522092;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dyXXTcYmbHIHLJT4ADyb1lhamE3C9aXEyjHVkuAarfk=;
 b=LnyHXbY6Y3g2AwuxJeFPEWTuX4fciLegLussEO7LRnDh5DNCJ87mX7/kEj1wTj51dx
 A25KA+6t5EgIv7Encr/7s5ZmnRoFvuWsX4W1/AoH+5D5yezaD1qIJ7110Kv7Nyvkiu+p
 aKMWUUSPDdqGqR1Ip8NaF/1knD/yAJRZSbdycQboEl0wxRM5tXf80dcXuESgW5RjHg6Q
 xmzBnmyoBCOjDqkq+vBA628tpWa29YKDzvO9AYbwQieIzxTUIblf4EGx3cJCDvDrRfCX
 2Vdpa0ZGPyOh3gOZ376jCRmrNEgD5znvm5ELgrIuw2cp+yKhQ30unPDs5/3YXA4U+AxR
 louw==
X-Gm-Message-State: AFuF++nFX5H0JC69F+r5rxnmnbvO7kQkhOZYOHnE6zS62cAP1zwo7cMW
 c5tax/UtRC5rrM4aa5fbjUSurrwkGjTV6yOYc2e8hLZqaB+221OCgaFne/apj0ud
X-Gm-Gg: AR+sD13HznHJlh+AtBWVIK2eBxf2mPynfhWMZvhcUoH3bElguz3rcfhybSzED01xD01
 jjYAXQxLu4DRQmVuZ5FaVr2naUS7d995STXfSrpR0vt0pKdE4kSx6T35g1z9Oqx77pvfQXz5ECC
 w6TdkinK8MYCfZU3BlO5lFEH039fMZienxE8HjJ9SgtwsVOM8o7J96wAXKNsriDyjPH3wkp2Ir7
 cyFBRMoV3XdU98BVAUaiCEhkxKIHxu7u5gbXjwoxGe9WuGXfErdJ5wyPpZO5YMhzMfQP5FbCt+h
 vTobkH8zcHeKawU6QaXXiegFzbth5pGOY98EoS1lst9TMoVxlQb6xTXXjAk7CBI2dO5ER1fB5U/
 P7/a/R3JxxAisX8aJjKo39dIZnbk/rHhWmaTFwt1BhH0LZfMIIDyhZtR0CepeNiuJVJLulsedlS
 s4urwBQlAJjrUZLWmMT7aC0DxXomTCoUm2jU3mrpa0f4DhaIj9zZD2brFsDlwBGerZYZKcQjnbI
 1yAPOFQLnsN7xZvCSrE52/9
X-Received: by 2002:a17:907:e1ca:20b0:c25:57d9:e67d with SMTP id
 a640c23a62f3a-c2557d9e901mr297601566b.13.1787917291538; 
 Fri, 28 Aug 2026 04:41:31 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/11] drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
Date: Fri, 28 Aug 2026 13:41:12 +0200
Message-ID: <20260828114113.13523-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The retry CAM can filter interrupts which occur repeatedly,
such as page fault interrupts when retry faults are enabled.
This makes processing those interrupts much more efficient,
because the CPU won't have to deal with processing the same
interrupt repeatedly.

Enable the doorbell for the retry CAM.

Also change the doorbell range to actually enable the
doorbell for the retry CAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 4470df45b7ea..d6554add485c 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -307,6 +307,16 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t ih_v6_0_setup_retry_doorbell(u32 doorbell_index)
+{
+	u32 val = 0;
+
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
+
+	return val;
+}
+
 /**
  * ih_v6_0_irq_init - init and enable the interrupt ring
  *
@@ -392,6 +402,21 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	if (!(adev->flags & AMD_IS_APU)) {
+		/* Allocate the doorbell for IH Retry CAM */
+		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
+			     ih_v6_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
+
+		/* Enable IH Retry CAM */
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
+		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
+
+		adev->irq.retry_cam_enabled = true;
+	}
+
 	/* enable interrupts */
 	ret = ih_v6_0_toggle_interrupts(adev, true);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index f89e5f40e1a5..a66e3073aed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -199,7 +199,7 @@ static void nbio_v4_3_ih_doorbell_range(struct amdgpu_device *adev,
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
 						  S2A_DOORBELL_ENTRY_1_CTRL,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  2);
+						  8);
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
 						  S2A_DOORBELL_ENTRY_1_CTRL,
 						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-- 
2.55.0

