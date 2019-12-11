Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB3C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACC720836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z0JtU1kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACC720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0A56E06B;
	Wed, 11 Dec 2019 20:07:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7082B6E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMey+9tuiqcA2PDcuZjDySScTIF41hAQfNBXCgfGxPPoDkyFDD3+RdKhJ9e2cY/fV4q3iW+3ifZ02RkJmRnauWDZxYEhq2gneaffmW3TUYpnDWJOR9tgntb+XP5EpaI9oFO7fh0MsO6TMaV8pJA1wCrEwH+M1fh1PDIB9GBE+SmA9SU63nq7rQtOHhWnP+3Wj59ivMeUcGYNZQ8qVjZCsFBbmutMIeVcrcWoI2uvEB7HZwpGieKm1f5PpZ+KHmaGSkyG6BN7sY4+fRNAdcn6BOUohlAYvc7pcm3ufg2xH+ZNZHUCoZI0pLlZkThr4pD7pX1xsKZWGj+Ylfed8ovzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSTWVqIEOuFNnA5my3jMbtcRLRuG7+9bv97JjVHbz8I=;
 b=SyUwXtvsFKXSVD7jbi+bbblE6ObMy3JAFW0fzs5bETsoI9RK+Q5hfsnYzTxQqL7AitL71Xt91Hy+22EW/hy3je+H2xR9dUbnsRZ5jfyN11bV2wh9twr8oC7GtUuZ1vUytDMO/syHjQXrJwhR3nUdTSBTwSZ6HtRWc2tzOp+uJp5b4J6sk7A+hDnO2ZkTErj+3wYI8tXRILJwrWv0aT21/MPNr4Ae78JRGEpTCdNDP4kAu7jA9AtONmU2ixW709X+mPWQOIWj4QzMFQJj58Gw+lh46sa6s8FChD9/2zdSyFKwY8SKZ95XbdSh34DQzeVIVFciGtnDh//8X5/wMPI0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSTWVqIEOuFNnA5my3jMbtcRLRuG7+9bv97JjVHbz8I=;
 b=Z0JtU1kLRpJxV/QIu5VbkviyMJqbXJVEiXvC+u0xWTwH8SpsWU9OYulp4PoYdT6Y8vS2rBUc0p2IC0lXiDlCv3GWJfOtrBYdFyocJHFk5dekAE7zJE3RIbx1pLL9/eBgdFN2ao+Wdsrcw9Z3QP8S+2huX80rp+zEF69lexmd3sU=
