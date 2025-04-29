Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C34C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 17:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEF910E11E;
	Tue, 29 Apr 2025 17:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2UVGdYJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DAC10E11E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 17:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM4T/gJpO2/G8ehudrH0Zt0GbKn63FfjPZuQVFOlpu4n7ulGU0xtESlpB0Hu5HwhhKEw+k31f4fQ6PBMvqOafL6Qll2M8q5hxwSP8F33LAKXmr/6TiL8ylJbaDF0C2iLbizHdeCWdjyvUJPegmPhtli1bHKC3aIlREuZv8KtQjZcXBVOeLQD0KYMgp53uckV1c7sVHy51S8uplMJDul4ko8JR8XmZEdcBRQ8XDRBBZtuopMcAJXWmW2ea9dGcB1Sv/mPYDZ8bG5QPbj2KkEW2zDftiKAahgNHOwOCwWYo0VeK6xJR0WUSmqhaZIhN/1K1WhPbH49iNnMhUhA0X4NIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SxciciJP1/Tl39k8zx6BdZz5nurcMuRAZpp5Up60qI=;
 b=WOQ8egSIJFWFdIpiPso2vVMsMjDG62Ufy+PoIX2Yuayu1hnbpA7UYRukFhGKdGOT74lLPFB80XkaDnvk0THlxBIvzd5oaN5MrMkF3+Zqj+Mj6EZ02YqhVGqfRwlIxOw9IgoILqatufJUJDhKOflsvQOMyPU4GVD59WVAe0BENXl6lZJJDcctOw3kR0uq0ZwAbdJtFH7fyRiJfuawfxE/V2k7XF8vB7ccCzmV4lmLD7lRG0j7hkXZv/Z3xGAX1Qjcy62Gz+TE3jYwHA7rZhqBZyxYaAtPsLjVI1nXgxxdu9hDsVbhQsYNSj4SOttXNq6z4bHKZcREpWcZEcDgEb0z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SxciciJP1/Tl39k8zx6BdZz5nurcMuRAZpp5Up60qI=;
 b=h2UVGdYJT0iQKCMfKXr7Wp6nuC/C9ZGdZ8f18T2pNjjbhJWN4JLMdP7ZL7cDTYOd0m/ZWoOOmo5809pyzpWn2rjK/WgXAuFqe/pm/GLugFie0E7KpFynqTyn6Oyr5HSmC7LGJAu9aXPJrbzsGpOEl0MXJiyMUTsAVEiZuyeA5aM=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 17:50:40 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::58) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 17:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 17:50:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 12:50:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Arvind Yadav
 <Arvind.Yadav@amd.com>
