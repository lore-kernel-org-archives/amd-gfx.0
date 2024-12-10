Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294AAE7718B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EB710E9EC;
	Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lkCta7c2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AD010E9E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB28zJVsykbOUgl7CJGv0ZPY9/wQ/uByrpMEjqMomH3vagASrEiMAoWc3shbuTM7pgQ+WuyR1RGpj14EnZ9CsiK8wqtTWWdyNBzloRoHqSB/jej2EW9GuamlYe3abglLBvPWqgNL01w2rcrvWhS67F90MadOHAz3a6cm/e48dj0/cPvU6SfJliytv3lXXfRsmcDmwII83IDEzDrwfdyKXDdTKE+ohiOkonOTtAhhbZyniJZXtagGLp8svaS39PiuIn4VXpA/hxy1UaftavsQaC1XXcr7/6ZSA+0fypMFUZ+hqnHkdPYYzV7OQwCCNB83CMbVUNyNy73vU98inAhmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frFHVbQH48u1FfO2M0plgt/iR4EgZnoCuIQr9zlV7eM=;
 b=Bt6y339kQqlSZvcAw1nY74ucWXYST0uQJR94BhhbwdPlDK2IlhiV3tSX/5BVOPEDcCqCOn3BizMJAa43nWOV+5tDPtAjCcazwXBDzCuqJjeGsjIp8Ov0W+BpFCBqv36pgVrGZ9SRDSTpJiW8WykKidTzgqKWcLQORhzcX8b3BafjrxPS4TWsEZSK03G+qYypm3aMkTcnaL+niUO1gyeHHyDWO313oyB4/qgp75mmGCzaqXR5kv255SjtwpzAalVkwIP8X4LWio3f+GUxY51zco1fAdVR4FZIaitIt0xFUJaecWmd7fixQVXjTkIWfct3laarnaBjH5dEAqiDC6YgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frFHVbQH48u1FfO2M0plgt/iR4EgZnoCuIQr9zlV7eM=;
 b=lkCta7c21DpQUiWwp3QtqUjduXrRkRbkmQtmIYA4t0Fr562Uf/V+nxp6ifTTKlxGyG+7jDcYuUIrirtr3C+secl8Ypt7Df5vqJch2uMJfmamuIZRJGWiN+o0y7VGmCbbERlCNL1QUoA5QOkVnQmoTWAW4A6dT+zKSK2AFGi9LZg=
Received: from MN2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:c0::29)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 22:54:13 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::cb) by MN2PR05CA0016.outlook.office365.com
 (2603:10b6:208:c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Tue,
 10 Dec 2024 22:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/48] drm/amdgpu/vcn3.0: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:15 -0500
Message-ID: <20241210225337.75394-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a8e816-f08b-40bb-2372-08dd196d90d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u5zXTf0E9jeGENwAtMeb+KTx/pj+J3lb0ygKs82qQnxne+p3RMAH6hPz5LI4?=
 =?us-ascii?Q?ZNbPZtQEkUq1ALo/N6PAI5vmDhjlfZP2hYwwc7hHsztA5zxSe/sGtPS3SX38?=
 =?us-ascii?Q?+xRMf2eJWCqcLnEj/o3j9TsTIiRGj1upUTS9H31lgCNhUi8iL0BQBvl+PgaP?=
 =?us-ascii?Q?aopIdYSjTLTKUCV/HNeElIrgHCsSsUa3oDnNMpXWxozJl2T6A9hzv1DL58bp?=
 =?us-ascii?Q?zqrZ0GYkB5bPy+Ll1X1lA46aFFzI2E7C9VpvpGnyIcE+JsQMYyQTj7XqskQV?=
 =?us-ascii?Q?I5/wdANio0RZ4FIxcMQ+VnOqseqmiZrrMR/xnmWRlC2x9QMETas0wILivJOi?=
 =?us-ascii?Q?UOycwmpgedB5T5+tUQsNH83T7ReGhpSnioniGbRONh/AvJdM472jNFzV1xoe?=
 =?us-ascii?Q?q9v1+XJiPzrvSrdydYCVOAajcoJHfywXuuxCUoe8B/FvcMXaorkum4ysSvIK?=
 =?us-ascii?Q?QJ2s3wvRgXJB6P9D9/LDsYR6zux0jcgwtzp4GvInhWT0y+hoojmsaJuabw9v?=
 =?us-ascii?Q?vwjAPWmEt6RZCQPoqUJ0GUrawMSO10cGnEZBT6I9ax0D8ln1MUnyj5gyYL3o?=
 =?us-ascii?Q?62CYhRfRlaRvf+gtO4i2fqqtxrHmx6kGSFMh+LOf4aAZhK+be9eT/M6TSp8t?=
 =?us-ascii?Q?xZgAE9IaY5ZdGTa7Uf+FRzNNnGTB709jp5aAr8SC0Er7gdgAlHyWbCfq3QMr?=
 =?us-ascii?Q?I47bXZjyU1tKrsxQ8322gntTcr/jp6WcN5mCKPtkA09nKKXx0tiyAheCLy56?=
 =?us-ascii?Q?5Pgq04PjNuvJkY5Pxb/C9d0wQVVgO5UO/u2KtC5sAOLepis+nuH1LTgN3rDl?=
 =?us-ascii?Q?A3aepRVD9WGZrxceSsodkscnNMQJDPIO/zgJOU1W95wYBfzhqO76qWEZCSnZ?=
 =?us-ascii?Q?bVOxhAKXoKwlG3fQgDPchuUL1qhb5kwChjdEPKt/zTqKTxSdzhZlVa/kWqg9?=
 =?us-ascii?Q?T5rCFDGnGEuiGLH5Mi99YUDKlxHH4ICa3IoNV79CndQ1IMq84BRgucyymHfv?=
 =?us-ascii?Q?S9KoOt5of5BUCqoD4VzxtmQdplqUOYZALDGy3arB5ZWomaaVddThso00LoUJ?=
 =?us-ascii?Q?LwxDC3xOq4gv1p78m0Rl1vsLdfUh+fYZpEKXt9j9jJ7CQYWl2PFcv/y4/itr?=
 =?us-ascii?Q?C1h67w8fhVRRVdxhkqOYqlr1qleR5ABF/LGcbv/oMOoTUGLYfvdMJI/KQnxt?=
 =?us-ascii?Q?PcgV/9R5GiLqcwndb+f6Y6TW6bv6ws4ZGnZz17fOzj7Mtsu9Rn0Iju5SrXlw?=
 =?us-ascii?Q?/rkQeK9/PckiraVOpjCpt5VL6+lhNbNpAmznMq5Mu73nn+u4UduM3votNedu?=
 =?us-ascii?Q?lkGQMpu1M2JrL8tpMnIqYuJZD3Qu+K9PhQVbWZXuHhpHvuKu7bUTM6gDKKvp?=
 =?us-ascii?Q?KSsqv8G6DySYyfgSSnCwgBkW24B9zto4JDCmt15GEuy4lM0b+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:12.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8e816-f08b-40bb-2372-08dd196d90d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2a17a7e108001..353aab5565702 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,9 +105,8 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -155,6 +154,8 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].set_pg_state = vcn_v3_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -440,18 +441,18 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			    (vinst->cur_state != AMD_PG_STATE_GATE &&
 			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state_inst(ip_block,
-								    AMD_PG_STATE_GATE,
-								    i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -2200,12 +2201,10 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2213,11 +2212,11 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2226,7 +2225,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v3_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -2237,9 +2236,11 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
-							   state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

