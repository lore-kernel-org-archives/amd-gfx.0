Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67434606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=heMnyYzs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0184410F46B;
	Tue, 27 Oct 2026 12:56:55 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82E310F463
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkLZqoo7zc3WNIuXN9I4Ky+qHGi7tDjciOwlmYGrwBOaW5Y2BfiERU0iXcv62HHnwy5lbQZri0skJWNDvi3LYxlifmCU85APE+0ifnblwkA8h1AFJ5W9aq+nJ0cCUH9dww69p2niCHQmv+HES5jIatrdGn9NKtOPxF6W6HEbVPCj+OyjQhr/WTjltR2cNt5Kwpr7DDMrfv989J5mH/AsCY0Grf+9hMZevfIpwxlu73iKt7cZEfy3Nq7ya5a1Dz8ckju8Vrl0S1USN4rRYs+WYjLjnouQqdWAK+iutjTb5+Ai6R+GLMr77uDkWGGEWmewjtIg6oYZJq1d/9zBDhqovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhvl65Sa9FSMqYhiXHmsFIzXQRMiOXipakyZW1Hu2Vk=;
 b=BghuQIq10H1EMC5ix6yYOjzxsV+JZWqKcljK1cPukaqrPXyckQP7q/+AKrOf4ra0uKiwKZAHp6nJ6NU0+HMFCVfjJJyldRmpoekPSZueCnjY7bANKHowM/vXmXmHo8E0WNxFvjkpKuLYMhj+k6fRbz/ugqak1YRsxS/J8ecJEJgalgm4UAv0p8voD4ghCUrcjt2T8ENCJvNmf1SSVOQmMdxC+0umfkdsWD2Jz+SBbCAk6YXClGT+bxqwDZQUoMbrNnypggCHizoBOn1xBwFarlY21DJLlOfO3nIb3Oa5A5oPC1czOyZ6WNyjkj/oeEkkgNiDj+NxBsEJGF7SvxF67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhvl65Sa9FSMqYhiXHmsFIzXQRMiOXipakyZW1Hu2Vk=;
 b=heMnyYzscZSrAHrA/fm3h73m1kVCPIpzPUJqSg9hNtAzsp4w6y0mC/gvE+n3j/ZI0c5YhG7nq6jyq+aPBjCOji9Tg0fPngKKlQI029002n9Q+45pm/fkQ+1+nHNTwVPx0lbeCtRzFW3RO/V20Rgcyh63kUcrGq7hlg8fp/Mtb1k=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by CHBPR12MB697279.namprd12.prod.outlook.com (2603:10b6:610:36b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:43 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::48) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:43 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:39 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: Refactor amdgpu_virt_init_data_exchange
