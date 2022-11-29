Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A7BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 08:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915FA10E163;
	Tue, 29 Nov 2022 08:22:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6135310E101;
 Tue, 29 Nov 2022 07:10:41 +0000 (UTC)
Received: from frapeml100007.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NLthB5Kmyz67tG2;
 Tue, 29 Nov 2022 15:07:38 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 08:10:38 +0100
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 29 Nov 2022 07:10:36 +0000
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm: amdgpu: Fix logic error
Date: Tue, 29 Nov 2022 15:10:32 +0800
Message-ID: <20221129071032.2154949-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 29 Nov 2022 08:22:09 +0000
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
Cc: yifan1.zhang@amd.com, lijo.lazar@amd.com, yusongping@huawei.com,
 guchun.chen@amd.com, artem.kuzin@huawei.com, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 mdaenzer@redhat.com, nirmoy.das@amd.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, hukeping@huawei.com, evan.quan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit fixes logic error in function 'amdgpu_hw_ip_info':
       - value 'uvd' might be 'vcn'.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fe23e09eec98..28752a6a92c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -424,7 +424,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
 			if (adev->vcn.inst[i].ring_dec.sched.ready)
@@ -436,7 +436,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
 			for (j = 0; j < adev->vcn.num_enc_rings; j++)
-- 
2.25.1

