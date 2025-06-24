Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75435C7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7AD10E52B;
	Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2uF8RwWo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A6610E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DojlbXXjAByHasz8mId/ctcOAc+Xz6tI2zUyJ7mOuSbxPX8WQcUljkcOHuSgJGEQ+kZQDtDCkLunuESeuCYGwC15eCk6w9gxxgpZ+g94RIe2Vo2TAN5ra8FavarkSJTGTMfIfR8NBHqHltJTV4nONs5uX1e0Fw2lXFPQax5eUMrBXE4YTQ3X6Ma0/CHbo8k9hKuJ6cydjl2q/WGRlOZvmczWlmcgmEFXyKqCXT5cYp4+ncIO1MaiMvJYxLO9/yHhtulNBuij+gYGxKu0Khcn7FE4UxcChN5cU1qpSK0Kv8LniiZwipCo1zkgH/SEvmK4WXFALNELt7z9GEAVAySA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pznexdbHZ8oLlfgIYp2aBkqZRQl/Y2fszZ/OxiPjWWA=;
 b=rXZaa6KLlmzGNp8xQphEfa+iZlDrMiXdhDy+tKb1+R/AQAT8+v9pX4p7MSP5xtH5omIxi8Uo9WpdZZS1xviL4YAO3yzDpmM6mBPs8DuKO8ZxkZToRzbelwBWMPQS1M0bHrA9WH2lY9bekBkTRgZseQSjnBKQdwky/oR4wteKd4hQFY0BtAWa6VmZJU2tRcSI9qNNt/fOSDaPCSMp9QmzboSCbNfxZe+y/xti7SytSaiJzZ0guSOP6DIZLTPrVc3bjXchPe5hnfL8K4IsaVUA6FVQ5Q9EdbrfI5zU+BovIPCghvL2qY3rYh1OeQce0dn8p5qR6JVkBH3zkiJVIGcxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pznexdbHZ8oLlfgIYp2aBkqZRQl/Y2fszZ/OxiPjWWA=;
 b=2uF8RwWopECS4yx++DTf8qPXeUsyIeMcB39bBaVb9llqsXt37vqIKQRRoIGNMfrXxAU7n7rJ+m/m2yotdzx3XF4w9kJ7TjVIufS6V6PLubR9K6MTEYD53rB8Ne2d/NrHswajMfX2CW63oywiqqKzWVZxw0NT39XxcWEIlFJCi2c=
