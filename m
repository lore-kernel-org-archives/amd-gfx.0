Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22E110F2DF;
	Mon, 29 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdnFXXp7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3E110F2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2VIePgibKlkyi9PDemfSOknaRvtvjJ+plNSW1yJ0Qzza0yliRiiPgbGvjM+wL1nIeIcnMgUz/EfeN/qIjEY/6QOeQaO46ZKLfQqz9ZQvxQ/KuGVjVBMWm/VS/qb0c2ERWA3+Tgs3AGsC1GqCpBJRtz0KaoOAQaGtFWmc4/+9OgLeeRfJair66iyc7dwW/5bmZxV3Dh/7kmby9JC+cVwUdxUAti/M6asLSQEI812hRdOF9Y48Iazs93Aq69eaaq8oQ0M30EuOsEL9yRbALgiiLoqxa/KMxHQmpw/hTvOMAh1D5ljsbqLdbC1eaMAs/aABEQJnMjH3lQquwcmdM4LwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LfsBG9UpoXp629nXQcl8Rn3fd+V1xgmrLbl3D9SSFU=;
 b=ORVESWZbdSYEkWeG9MJ1di7ujf1n67lPs2vtp9fJslbq/covoUA7rY9fZgoK6siH4Bf4q5+GrJZHHr9HRPCfG+TAp7p8qRzS9jd3D8JWXIQAb9aW2gtJMtvNwf10bqp7d/fvL57yhCBazXy22plfBveWQxdyLdZ35k0uPJtRgo1dZSwqh0ohmj4rtE8eby4WkyMbsxq64tcZrvn0+qV8XaJnfAAjfyiDEH+Yj340+YMP8LJA3Hn2UqJ90myJCDrD4isOtajHiCf7LnjYQS/sigaNDZDY9UmuWqwamJnGuQPsymV0nnRjdEKLwE3il6JvJwvh+uS2mcWfX4RP5O46/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LfsBG9UpoXp629nXQcl8Rn3fd+V1xgmrLbl3D9SSFU=;
 b=DdnFXXp7pGs/f/jtzEPv7p7AjMEqV5YUNp9GgZ+5xajO53YoBVIhi7GS99wviUi+IlwcJxW2kyejHFAHCYWCWcC1KFAb/XIDW1RGQ0YLiYDyaCauFP9t2iXjj4nFD3rMbwGAgawUW0Cat5N0Xa/zAmZDoKbuF76l5vNOWBrtkHY=
Received: from PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::15)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 13:38:40 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::83) by PH7P221CA0019.outlook.office365.com
 (2603:10b6:510:32a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 13:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 13:38:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 08:38:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] Revert "drm/amd/pm: fixes a random hang in S4 for SMU
 v13.0.4/11"
Date: Mon, 29 Apr 2024 09:38:14 -0400
Message-ID: <20240429133814.3427671-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 589942ee-2932-44fa-534e-08dc6851aaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LV1MOM3gj79I1VeUcV+RhXRZurx4ksinsrc/OzTw9CdCjWJg3+tXYHwLp30N?=
 =?us-ascii?Q?LdcLOchgCESEFu/DcfzTtVtp3kGTUyKVaoITvBMEAj4P8FIuaFLfndBWpzRf?=
 =?us-ascii?Q?08O4d3szOw4spexWX9xf2tAQepepcdvaLIzHGgU5r5v3lLQvFk0aQTyi/S3k?=
 =?us-ascii?Q?BOmF0SDNmv3PGW6AaGxkTvPJd2KWDet/LlTKaKgRYLNA7G4z2fF+p7MJH85t?=
 =?us-ascii?Q?JygcX9ve+8xdBUpKQ3SmFjar//60I7mp+sUs21gg/N2XOc329t+mSXZX1BNd?=
 =?us-ascii?Q?dIZyziRpdlarXsEHFG7zVh3gz+CZg3E8PRVa/F8Y+EYNxVcCZ8OBsyY9eDDL?=
 =?us-ascii?Q?WN8xDw4ZFqHuIudKzS79mcKRKMpJTW59YyNZ9fVAhrJdq5W3tnTosouUvAfF?=
 =?us-ascii?Q?1nPwcXwNQspx2RoeOO9Q9b+KylYVblXByPUwWr5MXxnWrYnd4NxYUJIwHdif?=
 =?us-ascii?Q?Il8LX2TYWUL2WsXu1HVAPoqrpjOGs6xVx6Zrvk8/ZUslQ68leMBKYi5Z9bbc?=
 =?us-ascii?Q?sDH9yrO0pLXFpKW26Q+WxwNVRu1Pp4mIf9Dk+bTIWL1VyX3ETs7DZP3hloNq?=
 =?us-ascii?Q?9GeFevU/Qv061nmSj6FeNMZzXxfj7GbF1F0m2ZxCdTUFTpCXEcJZWlzLPEue?=
 =?us-ascii?Q?I7+XAeaacEKF8uVVw91uzv/CeV/ICloDHoZIQEbks1wUaeVZHdvs1XIpaWmv?=
 =?us-ascii?Q?EK/XI3MjiZzhpEAVNnvUwWYUO4fPiM+WhTDY0OLvdpOrtsINb1H3D0qL2vB4?=
 =?us-ascii?Q?svsMVC+HeAcEME/SZmt/qh8S9EGpcu/e0DwtbI9fYmxIolofIvs7/6mjTOf5?=
 =?us-ascii?Q?4XIXZziXYpsWDwElTLv407twjJszRkEqm/zgmKdRQXrl4K8cVPvqngZXLu1J?=
 =?us-ascii?Q?0+I/ckSYoPvq/+q5vK/TtICaYber7XnK5KUzxtLCiWS7rRY83LoNqvxYP0ng?=
 =?us-ascii?Q?3t+VTiLtYS/J3sTqS/Yf7C5Ka0mDgkUxOH4ZdKVeIzlncZf0u+thYGSTbALn?=
 =?us-ascii?Q?06Ym0nAchdORkYziHgk8QW04zSAQdquEyljZiKV7JloivrOvOtoh8uq11fUm?=
 =?us-ascii?Q?MCRncyXnvhngXlnR18DGuaFEEbQKRPNQVRuoYsINO7wz5dRYe/UXA0TPZCTy?=
 =?us-ascii?Q?OCXxpSUmLeU0nQZTtxRvocGpa0OE0nR+PtPvFo7JMKklQBjN1nFTy+TEP0Ch?=
 =?us-ascii?Q?6Ltmk8duZj/SjFnYXltQ4DsfGbM2M3Jjcvc3LA0fGO39BHxiaNVNIhaH8nYP?=
 =?us-ascii?Q?WlW+CGdsxQpPZ7I42J73VsBAWYoxFKzf87XnwjO4RiyxQxR9fXTn+GYLHJiq?=
 =?us-ascii?Q?Buaqxsf83TPFQP+0GfA7/EEf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:38:34.7928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589942ee-2932-44fa-534e-08dc6851aaec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

This reverts commit 31729e8c21ecfd671458e02b6511eb68c2225113.

This causes problems with reboots/shutdowns for some users.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3351
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 88f1a0d878f33..e8119918ef6b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,18 +226,8 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix) {
-		/* Adds a GFX reset as workaround just before sending the
-		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
-		 * an invalid state.
-		 */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-						      SMU_RESET_MODE_2, NULL);
-		if (ret)
-			return ret;
-
+	if (!en && !adev->in_s0ix)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
-	}
 
 	return ret;
 }
-- 
2.44.0

