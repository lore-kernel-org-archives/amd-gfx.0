Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302F5C61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A958E10E00F;
	Fri, 28 Aug 2026 12:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIlgnQRa";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BC610E00F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:36 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso154114766b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918855; x=1788523655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=LIlgnQRamf4WdcXLikhpK8JGzLl3tq6vDFTueQDB9aLIijJTk9Ld6+c9eRY5s9ohU+
 iNWLO02fIDayn1XCeEe0ALCUWzOIjCLYUmPRzIVq+6ByRy4xZWc628H443pocG42tuEC
 JSdXRxAQ19Adq3fhIOiS9DfDE7gtwMf1VSLpey8BSCGST9CPj2IAxsMawApnoMCFYTBA
 i3LHEtAUTk8NMtgYdLQH1qO8yXOEY/E0N7sFadbwSu83FEWiJ/cnx8iMXUW+PUcy732P
 X3goiFUKV7IJo43xvIY4eYplOBnlQilhvayUjrDVjOktXrkk4wnG2NKzuR65B4IqrO4d
 CQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918855; x=1788523655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=rnoY8vxCm+Se7WmNN9EWZV91aAAlY3fBBekJJAP5JIVFdiuHIGr4koXVXYENBcpXCA
 xFjPLnm5XR0foNGa2yUJZ6zJzEHdWV8uglp9Gg04b/+eiA+k0rGqx+vIFCve8bmDSmV1
 hPyH0+fSYbEuMxhO3KSr49OEAOdATielT4NYAWxoV6xUQxpb5RlCtd72aZK79c5z9zB6
 TVovM4qJpEd7FVC8VV7zUctHVFa88fhzKUrEZbt0WlOg4rYyMl5Pnci0lmRqIaLldTMg
 DTG3zfL6aMPUuLUQrYFeZq30u5xNo+f2052DBiV0I+EB4LGgeS/dpYwe2Ajm5owE0RC4
 u/ow==
X-Gm-Message-State: AFuF++lwe/81AA7b+BMoEa7B92+Z1I5h+hcLogQlfzUcCwFoAgoIuV8E
 Gb75TiM+6S1uBik3AGxncIBIxUcI8SwpgmIXJb+90WsJFshAYoyO91xr9TYRxjXE
X-Gm-Gg: AR+sD1127u66LPdLVrl/yUaAmSypTWRwgagSbtWN3A1jmjnCWGJhfE2rMSllsC1Zbwy
 Af7hdNHDx0W8FkrmVgML9q9CKx6vu4e9hlOWBYMa+N/o+UfvYiXG79Y7wSiBtp39xkN1CYBNtgw
 uFARdHZpKp7nrjnJzz4ToPDKt9Lq98epBvleKwpMLBvA7f3KbOhOdNFQ27plG2PSrXpB8lSOtLS
 7DDk1hMtwIEQ0LqgRnpFRsZ6sTvhD2N9eRJy7MDb6JH31as5Nz+V6Eml4TJr/bewSjQgKMLphEF
 GABhIQ10RFmX9I/whbPyS05KoMeXxuFfTP2Tgl3oX3IL9dSpu1hD9V2mhnq5rEftHn2aX6Mz5B4
 oTlnCaoio79fuMACRUhwVptiKtG4aoDiPr/nqJj4Oqi2McmI4r2VuesG1W7pukpnpNmvv6N2e4b
 OAsisE7pE6eplWqoUtqFfIGQAHO3Ye2dE/tjWUYKYPeIklFpoXjKKTGq1ErV9hCSKljgpVp5HZF
 lwojwNZtBh1ijFFFsLfl/Ir1AyQ1/MGUZs=
X-Received: by 2002:a17:907:b04b:10b0:c25:6022:6f28 with SMTP id
 a640c23a62f3a-c25602275c2mr230932366b.8.1787918854882; 
 Fri, 28 Aug 2026 05:07:34 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
Date: Fri, 28 Aug 2026 14:07:25 +0200
Message-ID: <20260828120729.25908-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120729.25908-1-timur.kristof@gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
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

The ring contains commands that were emitted before the reset.
These need to be cleared to make sure the HW doesn't execute
them, because they are garbage at this point.

Note that the ring reset helpers will re-emit the commands
that are necessary after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..66f278f77f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -593,6 +593,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		goto exit;
 	}
 
+	amdgpu_ring_clear_ring(gfx_ring);
+	gfx_ring->wptr = 0;
+	atomic64_set((atomic64_t *)gfx_ring->wptr_cpu_addr, 0);
+	atomic64_set((atomic64_t *)gfx_ring->rptr_cpu_addr, 0);
+
+	if (adev->sdma.has_page_queue) {
+		amdgpu_ring_clear_ring(page_ring);
+		page_ring->wptr = 0;
+		atomic64_set((atomic64_t *)page_ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)page_ring->rptr_cpu_addr, 0);
+	}
+
 	if (sdma_instance->funcs->start_kernel_queue) {
 		sdma_instance->funcs->start_kernel_queue(gfx_ring);
 		if (adev->sdma.has_page_queue)
-- 
2.55.0