Received: from PH2PEPF00003856.namprd17.prod.outlook.com (2603:10b6:518:1::78)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 08:45:56 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH2PEPF00003856.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 08:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Date: Tue, 24 Jun 2025 16:45:30 +0800
Message-ID: <20250624084535.1178476-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e4ef8f-7651-4c84-029d-08ddb2fb88ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vTSNVs68CclaIMofjemFcbBX7WUM6j3RQvUvDRlpoZiceIksM7ErS4r/fZiE?=
 =?us-ascii?Q?+nuVKvow+JiqvxOj8XR2b9wrRP9GegPTUe1ZYBalJXihiqa8Y+poamUwwabq?=
 =?us-ascii?Q?jaKPg4qUu5LZ5y0bdJBqZjrk1weQI18MCm6Ojv9QJfjimk0pWtfXndORPTgW?=
 =?us-ascii?Q?0qubFLrfONuEOUNJIrXlnpl1ukRpT9gNTdBSof5CLgsRj50SvnQeYEhZBdfz?=
 =?us-ascii?Q?gWKfj5TFft8jWvPBGxTrweIF4W9r4x2XpSKb+evvwdsbAUpwkW4s1mZSslWA?=
 =?us-ascii?Q?qU6H7h1e9Wgw3+udxmSajTbaD2dl3xwHR0+Zy319KixV3MMXGKSfEvYdTcA1?=
 =?us-ascii?Q?OFb2ENoncg2VVj3E6S1ogoZzRyaUr+0oGSBaFWYdAiJcbpBUeGk2vk5su1o5?=
 =?us-ascii?Q?c1vIShnBvxbSwzIYJlczcgLaAtKFdYKWntWvJJ2ogaPVh26dlWkBvLQVvn3y?=
 =?us-ascii?Q?0tpr4kOk1Xlv8i7F1xt13nxHMu60P8Sul/swu9JrwpPsJhjKmkdavKNMd+TQ?=
 =?us-ascii?Q?Ppe/4k2NAigykdS/CcltE6PfdRLQBU32PeeYR+gMxrrGIhWY0C3BaS+dT88J?=
 =?us-ascii?Q?8/fGc3Lj7l1nhtzE+452NrjdpR2ZoFRMIUYqzXvTYHs4TmhFrFuxcTpO7A5n?=
 =?us-ascii?Q?bJebHxp/rtV9hoF7dv4In+vvt068b3YIaT2lYgpirdpDH3fMywdq6Izp+P4h?=
 =?us-ascii?Q?Vd8hojR7dSwvUeaXbmOz5lZuDGracRCQ+DyOwiL+U980FIVsQg5/3YI7ujXI?=
 =?us-ascii?Q?GklKjOsRilsYnv3+J/6QW56pXJlno56xiEJ/f4mUEnq2dY/GNIaRjjixKiUR?=
 =?us-ascii?Q?yRu7jzAklfHp9Iyx3aPQi7VHBMiR5X6g/om053+3+Ysj1sMIXpQTz4O21Kdg?=
 =?us-ascii?Q?j6+sf6DLZpeKQOwvVs0iG5eOm1cuxkbAYBjPbL6aQ1uELMPOwtoe8e9e7WiZ?=
 =?us-ascii?Q?xU+Bbeyck+q8aEpgNwgHGV0WJVdgpGTbHP1MSnB+naptzQtlXMmGUlvi9jUo?=
 =?us-ascii?Q?YvLbW87E5W6Ecg1RR6kW6KuRE6ZT4dT6p/+5V/vQTeCY4OehqQY0zmtlMmYa?=
 =?us-ascii?Q?56dawMALng2kuJEcjy2TV3cCKjQi6AVtnTfpOdjKRZe3wSQwzC7iOsPgHgoE?=
 =?us-ascii?Q?GQr1SxNPx2RrdYiLpAqbMDpOl5skv+YCCZ9Mvsyx5tQjtlefN2vPp2qMOnJD?=
 =?us-ascii?Q?Bhv8ajp+070wKlJNZk8LKEEHu0DgY7Uj9NHEExVWlixIoMclteEUyeKDJ6p6?=
 =?us-ascii?Q?JlHaiVO/jpXML2aYzeIK9XUFL2KMJd0DRqkEePjh0Wma0LUUwaVAmzVK3ZYD?=
 =?us-ascii?Q?1J/CtagZoVkehzc3CXFwS9M/RWtRxn1OM2Mu6pPM9sprFA6AuUXSFa5s2BPp?=
 =?us-ascii?Q?05yrQeMPfb86+2WSKEk5Q+kdsfBWFRoe6iqkf5AsSqoYyWu5ic5V6abStvhb?=
 =?us-ascii?Q?SS6rRg6FoVBwerdvM2oLstSNiMRIpIs3NB2C178OSGWm40rh2vlaygP/oY+h?=
 =?us-ascii?Q?iogaQlHCSMT/L6BrLbiqbim6TFsCB4rzvg1T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:55.9426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e4ef8f-7651-4c84-029d-08ddb2fb88ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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

The user queue object destroy requires ensuring its
VA has been unmapped prior to the queue being destroyed.
Otherwise, the kernel driver should report an invalidated
error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cbbd1860a69a..79b263c18eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -477,12 +477,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
+
+	/*
+	 * At this point the userq obj va should be unmapped,
+	 * otherwise will return error to user.
+	 */
+	if (amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be mapped during destroying userq\n");
+		r=  -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for unmap error*/
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		r = -ETIMEDOUT;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -603,6 +615,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

