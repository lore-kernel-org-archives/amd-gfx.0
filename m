Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF18C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09E810EDA5;
	Tue,  7 Jul 2026 14:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J3lSG4JO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DA810EDA5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyoVi9AzLFNLpADFbdO6/B3VR0oAhRiHNw298mK50XWullS/MQEkDiBlfRiBKk01mjIU3314wwgtT+xEXMSUZqueNRTL4NoYzR6Jj/O1N8enh2cyVWxLEmiUmHuCwQ65jw+Jv5XEC0JD1XnaQlbvP5NFBQgam3Hv4oOyV9YCKArpv0+n3xrmALVzoo0rT2mn4Lxwn2Hgoy1jVf87a1Itg5Xrxtyt9bUq2Rz/v/f3VSDG8Xj36uBPc4+6ImoIfNFCrrfj252BKnGIhoA8qkRKWuaEDY6JfvLi11yM1T4Acgo5aNFrBBHNJRrnH8Zu4comuSSLEt6bkPqel48iE+yRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NeWiQPpFppWzDwQJBBaQFOBoUFpyDtGiVacoanIOPg=;
 b=nLUBCqmX62jJdtA9X8leLzf7KaowVmSi9OsMUSfXXTtlA6hWRrHfMDsxpAuC70QSS0kQrwTbeU+9gEI1bwYedYaOD+4Fica89/OwE80ppv2nAY7LsBd0WUnrjwG19u1CjJB17+ywSN9aIhTV5/8Sqr/yUk4BzlLguOBrjyDZSeoMbiO41+cqd6zZ7LdBZAODQV5iSMXSlJnsbRgiFwuvQTAhjEMEcr0V/eUeipEXr05f/Z5E5jRZOj+g027aAYhhK1eMeGsBz4QgOuZastLvee64o41XIQHfWBbsPZmXlXaO8hTL4Gmr9MgZ/zeaQNEq2Er+EB0vtKVNr3O+zCUSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NeWiQPpFppWzDwQJBBaQFOBoUFpyDtGiVacoanIOPg=;
 b=J3lSG4JOrR5TrTLdCgVwFfpnC5pStMs8Uc7tBi1dwzxuvclnl1PT27veZZ5jUAxSbJNtjkAc6AwkMqwaqOSjHOJIHpz6ahjzbYN9g1Pbo4hHov+2C5slBagnsTnsB9trmlTD+hE7qRfpOq+YyRxjtq0t4cZyswVVNisRka2mTG0=
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 14:34:33 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::7f) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 14:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdkfd: disallow gfxoff around compute/sdma queue
 reset
Date: Tue, 7 Jul 2026 10:34:20 -0400
Message-ID: <20260707143420.2104857-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707143420.2104857-1-alexander.deucher@amd.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6df26b-bb80-4a1d-5e7e-08dedc34dcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hSb9K1bcNws8RnBulxX92goz8TFaUflLETTK6pjzCT9zucuOoU+pj1Ti7VEI5w7tHIgI8Xb5v3QI0KmSN/zFc+LY9XwmmL+VUlTW/YhuJrNDseyDR9/dqtYGGapsnPVUOsFYX/whkXb3WDftbliYCHgKQ5Lxhq7B5bIy3VQjBmu2bFle8cswpoSDGoecnOlk5KK0jMTpuwpWEBwKDggoypkad59GkCVbJiF242NtSuIVvz+1MLPDOTv5KvfF/Xme0uD7csPUQkNh1VY5SVTEpi515hopA1awMyRwPuwvN1J4X9ehf/ZcC4mifhbqW0rYpm2tFgRqX5o5aHZqgfQLEoJ970ohdLFNu3Te6f1pTJJnsE/TXkBXd868IzF+sht290vdBrCtPasR1tp2psS84UQe3NlvBYMTGmqhQww9JG5hNweHVcwJe8qvyunVKcupz5Hfbv83aztwipth3f1ljXRyVSkrI+jGMAnoz1KzhvJayi8qzxDcsu8nMN782tWkxa6Xoeh70ZeWBnsqOI35jev9wHz38WoLQbeyYcMVX8SKG0WbhuD6vkHUDH842tsAiyJ446h8TOlubDeffiNU5nzNEj9JCUTX3ihB3NOvqUg3y5cAJXI8mzI6e5fIO0DFwPVbdpHYACX7QbVz5Il9b/nRC9Tns/fF+we0BmU9fJaPSiJ2ZNEwHaD4HqXQ7+ijgmPLBelZV24ZHij+CvLAOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jxhq8xbLYkG6+oBgy3zl6OFbFgPwK5SeFSCXqapuwGrQoHJUGwJMiBSVl25Z35/tPCkvd6uIDtq42gpIuO8fVgllk3Xt3ycteDZ4g4FdueUv5GRRrRol36q2hQnSRaaGPJX96flyTsY1fxeUrXTn695Mnkg1G7amwEb6h80a69rF4Z0Q/lNTqk94a2PBezIRT9L0w1gnYGUE4zL6a1YM8YhFTfR0hr+mg727xchj0UpHaFj3elicNcDqtr9FEnXw/W7LkRVZQKFYLKT6Hjadbve7dS7ixe/fZjtCd8GjMEgE9qf+tL69NnPXJzzASQkZMBoJTACOQbJxcvlFcXviq+Ebkk6YmipwJ+zF7eNlWQzm3a1/AZPvyvJygumON3Zg1AEKOoRJxB3FakkFCo+IuxPkfya3Nv9tOeH/T+bR5Sd1U7RsvSc+FMBm8Vb5JFjL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:33.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6df26b-bb80-4a1d-5e7e-08dedc34dcbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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

If the engine is hung, we shouldn't need this since it won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due to logic errors in the commands,
the fence never signals.  The engine could potentially go into
the off state.  Protect against that.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6a749fbdd8ee..7edae15adb16e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -473,7 +473,9 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 	/* pass the known bad queue info to the reset function */
+	amdgpu_gfx_off_ctrl(adev, false);
 	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
+	amdgpu_gfx_off_ctrl(adev, true);
 	if (r)
 		goto fail;
 
@@ -2454,7 +2456,10 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			amdgpu_gfx_off_ctrl(dqm->dev->adev, false);
+			r = amdgpu_sdma_reset_engine(dqm->dev->adev, i, false);
+			amdgpu_gfx_off_ctrl(dqm->dev->adev, true);
+			if (r ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.55.0

