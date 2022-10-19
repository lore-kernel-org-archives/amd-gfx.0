Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA7AC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5171B10F19D;
	Wed, 19 Oct 2022 08:45:49 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8878A10F160
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 07:07:23 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MshWK3blMz1P76t;
 Wed, 19 Oct 2022 15:02:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:07:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 15:07:19 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: fix possible memory leak
Date: Wed, 19 Oct 2022 15:06:28 +0800
Message-ID: <20221019070628.3242386-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 19 Oct 2022 08:45:19 +0000
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
Cc: alexander.deucher@amd.com, luben.tuikov@amd.com, stable@vger.kernel.org,
 yangyingliang@huawei.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If kset_register() fails, the refcount of kobject is not 0,
the name allocated in kobject_set_name(&kset.kobj, ...) is
leaked. Fix this by calling kset_put(), so that it will be
freed in callback function kobject_cleanup().

Cc: stable@vger.kernel.org
Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3993e6134914..638edcf70227 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -863,7 +863,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				res = kset_register(&ip_hw_id->hw_id_kset);
 				if (res) {
 					DRM_ERROR("Couldn't register ip_hw_id kset");
-					kfree(ip_hw_id);
+					kset_put(&ip_hw_id->hw_id_kset);
 					return res;
 				}
 				if (hw_id_names[ii]) {
@@ -954,7 +954,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		res = kset_register(&ip_die_entry->ip_kset);
 		if (res) {
 			DRM_ERROR("Couldn't register ip_die_entry kset");
-			kfree(ip_die_entry);
+			kset_put(&ip_die_entry->ip_kset);
 			return res;
 		}
 
@@ -989,6 +989,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	res = kset_register(&adev->ip_top->die_kset);
 	if (res) {
 		DRM_ERROR("Couldn't register die_kset");
+		kset_put(&adev->ip_top->die_kset);
 		goto Err;
 	}
 
-- 
2.25.1