Date: Tue, 27 Oct 2026 08:56:08 -0400
Message-ID: <20261027125613.6549-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|CHBPR12MB697279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c92c1c1-6aa0-4c31-a60a-08df3429c02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|18002099003|22082099003|261026140227099003|56012099006|11063799006|261021121427099003|261021123027099003|261022075727099003|10067099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: nbjf+IIVBG68gAclIygUz2PFjxuZvGmKrb9U5TMpX5dYRHJ6ADJHWVhT8LnokDKSAfECdNa44twQI3XYzAR8cxitoxzqtn9RDQHf5b794cxJ8R/iyosAos869Wtry6OtwPgj7i/aOvEiNzx9xC12QjqkZD1lsE66lfGiUitbDl82dhLkb9rsDtG7p2LSV5dRI3A+HZY9Z8jmuNjfF9mM3RlEhdsMtIe0A+tw4uGipbcLsBcdnCkq0VfhhcULY606TOaWGS4UfYcjZmwTF8ssfCA82A+NK6/CWfpUFpUnqpa5h4pU3pzzt9wNWfbPlN/X8rwPfBtG59yYkvyEL/kEid1MHw7asyhIuJy/rAiAMbcyYnvOjLUveIm51OanAr6SE0vwA6RkEh/6lH7qMm+T4Zs4SHToJFgoTHbD/3hjylVDfXEmN30Jblf96gXV+uHSb6Azx8i4z+1SwL/lW/qHXwo8hZiR/CxdOQuUWSV/JaroFRdhY7PmAddgnFgfOSs64ZcYSGPWN2o1w2unpIgn9cKK+0inBLt+wz4+DjnTIMajX6JM8jTHYIGbsvdEAPJZL66CzzCYz/6lAQZUb0rlS3lCuHz/2GUGgf1VxkcSKJL7sthKazwTt1wADihm/u06JTTwYWAb83Hg4VSW3e1/hBm0aECFq3FNjvXXVn14X7EvJNnYzal/KXI7Ypn6QuaaTw/puoECHq7byDIfZ7oelA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(261026140227099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w5zHL+Xs5LuVCXN5goUlCM/z7AgjGyqk2mltPX8+BNYvYl3YG68ffuLxZfoGtyw7wPFM11zZEjp0kxOhHzCRhFOrF4ZJW2VnfwJVXLDg5zSIqlasB7lV2bHloJTAWo9e4waJTJC7NnXFZElY8Mc3AHR1K5F5VyvXv9sP8WF8E1To6fbGhfFs7OZelqL9+7qHJ0j6tUFCWLHlMP6ds0Xi6FoVlqC0VPj1iubGH1FP/defxVvPxsLAUJsTQ3MMlyigD0UvKR0Si1Qd38e9bl00ZQ3rNaO/5v/g8MdEO8rlTZVgr3vEQK+AEy9nIuix8+BmVCKKOnwpdkvES/zp/EeCdF2n+m9aHCahyCV1oCfgrtmMHp34tNEGN6RUBnPFXBoDGJTOGkA+pTuLRoX2UpJ2jEMk/XOcIva/Xbxtkfbpvon3Nre2jPxKru8Cqkp1R4NA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:43.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c92c1c1-6aa0-4c31-a60a-08df3429c02a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB697279
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The guest accesses exchange data 3 times during init.
Each time has a different usecase. Currently amdgpu_virt_init_data_exchange
is called all 3 times, making exchange init logic very confusing.

Split this function by each usecase:

1) Guest must read PF2VF reg_access flags prior to sw_init.
GMC IP is not yet init, so the access is done by reading VRAM directly,
without reserving the region. This is done through amdgpu_virt_read_pf2vf_data_early

2) After GMC Init, guest reads the Bad Page table and reserves all bad pages.
At this point, the exchange region is reserved and the mapped VA is available.
This is done through amdgpu_virt_exchange_data

3) After IP Init, guest must write the VF2PF data and start
the VF2PF worker thread. This is done through amdgpu_virt_start_xchg_work

For resets, only the VF2PF worker thread must be restarted.
This is done through amdgpu_virt_start_xchg_work.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 284 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  10 +-
 6 files changed, 164 insertions(+), 165 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dcc029bccd74..54ef47126b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2155,9 +2155,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				}
 			}
 
-			/*get pf2vf msg info at it's earliest time*/
 			if (amdgpu_sriov_vf(adev))
-				amdgpu_virt_init_data_exchange(adev);
+				amdgpu_virt_read_pf2vf_data_early(adev);
 
 		}
 	}
@@ -2407,7 +2406,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			}
 			adev->ip_blocks[i].status.hw = true;
 		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
