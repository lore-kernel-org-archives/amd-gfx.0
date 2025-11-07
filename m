Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C16CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 11:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD26A10EA7F;
	Fri,  7 Nov 2025 11:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O5TSIBmI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1350210EA7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 11:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTGpQU6ozcHNYI8bpjG33eZ+JcW5Wiv/xy0o6elKmqOVCMEFIaAaUQT0wpTlY0z7n2wyrCh5mUEyREkSjzlU5gPZg2A6g3LnCMVhw8Wyh3z6JFKIWHyIm5BCE+CqyNJSCAnCEO87i4kx6G0R93Jr4o6kaCqhAen+yHLJjlMXL9dV/GhjKQxZvl6hp87+bJ7slUsmwPaZARQ1Q4lK8entPoKGUlLYZ0/u3aEWNoy90nxbeWbV2mK3dBA9xxM0WM6j7Z12/iM9eaMRzbUlr+00gVPcpk4fuVdLQBd+whXBC96ttOYz8sLusOK+TOxLfsiXBpTHF7cWvCWopRIjU8ffxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16gGcD2QdFK6Q+x+Y5cHNpT0jeT0ZjXBe1L5tvI0NiY=;
 b=TB9MrceCtZwRbjN9oHz2W6dnqu7HN3vcZ47wUBLFDBzwvcCTiOAJKf1TIo8EzGQOdHJa8eRhr76f/Pkhc6gCkXpcye36QnDZ8nubyO06p39tC6PzJxPT+UXC1CRCerSyQtBwnYHyvh+UjgYZ135u/rsOhD0PLwCwYhAMt5pCVpF3eEGOCgpWM4El/YlOJirDs1vHZWZUPMkoj2O1j4QTLpdcDWuCAgnAte5CiaKBCN8Ro15VlE2EXI6/iM9or7gYovcO84Nq4PuIrXKdLSCf8dnXq9T9RVZdJlwc2Ze8pajulbmQDekzWAqP6QwcTqfS606P1eo0mFcMYsRITxQg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gGcD2QdFK6Q+x+Y5cHNpT0jeT0ZjXBe1L5tvI0NiY=;
 b=O5TSIBmIJA+4wJnqqoPI7p5yy5At0e1obxE9bV3/KfUbEZqSLgOkOscPwh8Dcfe7uAflclIj4h6dFAC+aWEUBLqOhe/LkZEttzEjJjiSB7D5LQLY94CnALTa8X50Y8xE6Dv6ik04L4lxiurCYwFYQA14UZaM+r7q2/NgRSrtFuc=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:27:08 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::53) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 11:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 11:27:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 03:27:06 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 05:27:06 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 03:27:04 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Date: Fri, 7 Nov 2025 19:26:12 +0800
