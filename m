Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F93C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 12:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF000206E9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 12:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sTpCEi06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF000206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971EE6E2E8;
	Thu, 16 Apr 2020 12:00:53 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690057.outbound.protection.outlook.com [40.107.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977116E2E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 12:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz62EKbOJ5nkJHY252wwoYnAly+S1D3EMrMR/uXek3PQE1HUc4HeqO9I0AZYMeGpkAhdXTx6AvphWaWcp+ZhUHEs077li/r+hqZjx01Ty9RUH0kR8cgwCaa0Fek+5pltstKdIMgM0eiNaxhBc5ELVc3vYysJUCoe/YG54KJBccni/0NmC2Hjvx8WRsyWFwCcOUsiVxHzbh7dDprAu89tPn14VMFvJ1OqAk1tJYjWOvCbgqMFgPgBjnUgbm90OylyjkrGGWMscS8KREfegMlMZBaM7LuqcAbC/Hc+DiT5cw3kxycsPbUnnO9lyXq/nKB89sSIB7z/nyT9Z1JJjZCcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzVfV5Y5ZrFhuKgaC1nhfz5xsg1loYJyQS3K7VhdfI4=;
 b=jTpV/qnbo66RAwlXfRwyGcYQLQxy0LI2wx3hIt943Fz2PFG1djHDMoZYNZAGhvEfkxs8DRYWVgONAvylnxj9D2/cMSeZn3Wd9ZoovJT8xatlqgQmC0E+WDls9a7StsgnRLyeBTj7bfClD3yFED+SxqkS6Ozn8Ywjo2lN49QYKbgjbG9I/zyPWnDx8CsFwDEFBb/8MpmlQ4x1Zn4Aa0HfC1TzLE9zagk/us0dH3xaUI2ZXH0Ul7toG+K6SB34EZYXINicIvagrOJM9eYjVl9G6/ReVDyfGPreG0Vpp36bqP9UHjWK3fyyU5U8jk2WvNQXiYVnqBPYTyZbTn4OcOIG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzVfV5Y5ZrFhuKgaC1nhfz5xsg1loYJyQS3K7VhdfI4=;
 b=sTpCEi06rMZ057bAJl9PSDTC7Hlco2CC22Icu0A119lMvtHb+z3cG8svfb7x7P12dM+VyF3ILzjcQH1Uj+omXbNdJ/FKB8RG54fL1zbDX3C9gwFbqGcr1AyW2+mm6LnDicLVMXfB3RLzo76ZY0y7b5DHLGW4Au5QKPYKqSsVl6k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 12:00:49 +0000
Received: from MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0]) by MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0%5]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 12:00:49 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdgpu: fix race between pstate and remote buffer map
Date: Thu, 16 Apr 2020 07:59:53 -0400
Message-Id: <20200416115953.80843-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To MN2PR12MB4518.namprd12.prod.outlook.com
 (2603:10b6:208:266::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 12:00:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe5f54ff-c0a5-4cc2-970c-08d7e1fdcdc7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4439:|MN2PR12MB4439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB443919ADAF545C57EB5EAF2685D80@MN2PR12MB4439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(2906002)(8936002)(8676002)(6636002)(5660300002)(478600001)(81156014)(7696005)(956004)(6666004)(52116002)(44832011)(1076003)(316002)(6486002)(16526019)(36756003)(186003)(37006003)(34206002)(66946007)(4326008)(66556008)(26005)(54906003)(2616005)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gd4WNswK8nIg1ChnD4AqKPtuAzZWeoStnAEzFZpiJyJ/bWSE6pG4lsb6IWwN7ENlbtvk5BaOV6Ci5PA+feRAOV3EuaO/UkfaAx1g7Nd0hJAxHfGOvO24fMQ01rCLI+6quxjiIVqns3T+o8jIyL1UcrVMMZXtTog4MDKJ9U7sYRddmSDQif6z+vvV7T/mlqcZnqv2QMFcM+wTlv26LHnVkBdA1gaCceYpLPc99QGjYl9UsUDs2cJr9UlJza7+iX1jDv4R27hAKVZkBnJs7FPoUFpNiraAqeCZqZYO/axu0Xtfr8PXwych/w4wv8rlvEM9aaJOZD2VuEwPCKdeQthte+dE6rcCSujyElSkAXxaunkX8ZQFolXLjHgM+7MiBlWA3FWyrG2ATsGKqy4guOltH28IBeUNesgAefm8rpjE2lPKZYLp9APols3qPhuMV8mh
X-MS-Exchange-AntiSpam-MessageData: bUv6QhO5YxKk7Ko0mplJGUSYrolskIkqmCGszy2iMiby4Akhlhi8k9EZQQBkuUHvJLibqXzg9gu3sOpyEOiR7KDX7yOfGtNc+ZqQM6nKW7oDo4OhABYQYh0OgubsOBsxsFl4ydbuclypLv3fFVJivQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5f54ff-c0a5-4cc2-970c-08d7e1fdcdc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 12:00:49.4944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfqVbLlGpceOYqLSSxrvLzxxej+LSUnf0x4VaP7X81WddJTKXdkA+Ot2Qs+OSJfj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vega20 arbitrates pstate at hive level and not device level. Last peer to
remote buffer unmap could drop P-State while another process is still
remote buffer mapped.

With this fix, P-States still needs to be disabled for now as SMU bug
was discovered on synchronous P2P transfers.  This should be fixed in the
next FW update.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 16 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 66 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  6 +++
 5 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e1d4cfe7a9f..94dff899248d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -982,8 +982,6 @@ struct amdgpu_device {
 	uint64_t			unique_id;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
-	/* device pstate */
-	int				pstate;
 	/* enable runtime pm on the device */
 	bool                            runpm;
 	bool                            in_runpm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index accbb34ea670..95560eea61c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2135,11 +2135,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	if (bo && amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
 	    (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
 		bo_va->is_xgmi = true;
-		mutex_lock(&adev->vm_manager.lock_pstate);
 		/* Power up XGMI if it can be potentially used */
-		if (++adev->vm_manager.xgmi_map_counter == 1)
-			amdgpu_xgmi_set_pstate(adev, 1);
-		mutex_unlock(&adev->vm_manager.lock_pstate);
+		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MAX_VEGA20);
 	}
 
 	return bo_va;
@@ -2562,12 +2559,8 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 
 	dma_fence_put(bo_va->last_pt_update);
 
-	if (bo && bo_va->is_xgmi) {
-		mutex_lock(&adev->vm_manager.lock_pstate);
-		if (--adev->vm_manager.xgmi_map_counter == 0)
-			amdgpu_xgmi_set_pstate(adev, 0);
-		mutex_unlock(&adev->vm_manager.lock_pstate);
-	}
+	if (bo && bo_va->is_xgmi)
+		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
 
 	kfree(bo_va);
 }
@@ -3177,9 +3170,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 
 	idr_init(&adev->vm_manager.pasid_idr);
 	spin_lock_init(&adev->vm_manager.pasid_lock);
-
-	adev->vm_manager.xgmi_map_counter = 0;
-	mutex_init(&adev->vm_manager.lock_pstate);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea771d84bf2b..c8e68d7890bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -357,10 +357,6 @@ struct amdgpu_vm_manager {
 	 */
 	struct idr				pasid_idr;
 	spinlock_t				pasid_lock;
-
-	/* counter of mapped memory through xgmi */
-	uint32_t				xgmi_map_counter;
-	struct mutex				lock_pstate;
 };
 
 #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((adev)->vm_manager.vm_pte_funcs->copy_pte((ib), (pe), (src), (count)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8c3215505e78..52f45b9fe271 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -373,7 +373,13 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 
 	if (lock)
 		mutex_lock(&tmp->hive_lock);
-	tmp->pstate = -1;
+	tmp->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
+	tmp->high_gpu = NULL;
+	/*
+	 * hive pstate on boot is high in vega20 so we have to go to low
+	 * pstate on after boot.
+	 */
+	tmp->map_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
 	mutex_unlock(&xgmi_mutex);
 
 	return tmp;
@@ -383,50 +389,49 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 {
 	int ret = 0;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
-	struct amdgpu_device *tmp_adev;
-	bool update_hive_pstate = true;
-	bool is_high_pstate = pstate && adev->asic_type == CHIP_VEGA20;
+	struct amdgpu_device *tar_adev = hive->high_gpu ?
+							hive->high_gpu : adev;
+	bool map = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
+	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
 
-	if (!hive)
+	if (!hive || adev->asic_type == CHIP_VEGA20)
 		return 0;
 
 	mutex_lock(&hive->hive_lock);
 
-	if (hive->pstate == pstate) {
-		adev->pstate = is_high_pstate ? pstate : adev->pstate;
+	if (map)
+		hive->map_count++;
+	else
+		hive->map_count--;
+
+	/*
+	 * Vega20 only needs single peer to request pstate high for the hive to
+	 * go high but all peers must request pstate low for the hive to go low
+	 */
+	if (hive->pstate == pstate || (!map && hive->map_count && !init_low))
 		goto out;
-	}
 
-	dev_dbg(adev->dev, "Set xgmi pstate %d.\n", pstate);
+	dev_dbg(tar_adev->dev, "Set xgmi pstate %d.\n", pstate);
 
-	ret = amdgpu_dpm_set_xgmi_pstate(adev, pstate);
+	ret = amdgpu_dpm_set_xgmi_pstate(tar_adev, pstate);
 	if (ret) {
-		dev_err(adev->dev,
+		dev_err(tar_adev->dev,
 			"XGMI: Set pstate failure on device %llx, hive %llx, ret %d",
-			adev->gmc.xgmi.node_id,
-			adev->gmc.xgmi.hive_id, ret);
+			tar_adev->gmc.xgmi.node_id,
+			tar_adev->gmc.xgmi.hive_id, ret);
 		goto out;
 	}
 
-	/* Update device pstate */
-	adev->pstate = pstate;
-
-	/*
-	 * Update the hive pstate only all devices of the hive
-	 * are in the same pstate
-	 */
-	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-		if (tmp_adev->pstate != adev->pstate) {
-			update_hive_pstate = false;
-			break;
-		}
-	}
-	if (update_hive_pstate || is_high_pstate)
+	if (init_low)
+		hive->pstate = hive->map_count ?
+					hive->pstate : AMDGPU_XGMI_PSTATE_MIN;
+	else {
 		hive->pstate = pstate;
-
+		hive->high_gpu = pstate != AMDGPU_XGMI_PSTATE_MIN ?
+							adev : NULL;
+	}
 out:
 	mutex_unlock(&hive->hive_lock);
-
 	return ret;
 }
 
@@ -507,9 +512,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		goto exit;
 	}
 
-	/* Set default device pstate */
-	adev->pstate = -1;
-
 	top_info = &adev->psp.xgmi_context.top_info;
 
 	list_add_tail(&adev->gmc.xgmi.head, &hive->device_list);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d5a63904ec33..b5c4acf2316d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,6 +25,10 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
 
+#define AMDGPU_XGMI_PSTATE_UNKNOWN	-1
+#define AMDGPU_XGMI_PSTATE_MIN		0
+#define AMDGPU_XGMI_PSTATE_MAX_VEGA20	1
+
 struct amdgpu_hive_info {
 	uint64_t		hive_id;
 	struct list_head	device_list;
@@ -34,6 +38,8 @@ struct amdgpu_hive_info {
 	struct device_attribute dev_attr;
 	struct amdgpu_device *adev;
 	int pstate; /*0 -- low , 1 -- high , -1 unknown*/
+	int map_count;
+	struct amdgpu_device *high_gpu;
 	struct task_barrier tb;
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
