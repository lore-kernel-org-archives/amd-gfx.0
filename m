Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E130C32774
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 07:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B91B98AB3;
	Tue, 23 Aug 2022 07:29:47 +0000 (UTC)
X-Greylist: delayed 1843 seconds by postgrey-1.36 at gabe;
 Tue, 23 Aug 2022 07:15:06 UTC
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8FADEAFD6B;
 Tue, 23 Aug 2022 07:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vA5Ae
 AbhZveLwqZvzwPuBdbrG2MlvxHo52QrIh29FRE=; b=VMJYcQr4/atAFWSfxtbY8
 2ZHocm3hno7C6gSY0TqUpBOJxV1L/ItDKJKGHm9DPH9RcYOoP6w5tOWVkyjJbZ7j
 A1tM0WazplM7ge+0g8EKtt79vL7Llon1BFmJ3sj+BdQyzTORZKIERn3dP1UiIg3Q
 Wlzu0Mnl/0NEm7d2mhe1kE=
Received: from CD-PF1FQ4FS.Hygon.cn (unknown [175.152.51.41])
 by smtp8 (Coremail) with SMTP id NORpCgDXqgw4dwRj9dGVAQ--.54535S2;
 Tue, 23 Aug 2022 14:44:10 +0800 (CST)
From: jinsdb@126.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly
Date: Tue, 23 Aug 2022 14:44:06 +0800
Message-Id: <20220823064406.1874-1-jinsdb@126.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDXqgw4dwRj9dGVAQ--.54535S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW3AFWDZrWkGF1UtFykGrg_yoWfWrc_AF
 WYq3sY9r47uFn2qryxZr43Wa4jvFn5uF4fWr1UJa4Fyry2q397Xa47urn2qr18uF4fuF13
 u3ZIgry5JasxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZzVj7UUUUU==
X-Originating-IP: [175.152.51.41]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbijBpmDlpEJFGYIwAAsu
X-Mailman-Approved-At: Tue, 23 Aug 2022 07:29:12 +0000
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
Cc: jinsdb@126.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qu Huang <jinsdb@126.com>

The mmVM_L2_CNTL3 register is not assigned an initial value

Signed-off-by: Qu Huang <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 1da2ec692057e..b8a987a032a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -176,6 +176,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);

+	tmp = mmVM_L2_CNTL3_DEFAULT;
 	if (adev->gmc.translate_further) {
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
--
2.31.1