Message-ID: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e0425f-0ab3-465b-1052-08de1df0965d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fcypRAoXD18AZT7aVvvzToK/1R16hR0u0wdHOc7vPFJiO3jIAJEAstcx4rr4?=
 =?us-ascii?Q?AMAcTwG/AUxwchJqlNdU7ZY99J0IHeMtwNDGkGPoaichWa8ArtlAfibf5H3U?=
 =?us-ascii?Q?qUmQ+gR4INAy+8BzRnrZ35wSNrT5GqyjZSd1qbqhI481OF41fWbjy+9IcWUz?=
 =?us-ascii?Q?r1bJghlsTT6UuG9nSM4/StKNet83XGj1E5S/TGMg7GLL2xsjrI0UODIL/cEa?=
 =?us-ascii?Q?ouii9lkEis/vGs3N4sRSQci0QI/8NJt9Kn4N0ngs1eJanIVV7zGcmSd0i5iX?=
 =?us-ascii?Q?yjc4O+lkIz3Om4MNi2yuRv0UTAf4grNlpJsZrs1/H3oWw5eSj/AyeYLCWmsk?=
 =?us-ascii?Q?m8rI7VtKWPP/4YXm8R0KvWX/je+IiZP34ehJ+vmK5QOc48QqbTQnhpEVH9sJ?=
 =?us-ascii?Q?Y4n+3YWThWVPtrIoKMS0tm2dySGm4ufDWADTlS8gpSfEfODGld4WEaWZkTgq?=
 =?us-ascii?Q?Z/dVx9uHVLn0BsupVEPA3hlQfXt5H6gXj/CkyQwUBfT5AG+XDdRHiQwiH4hG?=
 =?us-ascii?Q?VaoC0vulfZJCsDIZG+r91IU09DiJFGlfSfDjrDXixY7p8BaMPB0gBj6VQP03?=
 =?us-ascii?Q?tDfJy09cR8kBLEpVUdHVQLhMX9Olv0KhOTW67gtHHlCFszJUipm2QQWGT3R5?=
 =?us-ascii?Q?a+nQdbOSWPmx+wDa3VGF5fKw+26m4MYauJmBevDCHfoQjGvmk6HPyOSnBmB6?=
 =?us-ascii?Q?O4MyFv+OBUzjTssHD2farMKAGLATxtTWWl7+6w9gpEa/gWD50ZRwa/+agt8A?=
 =?us-ascii?Q?CWyS5y4fgG71hopr9/sqxaCIC6xmJm6E6wo0Fn3vjLD19wC9qw1iZ3ak9Wfq?=
 =?us-ascii?Q?1EEcTDcGfXx7Wwo0mEDRLIUK/1uKT80/yxFt5MovaqNplWhkHUdhWg0XQ/4j?=
 =?us-ascii?Q?OAcm+wovCZFrE1NFFwDfPhAqoZOdpybETUsUtGXfmJTCeROxeKM6c860QAKA?=
 =?us-ascii?Q?cEKi3Ll6LLijxNgmeoRDkSeAV4cS+DBXntM0gYwX6g5NxelDuFYwZKTaQF0H?=
 =?us-ascii?Q?hTvGao3IIEKZ3lug/uQAuY/j8MtJhaDqPOsjv2WcOXF135jJBh0KLsObVkx7?=
 =?us-ascii?Q?3OPOptfFuGu/mOB7BxEn1ZHXE9Q09sMstdO2IzgkhXq0RW6RCPZnl/8z7YQB?=
 =?us-ascii?Q?vorPc4rs3mIMaDt4TUfz/Vdl8qDoXcoQGlnybzVmZe7rIQv9f3DTHncZ2YLi?=
 =?us-ascii?Q?Nw20ryCddouxG1+wfLaps4Ijqg4SX6Sb5dxE7c52NWuvUDYycSps+SHudzra?=
 =?us-ascii?Q?gSv979sGnPwLuHky7n2iiJbCjTH0riYgR9JVzpuXFy0eixk9TQoAc6zuS7L0?=
 =?us-ascii?Q?mnd7zB4/saUOhKd0/fuSqwmmcvVrktl9WtHvTKOykLABv8iwOy/XFxueqzv7?=
 =?us-ascii?Q?Yi5qCW2Kue/7bnLkE7tq1iw4WbJPkaPHB0mVcdZ/wjPlVM0SVW8JXpVthRSl?=
 =?us-ascii?Q?IMaNP9RIjn8RHQ5j5H5SX18+S4+Q1pASQWvny+145sSd1BJe5yRaJbY3bGNd?=
 =?us-ascii?Q?g5BmO39XSe+ryv5OJZA3MzLlukI2ORGIJAdE67tlDCVuJIVBm8PY+6+ok9zn?=
 =?us-ascii?Q?N8EpmEFXWVc3LqYrwkU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:27:08.4787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e0425f-0ab3-465b-1052-08de1df0965d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

This patch ensures the MES is properly resumed
after detecting and recovering from a user queue hang condition.

Key changes:
1. Track when a hung user queue is detected using found_hung_queue flag
2. Call amdgpu_mes_resume() to restart MES scheduling after completing
   the hang recovery process
3. This complements the existing recovery steps (fence force completion
   and device wedging) by ensuring the scheduler can process new work

Without this resume call, the MES scheduler may remain in a paused state
even after the hung queue has been handled, preventing newly submitted
work from being processed and leading to system stalls.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b1ee9473d628..6d1af72916a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -208,6 +208,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	unsigned int hung_db_num = 0;
 	unsigned long queue_id;
 	u32 db_array[8];
+	bool found_hung_queue =false;
 	int r, i;
 
 	if (db_array_size > 8) {
@@ -232,6 +233,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 				for (i = 0; i < hung_db_num; i++) {
 					if (queue->doorbell_index == db_array[i]) {
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
+						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
 						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
@@ -241,6 +243,11 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 		}
 	}
 
+	if (found_hung_queue) {
+		/* Resume scheduling after hang recovery */
+		r = amdgpu_mes_resume(adev);
+	}
+
 	return r;
 }
 
-- 
2.49.0

