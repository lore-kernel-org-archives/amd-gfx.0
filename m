Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048F9CD5BB4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F3510E63B;
	Fri, 22 May 2026 00:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A31pw76j";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA9F10E63B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROl4QNqp5ntQMX/09k4ZvT5Rpt5YF5MHUBOa9LgLvyuH+O5mSdul1CNf50xqWrdqGg1RiGgRj/xtI5unXIt3Ea6YDYjRXUrZCGBDnLzUrZDgHtIvHB7XORWnJBtTCmSD1jizHwT++KLrDIUCCD3g6JnVBmCiFCkFE886WcZKdPj89JBuW+M4JP0DnQwU5EPwOQTgEx6x0B9/T//XDis/Sn0FrqAnF7N0HmM/PN+1ZqUjYSihXyMogQ063QQxsth6Mnis1yJoYYYU3uBH5yYqEJPkRCGhyJxd0ZJBXoOejR/VNkF0k/HSvX/oZQMzWYFTfhWpaLOnbXDR1AwzycauJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjnXG3K+p0KQqDDlQY5vMA2zeKTBbvrdFayBhhMdIIg=;
 b=X/jN/aiwNgRoA/7NEJr11MVhfKcb2x1zO6k8fjA3/kw72S6YR/x7oNubX5Lnbog7Vq9tftWWlxNBK93Y8UEmjaDp+pJtrv3M1gSekesvK1862hs1l3gc4eO/C2HAaa/Fdm4OEMO+s70K1T6Lvib7jkQHnHtcyTrb0AIKDKhYbOw7oS5c9GOpFRpciFa5b7DrHZq/INNXxvqednozi4poHfV/n6wAyE/2LD6PHN7Yiej3aHrYfwNpkvIqBGdTuAvVFG2dY9cvy0EoCMKvdcNgUcgI/D1e9ID2fZ+gzp52KksPx1mMlQchC9fE3xcxVoV0CaB2bzTJ5iAWUwxExyQbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjnXG3K+p0KQqDDlQY5vMA2zeKTBbvrdFayBhhMdIIg=;
 b=A31pw76jM+jhSZC55e3m8aNjVARt7h32993nhxx/Zwx1CgM0YWRDCqMxw4ZYnAyVtrxki2c6ZaGSlOC6qHnsFap7nu/jnDrOXmfbczaNVvn61gZr7XXcinVPBbnGZJDh+lxfGpBKSefYHix/omvOGwG27QxADNJJmz38uozNteU=
Received: from CH2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:610:51::26)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:58 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::f2) by CH2PR15CA0016.outlook.office365.com
 (2603:10b6:610:51::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/42] drm/amdgpu/userq: switch to per queue reset
Date: Thu, 21 May 2026 20:20:28 -0400
Message-ID: <20260522002048.98506-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 48af8422-c72b-465c-d8aa-08deb79822d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5DxwyZ0VkHlZXb8T75Rpp8CTUeFmeHbfPJ4NjkvHyhKkIEnwP7UzKDQU2ZSlMSonMiK0H8PvUQkUGyWzmkSofOq5AUOudkCkJnVigAny7S91wqoyM+uQ6u/YETSo03zKeIzle5sR1dCV6zfyBdNwtOysVLhbktejKeY33e6N4JwSYy7nPfoL62xVKLfQklOKNL61OFmYWrFV5PNV3ZvZRkMfbR4lknxigrb3vZFtT+apm9WCwi/tUOaCT+zn97EJzFTEPVeSS5eReH5w3mcV3HOaJZqJrxw3lIKM7jMF7dux4I/flFpwLTpH6esxdi6+IagJ4wxbKizSaY3etFbZk436R+ae3GbPTGTZd0D+qvjxOwKbzU8weZTOFvtP2goNchRbWJ+jmagay9Lt3DLUJ6R4QCTYTBTFM01bFsBV76npMvHGlJA+BBPJhsVkSqQMqwOzxjOkzzii73zXvxsycHAOKN6kN7BFKCWTuFXGfuJwBb46vjslpmy9rpJfyTTuUNCTo2oNrDRSxU+YtuE8AbQi4vBvXxid7EISPemcAC3m/+5u+zlkkF+HuvWUjRH+Xl2MnFg+JcPDSW4lQVIVLE/Zicx/UeeAYrjwWY1cbdSuST/eOtalJfKekfCnfVxYZx2U8+2CfT12NnOlAP/ZRf7BxzM0KForYKdFcMIPCwA3sTmnlkk3sQ6ty1QNmWCTZbbIza+/0Pp0AYfKj1JXNnHEp0XAsLCI/eY/H10is6s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jaKZBFday3FOX+vwh6gAMa0e9t5Loi1JmoxPV0FT48Izrs6Zq/iuJmLhvQ31eKVCJI5CuGyFbvVpdawB/ZkVtcs3OUBl8/XDYOwNdHmhNA0AO8M6BD7C1WhOutK+Jjui8xyazdE7Qo3s1MNNXMGc727BKl4/lUwJdp7dxKThzkUSsCQ3oeI7DfX6zRRYpZ6Z6IirM2LPn4GdolEXlKFjVugGeUP7eZiTcJ2ZnD89O0Zm2voMKrl0djYMMcVsIX0AQDhyO+MOlR0ZI/lNwaUSujn857cmWMGN+/3gvm48SNGdpQy4DVZDztKodeVTN6fP+VPLxMDjdYjOW1eLzwYATdZ8wr59AHdcoWUjqIRdsEupe87QhqwZ9xMvvdXZCtmvf9IdSKPxQmoAplnUtpNiU+wNVgv+Si0KwrxTlGV/+QtHrRnV50a0vQzyrFDvaHDU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:57.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48af8422-c72b-465c-d8aa-08deb79822d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
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

Switch to using the per queue reset rather than
the detect and reset interface.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 ++++++-----------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7a09e30912324..0c9d370341a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -120,14 +120,9 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 			     hang_detect_work.work);
 	struct amdgpu_userq_mgr *uq_mgr =queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const int queue_types[] = {
-		AMDGPU_RING_TYPE_COMPUTE,
-		AMDGPU_RING_TYPE_GFX,
-		AMDGPU_RING_TYPE_SDMA
-	};
-	const int num_queue_types = ARRAY_SIZE(queue_types);
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
 	bool gpu_reset = false;
-	int i, r;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
@@ -141,28 +136,15 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	/*
-	 * Iterate through all queue types to detect and reset problematic queues
-	 * Process each queue type in the defined order
-	 */
-	for (i = 0; i < num_queue_types; i++) {
-		int ring_type = queue_types[i];
-		const struct amdgpu_userq_funcs *funcs =
-			adev->userq_funcs[ring_type];
-
-		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
-							  AMDGPU_RESET_TYPE_PER_QUEUE))
-				continue;
-
-		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
-		    funcs && funcs->detect_and_reset) {
-			r = funcs->detect_and_reset(adev, ring_type);
-			if (r) {
-				gpu_reset = true;
-				break;
-			}
-		}
+	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
+						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
+		int r = userq_funcs->reset(queue);
+		if (r)
+			gpu_reset = true;
+	} else {
+		gpu_reset = true;
 	}
+
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
 	 * handler to another is illegal if you don't take extra precautions!
-- 
2.54.0

