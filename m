Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62915CA5FC1
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 06:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E606410E42F;
	Sat,  3 Oct 2026 06:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6ST628B";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB6D10E42F
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 06:38:21 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso2342995e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791009500; x=1791614300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cl1Cm3ntznpx9hP+2l8bU0E8iBoCn2OenHC0GsmXEUI=;
 b=h6ST628BgpyCQqQjugFoPRicweqg1LANGpIq1Vumxsd1jo4Xu67ij1himIgy1ErUNQ
 sIOcdfkNPtxpui4gVwyhnEgk/HwArHdQJmPcvzYY3lqhTe6uMLbDBo5IkFpLAXedlpQu
 0LXkJ33ao2Fs+jwFL5tx8reXeeDLaUxVjSIhD1u7mzRHhv4LZ7iRfArgFtC4lWqdN0t1
 p4BJXsqwoOg+skOD9Q/FAONMnl7cATguc/tPbpNs7U6eXoDZDGea0Sxgc4hHd4wNtI62
 MpYBHN6rhb6qJ8mYwgzIeF2McRw3VYdiJkpCVqxvesOTu2TmcmDa6rfXRpBjkgD3zMKl
 anYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791009500; x=1791614300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cl1Cm3ntznpx9hP+2l8bU0E8iBoCn2OenHC0GsmXEUI=;
 b=Vq5lJkmfBvpW0jsF9IdaydJ0xpsDxlQVeBU4///9r1m/ldTPq5xY7qlGr/l/rR6PKO
 M7WsIzYHKqlsgBUDO4dRVW1OuDTByxxTxZxOqSZ7lV0E9C6eawtbT2IlWU2/0ZGjbMGc
 VezaFRWD5TpQnxzFBms6L59fIV3gWdsDegGYVTEplde2iFdBxcyQF+4FvCnsxpeA00uO
 T96KGZMZrNRsmqTZT5z4eWupWkLL/4KubBF5yml8qY3btCneTnxRT+neibXvCQKJXO6G
 N1NuIns9T9m9fM6yLugwbSQA5iPEfCqPfC8nuw9GUOzMVv6wH31WGzqAGXdD0f0/a+QW
 tkfQ==
X-Gm-Message-State: AFuF++n8vBX6+2X06Dltf/wsmGnWup+C0QKznIJUzFXptK20fH6O8oVO
 nEsYeeB1UXBf8C60WL6t2lxPAEEhju6Tlonl5qwvVxIuRL1X/sjxP6ORJRLOQA==
X-Gm-Gg: AYBFou0nTJlgC10JfPiZm0w8hF5YG3E8GwfaH9ldcLNUrJel2fOruVjqJZJpxpam4CG
 Tl9lfwcr5UnXrJHQ47sra7N7/fPEFRIgcMg5Ld5g2Eal2O1yRyelCCinDxV3v15cq3WA/PrCXJT
 m+ZPG6yzmEj5HF3Z4nnY0nAIwpjQSJAdGxZzDRxVO6cuK3D3ZzeOowjYSPLIOYhgxI81ZZ5uq5q
 yKa99z+AyqwGvnhwKljeOaCW4VyRDSJA9r2awTtM+NE0XKhDST/96bIMBmmIMxsCH9qwZODnzzZ
 wEsyJTShi3eZZwietZBTCi56nyJEB3bI/Jt8uX/kT02cpNCRThLQSIKII68kJ+E8GKyuW422SWJ
 CnZPht7OvMd0ef5vMHzy1ZokTEEn7n63HztH/HWgb2tBMspBbdTKF6wdJDMio5vbqXg3zrP9YDM
 9p0PsawezbWUzRR9T0QUBNZmB3uCtf5sYZUXkb6fO7FMrAIXW5LA0+8hm19NlG7bO8wE7IqVge3
 y0TV7F2Ej5xyM8FzA0O6ns2+QGHQ1rCipRvfRW23VMOcpSR8cvACCZysqXlelIUeg36N0HI53gU
 rJZ9lEY0tHWaRobgJEsTJErOxOmuBI1EadMO8MttjdpHonVG+gJK88B+oeJkCyK+wXGic+4ixg9
 y0hvMJPaABlUHBQjqfP2r3IxXf5amGaGMCJZEk3NMP+Lcl6+absWOgRrp8q2G/wFvPivDrni32Y
 GQFI+mE5XR3XeVc0g=
X-Received: by 2002:a05:600c:3489:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-4a0274f3fa4mr82115135e9.1.1791009500035; 
 Fri, 02 Oct 2026 23:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:416e:c95d:c72:8d01:9941:d6d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm200215285e9.11.2026.10.02.23.38.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 23:38:19 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH 1/2] drm/amdkfd: fix NULL deref and unbounded wait in
 teardown_processes on surprise removal
Date: Sat,  3 Oct 2026 08:38:16 +0200
Message-ID: <20261003063817.36606-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
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

On PCIe surprise removal (e.g. Thunderbolt eGPU link drop),
amdgpu_device_fini_hw() calls amdgpu_amdkfd_device_fini_sw() when
pci_dev_is_disconnected() is true, which frees adev->kfd.dev and sets
it to NULL. amdgpu_device_ip_fini_early() then runs a few calls later
in the same function and reaches kgd2kfd_teardown_processes(), which
unconditionally dereferences adev->kfd.dev->kfd_processes_count.

Observed on real hardware (MI50 eGPU behind TB3): NULL deref at +0x1b4
(kfd_processes_count) inside kgd2kfd_teardown_processes, called from
the pciehp removal thread; panic via panic_on_oops (pstore capture).

Additionally, the wait-for-termination loop is unbounded: on a
physically gone device, processes can be unable to make forward
progress, wedging the pciehp removal thread in cond_resched() forever
and cascading into hung-task/softlockup panics.

Guard the wait on adev->kfd.dev and bound it to 30s with a dev_warn so
removal can complete and the kernel survives.

Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640..9326447 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1780,6 +1780,7 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 {
 	struct hlist_node *p_temp;
+	unsigned long timeout;
 	struct kfd_process *p;
 	struct kfd_node *dev;
 	unsigned int temp;
@@ -1801,9 +1802,26 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
-	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
+	/* On surprise removal amdgpu_amdkfd_device_fini_sw() has already
+	 * freed kfd.dev before we get here.
+	 */
+	if (!adev->kfd.dev)
+		return;
+
+	/* Wait for all kfd processes using adev to terminate. Bound the
+	 * wait: on a physically gone device processes may never finish,
+	 * and spinning here forever wedges the pciehp removal thread.
+	 */
+	timeout = jiffies + msecs_to_jiffies(30000);
+	while (atomic_read(&adev->kfd.dev->kfd_processes_count)) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(adev->dev,
+				 "kfd: %d processes still attached to removed device\n",
+				 atomic_read(&adev->kfd.dev->kfd_processes_count));
+			break;
+		}
 		cond_resched();
+	}
 }
 
 int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
-- 
2.54.0 (Apple Git-157)