Received: from CY4PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:910:16::22) by CY4PR12MB1784.namprd12.prod.outlook.com
 (2603:10b6:903:11e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 20:07:18 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by CY4PR1201CA0012.outlook.office365.com
 (2603:10b6:910:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 20:07:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 20:07:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:17 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:16 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:07:16 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: reverts commit
 b01245ff54db66073b104ac9d9fbefb7b264b36d.
Date: Wed, 11 Dec 2019 15:07:05 -0500
Message-ID: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(428003)(189003)(199004)(7696005)(478600001)(8936002)(316002)(8676002)(4326008)(54906003)(2906002)(44832011)(36756003)(70586007)(426003)(6666004)(81156014)(2616005)(70206006)(336012)(86362001)(6916009)(26005)(186003)(5660300002)(356004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1784; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453c0734-c80e-4406-4501-08d77e75b96b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1784:
X-Microsoft-Antispam-PRVS: <CY4PR12MB178407C1C644ADBB2D7AE960EA5A0@CY4PR12MB1784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtupHfWcFRj6APR6+dzSbCkMTLsGhYDziTMwW4ip0GbM9IQ7sbITqB2mK99FfBUwyrQWntju2DV8OArsLw5yyP08v9IW171mMFzU0Dkau2989uL8L9HX8MvC6iLGb36Vl5KAjYRyRDpzV8FC+LmF4BDEvrdC7VGqWJ8OSRqBZlxBQMHScECPEVJFhXvGtjeTk8FvOvQhu10PAt2rHFni+jlGUB7B80lQH+/8a4IsFd+cQAvERmBsO7dUsMxDgcZcba6nuIGQWfCg654LQEaN81xlumU4JlmnhK5FfLy7CDwnQv1VrjT/Bp/zdYIOy1BBbCFwcYtJiPFRrSRBV52OLe9S2b2RtyevgLvHTX4dZ8pcRw2Dv3T2T2tGpak8fBfeWlsYtRxaCleCrbviWK1PABwmQrqVJz2aEfMRsA+WdCRRP9Z2QcLAeDpfAOHuCPBS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 20:07:18.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c0734-c80e-4406-4501-08d77e75b96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1784
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Evan.Quan@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In preparation for doing XGMI reset synchronization using task barrier.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 76 +++++-------------------------
 2 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a78a363..50bab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1001,8 +1001,6 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
-
-	bool				in_baco;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7324a5f..1d19edfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2667,7 +2667,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
 		adev->asic_reset_res = (adev->in_baco == false) ?
 				amdgpu_device_baco_enter(adev->ddev) :
-				amdgpu_device_baco_exit(adev->ddev);
+				qamdgpu_device_baco_exit(adev->ddev);
 	else
 		adev->asic_reset_res = amdgpu_asic_reset(adev);
 
@@ -3796,18 +3796,13 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
-			       struct amdgpu_hive_info *hive,
+static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
 			       bool *need_full_reset_arg)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
 	int r = 0;
-	int cpu = smp_processor_id();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
 
 	/*
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
@@ -3815,62 +3810,22 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 	 */
 	if (need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-			/*
-			 * For XGMI run all resets in parallel to speed up the
-			 * process by scheduling the highpri wq on different
-			 * cpus. For XGMI with baco reset, all nodes must enter
-			 * baco within close proximity before anyone exit.
-			 */
+			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work_on(cpu, system_highpri_wq,
-						   &tmp_adev->xgmi_reset_work))
+				if (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
-				cpu = cpumask_next(cpu, cpu_online_mask);
 			} else
 				r = amdgpu_asic_reset(tmp_adev);
-			if (r)
-				break;
-		}
-
-		/* For XGMI wait for all work to complete before proceed */
-		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					flush_work(&tmp_adev->xgmi_reset_work);
-					r = tmp_adev->asic_reset_res;
-					if (r)
-						break;
-					if (use_baco)
-						tmp_adev->in_baco = true;
-				}
-			}
-		}
 
-		/*
-		 * For XGMI with baco reset, need exit baco phase by scheduling
-		 * xgmi_reset_work one more time. PSP reset and sGPU skips this
-		 * phase. Not assume the situation that PSP reset and baco reset
-		 * coexist within an XGMI hive.
-		 */
-
-		if (!r && use_baco) {
-			cpu = smp_processor_id();
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					if (!queue_work_on(cpu,
-						system_highpri_wq,
-						&tmp_adev->xgmi_reset_work))
-						r = -EALREADY;
-					if (r)
-						break;
-					cpu = cpumask_next(cpu, cpu_online_mask);
-				}
+			if (r) {
+				DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
+					 r, tmp_adev->ddev->unique);
+				break;
 			}
 		}
 
-		if (!r && use_baco) {
+		/* For XGMI wait for all PSP resets to complete before proceed */
+		if (!r) {
 			list_for_each_entry(tmp_adev, device_list_handle,
 					    gmc.xgmi.head) {
 				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -3878,21 +3833,15 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 					r = tmp_adev->asic_reset_res;
 					if (r)
 						break;
-					tmp_adev->in_baco = false;
 				}
 			}
 		}
-
-		if (r) {
-			DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
-				 r, tmp_adev->ddev->unique);
-			goto end;
-		}
 	}
 
 	if (!r && amdgpu_ras_intr_triggered())
 		amdgpu_ras_intr_cleared();
 
+
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
@@ -4181,8 +4130,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(adev, hive, device_list_handle,
-					  &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
