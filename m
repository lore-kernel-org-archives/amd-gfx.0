Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC711C0219D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E329210E3E7;
	Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h9fkK04i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5616610E3D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUQUyZ4PxNb504Z0s5PnP3DsV15TyhEIHZFksaxBaDTvrQorZEndnU/5zys8fSynQQUUViyn/cRwVy8aZpLQmFLX5s79a7g/gxDZQoF7bXjdRpWOXDCPic+FePOsRuTzefA2VOlnWi67rOmqZmQyM/pj4NqBNXHkPVvEeF3AS9N0xv1fMtVjGMEWlr1WcOONFQOojOA/uVg9q9e9+vna4bS28FRJnAO0uhdBAjilH8vs/Y+FUKPMm4+Dm6eHFy4JTT6BKfYPHRfu0tLX8rx9zNB3Fe/toUz8ciBLQzU60gkmanzC6JP+1JMISFumtAgtOZhhGsNzdwnlC7VvxIqRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRu8Nsw0GWc0AZxuF7wHMuQW6htfCL5dHv5FZ8cJsAw=;
 b=YKqm7O6UNJEALaHQqPWLmzctOSUqUYzFd7yQvxU9JQyUdEjulyPAG2O/i84sJKpyv/M4uQwXDHckDMxAStT+7awDHCB3F9DoQ4mw7o1KW7gJCIo1Gudw8T/nBn0JIxj5x++rO9o/bv2y2MGWaCwIptPMPD9ioTD8h3yTH+bFNeNOiuRtmoMmMrqslO2ECpsX/Olx3SHLis7+kNKy2vTGoVNY+ryt78EYYcA+l5+46N0k9cU56iePOphLIus4Te1PpytNzJ4GUFG14O4FwDqbl/36Chntcv9/Duv9L6GZ74gFW1KaElffhLfBVVTm/1luy3sVFnHyYXSxiR196nK9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRu8Nsw0GWc0AZxuF7wHMuQW6htfCL5dHv5FZ8cJsAw=;
 b=h9fkK04in5QidbMsJdIfSXEIuTlIQ9TXcNHJBLLzWUVrDuUZgO6Craf9SnwOiONZSvFiSu9TTF8DLj1BYJpAQGCuRW8TdAuMtq7837ZD7xjxqr1vAdZvlanJ/UqsY5T7tOCxzxv7NhV2vipn4MIcbQDXUvLCfmxBKfeLJ7kFK6k=
Received: from CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::7)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:21 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7) by CH5P220CA0001.outlook.office365.com
 (2603:10b6:610:1ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/44] drm/amdgpu/vcn5.0.0: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:26 -0500
Message-ID: <20250131165741.1798488-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d91f5c9-86ed-4b29-4d15-08dd421877b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7IoH0LaA1gP60nOIGc16SLClf+8L7j0z7Z+V/VeblF6VFoUlHUaLwW1woEfV?=
 =?us-ascii?Q?uyNCpahltI9E+yVew4EC26SLJijTobEfdz4Lkoks9v6/14WejnnNzuwDaaOC?=
 =?us-ascii?Q?SCmiRjIaRFbwuXRe8HYy02Etb64JG9d5MReiFLNaELuC+gbrd29RQxSTLahe?=
 =?us-ascii?Q?btwRJw5l5wUdM6VF+SIlnD+J8PUtSbGCaKYBh065fNxZ3KHH+cd3wORKK/Mq?=
 =?us-ascii?Q?45Bks7yxxGbI4BRruXGF3iLWKkZ4HOa00bInTNd3Xi/S7Y4HXGzDYjSC9GBx?=
 =?us-ascii?Q?99X2j465e2U/QDBF8wXFb+fn+wQSdtykMq4s9Xi/Hc1XffZ0wsAjzJkyqPaK?=
 =?us-ascii?Q?+MhJ9B1nHCuRkKWaFKj5ewsWU5Vcq8ciSnMuGAy011MVbeqytQ42PcxvEeZB?=
 =?us-ascii?Q?/Je33ZBKVOqUxIvaWbr8kgPruKOtbX99DDLc/rfpChOVww2yknfHkAfe6+3h?=
 =?us-ascii?Q?NxT7NYHme3xCx48+km1ySbD54c1KnDodj9kM/HhJDE1BuFRHL7zqbQmWEcGy?=
 =?us-ascii?Q?4c+dFIPF242YuWvMFPTuQKRYYAbreyRtddLut8gOgmZX0AJfZkafGOkmAeNh?=
 =?us-ascii?Q?cVLcV0H0XmeRC9hmbnVBFHhNIvanRhwo3y1J2zdoFC4yMQJLa7BuiJRMTKu9?=
 =?us-ascii?Q?8C4DC5sMk02luj3eKp1RjCdl8ugW0fYIToy6eAJ4jduJjJvHFRoJVetIg3xC?=
 =?us-ascii?Q?bOtW0OaDmRARvsuB5IxjzQe7u8BQQIK7BHnPTro1uOlVGWjAA5ipwyXWRStT?=
 =?us-ascii?Q?rj8Yw8fmQ6iO0Q12QxZzdqP+P7y8+/0kGfog3v36R8KPUKQiPiaM1MLPbToY?=
 =?us-ascii?Q?DRzbbRXsEdLVehg/h+CEx6Ghn39SbXlgwYljHK+GqvujYkL4Uk80l4Ey4UhN?=
 =?us-ascii?Q?q1f14W9CCYj30A9nPh4jefdJbSzAoXOYHRNX00qzlMBiqhWkc1OEhydQ7M+d?=
 =?us-ascii?Q?cJ+xZ0YscGMGuRCx7OwT7CPD8loXQjSh9otBenUgHohlcRn88yM6FRhjZ9Ax?=
 =?us-ascii?Q?LFj3pV1iN2MRVO9m4nr5iqX5BhXdbxsEC3gvg50eW98Ukg+cJ50sbCTab1FO?=
 =?us-ascii?Q?aJZTTyobR5iENO/CRUEw/il5q2uhUXFI2/X3wevJo+epMBsTW6WMw9plnHAX?=
 =?us-ascii?Q?i7TJ9gX9yjmklo26i+C/9wzeX2JMfeRj95URD0WnYFfmiWQofSi8pKrGKFor?=
 =?us-ascii?Q?a57oqW052Q+CZpbi9AL2UICW4Ytt28/m3RGAOxsLHIfDajmoVouTzLooENKF?=
 =?us-ascii?Q?EOYPkCXNGqMO+wh+2JSG29By6KKp1X0PS7fl98gkkD3Qhnnd5yRhzqSKG6tS?=
 =?us-ascii?Q?nMO/rWZug8TDrhqrsVKxeqs3z4e7YpOQgHhtyH+GPibB3vcK4rk53WpJPHwX?=
 =?us-ascii?Q?uaTJGuv/eqjRKGfBHJyC9n6qwQ0tQ+NbD3eO/afOT5xiUyzEHabJRxr4Y834?=
 =?us-ascii?Q?wMn9O91sff5L7Vtn7E7GJmux+4J4Re0MpB7CcFAMZQVgRLdHiA7nJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:21.0025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91f5c9-86ed-4b29-4d15-08dd421877b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 91b57b86dc58a..9588153079675 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,9 +78,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -108,6 +107,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -299,16 +300,18 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
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
 			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1297,15 +1300,12 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1314,7 +1314,7 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v5_0_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1333,8 +1333,11 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