Subject: [PATCH] drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()
Date: Tue, 29 Apr 2025 13:50:22 -0400
Message-ID: <20250429175022.1636538-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: e18e12c0-23bb-4f52-2986-08dd87465ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fX/rvEDNOR9+610zwg6/Uzhtr7J83K1ML51w3JwP3GhhQ6Sbz6srxKQWR3Bd?=
 =?us-ascii?Q?7J0nP1aWilp2wP3l23sTkt/n76HLESNekKaXL7bnOHfB7biYTQsfOWelZ2K1?=
 =?us-ascii?Q?vQyhDNEpJk361E4l6JE/l2lhZjgkFTmr0zYr9JtsINN+2Q0BQIecS7yDBZ/f?=
 =?us-ascii?Q?onwKP1yfBvtIavzpR1iD/Ic6Wg/mvAmevqAd4AsdZVqSAFakKLY3YDQM6MVY?=
 =?us-ascii?Q?O/PiWTvKoRc69ldkH5sssYHcUXBYv/4KjJD3xd+vHC4KEXanBjW227mLkESQ?=
 =?us-ascii?Q?CoTDxrmTIcg0I2otMpdmgMtTM5jRSFJssSYYXIMfoikrW+8GqhR134Rvb6Vn?=
 =?us-ascii?Q?nkMIA2t2TSmYiShDFiIHbjeUWaJsUF6T+J7KNUI3/m3bfEm2CAgO7rO6YpNB?=
 =?us-ascii?Q?HDxFX8dqZbVrQKV0ZycR67o6oe15UXvEf9hOYw95Dpxhb/i0BpdfaPtPFfxn?=
 =?us-ascii?Q?ve2jvqpnySwNo3OLDtrrbsS1dJbf8A3vRrpZ+z282pIbwbvRz44JvEf7kEzb?=
 =?us-ascii?Q?3IYAR5w6vaAxn6XrPHZyc2aOKQK9/+55aqVDBjggSuvKFa6KalJi2vSaLuOo?=
 =?us-ascii?Q?vq8lMwc3sDcrWp/EijEmFngOSa5jfYPgokVkD/AUa+xQzBkS121xY/6ekljW?=
 =?us-ascii?Q?aXmot6tgJh8xJ7bbDQ3xcnb/rxnXZC+2bKUx1Vuu/+lHRzeRMaO3IzsQmc02?=
 =?us-ascii?Q?kkKzrRHisE/tkXoYrfD577Yi0JRNcG/gYRzYav+XhUYyxgkGq5wlUiHKJoe4?=
 =?us-ascii?Q?cw7yeHz+l7zi0QtcHRPGYDAys+1NbQqeCbEa5nF2hJgcsgfWwxxKXbkPWZPI?=
 =?us-ascii?Q?0UxjieVb0v8u37ClgSLzI7Lbg0M9mprj6RgtAxgVeuEEtO7wC28BnjRq1Q6U?=
 =?us-ascii?Q?514lgAlGsdKuMxcOUmG0Zq3azRZbw2X6tPtXmilv4gAHR5mQ8MpO47ZZ45vf?=
 =?us-ascii?Q?c271waFx+CeQAx4XEL7N0kLu7C8N4FaQchrwRqwaFU9U8rGENji2nWzBCMnI?=
 =?us-ascii?Q?8Upe1htitm/VECYMSW1Tquhtyzft/ZhbnRF4uzOODYQf5hzkzhq4REx3XiqH?=
 =?us-ascii?Q?KZJjqMY1sQeVWviNpIOYD1/W9NwlDNUOSyIxnVhcSP/Fms/xGwJ2a6e7FjKr?=
 =?us-ascii?Q?2DHAUjpn+d8RDTq6c0mKnfhopKTr7CqiQjZjLZ39efS9WVoiUPIKGXRQqOzb?=
 =?us-ascii?Q?lST7ku9JkPpRhgFcdc0/7g8lfqlD9z2nnR1KHD68Cs9yV1ElTGCk6PktaAIP?=
 =?us-ascii?Q?hZHzadIaatWhWyS4sugfPB2bjsDmxr2SEn4P6IBOjVfZMtyNfggykzOMYDiF?=
 =?us-ascii?Q?7hgOetmjs6mwMtXS2y88GsB3oLU9ItSFIzSMO+0lIze2psU0+Wy4/7pca9zg?=
 =?us-ascii?Q?NzIhyGatXO8fg4nehDEj+8y2IcLxR2ol6utxCFpb1+LAly/RNFRsqwWaakEO?=
 =?us-ascii?Q?zqtnsGOK8WDxL+he5Wc7P6StppXsV5vZZWf9LFmiSXHU1dlxzrusdKFsAFwk?=
 =?us-ascii?Q?fGezG/xRVKD8MiwFFYOFPZgZlP6NHPz4P1YG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 17:50:39.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18e12c0-23bb-4f52-2986-08dd87465ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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

When kernel queues are disabled, all GC vmids are available
for the scheduler.  MM vmids are still managed by the driver
so make all 16 available.

Also fix gmc 10 vs 11 mix up in
commit 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")

Fixes: 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
Cc: Arvind Yadav <Arvind.Yadav@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 359c19de9a5b9..c7a6d40ded5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -576,8 +576,12 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
 		id_mgr->reserved_use_count = 0;
 
-		/* manage only VMIDs not used by KFD */
-		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
+		if (AMDGPU_IS_MMHUB0(i) ||
+		    AMDGPU_IS_MMHUB1(i))
+			id_mgr->num_ids = 16;
+		else
+			/* manage only VMIDs not used by KFD */
+			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
 
 		/* skip over VMID 0, since it is the system VM */
 		for (j = 1; j < id_mgr->num_ids; ++j) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7648e977b44bc..a3e2787501f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -896,7 +896,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
+	adev->vm_manager.first_kfd_vmid = 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7f5ca170f141a..917d894a1316a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -828,7 +828,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.49.0

