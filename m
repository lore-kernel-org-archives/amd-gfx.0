Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7472C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 07:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDFE10E790;
	Tue, 29 Mar 2022 07:42:46 +0000 (UTC)
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF4010EEAA;
 Tue, 29 Mar 2022 05:28:16 +0000 (UTC)
X-UUID: d4b4f838eda744c09a499bf8ad02f325-20220329
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 167 audit/email.address 1 meta/cnt.alert 1
X-UUID: d4b4f838eda744c09a499bf8ad02f325-20220329
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
 (envelope-from <lizhenneng@kylinos.cn>) (Generic MTA)
 with ESMTP id 1875178512; Tue, 29 Mar 2022 11:05:39 +0800
X-ns-mid: postfix-624277B6-7434123726
Received: from localhost.localdomain (unknown [172.20.108.41])
 by cs2c.com.cn (NSMail) with ESMTPA id 4A474383C640;
 Tue, 29 Mar 2022 03:06:30 +0000 (UTC)
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH next,
 v2] kernel: Add 1 ms delay to init handler to fix s3 resume hang
Date: Tue, 29 Mar 2022 11:05:47 +0800
Message-Id: <20220329030547.286265-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Mar 2022 07:42:45 +0000
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Jack Zhang <Jack.Zhang1@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, David Airlie <airlied@linux.ie>,
 Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Zhenneng Li <lizhenneng@kylinos.cn>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Kevin Wang <kevin1.wang@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a workaround for s3 resume hang for r7 340(amdgpu).
When we test s3 with r7 340 on arm64 platform, graphics card will hang up,
the error message are as follows:
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.599374][ 7] [  T291] amdgpu 0000:02:00.0: fb0: amdgpudrmfb frame buffer device
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.612869][ 7] [  T291] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <si_dpm> failed -22
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.623392][ 7] [  T291] amdgpu 0000:02:00.0: amdgpu_device_ip_late_init failed
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.630696][ 7] [  T291] amdgpu 0000:02:00.0: Fatal error during GPU init
Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.637477][ 7] [  T291] [drm] amdgpu: finishing device.

On the following hardware:
lspci -nn -s 05:00.0
05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 / Radeon 520 OEM] [1002:6611] (rev 87)

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3987ecb24ef4..1eced991b5b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2903,6 +2903,8 @@ static void amdgpu_device_delayed_init_work_handler(struct work_struct *work)
 		container_of(work, struct amdgpu_device, delayed_init_work.work);
 	int r;
 
+	mdelay(1);
+
 	r = amdgpu_ib_ring_tests(adev);
 	if (r)
 		DRM_ERROR("ib ring test failed (%d).\n", r);
-- 
2.25.1