-			/* need to do gmc hw init early so we can allocate gpu mem */
 			/* Try to reserve bad pages early */
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_virt_exchange_data(adev);
@@ -2456,7 +2454,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_xchg_start_work(adev);
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
@@ -3222,7 +3220,7 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 	int r;
 
 	if (amdgpu_sriov_vf(adev)) {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
@@ -4292,7 +4290,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 */
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_request_full_gpu(adev, false);
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 	}
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
@@ -4547,7 +4545,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev)) {
 		if (!adev->in_runpm)
 			amdgpu_amdkfd_suspend_process(adev);
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
 		if (r)
 			return r;
@@ -4729,7 +4727,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
 	if (amdgpu_sriov_vf(adev)) {
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_xchg_start_work(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
 
 		if (!r && !adev->in_runpm)
@@ -4816,7 +4814,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_virt_init_data_exchange(adev);
+	amdgpu_virt_xchg_start_work(adev);
 
 	r = amdgpu_device_fw_loading(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b053aa883592..301b41f5787e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -640,7 +640,7 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
 {
 	/* stop the data exchange thread */
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_xchg_stop_work(adev);
 	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index e1cf6fe71e96..1d5b74be5e08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -484,8 +484,6 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
-int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
-void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
@@ -529,6 +527,9 @@ bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev, const struct eeprom_tab
 int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev);
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev, int data_id,
 				      uint8_t *binary, u32 *size);
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev);
+int amdgpu_virt_exchange_data(struct amdgpu_device *adev);
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev);
+void amdgpu_virt_xchg_stop_work(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
index e6e651efd0e8..55f20d99feea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -277,31 +277,87 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
-static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+static void amdgpu_virt_add_bad_pages(struct amdgpu_device *adev)
 {
-	uint32_t dataexchange_offset =
-		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
-	uint32_t dataexchange_size =
-		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
-	uint64_t pos = 0;
+	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
+	uint64_t bp_block_offset, retired_page;
+	uint32_t bp_block_size, bp_idx, bp_cnt;
+	struct eeprom_table_record bp = { 0 };
 
-	dev_info(adev->dev,
-			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
-			dataexchange_offset, dataexchange_size);
+	if (adev->virt.xchg.p_pf2vf->version != 2)
+		return;
 
-	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
-		dev_err(adev->dev, "Data exchange data not aligned to 4 bytes\n");
-		return -EINVAL;
+	pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.xchg.p_pf2vf;
+	bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
+		((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
+	bp_block_size = pf2vf_v2->bp_block_size;
+
+	if (!bp_block_size)
+		return;
+
+	if (!adev->virt.ras_init_done)
+		amdgpu_virt_init_ras_err_handler_data(adev);
+
+	if (adev->virt.ras_init_done) {
+		bp_cnt = bp_block_size / sizeof(uint64_t);
+		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+			retired_page = *(uint64_t *)(adev->virt.xchg.va +
+					bp_block_offset + bp_idx * sizeof(uint64_t));
+			bp.retired_page = retired_page;
+
+			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+				continue;
+
+			if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+				break;
+
+			amdgpu_virt_ras_reserve_bps(adev);
+		}
 	}
+}
+
+void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev)
+{
+	void *pfvf_data;
+	uint32_t size;
+
+	switch (adev->virt.xchg.req_init_data_ver) {
+	case GPU_CRIT_REGION_V2:
+		/*
+		 * This one time pass is expected only one time, before TTM has made
+		 * xchg reservations. Use a temporary buffer to get pf2vf data needed for init.
+		 */
+		size = adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+		pfvf_data = kzalloc(size, GFP_KERNEL);
+		if (!pfvf_data) {
+			dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
+			return;
+		}
 
-	pos = (uint64_t)dataexchange_offset;
-	amdgpu_device_vram_access(adev, pos, pfvf_data,
-			dataexchange_size, false);
+		if (amdgpu_virt_get_dynamic_data_info(adev,
+						      AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+						      pfvf_data,
+						      &size)) {
+			kfree(pfvf_data);
+			return;
+		}
 
-	return 0;
+		adev->virt.xchg.p_pf2vf = (struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+		amdgpu_virt_read_pf2vf_data(adev);
+		adev->virt.xchg.p_pf2vf = NULL;
+		kfree(pfvf_data);
+		return;
+	case GPU_CRIT_REGION_V1:
+	default:
+		adev->virt.xchg.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+		amdgpu_virt_read_pf2vf_data(adev);
+		return;
+	}
 }
 
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
+void amdgpu_virt_xchg_stop_work(struct amdgpu_device *adev)
 {
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		dev_info(adev->dev, "clean up the vf2pf work item\n");
@@ -310,151 +366,93 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 	}
 }
 
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+static int amdgpu_virt_xchg_set_data_table_va(struct amdgpu_device *adev)
 {
-	uint32_t *pfvf_data = NULL;
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
 	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
 
-	adev->virt.xchg.p_pf2vf = NULL;
-	adev->virt.xchg.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (fw_va && drv_va) {
-		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
-	} else if (fw_va || drv_va) {
-		/* go through this logic in ip_init and reset to init workqueue*/
-		amdgpu_virt_exchange_data(adev);
-
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
-	} else if (adev->bios != NULL) {
-		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		if (adev->virt.xchg.req_init_data_ver == GPU_CRIT_REGION_V2) {
-			pfvf_data =
-				kzalloc(adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
-					GFP_KERNEL);
-			if (!pfvf_data) {
-				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
-				return;
-			}
-
-			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
-				goto free_pfvf_data;
+		dev_err(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
+		return -EINVAL;
+	}
 
-			adev->virt.xchg.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+	if (fw_va)
+		adev->virt.xchg.va = fw_va;
+	if (drv_va)
+		adev->virt.xchg.va = drv_va;
 
-			amdgpu_virt_read_pf2vf_data(adev);
+	if (!adev->virt.xchg.va) {
+		dev_err(adev->dev, "Invalid virt exchange address\n");
+		return -EINVAL;
+	}
 
-free_pfvf_data:
-			kfree(pfvf_data);
-			pfvf_data = NULL;
-			adev->virt.xchg.p_pf2vf = NULL;
-		} else {
-			adev->virt.xchg.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-
-			amdgpu_virt_read_pf2vf_data(adev);
-		}
+	switch (adev->virt.xchg.req_init_data_ver) {
+	case GPU_CRIT_REGION_V2:
+		adev->virt.xchg.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->virt.xchg.va +
+			adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
+		adev->virt.xchg.p_vf2pf =
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			(adev->virt.xchg.va +
+			adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
+			(AMD_SRIOV_MSG_SIZE_KB << 10));
+		adev->virt.xchg.ras_telemetry =
+			(adev->virt.xchg.va +
+			adev->virt.xchg.tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
+		break;
+	case GPU_CRIT_REGION_V1:
+	default:
+		adev->virt.xchg.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->virt.xchg.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+		adev->virt.xchg.p_vf2pf =
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			(adev->virt.xchg.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+		adev->virt.xchg.ras_telemetry =
+			(adev->virt.xchg.va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+		break;
 	}
+
+	return 0;
 }
 
-static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
-		uint64_t bp_block_offset, uint32_t bp_block_size)
+int amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 {
-	struct eeprom_table_record bp;
-	uint64_t retired_page;
-	uint32_t bp_idx, bp_cnt;
-	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
-	void *vram_usage_va = fw_va ? fw_va : drv_va;
-
-	memset(&bp, 0, sizeof(bp));
-
-	if (!bp_block_size)
-		return;
+	int r;
 
-	bp_cnt = bp_block_size / sizeof(uint64_t);
-	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-		retired_page = *(uint64_t *)(vram_usage_va +
-				bp_block_offset + bp_idx * sizeof(uint64_t));
-		bp.retired_page = retired_page;
+	r = amdgpu_virt_xchg_set_data_table_va(adev);
+	if (r)
+		return r;
 
-		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-			continue;
+	r = amdgpu_virt_read_pf2vf_data(adev);
+	if (r)
+		return r;
+	r = amdgpu_virt_write_vf2pf_data(adev);
+	if (r)
+		return r;
 
-		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
-			break;
+	amdgpu_virt_add_bad_pages(adev);
 
-		amdgpu_virt_ras_reserve_bps(adev);
-	}
+	return r;
 }
 
-void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
+int amdgpu_virt_xchg_start_work(struct amdgpu_device *adev)
 {
-	uint64_t bp_block_offset = 0;
-	uint32_t bp_block_size = 0;
-	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
-	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
-	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
-
-	if (fw_va || drv_va) {
-		if (fw_va) {
-			if (adev->virt.xchg.req_init_data_ver == GPU_CRIT_REGION_V2) {
-				adev->virt.xchg.p_pf2vf =
-					(struct amd_sriov_msg_pf2vf_info_header *)
-					(fw_va +
-					adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
-				adev->virt.xchg.p_vf2pf =
-					(struct amd_sriov_msg_vf2pf_info_header *)
-					(fw_va +
-					adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
-					(AMD_SRIOV_MSG_SIZE_KB << 10));
-				adev->virt.xchg.ras_telemetry =
-					(fw_va +
-					adev->virt.xchg.tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
-			} else {
-				adev->virt.xchg.p_pf2vf =
-					(struct amd_sriov_msg_pf2vf_info_header *)
-					(fw_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-				adev->virt.xchg.p_vf2pf =
-					(struct amd_sriov_msg_vf2pf_info_header *)
-					(fw_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-				adev->virt.xchg.ras_telemetry =
-					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
-			}
-		} else if (drv_va) {
-			adev->virt.xchg.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(drv_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-			adev->virt.xchg.p_vf2pf =
-				(struct amd_sriov_msg_vf2pf_info_header *)
-				(drv_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-			adev->virt.xchg.ras_telemetry =
-				(drv_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
-		}
+	int r;
 
-		amdgpu_virt_read_pf2vf_data(adev);
-		amdgpu_virt_write_vf2pf_data(adev);
-
-		/* bad page handling for version 2 */
-		if (adev->virt.xchg.p_pf2vf->version == 2) {
-			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.xchg.p_pf2vf;
+	r = amdgpu_virt_exchange_data(adev);
+	if (r)
+		return r;
 
-			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
-				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
-			bp_block_size = pf2vf_v2->bp_block_size;
+	INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+	schedule_delayed_work(&(adev->virt.vf2pf_work),
+				msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 
-			if (bp_block_size && !adev->virt.ras_init_done)
-				amdgpu_virt_init_ras_err_handler_data(adev);
-
-			if (adev->virt.ras_init_done)
-				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
-		}
-	}
+	return r;
 }
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
@@ -601,7 +599,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 				  adev->virt.xchg.offset,
 				  adev->virt.xchg.size, true);
 	dev_info(adev->dev,
-		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
+		 "critical region v%d requested to reserve memory start at 0x%llx with %llu KB.\n",
 			init_data_hdr->version,
 			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
 			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
@@ -628,17 +626,19 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	data_offset = adev->virt.xchg.tbl[data_table_id].offset;
 	data_size = adev->virt.xchg.tbl[data_table_id].size_kb << 10;
 
-	/* Validate on input params */
 	if (!binary || !size || *size < (uint64_t)data_size)
 		return -EINVAL;
 
-	/* Proceed to copy the dynamic content */
 	amdgpu_device_vram_access(adev,
-			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+				  (uint64_t)data_offset,
+				  (uint32_t *)binary,
+				  data_size,
+				  false);
+
 	*size = (uint64_t)data_size;
 
 	dev_dbg(adev->dev,
-		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		"Got %s info from exchange table at offset 0x%x with size of 0x%x bytes.\n",
 		amdgpu_virt_table_name[data_id], data_offset, data_size);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 45cba3bde580..aaa600bfa73c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -275,7 +275,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	struct amdgpu_reset_context reset_context = { 0 };
 
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_xchg_stop_work(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -297,7 +297,7 @@ static void xgpu_ai_mailbox_req_bad_pages_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 		amdgpu_virt_request_bad_pages(adev);
 		up_read(&adev->reset_domain->sem);
 	}
@@ -316,8 +316,8 @@ static void xgpu_ai_mailbox_handle_bad_pages_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		amdgpu_virt_fini_data_exchange(adev);
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
+		amdgpu_virt_xchg_start_work(adev);
 		up_read(&adev->reset_domain->sem);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 89ee81238d22..e7d664b2c99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -379,7 +379,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	struct amdgpu_reset_context reset_context = { 0 };
 
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_xchg_stop_work(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -404,7 +404,7 @@ static void xgpu_nv_mailbox_req_bad_pages_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 		amdgpu_virt_request_bad_pages(adev);
 		up_read(&adev->reset_domain->sem);
 	}
@@ -423,8 +423,8 @@ static void xgpu_nv_mailbox_handle_bad_pages_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		amdgpu_virt_fini_data_exchange(adev);
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
+		amdgpu_virt_xchg_start_work(adev);
 		up_read(&adev->reset_domain->sem);
 	}
 }
@@ -565,7 +565,7 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
 		xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
 	} else {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_xchg_stop_work(adev);
 		xgpu_nv_send_access_requests_with_param(adev,
 					IDH_RAS_POISON,	block, 0, 0);
 	}
-- 
2.34.1

